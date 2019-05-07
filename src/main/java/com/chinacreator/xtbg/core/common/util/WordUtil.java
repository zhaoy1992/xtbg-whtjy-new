package com.chinacreator.xtbg.core.common.util;


import java.io.File;
import java.net.ConnectException;
import java.util.Map;

import org.apache.log4j.Logger;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
/**
 * 为利用软件[openoffice]处理word转pdf,需要利用组件[jodconverter-2.2.2.zip]
 * 组件[jodconverter-2.2.2.zip]中的11个jar需要加入项目,9个是新的，2个已经存在.

 1:commons-cli-1.2.jar  要
 2:commons-io-1.4.jar   不要   系统有commons-io-2.2.jar
 3:jodconverter-2.2.2.jar 要
 4:jodconverter-cli-2.2.2.jar 要
 5:juh-3.0.1.jar 要
 6:jurt-3.0.1.jar 要
 7:ridl-3.0.1.jar 要
 8:slf4j-jdk14-1.4.3.jar 要
 9:slf4j-api-1.4.3.jar 要
 10:unoil-2.3.0.jar 要
 11:xstream-1.3.1.jar     不要   系统有 xstream-1.4.5.jar
 */
/**
 * 
 * word后台处理
 *<p>Title:WordUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-12-31
 */
public class WordUtil implements Runnable{
	/**
	 * 日志处理
	 */
	private static final Logger LOG = Logger.getLogger(WordUtil.class);
	/**
	 * 写word的锁
	 */
	private static String LOCK_WRITE_WORD="lockA";
	/**
	 * 删除痕迹的锁
	 */
	private static String LOCK_DELETE_HJ = "lockB";
	/**
	 * 转PDF的锁
	 */
	private static String LOCK_WORD_TO_PDF = "lockC";
	/**
	 * 操作:在流程环节处理最后环节,将word转换为PDF
	 */
	public static final String OPERATE_TYPE_WORD_TO_PDF = "1";
	/**
	 * 操作:在手机端处理流程的时候 可能需要 将 意见 签字信息 注入到word文档中
	 */
	public static final String OPERATE_TYPE_WRITE_WORD = "2";
	/**
	 * 配置
	 */
	public static WordToPDFConf conf;
	
	public WordUtil(){
		if(conf==null){
			conf = (WordToPDFConf)LoadSpringContext.getApplicationContext().getBean("WordToPDFConf");
		}
		File a = new File(conf.getWordFileUrl());
		if(!a.exists()){
			a.mkdirs();
		}
		File b = new File(conf.getPdfFileUrl());
		if(!b.exists()){
			b.mkdirs();
		}
	}
	
	private String operateType;
	private boolean needCleanHJ;
	private File wordFile;
	private File pdfFile;
	/**
	 * 转PDF
	 *<b>Summary: </b>
	 * wordToPdf(转PDF)
	 * @param insId 流程实例ID
	 * @param wordContentId 流程word内容ID
	 */
	public void wordToPdf(String insId,String wordContentId,boolean needCleanHJ){
		
		//1设置操作类型
		this.operateType = OPERATE_TYPE_WORD_TO_PDF;
		this.needCleanHJ = needCleanHJ;
		//2生成word文件
		String wordFilePath = conf.getWordFileUrl();
		FileUtil.tableTodisk(wordFilePath, wordContentId, "docment",insId);
		File tmp = new File(wordFilePath+insId+".doc");
		if(tmp.exists()){
			this.wordFile = tmp;
			this.pdfFile = new File(conf.getPdfFileUrl()+insId+".pdf");
		}
		new Thread(this).start();
	}
	
	@Override
	public void run() {
		if(OPERATE_TYPE_WORD_TO_PDF.equals(this.operateType)){
			if(this.isWindowsOS()
					&&this.needCleanHJ){
				boolean flag = WordUtil.deleteHJ(this.wordFile);
				if(flag){
					WordUtil.wordToPdf(conf.getOpenOfficePort(),this.wordFile,this.pdfFile);
				}
			}else{
				LOG.error("服务器非windows环境,或客户端非手机 则不能清理痕迹");
				WordUtil.wordToPdf(conf.getOpenOfficePort(),this.wordFile,this.pdfFile);
			}
		}
	}
	/**
	 * 警告:若在同一台电脑上启动应用，和通过浏览器处理流程，会出现问题，
	 * 因为  前端 iweboffice 使用的word 与 后台 jacob会相互冲突
	 *<b>Summary: </b>
	 * deleteHJ(清理痕迹)
	 */
	public static boolean deleteHJ(File file){
		synchronized (LOCK_DELETE_HJ) {
			ActiveXComponent word = null;
			Dispatch wordfile = null;
			boolean flag = false;
			String macroname = "deleteHJ1";
			try{
				ComThread.InitSTA();
				//1
				word = new ActiveXComponent("Word.Application");
				//2
				//是否进行转换 ConfirmConversions:new Variant(true)
				//是否只读  :new Variant(false)
				Dispatch dispatchTarget = word.getProperty("Documents").toDispatch();
				String name = "Open";
				int wFlags = Dispatch.Method;
				Object[] oArg = new Object[]{file.getPath(),new Variant(false),new Variant(false)};
				int[] uArgErr = new int[1];
				wordfile = Dispatch.invoke(dispatchTarget, name, wFlags, oArg, uArgErr).toDispatch();
				
				//3
				Dispatch.call(word, "Run", new Variant(macroname));
			    flag = true;
			    LOG.error("清理痕迹结束"+file.getPath());
			}catch(Exception e){
				LOG.error("清理痕迹出现异常"+file.getPath(),e);
				LOG.error("警告:若在同一台电脑上启动应用，和通过浏览器处理流程，会出现问题");
				LOG.error("因为  前端 iweboffice 使用的word 与 后台 jacob会相互冲突");
			}catch(Error e){
				LOG.error("清理痕迹出现错误"+file.getPath(),e);
			}finally{
				if(wordfile!=null){
					if(flag){
						Dispatch.call(wordfile, "Close", new Variant(-1));//0不保存修改 -1 保存修改 -2 提示是否保存修改  
					}else{
						Dispatch.call(wordfile, "Close", new Variant(0));
					}
				}
				if(word!=null){
					Dispatch.call(word, "Quit");//关闭进程winword.exe
				}
				ComThread.Release();
			}
			//个人感觉:程序调用 释放word资源代码,到真正释放资源 会有时差
			try {
				Thread.sleep(conf.getAfterDeleteHJCleanResTime());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * wordToPdf(word转PDF)
	 * @param openOffilePort
	 * @param wordFile
	 * @param pdfFile
	 */
	public static void wordToPdf(int openOffilePort,File wordFile,File pdfFile){
		synchronized (LOCK_WORD_TO_PDF) {
			OpenOfficeConnection conn = null;
			try {
				//1
				conn = new SocketOpenOfficeConnection(openOffilePort);
				conn.connect();
				//2
				DocumentConverter converter = new OpenOfficeDocumentConverter(conn);
				converter.convert(wordFile, pdfFile);
				LOG.error("PDF转换 结束:"+pdfFile.getPath());
			} catch (ConnectException cex) {
				LOG.error("错误:openoffice软件服务没有启动,或者服务器上未安装openoffice,请参考\"openoffice-wordtopdf说明.doc\"操作", cex);
				LOG.error("开启服务命令:\r\n cd %openoffice_home%\\program\r\nsoffice -headless -accept=\"socket,host=127.0.0.1,port="+openOffilePort+";urp;\" -nofirststartwizard");
				LOG.error("相关文档:java后台word转pdf的功能开发备忘录、升级说明、使用说明_20141020.doc");
			} catch (Exception e) {
				LOG.error("相关文档:java后台word转pdf的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
			} catch (Error e) {
				LOG.error("相关文档:java后台word转pdf的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
			}finally {
				if (conn != null) {
					conn.disconnect();
				}
			}
		}
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * writeWordFile(向word中写意见和签字)
	 * @param writeMap 写的内容
	 * @param userName 修改者名字
	 * @param targetFile 目标word文件
	 * @return
	 */
	public static boolean writeWordFile(Map<String,String> writeMap,String userName,File targetFile){
		synchronized (LOCK_WRITE_WORD) {
			boolean flag = false;
			ActiveXComponent word = null;
			Dispatch wordfile = null;
			if(targetFile!=null){
				try{
					ComThread.InitSTA();
					//1获得worfFile对象
					word = new ActiveXComponent("Word.Application");
					if(userName!=null){
						word.setProperty("UserName", userName);
					}
					Dispatch dispatchTarget = word.getProperty("Documents").toDispatch();
					String name = "Open";
					int wFlags = Dispatch.Method;
					//是否进行转换 ConfirmConversions : new Variant(true)
					//是否只读  :new Variant(false)
					Object[] oArg = new Object[]{targetFile.getPath(),new Variant(false),new Variant(false)};
					int[] uArgErr = new int[1];
					wordfile = Dispatch.invoke(dispatchTarget, name, wFlags, oArg, uArgErr).toDispatch();
					//2获得选择器对象
					Dispatch vSelection = word.getProperty("Selection").toDispatch();
					//3获得表对象
					Dispatch tables = Dispatch.get(wordfile, "tables").toDispatch();
					//3
					for (String loc : writeMap.keySet()) {
						String[] locs = loc.split(",");
						int a = Integer.parseInt(locs[0]);
						int b = Integer.parseInt(locs[1]);
						int c = Integer.parseInt(locs[2]);
						try{
							//4获得cell
							Dispatch table = Dispatch.call(tables, "Item", new Variant(a)).toDispatch();
							Dispatch cell = Dispatch.call(table, "Cell", new Variant(b),new Variant(c)).toDispatch();
							//5
							Dispatch range=Dispatch.get(cell,"Range").toDispatch();
							String data=Dispatch.get(range,"Text").getString();
							if(data!=null&&data.length()>2){
								//6选中cell,在cell中添加新段落,并添加数据
								Dispatch.call(cell, "Select");
								Dispatch.call(vSelection, "EndKey", "5");
								Dispatch.call(vSelection, "TypeParagraph");
						        Dispatch.put(vSelection, "Text", writeMap.get(loc));
							}else{
								Dispatch.call(cell, "Select");
						        Dispatch.put(vSelection, "Text", writeMap.get(loc));
							}
						}catch(Exception e){
							LOG.error("给文档添加数据失败(file:"+targetFile.getPath()+")(value:"+writeMap.get(loc)+")(loc:"+loc+")",e);
						}
					}
					flag = true;
				}catch(Error e){
					if("java.lang.NoClassDefFoundError".equals(e.getClass().getName())){
						if("Could not initialize class com.jacob.activeX.ActiveXComponent".equals(e.getMessage())){
							LOG.error("word文档中插入意见失败:请将jacob-1.14.3-x86.dll文件放入java.library.path[url=\""+System.getProperty("java.home")+"\\bin\\\"]后重启web服务器");
						}else{
							LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
						}
					}else{
						LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
					}
				}catch(Exception e){
					LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
				}finally{
					if(wordfile!=null){
						if(flag){
							Dispatch.call(wordfile, "Close", new Variant(-1));//0不保存修改 -1 保存修改 -2 提示是否保存修改  
						}else{
							Dispatch.call(wordfile, "Close", new Variant(0));
						}
					}
					if(word!=null){
						Dispatch.call(word, "Quit");//关闭进程winword.exe
					}
					ComThread.Release();
				}
			}
			return flag;
		}
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * writeWordFileByShuQian(下一版本 需要使用的)
	 * @param writeMap
	 * @param userName
	 * @param targetFile
	 */
	private void writeWordFileByShuQian(Map<String,String> writeMap,String userName,File targetFile){
		boolean flag = false;
		ActiveXComponent word = null;
		Dispatch wordfile = null;
		if(targetFile!=null){
			try{
				//1获得worfFile对象
				word = new ActiveXComponent("Word.Application");
				if(userName!=null){
					word.setProperty("UserName", userName);
				}
				Dispatch dispatchTarget = word.getProperty("Documents").toDispatch();
				String name = "Open";
				int wFlags = Dispatch.Method;
				//是否进行转换 ConfirmConversions : new Variant(true)
				//是否只读  :new Variant(false)
				Object[] oArg = new Object[]{targetFile.getPath(),new Variant(false),new Variant(false)};
				int[] uArgErr = new int[1];
				wordfile = Dispatch.invoke(dispatchTarget, name, wFlags, oArg, uArgErr).toDispatch();
				//2获得选择器对象
				Dispatch vSelection = word.getProperty("Selection").toDispatch();
				//3获得书签集
				Dispatch activeDocument = word.getProperty("ActiveDocument").toDispatch(); 
				Dispatch bookMarks = word.call(activeDocument, "Bookmarks").toDispatch();
				//3
				for (String loc : writeMap.keySet()) {
					boolean bookMarkExist = Dispatch.call(bookMarks, "Exists",loc).getBoolean();
					if(bookMarkExist){
						System.out.println("已找到书签 " + loc);
						Dispatch rangeItem = Dispatch.call(bookMarks, "Item", loc).toDispatch();   
						
			           // Dispatch range = Dispatch.call(rangeItem, "Range").toDispatch();    
//			            Dispatch.put(range, "Text", new Variant(writeMap.get(loc)));
			            Dispatch.call(rangeItem, "Select");
			            Dispatch.call(vSelection, "MoveLeft");
				        Dispatch.put(vSelection, "Text", "\r"+writeMap.get(loc));
					}else{
						System.out.println("未找到书签 " + loc);
					}
				}
				
				flag = true;
			}catch(Error e){
				if("java.lang.NoClassDefFoundError".equals(e.getClass().getName())){
					if("Could not initialize class com.jacob.activeX.ActiveXComponent".equals(e.getMessage())){
						LOG.error("word文档中插入意见失败:请将jacob-1.14.3-x86.dll文件放入java.library.path[url=\""+System.getProperty("java.home")+"\\bin\\\"]后重启web服务器");
					}else{
						LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
					}
				}else{
					LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
				}
			}catch(Exception e){
				LOG.error("相关文档:java后台编辑word文件表格内容的功能开发备忘录、升级说明、使用说明_20141020.doc",e);
			}finally{
				if(wordfile!=null){
					if(flag){
						Dispatch.call(wordfile, "Close", new Variant(-1));//0不保存修改 -1 保存修改 -2 提示是否保存修改  
					}else{
						Dispatch.call(wordfile, "Close", new Variant(0));
					}
				}
				if(word!=null){
					Dispatch.call(word, "Quit");//关闭进程winword.exe
					//word.invoke("Quit", new Variant[]{});  
				}
				//ComThread.Release(); java.lang.IllegalStateException: Dispatch not hooked to windows memory
			}
		}else{
			System.out.println("initWordFile 办事不利:未生成word文件");
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * isWindowsOS是否是windows系统
	 * @return
	 */
	private boolean isWindowsOS(){
		String os = System.getProperty("os.name");
		return os.toLowerCase().startsWith("win");
	}
}

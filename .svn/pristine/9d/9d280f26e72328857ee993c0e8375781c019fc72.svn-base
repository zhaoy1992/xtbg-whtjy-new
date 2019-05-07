package com.chinacreator.xtbg.core.mobile.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.common.util.WordToPDFConf;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
/**
 *  
 * 针对某一个流程文件的操作 和控制
 *<p>Title:FlowWordUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-10-14
 */
public class FlowWordUtil extends XtDbBaseDao implements WordUtil{
	
	private WordToPDFConf conf;
	public FlowWordUtil(){
		try{
			conf = (WordToPDFConf)LoadSpringContext.getApplicationContext().getBean("WordToPDFConf");
		}catch(Exception e){
			
		}
	}

	private File wordFile;
	private String updateSql;
	
	public File getWordFile() {
		return wordFile;
	}
	public void setWordFile(File wordFile) {
		this.wordFile = wordFile;
	}
	public String getUpdateSql() {
		return updateSql;
	}
	public void setUpdateSql(String updateSql) {
		this.updateSql = updateSql;
	}

	/**
	 * 流程实例ID
	 */
	private String insId;
	
	public FlowWordUtil(String insId){
		this.insId = insId;
		conf = (WordToPDFConf)LoadSpringContext.getApplicationContext().getBean("WordToPDFConf");
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     生成  wordFile
	 * @see com.chinacreator.xtbg.core.process.workflowphone.util.WordUtil#initWordFile()
	 */
	public void initWordFile(Connection conn){
		FlowUtilDaoImpl dao = new FlowUtilDaoImpl();
		Map<String,String> mess = dao.getDocmentAttachIdByInsId(this.insId,conn);
		if(mess!=null
				&&!StringUtil.nullOrBlank(mess.get("yw_id"))){
			String name = this.conf.getWordFileUrl();
			FileUtil.tableTodisk(name, mess.get("yw_id"), "docment",this.insId);
			File tmp = new File(name);
			if(tmp.exists()){
				this.wordFile = tmp;
				this.updateSql = "update oa_document_file set oa_document_file.filebody = ?,filesize=? where oa_document_file.recordid = '"+mess.get("yw_id")+"'";
			}
		}
	}

	@Override
	public boolean writeWordFile(Map<String,String> writeMap){
		boolean flag = false;
		ActiveXComponent word = null;
		if(this.wordFile!=null){
			try{
				//1获得worfFile对象
				word = new ActiveXComponent("Word.Application");
				
				Dispatch dispatchTarget = word.getProperty("Documents").toDispatch();
				String name = "Open";
				int wFlags = Dispatch.Method;
				//是否进行转换 ConfirmConversions : new Variant(true)
				//是否只读  :new Variant(false)
				Object[] oArg = new Object[]{this.wordFile.getPath(),new Variant(true),new Variant(false)};
				int[] uArgErr = new int[1];
				Dispatch wordfile = Dispatch.invoke(dispatchTarget, name, wFlags, oArg, uArgErr).toDispatch();
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
						//5获得数据
						Dispatch range=Dispatch.get(cell,"Range").toDispatch();
						String data=Dispatch.get(range,"Text").getString();
						if(data.length()>=2){
							data = data.substring(0, data.length()-2);
						}
						if(data.length()>0
							&&!data.endsWith("\r")){
							data=data+"\r";
						}
						//6选中cell,并添加数据
						Dispatch.call(cell, "Select");
				        Dispatch.put(vSelection, "Text", data+writeMap.get(loc));
					}catch(Exception e){
						continue;
					}
				}
				Dispatch.call(wordfile, "Close", new Variant(-2));
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
				if(word!=null){
					Dispatch.call(word, "Quit");//关闭进程winword.exe
					//word.invoke("Quit", new Variant[]{});  
				}
				//ComThread.Release(); java.lang.IllegalStateException: Dispatch not hooked to windows memory
			}
		}else{
			System.out.println("initWordFile 办事不利:未生成word文件");
		}
		return flag;
	}
	
	private static final Logger LOG = Logger.getLogger(FlowWordUtil.class);

	@Override
	public void readWordFileIntoDB(Connection conn) {
		if(this.updateSql!=null){
			try {
				InputStream fin = new  FileInputStream(this.wordFile);
				PreparedDBUtil pdb = new PreparedDBUtil();
				pdb.preparedUpdate(this.updateSql);
				pdb.setBinaryStream(1, fin, (int)this.wordFile.length());
				pdb.setLong(2, this.wordFile.length());
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				//this.deleteWordFile();
			}
		}
	}

	@Override
	public void deleteWordFile() {
		if(wordFile!=null){
			wordFile.delete();
		}
	}
	public void getTableName(String template_id,String busi_id){
		StringBuffer sqlStr = new StringBuffer();
		List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
		sqlStr.append("select textinput_id, ");
		sqlStr.append("       template_id, ");
		sqlStr.append("       textinput_name, ");
		sqlStr.append("       table_id, ");
		sqlStr.append("       column_id, ");
		sqlStr.append("       textinput_value_type, ");
		sqlStr.append("       textinput_value, ");
		sqlStr.append("       textinput_help, ");
		sqlStr.append("       textinput_flag, ");
		sqlStr.append("       textinput_remark, ");
		sqlStr.append("       table_cell, ");
		sqlStr.append("       DATA_COME_FROM_TABLE_ID, ");
		sqlStr.append("       DATA_COME_FROM_COLUMN_ID ");
		sqlStr.append("  from oa_word_textinput ");
		sqlStr.append(" where template_id = ? ");
		sqlStr.append(" and( textinput_value_type ='2' or textinput_value_type ='8') "); 
		try {
			listMap =queryToListMap(sqlStr.toString(), template_id);
			String column_id  ="";
			String t_id ="";
			Map<String,String> map =  new HashMap<String,String>();
			for(int i = 0 ; i < listMap.size() ; i++){
				
				 map = listMap.get(i);
				if("8".equals(map.get("textinput_value_type"))){
					t_id = map.get("column_id");
					map.remove("column_id");
					map.put("t_id", t_id);
					map.put("column_id",column_id);
				}else{
					 column_id = map.get("column_id");
				}
			}
			String recordID = getMRecordID(busi_id,map);
			//生成word出来
			FileUtil.tableTodisk("C:\\oa_core_tmp_files\\", recordID,"docment",recordID);
			//转pdf保存
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getMRecordID(String busi_id,Map<String,String> map) throws SQLException{
		String  recordID="";
		String tableName = map.get("table_id");
		String column_id =map.get("column_id");
		String t_id = map.get("t_id");
		String strsql = "select "+column_id+" from "+tableName+" where "+t_id+" =  '"+busi_id+"'";
		recordID = DaoUtil.sqlToField(strsql);
		return recordID;
	}
	
	public static void main(String[] args) {
		// 读取文件生成到服务器磁盘上
		//通过template_id 来查询出业务表的表名跟正文的字段名
		//再通过busi_id来查询出对应的正文编号
		//1、转pdf
		//2、手机端签字，调用接口pc端后台代码打开word，插入签字位置的值，并且需要更新表中的数据，
		//3、再转pdf（已办的时候需要查看）
		// 注意整个流程只存在一个pdf
		FlowWordUtil f = new FlowWordUtil();
		f.getTableName("375ac39e-d829-48a6-ab61-28303e9f880a","9e196665-2911-4cc4-b2c3-a028fdfd6b95");
		
	/*	f.setWordFile(new File("C:\\oa_core_tmp_files\\e669834b-4c25-4c48-a6ac-fc76da5419a8.doc"));
		Map<String,String> writeMap = new HashMap<String,String>();
		writeMap.put("1,4,3", "我日你大爷！！！！");
		f.writeWordFile(writeMap);*/
	}
}

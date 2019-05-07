package com.chinacreator.xtbg.core.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ConnectException;

import org.apache.log4j.Logger;

import com.artofsolving.jodconverter.DefaultDocumentFormatRegistry;
import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.DocumentFormat;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;

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
 * word转PDF工具
 * <p>Title:WordToPDFUtil.java</p>
 * <p>Description:</p>
 * <p>Copyright:Copyright (c) 2013</p>
 * <p>Company:湖南科创 </p>
 * 
 * @author tuo.zou
 * @version 1.0 2014-10-15
 */
public class WordToPDFUtil extends java.lang.Thread {
	
	private static final Logger LOG = Logger.getLogger(WordToPDFUtil.class);
	
	public WordToPDFConf conf;
	public WordToPDFUtil(){
		try{
			conf = (WordToPDFConf)LoadSpringContext.getApplicationContext().getBean("WordToPDFConf");
			File a = new File(conf.getWordFileUrl());
			if(!a.exists()){
				a.mkdirs();
			}
			File b = new File(conf.getPdfFileUrl());
			if(!b.exists()){
				b.mkdirs();
			}
		}catch(Exception e){
			
		}
		
	}
	/**
	 * 被转换的文件
	 */
	private File inputFile;
	/**
	 * 被转换的文件流
	 */
	private InputStream inputFileStream;
	/**
	 * 转换之后的文件
	 */
	private File outputFile;
	/**
	 * 操作方式:1:FileToFile,2:InputStreamToFile
	 */
	private String operateType;
	
	public InputStream getInputFileStream() {
		return inputFileStream;
	}
	public void setInputFileStream(InputStream inputFileStream) {
		this.inputFileStream = inputFileStream;
	}
	public String getOperateType() {
		return operateType;
	}
	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
	public File getInputFile() {
		return inputFile;
	}
	public void setInputFile(File inputFile) {
		this.inputFile = inputFile;
	}
	public File getOutputFile() {
		return outputFile;
	}
	public void setOutputFile(File outputFile) {
		this.outputFile = outputFile;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * docToPdf(将doc文件转换成pdf文件)
	 * @param inputFile
	 * @param outputFile
	 */
	public void docToPdf(File inputFile,File outputFile){
		this.setInputFile(inputFile);
		this.setOutputFile(outputFile);
		this.setOperateType("FileToFile");
		super.start();
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * docInputStreamToPdf(将输入流形式的doc文件转换成pdf文件)
	 * @param inputFileStream
	 * @param outputFile
	 */
	public void docInputStreamToPdf(InputStream inputFileStream,File outputFile){
		this.setInputFileStream(inputFileStream);
		this.setOutputFile(outputFile);
		this.setOperateType("InputStreamToFile");
		super.start();
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * createConnection(打开与OpenOffice软件服务的连接)
	 * @return
	 */
	private OpenOfficeConnection createConnection(){
		return new SocketOpenOfficeConnection(this.conf.getOpenOfficePort());
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getDocumentConverter(获得转换器)
	 * @param conn
	 * @return
	 * @throws ConnectException
	 */
	private DocumentConverter getDocumentConverter(OpenOfficeConnection conn) throws ConnectException{
		DocumentConverter converter = null;
		if(conn!=null){
			conn.connect();
			converter = new OpenOfficeDocumentConverter(conn);
		}
		return converter;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * closeConnection(关闭与软件服务的连接)
	 * @param conn
	 */
	private void closeConnection(OpenOfficeConnection conn){
		if (conn != null) {
			conn.disconnect();
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 run 
	 */
	public void run(){
		if("FileToFile".equals(this.getOperateType())){
			this.docToPdf();
		}else if("InputStreamToFile".equals(this.getOperateType())){
			this.docInputStreamToPdf();
		}
		
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * docToPdf(将doc文件转换成pdf文件)
	 */
	private void docToPdf(){
		OpenOfficeConnection conn = null;
		try {
			conn = this.createConnection();
			DocumentConverter converter = this.getDocumentConverter(conn);
			converter.convert(this.getInputFile(), this.getOutputFile());
		} catch (ConnectException cex) {
			LOG.error("错误:openoffice软件服务没有启动,或者服务器上未安装openoffice,请参考\"openoffice-wordtopdf说明.doc\"操作", cex);
			LOG.error("开启服务命令:\r\n cd %openoffice_home%\\program\r\nsoffice -headless -accept=\"socket,host=127.0.0.1,port="+this.conf.getOpenOfficePort()+";urp;\" -nofirststartwizard");
			
			LOG.error("相关文档:java后台word转pdf的功能开发备忘录、升级说明、使用说明_20141020.doc");
		} catch (Exception e) {
			LOG.error("相关文档:java后台word转pdf的功能开发备忘录、升级说明、使用说明_20141020.doc");
			e.printStackTrace();
		} finally {
			this.closeConnection(conn);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * docInputStreamToPdf(将输入流形式的doc文件转换成pdf文件)
	 */
	private void docInputStreamToPdf(){
		OpenOfficeConnection conn = null;
		try {
			conn = this.createConnection();
			DocumentConverter converter = this.getDocumentConverter(conn);
			DocumentFormat inFormat = this.getDocumentFormatBySuffix("doc");
			DocumentFormat outFormat = this.getDocumentFormatBySuffix("pdf");
			OutputStream ops = new FileOutputStream(this.getOutputFile());
			converter.convert(this.getInputFileStream(), inFormat, ops, outFormat);
		} catch (ConnectException cex){
			cex.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closeConnection(conn);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getDocumentFormatBySuffix(获得文档格式,代码copy [http://blog.sina.com.cn/s/blog_783eaf590100vx6o.html])
	 * @param suffix
	 * @return
	 */
	public DocumentFormat getDocumentFormatBySuffix(String suffix) {
        DocumentFormat df = null;
        if (suffix != null) {
            DefaultDocumentFormatRegistry registry = new DefaultDocumentFormatRegistry();
            df = registry.getFormatByFileExtension(suffix);
        }
        return df;
    }
	
	public void test() {
		WordToPDFConf conf = new WordToPDFConf();
		conf.setIsOpen(true);
		conf.setOpenOfficeHome("C:\\PROGRA~1\\OpenOf~1\\");
		conf.setOpenOfficePort(8100);
		
		WordToPDFUtil t1 = new WordToPDFUtil();
		t1.conf = conf;
		t1.inputFile = new File("D:\\workspace\\zjj\\creatorepp\\uploadDocument\\a9a1ccd7-ea35-4348-9f6a-5d3243f26ca9.doc");
		t1.outputFile = new File("D:\\workspace\\zjj\\creatorepp\\uploadDocument\\a9a1ccd7-ea35-4348-9f6a-5d3243f26ca9.pdf");
		t1.docToPdf();
		
//		WordToPDFUtil t2 = new WordToPDFUtil(new File(
//				"D:\\workspace\\OpenOfficeTest\\res\\档案管理bug-孙丹.doc"),
//		new File(
//				"D:\\workspace\\OpenOfficeTest\\res\\档案管理bug-孙丹.pdf"));
//
//		t2.docToPdf();
//		t1.docToPdf();
	}

	public static void main(String[] args) throws Exception {
		WordToPDFUtil p = new WordToPDFUtil();
		p.test();

	}

}

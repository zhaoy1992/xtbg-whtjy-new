package com.chinacreator.xtbg.pub.iweboffice.util;

import java.io.File;
import java.io.IOException;

import org.apache.log4j.Logger;
/**
 * 
 *<p>Title:Doc2Pdf2SwfUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-5-9
 */
public class Doc2Pdf2SwfUtil {

	private static final Logger log = Logger.getLogger(Doc2Pdf2SwfUtil.class);

	private String mFilePath;
	private String fileString;
	private File pdfFile;
	private File swfFile;
	private File docFile;
	private String pdfFilePath;//pdf的转换路径
	private String swfFilePath;//swf的转换路径
	//转换器安装路径
    private String exePath = "";
	
    /**
     * 
      * <b>Summary: </b>
      *     构造一个 Doc2Pdf2SwfUtil  
       * <b>Remarks: </b>
      *     构造类 Doc2Pdf2SwfUtil 的构造函数 Doc2Pdf2SwfUtil
      * @param mFilePath
      * @param fileString
      * @param pdfFileString
      * @param swfFileString
     */
	public Doc2Pdf2SwfUtil(String mFilePath,String fileString,String pdfFileString,String swfFileString)
	{
		ini(mFilePath,fileString,pdfFileString,swfFileString);
	}
	/*
	* 重新设置file
	* @param fileString
	*/
	public void setFile(String mFilePath,String fileString,String pdfFileString,String swfFileString)
	{
		ini(mFilePath,fileString,pdfFileString,swfFileString);
	}
	/*
	* 初始化
	* @param fileString
	*/
	private void ini(String mFilePath,String fileString,String pdfFileString,String swfFileString)
	{
		 this.mFilePath = mFilePath;
		 this.fileString = fileString;
		 pdfFilePath = pdfFileString;
		 swfFilePath = swfFileString;
		 
		 exePath = mFilePath.replace("\\", "/")+"/pdf2swf.exe";
		 docFile = new File(fileString);
		 pdfFile = new File(pdfFilePath);
//		 swfFile = new File(swfFilePath);
	}
	/*
	* 转换主方法
	*/
	public boolean conver()
	{
		if(!docFile.exists()){
			log.error("转换失败!：原word文件不存在!");
			return false;
		}
		
	  	 if(pdfFile.exists())//转换之前都清除掉原先的pdf文件
	  		pdfFile.delete();
	  	 if(swfFile.exists())//转换之前都清除掉原先的swf文件
	  		swfFile.delete();
	  	 
	  	 
	  	 boolean isConvert = false;

	  	 while(!pdfFile.exists()){
	  		 if(!isConvert){
	  			 ChangeToPDF.ConvertWordToPDF(fileString,pdfFilePath);
	  			 isConvert = true;
	  		 } 
	  	 }
	  	log.debug("转换PDF:完成!文件路径："+pdfFilePath);
	  	 
	     
	  	try {
	 		PDF2SWFUtil.pdf2swf(pdfFilePath.replace("\\", "/"),swfFilePath.substring(0, swfFilePath.lastIndexOf("\\")), exePath);
	    } catch (IOException e) {
	    	log.error("转换出错！",e);
	        return false;
	    }
	    log.debug("转换SWF:完成!文件路径："+swfFilePath);
	    return true;
	   }  

	/**
	 * 
	*<b>Summary: 将Doc转换成Pdf</b>
	* converDocToPdf(请用一句话描述这个方法的作用)
	* @return
	 */
	public boolean converDocToPdf()
	{
		if(!docFile.exists()){
			log.error("转换失败!：原word文件不存在!");
			return false;
		}
		
	  	 if(pdfFile.exists())//转换之前都清除掉原先的pdf文件
	  		pdfFile.delete();	  	 
	  	 
	  	 boolean isConvert = false;
	  	 while(!pdfFile.exists()){
	  		 if(!isConvert){
	  			 ChangeToPDF.ConvertWordToPDF(fileString,pdfFilePath);
	  			 isConvert = true;
	  		 } 
	  	 }
	  	log.error("转换PDF:完成!文件路径："+pdfFilePath);	 
	    return true;
	   }
	}


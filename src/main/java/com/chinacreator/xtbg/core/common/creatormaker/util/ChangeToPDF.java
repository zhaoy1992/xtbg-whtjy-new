package com.chinacreator.xtbg.core.common.creatormaker.util;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.goldgrid.pdfmake.KGPDFMake;
/**
 *<p>Title:ChangeToPDF.java</p>
 *<p>Description:WORD文档转PDF类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-1
 */
public class ChangeToPDF{
	
	private static final Log LOG = LogFactory.getLog(ChangeToPDF.class);
	private static String errMessage = "";  // 最后产生的错误
	
	/*加载提供文档转换的动态链接库，调用JNI接口是一点要加载此DLL链接库*/
	static{
		try{
			System.loadLibrary("KG_PDFMake_JNI");
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 注意:此方法必须是线程同步的,否则可能引起JNI调用失败
	 * 调用方案一的转换  (转换方法的类型 1:Office2007)
	 * @param  srcPath  WORD 文档在服务器上的保存路径
	 * @param  pdfPath  转换后PDF文件保存的路径
	 * @return TRUE:成功 FALSE:失败
	 * @throws Exception 
	 */
	public static synchronized boolean convertWordToPDF(String srcPath,String pdfPath) throws Exception{
		boolean mark = false;
		if(!new File(srcPath).exists()){  // 判断待转换的文件是否存在
			errMessage = srcPath+":文件不存在";
			return false;
		}
		try{
			// 调用JNI接口进行文档转换
			if(KGPDFMake.WordToPDF(srcPath, pdfPath)){
				mark = true; // 文档转换成功  
				errMessage = "";
			}else{
				mark = false;
				errMessage = KGPDFMake.GetLastError(); //获取转换文档过程中最后产生的错误 如果没有错误则返回空
				throw new Exception(errMessage);
			}
		}finally{
			KGPDFMake.FreeDll();  // 释放动态链接库的资源 转换之后必须调用 否则引起内存泄露
		}
		return mark;
	}
	
	/**
	 * 注意:此方法必须是线程同步的,否则可能引起JNI调用失败
	 * 调用方案二的转换 2:Office2007+ADOBE PDF 虚拟打印机
	 * @param srcPath WORD 文档在服务器上的保存路径
	 * @param psPath  转换过程中产生的PS文件保存的路径
	 * @param pdfPath 转换后PDF文件保存的路径
	 * @return TRUE:成功 FALSE:失败
	 * @throws Exception 
	 */
	public static synchronized boolean convertWordToPDFEx(String srcPath,String psPath,String pdfPath) throws Exception{
		boolean mark = false;
		if(!new File(srcPath).exists()){ //判断待转换的文件是否存在
			errMessage = srcPath+":文件不存在";
			return false;
		}
		try{
			// 调用JNI接口进行文档转换
			if(KGPDFMake.WordToPDFEx(srcPath, psPath, pdfPath)){
				mark = true; // 文档转换成功  
				errMessage = "";
			}else{
				mark = false;
				errMessage = KGPDFMake.GetLastError(); //获取转换文档过程中最后产生的错误 如果没有错误则返回空
				throw new Exception(errMessage);
			}
		}finally{
			KGPDFMake.FreeDll();  // 释放动态链接库的资源 转换之后必须调用 否则引起内存泄露
		}
		return mark;
	}
	
	/*获取最后产生的错误*/
	public static String getLastError(){
		return errMessage;
	}
}

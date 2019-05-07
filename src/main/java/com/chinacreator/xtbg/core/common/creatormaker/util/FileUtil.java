package com.chinacreator.xtbg.core.common.creatormaker.util;

import java.io.File;

/**
 *<p>Title:FileUtil.java</p>
 *<p>Description:文件工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-1
 */
public class FileUtil {

	/**
	*<b>Summary: </b>
	* checkFolder(检查目录是否存在,不存在则创建)
	* @param path
	* @return
	*/
	public static boolean checkFolder(String folderPath) {
		boolean success = false;
		File tempfolder = new File(folderPath);
		if (!tempfolder.exists()){
			success = tempfolder.mkdirs();
		}
		return success;
	}
	
	/**
	*<b>Summary: </b>
	* checkFile(检查文件是否存在)
	* @param filePath
	* @return
	*/
	public static boolean checkFile(String filePath){
		File tempFile = new File(filePath);
		return tempFile.exists();
	}
	
	/**
	*<b>Summary: </b>
	* deleteFiles(批量删除文件)
	* @param filePaths
	*/
	public static void deleteFiles(String ... filePaths){
		for(String filePath : filePaths){
			deleteFile(filePath);
		}
	}
	
	/**
	*<b>Summary: </b>
	* deleteFile(删除文件)
	* @param filePath
	*/
	public static void deleteFile(String filePath){
		File tempFile = new File(filePath);
		if(tempFile.exists()){
			tempFile.delete();
		}
	}
}

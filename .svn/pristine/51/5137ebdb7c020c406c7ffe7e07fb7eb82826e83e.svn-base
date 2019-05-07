package com.chinacreator.xtbg.core.archive.gwcs.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
/**
 * 
 *<p>Title:PublicMethod.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 6, 2013
 */
public class PublicMethod {
	
	
	
	public String replaceNull(Object obj){
		return obj!=null?obj.toString().trim():"";
	}
	
	
	public static File getFileFromBytes(byte[] content, String filepath) throws Exception {
		FileOutputStream fos = null;
		File zipfile = new File(filepath);
		String dir = zipfile.getParent();
		File directory = new File(dir);
		try {
			if(!directory.exists()){
				directory.mkdirs();
			}
			fos = new FileOutputStream(zipfile);
			fos.write(content);
		} catch (IOException e) {
			System.out.println("ceb文件生成失败" + e.getMessage());
			throw new Exception("byteToFile" + e.getMessage());
		} finally {
			try {
				if (fos != null) { 
					fos.flush();
					fos.close();
					fos = null;
				}
			} catch (IOException e) {
				System.out.println("dispatchservice:byteToFile流关闭失败" + e.getMessage());
			}

		}
		return new File(filepath);
	}
	/**
	 * 删除文件或文件夹
	 * @param filePath 文件或文件夹绝对路径
	 */
	public static void deleteFile(String filePath){
		File file = new File(filePath);
		if(file.exists()){
			if(file.isFile()){
				file.delete();
			}else{
				File[] files = file.listFiles();
				for(File f : files){
					if(f!=null&&f.exists()){
						deleteFile(f.getAbsolutePath());
					}
				}
				file.delete();
			}
		}
	}
	

	public static void main(String[] args) {
		
		
		
	}
}

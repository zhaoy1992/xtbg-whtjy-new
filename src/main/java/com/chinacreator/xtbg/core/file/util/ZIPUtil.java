package com.chinacreator.xtbg.core.file.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
/**
 * 将文件夹(url=filePath)打包成zip文件(url=zipFilePath)
 * copy from net
 *<p>Title:ZIPUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 15, 2013
 */
public class ZIPUtil {

	private ZIPUtil(){}
	
	private static ZIPUtil zu = null;

	public static ZIPUtil getInstance() {
		if (zu == null)
			zu = new ZIPUtil();
		return zu;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * createZipFile将文件夹(url=filePath)打包成zip文件(url=zipFilePath)
	 * @param filePath
	 * @param zipFilePath
	 */
	public boolean createZipFile(String filePath, String zipFilePath) {
		boolean flag = false;
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		try {
			fos = new FileOutputStream(zipFilePath);
			zos = new ZipOutputStream(fos);
			writeZipFile(new File(filePath), zos, "");
			flag= true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (zos != null)
					zos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (fos != null)
					fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

	private void writeZipFile(File f, ZipOutputStream zos, String hiberarchy) throws Exception{
		if (f.exists()) {
			if (f.isDirectory()) {
				hiberarchy += f.getName() + "/";
				File[] fif = f.listFiles();
				for (int i = 0; i < fif.length; i++) {
					writeZipFile(fif[i], zos, hiberarchy);
				}
			} else {
				FileInputStream fis = null;
				try {
					fis = new FileInputStream(f);
					ZipEntry ze = new ZipEntry(hiberarchy + f.getName());
					zos.putNextEntry(ze);
					byte[] b = new byte[1024];
					while (fis.read(b) != -1) {
						zos.write(b);
						b = new byte[1024];
					}
				}  finally {
					if (fis != null)
						fis.close();
				}
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* createrZipFiles(多个文件打包成zip)
	* @param zipName
	* @param zipPath
	* @param files
	* @throws Exception
	 */
	public static boolean createrZipFiles(String zipName, String zipPath, File[] files) throws Exception{
		try {
			byte[] buffer = new byte[1024];
			String strZipName = zipPath + zipName;
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
					strZipName));

			for (int i = 0; i < files.length; i++) {
				FileInputStream fis = new FileInputStream(files[i]);
				out.putNextEntry(new ZipEntry(files[i].getName()));
				int len;
				// 读入需要下载的文件的内容，打包到zip文件
				while ((len = fis.read(buffer)) > 0) {
					out.write(buffer, 0, len);
				}
				// 设置中文名称
				out.setEncoding("gbk");
				out.closeEntry();
				fis.close();
			}
			out.close();
			System.out.println("生成 zip成功");
			return true;
		} catch (Exception e) {
			System.out.println("生成 zip失败");
			e.printStackTrace();
			throw e;
		} 
	}
	
	public static void main(String[] args) {
		boolean a  = ZIPUtil.getInstance().createZipFile("D:/12","d:/test1.zip");
		System.out.println(a);
	}

}

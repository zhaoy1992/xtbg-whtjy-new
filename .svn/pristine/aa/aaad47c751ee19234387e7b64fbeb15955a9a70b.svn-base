package com.chinacreator.xtbg.core.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Map;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

/**
 * 
 *<p>Title:ZipUtil.java</p>
 *<p>Description:zip压缩解压工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 7, 2013
 */
public class ZipUtil {
	
	private static final int BUFFER = 2048;
	public static final String ENCODE_UTF8 = "utf-8";
	public static final String ENCODE_GBK = "gbk";
	private String Encode = "";
	
	public ZipUtil(){
		
	}
	public ZipUtil(String encode){
		Encode = encode;
	}
	
	public String getEncode() {
		return Encode;
	}

	public void setEncode(String encode) {
		Encode = encode;
	}

	/**
	 * 文件进行zip压缩
	 * 支持中文 
	 * @param outFilePath
	 * @param files
	 * @throws IOException
	 */
	public synchronized void zipFile(String outFilePath, String[] files) throws IOException {
		ZipOutputStream out = null;
		FileOutputStream dest = null;
		try {
			BufferedInputStream origin = null;
			dest = new FileOutputStream(outFilePath);
			out = new ZipOutputStream(new BufferedOutputStream(dest));
			byte data[] = new byte[BUFFER];
			for (int i = 0; i < files.length; i++) {
				File f = new File(files[i]);
				if (f.exists()) {
					FileInputStream fi = null;
					try {
						fi = new FileInputStream(f.getAbsolutePath());
						origin = new BufferedInputStream(fi, BUFFER);
						ZipEntry entry = new ZipEntry(f.getName());
						out.putNextEntry(entry);
						if("" != Encode)
						out.setEncoding(Encode);
						int count;
						while ((count = origin.read(data, 0, BUFFER)) != -1) {
							out.write(data, 0, count);
						}
					} finally {
						closeInputStream(origin);
						closeInputStream(fi);						
					}
				} else {
					continue;
				}
			}
			out.flush();
			dest.flush();
		} finally {
			closeOutputStream(out);
			closeOutputStream(dest);			
		}
	}
	/**
	 * 文件进行zip压缩:文件是从数据库中blob字段获取的
	 * 支持exportzip.jsp
	 * 支持中文 
	 * @param outFilePath
	 * @param files
	 * @throws IOException
	 */
	public synchronized void zipFile1(String outFilePath,Map<String,byte[]> files) throws IOException {
		ZipOutputStream out = null;
		FileOutputStream dest = null;
		try {
			BufferedInputStream origin = null;
			dest = new FileOutputStream(outFilePath);
			out = new ZipOutputStream(new BufferedOutputStream(dest));
			byte data[] = new byte[BUFFER];
			for (String fileName : files.keySet()) {
				origin = new BufferedInputStream(new ByteArrayInputStream(files.get(fileName)), BUFFER);
				ZipEntry entry = new ZipEntry(fileName);
				out.putNextEntry(entry);
				if("" != Encode)
				out.setEncoding(Encode);
				int count;
				while ((count = origin.read(data, 0, BUFFER)) != -1) {
					out.write(data, 0, count);
				}
				out.flush();
				dest.flush();
			}
		} finally {
			closeOutputStream(out);
			closeOutputStream(dest);			
		}
	}
	/**
	 * 文件进行zip压缩:文件是从数据库中blob字段获取的,输出流不是FileOutput而是  HTTP请求中response的输出流
	 * 支持exportzip.jsp
	 * 支持中文 
	 * @param outFilePath
	 * @param files
	 * @throws IOException
	 */
	public synchronized void zipFile2(OutputStream response,Map<String,byte[]> files) throws IOException {
		ZipOutputStream out = null;
		try {
			BufferedInputStream origin = null;
			out = new ZipOutputStream(response);
			byte data[] = new byte[BUFFER];
			for (String fileName : files.keySet()) {
				byte[] fileContent = files.get(fileName);
				if(fileContent==null){
					System.out.println(fileName);
					continue;
				}
				origin = new BufferedInputStream(new ByteArrayInputStream(files.get(fileName)), BUFFER);
				ZipEntry entry = new ZipEntry(fileName);
				out.putNextEntry(entry);
				if("" != Encode)
				out.setEncoding(Encode);
				int count;
				while ((count = origin.read(data, 0, BUFFER)) != -1) {
					out.write(data, 0, count);
				}
				out.flush();
			}
		} finally {
			closeOutputStream(out);		
		}
	}

	/**
	 * 解压zip文件
	 * 支持中文
	 * @param zipFilePath
	 * @param outFilePath
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public synchronized void unZipFile(String zipFilePath, String releasePath) throws IOException {
		BufferedOutputStream dest = null;
		BufferedInputStream is = null;
		ZipEntry entry = null;
		ZipFile zipFile = new ZipFile(zipFilePath);
		Enumeration<ZipEntry> e = zipFile.getEntries();
		while (e.hasMoreElements()) {
			FileOutputStream fos = null;
			try {
				entry = (ZipEntry) e.nextElement();
				is = new BufferedInputStream(zipFile.getInputStream(entry));
				int count;
				byte data[] = new byte[BUFFER];
				
				File upfile = new File(releasePath);
				if(!upfile.exists()){
					upfile.mkdirs();
				}
				
				fos = new FileOutputStream(releasePath + entry.getName());
				dest = new BufferedOutputStream(fos, BUFFER);
				while ((count = is.read(data, 0, BUFFER)) != -1) {
					dest.write(data, 0, count);
				}
				dest.flush();
				fos.flush();
			} finally {					
				closeOutputStream(dest);
				closeOutputStream(fos);
				closeInputStream(is);
			}
		}
		if(null != zipFile) {
			zipFile.close() ;
		}
	}
	
	public static void main(String[] args) {
		ZipUtil util = new ZipUtil();
		/*try {
			util.unZipFile(GwConstant.TMP_ZIP_PATH, GwConstant.TMP_ZIP_DIR);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}
	
	/**
	  * 关闭InputStream
	  * @param in
	  */
	protected void closeInputStream(InputStream in){
		if (in != null) {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
	}
	
	/**
	  * 关闭OutputStream
	  * @param out
	  */
	protected void closeOutputStream(OutputStream out){
		if (out != null) {
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
	}
}

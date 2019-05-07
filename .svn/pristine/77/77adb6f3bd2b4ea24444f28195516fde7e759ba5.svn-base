package com.chinacreator.xtbg.core.common.fancyuoload.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.UUID;

import org.apache.log4j.Logger;

/**
 * 
 *<p>Title:FileUtils.java</p>
 *<p>Description:工具类</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author steven.zhu 
 *@mail   wenghua_yan@163.com
 *@version 1.0
 *2011-7-11
 */
public class FileUtils {
	
	private static final Logger LOG = Logger.getLogger(FileUtils.class);
	/**
	 * 根据路径创建一系列的目录
	 * @param path
	 */
	public static void mkDirectory(String path) {
		File file;
		try {
			file = new File(path);
			if (!file.exists()) {
				boolean returnVal = file.mkdirs();
				if(returnVal) {
					LOG.info(path+"文件创建成功");
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			file = null;
		}
	}
	
	/**
	 * 根据 文件名到文件后缀
	 * @param fileName
	 * return  string
	 */
	public static String getFiletype(String fileName) {
		String type = "";
		if (fileName == null || fileName.equals(""))
			return type;
		int position = fileName.lastIndexOf(".");
		if (position != -1) {
			type = fileName.substring(position, fileName.length());
		}
		return type;
	}
	
	/**
	 * uuid 把文件名成唯一
	 * return  string
	 */
	public static String randomUUID() {
		return 	UUID.randomUUID().toString();
	}
	
	/**
	 * 
	 * 得到系统时间组合成时字符串         这里是测试用，最好从数据库得到时间
	 * return  string
	 */
	public static String getSysTime() {
		String str = "";
		try {
			Date d = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			df.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai")); // 设置时区
			str = df.format(d);
			return str;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		}

	}
	
	/**
	 * 
	 * 字符到日期
	 * return  date
	 */
	public static Date stringToStime(String str) {
		Date d;
		try {
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			d = df.parse(str);
			return d;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		}
	}
	
	/**
	 * 
	 * 格式化日期字符串
	 * return  date
	 */
	public static String stringToString(String str) {
		String newdate;
		Date d;
		try {
			SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");
			SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			d = df1.parse(str);
			newdate = df2.format(d);
			return newdate;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		}
	}
	
	/**
	 * 把文件读取为byte[]
	 * 
	 * @param FilePath
	 * @return
	 * @throws Exception
	 */
	public synchronized static byte[] getFileBytes(String filePath) throws IOException {
		byte[] buffer = null;
		FileInputStream fin = null;
		try {
			File file = new File(filePath);
			fin = new FileInputStream(file);
			buffer = new byte[fin.available()];
			fin.read(buffer);
		} finally {
			try {
				if (fin != null) {
					fin.close();
					fin = null;
				}
			} catch (IOException e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return buffer;
	}
	
	/**
	 * 把文件读取为byte[]
	 * 
	 * @param FilePath
	 * @return
	 * @throws Exception
	 */
	public synchronized static byte[] getFileBytes(InputStream fin) throws IOException {
		byte[] buffer = null;
		try {
			buffer = new byte[fin.available()];
			fin.read(buffer);
		} finally {
			try {
				if (fin != null) {
					fin.close();
					fin = null;
				}
			} catch (IOException e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return buffer;
	}
}

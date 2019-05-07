package com.chinacreator.xtbg.core.common.iweboffice.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * 
 *<p>
 * Title:PDF2SWFUtil.java
 * </p>
 *<p>
 * Description:
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-9
 */
public class PDF2SWFUtil {
	/**
	 * 利用SWFTools工具将pdf转换成swf，转换完后的swf文件与pdf同名
	 * 
	 * @author iori
	 * @param fileDir
	 *            PDF文件存放路径（包括文件名）
	 * @param tofilePath
	 *            指定swf所放置的路径
	 * @param exePath
	 *            转换器安装路径
	 * @throws IOException
	 */
	public static synchronized void pdf2swf(String fileDir, String tofilePath,
			String exePath) throws IOException {
		// 文件路径
		String filePath = fileDir.substring(0, fileDir.lastIndexOf("/"));
		// 文件名，不带后缀
		String fileName = fileDir.substring((filePath.length() + 1), fileDir
				.lastIndexOf("."));
		Process pro = null;
		if (isWindowsSystem()) {
			// 如果是windows系统
			// 命令行命令 此处必须加 “-T 9” 参数，设置输出版本为flash9，解决PDF文件只有一页，生成的swf不能播放的问题。
			String cmd = exePath + " \"" + fileDir + "\" -o \"" + tofilePath
					+ "/" + fileName + ".swf\" -T 9";
			// Runtime执行后返回创建的进程对象
			pro = Runtime.getRuntime().exec(cmd);
		} else {
			// 如果是linux系统,路径不能有空格，而且一定不能用双引号，否则无法创建进程
			String[] cmd = new String[3];
			cmd[0] = exePath;
			cmd[1] = fileDir;
			cmd[2] = tofilePath + "/" + fileName + ".swf";
			// Runtime执行后返回创建的进程对象
			pro = Runtime.getRuntime().exec(cmd);
		}
		// 非要读取一遍cmd的输出，要不不会flush生成文件（多线程）
		new DoOutput(pro.getInputStream()).start();
		new DoOutput(pro.getErrorStream()).start();
		try {
			// 调用waitFor方法，是为了阻塞当前进程，直到cmd执行完
			pro.waitFor();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 判断是否是windows操作系统
	 * 
	 * @author iori
	 * @return
	 */
	private static boolean isWindowsSystem() {
		String p = System.getProperty("os.name");
		return p.toLowerCase().indexOf("windows") >= 0 ? true : false;
	}

	/**
	 * 多线程内部类 读取转换时cmd进程的标准输出流和错误输出流，这样做是因为如果不读取流，进程将死锁
	 * 
	 * @author iori
	 */
	private static class DoOutput extends Thread {
		public InputStream is;

		// 构造方法
		public DoOutput(InputStream is) {
			this.is = is;
		}

		public void run() {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					this.is));
			String str = null;
			try {
				// 这里并没有对流的内容进行处理，只是读了一遍
				while ((str = br.readLine()) != null)
					;
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (br != null) {
					try {
						br.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
}
package com.chinacreator.xtbg.pub.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URL;

public class FileUtil {

	public static File getClassFile(Class<?> clazz) {
		URL path = clazz.getResource(clazz.getName().substring(
				clazz.getName().lastIndexOf(".") + 1)
				+ ".class");
		if (path == null) {
			String name = clazz.getName().replaceAll("[.]", "/");
			path = clazz.getResource("/" + name + ".class");
		}
		return new File(path.getFile());
	}
	
	public static File getClassPathFile(Class<?> clazz) {
		File file = getClassFile(clazz);
		for (int i = 0, count = clazz.getName().split("[.]").length; i < count; i++)
			file = file.getParentFile();
		if (file.getName().toUpperCase().endsWith(".JAR!")) {
			file = file.getParentFile();
		}
		return file;
	}
	
	public static String getClassPath(Class<?> clazz) throws UnsupportedEncodingException {
		return java.net.URLDecoder.decode(getClassPathFile(clazz)
				.getAbsolutePath(), "UTF-8");

	}
	
	
}

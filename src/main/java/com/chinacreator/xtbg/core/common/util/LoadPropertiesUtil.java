package com.chinacreator.xtbg.core.common.util;

import java.io.InputStream;
import java.util.Properties;

/**
 *<p>Title:LoadPropertiesUtil.java</p>
 *<p>Description:读取Properties</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 刘小龙
 *@version 1.0
 *2011-3-21
 */
public class LoadPropertiesUtil {
	
	private static LoadPropertiesUtil loadPropertiesUtil = null;
		
		private LoadPropertiesUtil () {
			
		}
		/**
		 * 单例方法
		 * @return
		 */
		public static LoadPropertiesUtil getInstance() {
			if (loadPropertiesUtil == null) {
				synchronized(LoadPropertiesUtil.class) {
					loadPropertiesUtil = new LoadPropertiesUtil();
				}
			}
			return loadPropertiesUtil;
		}
		
		
		/**
		 * 获得deploymentConfig.proper	ties 配置的区域代码
		 * @param fileName
		 * @param key
		 * @return
		 */
		public String[] getPropertiesAreaCode(String fileName,String key)throws Exception{
			String[] areaCodes=null;
			String targetName=getPropertiesValue(fileName, key);
			areaCodes=targetName.split(",");
			return areaCodes;
			
		}
		/**
		 * 
		 * @param fileName:读取的properties的文件名
		 * @param key ：properties属性的key值
		 * @return
		 */
		public String getPropertiesValue(String fileName,String key)throws Exception{
			String targetName="";
			Properties pts=new Properties();
			InputStream is=LoadPropertiesUtil.class.getClassLoader().getResourceAsStream(fileName);
			pts.load(is);
			targetName=pts.getProperty(key);
			return targetName;
		}
		
	}

package com.chinacreator.business.common.tools;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Map;


import org.apache.log4j.Logger;


import com.chinacreator.business.common.publuc.Dictionary;


/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:初始化系统管理类
 * </p>
 * <p>
 * Company:湖南
 * </p>
 * @author 沈联成
 * @version 1.0 2012-11-20
 */
public class InitSystemManage {
	private static final Logger logger = Logger.getLogger(InitSystemManage.class);
	
	private static InitSystemManage uniqueInstance = null;
    //单例实现
	private InitSystemManage() {
		logger.debug("init InitSystemManage .....");
	}

	public static InitSystemManage getInstance() {
		if (uniqueInstance == null) {
			uniqueInstance = new InitSystemManage();
		}
		return uniqueInstance;
	}
	
	// 加载System
	public void initSystemProperties() {
		String path = 
				ReaderConfigFile.getInstance().getConfigPath()+ "config/";
		ArrayList<String> list = 
				ReaderConfigFile.getInstance().seekAllFilePath(path, ".+.properties",null);
		Map<String, String> map =
				(Map<String, String>) CacheCommonManage.getInstance().getCacheMap(Dictionary.SYSTEM_DIC);

		for (String s : list) {
			ReaderConfigFile.getInstance().readerPropertiesKeyAddExtraName(s, map);
		}
		if ("".equals(map.get(Dictionary.CONFIG_PATH))) {
			map.put(Dictionary.CONFIG_PATH, path);
		}
	}
	 
	  //加载Action配置
	 public void initActonXml(){
		 String path = 
				 CacheCommonManage.getInstance().getSystemParam(Dictionary.CONFIG_PATH);
		 String regex = 
				 CacheCommonManage.getInstance().getSystemParam(Dictionary.ACTION_REGEX);
		 ArrayList<String> list =
				 ReaderConfigFile.getInstance().seekAllFilePath(path, regex,null);
		 Map<String, Object> map =
					(Map<String, Object>) CacheCommonManage.getInstance().getCacheMap(Dictionary.ACTION_MAP_KEY);
		 for (String s : list) {
				try {
					ReaderConfigFile.getInstance().readerActionConfig(s, map);
				} catch (Exception e) {
					logger.error(e);
				}
		  }
	 }
	 
	 public void initFristXML(){
		 String path = 
				 CacheCommonManage.getInstance().getSystemParam(Dictionary.CONFIG_PATH);
		 String regex = 
				 CacheCommonManageProxy.getSystemParam("leftModule_CONFIG_NAME");
		 ArrayList<String> list =
				 ReaderConfigFile.getInstance().seekAllFilePath(path, regex,null);
		 if(null == list || list.isEmpty()) return;
		 try {
			Object obj = ReaderConfigFile.getInstance().readerFristConfig(list.get(0));
			CacheCommonManage.getInstance().putFrist(obj);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	 }
	 
	 public void initAuthXML(){
		 String path = 
				 CacheCommonManage.getInstance().getSystemParam(Dictionary.CONFIG_PATH);
		 String regex = 
				 CacheCommonManage.getInstance().getSystemParam("AUTH_CONFIG_NAME");
		 ArrayList<String> list =
				 ReaderConfigFile.getInstance().seekAllFilePath(path, regex,null);
		 if(null == list || list.isEmpty() || null == regex || "".equals(regex)) return;
		 try {
			Object obj = ReaderConfigFile.getInstance().readerAuthConfig(list.get(0));
			CacheCommonManage.getInstance().putAuth(obj);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	 }
}

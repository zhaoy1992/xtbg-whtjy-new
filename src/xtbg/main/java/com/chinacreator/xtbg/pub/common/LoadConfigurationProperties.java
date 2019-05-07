package com.chinacreator.xtbg.pub.common;

import java.util.List;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2008</p>
 *<p>Company:湖南科创</p>
 *@author creator
 *@version 3.0
 *@date 2009-1-7
 */
public abstract class LoadConfigurationProperties {
	
	private static final String basePath = "config/";
	
	private static final String postfix = ".properties";
	
	private static String filePath = "";
	
	private static String encoding = "utf-8";
	
	private static final char delimiter = ';';
	
	private static PropertiesConfiguration config = null;
	
	protected LoadConfigurationProperties(){
		
	}
	
	/**
	 * 设置properties文件所在路径
	 * 如果在config文件夹下只需要传入配置文件的名称 不需要后缀名称
	 * 如果为自定义路径,请输入完整路径
	 * @param propertiesName
	 */
	protected static void setPath(String propertiesName){
		if((propertiesName.indexOf("/") != -1) || (propertiesName.indexOf(postfix) != -1)){
			filePath = propertiesName;
		}else{
			filePath = basePath+propertiesName+postfix;
		}		
	}
	protected static void setEncoding(String enCoding){
		encoding = enCoding;
	}
	
	/**
	 * 加载实例
	 * @return
	 * @throws ConfigurationException
	 * 
	 */
	protected synchronized static PropertiesConfiguration getInstance() throws ConfigurationException{
		if (config == null) {
			config = new PropertiesConfiguration();
			config.setFileName(filePath);
			config.setEncoding(encoding);
			config.setListDelimiter(delimiter);
			config.load();
		} else {
			if(!(filePath).equals(config.getFileName())){
				config = new PropertiesConfiguration();
				config.setFileName(filePath);
				config.setEncoding(encoding);
				config.setListDelimiter(delimiter);
				config.load();
			}
		}
		return config;
	}
	
	/**
	 * 获取properties中属性值 
	 * @param propertiesName
	 * @param key
	 * @return string
	 * @throws ConfigurationException
	 */
	public static String getPropertiesString(String propertiesName, String key) throws ConfigurationException{
		setPath(propertiesName);	
		config = LoadConfigurationProperties.getInstance();
		return config.getString(key);
	}
	
	/**
	 * 获取properties中属性值
	 * @param propertiesName
	 * @param key
	 * @return String[]
	 * @throws ConfigurationException
	 */
	public static String[] getPropertiesStringArray(String propertiesName, String key) throws ConfigurationException{
		setPath(propertiesName);
		config = LoadConfigurationProperties.getInstance();
		return config.getStringArray(key);
	}
	
	/**
	 * 获取properties中属性值
	 * @param propertiesName
	 * @param key
	 * @return list
	 * @throws ConfigurationException
	 */
	@SuppressWarnings("unchecked")
	public static List<String> getPropertiesStringList(String propertiesName, String key) throws ConfigurationException{
		setPath(propertiesName);
		config = LoadConfigurationProperties.getInstance();
		return config.getList(key);
	}
	
	/**
	 * 资源清理
	 *
	 */
	public static void clear(){
		if(config != null){
			config.clear();
		}
	}
	
	public static void main(String...strings) throws ConfigurationException{

	}
}

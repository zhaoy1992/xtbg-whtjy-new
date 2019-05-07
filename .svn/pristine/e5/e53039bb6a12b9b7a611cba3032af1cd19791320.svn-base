package com.chinacreator.xtbg.pub.common;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

import javax.xml.parsers.*;

import org.w3c.dom.*;
import org.xml.sax.SAXException;
import com.chinacreator.xtbg.pub.util.FileUtil;
import com.chinacreator.xtbg.pub.util.PinyinUtil;



/**
 *<p>Title:DaoImplClassUtil.java</p>
 *<p>Description:将Dao实例类加入内在中</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2011-12-26
 */
public class ReadDaoImplClass extends LoadConfigurationProperties{

	protected static final Logger log = Logger.getLogger(ReadDaoImplClass.class.getName());
		
	private static final String PATHNAME = "xtbgDatebase";//配置文件名称
	
	private static List<DaoImplClassBean> daoImplClassBeanlist = new ArrayList<DaoImplClassBean>();
	
	/**
	 * @Description  将Dao实现类对象放入内在中
	 * @param 
	 * @return  
	 * @exception Exception
	 */
	public static void init() {
		try {
			log.info("Dao实现类加载中...");
			getDaoImplClass();
		}catch(Exception e) {
			log.error(e);
		}
	}
	
	/**
	 * @Description  从类存只获得DaoImpl类集合
	 * @param 
	 * @return  
	 * @exception Exception
	 */
	public static  List<DaoImplClassBean> getDaoImplList() {
		
		return daoImplClassBeanlist;
		
	}
	/**
	 * @Description  获得Dao实现类的集合
	 * @param 无
	 * @return  List
	 * @exception ParserConfigurationException, SAXException, IOException, ConfigurationException
	 */
	private static List<DaoImplClassBean> getDaoImplClass() throws ParserConfigurationException, SAXException, IOException, ConfigurationException {
		File file = new File(FileUtil.getClassPath(ReadDaoImplClass.class) + getConfigPath());
		
		if (!file.exists()){ //判断文件是否存在
			throw new FileNotFoundException("file not exist");
		}
		DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance(); //得到DOM解析器的工厂实例
		DocumentBuilder builder = dFactory.newDocumentBuilder();//从DOM工厂获得DOM解析器
		Document doc;							
		doc = builder.parse(file);//解析XML文档的输入流，得到一个Document

		NodeList classNames = doc.getElementsByTagName("className");
		for(int i = 0; i < classNames.getLength(); i++) {
			DaoImplClassBean daoImplClassBean = new DaoImplClassBean();
			Node className = classNames.item(i);
			if(className.getAttributes().getNamedItem("id") != null) {
				daoImplClassBean.setId(className.getAttributes().getNamedItem("id").getNodeValue());
			}
			daoImplClassBean.setClassName(className.getFirstChild().getNodeValue());
			daoImplClassBeanlist.add(daoImplClassBean);
		}
		return daoImplClassBeanlist;
	}
	
	/**
	 * @Description  获得Dao实现类的配置路径
	 * @param 无
	 * @return  String
	 * @exception ConfigurationException
	 */
	private static String getConfigPath() throws ConfigurationException {
		
		String path = "/config/oralceConfig.xml";
		LoadConfigurationProperties.setPath(PATHNAME);
		PropertiesConfiguration config = LoadConfigurationProperties.getInstance();
		String database = config.getString("DATABASE");
		if("MYSQL".equals(database)) {
			path = "/config/mysqlConfig.xml";
		}
		return path;
		
	}
	
	public static void main(String[] args) {

		try {
			System.out.println(getConfigPath());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}

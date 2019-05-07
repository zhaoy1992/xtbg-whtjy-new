package com.chinacreator.xtbg.pub.common;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.chinacreator.xtbg.pub.util.FileUtil;

/**
 *<p>Title:ReadFlowClass.java</p>
 *<p>Description:将流程实例类加入内存中</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-2-2
 */
public class ReadFlowClass {

	protected static final Logger log = Logger.getLogger(ReadFlowClass.class.getName());
	
	private static List<FlowClassBean> flowClassBeanList = new ArrayList<FlowClassBean>();

	
	/**
	 * @Description  初始化加载servletBean
	 * @param 
	 * @return  
	 * @exception Exception
	 */
	public static void init() {
		try {
			log.info("流程实现类加载中...");
			getFlowClass();
		}catch(Exception e) {
			log.error(e);
		}
	}
	
	/**
	 * @Description  从类存只获得flowList类集合
	 * @param 
	 * @return  
	 * @exception Exception
	 */
	public static  List<FlowClassBean> getFlowList() {
		
		return flowClassBeanList;
		
	}
	/**
	 * @Description  获得flowList的集合
	 * @param 无
	 * @return  List
	 * @exception ParserConfigurationException, SAXException, IOException, ConfigurationException
	 */
	private static List<FlowClassBean> getFlowClass() throws ParserConfigurationException, SAXException, IOException, ConfigurationException {
		String path = "/config/flowConfig.xml";
		File file = new File(FileUtil.getClassPath(ReadFlowClass.class) + path);
		
		if (!file.exists()){ //判断文件是否存在
			throw new FileNotFoundException("file not exist");
		}
		DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance(); //得到DOM解析器的工厂实例
		DocumentBuilder builder = dFactory.newDocumentBuilder();//从DOM工厂获得DOM解析器
		Document doc;							
		doc = builder.parse(file);//解析XML文档的输入流，得到一个Document

		NodeList classNames = doc.getElementsByTagName("className");
		for(int i = 0; i < classNames.getLength(); i++) {
			FlowClassBean flowClassBean = new FlowClassBean();
			Node className = classNames.item(i);
			if(className.getAttributes().getNamedItem("id") != null) {
				flowClassBean.setId(className.getAttributes().getNamedItem("id").getNodeValue());
			}
			flowClassBean.setClassName(className.getFirstChild().getNodeValue());
			flowClassBeanList.add(flowClassBean);
		}
		return flowClassBeanList;
	}
}

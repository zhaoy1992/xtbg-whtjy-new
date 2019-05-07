package com.chinacreator.xtbg.core.workbench.cache;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.workbench.entity.PendingBean;
import com.chinacreator.xtbg.core.workbench.entity.PendingItemBean;
import com.chinacreator.xtbg.core.workbench.entity.ShowItemBean;
import com.chinacreator.xtbg.core.workbench.entity.SystemBean;

/**
 *<p>Title:WorkbenchConfCache.java</p>
 *<p>Description:工作台配置信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class WorkbenchConfCache {

	private static final Log LOG = LogFactory.getLog(WorkbenchConfCache.class);
	
	//配置文件
	private String frist_config_path = "\\coreconfig\\first_config.xml";
	
	private static Map<String,ShowItemBean> showItemMap = null;//首页显示块配置信息
	
	private static List<ShowItemBean> showItemList = null;//首页显示块配置信息
	
	private static PendingBean pendingBean = null;//首页总统计数据配置信息
	
	private static SystemBean systemBean = null;
	
	/**
	*<b>Summary: </b>
	* getShowItemMap(获取首页显示块配置信息)
	* @return
	*/
	public static Map<String, ShowItemBean> getShowItemMap() {
		return showItemMap;
	}

	/**
	*<b>Summary: </b>
	* getShowItemList(获取首页显示块配置信息)
	* @return
	*/
	public static List<ShowItemBean> getShowItemList() {
		return showItemList;
	}

	public void setFrist_config_path(String frist_config_path) {
		this.frist_config_path = frist_config_path;
	}

	/**
	*<b>Summary: </b>
	* getPendingBean(获取首页总统计数据配置信息)
	* @return
	*/
	public static PendingBean getPendingBean() {
		return pendingBean;
	}
	
	/**
	*<b>Summary: </b>
	* getSystemBean(获取系统配置信息)
	* @return
	*/
	public static SystemBean getSystemBean() {
		return systemBean;
	}

	/**
	*<b>Summary: </b>
	* init(容器启动加载工作台配置信息)
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@PostConstruct
	public void init() throws Exception {
		Document doc = null;
		try {
			File file = new File(StringUtil.getClassPath(WorkbenchConfCache.class) + frist_config_path);
			if (!file.exists()){
				throw new FileNotFoundException(frist_config_path + " not exist");
			}
			SAXReader reader = new SAXReader();
			doc = reader.read(new FileInputStream(file));
			Element root = doc.getRootElement();
			systemBean = new SystemBean();
			showItemMap = new HashMap<String, ShowItemBean>();
			showItemList = new ArrayList<ShowItemBean>();
			pendingBean = new PendingBean();
			
			Element systemElement = root.element("system");
			systemBean.setSys_name(systemElement.elementTextTrim("sys_name"));
			systemBean.setWeather_url(systemElement.elementTextTrim("weather_url"));
			
			List<Element> showItems = root.element("item").elements("show-item");
			for(Element e : showItems){//首页显示块配置信息
				ShowItemBean bean = new ShowItemBean();
				String id = e.attributeValue("id");
				bean.setId(id);
				bean.setName(e.attributeValue("name"));
				bean.setShowColumns(e.attributeValue("showColumns"));
				bean.setRealShowColumns(e.attributeValue("realShowColumns"));
				bean.setColumnsWidth(e.attributeValue("columnsWidth"));
				bean.setDynamicUrlColumns(e.attributeValue("dynamicUrlColumns"));
				bean.setUrlParamColumns(e.attributeValue("urlParamColumns"));
				bean.setClickurl(e.elementTextTrim("clickurl"));
				bean.setMoreUrl(e.elementTextTrim("moreUrl"));
				Element sqlElement = e.element("sql");
				bean.setParamCount(Integer.parseInt(sqlElement.attributeValue("paramCount")));
				bean.setMaxRownum(Integer.parseInt(sqlElement.attributeValue("maxRownum")));
				bean.setSql(sqlElement.getText());
				
				showItemMap.put(id, bean);
				showItemList.add(bean);
			}
			
			Element pendingElement = root.element("pending");
			pendingBean.setFunctionSql(pendingElement.attributeValue("functionSql"));
			List<Element> pendingItems = pendingElement.elements("pending-item");
			for(Element e : pendingItems){
				PendingItemBean bean = new PendingItemBean();
				bean.setId(e.attributeValue("id"));
				bean.setName(e.attributeValue("name"));
				bean.setClickurl(e.elementTextTrim("clickurl"));
				bean.setIframurl(e.elementTextTrim("iframurl"));
				pendingBean.setPendingItemBean(bean);
			}
			
			LOG.info("成功加载工作台配置信息");
		} finally {
			doc = null;
		}
	}
}

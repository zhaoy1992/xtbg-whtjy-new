package com.chinacreator.xtbg.core.file.cache;

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
import com.chinacreator.xtbg.core.file.entity.ShowItemBean;

/**
 * 
 *<p>Title:FileCache.java</p>
 *<p>Description:档案管理缓存</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-22
 */
public class FileCache {

	private static final Log LOG = LogFactory.getLog(FileCache.class);
	
	//配置文件
	private String frist_config_path = File.separator + "coreconfig" + File.separator + "first_config_file.xml";
	
	private static Map<String,ShowItemBean> showItemMap = null;//首页显示块配置信息
	
	private static List<ShowItemBean> showItemList = null;//首页显示块配置信息
	
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
	* init(容器启动加载工作台配置信息)
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@PostConstruct
	public void init() throws Exception {
		Document doc = null;
		try {
			File file = new File(StringUtil.getClassPath(FileCache.class) + frist_config_path);
			if (!file.exists()){
				throw new FileNotFoundException(frist_config_path + " not exist");
			}
			SAXReader reader = new SAXReader();
			doc = reader.read(new FileInputStream(file));
			Element root = doc.getRootElement();
			showItemList = new ArrayList<ShowItemBean>();
			showItemMap = new HashMap<String, ShowItemBean>();
			
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
				bean.setShowColumnsTitle(e.attributeValue("showColumnsTitle"));
				bean.setShowColumnsTileLocation(e.attributeValue("showColumnsTileLocation"));
				
				showItemMap.put(id, bean);
				showItemList.add(bean);
			}
	
			LOG.info("成功加载档案首页配置信息");
		} finally {
			doc = null;
		}
	}
}

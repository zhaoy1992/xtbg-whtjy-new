package com.chinacreator.xtbg.core.archive.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:GwcsAddressXmlReader.java</p>
 *<p>Description:解析公文传输地址簿配置文件</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 1, 2013
 */
public class GwcsAddressXmlReader {
	
	public GwcsAddressXmlReader(){
		
	}
	
	//构造诸如地址
	public GwcsAddressXmlReader(String gwcs_address_path){
		this.gwcs_address_path = gwcs_address_path;
	}
	
	private static final Log LOG = LogFactory.getLog(GwcsAddressXmlReader.class);
	
	//配置文件
	private String gwcs_address_path = "\\coreconfig\\gwcs-address_config.xml";
	
	@SuppressWarnings("unchecked")
	public List<GWCSUnitBean> getAddress(){
		List<GWCSUnitBean> list = new ArrayList<GWCSUnitBean>();
		Document doc = null;
		try {
			File file = new File(StringUtil.getClassPath(GwcsAddressXmlReader.class) + gwcs_address_path);
			if (!file.exists()){
				throw new FileNotFoundException(gwcs_address_path + " not exist");
			}
			SAXReader reader = new SAXReader();
			doc = reader.read(new FileInputStream(file));
			Element root = doc.getRootElement();
			List<Element> parentItems = root.elements("parentItem");
			for(Element e : parentItems){
				GWCSUnitBean bean = new GWCSUnitBean();
				//解析是否有效，只有有效的数据才显示
				String is_valid = e.attributeValue("is_valid");
				if(is_valid != null && !"".equals(is_valid)){
					bean.setOrg_name(e.attributeValue("name"));
					bean.setConfig_dom_id(e.attributeValue("config_dom_id"));
					bean.setConfig_sqlParamValue(e.attributeValue("sqlParamValue"));
					bean.setConfig_copies(e.attributeValue("copies"));
					bean.setConfig_number(e.attributeValue("number"));
					bean.setConfig_child_sql(e.elementTextTrim("sql"));
					list.add(bean);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return list;
	}
}
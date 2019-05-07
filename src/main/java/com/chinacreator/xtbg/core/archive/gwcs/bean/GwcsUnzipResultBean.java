package com.chinacreator.xtbg.core.archive.gwcs.bean;

/**
 * 
 *<p>Title:GwcsUnzipResultBean.java</p>
 *<p>Description:解压后返回的数据bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 6, 2013
 */
public class GwcsUnzipResultBean {
	/**
	 * 解压出来的xml路径
	 */
	private String xmlPath;
	/**
	 * 解压出来的ceb路径
	 */
	private String cebPath;
	public String getXmlPath() {
		return xmlPath;
	}
	public void setXmlPath(String xmlPath) {
		this.xmlPath = xmlPath;
	}
	public String getCebPath() {
		return cebPath;
	}
	public void setCebPath(String cebPath) {
		this.cebPath = cebPath;
	}
	
	
}

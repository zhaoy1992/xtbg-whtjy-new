package com.chinacreator.xtbg.core.workbench.entity;

import java.io.Serializable;

/**
 *<p>Title:ShowItemBean.java</p>
 *<p>Description:首页显示块配置信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class ShowItemBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;//块id
	
	private String name;//块名称
	
	private String showColumns;//显示字段
	
	private String realShowColumns;//真实显示的字段
	
	private String columnsWidth;//字段宽度百分比
	
	private String urlParamColumns;//连接参数
	
	private String dynamicUrlColumns;//为动态查询出的链接地址  值为字段名
	
	private String clickurl;//链接url
	
	private String moreUrl;//更多 查看链接url
	
	private int paramCount;//sql语句中预编译参数个数
	
	private int maxRownum;//查询数据条数
	
	private String sql;//数据查询url

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShowColumns() {
		return showColumns;
	}

	public void setShowColumns(String showColumns) {
		this.showColumns = showColumns;
	}

	public String getRealShowColumns() {
		return realShowColumns;
	}

	public void setRealShowColumns(String realShowColumns) {
		this.realShowColumns = realShowColumns;
	}

	public String getUrlParamColumns() {
		return urlParamColumns;
	}

	public void setUrlParamColumns(String urlParamColumns) {
		this.urlParamColumns = urlParamColumns;
	}
	
	public String getDynamicUrlColumns() {
		return dynamicUrlColumns;
	}

	public void setDynamicUrlColumns(String dynamicUrlColumns) {
		this.dynamicUrlColumns = dynamicUrlColumns;
	}

	public String getClickurl() {
		return clickurl;
	}

	public void setClickurl(String clickurl) {
		this.clickurl = clickurl;
	}

	public String getMoreUrl() {
		return moreUrl;
	}

	public void setMoreUrl(String moreUrl) {
		this.moreUrl = moreUrl;
	}

	public int getParamCount() {
		return paramCount;
	}

	public void setParamCount(int paramCount) {
		this.paramCount = paramCount;
	}

	public int getMaxRownum() {
		return maxRownum;
	}

	public void setMaxRownum(int maxRownum) {
		this.maxRownum = maxRownum;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getColumnsWidth() {
		return columnsWidth;
	}

	public void setColumnsWidth(String columnsWidth) {
		this.columnsWidth = columnsWidth;
	}
	
	
}

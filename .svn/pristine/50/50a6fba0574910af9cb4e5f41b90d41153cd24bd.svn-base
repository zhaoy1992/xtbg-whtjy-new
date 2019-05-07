package com.chinacreator.xtbg.core.workbench.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:ShowItemDetailDataBean.java</p>
 *<p>Description:首页显示块每行的数据</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-27
 */
public class ShowItemDetailDataBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private List<ItemValueBean> valueList = new ArrayList<ItemValueBean>();//显示的值集合
	
	private String clickUrl;//链接地址
	
	private String cloumnWidth;//各字段宽度百分比

	private String moreUrl; //列表URL
	
	/**
	 * <b>Summary: </b>
	 *     获取moreUrl的值
	 * @return moreUrl 
	 */
	public String getMoreUrl() {
		return moreUrl;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 moreUrl 的值 
	 * @param moreUrl 
	 */
	public void setMoreUrl(String moreUrl) {
		this.moreUrl = moreUrl;
	}

	public List<ItemValueBean> getValueList() {
		return valueList;
	}

	public void setValue(ItemValueBean bean) {
		valueList.add(bean);
	}

	public String getClickUrl() {
		return clickUrl;
	}

	public void setClickUrl(String clickUrl) {
		this.clickUrl = clickUrl;
	}

	public String getCloumnWidth() {
		return cloumnWidth;
	}

	public void setCloumnWidth(String cloumnWidth) {
		this.cloumnWidth = cloumnWidth;
	}
}

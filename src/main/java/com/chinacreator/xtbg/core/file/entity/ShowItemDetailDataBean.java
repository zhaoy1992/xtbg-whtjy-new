package com.chinacreator.xtbg.core.file.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:ShowItemDetailDataBean.java</p>
 *<p>Description:知识库显示块每行的数据</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-15
 */
public class ShowItemDetailDataBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private List<ItemValueBean> valueList = new ArrayList<ItemValueBean>();//显示的值集合
	
	private String clickUrl;//链接地址
	
	private String cloumnWidth;//各字段宽度百分比

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

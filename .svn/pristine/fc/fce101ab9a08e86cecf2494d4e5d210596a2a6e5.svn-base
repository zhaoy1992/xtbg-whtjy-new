package com.chinacreator.xtbg.core.workbench.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:ShowItemDataBean.java</p>
 *<p>Description:首页显示块数据实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-27
 */
public class ShowItemDataBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String itemID;//显示模块id
	
	private int showMaxRowNum;//模块显示数据行数
	
	private int showTypeCount;//显示的字段个数
	
	private List<ShowItemDetailDataBean> list = new ArrayList<ShowItemDetailDataBean>();//数据集合

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	
	public int getShowMaxRowNum() {
		return showMaxRowNum;
	}

	public void setShowMaxRowNum(int showMaxRowNum) {
		this.showMaxRowNum = showMaxRowNum;
	}

	public int getShowTypeCount() {
		return showTypeCount;
	}

	public void setShowTypeCount(int showTypeCount) {
		this.showTypeCount = showTypeCount;
	}

	public List<ShowItemDetailDataBean> getList() {
		return list;
	}

	public void setShowItemDetailDataBean(ShowItemDetailDataBean bean) {
		list.add(bean);
	}
}

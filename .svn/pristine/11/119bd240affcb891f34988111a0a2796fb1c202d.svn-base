package com.chinacreator.xtbg.core.file.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:ShowItemDataBean.java</p>
 *<p>Description:知识库显示块数据实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-15
 */
public class ShowItemDataBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String itemID;//显示模块id
	
	private int showMaxRowNum;//模块显示数据行数
	
	private int showTypeCount;//显示的字段个数
	
	private String showColumnsTitle;//列头字段显示名称
	
	private String cloumnWidth;//各字段宽度百分比
	
	private String showColumnsTileLocation; //列头字段显示的位置 left,right,center
	
	public String getShowColumnsTileLocation() {
		return showColumnsTileLocation;
	}

	public void setShowColumnsTileLocation(String showColumnsTileLocation) {
		this.showColumnsTileLocation = showColumnsTileLocation;
	}
	
	public String getCloumnWidth() {
		return cloumnWidth;
	}

	public void setCloumnWidth(String cloumnWidth) {
		this.cloumnWidth = cloumnWidth;
	}

	public String getShowColumnsTitle() {
		return showColumnsTitle;
	}

	public void setShowColumnsTitle(String showColumnsTitle) {
		this.showColumnsTitle = showColumnsTitle;
	}

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

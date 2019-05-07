package com.chinacreator.xtbg.core.archive.entity;

import java.util.List;

/**
 * 
 *<p>Title:ExcelBean.java</p>
 *<p>Description:文件拆分bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 17, 2013
 */
public class ExcelBean {
	private String title; // 分割标题
	private int totalNum; // 总共多少行
	private int startRowNum; // 开始行号
	private int endRowNum; // 结束行号
	private String unit_id;	//拆分单位id
	private long file_size;	//文件大小
	
	private String city;	//市
	private String area;	//区
	private String remark;	//备注
	
	private boolean isAllItemSame;	//是否所有科目都相同，即 没功能科目 经济科目
	private List<String> headers;		//标题
	private List<ExcelDetailBean> list;	//详细数据list
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public boolean isAllItemSame() {
		return isAllItemSame;
	}
	public void setAllItemSame(boolean isAllItemSame) {
		this.isAllItemSame = isAllItemSame;
	}
	public List<String> getHeaders() {
		return headers;
	}
	public void setHeaders(List<String> headers) {
		this.headers = headers;
	}
	public List<ExcelDetailBean> getList() {
		return list;
	}
	public void setList(List<ExcelDetailBean> list) {
		this.list = list;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getUnit_id() {
		return unit_id;
	}

	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	@Override
	public String toString() {
		return "ExcelBean [title=" + title + ", totalNum=" + totalNum
				+ ", startRowNum=" + startRowNum + ", endRowNum=" + endRowNum
				+ ", city="+city + ", area="+area
				+ ", headers=" + headers + ", list=" + list + "]";
	}
}
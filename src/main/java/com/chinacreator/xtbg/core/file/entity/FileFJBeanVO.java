package com.chinacreator.xtbg.core.file.entity;


/**
 * 档案统计分类
 *<p>Title:FileFJBeanVO.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 23, 2013
 */
public class FileFJBeanVO{
	//图表 57  阅读数量统计（按分类）
	private String typeName;
	private String fileNum;
	private String queryCount;
	private String lendCount;
	private String otherDeptLendCount;//
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getFileNum() {
		return fileNum;
	}
	public void setFileNum(String fileNum) {
		this.fileNum = fileNum;
	}
	public String getQueryCount() {
		return queryCount;
	}
	public void setQueryCount(String queryCount) {
		this.queryCount = queryCount;
	}
	public String getLendCount() {
		return lendCount;
	}
	public void setLendCount(String lendCount) {
		this.lendCount = lendCount;
	}
	public String getOtherDeptLendCount() {
		return otherDeptLendCount;
	}
	public void setOtherDeptLendCount(String otherDeptLendCount) {
		this.otherDeptLendCount = otherDeptLendCount;
	}
}

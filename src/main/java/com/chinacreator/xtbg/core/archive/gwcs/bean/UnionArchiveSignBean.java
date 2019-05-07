package com.chinacreator.xtbg.core.archive.gwcs.bean;

public class UnionArchiveSignBean {
	private String id;		//流程实例ID
	private String buss_id;		//公文业务ID
	private String orgaddr;		//参与盖章的单位地址码
	private String signorder;		//盖章顺序，主办方默认为第一位 1 
	private String issigned;		//是否完成盖章操作默认为 0 表示未完成盖章 1 表示完成盖章
	private String terminate;		//该单位是否终止联合盖章 0 表示未终止 1 表示终止
	private String isstamping;		//盖章流程标识默认为0表示未到此单位，1 表示已到此单位
	private String stampdate;		// 盖章或者终止的时间
	private String orgname;		//参与盖章的单位名称
	
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	/**
	*<b>Summary: 获取流程实例ID</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置流程实例ID</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取公文业务ID</b>
	*/
	public String getBuss_id() {
		return buss_id;
	}
	/**
	*<b>Summary: 设置公文业务ID</b>
	*/
	public void setBuss_id(String buss_id) {
		this.buss_id = buss_id;
	}
	/**
	*<b>Summary: 获取参与盖章的单位地址码</b>
	*/
	public String getOrgaddr() {
		return orgaddr;
	}
	/**
	*<b>Summary: 设置参与盖章的单位地址码</b>
	*/
	public void setOrgaddr(String orgaddr) {
		this.orgaddr = orgaddr;
	}
	/**
	*<b>Summary: 获取盖章顺序，主办方默认为第一位 1 </b>
	*/
	public String getSignorder() {
		return signorder;
	}
	/**
	*<b>Summary: 设置盖章顺序，主办方默认为第一位 1 </b>
	*/
	public void setSignorder(String signorder) {
		this.signorder = signorder;
	}
	/**
	*<b>Summary: 获取是否完成盖章操作默认为 0 表示未完成盖章 1 表示完成盖章</b>
	*/
	public String getIssigned() {
		return issigned;
	}
	/**
	*<b>Summary: 设置是否完成盖章操作默认为 0 表示未完成盖章 1 表示完成盖章</b>
	*/
	public void setIssigned(String issigned) {
		this.issigned = issigned;
	}
	/**
	*<b>Summary: 获取该单位是否终止联合盖章 0 表示未终止 1 表示终止</b>
	*/
	public String getTerminate() {
		return terminate;
	}
	/**
	*<b>Summary: 设置该单位是否终止联合盖章 0 表示未终止 1 表示终止</b>
	*/
	public void setTerminate(String terminate) {
		this.terminate = terminate;
	}
	/**
	*<b>Summary: 获取盖章流程标识默认为0表示未到此单位，1 表示已到此单位</b>
	*/
	public String getIsstamping() {
		return isstamping;
	}
	/**
	*<b>Summary: 设置盖章流程标识默认为0表示未到此单位，1 表示已到此单位</b>
	*/
	public void setIsstamping(String isstamping) {
		this.isstamping = isstamping;
	}
	public String getStampdate() {
		return stampdate;
	}
	public void setStampdate(String stampdate) {
		this.stampdate = stampdate;
	}
}

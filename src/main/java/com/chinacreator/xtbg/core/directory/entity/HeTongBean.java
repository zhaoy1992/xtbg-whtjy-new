package com.chinacreator.xtbg.core.directory.entity;

/**
 * 
 *<p>Title:HeTongBean.java</p>
 *<p>Description:合同信息Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-2-20
 */
public class HeTongBean {
	private String hetong_id;		//主键id
	private String hetong_userands_id;		//人员主键id
	private String hetong_isold;		//是否参加养老保险"1:是,0:否"
	private String hetong_isyl;		//是否参加医疗保险"1:是,0:否"
	private String hetong_issy;		//是否参加生育保险"1:是,0:否"
	private String hetong_isgs;		//是否参加工伤保险"1:是,0:否"
	private String hetong_isshiye;		//是否参加失业保险"1:是,0:否"
	private String hetong_isydwgm;		//是否原单位购买 保险 "1":是 , "0":否
	private String hetong_type;		//合同类别
	private String hetong_number;		//08年后劳动合同签订次数
	private String hetong_first_date;		//首次合同签订日期
	private String hetong_nowstart_date;		//现合同起始期
	private String hetong_nowsend_date;		//现合同终止期
	private String hetong_trystart_date;		//合同试用起始期
	private String hetong_tryend_date;		//合同试用终止期
	private String hetong_busiid;//合同编号
	
	
	public String getHetong_busiid() {
		return hetong_busiid;
	}
	public void setHetong_busiid(String hetong_busiid) {
		this.hetong_busiid = hetong_busiid;
	}
	/**
	 * <b>Summary: </b>
	 *     获取hetong_isydwgm的值
	 * @return hetong_isydwgm 
	 */
	public String getHetong_isydwgm() {
		return hetong_isydwgm;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 hetong_isydwgm 的值 
	 * @param hetong_isydwgm 
	 */
	public void setHetong_isydwgm(String hetong_isydwgm) {
		this.hetong_isydwgm = hetong_isydwgm;
	}
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getHetong_id() {
		return hetong_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setHetong_id(String hetong_id) {
		this.hetong_id = hetong_id;
	}
	/**
	*<b>Summary: 获取人员主键id</b>
	*/
	public String getHetong_userands_id() {
		return hetong_userands_id;
	}
	/**
	*<b>Summary: 设置人员主键id</b>
	*/
	public void setHetong_userands_id(String hetong_userands_id) {
		this.hetong_userands_id = hetong_userands_id;
	}
	/**
	*<b>Summary: 获取是否参加养老保险"1:是,0:否"</b>
	*/
	public String getHetong_isold() {
		return hetong_isold;
	}
	/**
	*<b>Summary: 设置是否参加养老保险"1:是,0:否"</b>
	*/
	public void setHetong_isold(String hetong_isold) {
		this.hetong_isold = hetong_isold;
	}
	/**
	*<b>Summary: 获取是否参加医疗保险"1:是,0:否"</b>
	*/
	public String getHetong_isyl() {
		return hetong_isyl;
	}
	/**
	*<b>Summary: 设置是否参加医疗保险"1:是,0:否"</b>
	*/
	public void setHetong_isyl(String hetong_isyl) {
		this.hetong_isyl = hetong_isyl;
	}
	/**
	*<b>Summary: 获取是否参加生育保险"1:是,0:否"</b>
	*/
	public String getHetong_issy() {
		return hetong_issy;
	}
	/**
	*<b>Summary: 设置是否参加生育保险"1:是,0:否"</b>
	*/
	public void setHetong_issy(String hetong_issy) {
		this.hetong_issy = hetong_issy;
	}
	/**
	*<b>Summary: 获取是否参加工伤保险"1:是,0:否"</b>
	*/
	public String getHetong_isgs() {
		return hetong_isgs;
	}
	/**
	*<b>Summary: 设置是否参加工伤保险"1:是,0:否"</b>
	*/
	public void setHetong_isgs(String hetong_isgs) {
		this.hetong_isgs = hetong_isgs;
	}
	/**
	*<b>Summary: 获取是否参加失业保险"1:是,0:否"</b>
	*/
	public String getHetong_isshiye() {
		return hetong_isshiye;
	}
	/**
	*<b>Summary: 设置是否参加失业保险"1:是,0:否"</b>
	*/
	public void setHetong_isshiye(String hetong_isshiye) {
		this.hetong_isshiye = hetong_isshiye;
	}
	/**
	*<b>Summary: 获取合同类别</b>
	*/
	public String getHetong_type() {
		return hetong_type;
	}
	/**
	*<b>Summary: 设置合同类别</b>
	*/
	public void setHetong_type(String hetong_type) {
		this.hetong_type = hetong_type;
	}
	/**
	*<b>Summary: 获取08年后劳动合同签订次数</b>
	*/
	public String getHetong_number() {
		return hetong_number;
	}
	/**
	*<b>Summary: 设置08年后劳动合同签订次数</b>
	*/
	public void setHetong_number(String hetong_number) {
		this.hetong_number = hetong_number;
	}
	/**
	*<b>Summary: 获取首次合同签订日期</b>
	*/
	public String getHetong_first_date() {
		return hetong_first_date;
	}
	/**
	*<b>Summary: 设置首次合同签订日期</b>
	*/
	public void setHetong_first_date(String hetong_first_date) {
		this.hetong_first_date = hetong_first_date;
	}
	/**
	*<b>Summary: 获取现合同起始期</b>
	*/
	public String getHetong_nowstart_date() {
		return hetong_nowstart_date;
	}
	/**
	*<b>Summary: 设置现合同起始期</b>
	*/
	public void setHetong_nowstart_date(String hetong_nowstart_date) {
		this.hetong_nowstart_date = hetong_nowstart_date;
	}
	/**
	*<b>Summary: 获取现合同终止期</b>
	*/
	public String getHetong_nowsend_date() {
		return hetong_nowsend_date;
	}
	/**
	*<b>Summary: 设置现合同终止期</b>
	*/
	public void setHetong_nowsend_date(String hetong_nowsend_date) {
		this.hetong_nowsend_date = hetong_nowsend_date;
	}
	/**
	*<b>Summary: 获取合同试用起始期</b>
	*/
	public String getHetong_trystart_date() {
		return hetong_trystart_date;
	}
	/**
	*<b>Summary: 设置合同试用起始期</b>
	*/
	public void setHetong_trystart_date(String hetong_trystart_date) {
		this.hetong_trystart_date = hetong_trystart_date;
	}
	/**
	*<b>Summary: 获取合同试用终止期</b>
	*/
	public String getHetong_tryend_date() {
		return hetong_tryend_date;
	}
	/**
	*<b>Summary: 设置合同试用终止期</b>
	*/
	public void setHetong_tryend_date(String hetong_tryend_date) {
		this.hetong_tryend_date = hetong_tryend_date;
	}

}

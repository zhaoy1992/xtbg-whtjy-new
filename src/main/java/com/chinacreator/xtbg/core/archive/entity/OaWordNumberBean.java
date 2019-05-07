package com.chinacreator.xtbg.core.archive.entity;

/**
 *<p>Title:OaWordNumberBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-30
 */
public class OaWordNumberBean {
	private String busi_id;		//业务ID
	private String number_type;		//编号类型
	private String number_year;		//编号年份
	private String number_code;		//编号号码
	private String archive_title; //标题
	private String archive_date; //时间
	private String archive_userid; //申请人id
	private String archive_user; //申请人
	private String is_paper; //是否纸质
	private String archive_type; //类型
	private String enddate; //页面查询参数
	private String number_title; //编号标题
	
	
	public String getArchive_userid() {
		return archive_userid;
	}
	public void setArchive_userid(String archive_userid) {
		this.archive_userid = archive_userid;
	}
	/**
	 * <b>Summary: </b>
	 *     获取number_title的值
	 * @return number_title 
	 */
	public String getNumber_title() {
		return number_title;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 number_title 的值 
	 * @param number_title 
	 */
	public void setNumber_title(String number_title) {
		this.number_title = number_title;
	}
	/**
	*<b>Summary: 获取编号类型</b>
	*/
	public String getNumber_type() {
		return number_type;
	}
	/**
	*<b>Summary: 设置编号类型</b>
	*/
	public void setNumber_type(String number_type) {
		this.number_type = number_type;
	}
	/**
	*<b>Summary: 获取编号年份</b>
	*/
	public String getNumber_year() {
		return number_year;
	}
	/**
	*<b>Summary: 设置编号年份</b>
	*/
	public void setNumber_year(String number_year) {
		this.number_year = number_year;
	}
	/**
	*<b>Summary: 获取编号号码</b>
	*/
	public String getNumber_code() {
		return number_code;
	}
	/**
	*<b>Summary: 设置编号号码</b>
	*/
	public void setNumber_code(String number_code) {
		this.number_code = number_code;
	}
	/**
	*<b>Summary: 获取业务ID</b>
	*/
	public String getBusi_id() {
		return busi_id;
	}
	/**
	*<b>Summary: 设置业务ID</b>
	*/
	public void setBusi_id(String busi_id) {
		this.busi_id = busi_id;
	}
	public String getArchive_title() {
		return archive_title;
	}
	public void setArchive_title(String archive_title) {
		this.archive_title = archive_title;
	}
	public String getArchive_date() {
		return archive_date;
	}
	public void setArchive_date(String archive_date) {
		this.archive_date = archive_date;
	}
	public String getArchive_user() {
		return archive_user;
	}
	public void setArchive_user(String archive_user) {
		this.archive_user = archive_user;
	}
	public String getIs_paper() {
		return is_paper;
	}
	public void setIs_paper(String is_paper) {
		this.is_paper = is_paper;
	}
	public String getArchive_type() {
		return archive_type;
	}
	public void setArchive_type(String archive_type) {
		this.archive_type = archive_type;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	
}


 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataTypeBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:PsdataTypeBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-9
 */
public class PsdataTypeBean extends XtDbBaseBean {
	
	private String p_type_id; // 分类ID
	private String p_type_name; // 分类名称
	private String p_type_unit; // 分类所属的单位ID
	private String p_type_parentid; // 所属上级分类
	private String p_type_order; // 排序号
	private String p_remark; // 备注
	private String p_creater_userid; // 登记人ID
	private String p_creater_username; // 登记姓名
	private Object p_creater_time; // 登记时间

	public PsdataTypeBean() {
		super("oa_persondata_type", "p_type_id");
	}

	/**
	 * <b>Summary: 获取分类ID</b>
	 */
	public String getP_type_id() {
		return p_type_id;
	}

	/**
	 * <b>Summary: 设置分类ID</b>
	 */
	public void setP_type_id(String p_type_id) {
		this.p_type_id = p_type_id;
	}

	/**
	 * <b>Summary: 获取分类名称</b>
	 */
	public String getP_type_name() {
		return p_type_name;
	}

	/**
	 * <b>Summary: 设置分类名称</b>
	 */
	public void setP_type_name(String p_type_name) {
		this.p_type_name = p_type_name;
	}

	/**
	 * <b>Summary: 获取分类所属的单位ID</b>
	 */
	public String getP_type_unit() {
		return p_type_unit;
	}

	/**
	 * <b>Summary: 设置分类所属的单位ID</b>
	 */
	public void setP_type_unit(String p_type_unit) {
		this.p_type_unit = p_type_unit;
	}

	/**
	 * <b>Summary: 获取所属上级分类</b>
	 */
	public String getP_type_parentid() {
		return p_type_parentid;
	}

	/**
	 * <b>Summary: 设置所属上级分类</b>
	 */
	public void setP_type_parentid(String p_type_parentid) {
		this.p_type_parentid = p_type_parentid;
	}

	/**
	 * <b>Summary: 获取排序号</b>
	 */
	public String getP_type_order() {
		return p_type_order;
	}

	/**
	 * <b>Summary: 设置排序号</b>
	 */
	public void setP_type_order(String p_type_order) {
		this.p_type_order = p_type_order;
	}

	/**
	 * <b>Summary: 获取备注</b>
	 */
	public String getP_remark() {
		return p_remark;
	}

	/**
	 * <b>Summary: 设置备注</b>
	 */
	public void setP_remark(String p_remark) {
		this.p_remark = p_remark;
	}

	/**
	 * <b>Summary: 获取登记人ID</b>
	 */
	public String getP_creater_userid() {
		return p_creater_userid;
	}

	/**
	 * <b>Summary: 设置登记人ID</b>
	 */
	public void setP_creater_userid(String p_creater_userid) {
		this.p_creater_userid = p_creater_userid;
	}

	/**
	 * <b>Summary: 获取登记姓名</b>
	 */
	public String getP_creater_username() {
		return p_creater_username;
	}

	/**
	 * <b>Summary: 设置登记姓名</b>
	 */
	public void setP_creater_username(String p_creater_username) {
		this.p_creater_username = p_creater_username;
	}

	/**
	 * <b>Summary: 获取登记时间</b>
	 */
	public Object getP_creater_time() {
		return p_creater_time;
	}

	/**
	 * <b>Summary: 设置登记时间</b>
	 */
	public void setP_creater_time(Object p_creater_time) {
		this.p_creater_time = p_creater_time;
	}
}

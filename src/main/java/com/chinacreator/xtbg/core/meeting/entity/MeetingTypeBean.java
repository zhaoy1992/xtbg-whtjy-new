package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingType.java</p>
 *<p>Description:会议类型</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingTypeBean extends XtDbBaseBean{	

	private String m_type_id; // 会议类型id
	private String m_type_code; // 会议类型编码
	private String m_type_name; // 会议类型名称
	private String m_unit_id; // 所属单位id
	private String m_unit_name ;//所属单位名
	private String m_is_use_flag; // 是否有效(1有效0无效)
	private Object m_is_use_time; // 有效时间(必须在此时间之前使用)
	private String m_reg_user_id; // 登记人id
	private String m_reg_user_name; // 登记人name
	private Object m_reg_time; // 登记时间
	private String m_remark; // 备注
	
	public MeetingTypeBean() {
		super("oa_meeting_type", "m_type_id");
	}

	/**
	 *<b>Summary: 获取会议类型id</b>
	 */
	public String getM_type_id() {
		return m_type_id;
	}

	/**
	 *<b>Summary: 设置会议类型id</b>
	 */
	public void setM_type_id(String m_type_id) {
		this.m_type_id = m_type_id;
	}

	/**
	 *<b>Summary: 获取会议类型编码</b>
	 */
	public String getM_type_code() {
		return m_type_code;
	}

	/**
	 *<b>Summary: 设置会议类型编码</b>
	 */
	public void setM_type_code(String m_type_code) {
		this.m_type_code = m_type_code;
	}

	/**
	 *<b>Summary: 获取会议类型名称</b>
	 */
	public String getM_type_name() {
		return m_type_name;
	}

	/**
	 *<b>Summary: 设置会议类型名称</b>
	 */
	public void setM_type_name(String m_type_name) {
		this.m_type_name = m_type_name;
	}

	/**
	 *<b>Summary: 获取所属单位</b>
	 */
	public String getM_unit_id() {
		return m_unit_id;
	}

	/**
	 *<b>Summary: 设置所属单位</b>
	 */
	public void setM_unit_id(String m_unit_id) {
		this.m_unit_id = m_unit_id;
	}

	/**
	 *<b>Summary: 获取是否有效(1有效0无效)</b>
	 */
	public String getM_is_use_flag() {
		return m_is_use_flag;
	}

	/**
	 *<b>Summary: 设置是否有效(1有效0无效)</b>
	 */
	public void setM_is_use_flag(String m_is_use_flag) {
		this.m_is_use_flag = m_is_use_flag;
	}

	/**
	 *<b>Summary: 获取有效时间(必须在此时间之前使用)</b>
	 */
	public Object getM_is_use_time() {
		return m_is_use_time;
	}

	/**
	 *<b>Summary: 设置有效时间(必须在此时间之前使用)</b>
	 */
	public void setM_is_use_time(Object m_is_use_time) {
		this.m_is_use_time = m_is_use_time;
	}

	/**
	 *<b>Summary: 获取登记人id</b>
	 */
	public String getM_reg_user_id() {
		return m_reg_user_id;
	}

	/**
	 *<b>Summary: 设置登记人id</b>
	 */
	public void setM_reg_user_id(String m_reg_user_id) {
		this.m_reg_user_id = m_reg_user_id;
	}

	/**
	 *<b>Summary: 获取登记人name</b>
	 */
	public String getM_reg_user_name() {
		return m_reg_user_name;
	}

	/**
	 *<b>Summary: 设置登记人name</b>
	 */
	public void setM_reg_user_name(String m_reg_user_name) {
		this.m_reg_user_name = m_reg_user_name;
	}

	/**
	 *<b>Summary: 获取登记时间</b>
	 */
	public Object getM_reg_time() {
		return m_reg_time;
	}

	/**
	 *<b>Summary: 设置登记时间</b>
	 */
	public void setM_reg_time(Object m_reg_time) {
		this.m_reg_time = m_reg_time;
	}

	/**
	 *<b>Summary: 获取备注</b>
	 */
	public String getM_remark() {
		return m_remark;
	}

	/**
	 *<b>Summary: 设置备注</b>
	 */
	public void setM_remark(String m_remark) {
		this.m_remark = m_remark;
	}

	public String getM_unit_name() {
		return m_unit_name;
	}

	public void setM_unit_name(String mUnitName) {
		m_unit_name = mUnitName;
	}

}

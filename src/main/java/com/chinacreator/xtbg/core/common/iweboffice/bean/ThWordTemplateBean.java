package com.chinacreator.xtbg.core.common.iweboffice.bean;
/**
 * 
 *<p>Title:ThWordTemplateBean.java</p>
 *<p>Description:套红模版实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-12
 */
public class ThWordTemplateBean {

	private String template_id_th;		//套红模板主键
	private String template_name_th;		//套红模板名称
	private Object template_creatortime_th;		//创建时间
	private String template_userid_th;		//创建者主键
	private String template_username_th;		//创建者
	private String org_id;		//机构id
	private String org_name;		//机构名称
	private String template_remark_th;		//套红模版说明
	private String is_common_th;		//是否套红模板
	private Object lastmodifytime_th;		//最后修改时间
	private String template_sn_th;		//序号
	private String remark;		//备用
	private String table_code;		//表名
	private String busitype_code;//流程业务类型
	public String getTable_code() {
		return table_code;
	}
	public void setTable_code(String table_code) {
		this.table_code = table_code;
	}
	/**
	*<b>Summary: 获取套红模板主键</b>
	*/
	
	public String getTemplate_id_th() {
		return template_id_th;
	}
	/**
	*<b>Summary: 设置套红模板主键</b>
	*/
	public void setTemplate_id_th(String template_id_th) {
		this.template_id_th = template_id_th;
	}
	/**
	*<b>Summary: 获取套红模板名称</b>
	*/
	public String getTemplate_name_th() {
		return template_name_th;
	}
	/**
	*<b>Summary: 设置套红模板名称</b>
	*/
	public void setTemplate_name_th(String template_name_th) {
		this.template_name_th = template_name_th;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getTemplate_creatortime_th() {
		return template_creatortime_th;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setTemplate_creatortime_th(Object template_creatortime_th) {
		this.template_creatortime_th = template_creatortime_th;
	}
	/**
	*<b>Summary: 获取创建者主键</b>
	*/
	public String getTemplate_userid_th() {
		return template_userid_th;
	}
	/**
	*<b>Summary: 设置创建者主键</b>
	*/
	public void setTemplate_userid_th(String template_userid_th) {
		this.template_userid_th = template_userid_th;
	}
	/**
	*<b>Summary: 获取创建者</b>
	*/
	public String getTemplate_username_th() {
		return template_username_th;
	}
	/**
	*<b>Summary: 设置创建者</b>
	*/
	public void setTemplate_username_th(String template_username_th) {
		this.template_username_th = template_username_th;
	}
	/**
	*<b>Summary: 获取机构id</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置机构id</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取机构名称</b>
	*/
	public String getOrg_name() {
		return org_name;
	}
	/**
	*<b>Summary: 设置机构名称</b>
	*/
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	/**
	*<b>Summary: 获取套红模版说明</b>
	*/
	public String getTemplate_remark_th() {
		return template_remark_th;
	}
	/**
	*<b>Summary: 设置套红模版说明</b>
	*/
	public void setTemplate_remark_th(String template_remark_th) {
		this.template_remark_th = template_remark_th;
	}
	/**
	*<b>Summary: 获取是否套红模板</b>
	*/
	public String getIs_common_th() {
		return is_common_th;
	}
	/**
	*<b>Summary: 设置是否套红模板</b>
	*/
	public void setIs_common_th(String is_common_th) {
		this.is_common_th = is_common_th;
	}
	/**
	*<b>Summary: 获取最后修改时间</b>
	*/
	public Object getLastmodifytime_th() {
		return lastmodifytime_th;
	}
	/**
	*<b>Summary: 设置最后修改时间</b>
	*/
	public void setLastmodifytime_th(Object lastmodifytime_th) {
		this.lastmodifytime_th = lastmodifytime_th;
	}
	/**
	*<b>Summary: 获取序号</b>
	*/
	public String getTemplate_sn_th() {
		return template_sn_th;
	}
	/**
	*<b>Summary: 设置序号</b>
	*/
	public void setTemplate_sn_th(String template_sn_th) {
		this.template_sn_th = template_sn_th;
	}
	/**
	*<b>Summary: 获取备用</b>
	*/
	public String getRemark() {
		return remark;
	}
	/**
	*<b>Summary: 设置备用</b>
	*/
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * <b>Summary: </b>
	 *     获取busitype_code的值
	 * @return busitype_code 
	 */
	public String getBusitype_code() {
		return busitype_code;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 busitype_code 的值 
	 * @param busitype_code 
	 */
	public void setBusitype_code(String busitype_code) {
		this.busitype_code = busitype_code;
	}

}

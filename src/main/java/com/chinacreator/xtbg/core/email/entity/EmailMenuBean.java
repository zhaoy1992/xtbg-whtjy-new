package com.chinacreator.xtbg.core.email.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:EmailMenuBean.java</p>
 *<p>Description:邮件菜单实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-18
 */
public class EmailMenuBean extends XtDbBaseBean{

	public EmailMenuBean(){
		super("oa_mail_menu","menu_id");
	}
	private String menu_id;		//菜单标题主键
	private String menu_name;		//菜单标题名称
	private String menu_remark;		//1.收信箱,2.草稿箱，3.已发邮件，4.发邮件
	private String menu_parentid;		//菜单标题父类id
	private String remark1;		//备用字段1
	private String remark2;		//备用字段2
	/**
	*<b>Summary: 获取菜单标题主键</b>
	*/
	public String getMenu_id() {
		return menu_id;
	}
	/**
	*<b>Summary: 设置菜单标题主键</b>
	*/
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	/**
	*<b>Summary: 获取菜单标题名称</b>
	*/
	public String getMenu_name() {
		return menu_name;
	}
	/**
	*<b>Summary: 设置菜单标题名称</b>
	*/
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	/**
	*<b>Summary: 获取说明</b>
	*/
	public String getMenu_remark() {
		return menu_remark;
	}
	/**
	*<b>Summary: 设置说明</b>
	*/
	public void setMenu_remark(String menu_remark) {
		this.menu_remark = menu_remark;
	}
	/**
	*<b>Summary: 获取菜单标题父类id</b>
	*/
	public String getMenu_parentid() {
		return menu_parentid;
	}
	/**
	*<b>Summary: 设置菜单标题父类id</b>
	*/
	public void setMenu_parentid(String menu_parentid) {
		this.menu_parentid = menu_parentid;
	}
	/**
	*<b>Summary: 获取备用字段1</b>
	*/
	public String getRemark1() {
		return remark1;
	}
	/**
	*<b>Summary: 设置备用字段1</b>
	*/
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	/**
	*<b>Summary: 获取备用字段2</b>
	*/
	public String getRemark2() {
		return remark2;
	}
	/**
	*<b>Summary: 设置备用字段2</b>
	*/
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
}

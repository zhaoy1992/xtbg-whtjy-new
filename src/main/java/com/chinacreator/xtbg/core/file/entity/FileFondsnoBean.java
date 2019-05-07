package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FileFondsno.java</p>
 *<p>Description:档案全宗号Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-12
 */
public class FileFondsnoBean extends XtDbBaseBean{
	
	private String f_fonds_id;		//全宗号ID
	private String f_fondsno_name;		//全宗号名称
	private String f_fondsno;		//全宗号
	private String f_fonds_remark;		//备注
	private String f_fonds_order;		//排序号
	private String f_org_id;		//所属的单位ID
	private String f_org_name;		//所属单位名称
	private String f_dept_id;		//所属部门ID
	private String f_dept_name;		//所属部门名
	
	public FileFondsnoBean(){
		super("oa_file_fondsno","f_fonds_id");
	}
	/**
	*<b>Summary: 获取全宗号ID</b>
	*/
	public String getF_fonds_id() {
		return f_fonds_id;
	}
	/**
	*<b>Summary: 设置全宗号ID</b>
	*/
	public void setF_fonds_id(String f_fonds_id) {
		this.f_fonds_id = f_fonds_id;
	}
	/**
	*<b>Summary: 获取全宗号名称</b>
	*/
	public String getF_fondsno_name() {
		return f_fondsno_name;
	}
	/**
	*<b>Summary: 设置全宗号名称</b>
	*/
	public void setF_fondsno_name(String f_fondsno_name) {
		this.f_fondsno_name = f_fondsno_name;
	}
	/**
	*<b>Summary: 获取全宗号</b>
	*/
	public String getF_fondsno() {
		return f_fondsno;
	}
	/**
	*<b>Summary: 设置全宗号</b>
	*/
	public void setF_fondsno(String f_fondsno) {
		this.f_fondsno = f_fondsno;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getF_fonds_remark() {
		return f_fonds_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setF_fonds_remark(String f_fonds_remark) {
		this.f_fonds_remark = f_fonds_remark;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getF_fonds_order() {
		return f_fonds_order;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setF_fonds_order(String f_fonds_order) {
		this.f_fonds_order = f_fonds_order;
	}
	/**
	*<b>Summary: 获取所属的单位ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置所属的单位ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取所属单位名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置所属单位名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取所属部门名</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置所属部门名</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}

	
	
}

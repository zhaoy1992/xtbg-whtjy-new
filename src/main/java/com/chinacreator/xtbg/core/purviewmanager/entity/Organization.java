package com.chinacreator.xtbg.core.purviewmanager.entity;

import java.sql.Timestamp;

/**
 * 
 *<p>Title:Organization.java</p>
 *<p>Description:机构Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-17
 */
public class Organization {

	private String isdirectlyparty;		//是否直属局0-不是，缺省值1-是
	private String isforeignparty;		//是否涉外局0-是，缺省值1-不是
	private String isjichaparty;		//是否稽查局0-不是，缺省值1-是
	private String isdirectguanhu;		//是否直接管户单位0-不是，缺省值1-是
	private String org_id;		//机构ID
	private String org_sn;		//机构排序ID
	private String org_name;		//机构名称
	private String parent_id;		//父机构ID
	private String path;		//路径
	private String layer;		//层（阶次）
	private String children;		//子机构
	private String code;		//机构代号
	private String jp;		//简拼
	private String qp;		//全拼
	private Timestamp creatingtime;		//创建时间
	private String creator;		//创建人
	private String orgnumber;		//机构编号
	private String orgdesc;		//机构描述
	private String remark1;		//备用字段1
	private String remark2;		//备用字段2
	private String remark3;		//机构类型

	private String remark4;		//备用字段4
	private String remark5;		//机构显现名称
	private String chargeorgid;		//主管机构
	private String ispartybussiness;		//表示机构是否是业务部门0-是1-不是默认为1
	private String satrapjobid;		//主管岗位
	private String org_level;		//机构行政级别，1：省级，2：市州级，3：县区级，4：科所级
	private String org_xzqm;		//行政区码
	/**
	*<b>Summary: 获取是否直属局
	0-不是，缺省值
	1-是</b>
	*/
	public String getIsdirectlyparty() {
		return isdirectlyparty;
	}
	/**
	*<b>Summary: 设置是否直属局
	0-不是，缺省值
	1-是</b>
	*/
	public void setIsdirectlyparty(String isdirectlyparty) {
		this.isdirectlyparty = isdirectlyparty;
	}
	/**
	*<b>Summary: 获取是否涉外局
	0-是，缺省值
	1-不是</b>
	*/
	public String getIsforeignparty() {
		return isforeignparty;
	}
	/**
	*<b>Summary: 设置是否涉外局
	0-是，缺省值
	1-不是</b>
	*/
	public void setIsforeignparty(String isforeignparty) {
		this.isforeignparty = isforeignparty;
	}
	/**
	*<b>Summary: 获取是否稽查局
	0-不是，缺省值
	1-是</b>
	*/
	public String getIsjichaparty() {
		return isjichaparty;
	}
	/**
	*<b>Summary: 设置是否稽查局
	0-不是，缺省值
	1-是</b>
	*/
	public void setIsjichaparty(String isjichaparty) {
		this.isjichaparty = isjichaparty;
	}
	/**
	*<b>Summary: 获取是否直接管户单位
	0-不是，缺省值
	1-是</b>
	*/
	public String getIsdirectguanhu() {
		return isdirectguanhu;
	}
	/**
	*<b>Summary: 设置是否直接管户单位
	0-不是，缺省值
	1-是</b>
	*/
	public void setIsdirectguanhu(String isdirectguanhu) {
		this.isdirectguanhu = isdirectguanhu;
	}
	/**
	*<b>Summary: 获取机构ID</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置机构ID</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取机构排序ID</b>
	*/
	public String getOrg_sn() {
		return org_sn;
	}
	/**
	*<b>Summary: 设置机构排序ID</b>
	*/
	public void setOrg_sn(String org_sn) {
		this.org_sn = org_sn;
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
	*<b>Summary: 获取父机构ID</b>
	*/
	public String getParent_id() {
		return parent_id;
	}
	/**
	*<b>Summary: 设置父机构ID</b>
	*/
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	/**
	*<b>Summary: 获取路径</b>
	*/
	public String getPath() {
		return path;
	}
	/**
	*<b>Summary: 设置路径</b>
	*/
	public void setPath(String path) {
		this.path = path;
	}
	/**
	*<b>Summary: 获取层（阶次）</b>
	*/
	public String getLayer() {
		return layer;
	}
	/**
	*<b>Summary: 设置层（阶次）</b>
	*/
	public void setLayer(String layer) {
		this.layer = layer;
	}
	/**
	*<b>Summary: 获取子机构</b>
	*/
	public String getChildren() {
		return children;
	}
	/**
	*<b>Summary: 设置子机构</b>
	*/
	public void setChildren(String children) {
		this.children = children;
	}
	/**
	*<b>Summary: 获取机构代号</b>
	*/
	public String getCode() {
		return code;
	}
	/**
	*<b>Summary: 设置机构代号</b>
	*/
	public void setCode(String code) {
		this.code = code;
	}
	/**
	*<b>Summary: 获取简拼</b>
	*/
	public String getJp() {
		return jp;
	}
	/**
	*<b>Summary: 设置简拼</b>
	*/
	public void setJp(String jp) {
		this.jp = jp;
	}
	/**
	*<b>Summary: 获取全拼</b>
	*/
	public String getQp() {
		return qp;
	}
	/**
	*<b>Summary: 设置全拼</b>
	*/
	public void setQp(String qp) {
		this.qp = qp;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Timestamp getCreatingtime() {
		return creatingtime;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setCreatingtime(Timestamp creatingtime) {
		this.creatingtime = creatingtime;
	}
	/**
	*<b>Summary: 获取创建人</b>
	*/
	public String getCreator() {
		return creator;
	}
	/**
	*<b>Summary: 设置创建人</b>
	*/
	public void setCreator(String creator) {
		this.creator = creator;
	}
	/**
	*<b>Summary: 获取机构编号</b>
	*/
	public String getOrgnumber() {
		return orgnumber;
	}
	/**
	*<b>Summary: 设置机构编号</b>
	*/
	public void setOrgnumber(String orgnumber) {
		this.orgnumber = orgnumber;
	}
	/**
	*<b>Summary: 获取机构描述</b>
	*/
	public String getOrgdesc() {
		return orgdesc;
	}
	/**
	*<b>Summary: 设置机构描述</b>
	*/
	public void setOrgdesc(String orgdesc) {
		this.orgdesc = orgdesc;
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
	/**
	*<b>Summary: 获取机构类型
	</b>
	*/
	public String getRemark3() {
		return remark3;
	}
	/**
	*<b>Summary: 设置机构类型
	</b>
	*/
	public void setRemark3(String remark3) {
		this.remark3 = remark3;
	}
	/**
	*<b>Summary: 获取备用字段4</b>
	*/
	public String getRemark4() {
		return remark4;
	}
	/**
	*<b>Summary: 设置备用字段4</b>
	*/
	public void setRemark4(String remark4) {
		this.remark4 = remark4;
	}
	/**
	*<b>Summary: 获取机构显现名称</b>
	*/
	public String getRemark5() {
		return remark5;
	}
	/**
	*<b>Summary: 设置机构显现名称</b>
	*/
	public void setRemark5(String remark5) {
		this.remark5 = remark5;
	}
	/**
	*<b>Summary: 获取主管机构</b>
	*/
	public String getChargeorgid() {
		return chargeorgid;
	}
	/**
	*<b>Summary: 设置主管机构</b>
	*/
	public void setChargeorgid(String chargeorgid) {
		this.chargeorgid = chargeorgid;
	}
	/**
	*<b>Summary: 获取表示机构是否是业务部门
	0-是
	1-不是
	默认为1</b>
	*/
	public String getIspartybussiness() {
		return ispartybussiness;
	}
	/**
	*<b>Summary: 设置表示机构是否是业务部门
	0-是
	1-不是
	默认为1</b>
	*/
	public void setIspartybussiness(String ispartybussiness) {
		this.ispartybussiness = ispartybussiness;
	}
	/**
	*<b>Summary: 获取主管岗位</b>
	*/
	public String getSatrapjobid() {
		return satrapjobid;
	}
	/**
	*<b>Summary: 设置主管岗位</b>
	*/
	public void setSatrapjobid(String satrapjobid) {
		this.satrapjobid = satrapjobid;
	}
	/**
	*<b>Summary: 获取机构行政级别，1：省级，2：市州级，3：县区级，4：科所级</b>
	*/
	public String getOrg_level() {
		return org_level;
	}
	/**
	*<b>Summary: 设置机构行政级别，1：省级，2：市州级，3：县区级，4：科所级</b>
	*/
	public void setOrg_level(String org_level) {
		this.org_level = org_level;
	}
	/**
	*<b>Summary: 获取行政区码</b>
	*/
	public String getOrg_xzqm() {
		return org_xzqm;
	}
	/**
	*<b>Summary: 设置行政区码</b>
	*/
	public void setOrg_xzqm(String org_xzqm) {
		this.org_xzqm = org_xzqm;
	}
}

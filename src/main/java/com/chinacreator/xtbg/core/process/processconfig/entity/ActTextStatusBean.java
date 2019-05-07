package com.chinacreator.xtbg.core.process.processconfig.entity;

/**
 *<p>Title:ActTextStatusBean.java</p>
 *<p>Description:流程活动表正文状态控制表(环节字段状态表) oa_act_text_stauts</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-5-31
 */
public class ActTextStatusBean {
	private String id;//注释晚点加。。。。。
	private String action_id;
	private String is_trace;
	private String is_red;
	private String is_readonly;
	private String extend_attribute;
	private String extend_methods;
	
	private String is_msg;  //是否发送短信
	private String msg_txt; //add by shuqi.liu 短信规则
	private String is_sign; //是否可签名
	private String is_keeptrace; //是否保留痕迹
	private String is_attachment; //是否处理附件
	private String is_serialnumber; //是否可编号
	
	private String is_gwzl; //是否整理公文
	private String is_ckcg; //是否可以查看草稿
	private String is_ckzw; //是否可以查看正文
	private String is_ckmq; //是否可以查看面签
	private String is_singname; //是否签名
	private String is_affix; //是否可以盖章
	private String remark1; //扩展字段
	
	private String is_xd; //是否校对
	private String is_gwff; //是否分发公文
	private String is_cd; //是否存档
	private String is_cklc; //是否查看流程
	private String is_newflow; //是否能发起新的流程
	private String is_gk; //是否公开
	private String is_print;//是否打印
	private String is_split;//是否拆分指标文
	private String is_infotype;//是否信息分类
	private String is_nbfs;//内部分送
	private String is_doback;//回退
	private String is_chief;//督办
	private String is_ckls;//督办
	private String is_sm;//扫描仪
	
	public String getIs_sm() {
		return is_sm;
	}
	public void setIs_sm(String is_sm) {
		this.is_sm = is_sm;
	}
	public String getIs_ckls() {
		return is_ckls;
	}
	public void setIs_ckls(String is_ckls) {
		this.is_ckls = is_ckls;
	}
	public String getIs_chief() {
		return is_chief;
	}
	public void setIs_chief(String is_chief) {
		this.is_chief = is_chief;
	}
	public String getIs_doback() {
		return is_doback;
	}
	public void setIs_doback(String is_doback) {
		this.is_doback = is_doback;
	}
	public String getIs_nbfs() {
		return is_nbfs;
	}
	public void setIs_nbfs(String is_nbfs) {
		this.is_nbfs = is_nbfs;
	}
	public String getIs_print() {
		return is_print;
	}
	public void setIs_print(String is_print) {
		this.is_print = is_print;
	}
	public String getIs_split() {
		return is_split;
	}
	public void setIs_split(String is_split) {
		this.is_split = is_split;
	}
	public String getIs_infotype() {
		return is_infotype;
	}
	public void setIs_infotype(String is_infotype) {
		this.is_infotype = is_infotype;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_xd的值
	 * @return is_xd 
	 */
	public String getIs_xd() {
		return is_xd;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_xd 的值 
	 * @param is_xd 
	 */
	public void setIs_xd(String is_xd) {
		this.is_xd = is_xd;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_gwff的值
	 * @return is_gwff 
	 */
	public String getIs_gwff() {
		return is_gwff;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_gwff 的值 
	 * @param is_gwff 
	 */
	public void setIs_gwff(String is_gwff) {
		this.is_gwff = is_gwff;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_cd的值
	 * @return is_cd 
	 */
	public String getIs_cd() {
		return is_cd;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_cd 的值 
	 * @param is_cd 
	 */
	public void setIs_cd(String is_cd) {
		this.is_cd = is_cd;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_cklc的值
	 * @return is_cklc 
	 */
	public String getIs_cklc() {
		return is_cklc;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_cklc 的值 
	 * @param is_cklc 
	 */
	public void setIs_cklc(String is_cklc) {
		this.is_cklc = is_cklc;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_newflow的值
	 * @return is_newflow 
	 */
	public String getIs_newflow() {
		return is_newflow;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_newflow 的值 
	 * @param is_newflow 
	 */
	public void setIs_newflow(String is_newflow) {
		this.is_newflow = is_newflow;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_gk的值
	 * @return is_gk 
	 */
	public String getIs_gk() {
		return is_gk;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_gk 的值 
	 * @param is_gk 
	 */
	public void setIs_gk(String is_gk) {
		this.is_gk = is_gk;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_gwzl的值
	 * @return is_gwzl 
	 */
	public String getIs_gwzl() {
		return is_gwzl;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_gwzl 的值 
	 * @param is_gwzl 
	 */
	public void setIs_gwzl(String is_gwzl) {
		this.is_gwzl = is_gwzl;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_ckcg的值
	 * @return is_ckcg 
	 */
	public String getIs_ckcg() {
		return is_ckcg;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_ckcg 的值 
	 * @param is_ckcg 
	 */
	public void setIs_ckcg(String is_ckcg) {
		this.is_ckcg = is_ckcg;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_ckzw的值
	 * @return is_ckzw 
	 */
	public String getIs_ckzw() {
		return is_ckzw;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_ckzw 的值 
	 * @param is_ckzw 
	 */
	public void setIs_ckzw(String is_ckzw) {
		this.is_ckzw = is_ckzw;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_ckmq的值
	 * @return is_ckmq 
	 */
	public String getIs_ckmq() {
		return is_ckmq;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_ckmq 的值 
	 * @param is_ckmq 
	 */
	public void setIs_ckmq(String is_ckmq) {
		this.is_ckmq = is_ckmq;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_singname的值
	 * @return is_singname 
	 */
	public String getIs_singname() {
		return is_singname;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_singname 的值 
	 * @param is_singname 
	 */
	public void setIs_singname(String is_singname) {
		this.is_singname = is_singname;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_affix的值
	 * @return is_affix 
	 */
	public String getIs_affix() {
		return is_affix;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_affix 的值 
	 * @param is_affix 
	 */
	public void setIs_affix(String is_affix) {
		this.is_affix = is_affix;
	}
	/**
	 * <b>Summary: </b>
	 *     获取remark1的值
	 * @return remark1 
	 */
	public String getRemark1() {
		return remark1;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 remark1 的值 
	 * @param remark1 
	 */
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_msg的值
	 * @return is_msg 
	 */
	public String getIs_msg() {
		return is_msg;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_msg 的值 
	 * @param is_msg 
	 */
	public void setIs_msg(String is_msg) {
		this.is_msg = is_msg;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_sign的值
	 * @return is_sign 
	 */
	public String getIs_sign() {
		return is_sign;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_sign 的值 
	 * @param is_sign 
	 */
	public void setIs_sign(String is_sign) {
		this.is_sign = is_sign;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_keeptrace的值
	 * @return is_keeptrace 
	 */
	public String getIs_keeptrace() {
		return is_keeptrace;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_keeptrace 的值 
	 * @param is_keeptrace 
	 */
	public void setIs_keeptrace(String is_keeptrace) {
		this.is_keeptrace = is_keeptrace;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_attachment的值
	 * @return is_attachment 
	 */
	public String getIs_attachment() {
		return is_attachment;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_attachment 的值 
	 * @param is_attachment 
	 */
	public void setIs_attachment(String is_attachment) {
		this.is_attachment = is_attachment;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_serialnumber的值
	 * @return is_serialnumber 
	 */
	public String getIs_serialnumber() {
		return is_serialnumber;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_serialnumber 的值 
	 * @param is_serialnumber 
	 */
	public void setIs_serialnumber(String is_serialnumber) {
		this.is_serialnumber = is_serialnumber;
	}
	public String getMsg_txt() {
		return msg_txt;
	}
	public void setMsg_txt(String msg_txt) {
		this.msg_txt = msg_txt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAction_id() {
		return action_id;
	}
	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}
	public String getIs_trace() {
		return is_trace;
	}
	public void setIs_trace(String is_trace) {
		this.is_trace = is_trace;
	}
	public String getIs_red() {
		return is_red;
	}
	public void setIs_red(String is_red) {
		this.is_red = is_red;
	}
	public String getIs_readonly() {
		return is_readonly;
	}
	public void setIs_readonly(String is_readonly) {
		this.is_readonly = is_readonly;
	}
	public String getExtend_attribute() {
		return extend_attribute;
	}
	public void setExtend_attribute(String extend_attribute) {
		this.extend_attribute = extend_attribute;
	}
	public String getExtend_methods() {
		return extend_methods;
	}
	public void setExtend_methods(String extend_methods) {
		this.extend_methods = extend_methods;
	}
	
}

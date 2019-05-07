package com.chinacreator.xtbg.core.inspect.entity;

import java.text.ParseException;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:InspectBaseInfoBean.java</p>
 *<p>Description:督查督办基本信息javabean</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectBaseInfoBean extends XtDbBaseBean{
	public InspectBaseInfoBean(){
		super("oa_inspect_baseinfo","info_id");
	}
	private String info_id;		//信息主键
	private String inspect_name;		//名称
	private String inspect_type;		//任务类型
	private String content;		//正文
	private String inspect_state;		//状态
	private Object create_time;		//任务创建时间
	private Object send_time;		//交办时间
	private Object plan_endtime;		//指定完成期限
	private Object remind_time;		//催办提醒时间
	private String remind_content;		//催办提醒内容
	private String recept_orgids;		//办理单位id集合
	private String recept_orgnames;		//办理单位名称集合
	private String send_user_id;		//发起人id
	private String send_user_name;		//发起人姓名
	private String user_orgid;		//用户所在单位id
	private String user_orgname;		//用户所在单位名称
	private String attach_id;		//与附件表的关联id
	private String is_sms;		//是否短信(1是,0否)
	private String is_msg;		//是否站内消息(1是,0否)
	private String is_rtx;		//是否及时消息(1是,0否)
	private String is_mail;		//是否邮件(1是,0否)
	private String is_report;//是否上报（1是，其他否）
	/**
	*<b>Summary: 获取信息主键</b>
	*/
	public String getInfo_id() {
		return info_id;
	}
	/**
	*<b>Summary: 设置信息主键</b>
	*/
	public void setInfo_id(String info_id) {
		this.info_id = info_id;
	}
	/**
	*<b>Summary: 获取名称</b>
	*/
	public String getInspect_name() {
		return inspect_name;
	}
	/**
	*<b>Summary: 设置名称</b>
	*/
	public void setInspect_name(String inspect_name) {
		this.inspect_name = inspect_name;
	}
	/**
	*<b>Summary: 获取任务类型</b>
	*/
	public String getInspect_type() {
		return inspect_type;
	}
	/**
	*<b>Summary: 设置任务类型</b>
	*/
	public void setInspect_type(String inspect_type) {
		this.inspect_type = inspect_type;
	}
	/**
	*<b>Summary: 获取正文</b>
	*/
	public String getContent() {
		return content;
	}
	/**
	*<b>Summary: 设置正文</b>
	*/
	public void setContent(String content) {
		this.content = content;
	}
	/**
	*<b>Summary: 获取状态</b>
	*/
	public String getInspect_state() {
		return inspect_state;
	}
	/**
	*<b>Summary: 设置状态</b>
	*/
	public void setInspect_state(String inspect_state) {
		this.inspect_state = inspect_state;
	}
	/**
	*<b>Summary: 获取任务创建时间</b>
	*/
	public Object getCreate_time() {
		return create_time;
	}
	/**
	*<b>Summary: 设置任务创建时间</b>
	*/
	public void setCreate_time(Object create_time) {
		this.create_time = create_time;
	}
	/**
	*<b>Summary: 获取交办时间</b>
	*/
	public Object getSend_time() {
		return send_time;
	}
	/**
	*<b>Summary: 设置交办时间</b>
	*/
	public void setSend_time(Object send_time) {
		this.send_time = send_time;
	}
	/**
	*<b>Summary: 获取指定完成期限</b>
	*/
	public Object getPlan_endtime() {
		return plan_endtime;
	}
	/**
	*<b>Summary: 设置指定完成期限</b>
	*/
	public void setPlan_endtime(Object plan_endtime) {
		this.plan_endtime = plan_endtime;
	}
	/**
	*<b>Summary: 获取催办提醒时间</b>
	*/
	public Object getRemind_time() {
		return remind_time;
	}
	/**
	*<b>Summary: 设置催办提醒时间</b>
	*/
	public void setRemind_time(Object remind_time) {
		this.remind_time = remind_time;
	}
	/**
	*<b>Summary: 获取催办提醒内容</b>
	*/
	public String getRemind_content() {
		return remind_content;
	}
	/**
	*<b>Summary: 设置催办提醒内容</b>
	*/
	public void setRemind_content(String remind_content) {
		this.remind_content = remind_content;
	}
	/**
	*<b>Summary: 获取办理单位id集合</b>
	*/
	public String getRecept_orgids() {
		return recept_orgids;
	}
	/**
	*<b>Summary: 设置办理单位id集合</b>
	*/
	public void setRecept_orgids(String recept_orgids) {
		this.recept_orgids = recept_orgids;
	}
	/**
	*<b>Summary: 获取办理单位名称集合</b>
	*/
	public String getRecept_orgnames() {
		return recept_orgnames;
	}
	/**
	*<b>Summary: 设置办理单位名称集合</b>
	*/
	public void setRecept_orgnames(String recept_orgnames) {
		this.recept_orgnames = recept_orgnames;
	}
	/**
	*<b>Summary: 获取发起人id</b>
	*/
	public String getSend_user_id() {
		return send_user_id;
	}
	/**
	*<b>Summary: 设置发起人id</b>
	*/
	public void setSend_user_id(String send_user_id) {
		this.send_user_id = send_user_id;
	}
	/**
	*<b>Summary: 获取发起人姓名</b>
	*/
	public String getSend_user_name() {
		return send_user_name;
	}
	/**
	*<b>Summary: 设置发起人姓名</b>
	*/
	public void setSend_user_name(String send_user_name) {
		this.send_user_name = send_user_name;
	}
	/**
	*<b>Summary: 获取用户所在单位id</b>
	*/
	public String getUser_orgid() {
		return user_orgid;
	}
	/**
	*<b>Summary: 设置用户所在单位id</b>
	*/
	public void setUser_orgid(String user_orgid) {
		this.user_orgid = user_orgid;
	}
	/**
	*<b>Summary: 获取用户所在单位名称</b>
	*/
	public String getUser_orgname() {
		return user_orgname;
	}
	/**
	*<b>Summary: 设置用户所在单位名称</b>
	*/
	public void setUser_orgname(String user_orgname) {
		this.user_orgname = user_orgname;
	}
	/**
	*<b>Summary: 获取与附件表的关联id</b>
	*/
	public String getAttach_id() {
		return attach_id;
	}
	/**
	*<b>Summary: 设置与附件表的关联id</b>
	*/
	public void setAttach_id(String attach_id) {
		this.attach_id = attach_id;
	}
	/**
	*<b>Summary: 获取是否短信(1是,0否)</b>
	*/
	public String getIs_sms() {
		return is_sms;
	}
	/**
	*<b>Summary: 设置是否短信(1是,0否)</b>
	*/
	public void setIs_sms(String is_sms) {
		this.is_sms = is_sms;
	}
	/**
	*<b>Summary: 获取是否站内消息(1是,0否)</b>
	*/
	public String getIs_msg() {
		return is_msg;
	}
	/**
	*<b>Summary: 设置是否站内消息(1是,0否)</b>
	*/
	public void setIs_msg(String is_msg) {
		this.is_msg = is_msg;
	}
	/**
	*<b>Summary: 获取是否及时消息(1是,0否)</b>
	*/
	public String getIs_rtx() {
		return is_rtx;
	}
	/**
	*<b>Summary: 设置是否及时消息(1是,0否)</b>
	*/
	public void setIs_rtx(String is_rtx) {
		this.is_rtx = is_rtx;
	}
	/**
	*<b>Summary: 获取是否邮件(1是,0否)</b>
	*/
	public String getIs_mail() {
		return is_mail;
	}
	/**
	*<b>Summary: 设置是否邮件(1是,0否)</b>
	*/
	public void setIs_mail(String is_mail) {
		this.is_mail = is_mail;
	}
	
	public String getIs_report() {
		return is_report;
	}
	public void setIs_report(String isReport) {
		is_report = isReport;
	}
	/**
	 * 
	*<b>Summary: 将日期字符串转换为Timestamp</b>
	* convertToTimestamp()
	* @return
	* @throws ParseException
	 */
	public InspectBaseInfoBean convertToTimestamp() throws ParseException {
		// 将时间字符串转换为Timestamp对象
		Object createTime = this.getCreate_time();
		if (!StringUtil.nullOrBlank(createTime)) {
			this
					.setCreate_time(StringUtil
							.convertStringToTimestamp(createTime));
		} else {
			this.setCreate_time(null);
		}
		Object sendTime = this.getSend_time();
		if (!StringUtil.nullOrBlank(sendTime)) {
			this.setSend_time(StringUtil.convertStringToTimestamp(sendTime));
		} else {
			this.setSend_time(null);
		}
		Object planEndtime = this.getPlan_endtime();
		if (!StringUtil.nullOrBlank(planEndtime)) {
			this.setPlan_endtime(StringUtil
					.convertStringToTimestamp(planEndtime));
		} else {
			this.setPlan_endtime(null);
		}
		Object remindTime = this.getRemind_time();
		if (!StringUtil.nullOrBlank(remindTime)) {
			this
					.setRemind_time(StringUtil
							.convertStringToTimestamp(remindTime));
		} else {
			this.setRemind_time(null);
		}
		return this;
	}
}

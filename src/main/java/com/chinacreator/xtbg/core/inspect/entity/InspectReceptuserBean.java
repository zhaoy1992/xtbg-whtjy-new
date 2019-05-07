package com.chinacreator.xtbg.core.inspect.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:InspectReceptuserBean.java</p>
 *<p>Description:督查督办通知接收用户bean（防止一个单位配置多个用户而采用）</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectReceptuserBean  extends XtDbBaseBean{
    public InspectReceptuserBean(){
    	super("oa_inspect_receptuser","id");
    }
    public InspectReceptuserBean(String key){
    	super("oa_inspect_receptuser",key);
    }
    private String id;		//主键
    private String recept_id;		//接收主键
    private String recept_userid;	//接收人id
    private String recept_username;	//接收人姓名
    private String phone;		//接收人电话号码
    private String email;		//接收人个人邮箱（预留字段）
    private String temp;		//备用字段
    private String info_id;     //任务id
    /**
    *<b>Summary: 获取主键</b>
    */
    public String getId() {
    	return id;
    }
    /**
    *<b>Summary: 设置主键</b>
    */
    public void setId(String id) {
    	this.id = id;
    }
    /**
    *<b>Summary: 获取接收主键</b>
    */
    public String getRecept_id() {
    	return recept_id;
    }
    /**
    *<b>Summary: 设置接收主键</b>
    */
    public void setRecept_id(String recept_id) {
    	this.recept_id = recept_id;
    }
    /**
    *<b>Summary: 获取接收人id</b>
    */
    public String getRecept_userid() {
    	return recept_userid;
    }
    /**
    *<b>Summary: 设置接收人id</b>
    */
    public void setRecept_userid(String recept_userid) {
    	this.recept_userid = recept_userid;
    }
    /**
    *<b>Summary: 获取接收人姓名</b>
    */
    public String getRecept_username() {
    	return recept_username;
    }
    /**
    *<b>Summary: 设置接收人姓名</b>
    */
    public void setRecept_username(String recept_username) {
    	this.recept_username = recept_username;
    }
    /**
    *<b>Summary: 获取接收人电话号码</b>
    */
    public String getPhone() {
    	return phone;
    }
    /**
    *<b>Summary: 设置接收人电话号码</b>
    */
    public void setPhone(String phone) {
    	this.phone = phone;
    }
    /**
    *<b>Summary: 获取接收人个人邮箱（预留字段）</b>
    */
    public String getEmail() {
    	return email;
    }
    /**
    *<b>Summary: 设置接收人个人邮箱（预留字段）</b>
    */
    public void setEmail(String email) {
    	this.email = email;
    }
    /**
    *<b>Summary: 获取备用字段</b>
    */
    public String getTemp() {
    	return temp;
    }
    /**
    *<b>Summary: 设置备用字段</b>
    */
    public void setTemp(String temp) {
    	this.temp = temp;
    }
	public String getInfo_id() {
		return info_id;
	}
	public void setInfo_id(String infoId) {
		info_id = infoId;
	}

}

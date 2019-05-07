package com.chinacreator.xtbg.tjy.device.entity;
/**
 *<p>Title:DevSubjectRecordBean.java</p>
 *<p>Description:仪器设备标对记录表bean</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author AutoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public class DevSubjectRecordBean { 
    private String sub_id;    //主键ID
    private String t_sb_id;    //设备ID
    private String sub_name;    //标样名称
    private String sub_result;    //标对结果
    private String remark;    //备注
    
    private String dev_code; //设备编号
    private String dev_name; //设备名称
    private Object creator_time;//标对时间

    /**
     * <b>Summary: 获取主键ID</b>
     */
    public String getSub_id() {
	    return sub_id;
    }
    /**
     * <b>Summary: 设置主键ID</b>
     */
    public void setSub_id(String sub_id) {
	    this.sub_id = sub_id;
    }
    /**
     * <b>Summary: 获取设备ID</b>
     */
    public String getT_sb_id() {
	    return t_sb_id;
    }
    /**
     * <b>Summary: 设置设备ID</b>
     */
    public void setT_sb_id(String t_sb_id) {
	    this.t_sb_id = t_sb_id;
    }
    /**
     * <b>Summary: 获取标样名称</b>
     */
    public String getSub_name() {
	    return sub_name;
    }
    /**
     * <b>Summary: 设置标样名称</b>
     */
    public void setSub_name(String sub_name) {
	    this.sub_name = sub_name;
    }
    /**
     * <b>Summary: 获取标对结果</b>
     */
    public String getSub_result() {
	    return sub_result;
    }
    /**
     * <b>Summary: 设置标对结果</b>
     */
    public void setSub_result(String sub_result) {
	    this.sub_result = sub_result;
    }
    /**
     * <b>Summary: 获取备注</b>
     */
    public String getRemark() {
	    return remark;
    }
    /**
     * <b>Summary: 设置备注</b>
     */
    public void setRemark(String remark) {
	    this.remark = remark;
    }
	public String getDev_code() {
		return dev_code;
	}
	public void setDev_code(String dev_code) {
		this.dev_code = dev_code;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public Object getCreator_time() {
		return creator_time;
	}
	public void setCreator_time(Object creator_time) {
		this.creator_time = creator_time;
	}
}
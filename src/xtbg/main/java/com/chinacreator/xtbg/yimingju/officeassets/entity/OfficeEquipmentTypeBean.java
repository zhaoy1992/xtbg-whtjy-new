package com.chinacreator.xtbg.yimingju.officeassets.entity;
/**
 *<p>Title:OfficeEquipmentTypeBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *@date 2012-3-7
 */

public class OfficeEquipmentTypeBean {
	private String oetype_id;//设备类型id
	
	private String oetype_name;//设备类型名称
	
	private Integer oetype_no;//排序号
	
	private String oetype_remark;//备注

	public String getOetype_id() {
		return oetype_id;
	}

	public void setOetype_id(String oetype_id) {
		this.oetype_id = oetype_id;
	}

	public String getOetype_name() {
		return oetype_name;
	}

	public void setOetype_name(String oetype_name) {
		this.oetype_name = oetype_name;
	}

	public Integer getOetype_no() {
		return oetype_no;
	}

	public void setOetype_no(Integer oetype_no) {
		this.oetype_no = oetype_no;
	}

	public String getOetype_remark() {
		return oetype_remark;
	}

	public void setOetype_remark(String oetype_remark) {
		this.oetype_remark = oetype_remark;
	}
	
}

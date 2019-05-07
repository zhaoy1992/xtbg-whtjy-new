package com.chinacreator.xtbg.tjy.officesupplies.entity;
/**
 * 固定资产使用管理物品清单表
 * @author 王淑滨
 *
 */
public class OsAccountDetails {
	   private String id;//主键id
	   private String m_id;//管理表id
	   private String internal_no;//内部编号
	   private String gdzc_num;//编号
	   private String gdzc_id;//固定资产id
	   private String gdzc_name;//资产名称
	   private String bar_code;//条形码
	   private String body_no;//机身号
	   private String state;//状态
	   
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String mId) {
		m_id = mId;
	}
	public String getInternal_no() {
		return internal_no;
	}
	public void setInternal_no(String internalNo) {
		internal_no = internalNo;
	}
	public String getGdzc_num() {
		return gdzc_num;
	}
	public void setGdzc_num(String gdzcNum) {
		gdzc_num = gdzcNum;
	}
	public String getGdzc_id() {
		return gdzc_id;
	}
	public void setGdzc_id(String gdzcId) {
		gdzc_id = gdzcId;
	}
	public String getGdzc_name() {
		return gdzc_name;
	}
	public void setGdzc_name(String gdzcName) {
		gdzc_name = gdzcName;
	}
	public String getBar_code() {
		return bar_code;
	}
	public void setBar_code(String barCode) {
		bar_code = barCode;
	}
	public String getBody_no() {
		return body_no;
	}
	public void setBody_no(String bodyNo) {
		body_no = bodyNo;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	   
	   
}

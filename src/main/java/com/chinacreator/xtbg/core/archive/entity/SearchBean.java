package com.chinacreator.xtbg.core.archive.entity;

public class SearchBean {
	private String workTitle;//主题
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String zsorg;//主送单位
	private String ngorg;//拟稿单位
	private String fwnumber;//发文编号
	private String count_type;//公文类型:收文或发文或其他
	private String user_id;//用户id
	//特检验OA 2014-06-09 start 只查询发文数据
	private String busitype_type_code;//类型分类编码
	//特检验OA 2014-06-09 end
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCount_type() {
		return count_type;
	}
	public void setCount_type(String count_type) {
		this.count_type = count_type;
	}
	public String getFwnumber() {
		return fwnumber;
	}
	public void setFwnumber(String fwnumber) {
		this.fwnumber = fwnumber;
	}
	public String getWorkTitle() {
		return workTitle;
	}
	public void setWorkTitle(String workTitle) {
		this.workTitle = workTitle;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getZsorg() {
		return zsorg;
	}
	public void setZsorg(String zsorg) {
		this.zsorg = zsorg;
	}
	public String getNgorg() {
		return ngorg;
	}
	public void setNgorg(String ngorg) {
		this.ngorg = ngorg;
	}
	public String getBusitype_type_code() {
		return busitype_type_code;
	}
	public void setBusitype_type_code(String busitype_type_code) {
		this.busitype_type_code = busitype_type_code;
	}
	
}

package com.chinacreator.xtbg.zhangjiajie.inforeported.entity;

/**
 *<p>Title:ReleaseunitBean.java</p>
 *<p>Description:发布栏目设置</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-21
 */
public class ReleaseunitBean {
	
	private String releaseunit_id; //栏目id
	
	private String infotype_id; //类型id
	
	private String infotype_name; //类型名称

	private String rec_personid; //接收人id
	
	private String rec_person_name; //接收人名称
	
	private String user_id; //创建人
	
	private String create_time; //创建时间
	
	private String releaseunit_name; //栏目名称
	
	
	
	public String getReleaseunit_id() {
		return releaseunit_id;
	}

	public void setReleaseunit_id(String releaseunit_id) {
		this.releaseunit_id = releaseunit_id;
	}

	public String getInfotype_id() {
		return infotype_id;
	}

	public void setInfotype_id(String infotype_id) {
		this.infotype_id = infotype_id;
	}

	public String getInfotype_name() {
		return infotype_name;
	}

	public void setInfotype_name(String infotype_name) {
		this.infotype_name = infotype_name;
	}
	
	public String getRec_personid() {
		return rec_personid;
	}

	public void setRec_personid(String rec_personid) {
		this.rec_personid = rec_personid;
	}

	public String getRec_person_name() {
		return rec_person_name;
	}

	public void setRec_person_name(String rec_person_name) {
		this.rec_person_name = rec_person_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getReleaseunit_name() {
		return releaseunit_name;
	}

	public void setReleaseunit_name(String releaseunit_name) {
		this.releaseunit_name = releaseunit_name;
	}

	

}

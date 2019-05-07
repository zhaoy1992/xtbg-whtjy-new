package com.chinacreator.xtbg.suxian.electroniccheck.entity;
/**
 *<p>Title:AnnouncementBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *@date 2012-2-2
 */

public class AnnouncementBean {
	private String ggbh;//公告编号
	
	private String yxsj;//有效时间
	
	private String yxsjs;
	
	private String yxsje;
	
	private String qcsj;//起草时间
	
	private String qcsjs;
	
	private String qcsje;
	private String ggbt;//公告标题
	
	private String fbr;//发布人
	
	private String nr;//内容
	
	private String authorid;//作者id
	
	private String author;//作者
	
	private String kckyhid;//可查看用户id
	
	private String kckyh;//可查看用户
	
	private String kckjgid;//可查看机构id
	
	private String kckjg;//可查看机构
	
	private String ggzt;//公告状态
	
	private String fbrid;//发布人id
	
	private String fbsj;//发布时间
	
	private String fbsjs;
	
	private String fbsje;
	
	private String state;//状态
	
	private String ckzt;//查看状态
	
	private String userid;//当前用户
	
	private String orgname;//当前用户机构
	
	private String orgid;//当前用户机构id
	
	private String count;//附件数量
	private String isorg;//是否单位名义
	private String deptid;//单位id
	private String deptname;//单位名称
	private String release_status;
	private String is_phone_send;//是否手机端发送是Y
	
	private String attach_id;//附件id
	
	
    public String getIs_phone_send() {
		return is_phone_send;
	}

	public void setIs_phone_send(String is_phone_send) {
		this.is_phone_send = is_phone_send;
	}

	public String getAttach_id() {
		return attach_id;
	}

	public void setAttach_id(String attach_id) {
		this.attach_id = attach_id;
	}

	private String ewebeditor_content_phone;//手机预览内容
	
	public String getEwebeditor_content_phone() {
		return ewebeditor_content_phone;
	}

	public void setEwebeditor_content_phone(String ewebeditorContentPhone) {
		ewebeditor_content_phone = ewebeditorContentPhone;
	}

	public String getRelease_status() {
		return release_status;
	}

	public void setRelease_status(String release_status) {
		this.release_status = release_status;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public String getIsorg() {
		return isorg;
	}

	public void setIsorg(String isorg) {
		this.isorg = isorg;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getCkzt() {
		return ckzt;
	}

	public void setCkzt(String ckzt) {
		this.ckzt = ckzt;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getYxsjs() {
		return yxsjs;
	}

	public void setYxsjs(String yxsjs) {
		this.yxsjs = yxsjs;
	}

	public String getYxsje() {
		return yxsje;
	}

	public void setYxsje(String yxsje) {
		this.yxsje = yxsje;
	}

	public String getQcsjs() {
		return qcsjs;
	}

	public void setQcsjs(String qcsjs) {
		this.qcsjs = qcsjs;
	}

	public String getQcsje() {
		return qcsje;
	}

	public void setQcsje(String qcsje) {
		this.qcsje = qcsje;
	}


	
	public String getFbsjs() {
		return fbsjs;
	}

	public void setFbsjs(String fbsjs) {
		this.fbsjs = fbsjs;
	}

	public String getFbsje() {
		return fbsje;
	}

	public void setFbsje(String fbsje) {
		this.fbsje = fbsje;
	}

	private String fj;//附件
	
	private String remark1;//备用1
	
	private String remark2;//备用2
	

	private String spr;//审批人
	
	private String sprid;//审批人id
	
	public String getGgbh() {
		return ggbh;
	}

	public void setGgbh(String ggbh) {
		this.ggbh = ggbh;
	}

	public String getYxsj() {
		return yxsj;
	}

	public void setYxsj(String yxsj) {
		this.yxsj = yxsj;
	}

	public String getQcsj() {
		return qcsj;
	}

	public void setQcsj(String qcsj) {
		this.qcsj = qcsj;
	}

	public String getGgbt() {
		return ggbt;
	}

	public void setGgbt(String ggbt) {
		this.ggbt = ggbt;
	}

	public String getFbr() {
		return fbr;
	}

	public void setFbr(String fbr) {
		this.fbr = fbr;
	}

	public String getNr() {
		return nr;
	}

	public void setNr(String nr) {
		this.nr = nr;
	}

	public String getAuthorid() {
		return authorid;
	}

	public void setAuthorid(String authorid) {
		this.authorid = authorid;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getKckyhid() {
		return kckyhid;
	}

	public void setKckyhid(String kckyhid) {
		this.kckyhid = kckyhid;
	}

	public String getKckyh() {
		return kckyh;
	}

	public void setKckyh(String kckyh) {
		this.kckyh = kckyh;
	}

	public String getKckjgid() {
		return kckjgid;
	}

	public void setKckjgid(String kckjgid) {
		this.kckjgid = kckjgid;
	}

	public String getKckjg() {
		return kckjg;
	}

	public void setKckjg(String kckjg) {
		this.kckjg = kckjg;
	}

	public String getGgzt() {
		return ggzt;
	}

	public void setGgzt(String ggzt) {
		this.ggzt = ggzt;
	}

	public String getFbrid() {
		return fbrid;
	}

	public void setFbrid(String fbrid) {
		this.fbrid = fbrid;
	}

	public String getFbsj() {
		return fbsj;
	}

	public void setFbsj(String fbsj) {
		this.fbsj = fbsj;
	}

	public String getFj() {
		return fj;
	}

	public void setFj(String fj) {
		this.fj = fj;
	}

	public String getRemark1() {
		return remark1;
	}

	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}

	public String getRemark2() {
		return remark2;
	}

	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}

	

	public String getSpr() {
		return spr;
	}

	public void setSpr(String spr) {
		this.spr = spr;
	}

	public String getSprid() {
		return sprid;
	}

	public void setSprid(String sprid) {
		this.sprid = sprid;
	}
	
	
}

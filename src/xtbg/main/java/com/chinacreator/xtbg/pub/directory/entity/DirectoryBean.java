package com.chinacreator.xtbg.pub.directory.entity;
/**
 *<p>Title:DirectoryBean.java</p>
 *<p>Description:名录信息Bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *@date 2012-2-16
 */
public class DirectoryBean {
	private String directoryid;//名录id
	
	private String directoryname;//姓名
	
	private String directoryyear;//出生年月
	
	private String directorysex;//性别
	
	private String directorystate;//在职状态
	
	private String education;//学历
	
	private String degree;//学位
	
	private String seniority;//工龄
	
	private String school;//毕业院校
	
	private String nation;//民族
	
	private String politics;//政治面貌
	
	private String natives;//籍贯
	
	private String specialty;//所学专业
	
	private String mobile;//常用手机
	
	private String mobile2;//常用手机
	
	private String homeadress;//家庭地址
	
	private String workphone;//办公电话
	
	private String workadress;//办公地址
	
	private String homephone;//家庭电话
	
	private String email;//电子邮箱
	
	private String duty;//工作职责
	
	private String resume;//个人简介
	
	private String orgid;
	
	private String org_code;//机构编码remark1
	
	private String orgname;
	
	private String duties;//职务
	
	private String eng_name;//姓名拼音
	
	private String idnumber;//身份证
	
	private String worktime;//参加工作时间
	
	private String joinparttime;//入党时间
	
	private String post;//职务
	
	private String directorylevel;//级别
	
	private String department;//所在科室
	
	private String directory_sn;//名录排序
	
	private String likevalue;//模糊查询值

	private String nameindex;//姓名首字母
	
	private String userid;//登陆用户id
	
	private String ishasviewrole;//是否拥有查看权限
	
	private String listtype;//列表类型
	
	private String portalandoa_id;//门户与OA用户对应字段
	
	private String numberone;//是否党政一把手
	
	private byte[] photo;//用户图片
	
	private String deptId;
	private String deptName;
	//手机短码
	private String remark2;//手机短码
	
	
	
	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getOrg_code() {
		return org_code;
	}

	public void setOrg_code(String orgCode) {
		org_code = orgCode;
	}

	public String getPortalandoa_id() {
		return portalandoa_id;
	}

	public void setPortalandoa_id(String portalandoaId) {
		portalandoa_id = portalandoaId;
	}

	public String getListtype() {
		return listtype;
	}

	public void setListtype(String listtype) {
		this.listtype = listtype;
	}

	public String getIshasviewrole() {
		return ishasviewrole;
	}

	public void setIshasviewrole(String ishasviewrole) {
		this.ishasviewrole = ishasviewrole;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getLikevalue() {
		return likevalue;
	}

	public void setLikevalue(String likevalue) {
		this.likevalue = likevalue;
	}

	public String getNameindex() {
		return nameindex;
	}

	public void setNameindex(String nameindex) {
		this.nameindex = nameindex;
	}

	public String getDirectory_sn() {
		return directory_sn;
	}

	public void setDirectory_sn(String directorySn) {
		directory_sn = directorySn;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getIdnumber() {
		return idnumber;
	}

	public void setIdnumber(String idnumber) {
		this.idnumber = idnumber;
	}

	public String getWorktime() {
		return worktime;
	}

	public void setWorktime(String worktime) {
		this.worktime = worktime;
	}

	public String getJoinparttime() {
		return joinparttime;
	}

	public void setJoinparttime(String joinparttime) {
		this.joinparttime = joinparttime;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getDirectorylevel() {
		return directorylevel;
	}

	public void setDirectorylevel(String directorylevel) {
		this.directorylevel = directorylevel;
	}

	public String getEng_name() {
		return eng_name;
	}

	public void setEng_name(String engName) {
		eng_name = engName;
	}

	public String getDuties() {
		return duties;
	}

	public void setDuties(String duties) {
		this.duties = duties;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getDirectoryid() {
		return directoryid;
	}

	public void setDirectoryid(String directoryid) {
		this.directoryid = directoryid;
	}

	public String getDirectoryname() {
		return directoryname;
	}

	public void setDirectoryname(String directoryname) {
		this.directoryname = directoryname;
	}

	public String getDirectoryyear() {
		return directoryyear;
	}

	public void setDirectoryyear(String directoryyear) {
		this.directoryyear = directoryyear;
	}

	public String getDirectorysex() {
		return directorysex;
	}

	public void setDirectorysex(String directorysex) {
		this.directorysex = directorysex;
	}

	public String getDirectorystate() {
		return directorystate;
	}

	public void setDirectorystate(String directorystate) {
		this.directorystate = directorystate;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getSeniority() {
		return seniority;
	}

	public void setSeniority(String seniority) {
		this.seniority = seniority;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getPolitics() {
		return politics;
	}

	public void setPolitics(String politics) {
		this.politics = politics;
	}

	public String getNatives() {
		return natives;
	}

	public void setNatives(String natives) {
		this.natives = natives;
	}

	public String getSpecialty() {
		return specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMobile2() {
		return mobile2;
	}

	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	public String getHomeadress() {
		return homeadress;
	}

	public void setHomeadress(String homeadress) {
		this.homeadress = homeadress;
	}

	public String getWorkphone() {
		return workphone;
	}

	public void setWorkphone(String workphone) {
		this.workphone = workphone;
	}

	public String getWorkadress() {
		return workadress;
	}

	public void setWorkadress(String workadress) {
		this.workadress = workadress;
	}

	public String getHomephone() {
		return homephone;
	}

	public void setHomephone(String homephone) {
		this.homephone = homephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getNumberone() {
		return numberone;
	}

	public void setNumberone(String numberone) {
		this.numberone = numberone;
	}

	public String getRemark2() {
		return remark2;
	}

	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
}

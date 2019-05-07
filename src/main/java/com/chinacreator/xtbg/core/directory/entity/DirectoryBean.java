package com.chinacreator.xtbg.core.directory.entity;
/**
 *<p>Title:DirectoryBean.java</p>
 *<p>Description:名录信息Bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
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
	
	private String orgUserMan;//是否是部门管理员
	
	private String remark4;
	
	private String remark5;
	
	private String new_user_type;		//人员类别
	private String new_job_state;		//在岗状态
	private String new_job_no;		//职工工号
	private String new_job_set;		//岗位设置
	private String new_join_zzdate;		//参加组织日期
	private String new_in_hosb;		//入院时间
	private String new_toother_date;		//借调时间
	private String new_first_xingshi;		//学习形式(第一学历)
	private String new_first_zy;		//专业(第一学历)
	private String new_first_bydate;		//毕业时间(第一学历)
	private String new_zg_byyx;		//毕业院校(最高学历)
	private String new_zg_xl;		//学历(最高学历)
	private String new_zg_xw;		//学位(最高学历)
	private String new_zg_xingshi;		//学习形式(最高学历)
	private String new_zg_zy;		//专业(最高学历)
	private String new_jb_zy;		//专业级别(最高学历)
	private String new_zg_bydate;		//毕业时间(最高学历)
	private String new_jszc;		//技术职称
	private String new_zc_getdate;		//职称获取时间
	private String new_zc_pydate;		//职称聘任时间
	private String persionHold_name;//持证项目
	
	private String hetong_nowsend_date1;		//现合同终止期起始时间
	private String hetong_tryend_date1;		//合同试用终止期起始时间
	private String hetong_nowsend_date2;		//现合同终止期截止时间
	private String hetong_tryend_date2;		//合同试用终止期截止时间
	
	private String hetong_nowsend_date;		//现合同终止期 (用于带回数据)
	private String hetong_tryend_date;		//合同试用终止期(用于带回数据)
	
	//特检院 OA  人员信息中的薪酬信息
	private String new_xc_gwgz;//岗位工资
	private String new_xc_xjgz;//薪级工资
	private String new_xc_yfgz;//应发合计
	private String new_xc_yb;//医保
	private String new_xc_ylbx;//养老保险
	private String new_xc_sybx;//失业保险
	private String new_xc_gjj;//公积金
	private String new_xc_cb;//补扣
	private String new_xc_cbhj;//扣款合计
	private String new_xc_sfhj;//实发合计
	
	private String strRoles; //角色
	private String org_id;    //部门id
	
	private String directoryyear1;   //出生日期查询开始日期
	private String directoryyear2;   //出生日期查询结束日期
	
	private String orgids;   //部门ids  用于查询
	private String intime1;   //入院时间查询开始时间
	private String intime2;   //入院时间查询结束时间
	
	private String job_name;//岗位名称
	
	//初次取证日期 开始时间
	private String hold_ratify_starttime;
	//初次取证日期 结束时间
	private String hold_ratify_endtime;
	//离职时间 
	private String leavetime;
	private String leavetime_date1;		//离职日期起始时间
	private String leavetime_date2;		//离职日期结束时间
	
	public String getIntime1() {
		return intime1;
	}

	public void setIntime1(String intime1) {
		this.intime1 = intime1;
	}

	public String getIntime2() {
		return intime2;
	}

	public void setIntime2(String intime2) {
		this.intime2 = intime2;
	}

	public String getRemark4() {
		return remark4;
	}

	public void setRemark4(String remark4) {
		this.remark4 = remark4;
	}

	public String getRemark5() {
		return remark5;
	}

	public void setRemark5(String remark5) {
		this.remark5 = remark5;
	}

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

	public String getOrgUserMan() {
		return orgUserMan;
	}

	public void setOrgUserMan(String orgUserMan) {
		this.orgUserMan = orgUserMan;
	}
	
	/**
	*<b>Summary: 获取人员类别</b>
	*/
	public String getNew_user_type() {
		return new_user_type;
	}
	/**
	*<b>Summary: 设置人员类别</b>
	*/
	public void setNew_user_type(String new_user_type) {
		this.new_user_type = new_user_type;
	}
	/**
	*<b>Summary: 获取在岗状态</b>
	*/
	public String getNew_job_state() {
		return new_job_state;
	}
	/**
	*<b>Summary: 设置在岗状态</b>
	*/
	public void setNew_job_state(String new_job_state) {
		this.new_job_state = new_job_state;
	}
	/**
	*<b>Summary: 获取职工工号</b>
	*/
	public String getNew_job_no() {
		return new_job_no;
	}
	/**
	*<b>Summary: 设置职工工号</b>
	*/
	public void setNew_job_no(String new_job_no) {
		this.new_job_no = new_job_no;
	}
	/**
	*<b>Summary: 获取岗位设置</b>
	*/
	public String getNew_job_set() {
		return new_job_set;
	}
	/**
	*<b>Summary: 设置岗位设置</b>
	*/
	public void setNew_job_set(String new_job_set) {
		this.new_job_set = new_job_set;
	}
	/**
	*<b>Summary: 获取参加组织日期</b>
	*/
	public String getNew_join_zzdate() {
		return new_join_zzdate;
	}
	/**
	*<b>Summary: 设置参加组织日期</b>
	*/
	public void setNew_join_zzdate(String new_join_zzdate) {
		this.new_join_zzdate = new_join_zzdate;
	}
	/**
	*<b>Summary: 获取入院时间</b>
	*/
	public String getNew_in_hosb() {
		return new_in_hosb;
	}
	/**
	*<b>Summary: 设置入院时间</b>
	*/
	public void setNew_in_hosb(String new_in_hosb) {
		this.new_in_hosb = new_in_hosb;
	}
	/**
	*<b>Summary: 获取借调时间</b>
	*/
	public String getNew_toother_date() {
		return new_toother_date;
	}
	/**
	*<b>Summary: 设置借调时间</b>
	*/
	public void setNew_toother_date(String new_toother_date) {
		this.new_toother_date = new_toother_date;
	}
	/**
	*<b>Summary: 获取学习形式(第一学历)</b>
	*/
	public String getNew_first_xingshi() {
		return new_first_xingshi;
	}
	/**
	*<b>Summary: 设置学习形式(第一学历)</b>
	*/
	public void setNew_first_xingshi(String new_first_xingshi) {
		this.new_first_xingshi = new_first_xingshi;
	}
	/**
	*<b>Summary: 获取专业(第一学历)</b>
	*/
	public String getNew_first_zy() {
		return new_first_zy;
	}
	/**
	*<b>Summary: 设置专业(第一学历)</b>
	*/
	public void setNew_first_zy(String new_first_zy) {
		this.new_first_zy = new_first_zy;
	}
	/**
	*<b>Summary: 获取毕业时间(第一学历)</b>
	*/
	public String getNew_first_bydate() {
		return new_first_bydate;
	}
	/**
	*<b>Summary: 设置毕业时间(第一学历)</b>
	*/
	public void setNew_first_bydate(String new_first_bydate) {
		this.new_first_bydate = new_first_bydate;
	}
	/**
	*<b>Summary: 获取毕业院校(最高学历)</b>
	*/
	public String getNew_zg_byyx() {
		return new_zg_byyx;
	}
	/**
	*<b>Summary: 设置毕业院校(最高学历)</b>
	*/
	public void setNew_zg_byyx(String new_zg_byyx) {
		this.new_zg_byyx = new_zg_byyx;
	}
	/**
	*<b>Summary: 获取学历(最高学历)</b>
	*/
	public String getNew_zg_xl() {
		return new_zg_xl;
	}
	/**
	*<b>Summary: 设置学历(最高学历)</b>
	*/
	public void setNew_zg_xl(String new_zg_xl) {
		this.new_zg_xl = new_zg_xl;
	}
	/**
	*<b>Summary: 获取学位(最高学历)</b>
	*/
	public String getNew_zg_xw() {
		return new_zg_xw;
	}
	/**
	*<b>Summary: 设置学位(最高学历)</b>
	*/
	public void setNew_zg_xw(String new_zg_xw) {
		this.new_zg_xw = new_zg_xw;
	}
	/**
	*<b>Summary: 获取学习形式(最高学历)</b>
	*/
	public String getNew_zg_xingshi() {
		return new_zg_xingshi;
	}
	/**
	*<b>Summary: 设置学习形式(最高学历)</b>
	*/
	public void setNew_zg_xingshi(String new_zg_xingshi) {
		this.new_zg_xingshi = new_zg_xingshi;
	}
	/**
	*<b>Summary: 获取专业(最高学历)</b>
	*/
	public String getNew_zg_zy() {
		return new_zg_zy;
	}
	/**
	*<b>Summary: 设置专业(最高学历)</b>
	*/
	public void setNew_zg_zy(String new_zg_zy) {
		this.new_zg_zy = new_zg_zy;
	}
	/**
	*<b>Summary: 获取毕业时间(最高学历)</b>
	*/
	public String getNew_zg_bydate() {
		return new_zg_bydate;
	}
	/**
	*<b>Summary: 设置毕业时间(最高学历)</b>
	*/
	public void setNew_zg_bydate(String new_zg_bydate) {
		this.new_zg_bydate = new_zg_bydate;
	}
	/**
	*<b>Summary: 获取现合同终止期</b>
	*/
	public String getHetong_nowsend_date1() {
		return hetong_nowsend_date1;
	}
	/**
	*<b>Summary: 设置现合同终止期</b>
	*/
	public void setHetong_nowsend_date1(String hetong_nowsend_date1) {
		this.hetong_nowsend_date1 = hetong_nowsend_date1;
	}
	/**
	*<b>Summary: 获取合同试用终止期</b>
	*/
	public String getHetong_tryend_date1() {
		return hetong_tryend_date1;
	}
	/**
	*<b>Summary: 设置合同试用终止期</b>
	*/
	public void setHetong_tryend_date1(String hetong_tryend_date1) {
		this.hetong_tryend_date1 = hetong_tryend_date1;
	}
	/**
	*<b>Summary: 获取现合同终止期</b>
	*/
	public String getHetong_nowsend_date2() {
		return hetong_nowsend_date2;
	}
	/**
	*<b>Summary: 设置现合同终止期</b>
	*/
	public void setHetong_nowsend_date2(String hetong_nowsend_date2) {
		this.hetong_nowsend_date2 = hetong_nowsend_date2;
	}
	/**
	*<b>Summary: 获取合同试用终止期</b>
	*/
	public String getHetong_tryend_date2() {
		return hetong_tryend_date2;
	}
	/**
	*<b>Summary: 设置合同试用终止期</b>
	*/
	public void setHetong_tryend_date2(String hetong_tryend_date2) {
		this.hetong_tryend_date2 = hetong_tryend_date2;
	}

	public String getPersionHold_name() {
		return persionHold_name;
	}

	public void setPersionHold_name(String persionHold_name) {
		this.persionHold_name = persionHold_name;
	}
	/**
	*<b>Summary: 获取技术职称</b>
	*/
	public String getNew_jszc() {
		return new_jszc;
	}
	/**
	*<b>Summary: 设置技术职称</b>
	*/
	public void setNew_jszc(String new_jszc) {
		this.new_jszc = new_jszc;
	}
	/**
	*<b>Summary: 获取职称获取时间</b>
	*/
	public String getNew_zc_getdate() {
		return new_zc_getdate;
	}
	/**
	*<b>Summary: 设置职称获取时间</b>
	*/
	public void setNew_zc_getdate(String new_zc_getdate) {
		this.new_zc_getdate = new_zc_getdate;
	}
	/**
	*<b>Summary: 获取职称聘任时间</b>
	*/
	public String getNew_zc_pydate() {
		return new_zc_pydate;
	}
	/**
	*<b>Summary: 设置职称聘任时间</b>
	*/
	public void setNew_zc_pydate(String new_zc_pydate) {
		this.new_zc_pydate = new_zc_pydate;
	}

	public String getHetong_nowsend_date() {
		return hetong_nowsend_date;
	}

	public void setHetong_nowsend_date(String hetong_nowsend_date) {
		this.hetong_nowsend_date = hetong_nowsend_date;
	}

	public String getHetong_tryend_date() {
		return hetong_tryend_date;
	}

	public void setHetong_tryend_date(String hetong_tryend_date) {
		this.hetong_tryend_date = hetong_tryend_date;
	}

	public String getNew_xc_gwgz() {
		return new_xc_gwgz;
	}

	public void setNew_xc_gwgz(String new_xc_gwgz) {
		this.new_xc_gwgz = new_xc_gwgz;
	}

	public String getNew_xc_xjgz() {
		return new_xc_xjgz;
	}

	public void setNew_xc_xjgz(String new_xc_xjgz) {
		this.new_xc_xjgz = new_xc_xjgz;
	}

	public String getNew_xc_yfgz() {
		return new_xc_yfgz;
	}

	public void setNew_xc_yfgz(String new_xc_yfgz) {
		this.new_xc_yfgz = new_xc_yfgz;
	}

	public String getNew_xc_yb() {
		return new_xc_yb;
	}

	public void setNew_xc_yb(String new_xc_yb) {
		this.new_xc_yb = new_xc_yb;
	}

	public String getNew_xc_ylbx() {
		return new_xc_ylbx;
	}

	public void setNew_xc_ylbx(String new_xc_ylbx) {
		this.new_xc_ylbx = new_xc_ylbx;
	}

	public String getNew_xc_sybx() {
		return new_xc_sybx;
	}

	public void setNew_xc_sybx(String new_xc_sybx) {
		this.new_xc_sybx = new_xc_sybx;
	}

	public String getNew_xc_gjj() {
		return new_xc_gjj;
	}

	public void setNew_xc_gjj(String new_xc_gjj) {
		this.new_xc_gjj = new_xc_gjj;
	}

	public String getNew_xc_cb() {
		return new_xc_cb;
	}

	public void setNew_xc_cb(String new_xc_cb) {
		this.new_xc_cb = new_xc_cb;
	}

	public String getNew_xc_cbhj() {
		return new_xc_cbhj;
	}

	public void setNew_xc_cbhj(String new_xc_cbhj) {
		this.new_xc_cbhj = new_xc_cbhj;
	}

	public String getNew_xc_sfhj() {
		return new_xc_sfhj;
	}

	public void setNew_xc_sfhj(String new_xc_sfhj) {
		this.new_xc_sfhj = new_xc_sfhj;
	}

	public String getStrRoles() {
		return strRoles;
	}

	public void setStrRoles(String strRoles) {
		this.strRoles = strRoles;
	}

	public String getOrg_id() {
		return org_id;
	}

	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}

	public String getDirectoryyear1() {
		return directoryyear1;
	}

	public void setDirectoryyear1(String directoryyear1) {
		this.directoryyear1 = directoryyear1;
	}

	public String getDirectoryyear2() {
		return directoryyear2;
	}

	public void setDirectoryyear2(String directoryyear2) {
		this.directoryyear2 = directoryyear2;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	/**
	 * <b>Summary: </b>
	 *     获取new_jb_zy的值
	 * @return new_jb_zy 
	 */
	public String getNew_jb_zy() {
		return new_jb_zy;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 new_jb_zy 的值 
	 * @param new_jb_zy 
	 */
	public void setNew_jb_zy(String new_jb_zy) {
		this.new_jb_zy = new_jb_zy;
	}

	/**
	 * <b>Summary: </b>
	 *     获取hold_ratify_starttime的值
	 * @return hold_ratify_starttime 
	 */
	public String getHold_ratify_starttime() {
		return hold_ratify_starttime;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 hold_ratify_starttime 的值 
	 * @param hold_ratify_starttime 
	 */
	public void setHold_ratify_starttime(String hold_ratify_starttime) {
		this.hold_ratify_starttime = hold_ratify_starttime;
	}

	/**
	 * <b>Summary: </b>
	 *     获取hold_ratify_endtime的值
	 * @return hold_ratify_endtime 
	 */
	public String getHold_ratify_endtime() {
		return hold_ratify_endtime;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 hold_ratify_endtime 的值 
	 * @param hold_ratify_endtime 
	 */
	public void setHold_ratify_endtime(String hold_ratify_endtime) {
		this.hold_ratify_endtime = hold_ratify_endtime;
	}

	/**
	 * <b>Summary: </b>
	 *     获取leavetime的值
	 * @return leavetime 
	 */
	public String getLeavetime() {
		return leavetime;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 leavetime 的值 
	 * @param leavetime 
	 */
	public void setLeavetime(String leavetime) {
		this.leavetime = leavetime;
	}

	/**
	 * <b>Summary: </b>
	 *     获取leavetime_date1的值
	 * @return leavetime_date1 
	 */
	public String getLeavetime_date1() {
		return leavetime_date1;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 leavetime_date1 的值 
	 * @param leavetime_date1 
	 */
	public void setLeavetime_date1(String leavetime_date1) {
		this.leavetime_date1 = leavetime_date1;
	}

	/**
	 * <b>Summary: </b>
	 *     获取leavetime_date2的值
	 * @return leavetime_date2 
	 */
	public String getLeavetime_date2() {
		return leavetime_date2;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 leavetime_date2 的值 
	 * @param leavetime_date2 
	 */
	public void setLeavetime_date2(String leavetime_date2) {
		this.leavetime_date2 = leavetime_date2;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
}

/*
 * Created Tue Feb 14 11:47:28 CST 2006 by MyEclipse Hibernate Tool.
 */
package com.chinacreator.sysmgrcore.entity;

import java.io.Serializable;

/**
 * A class that represents a row in the 'td_sm_user' table. 
 * This class may be customized as it is never re-generated 
 * after being created.
 */
public class User
    extends AbstractUser
    implements Serializable
{
	private String orgName;
	
	private String job_name;
	
	private String orgs;
    
	private String mobile2;
	
	private String numberOne; //是否党政一把手
	
	private UserAndSn userAndSn;
	
	private String user_fax;
	
	private String user_mobiletel1;
	
	private String user_worktel;
	
	private String user_id;
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String userId) {
		user_id = userId;
	}


	private String user_email;
	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String userEmail) {
		user_email = userEmail;
	}

	public String getUser_fax() {
		return user_fax;
	}

	public void setUser_fax(String userFax) {
		user_fax = userFax;
	}

	public String getUser_mobiletel1() {
		return user_mobiletel1;
	}

	public void setUser_mobiletel1(String userMobiletel1) {
		user_mobiletel1 = userMobiletel1;
	}

	public String getUser_worktel() {
		return user_worktel;
	}

	public void setUser_worktel(String userWorktel) {
		user_worktel = userWorktel;
	}

	public String getWorkphone() {
		return workphone;
	}

	public void setWorkphone(String workphone) {
		this.workphone = workphone;
	}


	private String workphone;
	
	

	/**
	 * 证书编号
	 */
	private String cretSn;
	/**
	 * 保存主机构
	 */
	protected String mainOrg;
	/**
	 * 手机证书编码
	 */
	private String mobileSn;
	
	
	public String getMobileSn() {
	    return mobileSn;
	}

	public void setMobileSn(String mobileSn) {
	    this.mobileSn = mobileSn;
	}

	/**
     * Simple constructor of User instances.
     */
    public User()
    {
    }

    /**
     * Constructor of User instances given a simple primary key.
     * @param userId
     */
    public User(Integer userId)
    {
        super(userId);
    }

	public String getOrgs() {
		return orgs;
	}

	public void setOrgs(String orgs) {
		this.orgs = orgs;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getMainOrg() {
		return mainOrg;
	}

	public void setMainOrg(String mainOrg) {
		this.mainOrg = mainOrg;
	}

	
	public String getCretSn() {
		return cretSn;
	}

	public void setCretSn(String cretSn) {
		this.cretSn = cretSn;
	}
	
	public String getMobile2() {
		return mobile2;
	}

	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	
	public UserAndSn getUserAndSn() {
		return userAndSn;
	}

	public void setUserAndSn(UserAndSn userAndSn) {
		this.userAndSn = userAndSn;
	}

	public String getNumberOne() {
		return numberOne;
	}

	public void setNumberOne(String numberOne) {
		this.numberOne = numberOne;
	}

	public String toString() {
		StringBuffer userinfo = new StringBuffer();
		userinfo.append("[user_id=").append(getUserId()).append(",user_name=")
			.append(getUserName()).append(",").append("USER_SN=").append(getUserSn())
			.append(",USER_PASSWORD=").append(getUserPassword())
			.append(",USER_REALNAME=").append(this.getUserRealname())
			.append(",USER_PINYIN=").append(this.getUserPinyin())
			.append(",USER_SEX=").append(this.getUserSex())
			.append(",USER_HOMETEL=").append(this.getUserHometel())
			.append(",USER_WORKTEL=").append(this.getUserWorktel())
			.append(",USER_TYPE=").append(this.getUserType())
			.append("]");
		return userinfo.toString();
	}

	
    /* Add customized code below */

}

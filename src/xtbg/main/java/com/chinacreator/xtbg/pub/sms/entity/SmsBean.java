package com.chinacreator.xtbg.pub.sms.entity;

public class SmsBean {
	//张家界短信bean
	public String businessId;
	
	private String classNameId;
	
	private String userId;
	
	private String userName;
	
	private String content;
	
	private String subCode;
	
	private String tel;
	
	
	public String getBusinessId() {
		return businessId;
	}

	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}

	
	public String getClassNameId() {
		return classNameId;
	}

	public void setClassNameId(String classNameId) {
		this.classNameId = classNameId;
	}

	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public String getSubCode() {
		return subCode;
	}

	public void setSubCode(String subCode) {
		this.subCode = subCode;
	}
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}


	
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	
	//移民局短信提醒bean
	
	private String RECEIVERMOBILENO;
	
	private String RECEIVERMOBILENOOne;
	
	private String MSG;


	public String getRECEIVERMOBILENO() {
		return RECEIVERMOBILENO;
	}

	public void setRECEIVERMOBILENO(String rECEIVERMOBILENO) {
		RECEIVERMOBILENO = rECEIVERMOBILENO;
	}

	public String getRECEIVERMOBILENOOne() {
		return RECEIVERMOBILENOOne;
	}

	public void setRECEIVERMOBILENOOne(String rECEIVERMOBILENOOne) {
		RECEIVERMOBILENOOne = rECEIVERMOBILENOOne;
	}

	public String getMSG() {
		return MSG;
	}

	public void setMSG(String mSG) {
		MSG = mSG;
	}
	
	
}

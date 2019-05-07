package com.chinacreator.xtbg.core.common.note.services.impl.mas2.entity;

import java.io.Serializable;

/**
 *<p>Title:SmsOutBoxbean.java</p>
 *<p>Description:mas2短信发送实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-18
 */
public class SmsOutBoxbean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String SISMSID; //UUID/GUID( 由应用侧产生)
	
	private String EXTCODE;//扩展号码
	
	private String DESTADDR; //接受手机MSISDN,多个用“;”分割,最大不超过50个
	
	private String MESSAGECONTENT;//短信内容	当MSGFMT为4时,消息内容为十六进制字符串
	
	private String REQDELIVERYREPORT;//是否需要状态报告	0:不需要 	1:需要
	
	private String MSGFMT;//消息类型	0- ASCII	4- Binary	8- usc2	15- gb2312	16-gb18030
	
	private String SENDMETHOD;//普通短信 	普通短信立即显示	长短信组包	带结构短信
	
	private String REQUESTTIME;//入库时间(短信发送请求时间)
	
	private String APPLICATIONID;//EC/SI应用的ID

	public String getSISMSID() {
		return SISMSID;
	}

	public void setSISMSID(String sISMSID) {
		SISMSID = sISMSID;
	}

	public String getEXTCODE() {
		return EXTCODE;
	}

	public void setEXTCODE(String eXTCODE) {
		EXTCODE = eXTCODE;
	}

	public String getDESTADDR() {
		return DESTADDR;
	}

	public void setDESTADDR(String dESTADDR) {
		DESTADDR = dESTADDR;
	}

	public String getMESSAGECONTENT() {
		return MESSAGECONTENT;
	}

	public void setMESSAGECONTENT(String mESSAGECONTENT) {
		MESSAGECONTENT = mESSAGECONTENT;
	}

	public String getREQDELIVERYREPORT() {
		return REQDELIVERYREPORT;
	}

	public void setREQDELIVERYREPORT(String rEQDELIVERYREPORT) {
		REQDELIVERYREPORT = rEQDELIVERYREPORT;
	}

	public String getMSGFMT() {
		return MSGFMT;
	}

	public void setMSGFMT(String mSGFMT) {
		MSGFMT = mSGFMT;
	}

	public String getSENDMETHOD() {
		return SENDMETHOD;
	}

	public void setSENDMETHOD(String sENDMETHOD) {
		SENDMETHOD = sENDMETHOD;
	}

	public String getREQUESTTIME() {
		return REQUESTTIME;
	}

	public void setREQUESTTIME(String rEQUESTTIME) {
		REQUESTTIME = rEQUESTTIME;
	}

	public String getAPPLICATIONID() {
		return APPLICATIONID;
	}

	public void setAPPLICATIONID(String aPPLICATIONID) {
		APPLICATIONID = aPPLICATIONID;
	}
}

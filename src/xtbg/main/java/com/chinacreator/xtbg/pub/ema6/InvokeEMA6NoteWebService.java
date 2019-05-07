package com.chinacreator.xtbg.pub.ema6;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.security.NoSuchAlgorithmException;

import org.apache.axis.AxisFault;

import com.chinacreator.xtbg.pub.util.MD5Util;


/**
 *<p>Title:InvokeNoteWebService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2011-4-20
 */
public class InvokeEMA6NoteWebService {

	private String endpoint;//短信接口地址
	
	private String account;//账号
	
	private String password;//密码
	
	private String orgCode;//机构子码
	
	SmsOperatorImpInterServiceLocator sl;
	SmsOperatorImpInterServiceSoapBindingStub stub;
	
	private SmsOperatorImpServiceLocator locator ;
	
	private SmsOperatorImpServiceSoapBindingStub sstub ;

	
	public InvokeEMA6NoteWebService(String wsdlUrl,String account,String password) throws NoSuchAlgorithmException, AxisFault, MalformedURLException{
		this.endpoint = wsdlUrl;
		this.account = account;
		this.password = MD5Util.MD5(password);
		this.orgCode = "";
		this.locator = new SmsOperatorImpServiceLocator();
		this.sstub = new SmsOperatorImpServiceSoapBindingStub(new URL(endpoint),locator);

	}
	public InvokeEMA6NoteWebService(String wsdlUrl,String account,String password,String orgCode) throws NoSuchAlgorithmException, AxisFault, MalformedURLException{
		this.endpoint = wsdlUrl;
		this.account = account;
		this.password = MD5Util.MD5(password);
		this.orgCode = orgCode;
		this.sl = new SmsOperatorImpInterServiceLocator();
		this.stub = new SmsOperatorImpInterServiceSoapBindingStub(new URL(endpoint),sl);
	}
	
	/**
	*<b>Summary: </b>
	* sendSms(发送一条或则多条内容相同的短信)
	* @param message
	* @return
	* @throws RemoteException
	 */
	public MtMessageRes sendSms(MtMessage message) throws RemoteException{
		if("".equals(orgCode.trim())) {
			return sendSmsNotNeedOrgCode(message) ;
		} else {
			return stub.sendSms(account, password, orgCode, "", message);
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* sendSmsNotNeedOrgCode(发送一条或则多条内容相同的短信:不需要orgCode)
	* @param message
	* @return
	* @throws RemoteException
	 */
	public MtMessageRes sendSmsNotNeedOrgCode(MtMessage message) throws RemoteException{
		return sstub.sendSms(account, password, "", message);
	}
	/**
	 * 
	*<b>Summary: </b>
	* batchSendSms(批量发内容不相同的短信)
	* @param messages
	* @param subCode
	* @param sendResMsg
	* @param errMsg
	* @throws RemoteException
	 */
	public MtMessageRes batchSendSms(MtMessage[] messages) throws RemoteException{
		return  stub.bathSendSms(account, password, orgCode, "", messages);
	}
	
	/**
	*<b>Summary: </b>
	* getReport(获取短信发送状态))
	* @return
	* @throws RemoteException
	 */
	public ReportMessageRes getReport() throws RemoteException{
		return stub.getReport(account, password);
	}
	
	/**
	*<b>Summary: </b>
	* getSms(获取回复的短信)
	* @param resMsg
	* @param errMsg
	* @throws RemoteException
	 */
	public MoMessageRes  getSms() throws RemoteException{
		return sstub.getSms(account, password);
	}
}

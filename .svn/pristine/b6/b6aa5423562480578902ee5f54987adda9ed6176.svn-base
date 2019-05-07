package com.chinacreator.xtbg.core.common.note.services.impl;

import java.net.URL;
import java.sql.Connection;
import java.util.List;

import org.apache.axis.types.URI;
import org.apache.axis.types.URI.MalformedURIException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.gwcs.note.send.finance.schema.sms.MessageFormat;
import com.chinacreator.gwcs.note.send.finance.schema.sms.SendMethodType;
import com.chinacreator.gwcs.note.send.finance.schema.sms.SendSmsRequest;
import com.chinacreator.gwcs.note.send.finance.schema.sms.SendSmsResponse;
import com.chinacreator.gwcs.note.send.finance.service.Cmcc_mas_wbsSoapBindingStub;
import com.chinacreator.gwcs.note.send.finance.service.Cmcc_mas_wbs_ServiceLocator;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.AbstractBusinessTrigger;
import com.chinacreator.xtbg.core.common.note.services.AbstractNoteService;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.chinacreator.xtbg.core.common.util.DbManager;

/**
 * 
 *<p>Title:FinanceNoteSendService.java</p>
 *<p>Description:财政厅短信接口</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 李畅
 *@version 1.0
 *2013-12-5
 */
public class FinanceNoteSendService extends AbstractNoteService {
	
	private static final Log LOG = LogFactory.getLog(FinanceNoteSendService.class);
	
	private String retry_times = "3";//最大重发次数
	private String endpoint;        //ws地址
	private String applicationID;   //应用编号
	private String extendCode="001";      //扩展编码
	
	public String getRetry_times() {
		return retry_times;
	}

	public void setRetry_times(String retry_times) {
		this.retry_times = retry_times;
	}
	
	public String getEndpoint() {
		return endpoint;
	}

	public void setEndpoint(String endpoint) {
		this.endpoint = endpoint;
	}

	public String getApplicationID() {
		return applicationID;
	}

	public void setApplicationID(String applicationID) {
		this.applicationID = applicationID;
	}

	public String getExtendCode() {
		return extendCode;
	}

	public void setExtendCode(String extendCode) {
		this.extendCode = extendCode;
	}

	private AbstractBusinessTrigger trigger;//业务触发类
	
	public void setTrigger(AbstractBusinessTrigger trigger) {
		this.trigger = trigger;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 doNoteSend
	  * @throws Throwable 
	  * @see com.chinacreator.xtbg.core.common.note.services.AbstractNoteService#doNoteSend()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void doNoteSend() throws Throwable {
		Connection conn = null;
		NoteBufferBean bean = null;
		List<NoteDetailBean>  list = null;
		try {
		    conn = DbManager.getInstance().getTransactionConnection();
		    Object[] obj = query(retry_times,conn);
		    if ((obj == null) || (obj.length != 2)) {
		    	return;
		    }
		    bean = (NoteBufferBean) obj[0];
		    list = (List<NoteDetailBean>) obj[1];
		    
		    noteToHis(bean, list, "", NoteConstants.HAS_SEND, Integer.parseInt(retry_times), conn);//假设调用接口发送成功
		    //调用接口发送短信
		    try {
				callServices(bean, list);
				conn.commit();
			} catch (Exception e) {
				throw e;
			}
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			noteToHis(bean, list, "", NoteConstants.SEND_FAIL, Integer.parseInt(retry_times), conn);//调用接口发送失败
			LOG.error(e.getMessage(),e);
		}finally{
			release(bean,list);
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* callServices(ws方法调用)
	* @param bean
	* @param list
	* @throws Exception
	 */
	public void callServices(NoteBufferBean bean, List<NoteDetailBean> list) throws Exception {
		if ((endpoint == null) || ("".equals(endpoint)) || (applicationID == null )|| ("".equals(applicationID))) {
			throw new IllegalArgumentException("webservices地址或applicationID为空");
		}		
		Cmcc_mas_wbs_ServiceLocator sl = new Cmcc_mas_wbs_ServiceLocator();
		Cmcc_mas_wbsSoapBindingStub stub = new Cmcc_mas_wbsSoapBindingStub(new URL(endpoint), sl);
		SendSmsRequest sendSmsRequest = new SendSmsRequest();
		sendSmsRequest.setApplicationID(applicationID);
		sendSmsRequest.setDeliveryResultRequest(true);
		sendSmsRequest.setDestinationAddresses(getURI(list));
		sendSmsRequest.setExtendCode(extendCode);
		sendSmsRequest.setMessageFormat(MessageFormat.fromString(MessageFormat._GB2312));
		sendSmsRequest.setSendMethod(SendMethodType.fromValue(SendMethodType._Normal));
		sendSmsRequest.setMessage(bean.getContent());
		SendSmsResponse rsps = stub.sendSms(sendSmsRequest);
		LOG.info(rsps.getRequestIdentifier());
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getURI(封装号码格式)
	* @param list
	* @return
	* @throws MalformedURIException
	 */
	private URI[] getURI(List<NoteDetailBean> list) throws MalformedURIException {
		int i = 0;
		URI[] uri = new URI[list.size()];
		for (NoteDetailBean bean : list) {
			uri[i] = new URI("tel:" + bean.getPhone_num());
			i = i + 1;
		}		
		return uri;
	}

	@Override
	public void getNoteReport() throws Throwable {
		// TODO Auto-generated method stub
		
		if(trigger!=null){
			trigger.triggerBusiness(null, null, NoteConstants.NOTE_REPORT, null);
		}
	}

	@Override
	public void getNoteReply() throws Throwable {
		// TODO Auto-generated method stub
		if(trigger!=null){
			trigger.triggerBusiness(null, null, NoteConstants.NOTE_REPLY, null);
		}
	}

}

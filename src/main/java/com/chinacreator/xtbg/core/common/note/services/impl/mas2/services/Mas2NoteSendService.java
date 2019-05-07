package com.chinacreator.xtbg.core.common.note.services.impl.mas2.services;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.AbstractBusinessTrigger;
import com.chinacreator.xtbg.core.common.note.services.AbstractNoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao.SmsOutBoxDao;
import com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao.impl.SmsOutBoxDaoImpl;
import com.chinacreator.xtbg.core.common.note.services.impl.mas2.entity.SmsOutBoxbean;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbConnection;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:Mas2NoteSendService.java</p>
 *<p>Description:烽火MAS2.0二次开发-数据库形式 </p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-18
 */
public class Mas2NoteSendService extends AbstractNoteService {
	
	private static final Log LOG = LogFactory.getLog(Mas2NoteSendService.class);
	
	private String retry_times = "3";//最大重发次数
	
	private int max_phone_num = 50;//一次可发送的手机号码个数
	
	private String applicationid; //EC/SI应用的ID
	
	private String mysql_url = null;//mysql数据库的链接url
	private String mysql_userName = null;//mysql数据库用户名
	private String mysql_password = null;//mysql数据库密码
	
	public void setMax_phone_num(int max_phone_num) {
		this.max_phone_num = max_phone_num;
	}

	public void setApplicationid(String applicationid) {
		this.applicationid = applicationid;
	}

	public void setMysql_url(String mysql_url) {
		this.mysql_url = mysql_url;
	}

	public void setMysql_userName(String mysql_userName) {
		this.mysql_userName = mysql_userName;
	}

	public void setMysql_password(String mysql_password) {
		this.mysql_password = mysql_password;
	}

	public void setRetry_times(String retry_times) {
		this.retry_times = retry_times;
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
		    Object[] obj = query(retry_times,conn);//查询短信数据
		    if ((obj == null) || (obj.length != 2)) {
		    	return;
		    }
		    bean = (NoteBufferBean) obj[0];
		    list = (List<NoteDetailBean>) obj[1];
		    noteToHis(bean, list, "", NoteConstants.HAS_SEND, Integer.parseInt(retry_times), conn);//假设调用接口发送成功
		    Connection mysqlConn = null;
		    try {
		    	List<SmsOutBoxbean> smsOutBoxbeans = getSmsOutBoxbean(bean,list);
			    mysqlConn = DbConnection.getInstrance().getMySqlConnection(mysql_url, mysql_userName, mysql_password);
			    mysqlConn.setAutoCommit(false);
			    SmsOutBoxDao smsOutBoxDao = new SmsOutBoxDaoImpl();
			    smsOutBoxDao.insertSmsOutBox(smsOutBoxbeans, mysqlConn);
			    mysqlConn.commit();
			} catch (Exception e) {
				DbManager.rollBackNoThrow(mysqlConn);
				throw e;
			}finally{
				DbManager.closeConnection(mysqlConn);
			}
		    conn.commit();
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
	*<b>Summary: </b>
	* getSmsOutBoxbean(获取短信发送实体)
	* @param bean
	* @param list
	* @return
	*/
	private List<SmsOutBoxbean> getSmsOutBoxbean(NoteBufferBean bean,List<NoteDetailBean>  list) {
		List<SmsOutBoxbean> smsOutBoxbeans = new ArrayList<SmsOutBoxbean>();
		List<String> destaddrList = getPhoneString(list);
		for(String destaddr : destaddrList){
			SmsOutBoxbean smsOutBoxbean = new SmsOutBoxbean();
			smsOutBoxbean.setSISMSID(StringUtil.getUUID());
			smsOutBoxbean.setEXTCODE("");
			smsOutBoxbean.setDESTADDR(destaddr);
			smsOutBoxbean.setMESSAGECONTENT(bean.getContent());
			smsOutBoxbean.setREQDELIVERYREPORT(bean.getNeed_status());
			smsOutBoxbean.setMSGFMT("15");//15- gb2312
			smsOutBoxbean.setSENDMETHOD("0");
			smsOutBoxbean.setREQUESTTIME(DateUtil.getCurrentDateTime());
			smsOutBoxbean.setAPPLICATIONID(applicationid);
			smsOutBoxbeans.add(smsOutBoxbean);
		}
		return smsOutBoxbeans;
	}
	
	/**
	*<b>Summary: </b>
	* getPhoneString(根据配置的一条短信发送的最大号码数进行号码拼接)
	* @param list
	* @return
	*/
	private List<String> getPhoneString(List<NoteDetailBean>  list){
		StringBuffer destaddr = new StringBuffer();
		List<String> destaddrList = new ArrayList<String>();
		int count = 0;
		for(NoteDetailBean bean : list){
			destaddr.append(bean.getPhone_num()).append(";");
			count++;
			if(count == max_phone_num){//拼接号码达最大数时另外再起一条
				destaddrList.add(destaddr.toString());
				release(destaddr);//重置
				destaddr = new StringBuffer();
				count = 0;
			}
		}
		if(count > 0 && !"".equals(destaddr.toString())){
			destaddrList.add(destaddr.toString());
		}
		return destaddrList;
	}
	
	/*public static void main(String[] args) {
		Mas2NoteSendService sendService = new Mas2NoteSendService();
		List<NoteDetailBean>  list = new ArrayList<NoteDetailBean>();
		for(int i=0;i<237;i++){
			NoteDetailBean bean = new NoteDetailBean();
			bean.setPhone_num(""+i);
			list.add(bean);
		}
		List<String> rrList = sendService.getPhoneString(list);
		for(String ssString : rrList){
			System.out.println(ssString);
		}
	}*/
	
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

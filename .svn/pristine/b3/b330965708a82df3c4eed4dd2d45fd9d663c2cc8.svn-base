package com.chinacreator.xtbg.core.common.note.services.impl.jingdi.service;

import java.sql.Connection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.AbstractBusinessTrigger;
import com.chinacreator.xtbg.core.common.note.services.AbstractNoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao.JingdiDoteSendDao;
import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao.impl.JingdiDoteSendDaoImpl;
import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.entity.SendTask;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:JingdiNoteSendService.java</p>
 *<p>Description:金迪短信发送</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-21
 */
public class JingdiNoteSendService extends AbstractNoteService {

	private static final Log LOG = LogFactory.getLog(JingdiNoteSendService.class);
	
	private String retry_times = "3";//最大重发次数
	
	public String getRetry_times() {
		return retry_times;
	}

	public void setRetry_times(String retry_times) {
		this.retry_times = retry_times;
	}

	private AbstractBusinessTrigger trigger;//业务触发类
	
	public void setTrigger(AbstractBusinessTrigger trigger) {
		this.trigger = trigger;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doNoteSend
	  * @throws Throwable 
	  * @see com.chinacreator.xtbg.core.common.note.services.AbstractNoteService#doNoteSend()
	 */
	@SuppressWarnings("unchecked")
	public void doNoteSend() throws Throwable {
		Connection conn = null;
		NoteBufferBean bean = null;
		List<NoteDetailBean>  list = null;
		NoteDetailBean noteDetailBean = null;
		SendTask sendTask = null;
		JingdiDoteSendDao jingdiDoteSendDao = null;
		try {
		    conn = DbManager.getInstance().getTransactionConnection();
		    Object[] obj = query(retry_times,conn);
		    if ((obj == null) || (obj.length != 2)) {
		    	return;
		    }
		    bean = (NoteBufferBean) obj[0];
		    list = (List<NoteDetailBean>) obj[1];
		    
		    noteToHis(bean, list, "", NoteConstants.HAS_SEND, Integer.parseInt(retry_times), conn);//假设调用接口发送成功
		    
		    
		    //金迪短信发送
		    jingdiDoteSendDao = new JingdiDoteSendDaoImpl();
		    sendTask = new SendTask();
		   
		    sendTask.setContent(bean.getContent());
		    String destnumber = "";
		    for(int i = 0; i < list.size(); i++) {
		    	noteDetailBean = new NoteDetailBean();
		    	noteDetailBean = list.get(i);
		    	destnumber += noteDetailBean.getPhone_num() + ";";
		    }
		    if(!StringUtil.isBlank(destnumber)) {
		    	destnumber = destnumber.substring(0, destnumber.length() - 1);
			    sendTask.setDestnumber(destnumber);
			    jingdiDoteSendDao.smsSendDao(sendTask, conn);
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

	@Override
	public void getNoteReply() throws Throwable {
		// TODO Auto-generated method stub
		if(trigger!=null){
			trigger.triggerBusiness(null, null, NoteConstants.NOTE_REPORT, null);
		}
	}

	@Override
	public void getNoteReport() throws Throwable {
		// TODO Auto-generated method stub

	}

}

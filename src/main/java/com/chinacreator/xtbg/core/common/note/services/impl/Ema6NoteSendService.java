package com.chinacreator.xtbg.core.common.note.services.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.AbstractBusinessTrigger;
import com.chinacreator.xtbg.core.common.note.services.AbstractNoteService;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.chinacreator.xtbg.core.common.util.DbManager;


/**
 *<p>Title:Ema6NoteSendService.java</p>
 *<p>Description:电信Ema6短信发送</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-16
 */
public class Ema6NoteSendService extends AbstractNoteService {
	
	private static final Log LOG = LogFactory.getLog(Ema6NoteSendService.class);
	
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
		    //TODO 调用接口发送短信
		    
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

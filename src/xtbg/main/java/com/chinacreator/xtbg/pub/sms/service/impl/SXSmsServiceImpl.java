package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;
import com.chinacreator.xtbg.pub.sms.smsutil.SmsUtil;
/**
 * 
 *<p>Title:SXSmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-6-19
 */
public class SXSmsServiceImpl implements SmsServiceIfc{

	private static final Logger LOG = Logger.getLogger(SXSmsServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 smsDataAssembling
	  * @param map
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc#smsDataAssembling(java.util.Map, java.sql.Connection)
	 */
	@Override
	public void smsDataAssembling(Map<String, String> map,Connection con) throws Exception{
		SmsUtil smsUtil = new SmsUtil();
		try {
			List<NoteDetailBean>  list = (List<NoteDetailBean>) smsUtil.getRecipient(map);
			NoteBufferBean bean = new NoteBufferBean();
			StringBuffer content = new StringBuffer();
			bean.setUser_name(map.get("accepter"));
			
			if("GW".equals(map.get("isFlag"))){
				content.append("您有一篇公文，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			if("TZ".equals(map.get("isFlag"))){//通知公告
				content.append(map.get("accepter")).append("向您发送了一条").append("通知公告，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			if("JB".equals(map.get("isFlag"))){//简报
				content.append(map.get("accepter")).append("向您发送了一条").append("工作简报，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			if("HY".equals(map.get("isFlag"))){//简报
				content.append(map.get("accepter")).append("向您发送了一条").append("会议通知，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			if("RWJB".equals(map.get("isFlag"))){//任务交办
				content.append(map.get("accepter")).append("向您发送了一条").append("交办任务，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			if("QSBG".equals(map.get("isFlag"))){//任务交办
				content.append(map.get("accepter")).append("向您发送了一条").append("请示报告，").append("请您阅办。");
				bean.setContent(content.toString());
			}
			NoteService noteService = new NoteServiceImpl();
			noteService.doNoteSend(bean ,list,con);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			throw e;
		}
	}
	

}

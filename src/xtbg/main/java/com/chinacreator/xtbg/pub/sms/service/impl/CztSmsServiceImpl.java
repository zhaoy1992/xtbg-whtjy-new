package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;

/**
 *<p>Title:WcSmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-6-20
 */
public class CztSmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(CztSmsServiceImpl.class);
	@Override
	public void smsDataAssembling(Map<String, String> map, Connection con)
			throws Exception {
		try {
			//图书管理 专用短信 其他短信 另外i加条件
			if (("y").equals(map.get("isSend"))) {
				List<NoteDetailBean> list = new ArrayList<NoteDetailBean>();
				NoteDetailBean smsSendBean = new NoteDetailBean();
				smsSendBean.setPhone_num(map.get("phone_number"));
				smsSendBean.setUser_name(map.get("boorow_user_name"));
				smsSendBean.setUser_id(map.get("boorow_user_id"));
				list.add(smsSendBean);
				NoteBufferBean bean = new NoteBufferBean();
				StringBuffer content = new StringBuffer();
				content.append(map.get("content")+"("+map.get("accepter")+"发送)"); 
				bean.setContent(content.toString());
				bean.setUser_name(map.get("accepter"));
				NoteService noteService = new NoteServiceImpl();
				noteService.doNoteSend(bean ,list,con);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			throw e;
		}
		
	}
}

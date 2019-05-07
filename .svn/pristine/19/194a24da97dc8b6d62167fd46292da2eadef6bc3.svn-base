package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.xtbg.core.common.util.StringUtil;
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
 *2013-12-11
 */
public class SWJSmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(SWJSmsServiceImpl.class);
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
	public void smsDataAssembling(Map<String, String> map, Connection con)
			throws Exception {
		SmsUtil smsUtil = new SmsUtil();
		try {
			List<NoteDetailBean>  list = (List<NoteDetailBean>) smsUtil.getRecipient(map);
			NoteBufferBean bean = new NoteBufferBean();
			StringBuffer content = new StringBuffer();
			bean.setUser_name(map.get("accepter"));
			Timestamp  end_send_date = StringUtil.convertStringToTimestamp(map.get("send_date"), "yyyy-MM-dd HH24:mi:ss");
			bean.setSend_date(end_send_date);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式

			if("DCDB".equals(map.get("isFlag"))){
				content.append("你好！你有一则督办任务：").append("标题： ").append(map.get("ins_name"))
				.append(" 创建人：").append(map.get("accepter")).append(" 发布时间：").append(df.format(new Date())).append("。请及时查看！");
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

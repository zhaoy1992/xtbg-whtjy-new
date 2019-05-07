package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;
import com.chinacreator.xtbg.pub.sms.smsutil.SmsUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:YmjSmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-9
 */
public class YmjSmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(YmjSmsServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 smsDataAssembling
	  * @param map 
	  * @see com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc#smsDataAssembling(java.util.Map)
	 */
	@Override
	public void smsDataAssembling(Map<String, String> map,Connection con) {
		SmsUtil smsUtil = new SmsUtil();
		if (null != map.get("user_id") && !"".equals(map.get("user_id")) && "y".equalsIgnoreCase(map.get("isSend"))) {
			try {
				List<SmsBean> list = (List<SmsBean>) smsUtil.threeSendPhone(map);
				if (list.size() > 0 && null != list) {
					for (int i = 0; i < list.size(); i++) {
						StringBuffer buf = new StringBuffer();
						SmsBean smsBean = list.get(i);
						smsBean.setMSG(buf.append("省移民局内网温馨提醒：您有待办公文，请查阅!").append("  ——〔省局信息分中心〕").toString());
						smsUtil.smsSendDao(smsBean);
					}
				}
			} catch (SQLException e) {
				LOG.error(e.getMessage(),e);
			}
		}
		
	}
	

}


package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.pub.sms.dao.SmsSendDaoCommon;
import com.chinacreator.xtbg.pub.sms.entity.SmsSendBean;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;
import com.chinacreator.xtbg.pub.sms.smsutil.SmsUtil;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
/**
 * 
 *<p>Title:JyksySmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-9
 */
public class JyksySmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(JyksySmsServiceImpl.class);
/**
 * 
  * <b>Summary: </b>
  *     复写方法 smsDataAssembling
  * @param map 
  * @see com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc#smsDataAssembling(java.util.Map)
 */
	@Override
	public void smsDataAssembling(Map<String, String> map,Connection con) {
		try {
			SmsUtil smsUtil = new SmsUtil();
			String sendphone = CacheCommonManageProxy.getSystemParam("sendphone");
			SmsSendDaoCommon dao = (SmsSendDaoCommon)DaoImplClassUtil.getDaoImplClass("SmsSendDaoCommonDaoImpl");
			if (null != map.get("user_id") && !"".equals(map.get("user_id")) && "y".equalsIgnoreCase(map.get("isSend"))) {
				
				//流程  共通通讯录
				if(StringUtil.isBlank(map.get("is_source"))){
					List<SmsSendBean> list = (List<SmsSendBean>) smsUtil.oneSendPhone(map);
					if (list.size() > 0 && null != list) {
						for (int i = 0; i < list.size(); i++) {
							StringBuffer buf = new StringBuffer();
							SmsSendBean smsSendBean = list.get(i);
							if (null == map.get("content") || "".equals(map.get("content"))) {
								
								//请批件发送请批件流程发送的短信格式的“【上一环节执行】向您发送了【标题】，请您处理。
								//[湖南省教育考试院]勿回本号”中【标题】需要先删除其中的空格、回车符，然后取前20个字符。否则短信会很长，导致浏览困难。
								String mgrName = map.get("mgrName");
								String [] strMgrName = mgrName.split("#");
								//请批件
								if("jyksyqpj".equals(strMgrName[0])){
									String content1 = smsUtil.replaceBlank(map.get("ins_name"));
									buf.append(smsSendBean.getUserName()).append(
									"向您发送了一条<").append(content1).append(">，")
									.append("请您处理。");
								} else { 
									buf.append(smsSendBean.getUserName()).append(
										"向您发送了一条<").append(map.get("ins_name")).append(">，")
										.append("请您处理。");
								}
							} else {
								buf.append(map.get("content"));
							}
							smsSendBean.setContent(buf.toString());
							smsSendBean.setSendphone(sendphone);
							((BaseDao)dao).insert(smsSendBean);
						}
					}
				//个人通讯录
				} else {
					List<SmsSendBean> list = (List<SmsSendBean>) smsUtil.oneSendPersonPhone(map);
					if (list.size() > 0 && null != list) {
						for (int i = 0; i < list.size(); i++) {
							StringBuffer buf = new StringBuffer();
							SmsSendBean smsSendBean = list.get(i);
							buf.append(map.get("content"));
							smsSendBean.setContent(buf.toString());
							smsSendBean.setSendphone(sendphone);
							((BaseDao)dao).insert(smsSendBean);
						}
					}
				}
			}
			//会议的发送
			if(null!= map.get("conferenceNotice") && map.get("conferenceNotice").equals("conferenceNotice")){
				List<SmsSendBean> list = (List<SmsSendBean>) smsUtil.oneSendPhone(map);
				if (list.size() > 0 && null != list) {
					for (int i = 0; i < list.size(); i++) {
						StringBuffer buf = new StringBuffer();
						SmsSendBean smsSendBean = list.get(i);
						if (null == map.get("content") || "".equals(map.get("content"))) {
							buf.append(map.get("begindate")).append(
									"在").append(map.get("roomNname")).append("召开").append(map.get("title"))
									.append("，请您准时参加，会议详细内容请登录协同办公系统查看。");
						} else {
							buf.append(map.get("content"));
						}
						smsSendBean.setContent(buf.toString());
						smsSendBean.setSendphone(sendphone);
						((BaseDao)dao).insert(smsSendBean);
					}
				}
			}
		} catch (SQLException e) {
			LOG.error(e.getMessage(),e);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
	}
}

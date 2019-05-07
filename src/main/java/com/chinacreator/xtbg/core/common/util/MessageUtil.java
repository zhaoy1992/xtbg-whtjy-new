package com.chinacreator.xtbg.core.common.util;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.im.entity.IMBean;
import com.chinacreator.xtbg.core.common.im.services.IMService;
import com.chinacreator.xtbg.core.common.mail.entity.MailBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;
import com.chinacreator.xtbg.core.common.mail.services.MailService;
import com.chinacreator.xtbg.core.common.mail.services.impl.MailServiceImpl;
import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl;
import com.chinacreator.xtbg.core.common.msgtodo.services.MsgTodoService;
import com.chinacreator.xtbg.core.common.msgtodo.services.impl.MsgTodoServiceImpl;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;

/**
 * 
 *<p>Title:MessageUtil.java</p>
 *<p>Description:发送消息提醒工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-28
 */
public class MessageUtil {

	private static final Log LOG=LogFactory.getLog(MessageUtil.class);
	UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
	/**
	 * 
	*<b>Summary: </b>
	* sendSms(发短信)
	 */
	public void sendSms(String msg_business_id,String msg_content,String senduserid,List<String> useridlist,String busi_type,String othre,Connection conn){
		NoteBufferBean noteBufferBean = new NoteBufferBean();
		NoteDetailBean noteDetailBean = null;
		List<NoteDetailBean> detailList = new ArrayList<NoteDetailBean>();
		NoteService noteService = new NoteServiceImpl();
		
		try {
			if(!StringUtil.isBlank(msg_content)){
				noteBufferBean.setContent(msg_content);
				noteBufferBean.setUser_id(senduserid);
				noteBufferBean.setUser_name(userManagerServiceIfc.getUserBean(senduserid).get("user_realname"));
				String buffer_id = StringUtil.getUUID();
				noteBufferBean.setBuffer_id(buffer_id);
				//加这个字段，是为了发改委做短信统计与搜索时使用。
				noteBufferBean.setBusiness_type(busi_type);
				noteBufferBean.setBusiness_id(msg_business_id);
				for (String id : useridlist){
					Map<String, String> userMap = new HashMap<String, String>();
					userMap = userManagerServiceIfc.getUserBean(id);
					if (userMap!=null && !StringUtil.nullOrBlank(userMap.get("user_mobiletel1"))){
						noteDetailBean = new NoteDetailBean();
						noteDetailBean.setRecv_id(StringUtil.getUUID());
						noteDetailBean.setBuffer_id(buffer_id);
						noteDetailBean.setUser_id(id);
						noteDetailBean.setUser_name(userMap.get("user_realname"));
						noteDetailBean.setPhone_num(StringUtil.deNull(userMap.get("user_mobiletel1")));
						detailList.add(noteDetailBean);
					}
				}
				//发改委特殊要求
				 if(othre != null && !"".equals(othre)){
						String[] str = othre.split(";");
						for(int i = 0 ; i < str.length ; i++){
							String[] st = str[i].split(":"); 
							for(int j = 1 ; j < st.length ; j++ ){
								String substr = st[1].substring(0,st[1].length()-1);
								noteDetailBean = new NoteDetailBean();
								noteDetailBean.setPhone_num(substr);
								detailList.add(noteDetailBean);
							}
						}
					}

				if(noteBufferBean!=null && detailList!=null && detailList.size()>0){
					noteService.doNoteSend(noteBufferBean, detailList, conn);
				}
			}
		} catch (Exception e) {
			LOG.error( e.getMessage(), e);
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* sendSms(发站内)
	 */
	public void sendMsg(String msg_content,String senduserid,List<String> useridlist,Connection conn){
		MessageCenterService mservice = new MessageCenterServiceImpl();
		try {
			mservice.sendMessage(senduserid, useridlist, msg_content, conn);
		} catch (Exception e) {
			LOG.error( e.getMessage(), e);
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* sendSms(发及时)
	 */
	public void sendRtx(String msg_content,String senduserid,List<String> useridlist,Connection conn){
		IMService imservice= (IMService)LoadSpringContext.getApplicationContext().getBean("IMService");
		IMBean imBean=new IMBean();
		try {
			imBean.setMsg(msg_content);
			imBean.setSend_user(senduserid);
			for (String id : useridlist) {
				imBean.setRecv_user(id);
				imBean.setMsg(StringUtil.getUUID());
				imservice.sendMsg(imBean, conn);
			}
		} catch (Exception e) {
			LOG.error( e.getMessage(), e);
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* sendSms(发邮件)
	 */
	public void sendMail(String msg_content,String senduserid,List<String> useridlist,Connection conn){
		MailService mailService=new MailServiceImpl();
		MailBean bean= new MailBean();
		MailTopicBean mailTopicBean =new MailTopicBean();
		List<MailRecvBean> list=new ArrayList<MailRecvBean>();
		try {
			String mailid=StringUtil.getUUID();
			mailTopicBean.setMail_id(mailid);
			mailTopicBean.setContent(msg_content);
			mailTopicBean.setSend_user(senduserid);
			mailTopicBean.setTopic(msg_content);
			
			for (String id : useridlist) {
				MailRecvBean recvbean= new MailRecvBean();
				recvbean.setRecv_id(StringUtil.getUUID());
				recvbean.setMail_id(mailid);
				recvbean.setRecv_user(id);
				list.add(recvbean);
			}
			
			bean.setMailTopicBean(mailTopicBean);
			bean.setRecvList(list);
			mailService.sendMail(bean, conn);
		} catch (Exception e) {
			LOG.error( e.getMessage(), e);
		}
	}
	
	/**
	 * 	*<b>Summary: </b>
	* sendMsgTodo(添加统一待办信息)
	*  @param busId 业务ID
	 * @param title 标题
	 * @param type 待办类型（区别业务）
	 * @param url 链接地址
	 * @param recvType 接收者类型（1个人、2单位）
	 * @param senduserid 发送人ID
	 * @param useridlist 接收者集合
	 * @param conn
	 */
	public void sendMsgTodo(String busId, String title,String type,String url,String recvType,String senduserid,List<String> useridlist,Connection conn){
		MsgTodoService mservice = new MsgTodoServiceImpl();
		try {
			mservice.addMsgTodoInfo(busId, title, type, url, senduserid, useridlist, recvType, conn);
		} catch (Exception e) {
			LOG.error( e.getMessage(), e);
		}
	}
}

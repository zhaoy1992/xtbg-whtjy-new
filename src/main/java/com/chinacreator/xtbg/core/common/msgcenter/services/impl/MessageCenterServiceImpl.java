package com.chinacreator.xtbg.core.common.msgcenter.services.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.msgcenter.cache.MessageCache;
import com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageRecvBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;
import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:MessageCenterServiceImpl.java</p>
 *<p>Description:站内消息服务实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public class MessageCenterServiceImpl implements MessageCenterService {

	private static final Logger LOG = Logger
	.getLogger(MessageCenterServiceImpl.class);
		
	/**
	 * 
	*<b>Summary: 发送消息</b>
	* sendMessage()
	* @param sendUserId  消息发送人id
	* @param recvUserIds 消息接收人id列表
	* @param content     发送的消息内容
	* @return
	 */
	public boolean sendMessage(String sendUserId,List<String> recvUserIds,
			String content){
		boolean sucess = false;
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getTransactionConnection();
			sendMessage(sendUserId,recvUserIds,content,conn);			
			conn.commit();
		}catch (Exception e) {
			sucess = false;
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return sucess;
	} 

	/**
	 * 
	*<b>Summary:发送消息 </b>
	* sendMessage()
	* @param sendUserId  消息发送人id
	* @param recvUserIds 消息接收人id列表
	* @param content     发送的消息内容
	* @param conn        数据库连接
	* @return
	 * @throws Exception 
	 */
	public boolean sendMessage(String sendUserId,List<String> recvUserIds,
			String content, Connection conn) throws Exception {
		boolean sucess = false;
		MessageCenterDao messageCenterDao = new com.chinacreator.xtbg.core.common.msgcenter.dao.impl.MessageCenterDaoImpl();
		String msg_id = StringUtil.getUUID();// 消息id

		if (!StringUtil.nullOrBlank(content)
				&& !StringUtil.nullOrBlank(sendUserId)) {
			MessageSendBean sendBean = new MessageSendBean();
			sendBean.setMsg_id(msg_id);// 给发送消息实体中添加主键
			sendBean.setSend_userid(sendUserId);// 消息发送人id
			sendBean.setSend_date(new Timestamp(System.currentTimeMillis()));
			sendBean.setMsg_type("msg");
			sendBean.setMsg_content(content);
			((BaseDao) messageCenterDao).insert(sendBean, conn);
		} else {
			LOG.error("没有传入消息内容或者发送人id");
		}
		List<String> recvIds = new ArrayList<String>();
		if (null != recvUserIds && !recvUserIds.isEmpty()) {
			for (String rId : recvUserIds) {
				MessageRecvBean recvBean = new MessageRecvBean();
				String recvId = StringUtil.getUUID();
				recvBean.setRecv_id(recvId);
				recvBean.setMsg_id(msg_id);
				recvBean.setIshidden("0");
				recvBean.setIsread("0");
				recvBean.setRecv_userid(rId);
				// 插入
				((BaseDao) messageCenterDao).insert(recvBean, conn);
				recvIds.add(recvId);
			}
		} else {
			// 给出提示，不抛出异常
			LOG.error("没有传入消息接收人id列表");
		}
		// 如果保存成功，则放入缓存
		if (null != recvUserIds && !recvUserIds.isEmpty()) {
			for (int i = 0; i < recvUserIds.size(); i++) {
				MessageCache.addMessage(recvUserIds.get(i), recvIds.get(i));
			}
		}
		return sucess;
	}
	
	/**
	 * 
	*<b>Summary:发送站内消息 </b>
	* sendMessage()
	* @param sendUserId 站内消息发送人id
	* @param recvUserId 站内消息接收人id
	* @param content    消息内容
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean sendMessage(String sendUserId,String recvUserId,
			String content,Connection conn) throws Exception{
		boolean sucess = false;
		if(!StringUtil.nullOrBlank(recvUserId)){
		   List<String> list = new ArrayList<String>();
		   list.add(recvUserId);
		   sucess = sendMessage(sendUserId,list, 
					content,conn);
		}		
		return sucess;
	}
	/**
	  * <b>Summary: </b>
	  *     复写方法 deleteMessage
	  * @param user_id
	  * @param recvIds 消息接收id 
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService#deleteMessage(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean deleteMessage(String user_id, String recvIds)
			throws Exception {
		boolean sucess = false;
		Connection conn = null;
		MessageCenterDao messageCenterDao = (MessageCenterDao) LoadSpringContext.getApplicationContext().getBean("messageCenterDao");
		try{
			if(StringUtil.nullOrBlank(user_id)){
				throw new Exception("删除站内消息时，user_id不能为null");
			}
			conn = DbManager.getInstance().getTransactionConnection();
			sucess = messageCenterDao.updateMssageHidden(user_id, recvIds, conn);
			if(sucess){
				conn.commit();
				//清空全部，则删除用户的所有缓存消息
				if(StringUtil.nullOrBlank(recvIds)){
					MessageCache.deleteMessage(user_id);
				}else{
					MessageCache.deleteMessage(user_id, Arrays.asList(recvIds.split("\\,")));
				}
			}else{
				DbManager.rollBackNoThrow(conn);
			}
		}catch (Exception e) {
			sucess = false;
			DbManager.rollBackNoThrow(conn);
			throw e;
		}finally{
			DbManager.closeConnection(conn);
		}
		return sucess;
	}

	
	/**
	 * 
	*<b>Summary: 查询消息列表数据</b>
	* findMessagePageBean()
	* @param rbean
	* @param sbean
	* @param page
	* @return
	* @throws Exception
	 */
	public PagingBean queryMessageList(MessageRecvBean rbean,
			MessageSendBean sbean, PageInfoBean page) throws Exception{
		MessageCenterDao messageCenterDao = (MessageCenterDao) LoadSpringContext.getApplicationContext().getBean("messageCenterDao");
		return messageCenterDao.queryMessageList(rbean, sbean, page);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 querySingleMsgById
	  * @param recvId
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService#querySingleMsgById(java.lang.String)
	 */
	public Map<String, String> querySingleMsgById(String recvId)
			{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			MessageCenterDao dao = (MessageCenterDao) LoadSpringContext
					.getApplicationContext().getBean("messageCenterDao");
			return dao.querySingleMsgById(recvId,conn);
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			return new HashMap<String,String>();
		}  finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMessageReaded
	  * @param recvIds 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService#updateMessageReaded(java.lang.String)
	 */
	public boolean updateMessageReaded(String userId,String recvIds){
		Connection conn = null;
		try {
			//没有传入id，则不能进行更新操作
			if(StringUtil.nullOrBlank(recvIds)){
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			MessageCenterDao dao = (MessageCenterDao) LoadSpringContext
					.getApplicationContext().getBean("messageCenterDao");
			dao.updateMessageReaded(userId,recvIds, conn);
			conn.commit();
			//删除缓存中对应的数据
			MessageCache.deleteMessage(userId,Arrays.asList(recvIds.split("\\,")));
			return true;
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}  finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateAllMessageReaded
	  * @param recvIds
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService#updateAllMessageReaded(java.lang.String)
	 */
	public boolean updateAllMessageReaded(String userId){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MessageCenterDao dao = (MessageCenterDao) LoadSpringContext
					.getApplicationContext().getBean("messageCenterDao");
			//标记所有的消息都为已读，则不传入id
			dao.updateMessageReaded(userId,null, conn);
			MessageCache.deleteMessage(userId);
			conn.commit();
			return true;
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}  finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 countUnReadMessage
	  * @param userId
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService#countUnReadMessage(java.lang.String)
	 */
	public Integer countUnReadMessage(String userId){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			MessageCenterDao dao = (MessageCenterDao) LoadSpringContext
					.getApplicationContext().getBean("messageCenterDao");
			return dao.countUnReadMessage(userId, conn);
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			return 0;
		}  finally {
			DbManager.closeConnection(conn);
		}
	}
	
	public static void main(String[] args){
		MessageCenterServiceImpl service = new MessageCenterServiceImpl();
		List<String> ls = new ArrayList<String>();
		ls.add("28");
		ls.add("23");
		service.sendMessage("23", ls, "明天中午，在603召开加班动员大会，请准时参加，如果需要请假，请联系刘曙麒，电话：175869855447，谢谢");
	}
}

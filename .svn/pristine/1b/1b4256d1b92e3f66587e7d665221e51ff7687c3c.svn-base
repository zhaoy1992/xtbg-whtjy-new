package com.chinacreator.xtbg.core.common.msgcenter.action;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.common.msgcenter.cache.MessageCache;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageRecvBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;
import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl;
/**
 * 
 *<p>Title:MessageAction.java</p>
 *<p>Description:站内消息处理action</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-9-11
 */
public class MessageAction extends PublicAjaxAction {
	private static final Logger LOG = Logger
	.getLogger(MessageAction.class);
	
	private MessageRecvBean rbean;//站内消息接收实体对象
	
	private MessageSendBean sbean;//站内消息发送实体对象
	
	private String msgIds;//消息id以","拼接字符串
	private String userId;//用户id	
	private String recvIds;//消息接收id，以“,”拼接

	/**
	 * 
	*<b>Summary:查询消息列表 </b>
	* queryMessageList()
	 */
	public void queryMessageList() {
		try {
			MessageCenterService service = new MessageCenterServiceImpl();
			
			super.write4PagingBeanJson(service.queryMessageList(rbean, sbean,
					super.getPage()));
			
		} catch (Exception e) {
			LOG.error("查询站内消息出现异常", e);
			super.write4PagingBeanJson(null);
		}
	}
	
	/**
	 * 
	*<b>Summary:逻辑删除消息列表 </b>
	* updateMessage()
	 */
	public void deleteMessageLogically(){
		try {
			MessageCenterService service = new MessageCenterServiceImpl();
			//执行删除操作
			//特检院 修改 BUG start
			//boolean flag = service.deleteMessage(userId, msgIds);
			boolean flag = service.deleteMessage(userId, recvIds);
			//特检院 修改 BUG end
			if (flag) {
				super.write("{\"flag\":true,\"msg\":\"操作成功\"}");
			} else {
				super.write("{\"flag\":false,\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			super.write("{\"flag\":false,\"msg\":\"操作失败\"}");
		}

	}
	
	/**
	 * 
	*<b>Summary:标记所有消息为已读 </b>
	* updateMessage()
	 */
	public void updateAllMessageReaded(){
		try {
			MessageCenterService service = new MessageCenterServiceImpl();
			//执行更新操作
			boolean flag = service.updateAllMessageReaded(userId);
			if (flag) {
				super.write("{\"flag\":true,\"msg\":\"操作成功\"}");
			} else {
				super.write("{\"flag\":false,\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			super.write("{\"flag\":false,\"msg\":\"操作失败\"}");
		}
	}
	
	/**
	 * 
	*<b>Summary: 统计未读的记录条数</b>
	* countUnReadMessage()
	 */
	public void countUnReadMessage(){
		try {			
			//执行删除操作
			int count = MessageCache.getUserUnReadCount(userId);
			super.write("{\"flag\":true,\"count\":"+count+"}");			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			super.write("{\"flag\":false,\"msg\":\"操作失败\"}");
		}
	}
	

	public MessageRecvBean getRbean() {
		return rbean;
	}

	public void setRbean(MessageRecvBean rbean) {
		this.rbean = rbean;
	}

	public MessageSendBean getSbean() {
		return sbean;
	}

	public void setSbean(MessageSendBean sbean) {
		this.sbean = sbean;
	}

	public String getMsgIds() {
		return msgIds;
	}

	public void setMsgIds(String msgIds) {
		this.msgIds = msgIds;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRecvIds() {
		return recvIds;
	}

	public void setRecvIds(String recvIds) {
		this.recvIds = recvIds;
	}
}

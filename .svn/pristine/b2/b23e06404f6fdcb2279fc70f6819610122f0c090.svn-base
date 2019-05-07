package com.chinacreator.xtbg.core.common.msgcenter.services;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageRecvBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;

/**
 *<p>Title:MessageCenterService.java</p>
 *<p>Description:站内消息服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public interface MessageCenterService {
	/**
	 * 
	*<b>Summary: 发送消息</b>
	* sendMessage()
	* @param sendUserId
	* @param recvUserIds
	* @param content
	* @return
	 */
	public boolean sendMessage(String sendUserId,List<String> recvUserIds,
			String content);		
	/**
	 * 
	*<b>Summary:添加站内信息，调用此方法，在出现异常，事务回滚时，需要自行删除缓存中的消息 </b>
	* sendMessage()
	* @param sendUserId  消息发送人id
	* @param recvUserIds 消息接收人id列表
	* @param content     消息内容
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean sendMessage(String sendUserId,List<String> recvUserIds,
			String content, Connection conn) throws Exception;
	
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
			MessageSendBean sbean, PageInfoBean page) throws Exception;	
	
	/**
	 * 
	*<b>Summary:根据消息接收id查询消息 </b>
	* querySingleMsgById()
	* @param recvId
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> querySingleMsgById(String recvId);
	/**
	 * 
	 *<b>Summary: 更新状态为已读</b>
	 * updateMessageReaded()
	 * @param recvIds 消息接收主键id列表，按,拼接
	 * @return 是否更新成功的标记
	 */
	public boolean updateMessageReaded(String userId,String recvIds);
	/**
	 * 
	*<b>Summary:将所有消息标记为已读 </b>
	* updateAllMessageReaded()
	* @param recvIds 消息接收主键id列表，按,拼接
	* @return 是否更新成功的标记
	 */
	public boolean updateAllMessageReaded(String userId);
	
	/**
	 * 
	*<b>Summary: 根据用户id，统计未读的记录条数</b>
	* countUnReadMessage()
	* @return
	 * @throws SQLException 
	 */
	public Integer countUnReadMessage(String userId);
	
	/**
	 * 
	*<b>Summary: 删除消息</b>
	* deleteMessage()
	* @param user_id
	* @param recvIds
	* @return
	* @throws Exception
	 */
	public boolean deleteMessage(String user_id, String recvIds)
	throws Exception ;
}

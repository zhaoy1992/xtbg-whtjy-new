package com.chinacreator.xtbg.core.common.msgcenter.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageRecvBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;

/**
 *<p>Title:MessageCenterDao.java</p>
 *<p>Description:站内消息处理dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public interface MessageCenterDao {
	
	/**
	*<b>Summary:查找所有的未读站内消息 </b>
	* queryWaitReadMessage(查询系统中所有未读的站内消息)
	* @param conn
	* @return
	* @throws SQLException
	*/
	public List<Map<String,String>> queryWaitReadMessage(Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* addMessageSend(新增站内消息--发送信息)
	* @param bean 站内消息发送实体
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean addMessageSend(MessageSendBean bean,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* addMessageSend(新增站内消息--接收信息)
	* @param recvList 站内消息接收实体 集合
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean addMessageRecv(List<MessageRecvBean> recvList,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateMssageHidden(更新消息为隐藏)
	* @param user_id 用户id
	* @param msg_id 消息接收id
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean updateMssageHidden(String user_id,String recvIds,Connection conn) throws SQLException;
	
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
	public Map<String, String> querySingleMsgById(String recvId,Connection conn)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: 更新状态为已读</b>
	* updateMessageReaded()
	* @param recvIds 消息接收主键id列表，按,拼接
	* @param conn 数据库连接
	* @throws SQLException
	 */
	public void updateMessageReaded(String userId,String recvIds,Connection conn) throws SQLException;	/**
	 * 
	*<b>Summary: 根据用户id，统计未读的记录条数</b>
	* countUnReadMessage()
	* @return
	 * @throws SQLException 
	 */
	public Integer countUnReadMessage(String userId,Connection conn) throws SQLException;
}

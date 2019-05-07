package com.chinacreator.xtbg.core.common.mail.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.mail.entity.MailAffixBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;

/**
 *<p>Title:MailDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-6
 */
public interface MailDao {
	
	/**
	*<b>Summary: </b>
	* insertMailTopic(邮件主题信息入库)
	* @param mailTopicBean
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertMailTopic(MailTopicBean mailTopicBean,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* insertMailRecv(邮件接收人信息入库)
	* @param recvList
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertMailRecv(List<MailRecvBean> recvList,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* insertMailAffix(邮件附件信息入库)
	* @param affixList
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertMailAffix(List<MailAffixBean> affixList,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateMailStatus(批量更新邮件发送端状态)
	* @param mailIDS	邮件id集合
	* @param status	邮件状态：1草稿，2已发送，3已撤销，4已删除
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean updateMailSendStatus(List<String> mailIDS,String status,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateMailRecvStatusByMailId(根据邮件id更新邮件接收端状态)
	* @param mailIDS 邮件id集合
	* @param status 状态：1待阅，2已阅，3被撤销，4删除
	* @param conn
	* @return
	* @throws SQLException
	 */
	public boolean updateMailRecvStatusByMailId(List<String> mailIDS,String status, Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateMailRecvStatus(根据接收id更新邮件接收端状态)
	* @param recvIDS	邮件接收id集合
	* @param status	状态：1待阅，2已阅，3被撤销，4删除
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean updateMailRecvStatus(List<String> recvIDS,String status,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* queryOneMailTopic(按照邮件创建时间查询出最早的正在发送的邮件主题信息)
	* @param conn
	* @return
	* @throws SQLException
	*/
	public MailTopicBean queryOneMailTopic(Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* queryMailRecvs(根据邮件id查询出所有接收人)
	* @param mailID 邮件id
	* @param conn
	* @return
	* @throws SQLException
	*/
	public List<MailRecvBean> queryMailRecvs(String mailID,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* queryMailAffixsNoBlob(根据邮件id查询出附件信息)
	* @param mailID
	* @param conn
	* @return
	* @throws SQLException
	 */
	public List<MailAffixBean> queryMailAffixsNoBlob(String mailID,Connection conn) throws SQLException;
	
	

}

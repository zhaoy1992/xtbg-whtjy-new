package com.chinacreator.xtbg.core.common.mail.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.mail.dao.MailDao;
import com.chinacreator.xtbg.core.common.mail.entity.MailAffixBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailRecvBean;
import com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean;
import com.chinacreator.xtbg.core.common.mail.support.MailConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:MailDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-6
 */
public class MailDaoImpl implements MailDao{

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertMailTopic
	  * @param mailTopicBean
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#insertMailTopic(com.chinacreator.xtbg.core.common.mail.entity.MailTopicBean, java.sql.Connection)
	 */
	@Override
	public boolean insertMailTopic(MailTopicBean mailTopicBean, Connection conn)
			throws SQLException {
		String sql = "insert into oa_mail_topic(mail_id,topic,content,send_user,create_date,mail_origin,status) values(?,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int i = 1;
		pdb.setString(i++, mailTopicBean.getMail_id());
		pdb.setString(i++, mailTopicBean.getTopic());
		pdb.setString(i++, mailTopicBean.getContent());
		pdb.setString(i++, mailTopicBean.getSend_user());
		pdb.setTimestamp(i++, mailTopicBean.getCreate_date());
		pdb.setString(i++, mailTopicBean.getMail_origin());
		pdb.setString(i++, mailTopicBean.getStatus());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertMailRecv
	  * @param recvList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#insertMailRecv(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertMailRecv(List<MailRecvBean> recvList, Connection conn)
			throws SQLException {
		String sql = "insert into oa_mail_recv(recv_id,mail_id,recv_user,send_type,status) values (?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(recvList != null && recvList.size() > 0){
			for(MailRecvBean bean : recvList){
				pdb.preparedInsert(sql);
				int i = 1;
				pdb.setString(i++, bean.getRecv_id());
				pdb.setString(i++, bean.getMail_id());
				pdb.setString(i++, bean.getRecv_user());
				pdb.setString(i++, bean.getSend_type());
				pdb.setString(i++, bean.getStatus());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 insertMailAffix
	  * @param affixList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#insertMailAffix(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertMailAffix(List<MailAffixBean> affixList,
			Connection conn) throws SQLException {
		String sql = "insert into oa_mail_affix(affix_id,mail_id,original_name,realname,filesize,content,filetype,filelocation) values (?,?,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(affixList != null && affixList.size() > 0){
			for(MailAffixBean bean : affixList){
				pdb.preparedInsert(sql);
				int i = 1;
				pdb.setString(i++, bean.getAffix_id());
				pdb.setString(i++, bean.getMail_id());
				pdb.setString(i++, bean.getOriginal_name());
				pdb.setString(i++, bean.getRealname());
				pdb.setLong(i++, bean.getFilesize());
				pdb.setBlob(i++, bean.getContent());
				pdb.setString(i++, bean.getFiletype());
				pdb.setString(i++, bean.getFilelocation());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 updateMailSendStatus
	  * @param mailIDS
	  * @param status
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#updateMailSendStatus(java.util.List, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean updateMailSendStatus(List<String> mailIDS, String status,
			Connection conn) throws SQLException {
		String sql = "update oa_mail_topic t set t.status=?,t.send_date = sysdate where t.mail_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(mailIDS != null && mailIDS.size() > 0){
			for(String mailId : mailIDS){
				pdb.preparedUpdate(sql);
				int i = 1;
				pdb.setString(i++, status);
				pdb.setString(i++, mailId);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 updateMailRecvStatusByMailId
	  * @param mailIDS
	  * @param status
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#updateMailRecvStatusByMailId(java.util.List, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean updateMailRecvStatusByMailId(List<String> mailIDS,
			String status, Connection conn) throws SQLException {
		String sql = "update oa_mail_recv t set t.status=? where t.mail_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(mailIDS != null && mailIDS.size() > 0){
			for(String mailId : mailIDS){
				pdb.preparedUpdate(sql);
				int i = 1;
				pdb.setString(i++, status);
				pdb.setString(i++, mailId);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 updateMailRecvStatus
	  * @param recvIDS
	  * @param status
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#updateMailRecvStatus(java.util.List, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean updateMailRecvStatus(List<String> recvIDS, String status,
			Connection conn) throws SQLException {
		String sql = "update oa_mail_recv t set t.status=? where t.recv_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(recvIDS != null && recvIDS.size() > 0){
			for(String recvId : recvIDS){
				pdb.preparedUpdate(sql);
				int i = 1;
				pdb.setString(i++, status);
				pdb.setString(i++, recvId);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryOneMailTopic
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#queryOneMailTopic(java.sql.Connection)
	 */
	@Override
	public MailTopicBean queryOneMailTopic(Connection conn) throws SQLException {
		MailTopicBean bean = null;
		String sql = "select t.mail_id,t.topic,t.content,t.send_user,t.create_date,t.send_date,t.mail_origin,t.status" +
				" from oa_mail_topic t where t.status='"+MailConstants.SENDING+"' rownum < 2 order by t.create_date asc";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size() == 1){
			bean = new MailTopicBean();
			bean.setMail_id(pdb.getString(0, "mail_id"));
			bean.setTopic(pdb.getString(0, "topic"));
			bean.setContent(pdb.getString(0, "content"));
			bean.setSend_user(pdb.getString(0, "send_user"));
			bean.setCreate_date(pdb.getTimestamp(0, "create_date"));
			bean.setSend_date(pdb.getTimestamp(0, "send_date"));
			bean.setMail_origin(pdb.getString(0, "mail_origin"));
			bean.setStatus(pdb.getString(0, "status"));
		}
		return bean;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryMailRecvs
	  * @param mailID
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#queryMailRecvs(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<MailRecvBean> queryMailRecvs(String mailID, Connection conn)
			throws SQLException {
		List<MailRecvBean> recvList = new ArrayList<MailRecvBean>();
		String sql = "select t.recv_id,t.mail_id,t.recv_user,t.send_type,t.status,t.read_date from oa_mail_recv t  where t.mail_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, mailID);
		pdb.executePrepared(conn);
		for(int i = 0; i < pdb.size(); i++){
			MailRecvBean bean = new MailRecvBean();
			bean.setRecv_id(pdb.getString(i, "recv_id"));
			bean.setMail_id(pdb.getString(i, "mail_id"));
			bean.setRecv_user(pdb.getString(i, "recv_user"));
			bean.setSend_type(pdb.getString(i, "send_type"));
			bean.setStatus(pdb.getString(i, "status"));
			bean.setRead_date(pdb.getTimestamp(i, "read_date"));
			recvList.add(bean);
		}
		return recvList;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryMailAffixsNoBlob
	  * @param mailID
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.mail.dao.MailDao#queryMailAffixsNoBlob(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<MailAffixBean> queryMailAffixsNoBlob(String mailID, Connection conn)
			throws SQLException {
		List<MailAffixBean> affixList = new ArrayList<MailAffixBean>();
		String sql = "select t.affix_id,t.mail_id,t.original_name,t.realname,t.filesize,t.filetype,t.filelocation " +
				"from oa_mail_affix t where t.mail_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, mailID);
		pdb.executePrepared(conn);
		for(int i = 0; i < pdb.size(); i++){
			MailAffixBean bean = new MailAffixBean();
			bean.setAffix_id(pdb.getString(i, "affix_id"));
			bean.setMail_id(pdb.getString(i, "mail_id"));
			bean.setOriginal_name(pdb.getString(i, "original_name"));
			bean.setRealname(pdb.getString(i, "realname"));
			bean.setFilesize(pdb.getLong(i, "filesize"));
			bean.setFiletype(pdb.getString(i, "filetype"));
			bean.setFilelocation(pdb.getString(i, "filelocation"));
		}
		return affixList;
	}

}

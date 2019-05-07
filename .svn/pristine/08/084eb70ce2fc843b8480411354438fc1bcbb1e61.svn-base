package com.chinacreator.xtbg.core.common.msgcenter.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageRecvBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:MessageCenterDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public class MessageCenterDaoImpl extends XtDbBaseDao implements MessageCenterDao {
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryWaitReadMessage
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#queryWaitReadMessage(java.sql.Connection)
	 */
	public List<Map<String,String>> queryWaitReadMessage(Connection conn) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.recv_userid,a.recv_id from oa_msg_recv a ");
		sql.append(" where a.isread='0' and a.ishidden='0' ");
		return super.queryToListMap(sql.toString(),conn);		
	}
	

	/**
	  * <b>Summary: </b>
	  *     复写方法 addMessageSend
	  * @param bean
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#addMessageSend(com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean, java.sql.Connection)
	 */
	@Override
	public boolean addMessageSend(MessageSendBean bean, Connection conn)
			throws SQLException {
		String sql = "insert into oa_msg_send(msg_id,msg_content,msg_type,msg_url,send_userid,send_orgid,send_date) values(?,?,?,?,?,?,sysdate)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int k = 1;
		pdb.setString(k++, bean.getMsg_id());
		pdb.setString(k++, bean.getMsg_content());
		pdb.setString(k++, bean.getMsg_type());
		pdb.setString(k++, bean.getMsg_url());
		pdb.setString(k++, bean.getSend_userid());
		pdb.setString(k++, bean.getSend_orgid());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 addMessageRecv
	  * @param recvList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#addMessageRecv(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean addMessageRecv(List<MessageRecvBean> recvList,
			Connection conn) throws SQLException {
		String sql = "insert into oa_msg_recv(recv_id,msg_id,recv_userid,recv_orgid,isread,read_date,ishidden) values(seq_oa_msg_recv.nextval,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(recvList != null && recvList.size() > 0){
			for(MessageRecvBean bean : recvList){
				pdb.preparedInsert(sql);
				int k = 1;
				pdb.setString(k++, bean.getMsg_id());
				pdb.setString(k++, bean.getRecv_userid());
				pdb.setString(k++, bean.getRecv_orgid());
				pdb.setString(k++, bean.getIsread());
				pdb.setTimestamp(k++, (Timestamp)bean.getRead_date());
				pdb.setString(k++, bean.getIshidden());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMessageReaded
	  * @param recvIds
	  * @param conn
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#updateMessageReaded(java.lang.String, java.sql.Connection)
	 */
	public void updateMessageReaded(String userId,String recvIds,Connection conn) throws SQLException{
		StringBuffer sql = new StringBuffer("update oa_msg_recv t set t.isread='1',t.read_date=sysdate where t.isread <> '1' ");
		List<String> condition = new ArrayList<String>();
		if(!StringUtil.nullOrBlank(recvIds)){
			sql.append(" and instr(','||?||',',','||t.recv_id||',')>0 ");
			condition.add(recvIds.replaceAll("'", ""));
		}
		if(!StringUtil.nullOrBlank(userId)){
			sql.append(" and  instr(','||t.recv_userid||',',','||?||',')>0 ");
			condition.add(userId);
		}
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		for(int i=0;i<condition.size();i++){
			pdb.setString(i+1, condition.get(i));
		}
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMssageHidden
	  * @param user_id
	  * @param msg_id
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#updateMssageHidden(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean updateMssageHidden(String user_id, String recvIds,
			Connection conn) throws SQLException {
		List<String> condition =  new ArrayList<String>();
		StringBuffer sql = new StringBuffer("update oa_msg_recv t set t.ishidden='1'");
		sql.append(" where t.recv_id is not null" );
		if(!StringUtil.nullOrBlank(recvIds)){
			sql.append(" and instr(','||?||',',','||t.recv_id||',')>0 ");
			condition.add(recvIds);
		}
		if(!StringUtil.nullOrBlank(user_id)){
			sql.append(" and  instr(','||t.recv_userid||',',','||?||',')>0 ");
			condition.add(user_id);
		}
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
        for(int i=0;i<condition.size();i++){
        	pdb.setString(i+1, condition.get(i));
        }
		
		pdb.executePrepared(conn);
		return true;
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
	public PagingBean queryMessageList(MessageRecvBean rbean,MessageSendBean sbean, PageInfoBean page) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			// 拼接的值
			List<String> condition = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select r.msg_id,");
			sql.append("       r.msg_content,");
			sql.append("       r.msg_type,");
			sql.append("       r.msg_url,");
			sql.append("       t.isread,");
			sql.append("       t.recv_id,");
			sql.append("       r.send_userid,");
			sql.append("       r.send_orgid,");
			sql.append("       to_char(r.send_date, 'yyyy-mm-dd hh24:mi:ss') as send_date,");
			sql.append("       u.user_realname as user_name");
			sql.append("  from  oa_msg_recv t,");
			sql.append("   oa_msg_send r");
			sql.append("  left join td_sm_user u on r.send_userid = u.user_id  ");
			sql.append(" where t.msg_id = r.msg_id ");
			//接收人id
			if(!StringUtil.nullOrBlank(rbean.getRecv_userid())){
				sql.append(" and instr(','||t.recv_userid||',',','||?||',')>0 ");
				condition.add(rbean.getRecv_userid());
			}
			//是否已读标记
		    if(!StringUtil.nullOrBlank(rbean.getIsread())){
		    	sql.append(" and t.isread=?");
		    	condition.add(rbean.getRecv_userid());
		    }
		    //是否隐藏
		    if(!StringUtil.nullOrBlank(rbean.getIshidden())){
		    	sql.append(" and t.ishidden=?");
		    	condition.add(rbean.getIshidden());
		    }

	       if(!StringUtil.nullOrBlank(page.getSortName())  && !StringUtil.nullOrBlank(page.getSortOrder())){
		         sql.append(" order by t.isread,").append(page.getSortName()).append(" ").append(page.getSortOrder());
	       }else{
	 	     sql.append(" order by t.isread,r.send_date desc ");
	       }

			// 调父类的方法
			return queryToPagingBean(sql.toString(), page.getOffset(), page.getRows(), conn,
					condition);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 querySingleMsgById
	  * @param recvId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao#querySingleMsgById(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> querySingleMsgById(String recvId, Connection conn)
			throws Exception {

		StringBuffer sql = new StringBuffer();
		sql.append("select r.msg_id,");
		sql.append("       r.msg_content,");
		sql.append("       r.msg_type,");
		sql.append("       r.msg_url,");
		sql.append("       t.isread,");
		sql.append("       t.recv_id,");
		sql.append("       r.send_userid,");
		sql.append("       r.send_orgid,");
		sql
				.append("       to_char(r.send_date, 'yyyy-mm-dd hh24:mi:ss') as send_date,");
		sql.append("       u.user_realname as user_name");
		sql.append("  from  oa_msg_recv t,");
		sql.append("   oa_msg_send r");
		sql.append("  left join td_sm_user u on r.send_userid = u.user_id  ");
		sql.append(" where t.msg_id = r.msg_id and t.recv_id=?");
		return super.queryToSingleMap(conn, sql.toString(), recvId);
	}
	
	/**
	 * 
	*<b>Summary: 根据用户id，统计未读的记录条数</b>
	* countUnReadMessage()
	* @return
	 * @throws SQLException 
	 */
	public Integer countUnReadMessage(String userId,Connection conn) throws SQLException{
		String sql = "select count(*) as allCount from oa_msg_recv a "
			+" where a.ishidden = '0' and a.isread='0' and a.recv_userid = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, userId);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			return pdb.getInt(0, "allCount");
		}else{
			return 0;
		}
	}
	
}
package com.chinacreator.xtbg.core.vote.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.MessageSendDao;
import com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:MessageSendDaoImplYMJ.java
 * </p>
 *<p>
 * Description:移民局实现短信发送接口
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-21
 */
public class MessageSendDaoImplYMJ implements MessageSendDao<OAVotePaperBean> {

	/**
	 * 
	 * <b>Summary: </b> 复写方法 sendMsg
	 * 
	 * @param msg
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.vote.dao.MessageSendDao#sendMsg(java.util.Map)
	 */
	@Override
	public boolean sendMsg(OAVotePaperBean bean, Connection con)
			throws SQLException {
           
		if (null == bean) {
			return false;
		}	
		// 短信内容
		String messageContent = StringUtil.deNull(bean.getMessage_content());
		// 需要接受短信的人员id列表
		String userIds = StringUtil.deNull(bean.getPeople_ids());
        //短信id
		String msgId = StringUtil.getUUID();
		
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into oa_note_buffer ");
		sql.append("  (buffer_id, content, create_date, send_date, need_status,  ");
		sql.append(" need_content, retry_times, user_id, user_name, org_id, org_name)");
		sql.append(" values ('"+msgId+"',?,sysdate,sysdate,'0','0',0,?,?,?,?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		int i = 1;
		pdb.setString(i++, messageContent);
		pdb.setString(i++, bean.getUser_id());
		pdb.setString(i++, bean.getUser_name());
		pdb.setString(i++, bean.getOrg_id());
		pdb.setString(i++, bean.getOrg_name());
		pdb.executePrepared(con);
		
		StringBuffer sqlRecv = new StringBuffer();
		
		sqlRecv.append("insert into oa_note_detail");
		sqlRecv.append("  (recv_id, buffer_id, phone_num, user_id, user_name)");
		sqlRecv.append(" select sys_guid(),'"+msgId+"',user_mobiletel1,");
		sqlRecv.append(" user_id,user_realname ");
		sqlRecv.append(" from td_sm_user where user_mobiletel1 is not null ");
		
		// 传入了用户id列表，则插入传入了的id列表.没有传入id列表，则全表插入
		if (!StringUtil.nullOrBlank(userIds)) {
			String[] idArray = userIds.split(",");
			if (idArray.length < 1000) {
				sqlRecv.append(" and user_id in (" + userIds + ") ");
			} else {
				// 避免in语句包含的id过多，拼接多个或关系的in语句
				sqlRecv.append(joinSql(idArray, "user_id"));
			}
		}		
		// 执行数据库操作
		pdb.preparedInsert(sqlRecv.toString());
		pdb.executePrepared(con);		
		return true;
	}

	/**
	 * 
	 *<b>Summary: in 语句最多一次只能存在1000条记录，避免报错，拼接or连接多个in </b>
	 * joinSql(请用一句话描述这个方法的作用)
	 * 
	 * @param idArray
	 *            id数据
	 * @param column
	 *            执行in查询的列
	 * @return
	 */
	private String joinSql(String[] idArray, String column) {

		StringBuffer sql = new StringBuffer();

		sql.append(" and( " + column + " in ( ");
		// 拼接sql
		for (int i = 0; i < idArray.length; i++) {

			// 第一千条或最后一条不拼接分隔符","
			if ((i + 1) % 1000 == 0 || i == idArray.length - 1) {
				sql.append(idArray[i]);
			} else {
				sql.append(idArray[i] + ",");
			}
			// 超过1000条，则拼接 or 语句
			if ((i + 1) % 1000 == 0) {
				sql.append(" ) or " + column + " in ( ");
			}
		}

		sql.append(" ) )");

		return sql.toString();
	}

}

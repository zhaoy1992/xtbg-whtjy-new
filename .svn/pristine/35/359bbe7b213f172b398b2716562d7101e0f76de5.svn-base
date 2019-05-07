package com.chinacreator.xtbg.core.common.msgtodo.dao.impl;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.msgtodo.dao.MsgTodoDao;
import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoRecvBean;
import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoSendBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:MsgTodoDao.java</p>
 *<p>Description:统一待办数据处理实现层DAOIMPL</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author yin.liu
 *@version 1.0
 *2013-12-10
 */
public class MsgTodoDaoImpl implements MsgTodoDao {

	/**
	 * 新增待办主信息表数据
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoSend(MsgTodoSendBean bean,Connection conn) throws Exception{
		String sql = "insert into oa_msg_todo_send(msg_id,msg_title,msg_type,msg_url,send_userid,send_username,send_orgid,send_orgname,send_date,bus_id) values(?,?,?,?,?,?,?,?,sysdate,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int k = 1;
		pdb.setString(k++, bean.getMsg_id());
		pdb.setString(k++, bean.getMsg_title());
		pdb.setString(k++, bean.getMsg_type());
		pdb.setString(k++, bean.getMsg_url());
		pdb.setString(k++, bean.getSend_userid());
		pdb.setString(k++, bean.getSend_username());
		pdb.setString(k++, bean.getSend_orgid());
		pdb.setString(k++, bean.getSend_orgname());
		pdb.setString(k++, bean.getBus_id());
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 新增待办接收者表数据
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoRecv(MsgTodoRecvBean bean,Connection conn) throws Exception{
		String sql = "insert into oa_msg_todo_recv(recv_id,msg_id,recv_userid,recv_username,recv_orgid,recv_orgname,type) values(?,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int k = 1;
		pdb.setString(k++, bean.getRecv_id());
		pdb.setString(k++, bean.getMsg_id());
		pdb.setString(k++, bean.getRecv_userid());
		pdb.setString(k++, bean.getRecv_username());
		pdb.setString(k++, bean.getRecv_orgid());
		pdb.setString(k++, bean.getRecv_orgname());
		pdb.setString(k++, bean.getType());
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 新增待办接收者表数据
	 * @param beanList
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoRecv(List<MsgTodoRecvBean> beanList,Connection conn) throws Exception{
		String sql = "insert into oa_msg_todo_recv(recv_id,msg_id,recv_userid,recv_username,recv_orgid,recv_orgname,type) values(?,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(beanList != null && beanList.size() > 0){
			for(MsgTodoRecvBean bean : beanList){
				pdb.preparedInsert(sql);
				int k = 1;
				pdb.setString(k++, bean.getRecv_id());
				pdb.setString(k++, bean.getMsg_id());
				pdb.setString(k++, bean.getRecv_userid());
				pdb.setString(k++, bean.getRecv_username());
				pdb.setString(k++, bean.getRecv_orgid());
				pdb.setString(k++, bean.getRecv_orgname());
				pdb.setString(k++, bean.getType());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}
	
	/**
	 * 删除待办主信息表数据
	 * @param msg_id 待办主表主键 msg_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoSend(String msg_id,Connection conn) throws Exception{
		String sql = "delete from oa_msg_todo_send where msg_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		int k = 1;
		pdb.setString(k++, msg_id);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 删除待办接收者表数据
	 * @param recv_id 待办接收者表主键 recv_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoRecv(String recv_id,Connection conn) throws Exception{
		String sql = "delete from oa_msg_todo_recv where recv_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		int k = 1;
		pdb.setString(k++, recv_id);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 删除待办接收者表数据
	 * @param msg_id 待办接收者表外键 msg_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoRecvByMsgId(String msg_id,Connection conn) throws Exception{
		String sql = "delete from oa_msg_todo_recv where msg_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		int k = 1;
		pdb.setString(k++, msg_id);
		pdb.executePrepared(conn);
		return true;
	}
}

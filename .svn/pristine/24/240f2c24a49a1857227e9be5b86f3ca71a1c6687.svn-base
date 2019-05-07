package com.chinacreator.xtbg.core.common.msgtodo.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoRecvBean;
import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoSendBean;

/**
 *<p>Title:MsgTodoDao.java</p>
 *<p>Description:统一待办数据处理接口层DAO</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author yin.liu
 *@version 1.0
 *2013-12-10
 */
public interface MsgTodoDao {

	/**
	 * 新增待办主信息表数据
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoSend(MsgTodoSendBean bean,Connection conn) throws Exception;
	
	/**
	 * 新增待办接收者表数据
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoRecv(MsgTodoRecvBean bean,Connection conn) throws Exception;
	
	/**
	 * 新增待办接收者表数据
	 * @param beanList
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoRecv(List<MsgTodoRecvBean> beanList,Connection conn) throws Exception;
	
	/**
	 * 删除待办主信息表数据
	 * @param msg_id 待办主表主键 msg_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoSend(String msg_id,Connection conn) throws Exception;
	
	/**
	 * 删除待办接收者表数据
	 * @param recv_id 待办接收者表主键 recv_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoRecv(String recv_id,Connection conn) throws Exception;
	
	/**
	 * 删除待办接收者表数据
	 * @param msg_id 待办接收者表外键 msg_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoRecvByMsgId(String msg_id,Connection conn) throws Exception;
	
}

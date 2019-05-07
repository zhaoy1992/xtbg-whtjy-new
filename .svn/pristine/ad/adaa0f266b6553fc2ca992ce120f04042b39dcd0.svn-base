package com.chinacreator.xtbg.core.common.msgtodo.services;

import java.sql.Connection;
import java.util.List;

/**
 *<p>Title:MsgTodoService.java</p>
 *<p>Description:统一待办业务处理接口层</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author yin.liu
 *@version 1.0
 *2013-12-10
 */
public interface MsgTodoService {

	/**
	 * 添加待办信息（接收者以List集合形式）
	 * @param busId 业务ID
	 * @param title 标题
	 * @param type 类型
	 * @param url 链接地址
	 * @param sendUserId 发送人ID
	 * @param recvUserIds 接收人ID集合List
	 * @param recvType 接收者类型（1个人、2单位）
	 * @param conn 
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoInfo(String busId,String title,String type,String url,String sendUserId,List<String> recvUserIds,String recvType, Connection conn) throws Exception;
	
	/**
	 * 添加待办信息（接收者以逗号[,]隔开形式）
	 * @param busId 业务ID
	 * @param title 标题
	 * @param type 类型
	 * @param url 链接地址
	 * @param sendUserId 发送人ID
	 * @param recvUserIds 接收人ID串（多个以逗号[,]隔开）
	 * @param recvType 接收者类型（1个人、2单位）
	 * @param conn 
	 * @return
	 * @throws Exception
	 */
	public boolean addMsgTodoInfo(String busId, String title,String type,String url,String sendUserId,String recvUserIds,String recvType, Connection conn) throws Exception;
	
	
	/**
	 * 删除待办信息（删除个人接收表中信息）
	 * @param recvId 接收信息表主键接收id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByRecvId(String recvId, Connection conn) throws Exception;
	
	/**
	 * 没有事物处理
	 * 删除待办信息（删除待办主信息并删除该待办主信息的所有接收者表中信息）
	 * @param msgId 待办主表主键待办id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByMsgId(String msgId, Connection conn) throws Exception;
	
	/**
	 * 有事物处理
	 * 删除待办信息（删除待办主信息并删除该待办主信息的所有接收者表中信息）
	 * @param msgId 待办主表主键待办id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByMsgId(String msgId) throws Exception;
}

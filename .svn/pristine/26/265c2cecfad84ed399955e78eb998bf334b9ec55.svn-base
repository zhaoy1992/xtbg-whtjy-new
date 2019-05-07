package com.chinacreator.xtbg.core.common.msgtodo.services.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.msgtodo.dao.MsgTodoDao;
import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoRecvBean;
import com.chinacreator.xtbg.core.common.msgtodo.entity.MsgTodoSendBean;
import com.chinacreator.xtbg.core.common.msgtodo.services.MsgTodoService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:MsgTodoServiceImpl.java</p>
 *<p>Description:统一待办业务处理实现层</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author yin.liu
 *@version 1.0
 *2013-12-10
 */
public class MsgTodoServiceImpl implements MsgTodoService {

	private static final Logger LOG = Logger.getLogger(MsgTodoServiceImpl.class);
			
	/**
	 * 添加待办信息（接收者以List集合形式）
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
	public boolean addMsgTodoInfo(String busId,String title,String type,String url,String sendUserId,List<String> recvUserIds,String recvType, Connection conn) throws Exception{
		if (StringUtil.nullOrBlank(title)
				|| StringUtil.nullOrBlank(sendUserId)) {
			LOG.error("没有传入待办内容或者发送人id");
			return false;
		}
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(sendUserId);
		if(userCacheBean == null){
			userCacheBean = new UserCacheBean();
			LOG.error("根据sendUserId未找到其用户信息");
		}
		MsgTodoSendBean sendBean = new MsgTodoSendBean();
		String msg_id = StringUtil.getUUID();// 待办id
		sendBean.setMsg_id(msg_id);
		sendBean.setMsg_title(title);
		sendBean.setMsg_type(type);
		sendBean.setMsg_url(url);
		sendBean.setSend_orgid(userCacheBean.getOrg_id());
		sendBean.setSend_orgname(userCacheBean.getOrg_name());
		sendBean.setSend_userid(sendUserId);
		sendBean.setSend_username(userCacheBean.getUser_realname());
		sendBean.setBus_id(busId);
		
		MsgTodoDao dao = (MsgTodoDao) LoadSpringContext.getApplicationContext().getBean("MsgTodoDao");
		dao.addMsgTodoSend(sendBean, conn); // 插入待办主信息
		
		if (null != recvUserIds && !recvUserIds.isEmpty()) {
			MsgTodoRecvBean recvBean = null;
			String recv_id = "";
			UserCacheBean userRecvBean = null;
			OrgCacheBean orgCacheBean = null;
			List<MsgTodoRecvBean> beanList = new ArrayList<MsgTodoRecvBean>();
			for (String rId : recvUserIds) {
				recv_id = StringUtil.getUUID();// 接收ID
				recvBean = new MsgTodoRecvBean();
				recvBean.setRecv_id(recv_id);
				recvBean.setMsg_id(msg_id);
				recvBean.setType(recvType);
				if("1".equals(recvType)){ // 个人
					userRecvBean = UserCache.getUserCacheBean(rId);
					if(userRecvBean == null){
						userRecvBean = new UserCacheBean();
						LOG.error("根据rId未找到其用户信息");
					}
					recvBean.setRecv_userid(rId);
					recvBean.setRecv_username(userRecvBean.getUser_realname());
					recvBean.setRecv_orgid(userRecvBean.getOrg_id());
					recvBean.setRecv_orgname(userRecvBean.getOrg_name());
				}else if("2".equals(recvType)){ // 机构
					recvBean.setRecv_orgid(rId);
					orgCacheBean = OrgCache.getOrgCacheBean(rId);
					if(orgCacheBean == null){
						orgCacheBean = new OrgCacheBean();
						LOG.error("根据rId未找到其机构信息");
					}
					recvBean.setRecv_orgname(orgCacheBean.getOrg_name());
				}else{
					LOG.error("传入的接收者类型不符合规范");
				}
//				dao.addMsgTodoRecv(recvBean, conn);
				beanList.add(recvBean);
			}
			dao.addMsgTodoRecv(beanList, conn);
		}else{
			// 给出提示，不抛出异常
			LOG.error("没有传入待办接收人id列表");
		}
		return true;
	}
	
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
	public boolean addMsgTodoInfo(String busId, String title,String type,String url,String sendUserId,String recvUserIds,String recvType, Connection conn) throws Exception{
		if(StringUtil.nullOrBlank(recvUserIds)){
			LOG.error("没有传入接收者信息");
			return false;
		}
		String[] recvUserIdArr = recvUserIds.split(",");
		List<String> recvUserIdList = new ArrayList<String>();
		for(String rid : recvUserIdArr){
			recvUserIdList.add(rid);
		}
		return addMsgTodoInfo(busId, title, type, url, sendUserId, recvUserIdList, recvType, conn);
	}
	
	
	/**
	 * 删除待办信息（删除个人接收表中信息）
	 * @param recvId 接收信息表主键接收id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByRecvId(String recvId, Connection conn) throws Exception{
		MsgTodoDao dao = (MsgTodoDao) LoadSpringContext.getApplicationContext().getBean("MsgTodoDao");
		return dao.deleteMsgTodoRecv(recvId, conn);
	}
	
	/**
	 * 删除待办信息（删除待办主信息并删除该待办主信息的所有接收者表中信息）
	 * @param msgId 待办主表主键待办id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByMsgId(String msgId, Connection conn) throws Exception{
		boolean flag = false;
		MsgTodoDao dao = (MsgTodoDao) LoadSpringContext.getApplicationContext().getBean("MsgTodoDao");
		flag = dao.deleteMsgTodoRecvByMsgId(msgId, conn);
		flag = dao.deleteMsgTodoSend(msgId, conn);
		return flag;
	}
	
	/**
	 * 有事物处理
	 * 删除待办信息（删除待办主信息并删除该待办主信息的所有接收者表中信息）
	 * @param msgId 待办主表主键待办id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMsgTodoInfoByMsgId(String msgId) throws Exception{
		boolean flag = false;
		Connection conn = null;
		MsgTodoDao dao = (MsgTodoDao) LoadSpringContext.getApplicationContext().getBean("MsgTodoDao");
		try{
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.deleteMsgTodoRecvByMsgId(msgId, conn);
			if(flag){
				flag = dao.deleteMsgTodoSend(msgId, conn);
				if(flag){
					conn.commit();
				}else{
					DbManager.rollBackNoThrow(conn);
				}
			}else{
				DbManager.rollBackNoThrow(conn);
			}
		}catch(Exception e){
			flag = false;
			DbManager.rollBackNoThrow(conn);
			throw e;
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}

package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomAdministratorBean;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingRoomService;
/**
 * 
 *<p>Title:MeetingRoomServiceImpl.java</p>
 *<p>Description:会议室管理service接口实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-25
 */
public class MeetingRoomServiceImpl implements MeetingRoomService {
	private static final Logger LOG = Logger
			.getLogger(MeetingRoomServiceImpl.class);
	private MeetingRoomDao dao = null;

	/**
	 * 
	  * <b>Summary:构造器，初始化dao对象 </b>
	  *     构造一个 MeetingRoomServiceImpl  
	   * <b>Remarks: </b>
	  *     构造类 MeetingRoomServiceImpl 的构造函数 MeetingRoomServiceImpl
	 */
	public MeetingRoomServiceImpl() {
		try {
			this.dao = (MeetingRoomDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomDaoImpl");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteListMeetingRoom
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#deleteListMeetingRoom(java.lang.String)
	 */
	public String deleteListMeetingRoom(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			if (StringUtil.nullOrBlank(ids)) {
				return "{\"flag\":\"false\",\"msg\":\"删除成功\"}";
			}
			
			String[] idArray = ids.split(",");
			// 删除成功的记录条数
			int successCount = 0;
			// 删除失败的记录条数
			int failCount = 0;
			// 可以被删除的id
			StringBuffer deleteIds = new StringBuffer();
			for (String id : idArray) {
				// 类型是否已经被引用
				boolean flag = dao.isMeetingRoomUsed(id, conn);
				// 已存在，则不能删除
				if (flag) {
					failCount++;
				} else {
					successCount++;
					deleteIds.append(id + ",");
				}
			}

			if (deleteIds.length() > 0) {
				String lastDeleteIds = deleteIds.substring(0, deleteIds
						.length() - 1);
				// 执行删除操作
				((BaseDao) dao).deleteListById(new MeetingRoomBean(), conn,
						lastDeleteIds);
				//删除对应的会议室管理员信息
				((BaseDao) dao).deleteListById(new MeetingRoomAdministratorBean()
						.setDeleteKey("m_room_id"), conn, lastDeleteIds);
			}

			String returnStr = "删除成功";
			if (0 != failCount) {
				returnStr = "成功删除<span style=\"color:red;font-weight:bold;\">"
						+ successCount
						+ "</span>条记录<br/>存在<span style=\"color:red;font-weight:bold;\">"
						+ failCount + "</span>个会议室已经被会议使用，不能删除";
			}

			// 要返回的json
			JSONObject json = new JSONObject();
			json.put("flag", "true");
			json.put("msg", returnStr);
			// 关闭连接并提交事务
			DbManager.closeTransactionConnection(conn, true);
			return json.toString();

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return "{\"flag\":\"false\",\"msg\":\"删除失败\"}";
		}
	}

	/**
	 * 
	*<b>Summary: 根据id装载会议室数据</b>
	* queryToMeetingTypeBean(请用一句话描述这个方法的作用)
	* @param id   会议室id
	* @return     会议室bean对象
	 */
	public MeetingRoomBean queryToMeetingRoomBean(String id) {
		MeetingRoomBean room = new MeetingRoomBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			room.setM_room_id(id);
			return (MeetingRoomBean)((BaseDao)dao).queryToBean(room, conn);			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return room;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertMeetingRoomBean
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#insertMeetingRoomBean(java.lang.String)
	 */
	@Override
	public boolean insertMeetingRoomBean(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
			// 将字符串转换为bean
			MeetingRoomBean bean = StringUtil.convertStringToBean(json,
					MeetingRoomBean.class);
			// id赋初值
			bean.setM_room_id(StringUtil.getUUID());
			// 将字符串时间转换为Timestamp
			bean.setM_reg_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getM_reg_time())));

			// 插入会议室
			((BaseDao) dao).insert(bean, conn);
			// 插入会议室管理员信息
			insertRoomAdministor(bean, dao, conn);

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertMeetingRoomBean
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#insertMeetingRoomBean(java.lang.String)
	 */
	@Override
	public boolean updateMeetingRoomBean(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			
			// 将字符串转换为bean
			MeetingRoomBean bean = StringUtil.convertStringToBean(json,
					MeetingRoomBean.class);
			// 将字符串时间转换为Timestamp
			bean.setM_reg_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getM_reg_time())));

			// 插入会议室
			((BaseDao) dao).update(bean, conn);
			// 插入会议室管理员信息
			insertRoomAdministor(bean, dao, conn);

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}
	
	/**
	 * 
	*<b>Summary: 批量插入会议室管理员信息</b>
	* insertEvalList(请用一句话描述这个方法的作用)
	* @param room   会议室对象
	* @param dao    数据库操作dao接口
	* @param conn   数据库连接
	* @throws Exception
	 */
	private void insertRoomAdministor(MeetingRoomBean room,MeetingRoomDao dao, Connection conn)
			throws Exception {

		if (null == room || StringUtil.nullOrBlank(room.getM_room_id())) {
			return;
		}
		// 先删除存在的管理员信息
		((BaseDao)dao).deleteListById(new MeetingRoomAdministratorBean().setDeleteKey("m_room_id"),
				conn, room.getM_room_id());
		
		// 插入管理员信息
		dao.insertRoomAdministor(room.getM_room_id(),room.getAdministrator_ids(),conn);
		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListMeetingRoom
	  * @param conditions
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#queryListMeetingRoom(java.util.Map)
	 */
	@Override
	public List<MeetingRoomBean> queryListMeetingRoom(
			String orgId) {
		Connection conn = null;	    
		try{
			conn = DbManager.getInstance().getConnection();
			return dao.queryListMeetingRoom(orgId, conn);
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			return new ArrayList<MeetingRoomBean>();
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	public static void main(String []args){
		LOG.error("aa".substring(0, 15));
	}
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isMeetingRoomUsed 判断会议室是否已经被使用
	  * @param json
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingRoomService#isMeetingRoomUsed(java.lang.String) 
	  */
	public boolean isMeetingRoomUsed(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为bean
			MeetingRoomBean bean = StringUtil.convertStringToBean(json,
					MeetingRoomBean.class);

			return dao.isMeetingRoomUsed(bean.getM_room_id(), conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}

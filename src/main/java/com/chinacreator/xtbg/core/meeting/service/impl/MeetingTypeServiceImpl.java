package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTypeDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingTypeService;

/**
 * 
 *<p>
 * Title:MeetingTypeServiceImpl.java
 * </p>
 *<p>
 * Description: 会议类型管理操作service接口实现类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-22
 */
public class MeetingTypeServiceImpl implements MeetingTypeService {
	private static final Logger LOG = Logger
			.getLogger(MeetingTypeServiceImpl.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteListMeetingtype
	 * 
	 * @param ids
	 * @return
	 * @see com.chinacreator.xtbg.core.meeting.service.MeetingTypeService#deleteListMeetingtype(java.lang.String)
	 */
	@Override
	public String deleteListMeetingtype(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			if (StringUtil.nullOrBlank(ids)) {
				return "{\"flag\":\"false\",\"msg\":\"删除成功\"}";
			}
			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTypeDaoImpl");

			String[] idArray = ids.split(",");
			// 删除成功的记录条数
			int successCount = 0;
			// 删除失败的记录条数
			int failCount = 0;
			// 可以被删除的id
			StringBuffer deleteIds = new StringBuffer();
			for (String id : idArray) {
				// 类型是否已经被引用
				boolean flag = dao.isMeetingTypeUsed(id, conn);
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
				((BaseDao) dao).deleteListById(new MeetingTypeBean(), conn,
						lastDeleteIds);
			}

			String returnStr = "删除成功";
			if (0 != failCount) {
				returnStr = "成功删除<span style=\"color:red;font-weight:bold;\">"
						+ successCount
						+ "</span>条记录<br/>存在<span style=\"color:red;font-weight:bold;\">"
						+ failCount + "</span>条记录已经被会议引用，不能删除";
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
			DbManager.closeTransactionConnection(conn, true);
			LOG.error(e.getMessage(), e);
			return "{\"flag\":\"false\",\"msg\":\"删除失败\"}";
		}
	}

	/**
	 * 
	 *<b>Summary: 根据id查询会议类型信息</b> queryToOAVotePaperBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            会议类型id
	 * @return 会议类型bean对象
	 */
	public MeetingTypeBean queryToMeetingTypeBean(String id) {
		MeetingTypeBean type = new MeetingTypeBean();
		try {
			type.setM_type_id(id);
			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTypeDaoImpl");
			type = (MeetingTypeBean) dao.queryToBean(type);
			return type;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return type;
		}
	}

	/**
	 * 
	*<b>Summary: 插入会议类型</b>
	* insertMeetingTypeBean(请用一句话描述这个方法的作用)
	* @param json 会议类型的json字符串
	* @return 是否保存成功的标志
	 */
	public boolean insertMeetingTypeBean(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTypeDaoImpl");

			// 将json字符串转换为对象
			MeetingTypeBean type = StringUtil.convertStringToBean(json,
					MeetingTypeBean.class);
			// 设置初始值
			type.setM_type_id(StringUtil.getUUID());
			type.setM_reg_time(new Timestamp(System.currentTimeMillis()));

			// 插入操作
			((BaseDao) dao).insert(type, conn);
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
	*<b>Summary:更新会议类型</b>
	* insertMeetingTypeBean(请用一句话描述这个方法的作用)
	* @param json 会议类型的json字符串
	* @return 是否更新成功的标志
	 */
	public boolean updateMeetingTypeBean(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTypeDaoImpl");

			// 将json字符串转换为对象
			MeetingTypeBean type = StringUtil.convertStringToBean(json,
					MeetingTypeBean.class);
			// 将字符串转换为日期类型
			type.setM_reg_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(type.getM_reg_time())));

			// 更新操作
			((BaseDao) dao).update(type, conn);
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
    *<b>Summary:根据机构id查询会议类型信息 </b>
    * queryListMeetingTypeByOrgId()
    * @param orgId
    * @return
     */
	public List<MeetingTypeBean> queryListMeetingTypeByOrgId(String orgId){
		Connection conn = null;	    
		try{
			conn = DbManager.getInstance().getConnection();
			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
			.getApplicationContext().getBean("meetingTypeDaoImpl");

			return dao.queryListMeetingTypeByOrgId(orgId);
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			return new ArrayList<MeetingTypeBean>();
		}finally{
			DbManager.closeConnection(conn);
		}
	}
}

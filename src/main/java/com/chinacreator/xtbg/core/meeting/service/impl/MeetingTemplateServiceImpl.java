package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTemplateDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTemplateBean;
import com.chinacreator.xtbg.core.meeting.service.MeetingTemplateService;
/**
 * 
 *<p>Title:MeetingTemplateServiceImpl.java</p>
 *<p>Description:会议模板管理service接口实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-29
 */
public class MeetingTemplateServiceImpl implements MeetingTemplateService {
	private static final Logger LOG = Logger
			.getLogger(MeetingTemplateServiceImpl.class);

	MeetingTemplateDao dao = null;
    /**
     * 
      * <b>Summary: </b>
      *     构造一个 MeetingTemplateServiceImpl  
       * <b>Remarks: </b>
      *     构造类 MeetingTemplateServiceImpl 的构造函数 MeetingTemplateServiceImpl
     */
	public MeetingTemplateServiceImpl() {
		try {
			this.dao = (MeetingTemplateDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTemplateDaoImpl");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteListMeetingTemplate
	 * 
	 * @param ids
	 * @return
	 * @see com.chinacreator.xtbg.core.meeting.service.MeetingTemplateService#deleteListMeetingTemplate(java.lang.String)
	 */
	@Override
	public boolean deleteListMeetingTemplate(String ids) {
		// 数据库连接
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			if (StringUtil.nullOrBlank(ids)) {
				return true;
			}
			// 执行删除操作
			((BaseDao) dao)
					.deleteListById(new MeetingTemplateBean(), conn, ids);
			// 提交事务
			conn.commit();
			return true;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
   /**
	* 
	* <b>Summary: </b>
	*     复写方法 queryToMeetingTemplateBean
	* @param id
	* @return 
	* @see com.chinacreator.xtbg.core.meeting.service.MeetingTemplateService#queryToMeetingTemplateBean(java.lang.String)
	*/
	public MeetingTemplateBean queryToMeetingTemplateBean(String id) {
		MeetingTemplateBean bean = new MeetingTemplateBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			bean.setM_tmp_id(id);
			return (MeetingTemplateBean) ((BaseDao) dao)
					.queryToBean(bean, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return bean;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryToMeetingTemplateJSON
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingTemplateService#queryToMeetingTemplateJSON(java.lang.String)
	 */
	public String queryToMeetingTemplateJSON(String id) {
		MeetingTemplateBean bean = new MeetingTemplateBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			//查询列赋值
			bean.setM_tmp_id(id);
			//查询数据
			bean = (MeetingTemplateBean) ((BaseDao) dao)
					.queryToBean(bean, conn);
			//结果封装成json
			JSONObject json = new JSONObject();
			json.put("flag", "true");
			json.put("msg", JSONObject.toJSON(bean));
			return json.toString();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return "{\"flag\":\"false\",\"msg\":\"操作失败!\"}";
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 插入会议模板</b>
	* insertMeetingTemplate()
	* @param bean 会议模板对象
	* @return 插入是否成功的标志
	 */
	public boolean insertMeetingTemplate(MeetingTemplateBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();

			// id赋初值
			bean.setM_tmp_id(StringUtil.getUUID());

			// 将字符串时间转换为Timestamp
			bean.setM_tmp_create_time(StringUtil.convertStringToTimestamp(bean
					.getM_tmp_create_time()));
			// 会议开始时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm）
			bean.setM_begin_time(StringUtil.convertStringToTimestamp(bean
					.getM_begin_time()));
			// 会议结束时间
			bean.setM_end_time(StringUtil.convertStringToTimestamp(bean
					.getM_end_time()));
			bean.setM_close_time(StringUtil.convertStringToTimestamp(bean
					.getM_close_time()));

			//插入
			((BaseDao) dao).insert(bean, conn);
			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}	
	
	/**
	 * 
	*<b>Summary: 更新会议模板</b>
	* insertMeetingTemplate()
	* @param bean 会议模板对象
	* @return 插入是否成功的标志
	 */
	public boolean updateMeetingTemplate(MeetingTemplateBean bean) {
		Connection conn = null;
		try {
			if (null == bean) {
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串时间转换为Timestamp
			bean.setM_tmp_create_time(StringUtil.convertStringToTimestamp(bean
					.getM_tmp_create_time()));
			// 会议开始时间转换为Timestamp对象（由于其格式为yyyy-MM-dd hh:mm）
			bean.setM_begin_time(StringUtil.convertStringToTimestamp(bean
					.getM_begin_time()));
			// 会议结束时间
			bean.setM_end_time(StringUtil.convertStringToTimestamp(bean
					.getM_end_time()));
			bean.setM_close_time(StringUtil.convertStringToTimestamp(bean
					.getM_close_time()));

			//插入
			((BaseDao) dao).update(bean, conn);

			conn.commit();
			return true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
	}	
}

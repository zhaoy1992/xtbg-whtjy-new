package com.chinacreator.xtbg.core.holiday.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.holiday.dao.DailyDao;
import com.chinacreator.xtbg.core.holiday.entity.Daily;
import com.chinacreator.xtbg.core.holiday.service.DailyService;
/**
 * 
 *<p>Title:DailyServiceImpl.java</p>
 *<p>Description:工作时间管理服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-23
 */
public class DailyServiceImpl implements DailyService {

	private static final Log LOG=LogFactory.getLog(DailyServiceImpl.class);
	/**
	 * 
	  * <b>Summary:根据id查询工作时间的基本信息 </b>
	  *     复写方法 findDailyByWorkId
	  * @param workId
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.DailyService#findDailyByWorkId(java.lang.String)
	 */
	public Map<String, String> findDailyByWorkId(String workId) {
		Connection conn=null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DailyDao dao=(DailyDao)LoadSpringContext.getApplicationContext().getBean("dailyDaoImpl");
			map = dao.findDailyByWorkId(workId, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary:根据ids删除相应的工作时间信息 </b>
	  *     复写方法 delDailyByIds
	  * @param idsStr
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.DailyService#delDailyByIds(java.lang.String)
	 */
	public boolean delDailyByIds(String idsStr) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DailyDao dao=(DailyDao)LoadSpringContext.getApplicationContext().getBean("dailyDaoImpl");
			Daily daily=new Daily();
			daily.setDeleteKey("work_id");
			
			((BaseDao)dao).deleteListById(daily, conn, idsStr);
			flag=true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary:添加工作时间信息 </b>
	  *     复写方法 addDaily
	  * @param daily
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.DailyService#addDaily(com.chinacreator.xtbg.core.holiday.entity.Daily)
	 */
	public boolean addorupdateDaily(Daily daily) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DailyDao dao=(DailyDao)LoadSpringContext.getApplicationContext().getBean("dailyDaoImpl");
			//设置最后修改时间
			daily.setLast_modify_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss"));
			
			if(StringUtil.isBlank(daily.getWork_id())){
				daily.setWork_id(StringUtil.getUUID());
				((BaseDao)dao).insert(daily, conn);
			}else{
				((BaseDao)dao).update(daily, conn);
			}
			
			flag=true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary:判断该工作日期是否冲突 </b>
	  *     复写方法 findAcross
	  * @param daily
	  * @return 
	  * @see com.chinacreator.xtbg.core.holiday.service.DailyService#findAcross(com.chinacreator.xtbg.core.holiday.entity.Daily)
	 */
	public String findAcross(Daily daily) {
		Connection conn=null;
		String msg="";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DailyDao dao=(DailyDao)LoadSpringContext.getApplicationContext().getBean("dailyDaoImpl");
			msg = dao.findAcross(daily, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return msg;
	}

}

package com.chinacreator.xtbg.core.meeting.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.meeting.dao.MeetingDao;
import com.chinacreator.xtbg.core.meeting.service.MeetingServiceIfc;

/**
 *<p>Title:MeetingServiceImpl.java</p>
 *<p>Description:会议管理 服务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingServiceImpl implements MeetingServiceIfc {

	private static final Logger LOG = Logger.getLogger(MeetingServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 根据ids得到从新封装会议接收人的列表显示信息</b>
	  *     复写方法 getReceiverUserNames
	  * @param user_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.meeting.service.MeetingServiceIfc#getReceiverUserNames(java.lang.String)
	 */
	public List<Map<String, String>> getReceiverUserNames(String user_ids) {
		Connection conn=null;
		List<Map<String, String>> map=new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MeetingDao meetingDao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			map = meetingDao.getReceiverUserNames(user_ids, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	
}

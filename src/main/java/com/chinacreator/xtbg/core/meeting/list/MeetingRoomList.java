package com.chinacreator.xtbg.core.meeting.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingRoomDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingRoomBean;

/**
 * 
 *<p>Title:MeetingRoomList.java</p>
 *<p>Description:查询会议室列表的类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-24
 */
public class MeetingRoomList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(MeetingRoomList.class);

	/**
	 * 
	 * <b>Summary: 查询数据</b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = null;
		try {
			MeetingRoomBean model = StringUtil.convertStringToBean(parmjson,
					MeetingRoomBean.class);

			MeetingRoomDao dao = (MeetingRoomDao) LoadSpringContext
					.getApplicationContext().getBean("meetingRoomDaoImpl");
			pb = dao.findMeetingRoomPageBean(model, sortName, sortOrder,
					offset, maxPagesize);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

	
}

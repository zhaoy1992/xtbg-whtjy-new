package com.chinacreator.xtbg.core.meeting.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingMinutesDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingMinutesReaderBean;
/**
 * 
 *<p>Title:MeetingMinutesReadList.java</p>
 *<p>Description:查询得到会议纪要阅读情况列表</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-27
 */
public class MeetingMinutesReadList extends DataInfoImpl {
	private static final Logger LOG = Logger.getLogger(MeetingMinutesReadList.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = null;
		try {
			MeetingMinutesReaderBean bean = StringUtil.convertStringToBean(
					parmjson, MeetingMinutesReaderBean.class);
			MeetingMinutesDao dao = (MeetingMinutesDao) LoadSpringContext
					.getApplicationContext().getBean("meetingMinutesDaoImpl");
			pb = dao.findMinutesReaderPaginBean(bean, sortName, sortOrder,
					offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @return
	 * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
}


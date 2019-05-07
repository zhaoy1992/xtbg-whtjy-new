package com.chinacreator.xtbg.core.meeting.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingTypeDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingTypeBean;

/**
 * 
 *<p>
 * Title:MeetingTypeList.java
 * </p>
 *<p>
 * Description:会议类型信息列表
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
public class MeetingTypeList extends DataInfoImpl {
	private static final Logger LOG = Logger.getLogger(MeetingTypeList.class);

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
			MeetingTypeBean model = StringUtil.convertStringToBean(parmjson,
					MeetingTypeBean.class);

			MeetingTypeDao dao = (MeetingTypeDao) LoadSpringContext
					.getApplicationContext().getBean("meetingTypeDaoImpl");
			pb = dao.findMeetingTypePageBean(model, sortName, sortOrder,
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
	 * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}

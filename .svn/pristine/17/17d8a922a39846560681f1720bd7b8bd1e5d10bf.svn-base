package com.chinacreator.xtbg.core.meeting.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingNoticeViewDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;
/**
 * 
 *<p>Title:MeetingNoticeViewList.java</p>
 *<p>Description:会议总查询列表查询类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-4
 */
public class MeetingNoticeViewList  extends DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(MeetingNoticeViewList.class);

	/**
	 * 
	 * <b>Summary: 查询数据</b> 复写方法 getDataList 
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
			//将josn字符串转换为对象
			MeetingNoticeBean bean = StringUtil.convertStringToBean(parmjson,
					MeetingNoticeBean.class);
            //实例化
			MeetingNoticeViewDao dao = (MeetingNoticeViewDao) LoadSpringContext
					.getApplicationContext().getBean("meetingNoticeViewDaoImpl");
			pb = dao.findMeetingNooticePageBean(bean, sortName, sortOrder, offset, maxPagesize);

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
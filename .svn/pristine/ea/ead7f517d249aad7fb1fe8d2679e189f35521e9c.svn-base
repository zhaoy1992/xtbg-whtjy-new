package com.chinacreator.xtbg.core.meeting.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingReceiverUserDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingReceiverUserBean;

/**
 *<p>Title:MeetingReceiverUserList.java</p>
 *<p>Description:与会单位报名情况列表查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-24
 */
public class MeetingReceiverUserList extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(MeetingReceiverUserList.class);
	
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		MeetingReceiverUserBean model = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			model = (MeetingReceiverUserBean) JSONObject.parseObject(parmjson, MeetingReceiverUserBean.class);
		}
		try {
			MeetingReceiverUserDao dao = (MeetingReceiverUserDao)LoadSpringContext.getApplicationContext().getBean("meetingReceiverUserDaoImpl");
			pb = dao.findMeetingReceiverUserList(model, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String) 
	  */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}

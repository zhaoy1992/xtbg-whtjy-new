package com.chinacreator.xtbg.core.meeting.list;


import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.meeting.dao.MeetingDao;
import com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean;

/**
 *<p>Title:MeetingNoticeList.java</p>
 *<p>Description:会议通知申请情况</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-24
 */
public class MeetingNoticeList extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(MeetingNoticeList.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		MeetingNoticeBean model = null;
		PagingBean pb = null;
		String timesupflag = "";
		String dotype = "";
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			String[] str = parmjson.split("---");
			if (str.length==2){
				parmjson = str[0];
				dotype = str[1];
			}else if (str.length==3){
				parmjson = str[0];
				dotype = str[1];
				timesupflag = str[2];
			}
			model = (MeetingNoticeBean) JSONObject.parseObject(parmjson, MeetingNoticeBean.class);
		}
		try {
			MeetingDao dao = (MeetingDao)LoadSpringContext.getApplicationContext().getBean("meetingDaoImpl");
			pb = dao.findMeetingNoticeList(model,timesupflag,dotype, sortName, sortOrder, offset, maxPagesize);
			
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

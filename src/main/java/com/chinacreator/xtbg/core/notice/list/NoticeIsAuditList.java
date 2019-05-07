package com.chinacreator.xtbg.core.notice.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao;
/**
 * 
 *<p>Title:NoticeTempList.java</p>
 *<p>Description:通知公告未审核列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-11-27
 */
public class NoticeIsAuditList  extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(NoticeIsAuditList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
		try {
			pb = noticeBaseInfoDao.selNoticeIsAuditList(parmjson, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
}

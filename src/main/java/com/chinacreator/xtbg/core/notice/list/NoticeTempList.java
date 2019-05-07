package com.chinacreator.xtbg.core.notice.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao;

/**
 * 
 *<p>Title:NoticeTempList.java</p>
 *<p>Description:通知公告草稿列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-20
 */
public class NoticeTempList extends DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(NoticeTempList.class);
	
	/**
	 * 
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
		PagingBean pb = new PagingBean();
		NoticeBaseInfoDao noticeBaseInfoDao = (NoticeBaseInfoDao)LoadSpringContext.getApplicationContext().getBean("noticeBaseInfoDaoImpl");
		try {
			pb = noticeBaseInfoDao.selNoticeTempList(parmjson, sortName, sortOrder, offset, maxPagesize);
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

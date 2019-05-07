package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;

/**
 * 我的借阅的档案--待借阅
 *<p>Title:MyFileLendingBeforeList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 10, 2013
 */
public class MyFileLendingForMeNowList extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(MyFileLendingForMeNowList.class);
	
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
		FileLendingDetailBean model = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			model = (FileLendingDetailBean) JSONObject.parseObject(parmjson, FileLendingDetailBean.class);
		}
		try {
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			pb = dao.MyFileLendingForMeNowList(model, sortName, sortOrder, offset, maxPagesize);
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

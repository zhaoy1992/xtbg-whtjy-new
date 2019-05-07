
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     CirculUserRead.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-7-31   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.archive.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.dao.CircularizeDao;
import com.chinacreator.xtbg.core.archive.entity.CircularizeBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:CirculUserReadList.java</p>
 *<p>Description:传阅性公文 查看列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-7-31
 */
public class CirculUserReadList extends DataInfoImpl{
	
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(CirculUserReadList.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 文件传阅实体bean
	  * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		CircularizeBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			bean = (CircularizeBean) JSONObject.parseObject(parmjson, CircularizeBean.class);
		}
		try {
			CircularizeDao dao = (CircularizeDao)LoadSpringContext.getApplicationContext().getBean("circularizeDaoImpl");
			pb = dao.findCirularizeUserReadList(bean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}
}


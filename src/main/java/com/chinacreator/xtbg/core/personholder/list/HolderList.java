
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     HolderList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.list;

import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;

/**
 *<p>Title:HolderList.java</p>
 *<p>Description:持证管理列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public class HolderList extends DataInfoImpl{
	
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(HolderList.class);
	
	/**
	 * 
	  * <b>Summary: 人员持证管理列表</b>
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
		PagingBean pb = null;
		try {
			PersonHolderDao daojson = (PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			pb = daojson.findPersonHolderList(parmjson, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}

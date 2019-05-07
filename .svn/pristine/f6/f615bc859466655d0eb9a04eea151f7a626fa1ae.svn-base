
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     KbmDocReceiveList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.kbm.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;

/**
 *<p>Title:KbmDocReceiveList.java</p>
 *<p>Description:体系文件浏览接收界面</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-1
 */
public class KbmDocReceiveList extends DataInfoImpl {
	
	private static final Log LOG = LogFactory.getLog(KbmDocReceiveList.class);
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
		KbmDocBean model = new KbmDocBean();
		PagingBean pb = null;
		KbmDocReceiveDao dao = (KbmDocReceiveDao)LoadSpringContext.getApplicationContext().getBean("kbmDocReceiveDaoImpl");
		if (!StringUtil.isBlank(parmjson) ) {
			model = (KbmDocBean) JSONObject.parseObject(parmjson, KbmDocBean.class);
		}
		try {
			pb = dao.queryKbmDocReceiveList(model, sortName, sortOrder, offset, maxPagesize);
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

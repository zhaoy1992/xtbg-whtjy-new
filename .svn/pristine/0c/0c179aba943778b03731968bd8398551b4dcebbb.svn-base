package com.chinacreator.xtbg.core.kbm.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;

/**
 *<p>Title:KbmDocList.java</p>
 *<p>Description:知识库查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-08-13
 */
public class KbmDocList4Where extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(KbmDocList.class);
	KbmDocDao dao = (KbmDocDao)LoadSpringContext.getApplicationContext().getBean("kbmDocDaoImpl");
	
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
		KbmDocBean model = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			model = (KbmDocBean) JSONObject.parseObject(parmjson, KbmDocBean.class);
		}
		try {
			pb = dao.queryKbmDocList4Where(model, sortName, sortOrder, offset, maxPagesize);
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

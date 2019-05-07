package com.chinacreator.xtbg.core.archive.gwcs.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwHandleBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:ReceiveGwHandleList.java</p>
 *<p>Description:来文办理情况列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-14
 */
public class ReceiveGwHandleList extends DataInfoImpl {

	private static final Log LOG=LogFactory.getLog(ReceiveGwHandleList.class);
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

		ReceiveGwHandleBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			bean = (ReceiveGwHandleBean) JSONObject.parseObject(parmjson, ReceiveGwHandleBean.class);
		}
		try {
			ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
			pb = dao.findReceiveGwHandleList(bean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
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

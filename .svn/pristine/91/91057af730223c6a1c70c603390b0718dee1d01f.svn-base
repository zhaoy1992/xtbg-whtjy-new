package com.chinacreator.xtbg.core.agency.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.agency.dao.AgencyDao;
import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:AgencyList.java</p>
 *<p>Description:委托待办查询列表界面</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-26
 */
public class AgencyList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(AgencyList.class);
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
		AgencyBean agencyBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			agencyBean = (AgencyBean) JSONObject.parseObject(parmjson, AgencyBean.class);
		}
		try {
			AgencyDao agencyDao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
			pb = agencyDao.findAgencyAll(agencyBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) { 
			LOG.error(e);
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

package com.chinacreator.xtbg.core.archive.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.archive.dao.WorkCountDao;
import com.chinacreator.xtbg.core.archive.entity.SearchBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

public class Worklistcount  extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(Worklistcount.class);
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
	  * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		 SearchBean searchBean =new SearchBean();
		 PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			searchBean = (SearchBean) JSONObject.parseObject(parmjson, SearchBean.class);
		}
		try {
			WorkCountDao dao = (WorkCountDao)LoadSpringContext.getApplicationContext().getBean("workCountDaoImpl");
			pb = dao.workcount(searchBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}
}

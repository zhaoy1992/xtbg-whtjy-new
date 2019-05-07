package com.chinacreator.xtbg.core.common.iweboffice.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.util.ListInfo;

/**
 * 
 *<p>Title:ThWordTemplateList.java</p>
 *<p>Description:套红模版列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-12
 */

public class ThWordTemplateList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(ThWordTemplateList.class);

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
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
			ListInfo info = new ListInfo();
			ThWordTemplateBean thWordTemplateBean = new ThWordTemplateBean();
		 
			PagingBean pb = null;
			if (!StringUtil.isBlank(parmjson) ) {
				parmjson = DataControlUtil.replaceStr(parmjson);
				parmjson = Escape.unescape(parmjson);
				thWordTemplateBean = (ThWordTemplateBean) JSONObject.parseObject(parmjson, ThWordTemplateBean.class);
			}
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			pb = wordTemplateDao.getThWordTemplateInfoList(thWordTemplateBean, sortName, sortOrder, offset, maxPagesize);
			info.setDatas(pb.getList());
			info.setTotalSize(pb.getRecords());
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	

}

package com.chinacreator.xtbg.pub.wordtemplate.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.pub.wordtemplate.dao.WordTemplateDao;
import com.chinacreator.xtbg.pub.wordtemplate.entity.RuleItemBean;


/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-16
 */

public class RuleItemList implements DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(RuleItemList.class);
	/**
	 * @Description  变量查询
	 * 
	 * @param keyname  参数说明
	 * @param uri
	 * @return  返回值说明
	 * @exception 异常说明
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		RuleItemBean RuleItemBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			RuleItemBean = (RuleItemBean) JSONObject.parseObject(parmjson, RuleItemBean.class);
		}
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
			pb = wordTemplateDao.getRuleItemInfoList(RuleItemBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
		
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
				return null;
		
	}
}

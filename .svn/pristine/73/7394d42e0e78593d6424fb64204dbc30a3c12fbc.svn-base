package com.chinacreator.xtbg.core.common.iweboffice.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:WordTextInput.java</p>
 *<p>Description:查询参数变量</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-30
 */
public class WordTextInputList extends DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(WordTextInputList.class);
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
		RuleItemBean ruleItemBean = new RuleItemBean();
		 
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			ruleItemBean = (RuleItemBean) JSONObject.parseObject(parmjson, RuleItemBean.class);
		}
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			pb = wordTemplateDao.getRuleItemInfoList(ruleItemBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return pb;
	}
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
				return null;
	}


}

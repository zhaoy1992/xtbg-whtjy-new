package com.chinacreator.xtbg.pub.wordtemplate.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.pub.wordtemplate.dao.WordTemplateDao;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordVarBean;



/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-5-29
 */

public class WordVariableList implements DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(WordVariableList.class);
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
		WordVarBean wordVarBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			wordVarBean = (WordVarBean) JSONObject.parseObject(parmjson, WordVarBean.class);
		}
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
			pb = wordTemplateDao.getVariableInfoList(wordVarBean, sortName, sortOrder, offset, maxPagesize);
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

package com.chinacreator.xtbg.pub.wordtemplate.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.pub.wordtemplate.dao.WordTemplateDao;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.frameworkset.util.ListInfo;



/**
 *<p>Title:</p>
 *<p>Description:模板列表</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-15
 */

public class WordTemplateList implements DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(WordTemplateList.class);

	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
			ListInfo info = new ListInfo();
			WordTemplateBean wordTemplateBean = new WordTemplateBean();
		 
			PagingBean pb = null;
			if (!StringUtil.isBlank(parmjson) ) {
				parmjson = DataControlUtil.replaceStr(parmjson);
				parmjson = Escape.unescape(parmjson);
				wordTemplateBean = (WordTemplateBean) JSONObject.parseObject(parmjson, WordTemplateBean.class);
			}
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
			pb = wordTemplateDao.getWordTemplateInfoList(wordTemplateBean, sortName, sortOrder, offset, maxPagesize);
			info.setDatas(pb.getList());
			info.setTotalSize(pb.getRecords());
		} catch (Exception e) {
			LOG.error(e.getMessage());
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

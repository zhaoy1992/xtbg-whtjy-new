package com.chinacreator.xtbg.core.archive.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;

public class WordArchiveList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(WordArchiveList.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		OaWordNumberBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			bean = (OaWordNumberBean) JSONObject.parseObject(parmjson, OaWordNumberBean.class);
		}
		try {
			WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
			pb = dao.findWordNumberList(bean, sortName, sortOrder, offset, maxPagesize);
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

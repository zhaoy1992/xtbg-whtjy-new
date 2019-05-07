package com.chinacreator.xtbg.core.news.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.news.dao.newsDao;
import com.chinacreator.xtbg.core.news.entity.newsBean;

/**
 * 新闻统计
 * @author shaojun.wu
 *
 */
public class newsCountList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(newsCountList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = null;
		try {
			newsBean model = StringUtil.convertStringToBean(parmjson,
					newsBean.class);

			newsDao dao = (newsDao) LoadSpringContext.getApplicationContext().getBean("newsDaoImpl");
			pb = dao.findNewsCountListPageBean(model, sortName, sortOrder,	offset, maxPagesize);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
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

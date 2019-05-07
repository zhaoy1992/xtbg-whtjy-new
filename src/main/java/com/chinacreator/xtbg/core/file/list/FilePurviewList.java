package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FilePurviewDao;
/**
 * 
 *<p>Title:FilePurviewList.java</p>
 *<p>Description:档案分类密级查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 18, 2013
 */
public class FilePurviewList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(FilePurviewList.class);
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
		PagingBean pb = new PagingBean();
		FilePurviewDao dao = (FilePurviewDao)LoadSpringContext.getApplicationContext().getBean("FilePurviewDaoImpl");
		try {
			pb = dao.getFilePurviewList(parmjson, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
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
		return null;
	}

}

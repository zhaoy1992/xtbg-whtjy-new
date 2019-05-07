package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileProgramPageDao;
/**
 * 
 *<p>Title:FileProgramPageList.java</p>
 *<p>Description:程序界面查看列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-11
 */
public class FileProgramPageList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(FileProgramPageList.class);
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
		PagingBean pb = new PagingBean();
		FileProgramPageDao fileProgramPageDao = (FileProgramPageDao)LoadSpringContext.getApplicationContext().getBean("fileProgramPageDaoImpl");
		try {
			pb = fileProgramPageDao.selFileProgramPageList(parmjson, sortName, sortOrder, offset, maxPagesize);
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

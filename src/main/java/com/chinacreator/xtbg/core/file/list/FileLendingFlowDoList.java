package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;

/**
 * 
 *<p>Title:FileLendingFlowDoList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 11, 2013
 */
public class FileLendingFlowDoList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FileLendingFlowDoList.class);
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
		PagingBean pb=new PagingBean();
		try {
			FileLendingDetailBean bean = (FileLendingDetailBean) JSONObject.parseObject(parmjson, FileLendingDetailBean.class);
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			pb = dao.getFileLendingFlowDoList(bean, sortName, sortOrder, offset, maxPagesize); 
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

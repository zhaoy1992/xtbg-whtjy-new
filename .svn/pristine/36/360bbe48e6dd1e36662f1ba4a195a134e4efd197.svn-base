package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;

/**
 * 档案借阅登记 时候查询档案(管理员操作)
 *<p>Title:FileLendingByAdminList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 6, 2013
 */
public class FileLendingByAdminList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(FileLendingByAdminList.class);

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
		try {
			//借用FileFilesQueryBean做载体
			FileFilesQueryBean bean = (FileFilesQueryBean) JSONObject.parseObject(parmjson, FileFilesQueryBean.class);
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			pb = dao.queryListByAdmin(bean, sortName, sortOrder, offset, maxPagesize); 
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

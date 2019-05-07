package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileDocDao;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoInfoBean;

/**
 * 
 *<p>Title:FileFilesQueryList.java</p>
 *<p>Description:文件管理-照片文件-照片信息查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 23, 2013
 */
public class FilePhotoList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(FilePhotoList.class);

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
			FileDocPhotoInfoBean bean = (FileDocPhotoInfoBean) JSONObject.parseObject(parmjson,FileDocPhotoInfoBean.class);
			FileDocDao dao = (FileDocDao)LoadSpringContext.getApplicationContext().getBean("fileDocDaoImpl");
			pb = dao.queryFileDocPhotoBeanList(bean, sortName, sortOrder, offset, maxPagesize); 
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

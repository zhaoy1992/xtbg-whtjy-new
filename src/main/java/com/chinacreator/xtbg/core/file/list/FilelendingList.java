package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;

/**
 *<p>Title:FilelendingList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-13
 */
public class FilelendingList extends DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(FileFondsnoList.class);
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
		PagingBean pb=new PagingBean();
		try {
			//借用FileFilesQueryBean做载体
			FileLendingDetailBean bean = (FileLendingDetailBean) JSONObject.parseObject(parmjson, FileLendingDetailBean.class);
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			pb = dao.getFilelendingBeanList(bean, sortName, sortOrder, offset, maxPagesize); 
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

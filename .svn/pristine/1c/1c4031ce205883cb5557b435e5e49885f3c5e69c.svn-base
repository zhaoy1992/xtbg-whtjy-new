package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.file.dao.FileDestroyDao;
import com.chinacreator.xtbg.core.file.entity.FileDestroyDetalBean;

/**
 *<p>Title:FileInventoryList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-23
 */
public class FileInventoryList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FileInventoryList.class);
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
			FileDestroyDetalBean bean = (FileDestroyDetalBean) JSONObject.parseObject(parmjson, FileDestroyDetalBean.class);
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			pb = dao.queryFileInventoryList(bean, sortName, sortOrder, offset, maxPagesize); 
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


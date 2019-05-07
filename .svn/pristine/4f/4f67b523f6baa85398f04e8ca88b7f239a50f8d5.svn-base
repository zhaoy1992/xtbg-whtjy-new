package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.imploracle.FilesStateManageDaoImpl;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;

/**
 * 待部门档案管理员提交的
 *<p>Title:FilesSubmitList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-5-5
 */
public class FilesSubmitList extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FilesSubmitList.class);
	
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		FileFilesBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			bean = (FileFilesBean) JSONObject.parseObject(parmjson, FileFilesBean.class);
		}
		try {
			FilesStateManageDaoImpl dao = new FilesStateManageDaoImpl();
			pb = dao.queryFilesSubmitList(bean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String) 
	  */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}

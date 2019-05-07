package com.chinacreator.xtbg.core.file.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileTJDao;
import com.chinacreator.xtbg.core.file.dao.imploracle.FileTJDaoImpl;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;

/**
 * 档案统计按照分类
 *<p>Title:FileTJList1.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 23, 2013
 */
public class FileTJList1 extends DataInfoImpl {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FileTJList1.class);
	
	 /** 
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
		FileDocBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			bean = (FileDocBean) JSONObject.parseObject(parmjson, FileDocBean.class);
		}
		try {
			FileTJDao dao = new FileTJDaoImpl();
			pb = dao.queryList1(bean, sortName, sortOrder, offset, maxPagesize,"page");
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

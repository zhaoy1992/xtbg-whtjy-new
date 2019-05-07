package com.chinacreator.xtbg.core.directory.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;

/**
 * 
 *<p>Title:HeTongYuJingList.java</p>
 *<p>Description:合同预警list数据显示</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-2-23
 */
public class HeTongYuJingList extends DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(HeTongYuJingList.class);
	
	/**
	 * 
	  * <b>Summary: 查询合同预警列表</b>
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
		
		DirectoryBean directoryBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			directoryBean = (DirectoryBean) JSONObject.parseObject(parmjson, DirectoryBean.class);
		}
		
		try {
			DirectoryDao daojson = (DirectoryDao)LoadSpringContext.getApplicationContext().getBean("directoryDaoImpl");
			pb = daojson.findHetongList(directoryBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}

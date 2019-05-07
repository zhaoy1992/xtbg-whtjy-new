package com.chinacreator.xtbg.pub.directory.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.pub.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:DirectoryList.java</p>
 *<p>Description:名录管理list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-02-16
 */
public class DirectoryList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(DirectoryList.class);
	
	/**
	 * @Description  查询名录管理列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		DirectoryBean directoryBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			directoryBean = (DirectoryBean) JSONObject.parseObject(parmjson, DirectoryBean.class);
		}
		
		try {
			DirectoryDao daojson = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			pb = daojson.findTypeList(directoryBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}

package com.chinacreator.xtbg.suxian.electroniccheck.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;


import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 * 
 *<p>Title:ElectWorkIPInfoList.java</p>
 *<p>Description:查询办公IP列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-4-9
 */
public class ElectWorkIPInfoList  implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(ElectWorkIPInfoList.class);
	
	/**
	 * @Description  查询列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		 ElectInfoBean announcementBean = null;
			PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			announcementBean = (ElectInfoBean) JSONObject.parseObject(parmjson, ElectInfoBean.class);
		
			
		}
		
		try {
			
		ElectInfoDao daojson= (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
		pb = daojson.findWorkIPInfoList(announcementBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}


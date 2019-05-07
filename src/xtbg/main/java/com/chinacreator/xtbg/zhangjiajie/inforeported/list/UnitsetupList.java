package com.chinacreator.xtbg.zhangjiajie.inforeported.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.UnitsetupDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.UnitsetupBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:UnitsetupList.java</p>
 *<p>Description:上报单位列表</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class UnitsetupList implements DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(UnitsetupList.class);
	/**
	 * @Description  查询上报单位列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回PagingBean
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		
		UnitsetupBean unitsetupBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			unitsetupBean = (UnitsetupBean) JSONObject.parseObject(parmjson, UnitsetupBean.class);
		}
		
		try {
			UnitsetupDao unitsetupDao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
			pb = unitsetupDao.findUnitsetupList(unitsetupBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
		
		
	}

	/**
	 * @Description  描叙
	 * 
	 * @param keyname  参数说明
	 * @param uri
	 * @return  返回值说明
	 * @exception 异常说明
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
				return null;
		
		
	}
	
}

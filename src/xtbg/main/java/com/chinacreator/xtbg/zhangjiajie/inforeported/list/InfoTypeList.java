package com.chinacreator.xtbg.zhangjiajie.inforeported.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoTypeDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:InfoTypeList.java</p>
 *<p>Description:信息类型列表</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class InfoTypeList implements DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(InfoTypeList.class);
	/**
	 * @Description  查询信息类型列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回PagingBean
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		
		InfoTypeBean infoTypeBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			infoTypeBean = (InfoTypeBean) JSONObject.parseObject(parmjson, InfoTypeBean.class);
		}
		
		try {
			InfoTypeDao infoTypeDao = (InfoTypeDao)DaoImplClassUtil.getDaoImplClass("infoTypeDaoImpl");
			pb = infoTypeDao.findInfoTypeList(infoTypeBean, sortName, sortOrder, offset, maxPagesize);
			
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

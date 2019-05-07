package com.chinacreator.xtbg.pub.oagwcs.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.oagwcs.dao.ReceiveDao;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsListSearchBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:ReceiveLevelList.java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2011-12-23
 */
public class ReceiveGwcsList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(ReceiveGwcsList.class);
	
	/**
	 * @Description  查询缓急列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		ReceiveGwcsListSearchBean receiveGwcsListSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {

			parmjson = DataControlUtil.replaceStr(parmjson);
			receiveGwcsListSearchBean = (ReceiveGwcsListSearchBean) JSONObject.parseObject(parmjson, ReceiveGwcsListSearchBean.class);
		}
		 
		try {
			ReceiveDao daojson = (ReceiveDao)DaoImplClassUtil.getDaoImplClass("receiveDaoImpl");
			pb = daojson.findReceiveGwcsList(receiveGwcsListSearchBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}

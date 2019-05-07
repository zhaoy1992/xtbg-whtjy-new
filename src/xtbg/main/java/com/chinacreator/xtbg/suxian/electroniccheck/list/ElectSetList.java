package com.chinacreator.xtbg.suxian.electroniccheck.list;

import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao;

public class ElectSetList  implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(ElectSetList.class);
	
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
			PagingBean pb = null;
			Map<String, String> map=null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			map = (Map<String, String>) JSONObject.parseObject(parmjson, Map.class);
		}
		try {
		ElectResetDao poeManagerDao = (ElectResetDao)DaoImplClassUtil.getDaoImplClass("electResetDaoImpls");
		pb = poeManagerDao.querylist(map, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}


package com.chinacreator.xtbg.tjy.device.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAppItemDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;

/**
 * 
 *<p>Title:DevAppItemList.java</p>
 *<p>Description:查询采购物品数据列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-4
 */
public class DevAppItemList extends DataInfoImpl{
	
private static final Logger LOG = Logger.getLogger(DevAppLicationList.class);
	
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		DevAppItem devAppItem = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			devAppItem = (DevAppItem) JSONObject.parseObject(parmjson, DevAppItem.class);
		}
		
		try {
			DevAppItemDao devAppItemDao = new DevAppItemDaoImpl();
			pb = devAppItemDao.findDevAppItemList(devAppItem, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		
		return null;
	}

}

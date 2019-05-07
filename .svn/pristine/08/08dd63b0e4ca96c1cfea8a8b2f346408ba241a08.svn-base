
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardHistoryList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.FuelCardmangeDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.FuelCardmangeDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean;

/**
 *<p>Title:FuelCardHistoryList.java</p>
 *<p>Description:特检院 查询车辆油卡登记使用列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public class FuelCardHistoryList implements DataInfoImpl{
	
	private static final Logger LOG = Logger.getLogger(FuelCardHistoryList.class);

	/**
	 * @Description 查询车辆油卡管理信息列表
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		FuelCardInfoBean fuelcardinfobean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			fuelcardinfobean = (FuelCardInfoBean) JSONObject.parseObject(parmjson,FuelCardInfoBean.class);
		}
		try {
			FuelCardmangeDao fuelcardmangedao = new FuelCardmangeDaoImpl();
			pb = fuelcardmangedao.queryCardFuelHistory(fuelcardinfobean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	public PagingBean getDataList(String parmStr, String sortName,
			String sortOrder) {

		return null;
	}

}

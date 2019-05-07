/**
 * [Product]
 *     xtbg-tjy
 * [Copyright]
 *     Copyright © 2014 ICSS All Rights Reserved.
 * [FileName]
 *     FuelCardmangeList.java
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
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;

/**
 * Title:FuelCardmangeList.java
 * Description:特检院 查询车辆油卡管理信息列表
 * Copyright:Copyright (c) 2013
 * Company:湖南科创
 * @author 邱炼
 * @version 1.0 2014-3-25
 */
public class FuelCardmangeList implements DataInfoImpl {
	
	private static final Logger LOG = Logger.getLogger(FuelCardmangeList.class);

	/**
	 * @Description 查询车辆油卡管理信息列表
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		CarManageCarBean carmanagecarbean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			carmanagecarbean = (CarManageCarBean) JSONObject.parseObject(parmjson,CarManageCarBean.class);
		}
		try {
			FuelCardmangeDao fuelcardmangedao = new FuelCardmangeDaoImpl();
			pb = fuelcardmangedao.queryFuelCardmangeList(carmanagecarbean, sortName, sortOrder, offset, maxPagesize);
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

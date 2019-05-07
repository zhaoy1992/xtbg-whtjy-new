package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarDriverDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean;
/**
 * 
 *<p>Title:CarDriverList.java</p>
 *<p>Description:查询车辆管理司机详细信息列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-24
 */
public class CarDriverList implements DataInfoImpl {
	private static final Logger LOG = Logger
			.getLogger(CarDriverList.class);

	/**
	 * @Description 查询车辆管理司机详细信息列表
	 * 
	 * @param request
	 * @param response
	 * @return 返回JOSNOBJECT
	 * @exception
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		DriverBean driverBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			driverBean = (DriverBean) JSONObject.parseObject(parmjson,
					DriverBean.class);
		}
		try {
			CarDriverDao carDriverDao = (CarDriverDao) DaoImplClassUtil.getDaoImplClass("carDriver");
			pb = carDriverDao.queryDriverInfolist(driverBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}

	public PagingBean getDataList(String parmStr, String sortName,
			String sortOrder) {

		return null;
	}
}

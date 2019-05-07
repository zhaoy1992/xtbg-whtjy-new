package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageRefuelmanageDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageRefuelmanageBean;

public class CarManageRefuelmanageYmjList implements DataInfoImpl {
	private static final Logger log = Logger.getLogger(CarManageRefuelmanageYmjList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize) {
		CarManageRefuelmanageBean bean = null;
		PagingBean pb = null;
		// 获得查询参数
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (CarManageRefuelmanageBean) JSONObject.parseObject(parmjson, CarManageRefuelmanageBean.class);
		}
		try {
			CarManageRefuelmanageDao dao = (CarManageRefuelmanageDao) DaoImplClassUtil .getDaoImplClass("carManageRefuelmanageDaoImpl");
			pb = dao.findCarManageRefuelmanageList(bean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			log.error("查询活动类型分页信息出现异常", e); 
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName, String sortOrder) {
		return null;
	}

}

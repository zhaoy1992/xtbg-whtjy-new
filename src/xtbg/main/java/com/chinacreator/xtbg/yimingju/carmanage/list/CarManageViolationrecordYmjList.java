package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageViolationrecordDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean;

public class CarManageViolationrecordYmjList implements DataInfoImpl {
	private static final Logger log = Logger.getLogger(CarManageViolationrecordYmjList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize) {
		CarManageViolationrecordBean bean = null;
		PagingBean pb = null;
		// 获得查询参数
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (CarManageViolationrecordBean) JSONObject.parseObject(parmjson, CarManageViolationrecordBean.class);
		}
		try {
			CarManageViolationrecordDao dao = (CarManageViolationrecordDao) DaoImplClassUtil .getDaoImplClass("carManageViolationrecordDaoImpl");
			pb = dao.findCarManageViolationrecordList(bean, sortName, sortOrder, offset, maxPagesize);
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

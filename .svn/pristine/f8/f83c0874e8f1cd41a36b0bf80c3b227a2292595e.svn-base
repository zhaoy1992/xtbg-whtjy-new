package com.chinacreator.xtbg.yimingju.carmanage.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageWxbyDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageWxbyDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageWxbyBean;

public class CarManageWxList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(CarManageWxList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		CarManageWxbyBean carManageWxbyBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			carManageWxbyBean = (CarManageWxbyBean) JSONObject.parseObject(parmjson, CarManageWxbyBean.class);
		}
		try {
			CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
			pb = carManageWxbyDao.findCarManageWxbyInfoList(carManageWxbyBean, sortName, sortOrder, offset, maxPagesize);	
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}

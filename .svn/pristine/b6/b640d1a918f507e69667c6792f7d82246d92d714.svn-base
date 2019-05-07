package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.util.List;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarEditInfoDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarEditInfoDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarEditInfoBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarEditInfoService;

public class CarEditInfoServiceImpl implements CarEditInfoService {

	CarEditInfoDao editDao = new CarEditInfoDaoImpl();
	
	@Override
	public List<CarEditInfoBean> list(CarEditInfoBean bean) {
		return editDao.list(bean);
	}

	@Override
	public boolean insert(CarEditInfoBean bean) {
		CarEditInfoBean bean1 = bean;
		bean1.setE_id(StringUtil.getUUID());
		return editDao.insert(bean1);
	}

	@Override
	public boolean delete(CarEditInfoBean bean) {
		return editDao.delete(bean);
	}

}

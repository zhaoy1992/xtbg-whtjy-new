package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageWxbyDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageWxbyDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageWxbyBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageWxByServiceIfc;

public class CarManageWxByServiceImpl implements CarManageWxByServiceIfc{
	private static final Logger LOG = Logger.getLogger(CarManageWxByServiceImpl.class);
	@Override
	public boolean saveCarWxInfo(String baseinfoJson) {
		boolean result = false;
		CarManageWxbyBean carManageCarBean = new CarManageWxbyBean();
		if (!StringUtil.isBlank(baseinfoJson)) {
			baseinfoJson = DataControlUtil.replaceStr(baseinfoJson);
			baseinfoJson = Escape.unescape(baseinfoJson);
			carManageCarBean = (CarManageWxbyBean) JSONObject.parseObject(baseinfoJson, CarManageWxbyBean.class);
			carManageCarBean.setSp_state("1");
		} 
		try {
			CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
			result = carManageWxbyDao.saveCarWxInfo(carManageCarBean);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			LOG.error(e.getMessage());
			result = false;
		}
		return result;
	}
	@Override
	public CarManageWxbyBean findCarWxInfo(String Id) {
		CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
		CarManageWxbyBean carManageWxbyBean=carManageWxbyDao.findCarWxInfo(Id);
		return carManageWxbyBean;
	}
	@Override
	public boolean carWxInfoPass(String Id,String passCase,String sp_yj) {
		CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
		return carManageWxbyDao.carWxInfoPass(Id,passCase,sp_yj);
	}
	@Override
	public boolean carWxInfoNoPass(String Id,String passCase,String sp_yj) {
		CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
		return carManageWxbyDao.carWxInfoNoPass(Id,passCase,sp_yj);
	}
	public boolean carWxInfosjfy(String Id,String sjfy) {
		CarManageWxbyDao  carManageWxbyDao =new CarManageWxbyDaoImpl();
		return carManageWxbyDao.carWxInfosjfy(Id,sjfy);
	}
}

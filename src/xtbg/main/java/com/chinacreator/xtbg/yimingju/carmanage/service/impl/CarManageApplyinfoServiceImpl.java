package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.sql.Connection;


import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageApplyinfoDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.ApplyinfoState;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageApplyinfoServiceIfc;
import com.frameworkset.orm.transaction.TransactionManager;

public class CarManageApplyinfoServiceImpl implements
		CarManageApplyinfoServiceIfc {

	private static final Logger LOG = Logger.getLogger(CarManageApplyinfoDaoImpl.class);	
	
	@Override
	public String saveCarManageApplyinfo(String baseinfoJson) {
		CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		try {
			if (!StringUtil.isBlank(baseinfoJson)) {
				baseinfoJson = DataControlUtil.replaceStr(baseinfoJson);
				baseinfoJson = Escape.unescape(baseinfoJson);
				carManageApplyinfoBean = (CarManageApplyinfoBean) JSONObject.parseObject(baseinfoJson, CarManageApplyinfoBean.class);
			} 
		} catch (Exception e) {
			//LOG.info(e.getMessage());
			e.printStackTrace();
		}
		Connection con = null;
		String apply_id = "";
		try {
			con = DbconnManager.getInstance().getTransactionConnection();
			apply_id = carManageApplyinfoBean.getApply_id();
			CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
			apply_id = carManageApplyinfoDao.saveCarManageApplyinfo(carManageApplyinfoBean, con);
		} catch (Exception e) {
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
		}finally {
			DbconnManager.closeConnection(con);
		}
		
		return apply_id;
	}

	@Override
	public boolean updateCarManageApplyStateByApplyID(String spInfo) throws Exception {
		CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		boolean result = false;
		String str[] = null;
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			if (!StringUtil.isBlank(spInfo)) {
				spInfo = DataControlUtil.replaceStr(spInfo);
				spInfo = Escape.unescape(spInfo);
				carManageApplyinfoBean = (CarManageApplyinfoBean) JSONObject.parseObject(spInfo, CarManageApplyinfoBean.class);
				CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
				if("4".equals(carManageApplyinfoBean.getState())) { //4表示分派车辆
					if(!StringUtil.isBlank(carManageApplyinfoBean.getCar_id())){
						 str = carManageApplyinfoBean.getCar_id().split("#");
					}
					for(int i = 0; i<str.length ; i++){
						carManageApplyinfoBean.setCar_id(str[i].split(",")[0]);
						carManageApplyinfoBean.setCar_num(str[i].split(",")[1]);
						//特检院OA start  【车辆分派】页面，在【确定】按钮旁边增加【直接派车】按钮 2014-03-25
						if(!StringUtil.isBlank(carManageApplyinfoBean.getDirectcar())){
							carManageApplyinfoBean.setState(ApplyinfoState.APPLYINFO_WRIT_SP);
						}
						//特检院OA start  【车辆分派】页面，在【确定】按钮旁边增加【直接派车】按钮 2014-03-25
						carManageApplyinfoDao.updateCarManageApplyStateByApplyID(carManageApplyinfoBean);
						carManageApplyinfoDao.addCarInfo(carManageApplyinfoBean.getApply_id(), carManageApplyinfoBean.getCar_id());
					}
				} else {
					carManageApplyinfoDao.updateCarManageApplyStateByApplyID(carManageApplyinfoBean);
				}
				
			} 

		}catch (Exception e) {
			e.printStackTrace();
			LOG.info(e.getMessage());
			result = false;
			 tm.rollback();
		}
	    result = true;
		tm.commit();
		
		return result;
	}

	@Override
	public boolean updateCarManageApplyPcEndStateByApplyID(String ypcInfo) {
		CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		boolean result = false;
		try {
			if (!StringUtil.isBlank(ypcInfo)) {
				ypcInfo = DataControlUtil.replaceStr(ypcInfo);
				ypcInfo = Escape.unescape(ypcInfo);
				carManageApplyinfoBean = (CarManageApplyinfoBean) JSONObject.parseObject(ypcInfo, CarManageApplyinfoBean.class);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getTransactionConnection();
			CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
			result = carManageApplyinfoDao.updateCarManageApplyYpendStateByApplyID(carManageApplyinfoBean,con);
			con.commit();
		} catch (Exception e) {
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			result = false;
		}finally {
			DbconnManager.closeConnection(con);
		}
		return result;
	}
}

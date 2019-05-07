package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.sql.Connection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageYoukaDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageYoukadaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageYoukaService;

public class CarManageYoukaServiceImpl implements CarManageYoukaService{
	private static final Log LOG=LogFactory.getLog(CarManageYoukaServiceImpl.class);
	@Override
	public CarManageYoukaBean getByID(String id) {
		Connection conn = null;
		CarManageYoukaBean regBean = new CarManageYoukaBean();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageYoukaDao dao = new CarManageYoukadaoImpl();
			regBean = dao.getById(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return regBean;
	}
	@Override
	public boolean update(CarManageYoukaBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageYoukaDao dao = new CarManageYoukadaoImpl();
			flag = dao.Update(bean,conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}

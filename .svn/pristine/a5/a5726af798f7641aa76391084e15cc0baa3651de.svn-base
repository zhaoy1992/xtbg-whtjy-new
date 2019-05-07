package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegYhpDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAppRegObjectDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAppRegYhpDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAppRegYhpService;

public class OsAppRegYhpServiceImpl implements OsAppRegYhpService{
	private static final Log LOG=LogFactory.getLog(OsAppRegYhpServiceImpl.class);
	@Override
	public OsAppRegYhpBean getById(String id) {
		Connection conn = null;
		OsAppRegYhpBean regBean = new OsAppRegYhpBean();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsAppRegYhpDao dao = new OsAppRegYhpDaoImpl();
			regBean = dao.getByID(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return regBean;
	}
	@Override
	public boolean changeState(OsAppRegYhpBean bean) {
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsAppRegYhpDao dao = new OsAppRegYhpDaoImpl();
			OsAppRegObjectDao objectDao = new OsAppRegObjectDaoImpl();
			flag = dao.changeState(bean, conn) & objectDao.changeItem(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}

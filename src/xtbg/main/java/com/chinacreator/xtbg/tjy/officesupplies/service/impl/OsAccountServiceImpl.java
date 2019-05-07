package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService;
/**
 * 固定资产service实现
 * @author 王淑滨
 *
 */
public class OsAccountServiceImpl implements OsAccountService{
	private static final Log LOG=LogFactory.getLog(OsAccountServiceImpl.class);
	@Override
	public boolean insertAccount(OsAccountBean bean) {
		Connection conn = null;
		boolean flag = false;
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.insertAccount(bean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public OsAccountBean getByID(String id) {
		Connection conn = null;
		OsAccountBean bean = new OsAccountBean();
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			bean = dao.getByID(id, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}
	@Override
	public boolean updateAccount(OsAccountBean bean) {
		Connection conn = null;
		boolean flag = false;
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.updateAccount(bean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean deleteAccount(String[] ids) {
		Connection conn = null;
		boolean flag = true;
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			for (String beanId : ids) {
				flag = flag & dao.deleteAccount(beanId,conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean changeState(OsAccountBean bean) {
		Connection conn = null;
		boolean flag = true;
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.changeState(bean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updateCalibrationTime(OsAccountBean bean) {
		Connection conn = null;
		boolean flag = true;
		OsAccountDao dao = new OsAccountDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.updateCalibrationTime(bean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}

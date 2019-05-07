package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsKucunDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsKucunDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsuserTypeItemDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService;

public class OsKucunServiceImpl implements OsKucunService{
	private static final Log LOG=LogFactory.getLog(OsKucunServiceImpl.class);
	@Override
	public Map<String, String> getByID(String t_ha_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			OsKucunDao dao = new OsKucunDaoImpl();
			viewMap = dao.getByID(t_ha_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	@Override
	public boolean insert(OsHavaObjectBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			flag = dao.insert(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean update(OsHavaObjectBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			flag = dao.update(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updateNo(OsHavaObjectBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			flag = dao.updateNo(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updateNumber(Map<String, String> map) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			flag = dao.updateNumber(map, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean delete(String ids, String itIds) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			OsuserTypeItemDao itemDao = new OsuserTypeItemDaoImpl();
			//删库存                                                           删规格
			flag = dao.delete(ids, conn) & itemDao.deleteOsuserTypeItemsById(conn, itIds);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean deleteByItem(String id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsKucunDao dao = new OsKucunDaoImpl();
			//删库存                                                           删规格
			flag = dao.deleteByItem(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}


}

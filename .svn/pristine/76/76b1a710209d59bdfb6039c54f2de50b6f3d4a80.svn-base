package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountHistoryDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountHistoryDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountHistoryService;

/**
 * 使用记录service实现
 * @author 王淑滨
 *
 */
public class OsAccountHistoryServiceImpl implements OsAccountHistoryService{
	private static final Log LOG=LogFactory.getLog(OsAccountHistoryServiceImpl.class);
	@Override
	public boolean insertHisetory(OsAccountHistoryBean bean) {
		boolean flag = false;
		Connection conn = null;
		OsAccountHistoryDao dao = new OsAccountHistoryDaoImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.insertAccountHistory(bean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}

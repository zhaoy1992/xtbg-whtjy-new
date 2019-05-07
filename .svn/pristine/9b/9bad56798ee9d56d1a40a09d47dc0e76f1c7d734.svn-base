package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.tjy.device.dao.DevIssuedDetailsDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevIssuedDetailsDaoImp;
import com.chinacreator.xtbg.tjy.device.entity.DevIssuedDetailsBean;
import com.chinacreator.xtbg.tjy.device.service.DevIssuedDetailsService;
/**
 * 核验表设备清单service实现
 * @author 王淑滨
 *
 */
public class DevIssuedDetailsServiceImpl implements DevIssuedDetailsService{
	private static final Log LOG=LogFactory.getLog(DevIssuedDetailsServiceImpl.class);
	DevIssuedDetailsDao dao = new DevIssuedDetailsDaoImp();
	@Override
	public boolean delete(String planId) {
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.delete(planId, conn);
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
	public List<Map<String, String>> getByPlanid(String planId) {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			list = dao.getByPlanID(planId, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}

	@Override
	public boolean insert(DevIssuedDetailsBean bean) {
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.insert(bean, conn);
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

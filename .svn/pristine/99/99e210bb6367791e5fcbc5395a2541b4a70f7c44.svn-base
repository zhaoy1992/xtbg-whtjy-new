package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsapPlanDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsapPlanDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanService;

public class OsapPlanServiceImpl implements OsapPlanService{
	private static final Log LOG=LogFactory.getLog(OsapPlanServiceImpl.class);
	@Override
	public OsApplanBean getById(String ids) {
		Connection conn = null;
		OsApplanBean bean = new OsApplanBean();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanDao dao = new OsapPlanDaoImpl();
			bean = dao.getById(ids, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}
	@Override
	public boolean insertApplan(OsApplanBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanDao dao = new OsapPlanDaoImpl();
			flag = dao.insertApplan(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean changeState(OsApplanBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanDao dao = new OsapPlanDaoImpl();
			flag = dao.changeState(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean insertApplan(OsApplanBean bean, HttpServletRequest request) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanDao dao = new OsapPlanDaoImpl();
			flag = dao.insertApplan(bean, conn);
			String customClassName = request.getParameter(FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG);
			if(flag&&!StringUtil.isBlank(customClassName)){
				FlowBusiDataSaveDao flowDao = (FlowBusiDataSaveDao)Class.forName(customClassName).newInstance();
				flag = flowDao.saveBusiInfo(request, conn);
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}

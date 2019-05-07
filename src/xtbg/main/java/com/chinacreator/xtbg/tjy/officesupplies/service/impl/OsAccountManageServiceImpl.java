package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountManageDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsAccountManageDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountDetails;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountManageService;
/**
 * 固定资产使用管理service接口实现
 * @author 王淑滨
 *
 */
public class OsAccountManageServiceImpl implements OsAccountManageService{
	private static final Log LOG=LogFactory.getLog(OsAccountManageServiceImpl.class);
	OsAccountManageDao dao = new OsAccountManageDaoImpl();
	@Override
	public OsAccountManagerBean getByID(String id) {
		OsAccountManagerBean bean = new OsAccountManagerBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			bean = dao.getByID(id, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}

	@Override
	public List<Map<String, String>> getByMid(String id) {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			list = dao.getByMid(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}

	@Override
	public boolean insertManager(OsAccountManagerBean bean,HttpServletRequest request) {
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.insertManager(bean, conn);
			//新增清单
			String customClassName = request.getParameter(FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG);
			if(flag&&!StringUtil.isBlank(customClassName)){
				FlowBusiDataSaveDao dao = (FlowBusiDataSaveDao)Class.forName(customClassName).newInstance();
				flag = dao.saveBusiInfo(request, conn);
			}
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public boolean insertManagerDetails(OsAccountDetails bean) {
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = dao.insertManagerDetails(bean, conn);
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public boolean deleteManagerDetails(String[] ids) {
		boolean flag = true;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			for(String id:ids){
				flag = true && dao.deleteManagerDetails(id, conn);
			}
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}

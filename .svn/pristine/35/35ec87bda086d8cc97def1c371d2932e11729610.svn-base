
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevBorrowServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevBorrowDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevBorrowDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevBorrowBean;
import com.chinacreator.xtbg.tjy.device.service.DevBorrowService;

/**
 *<p>Title:DevBorrowServiceImpl.java</p>
 *<p>Description:设备借用、归还业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public class DevBorrowServiceImpl implements DevBorrowService{
	
	private static final Log LOG=LogFactory.getLog(DevBorrowServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevBorrowInfo
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevBorrowService#getDevBorrowInfo(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevBorrowInfo(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevBorrowDao devborrowdao = new DevBorrowDaoImpl();
			viewMap = devborrowdao.getDevBorrowInfo(t_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	@Override
	public boolean saveDevBorrowInfo(DevBorrowBean bean) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevBorrowDao devborrowdao = new DevBorrowDaoImpl();
			bean.setT_id(StringUtil.getUUID());
			devborrowdao.saveDevBorrowInfo(bean);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updateDevBorrowInfo(DevBorrowBean bean) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevBorrowDao devborrowdao = new DevBorrowDaoImpl();
			devborrowdao.updateDevBorrowInfo(bean);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updateDevDiaobo(String user_orgid, String user_orgname,
			String custos_userid, String custos_username,String id) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevBorrowDao devborrowdao = new DevBorrowDaoImpl();
			devborrowdao.updateDevDiaobo(user_orgid, user_orgname, custos_userid, custos_username,id);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	@Override
	public Map<String, String> getDevTransferInfo(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevBorrowDao devborrowdao = new DevBorrowDaoImpl();
			viewMap = devborrowdao.getDevTransferInfo(t_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
}

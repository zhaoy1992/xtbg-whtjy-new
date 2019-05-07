
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevInfoItemServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevInfoItemDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevInfoItemDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevInfoItemBean;
import com.chinacreator.xtbg.tjy.device.service.DevInfoItemService;

/**
 *<p>Title:DevInfoItemServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevInfoItemServiceImpl implements DevInfoItemService {

	private static final Log LOG=LogFactory.getLog(DevInfoItemServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevInfoItemBean
	  * @param dev_code
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevInfoItemService#getDevInfoItemBean(java.lang.String) 
	  */
	@Override
	public List<Map<String, String>> getDevInfoItemBean(String dev_code) {
		Connection conn = null;
		List<Map<String, String>> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new ArrayList<Map<String, String>>();
			DevInfoItemDao devinfoitemdao = new DevInfoItemDaoImpl();
			viewMap = devinfoitemdao.getDevInfoItem(dev_code, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateDevInfoItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevInfoItemService#insertOrUpdateDevInfoItem(com.chinacreator.xtbg.tjy.device.entity.DevInfoItemBean) 
	  */
	@Override
	public String insertOrUpdateDevInfoItem(DevInfoItemBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevInfoItemDao dao = new DevInfoItemDaoImpl();
			if(StringUtil.nullOrBlank(bean.getId())){//insert
				bean.setId(StringUtil.getUUID());
				beanId = bean.getId();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getId();
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevInfoItemByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevInfoItemService#deleteDevInfoItemByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevInfoItemByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevInfoItemDao dao = new DevInfoItemDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevInfoItemById(conn, beanId);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}

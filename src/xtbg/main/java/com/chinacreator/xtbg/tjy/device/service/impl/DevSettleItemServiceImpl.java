
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSettleItemServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-15   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevSettleItemDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevSettleItemDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevSettleItemBean;
import com.chinacreator.xtbg.tjy.device.service.DevSettleItemService;

/**
 *<p>Title:DevSettleItemServiceImpl.java</p>
 *<p>Description:政府采购验收结算货品业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-15
 */
public class DevSettleItemServiceImpl implements DevSettleItemService{

	private static final Log LOG = LogFactory.getLog(DevSettleItemServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevSettleItem
	  * @param devsettle_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSettleItemService#getDevSettleItem(java.lang.String) 
	  */
	@Override
	public List<Map<String, String>> getDevSettleItem(String devsettle_id) {
		Connection conn = null;
		List<Map<String, String>> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new ArrayList<Map<String, String>>();
			DevSettleItemDao devsettleitemdao = new DevSettleItemDaoImpl();
			viewMap = devsettleitemdao.getDevSettleItemList(devsettle_id, conn);
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
	  *     复写方法 getDevSettleItemBeanInfo
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSettleItemService#getDevSettleItemBeanInfo(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevSettleItemBeanInfo(String t_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new HashMap<String, String>();
			DevSettleItemDao devsettleitemdao = new DevSettleItemDaoImpl();
			viewMap = devsettleitemdao.getDevSettleItemInfo(t_id, conn);
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
	  *     复写方法 insertOrUpdateDevSettleItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSettleItemService#insertOrUpdateDevSettleItem(com.chinacreator.xtbg.tjy.device.entity.DevSettleItemBean) 
	  */
	@Override
	public String insertOrUpdateDevSettleItem(DevSettleItemBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevSettleItemDao dao = new DevSettleItemDaoImpl();
			if(StringUtil.nullOrBlank(bean.getT_id())){//insert
				bean.setT_id(StringUtil.getUUID());
				beanId = bean.getT_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getT_id();
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
	  *     复写方法 deleteDevSettleItemByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSettleItemService#deleteDevSettleItemByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevSettleItemByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevSettleItemDao dao = new DevSettleItemDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevSettleItemById(conn, beanId);
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

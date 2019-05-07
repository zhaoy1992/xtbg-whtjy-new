
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppItemServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAppItemDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;
import com.chinacreator.xtbg.tjy.device.service.DevAppItemService;

/**
 *<p>Title:DevAppItemServiceImpl.java</p>
 *<p>Description:物品列表业务层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevAppItemServiceImpl implements DevAppItemService{

	private static final Log LOG=LogFactory.getLog(DevAppItemServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevAppItemBean
	  * @param it_planid
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppItemService#getDevAppItemBean(java.lang.String) 
	  */
	@Override
	public List<Map<String, String>> getDevAppItemBean(String it_planid) {
		Connection conn = null;
		List<Map<String, String>> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new ArrayList<Map<String, String>>();
			DevAppItemDao devappitemdao = new DevAppItemDaoImpl();
			viewMap = devappitemdao.getDevAppItem(it_planid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* getDevAppItemBeanInfo(根据物品明细ID查询物品明细数据表数据)
	* @param item_id
	* @return
	 */
	public Map<String, String> getDevAppItemBeanInfo(String item_id){
		
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new HashMap<String, String>();
			DevAppItemDao devappitemdao = new DevAppItemDaoImpl();
			viewMap = devappitemdao.getDevAppItemInfo(item_id, conn);
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
	  *     复写方法 insertOrUpdateDevAppItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppItemService#insertOrUpdateDevAppItem(com.chinacreator.xtbg.tjy.officesupplies.entity.OsapPlanItem) 
	  */
	@Override
	public String insertOrUpdateDevAppItem(DevAppItem bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevAppItemDao dao = new DevAppItemDaoImpl();
			if(StringUtil.nullOrBlank(bean.getItem_id())){//insert
				bean.setItem_id(StringUtil.getUUID());
				beanId = bean.getItem_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getItem_id();
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
	  *     复写方法 deleteDevAppItemByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevAppItemService#deleteDevAppItemByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevAppItemByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevAppItemDao dao = new DevAppItemDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevAppItemById(conn, beanId);
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

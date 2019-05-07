
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsapPlanItemServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsapPlanItemDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl.OsapPlanItemDaoImpl;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsapPlanItem;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsapPlanItemService;

/**
 *<p>Title:OsapPlanItemServiceImpl.java</p>
 *<p>Description:物品列表业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-20
 */
public class OsapPlanItemServiceImpl implements OsapPlanItemService{
	
	private static final Log LOG=LogFactory.getLog(OsapPlanItemServiceImpl.class);

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsapPlanItemBean
	  * @param it_planid
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanItemService#getOsapPlanItemBean(java.lang.String) 
	  */
	@Override
	public List<Map<String, String>> getOsapPlanItemBean(String it_planid) {
		Connection conn = null;
		List<Map<String, String>> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap =new ArrayList<Map<String, String>>();
			OsapPlanItemDao osapplanitemdao = new OsapPlanItemDaoImpl();
			viewMap = osapplanitemdao.getOsapPlanItem(it_planid, conn);
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
	  *     复写方法 insertOrUpdateOsapPlanItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanItemService
	  * #insertOrUpdateOsapPlanItem(com.chinacreator.xtbg.tjy.officesupplies.entity.OsapPlanItem) 
	  */
	@Override
	public String insertOrUpdateOsapPlanItem(OsapPlanItem bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanItemDao dao = new OsapPlanItemDaoImpl();
			if(StringUtil.nullOrBlank(bean.getIt_id())){//insert
				bean.setIt_id(StringUtil.getUUID());
				beanId = bean.getIt_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getIt_id();
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
	  *     复写方法 deleteOsapPlanItemByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanItemService#deleteOsapPlanItemByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteOsapPlanItemByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsapPlanItemDao dao = new OsapPlanItemDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsapPlanItemById(conn, beanId);
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

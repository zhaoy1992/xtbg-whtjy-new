package com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsAppObjectDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl.OsAppObjectDaoImpl;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsAppObjectService;
/**
 * 
 *<p>Title:OsAppObjectServiceImpl.java</p>
 *<p>Description:处理添加入计划表的物品数据业务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public class OsAppObjectServiceImpl implements OsAppObjectService {

	private static final Log LOG=LogFactory.getLog(OsAppObjectServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 新增或者更新计划表所填物品</b>
	  *     复写方法 insertOrUpdateOsApp
	  * @param objectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService
	  * #insertOrUpdateOsApp(com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean)
	 */
	public String insertOrUpdateOsApp(OsAppObjectBean objectBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsAppObjectDao dao = new OsAppObjectDaoImpl();
			objectBean.setT_os_ob_id(StringUtil.getUUID());
			beanId = objectBean.getT_os_ob_id();
			((BaseDao)dao).insert(objectBean, conn);
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
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selectOsAppObject
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService#selectOsAppObject(java.lang.String)
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id) {
		List<Map<String, String>> osAppObjectList = null;
		try {
			osAppObjectList = new ArrayList<Map<String,String>>();
			OsAppObjectDao dao = new OsAppObjectDaoImpl();
			osAppObjectList = dao.selectOsAppObject(t_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return osAppObjectList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsAppObjectByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService#deleteOsAppObjectByIds(java.lang.String[])
	 */
	public String deleteOsAppObjectByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsAppObjectDao dao=new OsAppObjectDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsAppObject(beanId, conn);
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

	/**
	 * 
	  * <b>Summary: 更新计划表所填物品</b>
	  *     复写方法 onlyUpdateOsApp
	  * @param objectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService
	  * #onlyUpdateOsApp(com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean)
	 */
	public boolean onlyUpdateOsApp(OsAppObjectBean objectBean) {
		Connection conn = null;
		String beanIds = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsAppObjectDao dao = new OsAppObjectDaoImpl();
			beanIds = objectBean.getT_os_ob_id();
			String[] t_os_ob_ids = beanIds.split(",");
			if (t_os_ob_ids.length<2) {
				((BaseDao)dao).update(objectBean, conn);
			}else{
				for (int i = 0; i < t_os_ob_ids.length; i++) {
					objectBean.setT_os_ob_id(t_os_ob_ids[i]);
					((BaseDao)dao).update(objectBean, conn);
				}
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}

}

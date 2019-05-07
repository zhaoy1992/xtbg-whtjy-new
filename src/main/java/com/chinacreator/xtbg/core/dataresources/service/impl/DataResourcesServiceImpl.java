package com.chinacreator.xtbg.core.dataresources.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao;
import com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc;

public class DataResourcesServiceImpl implements DataResourcesServiceIfc{

	private static final Log LOG = LogFactory.getLog(DataResourcesServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataResourcesBeanMap
	  * @return 
	  * @see com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc#getDataResourcesBeanMap()
	 */
	@Override
	public List<Map<String, String>> getDataResourcesBeanMap() {
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
		try {
			listMap = dataResourcesDao.getDataResourcesBeanMap();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return listMap;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserBeanMap
	  * @param org_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc#getUserBeanMap(java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getUserBeanMap(String org_id) {
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
		try {
			listMap = dataResourcesDao.getUserBeanMap(org_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return listMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertOrgResourceConfig
	  * @param boxvalue
	  * @param org_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc#insertOrgResourceConfig(java.lang.String, java.lang.String)
	 */
	public boolean insertOrgResourceConfig(String boxvalue, String org_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
			dataResourcesDao.delOrgResourceConfig(boxvalue, org_id, conn);
			dataResourcesDao.insertOrgResourceConfig(boxvalue, org_id, conn);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getChooseOrgUser
	  * @param org_id
	  * @param config_type
	  * @return 
	  * @see com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc#getChooseOrgUser(java.lang.String, java.lang.String)
	 */
	@Override
	public List<String> getChooseOrgUser(String org_id) {
		Connection conn = null;
		Map<String, String> userMap = null;
		String resources_id = "";
		String config_ids = "";
		String config_idsArray[] = null;
		List<String> userandresourceidList = new ArrayList<String>();
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
 		DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			listMap = dataResourcesDao.getChooseOrgUser(org_id, conn);
			for (int i = 0; i < listMap.size(); i++) {
				userMap = listMap.get(i);
				resources_id = userMap.get("resources_id");
				config_ids = userMap.get("config_ids");
				if(!StringUtil.isBlank(config_ids)) {
					config_idsArray = config_ids.split(",");
					for(int j = 0; j < config_idsArray.length; j++) {
						userandresourceidList.add(config_idsArray[j] + resources_id);
					}
				}
				
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return userandresourceidList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delAllChooseOrgUser
	  * @param org_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc#delAllChooseOrgUser(java.lang.String)
	 */
	@Override
	public boolean delAllChooseOrgUser(String org_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
			dataResourcesDao.delAllChooseOrgUser(org_id, conn);
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}


}

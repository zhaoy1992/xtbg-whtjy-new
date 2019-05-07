
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieTypeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsupplieTypeDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl.OsupplieTypeDaoImpl;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieTypeBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsupplieTypeService;

/**
 *<p>Title:OsupplieTypeServiceImpl.java</p>
 *<p>Description:设备易耗品类型业务的实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsupplieTypeServiceImpl implements OsupplieTypeService{
	private static final Log LOG=LogFactory.getLog(OsupplieTypeServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsupplieTypeBean
	  * @param oftype_id
	  * @param oftype_flag
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService#getOsupplieTypeBean(java.lang.String, java.lang.String) 
	  */
	@Override
	public Map<String, String> getOsupplieTypeBean(String oftype_id,
			String oftype_flag) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			OsupplieTypeDao osupplietypedao = new OsupplieTypeDaoImpl();
			viewMap = osupplietypedao.getOsupplieType(oftype_id, oftype_flag, conn);
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
	  *     复写方法 insertOrUpdateOsTypeBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService
	  * #insertOrUpdateOsTypeBean(com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean) 
	  */
	@Override
	public String insertOrUpdateOsTypeBean(OsupplieTypeBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsupplieTypeDao dao = new OsupplieTypeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getOftype_id())){//insert
				bean.setOftype_id(StringUtil.getUUID());
				beanId = bean.getOftype_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getOftype_id();
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
	  *     复写方法 deleteOsTypeInfoByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService#deleteOsTypeInfoByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteOsTypeInfoByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
//		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsupplieTypeDao dao =new OsupplieTypeDaoImpl();
			for (String beanId : ids) {
//				//判断该类型是否被引用
//				count = dao.isOsupplieTypeBean(conn, beanId);
//				if(count>0){
//					return "number";
//				}
				//删除该节点以及子节点
				dao.deleteOsupplieBeansById(conn, beanId);
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


 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieUseTypeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.service.impl;

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
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsupplieUseTypeDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsuserTypeItemDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl.OsupplieUseTypeDaoImpl;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl.OsuserTypeItemDaoImpl;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsupplieUseType;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsupplieUseTypeService;

/**
 *<p>Title:OsupplieUseTypeServiceImpl.java</p>
 *<p>Description:常用物品业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsupplieUseTypeServiceImpl implements OsupplieUseTypeService{

	private static final Log LOG=LogFactory.getLog(OsupplieUseTypeServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsupplieUseTypeBean
	  * @param ofus_id
	  * @param ofus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService#getOsupplieUseTypeBean(java.lang.String, java.lang.String) 
	  */
	@Override
	public Map<String, String> getOsupplieUseTypeBean(String ofus_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			OsupplieUseTypeDao osupplieusetypedao = new OsupplieUseTypeDaoImpl();
			viewMap = osupplieusetypedao.getOsupplieUseType(ofus_id, conn);
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
	  *     复写方法 insertOrUpdateOsUserTypeBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService
	  * #insertOrUpdateOsUserTypeBean(com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieUseType) 
	  */
	@Override
	public String insertOrUpdateOsUserTypeBean(OsupplieUseType bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsupplieUseTypeDao dao = new OsupplieUseTypeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getOfustype_id())){//insert
				bean.setOfustype_id(StringUtil.getUUID());
				beanId = bean.getOfustype_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getOfustype_id();
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
	  *     复写方法 deleteOsUsTypeInfoByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService#deleteOsUsTypeInfoByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteOsUsTypeInfoByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsupplieUseTypeDao dao = new OsupplieUseTypeDaoImpl();
			OsuserTypeItemDao osusertypeitemdao = new OsuserTypeItemDaoImpl();
			for (String beanId : ids) {
				//判断该类型是否被引用
				List<Map<String, String>> listMap = osusertypeitemdao.queryOsuserTyptItemList(beanId);
				count = listMap.size();
				if(count>0){
					return "number";
				}
				//删除该节点以及子节点
				dao.deleteOsupplieUseBeansById(conn, beanId);
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
	  * <b>Summary: 查询所有物品信息</b>
	  *     复写方法 queryAllOsupplieUseType
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService#queryAllOsupplieUseType()
	 */
	public List<Map<String, String>> queryAllOsupplieUseType(String unit_id) throws Exception {
		List<Map<String, String>> allOsupplieUseList = new ArrayList<Map<String,String>>();;
		try {
			OsupplieUseTypeDao osupplieusetypedao = new OsupplieUseTypeDaoImpl();
			allOsupplieUseList = osupplieusetypedao.queryAllOsupplieUseType(unit_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return allOsupplieUseList;
	}

}

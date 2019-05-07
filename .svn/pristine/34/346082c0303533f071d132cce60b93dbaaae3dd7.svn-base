
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsUserTypeItemServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieUseTypeDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsuserTypeItemDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsupplieUseTypeDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsuserTypeItemDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsuserTypeItemBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService;

/**
 *<p>Title:OsUserTypeItemServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsUserTypeItemServiceImpl implements OsUserTypeItemService{
	
	private static final Log LOG=LogFactory.getLog(OsUserTypeItemServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsUserTypeItemBean
	  * @param it_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService#getOsUserTypeItemBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getOsUserTypeItemBean(String it_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			OsuserTypeItemDao osusertypeitemdao=(OsuserTypeItemDao)LoadSpringContext.getApplicationContext().getBean("osusertypeitemdaoimpl");
			viewMap = osusertypeitemdao.getOsuserTypeItem(it_id, conn);
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
	  *     复写方法 insertOrUpdateOsUserTypeItem
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService#insertOrUpdateOsUserTypeItem(com.chinacreator.xtbg.tjy.officesupplies.entity.OsuserTypeItemBean) 
	  */
	@Override
	public String insertOrUpdateOsUserTypeItem(OsuserTypeItemBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsuserTypeItemDao dao=(OsuserTypeItemDao)LoadSpringContext.getApplicationContext().getBean("osusertypeitemdaoimpl");
			if(StringUtil.nullOrBlank(bean.getIt_id())){//insert
				bean.setIt_id(StringUtil.getUUID());
				beanId = bean.getIt_id();
				((BaseDao)dao).insert(bean, conn);
				//新增规格新增一个库存
				//根据物品id得物品信息
				Map<String, String> map = new HashMap<String, String>();
				OsupplieUseTypeDao typeDao = new OsupplieUseTypeDaoImpl();
				map = typeDao.getOsupplieUseType(bean.getIt_typeid(),conn);
				
				OsHavaObjectBean objectBean = new OsHavaObjectBean();
				objectBean.setT_ha_id(DaoUtil.getUUID());//库存id
				objectBean.setOftype_id(map.get("oftype_id"));//物品类型id
				objectBean.setOftype_name(map.get("oftype_name"));//物品类型名
				objectBean.setOfustype_id(map.get("ofustype_id"));//物品id
				objectBean.setOfustype_name(map.get("ofustype_name"));//物品名
				objectBean.setIt_id(bean.getIt_id());//规格id
				objectBean.setIt_name(bean.getIt_name());//规格名
				objectBean.setT_ha_no("0");//数量
				objectBean.setOfustype_no(Integer.parseInt(bean.getIt_no()));//排序号
				objectBean.setT_ha_rkuser_id(bean.getUser_id());//入库人
				objectBean.setT_ha_rkuser_name(bean.getUser_name());
				objectBean.setT_ha_rkuser_date(bean.getTime());//入库时间
				objectBean.setUnit_id(bean.getUnit_id());
				objectBean.setUnit_name(bean.getUnit_name());
				OsKucunService kucunService = new OsKucunServiceImpl();
				boolean flag = kucunService.insert(objectBean);
				//删除第一条没有规格的库存
				flag = flag & kucunService.deleteByItem(map.get("ofustype_id"));
				if(!flag){
					beanId = null;
				}
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
	  *     复写方法 deleteOsUserTypeItemByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService#deleteOsUserTypeItemByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteOsUserTypeItemByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsuserTypeItemDao dao=(OsuserTypeItemDao)LoadSpringContext.getApplicationContext().getBean("osusertypeitemdaoimpl");
			for (String beanId : ids) {
				//判断该类型是否被引用
				count = dao.isOsuserTypeItem(conn, beanId);
				if(count>0){
					return "number";
				}
				//删除该节点以及子节点
				dao.deleteOsuserTypeItemsById(conn, beanId);
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
	  * <b>Summary: 根据IDs 删除物品规格信息</b>
	  *     复写方法 queryOsuserTyptItemList
	  * @param ofustypeId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService#queryOsuserTyptItemList(java.lang.String)
	 */
	public List<Map<String, String>> queryOsuserTyptItemList(String ofustypeId)
			throws Exception {
		List<Map<String, String>> ofustypeItemList = new ArrayList<Map<String,String>>();
		try {
			OsuserTypeItemDao dao=(OsuserTypeItemDao)LoadSpringContext.getApplicationContext().getBean("osusertypeitemdaoimpl");
			ofustypeItemList = dao.queryOsuserTyptItemList(ofustypeId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return ofustypeItemList;
	}

	/**
	 * 
	*<b>Summary: </b>
	* queryOsoFtypeItemList(根据物品ID查询出物品类别)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryOsoFtypeItemList(String ofustypeId) throws Exception{
		Map<String, String> ofustypeItemList = new HashMap<String,String>();
		try {
			OsuserTypeItemDao dao=(OsuserTypeItemDao)LoadSpringContext.getApplicationContext().getBean("osusertypeitemdaoimpl");
			ofustypeItemList = dao.queryOsoFtypeItemList(ofustypeId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return ofustypeItemList;
	}


	@Override
	public boolean insertItem(OsuserTypeItemBean bean) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsuserTypeItemDao dao = new OsuserTypeItemDaoImpl();
			flag = dao.insert(bean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}


	@Override
	public Map<String, String> getOfustypeById(String ofustypeId) {
		Connection conn = null;
		Map<String, String> map = new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsuserTypeItemDao dao = new OsuserTypeItemDaoImpl();
			map = dao.getOfustypeById(ofustypeId,conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}	
}

package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsExaminationObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsExaminationObjectDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsExaminationBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService;

/**
 * 
 *<p>Title:OsExaminationObjectServiceImpl.java</p>
 *<p>Description:审批表业务数据处理业务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public class OsExaminationObjectServiceImpl implements
		OsExaminationObjectService {
	
	private static final Log LOG=LogFactory.getLog(OsExaminationObjectServiceImpl.class);

	/**
	 * 
	  * <b>Summary: 根据ids查询出计划表数据</b>
	  *     复写方法 queryOsAppList
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#queryOsAppList(java.lang.String)
	 */
	public List<Map<String, String>> queryOsAppList(String ids,String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osAppList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao osExaminationObjectDao = new OsExaminationObjectDaoImpl();
			osAppList = osExaminationObjectDao.selectOsAppByIds(ids,bus_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppList;
	}

	/**
	 * 
	  * <b>Summary: 根据计划表ids查询出物品列表并将相同的常用物品合并</b>
	  *     复写方法 queryNoLikeOsAppObjectList
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#queryNoLikeOsAppObjectList(java.lang.String)
	 */
	public List<Map<String, String>> queryNoLikeOsAppObjectList(String ids,String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osAppObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao osExaminationObjectDao = new OsExaminationObjectDaoImpl();
			osAppObjectList = osExaminationObjectDao.selectOsAppObjectByIds(ids,bus_id);
			for (int i = 0; i < osAppObjectList.size(); i++) {
				for (int j = 0; j < osAppObjectList.size(); j++) {
					if ((!StringUtil.isBlank(osAppObjectList.get(i).get("it_id")))  && (osAppObjectList.get(i).get("it_id").equals(osAppObjectList.get(j).get("it_id"))) && i!=j) {  //常用物品规格ID不为空且相同
						osAppObjectList.get(i).put("t_os_ob_id", osAppObjectList.get(i).get("t_os_ob_id")+","+osAppObjectList.get(j).get("t_os_ob_id"));
						if(!osAppObjectList.get(i).get("t_org_id").equals(osAppObjectList.get(j).get("t_org_id"))){
							osAppObjectList.get(i).put("t_org_id", osAppObjectList.get(i).get("t_org_id")+","+osAppObjectList.get(j).get("t_org_id"));
							osAppObjectList.get(i).put("t_org_name", osAppObjectList.get(i).get("t_org_name")+","+osAppObjectList.get(j).get("t_org_name"));
						}
						long noI = Long.parseLong(osAppObjectList.get(i).get("t_os_ob_no"));
						long noJ = Long.parseLong(osAppObjectList.get(j).get("t_os_ob_no"));
						long sum = noI + noJ;
						osAppObjectList.get(i).put("t_os_ob_no",""+sum);
						osAppObjectList.remove(j);
					}
				}
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppObjectList;
	}

	/**
	 * 
	  * <b>Summary: 新增或者更新计划审批表所填物品</b>
	  *     复写方法 insertOrUpdateOsExaObject
	  * @param osExaminationBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#insertOrUpdateOsExaObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsExaminationBean)
	 */
	public String insertOrUpdateOsExaObject(OsExaminationBean osExaminationBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			osExaminationBean.setT_osexa_ob_id(StringUtil.getUUID());
			beanId = osExaminationBean.getT_osexa_ob_id();
			((BaseDao)dao).insert(osExaminationBean, conn);
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
	  * <b>Summary:根据计划审批表id查询出物品列表 </b>
	  *     复写方法 selectOsExaObject
	  * @param t_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#selectOsExaObject(java.lang.String)
	 */
	public List<Map<String, String>> selectOsExaObject(String t_id) {
		List<Map<String, String>> osExaObjectList = null;
		try {
			osExaObjectList = new ArrayList<Map<String,String>>();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			osExaObjectList = dao.selectOsExaObject(t_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return osExaObjectList;
	}

	/**
	 * 
	  * <b>Summary: 根据计划审批表ids删除物品</b>
	  *     复写方法 deleteOsExaObjectByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#deleteOsExaObjectByIds(java.lang.String[])
	 */
	public String deleteOsExaObjectByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsExaObject(beanId, conn);
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
	  * <b>Summary: </b>
	  *     复写方法 updateOsAplan
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#updateOsAplan(java.lang.String)
	 */
	public boolean updateOsAplan(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			dao.updateOsApplanState(ids, conn);
			conn.commit();
			flag = true;
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
	  * <b>Summary: 根据审批id查询存储的计划表id</b>
	  *     复写方法 queryOsAppIdsForExaId
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#queryOsAppIdsForExaId(java.lang.String)
	 */
	public String queryOsAppIdsForExaId(String id) {
		Connection conn = null;
		String osExaId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			osExaId = dao.queryOsAppIdsForExaId(id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osExaId;
	}

	/**
	 * 
	  * <b>Summary: 根据计划审批表ids查询出物品列表</b>
	  *     复写方法 selectOsExaObjectByIds
	  * @param t_ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsExaminationObjectService#selectOsExaObjectByIds(java.lang.String)
	 */
	public List<Map<String, String>> selectOsExaObjectByIds(String t_ids) {
		List<Map<String, String>> osExaObjectList = null;
		try {
			osExaObjectList = new ArrayList<Map<String,String>>();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			osExaObjectList = dao.selectOsExaObjectByIds(t_ids);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return osExaObjectList;
	}

	@Override
	public void insertOrUpdateOsApplanObject(OsApplanBean osApplanBean) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			dao.insertApplanObject(osApplanBean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public void insertOrUpdateHavaObject(OsHavaObjectBean osHavaObjectBean) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectDao dao = new OsExaminationObjectDaoImpl();
			dao.insertApplanObject(osHavaObjectBean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		
	}

}

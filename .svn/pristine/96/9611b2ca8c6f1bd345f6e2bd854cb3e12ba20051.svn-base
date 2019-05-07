package com.chinacreator.xtbg.tjy.detectionsupplies.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsHavaObjectDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl.OsHavaObjectDaoImpl;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsAppRegObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsNoMoveObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsExaminationObjectService;
import com.chinacreator.xtbg.tjy.detectionsupplies.service.OsHavaObjectService;

/**
 * 
 *<p>Title:OsHavaObjectServiceImpl.java</p>
 *<p>Description:物品库存处理业务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-10
 */
public class OsHavaObjectServiceImpl implements OsHavaObjectService {
	
	private static final Log LOG=LogFactory.getLog(OsHavaObjectServiceImpl.class);

	/**
	 * 
	  * <b>Summary: 物品入库</b>
	  *     复写方法 insertHavaObject
	  * @param osHavaObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #insertHavaObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public String insertOrupdateHavaObject(OsHavaObjectBean osHavaObjectBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			if (StringUtil.isBlank(osHavaObjectBean.getT_ha_id())) {
				osHavaObjectBean.setT_ha_id(UUID.randomUUID().toString());
				osHavaObjectDao.insertOsHavaInfo(osHavaObjectBean);
			}else{
				osHavaObjectDao.updateOsHavaInfo(osHavaObjectBean);
			}
			beanId = osHavaObjectBean.getT_ha_id();
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
	*<b>Summary: </b>
	* deleteHavaObjectByIds(根据IDs 删除库存基本信息)
	* @param ids
	* @return
	 */
	public String  deleteHavaObjectByIds(String[] ids){
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsHavaById(conn, beanId);
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
	  * <b>Summary: 更新已入库的计划审批表状态</b>
	  *     复写方法 updateOsExaByIds
	  * @param OsExaIds
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#updateOsExaByIds(java.lang.String)
	 */
	public boolean updateOsExaByIds(String OsExaIds) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			falg = osHavaObjectDao.updateOsExaState(OsExaIds);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: 根据规格ID查询库存信息</b>
	  *     复写方法 queryHavaInfoByItId
	  * @param it_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryHavaInfoByItId(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaInfoByItId(String it_id) {
		Connection conn = null;
		List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			if(it_id.split(";").length>1){
				it_id = it_id.split(";")[1];
			}
			havaValueList = osHavaObjectDao.queryHavaIdByItId(it_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return havaValueList;
	}

	/**
	 * 
	  * <b>Summary: 查询固定资产类型</b>
	  *     复写方法 queryNoMoveType
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryNoMoveType()
	 */
	public List<Map<String, String>> queryNoMoveType() {
		Connection conn = null;
		List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			havaValueList = osHavaObjectDao.queryNoMoveTypeSelect();
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return havaValueList;
	}

	/**
	 * 
	  * <b>Summary: 根据计划表ids查询出物品列表</b>
	  *     复写方法 queryOsAppRegObjectList
	  * @param ids
	  * @param bus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryOsAppRegObjectList(java.lang.String, java.lang.String)
	 */
	public List<Map<String, String>> queryOsAppRegObjectList(String ids,
			String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osAppObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osAppObjectList = osHavaObjectDao.selectOsAppObjectByIds(ids,bus_id);
			
			for (int i = 0; i < osAppObjectList.size(); i++) {
				for (int j = 0; j < osAppObjectList.size(); j++) {
					if ((!StringUtil.isBlank(osAppObjectList.get(i).get("it_id")))  
						 && (osAppObjectList.get(i).get("it_id").equals(osAppObjectList.get(j).get("it_id"))) && i!=j) {  //常用物品规格ID不为空且相同
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
	  * <b>Summary: 根据易耗品登记表id删除物品</b>
	  *     复写方法 deleteOsAppRegObjectByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#deleteOsAppRegObjectByIds(java.lang.String[])
	 */
	public String deleteOsAppRegObjectByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsAppRegObject(beanId, conn);
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
	  * <b>Summary: 增加或更新易耗品登记物品信息</b>
	  *     复写方法 insertOrUpdateOsAppRegObject
	  * @param osAppRegObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #insertOrUpdateOsAppRegObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean)
	 */
	public String insertOrUpdateOsAppRegObject(
			OsAppRegObjectBean osAppRegObjectBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
			osAppRegObjectBean.setT_osappreg_ob_id(StringUtil.getUUID());
			beanId = osAppRegObjectBean.getT_osappreg_ob_id();
			((BaseDao)dao).insert(osAppRegObjectBean, conn);
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
	  * <b>Summary: 更新已经领取的计划表状态</b>
	  *     复写方法 updateOsAppFroReg
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#updateOsAppFroReg(java.lang.String)
	 */
	public boolean updateOsAppFroReg(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
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
	  * <b>Summary: 获取相关计划表ids</b>
	  *     复写方法 queryOsAppIdsForAppRegId
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryOsAppIdsForAppRegId(java.lang.String)
	 */
	public String queryOsAppIdsForAppRegId(String id) {
		Connection conn = null;
		String osAppIds = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osAppIds = osHavaObjectDao.queryAppIdsForAppRegId(id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppIds;
	}

	/**
	 * 
	  * <b>Summary: 更新物品库存表易耗品信息</b>
	  *     复写方法 updateOsHavaObject
	  * @param osHavaObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #updateOsHavaObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean updateOsHavaObject(OsHavaObjectBean osHavaObjectBean) {
		Connection conn = null;
		List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
		boolean falgState = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			havaValueList = osHavaObjectDao.queryHavaIdByItId(osHavaObjectBean.getIt_id());
			
			if(havaValueList.size()>0){
				osHavaObjectBean.setT_ha_id(havaValueList.get(0).get("t_ha_id"));
				long t_ha_no = Long.parseLong(havaValueList.get(0).get("t_ha_no"));
				long now_t_ha_no = Long.parseLong(osHavaObjectBean.getT_ha_no());
				osHavaObjectBean.setT_ha_no(""+(t_ha_no-now_t_ha_no));
			}
			falgState = osHavaObjectDao.updateOsHavaObjectAfterLY(osHavaObjectBean);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falgState;
	}

	/**
	 * 
	  * <b>Summary: 根据易耗品申领登记表ID查询对应的物品列表</b>
	  *     复写方法 queryAppRegObjectForRegId
	  * @param bus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryAppRegObjectForRegId(java.lang.String)
	 */
	public List<Map<String, String>> queryAppRegObjectForRegId(String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osAppRegObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osAppRegObjectList = osHavaObjectDao.selectOsAppRegObjectByregId(bus_id);
			
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppRegObjectList;
	}

	/**
	 * 
	  * <b>Summary: 根据库存ids查询出物品信息</b>
	  *     复写方法 queryHavaObjectForHaIds
	  * @param haIds
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryHavaObjectForHaIds(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaObjectForHaIds(String haIds,String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osHavaObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osHavaObjectList = osHavaObjectDao.queryHavaObjectByHaIds(haIds,bus_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osHavaObjectList;
	}

	/**
	 * 
	  * <b>Summary: 插入或者更新物品领用表</b>
	  *     复写方法 insertOrUpdateHavaLYObject
	  * @param osHavaLYObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #insertOrUpdateHavaLYObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean)
	 */
	public String insertOrUpdateHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			if (StringUtil.isBlank(osHavaLYObjectBean.getT_ly_id())) {
				osHavaLYObjectBean.setT_ly_id(UUID.randomUUID().toString());
				osHavaLYObjectBean.setT_ly_date(osHavaLYObjectBean.getT_ly_date().split(" ")[0]);
				osHavaObjectDao.insertHavaLYObject(osHavaLYObjectBean);
			}else{
				osHavaObjectDao.updateHavaLYObject(osHavaLYObjectBean);
			}
			beanId = osHavaLYObjectBean.getT_ly_id();
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
	  * <b>Summary: 插入或者更新固定资产物品</b>
	  *     复写方法 insertOrUpdateNoMoveObject
	  * @param osNoMoveObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #insertOrUpdateNoMoveObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsNoMoveObjectBean)
	 */
	public String insertOrUpdateNoMoveObject(
			OsNoMoveObjectBean osNoMoveObjectBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
			osNoMoveObjectBean.setT_nomove_ob_id(StringUtil.getUUID());
			beanId = osNoMoveObjectBean.getT_nomove_ob_id();
			((BaseDao)dao).insert(osNoMoveObjectBean, conn);
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
	  * <b>Summary: 根据固定资产登记表id删除物品</b>
	  *     复写方法 deleteOsNoMoveObjectByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#deleteOsNoMoveObjectByIds(java.lang.String[])
	 */
	public String deleteOsNoMoveObjectByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
			for (String beanId : ids) {
				dao.deleteOsNoMoveObject(beanId, conn);
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
	  * <b>Summary: 根据ids更新库存设备状态</b>
	  *     复写方法 updateHavaObjectForIds
	  * @param havaIds
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#updateHavaObjectForIds(java.lang.String)
	 */
	public boolean updateHavaObjectForIds(String havaIds) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			falg = osHavaObjectDao.updateHavaObjectForIds(havaIds);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryNoMoveObjectForRegId
	  * @param bus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryNoMoveObjectForRegId(java.lang.String)
	 */
	public List<Map<String, String>> queryNoMoveObjectForRegId(String bus_id) {
		Connection conn = null;
		List<Map<String, String>> osAppRegObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osAppRegObjectList = osHavaObjectDao.queryNoMoveObjectForRegId(bus_id);
			
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppRegObjectList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryHavaIdsForRegId
	  * @param bus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryHavaIdsForRegId(java.lang.String)
	 */
	public String queryHavaIdsForRegId(String bus_id) {
		Connection conn = null;
		String osAppIds = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osAppIds = osHavaObjectDao.queryHavaIdsForRegId(bus_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osAppIds;
	}

	/**
	 * 
	  * <b>Summary: 根据主键查询库存物品信息</b>
	  *     复写方法 queryHavaObjectByHaId
	  * @param haId
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryHavaObjectByHaId(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaObjectByHaId(String haId) {
		Connection conn = null;
		List<Map<String, String>> osHavaObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osHavaObjectList = osHavaObjectDao.queryHavaObjectByHaId(haId);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osHavaObjectList;
	}

	/**
	 * 
	  * <b>Summary: 修改固定资产设备状态</b>
	  *     复写方法 updateHavaObjectStateByHaIds
	  * @param havaIds
	  * @param state
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#updateHavaObjectStateByHaIds(java.lang.String, java.lang.String)
	 */
	public boolean updateHavaObjectStateByHaIds(String havaIds, String state) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			falg = osHavaObjectDao.updateHavaObjectStateByHaIds(havaIds, state);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: 根据主键查询领用物品信息</b>
	  *     复写方法 queryMyObjectByLyId
	  * @param lyId
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#queryMyObjectByLyId(java.lang.String)
	 */
	public List<Map<String, String>> queryMyObjectByLyId(String lyId) {
		Connection conn = null;
		List<Map<String, String>> osMyObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osMyObjectList = osHavaObjectDao.queryMyObjectByLyId(lyId);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osMyObjectList;
	}

	/**
	 * 
	  * <b>Summary: 更新物品审批表已入库物品数量</b>
	  *     复写方法 updateOsexaObjectRKNO
	  * @param osexa_id
	  * @param t_osexa_obrk_no
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#updateOsexaObjectRKNO(java.lang.String, java.lang.String)
	 */
	public boolean updateOsexaObjectRKNO(String osexa_id, String t_osexa_obrk_no) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			falg = osHavaObjectDao.updateOsexaObjectRKNO(osexa_id, t_osexa_obrk_no);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: 判断审批表的所有物品数量已经全部入库</b>
	  *     复写方法 allObjectHavaRK
	  * @param t_osexa_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService#allObjectHavaRK(java.lang.String)
	 */
	public boolean allObjectHavaRK(String t_osexa_id) {
		Connection conn = null;
		boolean falg = true;
		List<Map<String,String>> osappitemList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsExaminationObjectService osExaminationObjectService = new OsExaminationObjectServiceImpl();
			osappitemList = osExaminationObjectService.selectOsExaObjectByIds(t_osexa_id);
			for (int i = 0; i < osappitemList.size(); i++) {
				long t_osexa_obrk_no = Long.parseLong(osappitemList.get(i).get("t_osexa_obrk_no"));
				long t_osexa_ob_no = Long.parseLong(osappitemList.get(i).get("t_osexa_ob_no"));
				if (t_osexa_ob_no > t_osexa_obrk_no) {
					falg = false;
				}
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: 更新库存物品所属部门</b>
	  *     复写方法 updateHavaObjectOrg
	  * @param osHavaObjectBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService
	  * #updateHavaObjectOrg(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean updateHavaObjectOrg(OsHavaObjectBean osHavaObjectBean) {
		Connection conn = null;
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			falg = osHavaObjectDao.updateHavaObjectOrg(osHavaObjectBean);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}
	
	/**
	*<b>Summary: </b>
	* queryHavaObjectBySbCode(根据设备编号查询库存物品信息)
	* @param t_ha_sbno
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectBySbCode(String t_ha_sbno){
		Connection conn = null;
		List<Map<String, String>> osHavaObjectList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsHavaObjectDao osHavaObjectDao = new OsHavaObjectDaoImpl();
			osHavaObjectList = osHavaObjectDao.queryHavaObjectBySbCode(t_ha_sbno);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return osHavaObjectList;
	}
}

package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;

/**
 * 
 *<p>Title:OsHavaObjectDao.java</p>
 *<p>Description:库存数据dao层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-10
 */
public interface OsHavaObjectDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsExaState(更新已入库的审批表的入库状态)
	* @param osExaIds
	* @return
	* @throws Exception
	 */
	public boolean updateOsExaState(String osExaIds) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaIdByItId(根据规格ID查询库存信息)
	* @param it_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaIdByItId(String it_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOsHavaInfo(插入库存信息)
	* @param osHavaObjectBean
	* @return
	* @throws Exception
	 */
	public boolean insertOsHavaInfo(OsHavaObjectBean osHavaObjectBean) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteOsHavaById(根据id删除库存基本信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsHavaById(Connection conn,String beanId)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsHavaInfo(更新库存信息)
	* @param osHavaObjectBean
	* @return
	* @throws Exception
	 */
	public boolean updateOsHavaInfo(OsHavaObjectBean osHavaObjectBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryNoMoveTypeSelect(查询固定资产类型)
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryNoMoveTypeSelect() throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOsHavaObjectList(查询库存物品列表)
	* @param osHavaObjectBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsHavaObjectList(OsHavaObjectBean osHavaObjectBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOsHavaNoMoveObjectList(查询固定资产库存状态列表)
	* @param osHavaObjectBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsHavaNoMoveObjectList(OsHavaObjectBean osHavaObjectBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* findOsAppList(查询已审核过的未入库的计划表列表)
	* @param osApplanBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsAppList(OsApplanBean osApplanBean,String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppObjectByIds(根据计划表IDS查询出相应的物品列表)
	* @param osAppIds
	* @param bus_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppObjectByIds(String osAppIds,String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsAppRegObject(根据易耗品登记表id删除物品)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteOsAppRegObject(String t_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsApplanState(更新相关计划表申领状态)
	* @param ids
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateOsApplanState(String ids, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryAppIdsForAppRegId(根据易耗品申领登记表ID查询对应的计划表ids)
	* @param appRegid
	* @return
	* @throws Exception
	 */
	public String queryAppIdsForAppRegId(String appRegid) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppRegObjectByregId(根据易耗品申领登记表ID查询对应的物品列表)
	* @param appRegId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppRegObjectByregId(String appRegId)  throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsHavaObjectAfterLY(易耗品领用后更新数量)
	* @param osHavaObjectBean
	* @return
	* @throws Exception
	 */
	public boolean updateOsHavaObjectAfterLY(OsHavaObjectBean osHavaObjectBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaObjectByHaIds(根据库存ids查询出物品信息)
	* @param haIds
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectByHaIds(String haIds,String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertHavaLYObject(插入物品领用表)
	* @param osHavaLYObjectBean
	* @return
	* @throws Exception
	 */
	public boolean insertHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaLYObject(更新物品领用表)
	* @param osHavaLYObjectBean
	* @return
	* @throws Exception
	 */
	public boolean updateHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsNoMoveObject(根据固定资产领用登记表id删除物品)
	* @param busi_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteOsNoMoveObject(String busi_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectForIds(根据ids更新库存设备状态)
	* @param havaIds
	* @return
	* @throws Exception
	 */
	public boolean updateHavaObjectForIds(String havaIds) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryNoMoveObjectForRegId(固定资产申领表ID查询物品信息)
	* @param bus_id
	* @return
	 */
	public List<Map<String, String>> queryNoMoveObjectForRegId(String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaIdsForRegId(固定资产ID查询相关库存物品IDs)
	* @param bus_id
	* @return
	 */
	public String queryHavaIdsForRegId(String bus_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOsHavaLYObjectList(物品领用列表)
	* @param osHavaLYObjectBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsHavaLYObjectList(OsHavaLYObjectBean osHavaLYObjectBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	public PagingBean findOsHavaLYObjectList(String parmjson, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* queryHavaObjectByHaId(根据主键查询库存物品信息)
	* @param haId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectByHaId(String haId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectStateByHaIds(修改固定资产设备状态)
	* @param havaIds
	* @param state
	* @return
	* @throws Exception
	 */
	public boolean updateHavaObjectStateByHaIds(String havaIds,String state) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryMyObjectByLyId(根据主键查询领用物品信息)
	* @param lyId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryMyObjectByLyId(String lyId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsexaObjectRKNO(更新物品审批表已入库物品数量)
	* @param osexa_id
	* @param t_osexa_obrk_no
	* @return
	* @throws Exception
	 */
	public boolean updateOsexaObjectRKNO(String osexa_id,String t_osexa_obrk_no) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectOrg(更新库存物品所属部门)
	* @param osHavaObjectBean
	* @return
	* @throws Exception
	 */
	public boolean updateHavaObjectOrg(OsHavaObjectBean osHavaObjectBean) throws Exception;
	
	/**
	*<b>Summary: </b>
	* queryHavaObjectBySbCode(根据设备编号 查询库存物品信息)
	* @param t_ha_sbno
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectBySbCode(String t_ha_sbno) throws Exception;
	
	public PagingBean findOsHavaList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}

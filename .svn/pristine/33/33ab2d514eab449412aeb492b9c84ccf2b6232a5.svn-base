package com.chinacreator.xtbg.tjy.officesupplies.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsNoMoveObjectBean;

/**
 * 
 *<p>Title:OsHavaObjectService.java</p>
 *<p>Description:物品库存数据处理业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-10
 */
public interface OsHavaObjectService {

	/**
	 * 
	*<b>Summary: </b>
	* insertHavaObject(物品入库)
	* @param osHavaObjectBean
	* @return
	 */
	public String insertOrupdateHavaObject(OsHavaObjectBean osHavaObjectBean);
	
	/**
	*<b>Summary: </b>
	* deleteHavaObjectByIds(根据IDs 删除库存基本信息)
	* @param ids
	* @return
	 */
	public String  deleteHavaObjectByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsExaByIds(更新已入库的计划审批表状态)
	* @param OsExaIds
	* @return
	 */
	public boolean updateOsExaByIds(String OsExaIds);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaInfoByItId(根据规格ID查询库存信息)
	* @param it_id
	* @return
	 */
	public List<Map<String, String>> queryHavaInfoByItId(String it_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryNoMoveType(查询固定资产类型)
	* @return
	 */
	public List<Map<String, String>> queryNoMoveType();
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsAppRegObjectList(根据计划表ids查询出物品列表)
	* @param ids
	* @param bus_id
	* @return
	 */
	public List<Map<String, String>> queryOsAppRegObjectList(String ids,String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsAppRegObjectByIds(根据易耗品登记表id删除物品)
	* @param ids
	* @return
	 */
	public String deleteOsAppRegObjectByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateOsAppRegObject(增加或更新易耗品登记物品信息)
	* @param osAppRegObjectBean
	* @return
	 */
	public String insertOrUpdateOsAppRegObject(OsAppRegObjectBean osAppRegObjectBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsAppFroReg(更新已经领取的计划表状态)
	* @param ids
	* @return
	 */
	public boolean updateOsAppFroReg(String ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsAppIdsForAppRegId(获取相关计划表ids)
	* @param id
	* @return
	 */
	public String queryOsAppIdsForAppRegId(String id); 
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsHavaObject(更新物品库存表易耗品信息)
	* @param osHavaObjectBean
	* @return
	 */
	public boolean updateOsHavaObject(OsHavaObjectBean osHavaObjectBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryAppRegObjectForRegId(根据易耗品申领登记表ID查询对应的物品列表)
	* @param bus_id
	* @return
	 */
	public List<Map<String, String>> queryAppRegObjectForRegId(String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaObjectForHaIds(根据库存ids查询出物品信息)
	* @param haIds
	* @return
	 */
	public List<Map<String, String>> queryHavaObjectForHaIds(String haIds,String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateHavaLYObject(插入或者更新物品领用表)
	* @param osHavaLYObjectBean
	* @return
	 */
	public String insertOrUpdateHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateNoMoveObject(插入或者更新固定资产物品)
	* @param osNoMoveObjectBean
	* @return
	 */
	public String insertOrUpdateNoMoveObject(OsNoMoveObjectBean osNoMoveObjectBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsNoMoveObjectByIds(根据固定资产登记表id删除物品)
	* @param ids
	* @return
	 */
	public String deleteOsNoMoveObjectByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectForIds(根据ids更新库存设备状态)
	* @param havaIds
	* @return
	 */
	public boolean updateHavaObjectForIds(String havaIds);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryNoMoveObjectForRegId(固定资产ID查询物品信息)
	* @param bus_id
	* @return
	 */
	public List<Map<String, String>> queryNoMoveObjectForRegId(String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaIdsForRegId(固定资产ID查询相关库存物品IDs)
	* @param bus_id
	* @return
	 */
	public String queryHavaIdsForRegId(String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryHavaObjectByHaId(根据主键查询库存物品信息)
	* @param haId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectByHaId(String haId);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectStateByHaIds(修改固定资产设备状态)
	* @param havaIds
	* @param state
	* @return
	 */
	public boolean updateHavaObjectStateByHaIds(String havaIds,String state);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryMyObjectByLyId(根据主键查询领用物品信息)
	* @param lyId
	* @return
	 */
	public List<Map<String, String>> queryMyObjectByLyId(String lyId);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsexaObjectRKNO(更新物品审批表已入库物品数量)
	* @param osexa_id
	* @param t_osexa_obrk_no
	* @return
	 */
	public boolean updateOsexaObjectRKNO(String osexa_id,String t_osexa_obrk_no);
	
	/**
	 * 
	*<b>Summary: </b>
	* allObjectHavaRK(判断审批表的所有物品数量已经全部入库)
	* @param t_osexa_id
	* @return
	 */
	public boolean allObjectHavaRK(String t_osexa_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateHavaObjectOrg(更新库存物品所属部门)
	* @param osHavaObjectBean
	* @return
	 */
	public boolean updateHavaObjectOrg(OsHavaObjectBean osHavaObjectBean);
	
	
	/**
	*<b>Summary: </b>
	* queryHavaObjectBySbCode(根据设备编号查询库存物品信息)
	* @param t_ha_sbno
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectBySbCode(String t_ha_sbno);
}

package com.chinacreator.xtbg.tjy.detectionsupplies.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsExaminationBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaObjectBean;

/**
 * 
 *<p>Title:OsExaminationObjectService.java</p>
 *<p>Description:审批表业务数据处理业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public interface OsExaminationObjectService {
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsAppList(根据ids查询出计划表数据)
	* @param ids
	* @return
	 */
	public List<Map<String, String>> queryOsAppList(String ids,String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryNoLikeOsAppObjectList(根据计划表ids查询出物品列表并将相同的常用物品合并)
	* @param ids
	* @param bus_id
	* @return
	 */
	public List<Map<String, String>> queryNoLikeOsAppObjectList(String ids,String bus_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateOsExaObject(新增或者更新计划审批表所填物品)
	* @param osExaminationBean
	* @return
	 */
	public String insertOrUpdateOsExaObject(OsExaminationBean osExaminationBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsExaObject(根据计划审批表id查询出物品列表)
	* @param t_id
	* @return
	 */
	public List<Map<String, String>> selectOsExaObject(String t_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsExaObjectByIds(根据计划审批表ids删除物品)
	* @param ids
	* @return
	 */
	public String  deleteOsExaObjectByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateOsAplan(更新计划表的审批状态)
	* @param ids
	* @return
	 */
	public boolean updateOsAplan(String ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsAppIdsForExaId(根据审批id查询存储的计划表id)
	* @param id
	* @return
	 */
	public String queryOsAppIdsForExaId(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsExaObject(根据计划审批表ids查询出物品列表)
	* @param t_ids
	* @return
	 */
	public List<Map<String, String>> selectOsExaObjectByIds(String t_ids);

	public void insertOrUpdateOsApplanObject(OsApplanBean osApplanBean);

	public void insertOrUpdateHavaObject(OsHavaObjectBean osHavaObjectBean);

}

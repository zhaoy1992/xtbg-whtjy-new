package com.chinacreator.xtbg.tjy.detectionsupplies.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsAppObjectBean;
/**
 * 
 *<p>Title:OsAppObjectService.java</p>
 *<p>Description:处理添加入计划表的物品数据业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public interface OsAppObjectService {
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateOsApp(新增计划表所填物品)
	* @param objectBean
	* @return
	 */
	public String insertOrUpdateOsApp(OsAppObjectBean objectBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppObject(根据计划表id查询出物品列表)
	* @param t_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsAppObjectByIds(根据计划表ids删除物品)
	* @param ids
	* @return
	 */
	public String  deleteOsAppObjectByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* onlyUpdateOsApp(更新计划表所填物品)
	* @param objectBean
	* @return
	 */
	public boolean onlyUpdateOsApp(OsAppObjectBean objectBean);

}

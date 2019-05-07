package com.chinacreator.xtbg.tjy.officesupplies.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieRepairBean;

/**
 * 
 *<p>Title:OsupplieRepairService.java</p>
 *<p>Description:办公用品管理-维修登记service</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-7
 */
public interface OsupplieRepairService {
	/**
	 * 
	*<b>Summary: </b>
	* getRepairInfo(根据osupplieRepairBean信息获取相应的一条数据)
	* @param osupplieRepairBean
	* @return
	 */
	public Map<String,String> getRepairInfo(OsupplieRepairBean osupplieRepairBean);
	
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOrUpdate(保存或更新)
	* @param osupplieRepairBean
	* @return
	 */
	public String saveOrUpdate(OsupplieRepairBean osupplieRepairBean);
	/**
	 * 
	*<b>Summary: </b>
	* delete(删除)
	* @param ids
	* @return
	 */
	public String delete(String ids);
}

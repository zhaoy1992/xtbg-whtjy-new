package com.chinacreator.xtbg.core.file.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FileDestroyDetalBean;

/**
 *<p>Title:FileDestroyService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
public interface FileDestroyService {
	/**
	 * 
	*<b>Summary: </b>
	* addfiledestroydetal(添加销毁清册数据
	* @param fileDocBeanIds
	* @param userId
	* @return
	 */
	public boolean addfiledestroydetal(FileDestroyDetalBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* updatedestroydetal(恢复销毁状态时/同时也要 更新doc文件表的状态)
	* @param bean
	* @return
	 */
	public boolean updatedestroydetal(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getFiledestoryDetail(根据销毁主表ID 查询销魂详细)
	* @param id
	* @return
	 */
	public List<Map<String, String>> getFiledestoryDetail(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* delfiledestroy(根据ID 删除业务数据)
	* @param id
	* @return
	 */
	public boolean delfiledestroy(String[] id);
	
	public boolean stopFileDestroy(String ids);
}

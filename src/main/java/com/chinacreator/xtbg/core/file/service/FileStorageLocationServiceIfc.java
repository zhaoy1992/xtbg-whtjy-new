package com.chinacreator.xtbg.core.file.service;

import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FileStorageLocationBean;

/**
 * 
 *<p>Title:FileStorageLocation.java</p>
 *<p>Description:档案存放位置管理服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-15
 */
public interface FileStorageLocationServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* deleteFileStorage(删除存放位置信息)
	* @param f_storage_id
	* @return
	 */
	public String deleteFileStorage(String f_storage_id);
	/**
	 * 
	*<b>Summary: </b>
	* getFileStorangeLocationBean(根据f_storage_id查询存放位置信息)
	* @param f_storage_id
	* @return
	 */
	public Map<String, String> getFileStorangeLocationBean(String f_storage_id);
	/**
	 * 
	*<b>Summary: </b>
	* addFileStorageLocation(添加存放位置信息)
	* @param fileStorageLocationBean
	* @return
	 */
	public boolean addFileStorageLocation(FileStorageLocationBean fileStorageLocationBean);
	/**
	 * 
	*<b>Summary: </b>
	* updateFileStorageLocatio(修改存放位置信息)
	* @param fileStorageLocationBean
	* @return
	 */
	public boolean updateFileStorageLocation(FileStorageLocationBean fileStorageLocationBean);
}

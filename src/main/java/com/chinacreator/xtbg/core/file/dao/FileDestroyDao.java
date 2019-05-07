package com.chinacreator.xtbg.core.file.dao;

import java.util.List;
import java.util.Map;
import java.sql.Connection;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileDestroyBean;
import com.chinacreator.xtbg.core.file.entity.FileDestroyDetalBean;

/**
 *<p>Title:FileDestroyDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
public interface FileDestroyDao {
	/**
	 * 
	*<b>Summary: </b>
	* queryFileDocList(查询销毁申请列表处于审批中的数据)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryFileDocList(FileDestroyBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryFileDocList(查询销毁清单
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryFileInventoryList(FileDestroyDetalBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getFiledestoryDetail(根据销毁主表ID 查询销魂详细)
	* @param beanIds
	* @return
	 */
	public List<Map<String,String>> getFiledestoryDetail(String id,Connection coon)throws Exception;
	/**
	 * 
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	public boolean stopFileDestroy(String ids,Connection conn)throws Exception;
}

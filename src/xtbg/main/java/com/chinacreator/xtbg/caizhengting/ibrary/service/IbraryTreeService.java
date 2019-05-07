
 /**
 * [Product]
  *     xtbg-base
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     IbraryTreeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-9-3   rt    最初版本
   */
package com.chinacreator.xtbg.caizhengting.ibrary.service;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean;

/**
 *<p>Title:IbraryTreeService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryTreeService {
	/**
	 * 
	*<b>Summary: </b>
	* addIbraryTree(增加图书分类信息)
	* @param bean
	* @return
	 */
	public String addIbraryTree(IbraryTreeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* delIbraryTree(删除图书分类信息 type表示删除类型)
	* @param id
	* @return
	 */
	public String delIbraryTree(String id,String type);
	
	/**
	 * 
	*<b>Summary: </b>
	* getbeanbyid(根据ID查询分类详细)
	* @param id
	* @return
	 */
	public IbraryTreeBean getbeanbyid(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebean(更新)
	* @param bean
	* @return
	 */
	public String updatebean(IbraryTreeBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getbookbytreeid(根据节点ID查询 是否存在图书信息  (删除用到))
	* @param treeid
	* @return
	 */
	public int  getbookbytreeid(String treeid);
	
	/**
	 * 
	*<b>Summary: </b>
	* getCodeNo(获取最大排序号)
	* @return
	 */
	public String getCodeNo(String id,String type_code);
}

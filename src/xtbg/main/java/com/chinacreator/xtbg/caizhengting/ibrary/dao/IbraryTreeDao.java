package com.chinacreator.xtbg.caizhengting.ibrary.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean;
import com.chinacreator.xtbg.pub.common.PagingBean;

/**
 *<p>Title:IbraryTreeDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryTreeDao {
	/**
	 * 
	*<b>Summary: </b>
	* addIbraryTree(增加图书分类信息)
	* @param bean
	* @return
	 */
	public String addIbraryTree(IbraryTreeBean bean,Connection con)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* delIbraryTree(删除图书分类信息)
	* @param id
	* @return
	 */
	public String delIbraryTree(String id,String type,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getbeanbyid(根据ID查询分类详细)
	* @param id
	* @return
	 */
	public IbraryTreeBean getbeanbyid(String id,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* list(pagebean)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @param con
	* @return
	* @throws Exception
	 */
	public PagingBean list(IbraryTreeBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebean(更新)
	* @param bean
	* @return
	 */
	public String updatebean(IbraryTreeBean bean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getbookbytreeid(根据节点ID 查询受否包含图书信息 删除时需用到)
	* @param treeid
	* @param con
	* @return
	* @throws Exception
	 */
	public int getbookbytreeid(String treeid)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getCodeNo(获取最大排序号)
	* @param con
	* @return
	* @throws Exception
	 */
	public String getCodeNo(String id,String type_code,Connection con)throws Exception;
}

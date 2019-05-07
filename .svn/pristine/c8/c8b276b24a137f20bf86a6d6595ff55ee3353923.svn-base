package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.archive.entity.BudgetFileBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:BudgetFileDao.java</p>
 *<p>Description:指标文拆分-指标文总信息Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public interface BudgetFileDao {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void insert(BudgetFileBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary: 更新</b>
	* update()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void update(BudgetFileBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary: 分页查询</b>
	* list()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @param con
	* @return
	* @throws Exception
	 */
	public PagingBean list(BudgetFileBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary: 根据业务ID和文件名查询数据</b>
	* deleteByBussidAndFileName()
	* @param bean
	 */
	public BudgetFileBean selectByBussid(BudgetFileBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary:根据指标文总信息id删除数据 </b>
	* deleteById()
	* @param id
	* @param con
	* @throws Exception
	 */
	public void deleteById(String id,Connection con ) throws Exception;
}

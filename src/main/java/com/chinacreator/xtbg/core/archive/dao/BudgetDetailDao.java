package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:BudgetDetailDao.java</p>
 *<p>Description:指标文拆分-拆分明细信息Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public interface BudgetDetailDao {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void insert(BudgetDetailBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary: 更新</b>
	* update()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void update(BudgetDetailBean bean,Connection con ) throws Exception;
	
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
	public PagingBean list(BudgetDetailBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary:根据指标文总信息id删除数据 </b>
	* deleteById()
	* @param id
	* @param con
	* @throws Exception
	 */
	public void deleteById(String id,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary: 根据详细id 删除详细数据</b>
	* deleteByDetailId()
	* @throws Exception
	 */
	public void deleteByDetailId(String id,Connection con ) throws Exception;

	/**
	 * 
	*<b>Summary: 根据拆分主文件id和拆分单位id得到详细数据</b>
	* getByFileIdAndUnitId()
	* @param bean
	* @param con
	* @return
	 */
	public BudgetDetailBean getByFileIdAndUnitId(BudgetDetailBean bean,Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary:根据fileid的到详细数据</b>
	* getByFileId()
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public List<BudgetDetailBean> getByFileId(BudgetDetailBean bean,Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary:根据详细id的到详细数据</b>
	* getByFileId()
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public BudgetDetailBean getByDetailId(BudgetDetailBean bean,Connection con) throws Exception;
}
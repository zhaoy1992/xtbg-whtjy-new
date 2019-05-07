package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.BudgetAttachBean;

/**
 * 
 *<p>Title:BudgetAttachDao.java</p>
 *<p>Description:指标文拆分-附件表DAO</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public interface BudgetAttachDao {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void insert(BudgetAttachBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary: 更新</b>
	* update()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void update(BudgetAttachBean bean,Connection con ) throws Exception;
	
	/**
	 * 
	*<b>Summary:根据指标问总信息查找附件信息 </b>
	* listById()
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public List<BudgetAttachBean> listById(BudgetAttachBean bean,Connection con ) throws Exception;
	
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
	*<b>Summary: 根据bus_id和shown_name获取bean</b>
	* getByBusIdAndShownName()
	* @param bean
	* @return
	 */
	public BudgetAttachBean getByIdAndShownName(BudgetAttachBean bean,Connection con ) throws Exception;
}

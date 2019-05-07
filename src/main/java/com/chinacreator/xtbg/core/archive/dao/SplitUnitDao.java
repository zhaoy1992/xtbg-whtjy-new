package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:SplitLogDao.java</p>
 *<p>Description:指标文拆分单位DAO</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public interface SplitUnitDao {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void insert(SplitUnitBean bean,Connection con ) throws Exception;
	
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
	public PagingBean list(SplitUnitBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary: 根据ID得到数据</b>
	* getById()
	* @param id
	* @param con
	* @return
	* @throws Exception
	 */
	public SplitUnitBean getById(SplitUnitBean bean,Connection con ) throws Exception;

	/**
	 * 
	*<b>Summary: 更新</b>
	* update()
	* @param bean
	* @param con
	 */
	public void update(SplitUnitBean bean, Connection con) throws Exception;

	/**
	 * 
	*<b>Summary: 无分页查询</b>
	* list()
	* @param bean
	* @param con
	* @return
	 */
	public List<SplitUnitBean> list(SplitUnitBean bean, Connection con) throws Exception;

	/**
	 * 
	*<b>Summary: 根据ID删除</b>
	* deleteById()
	* @param unit_ids
	* @param con
	* @throws Exception
	 */
	public void deleteById(String unit_ids, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: 根据单位名称得到数据</b>
	* getByUnitName()
	* @return
	* @throws Exception
	 */
	public SplitUnitBean getByUnitName(SplitUnitBean bean, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: 根据公文传输机构id得到数据 </b>
	* getUnitByGwcsOrgId()
	* @param bean
	* @param con
	* @return
	 */
	public SplitUnitBean getUnitByGwcsOrgId(SplitUnitBean bean, Connection con) throws Exception;
}

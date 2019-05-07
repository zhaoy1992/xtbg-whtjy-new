package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.SplitLogBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:SplitLogDao.java</p>
 *<p>Description:指标文拆分记录DAO</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public interface SplitLogDao {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public void insert(SplitLogBean bean,Connection con ) throws Exception;
	
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
	public PagingBean list(SplitLogBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary: 根据业务ID和文件名删除数据</b>
	* deleteByBussidAndFileName()
	* @param bean
	 */
	public void deleteByBussidAndFileName(SplitLogBean bean,Connection con ) throws Exception;
	/**
	 * 
	*<b>Summary:查询所拆分的文件中与公文传输关联的机构 </b>
	* getGwcsOrg()
	* @param bean
	* @return
	 */
	public List<SplitLogBean> getGwcsOrg(SplitLogBean bean,Connection con) throws Exception;
	
}

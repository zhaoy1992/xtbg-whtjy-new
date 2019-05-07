
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ProFlowBusiSearchDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.processing.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;

/**
 *<p>Title:ProFlowBusiSearchDao.java</p>
 *<p>Description:事务处理Dao层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public interface ProFlowBusiSearchDao {

	/**
	 * 
	*<b>Summary: </b>
	* findDoWorkList(根据条件查询待办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findDoWorkList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findLsWorkList(查询相关历史流程)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findLsWorkList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findFlowManageList(根据条件查询后台管理列表)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findFlowManageList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findToBeWorkList(根据条件查询暂存列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findToBeWorkList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findSituation(根据条件查询已办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findDoneWorkList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findDoneWorkFindList(文件查询列表)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findDoneWorkFindList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findFlowChiefList(督办列表)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findFlowChiefList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* findSituation(公文全局查询)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findSituation(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getProcInsIdByBussinessId(查询流程实例ID)
	* @param bussinessid
	* @return
	* @throws SQLException
	 */
	public String getProcInsIdByBussinessId(String bussinessid) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getProcInsIdByInsId(查询cc_form_instanceid)
	* @param ins_id
	* @return
	* @throws SQLException
	 */
	public String getProcInsIdByInsId(String ins_id) throws SQLException;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* findPlandoneDeWorkList(根据条件查询所有人员的[易耗品申购计划表]已办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findPlandoneDeWorkList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findPlandoneDeWorkList(根据条件查询所有人员的[检测耗材易耗品申购计划表]已办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findDETPlandoneDeWorkList(
			WorkFlowSearchBean workFlowSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findPlandoneDeWorkList(根据条件查询所有人员的[食堂物品易耗品申购计划表]已办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findCANPlandoneDeWorkList(
			WorkFlowSearchBean workFlowSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateClgl(修改车辆管理的is_valid字段)
	 */
	public void updateClgl();
	
}

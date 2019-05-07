
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2015 ICSS All Rights Reserved.
  * [FileName]
  *     FlowAnswersBusiSearchDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2015-2-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.answers.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;

/**
 *<p>Title:FlowAnswersBusiSearchDao.java</p>
 *<p>Description:有问必答数据库处理接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2015-2-3
 */
public interface FlowAnswersBusiSearchDao {
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
	 *<b>Summary: </b>
	 * findViewAnswersList(有问必答查看列表)
	 * @param workFlowSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findViewAnswersList(WorkFlowSearchBean workFlowSearchBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
}

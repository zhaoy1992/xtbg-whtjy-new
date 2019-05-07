package com.chinacreator.xtbg.core.task.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskTypeBean;




/**
 * 
 *<p>Title:TasksAssignedDao.java</p>
 *<p>Description:任务交办dao接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-10
 */
public interface TasksAssignedDao {

	/**
	 * 
	*<b>Summary: 查询我发起的任务列表数据</b>
	* findTasksList()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findTasksList(TaskBaseInfoBean bean, String sortName, String sortOrder, long offset, int maxPagesize) 
	throws Exception;
	
	/**
	 * 
	*<b>Summary:根据type种类查询type信息 </b>
	* queryTaskTypeBySort()
	* @param typeSort  类型分类信息
	* @return          类型列表数据
	* @throws Exception
	 */
	public List<TaskTypeBean> queryTaskTypeBySort(String typeSort,Connection conn) throws Exception;
		
}

package com.chinacreator.xtbg.core.task.dao;

import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskReportBean;


/**
 * 
 *<p>Title:TasksReportDao.java</p>
 *<p>Description:任务回复列表数据</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-11
 */
public interface TasksReportDao {

	/**
	 * 
	*<b>Summary: 查询任务回复列表</b>
	* findTasksList()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findTasksList(TaskReportBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * @Description  查询任务回复信息
	 * 
	 * @param id 任务id
	 * @return  List
	 * @exception 
	 */
	public List<TaskReportBean> findTasksListById(String id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findTasksTJList(任务统计列表)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findTasksTJList(TaskBaseInfoBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findTasksTJBean(根据责任人ID查询任务统计数据)
	* @param user_id
	* @return
	* @throws Exception
	 */
	public TaskBaseInfoBean findTasksTJBean(String user_id) throws Exception;
}

package com.chinacreator.xtbg.core.task.service;

import java.util.List;

import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskTypeBean;

/**
 * 
 *<p>Title:TasksAssignedServiceIfc.java</p>
 *<p>Description:任务交办service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-12
 */
public interface TasksAssignedServiceIfc {

	/**
	 * 
	*<b>Summary: 根据类型分类信息查询类型信息</b>
	* queryTaskTypeBySort()
	* @param typeSort
	* @return
	 */
	public List<TaskTypeBean> queryTaskTypeBySort(String typeSort);
	
	/**
	 * 
	*<b>Summary: 根据id查询任务基本信息对象</b>
	* queryToTaskBaseInfoBean()
	* @param id 任务id
	* @return TaskBaseInfoBean 任务bean对象
	 */
	public TaskBaseInfoBean queryToTaskBaseInfoBean(String id);
	
	
    /**
     * 
    *<b>Summary: 保存</b>
    * insertTaskBaseInfo()
    * @param bean
    * @return
     */
    public boolean insertTaskBaseInfo(TaskBaseInfoBean bean);
    
    /**
     * 
    *<b>Summary: 根据id批量删除数据</b>
    * deleteListMeetingMinutes()
    * @param ids id列表
    * @return
     */
    public boolean deleteListTaskBaseInfo(String ids) ;
    
    /**
     * 
    *<b>Summary: 更新任务</b>
    * updateTaskBaseInfo()
    * @param bean
    * @return
     */
    public boolean updateTaskBaseInfo(TaskBaseInfoBean bean);
	
    
}
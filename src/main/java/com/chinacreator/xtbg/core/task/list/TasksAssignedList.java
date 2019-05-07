package com.chinacreator.xtbg.core.task.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.task.dao.TasksAssignedDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;

/**
 * 
 *<p>Title:TasksAssignedList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-8
 */
public class TasksAssignedList extends DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(TasksAssignedList.class);
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = null;
		try {
			TaskBaseInfoBean instanceBean = null;
			instanceBean = StringUtil.convertStringToBean(parmjson,
					TaskBaseInfoBean.class);

			TasksAssignedDao dao = (TasksAssignedDao) LoadSpringContext
					.getApplicationContext().getBean("tasksAssignedDaoImpl");
			pb = dao.findTasksList(instanceBean, sortName, sortOrder,
					offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
package com.chinacreator.xtbg.core.task.list;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.task.dao.TasksReportDao;
import com.chinacreator.xtbg.core.task.entity.TaskReportBean;

/**
 *<p>Title:BriefsTypeList .java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author 付程
 *@version 1.0
 *2012-2-23
 */
public class TasksReportList extends DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(TasksReportList.class);
	
	/**
	 * @Description  查询简报类型列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String paramjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		PagingBean pb = null;
		TaskReportBean bean = StringUtil.convertStringToBean(paramjson, TaskReportBean.class);
		 
		try {
			TasksReportDao daojson = (TasksReportDao)LoadSpringContext
			.getApplicationContext().getBean("tasksReportDaoImpl");
			pb = daojson.findTasksList(bean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}

/**
 * 
  * <b>Summary: </b>
  *     复写方法 getDataList
  * @param parmStr
  * @param sortName
  * @param sortOrder
  * @return 
  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
 */
	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}

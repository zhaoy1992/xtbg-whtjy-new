package com.chinacreator.xtbg.core.task.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.task.dao.TasksAssignedDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>
 * Title:BriefsTypeDaoImpl.java
 * </p>
 *<p>
 * Description:密集程度信息实例类
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 付程
 *@version 1.0 2012-2-23
 */
public class TasksAssignedDaoImpl  extends XtDbBaseDao implements TasksAssignedDao {


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findTasksList
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.task.dao.TasksAssignedDao#findTasksList(com.chinacreator.xtbg.core.task.entity.TasksAssignedBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findTasksList(TaskBaseInfoBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();			
			
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.id,");
			sql.append("       a.task_name,");
			sql.append("       to_char(a.start_time,'yyyy-mm-dd') as start_time,");
			sql.append("       to_char(a.end_time,'yyyy-mm-dd') as end_time ,");
			sql.append("       a.higher_level_task,");
			sql.append("       a.task_content,");
			//特检院OA 追加任务要求字段  start 2014-05-05
			sql.append("       a.task_needinfo,");
			sql.append("       to_char(a.complete_time,'yyyy-mm-dd') as complete_time ,");
			//特检院OA 追加任务要求字段  end 2014-05-05
			sql.append("       a.degree_of_importance,");
			sql.append("       a.completion_rate,");
			sql.append("       a. task_type,");
			sql.append("       a.attach_id,");
			sql.append("       a.task_status,");
			sql.append("       decode(a.task_status,'3','已办结','2','办理中','未办理') as task_status_name,");
			sql.append("       a.input_userid,");
			sql.append("       a.input_orgid,");
			sql.append("       a.del_ident,");
			sql.append("       a.input_username,");
			sql.append("       a.input_orgname,");
			sql.append("       a.receive_userid,");
			sql.append("       a.receive_username,");
			sql.append("       a.receive_orgid,");
			sql.append("       a.receive_orgname,");
			sql.append("       b.type_name,");
			sql.append("       (select count(*)");
			sql.append("          from oa_task_taskreport c");
			sql.append("         where a.id = c.task_id");
			sql.append("           and c.type = '0'");
			if(!StringUtil.nullOrBlank(bean.getCount_user_id())){
				sql.append("           and c.user_id <> ?");
				conditionValues.add(bean.getCount_user_id());
			}
			sql.append(" ) as report_count");
			sql.append("  from oa_task_baseinfo a");
			sql.append("  left join oa_task_type b");
			sql.append("    on a.task_type = b.type_id");
			
			//用户id
			if(!StringUtil.nullOrBlank(bean.getInput_userid() )){
				sql.append(" where a.input_userid = ? ");
				conditionValues.add(bean.getInput_userid());
			}
			//接收任务的用户id
			if(!StringUtil.nullOrBlank(bean.getReceive_userid())){
				sql.append(" where a.receive_userid = ? ");
				conditionValues.add(bean.getReceive_userid());
			}
            //任务名
			if (!StringUtil.nullOrBlank(bean.getTask_name())) {
				sql.append(" and a.task_name like '%'||?||'%'");
				conditionValues.add(bean.getTask_name());
			}
			//重要程度
			if (!StringUtil.nullOrBlank(bean.getDegree_of_importance())) {
				sql.append(" and a.degree_of_importance = ? ");
				conditionValues.add(bean.getDegree_of_importance());
			}
			if (!StringUtil.nullOrBlank(bean.getTask_status())) {
				sql.append(" and a.task_status =? ");
				conditionValues.add(bean.getTask_status());
			}
			if (!StringUtil.nullOrBlank(bean.getTask_type())) {
				sql.append(" and a.task_type = ? ");
				conditionValues.add(bean.getTask_type());						
			}
			if (!StringUtil.nullOrBlank(bean.getStart_time())) {
				sql.append(" and a.Start_time>=to_date(?,'yyyy-mm-dd hh24:mi:ss')");
				conditionValues.add(bean.getStart_time()+" 00:00:00");
			}
			if (!StringUtil.nullOrBlank(bean.getEnd_time())) {
				sql.append(" and a.Start_time<=to_date(?,'yyyy-MM-dd hh24:mi:ss')");
				conditionValues.add(bean.getEnd_time()+" 23:59:59");
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryTaskTypeBySort
	  * @param typeSort
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.task.dao.TasksAssignedDao#queryTaskTypeBySort(java.lang.String, java.sql.Connection)
	 */
	@SuppressWarnings("unchecked")
	public List<TaskTypeBean> queryTaskTypeBySort(String typeSort,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" select type_id, type_name, type_sort, type_value");
		sql.append("   from oa_task_type ");
		sql.append("  where type_sort = ? ");
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, typeSort);
		return (List<TaskTypeBean>) pdb.executePreparedForList(conn,
				TaskTypeBean.class);
	}
}

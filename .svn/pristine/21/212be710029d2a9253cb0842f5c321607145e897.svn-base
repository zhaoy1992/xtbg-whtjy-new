package com.chinacreator.xtbg.core.task.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.task.dao.TasksReportDao;
import com.chinacreator.xtbg.core.task.entity.TaskBaseInfoBean;
import com.chinacreator.xtbg.core.task.entity.TaskReportBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:TasksReportDaoImpl.java</p>
 *<p>Description:查询任务回复列表数据</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-11
 */
public class TasksReportDaoImpl extends XtDbBaseDao implements TasksReportDao { 
	
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
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
		    StringBuffer sql = new StringBuffer();
			List<String> condition = new ArrayList<String>();

			sql.append("select id,");
			sql.append("       task_id,");
			sql.append("       report_content,");
			sql
					.append("       to_char(report_time,'yyyy-mm-dd hh24:mi') as report_time,");
			sql.append("       attach_id,");
			sql.append("       user_id,");
			sql.append("       type,");
			sql.append("       user_name");
			sql.append("  from oa_task_taskreport where id is not null ");

			if (!StringUtil.nullOrBlank(bean.getTask_id())) {
				sql.append(" and task_id=?");
				condition.add(bean.getTask_id());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					condition);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	  * <b>Summary: 查询任务回复信息 </b>
	  *     复写方法 findTasksListById
	  * @param id 任务id
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.task.dao.TasksReportDao#findTasksListById(java.lang.String)
	 */
	public List<TaskReportBean> findTasksListById(String id)
			throws Exception {

		// 预留查询回复信息的接口
		return new ArrayList<TaskReportBean>();
		// Connection conn = null;
		// List<TasksAssignedBean> list = new ArrayList<TasksAssignedBean>();
		// try {
		// if (StringUtil.nullOrBlank(id)) {
		// return list;
		// }
		// conn = DbManager.getInstance().getConnection();
		//
		// PreparedDBUtil db = new PreparedDBUtil();
		// StringBuffer sql = new StringBuffer();
		// sql.append("select");
		// sql.append(" 		t.id,");
		// sql.append(" 		t.report_content,");
		// sql.append(" 		t.report_time ,t.user_id,d.user_realname");
		// sql.append(" from oa_task_taskreport t ");
		// sql.append(" inner join oa_task_baseinfo k on t.task_id =k.id");
		// sql.append(" inner join td_sm_user d on t.user_id = d.user_id");
		// sql.append(" where ");
		// sql.append(" k.id ='" + id + "'");
		//
		// db.preparedSelect(sql.toString());
		// db.executePrepared(conn);
		//			
		// super.queryToListMap(sql, offset, pagesize, conn, values)
		// return list;
		// }finally{
		//			
		// }
	}

	/**
	 * 
	  * <b>Summary: 任务统计列表</b>
	  *     复写方法 findTasksTJList
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.task.dao.TasksReportDao#findTasksTJList(com.chinacreator.xtbg.core.task.entity.TaskReportBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findTasksTJList(TaskBaseInfoBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<TaskBaseInfoBean> list = new ArrayList<TaskBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select td.user_id receive_userid,td.user_realname receive_username,org.org_id receive_orgid,org.org_name receive_orgname,decode(task.overno,'','0',task.overno) overno,decode(task.overnumber,'','0/0',task.overnumber) overnumber ");
		sql.append("   from td_sm_user td  left join (select t.receive_orgname, ");
		sql.append("   t.receive_orgid, ");
		sql.append("   t.receive_userid, ");
		sql.append("   t.receive_username, ");
		sql.append("   (select count(t.id) ");
		sql.append("    from OA_TASK_BASEINFO t1");
		sql.append("   where t1.receive_userid = t.receive_userid ");
		sql.append("       and t1.task_status = '3'");
		sql.append("       ) as overno,");
		sql.append("       ((select count(t.id)");
		sql.append("       from OA_TASK_BASEINFO t1");
		sql.append("       where t1.receive_userid = t.receive_userid");
		sql.append("        and t1.task_status = '3') || '/' || (");
		sql.append("       select count(t.id)");
		sql.append("        from OA_TASK_BASEINFO t1");
		sql.append("       where t1.receive_userid = t.receive_userid))");
		sql.append("        as overnumber");
		sql.append("       from OA_TASK_BASEINFO t");
		sql.append("       where 1=1");
		sql.append("       group by t.receive_userid,receive_orgid, receive_username, receive_orgname) task on td.user_id = task.receive_userid ");
		sql.append("       left join td_sm_orguser tdo on td.user_id = tdo.user_id");
		sql.append("       left join td_sm_organization org on tdo.org_id = org.org_id");
		sql.append("       where 1=1");
		sql.append("       and td.user_id <> '1'");
		if (!StringUtil.isBlank(bean.getReceive_username())) {
			sql.append("       and td.user_realname like '%"+bean.getReceive_username()+"%'");
		}
		if (!StringUtil.isBlank(bean.getReceive_orgname())) {
			sql.append("       and org.org_name like '%"+bean.getReceive_orgname()+"%'");
		}
		if (!StringUtil.isBlank(bean.getUnit_id())) {
			sql.append("       and OA_USERPROPERTY(org.org_id,'2') = '"+bean.getUnit_id()+"'");
		}
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			TaskBaseInfoBean taskBaseInfoBean = new TaskBaseInfoBean();
			taskBaseInfoBean.setReceive_userid(db.getString(i, "receive_userid"));
			taskBaseInfoBean.setReceive_username(db.getString(i, "receive_username"));
			taskBaseInfoBean.setReceive_orgid(db.getString(i, "receive_orgid"));
			taskBaseInfoBean.setReceive_orgname(db.getString(i, "receive_orgname"));
			taskBaseInfoBean.setOverno(db.getString(i, "overno"));
			taskBaseInfoBean.setOvernumber(db.getString(i, "overnumber"));
			
			list.add(taskBaseInfoBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 
	  * <b>Summary: 根据责任人ID查询任务统计数据</b>
	  *     复写方法 findTasksTJBean
	  * @param user_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.task.dao.TasksReportDao#findTasksTJBean(java.lang.String)
	 */
	public TaskBaseInfoBean findTasksTJBean(String user_id) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		TaskBaseInfoBean taskBaseInfoBean = new TaskBaseInfoBean();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select td.user_id receive_userid,td.user_realname receive_username,org.org_id receive_orgid,org.org_name receive_orgname,decode(task.overno,'','0',task.overno) overno,decode(task.overnumber,'','0/0',task.overnumber) overnumber ");
		sql.append("   from td_sm_user td  left join (select t.receive_orgname, ");
		sql.append("   t.receive_orgid, ");
		sql.append("   t.receive_userid, ");
		sql.append("   t.receive_username, ");
		sql.append("   (select count(t.id) ");
		sql.append("    from OA_TASK_BASEINFO t1");
		sql.append("   where t1.receive_userid = t.receive_userid ");
		sql.append("       and t1.task_status = '3'");
		sql.append("       ) as overno,");
		sql.append("       ((select count(t.id)");
		sql.append("       from OA_TASK_BASEINFO t1");
		sql.append("       where t1.receive_userid = t.receive_userid");
		sql.append("        and t1.task_status = '3') || '/' || (");
		sql.append("       select count(t.id)");
		sql.append("        from OA_TASK_BASEINFO t1");
		sql.append("       where t1.receive_userid = t.receive_userid))");
		sql.append("        as overnumber");
		sql.append("       from OA_TASK_BASEINFO t");
		sql.append("       where 1=1");
		sql.append("       group by t.receive_userid,receive_orgid, receive_username, receive_orgname) task on td.user_id = task.receive_userid ");
		sql.append("       left join td_sm_orguser tdo on td.user_id = tdo.user_id");
		sql.append("       left join td_sm_organization org on tdo.org_id = org.org_id");
		sql.append("       where 1=1");
		sql.append("       and td.user_id='"+user_id+"'");
		sql.append("       and td.user_id <> '1'");
		
	
//	    sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString());
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			
			taskBaseInfoBean.setReceive_userid(db.getString(i, "receive_userid"));
			taskBaseInfoBean.setReceive_username(db.getString(i, "receive_username"));
			taskBaseInfoBean.setReceive_orgid(db.getString(i, "receive_orgid"));
			taskBaseInfoBean.setReceive_orgname(db.getString(i, "receive_orgname"));
			taskBaseInfoBean.setOverno(db.getString(i, "overno"));
			taskBaseInfoBean.setOvernumber(db.getString(i, "overnumber"));
	    }
		return taskBaseInfoBean;
	}

}

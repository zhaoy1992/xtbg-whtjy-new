package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.directory.entity.WorkIPBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowShowListBean;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.AttendanceLeaveBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoCountSearchBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class ElectInfoDaoImpl  extends XtDbBaseDao implements ElectInfoDao {
	/**
	 *<p>Title:ElectResetDaoImpl.java</p>
	 *<p>Description:电子考勤实例类</p> 
	 *<p>Company:湖南科创</p>
	 *@author 付程
	 *@version 1.0
	 *2012-2-24
	 */

	private static final Logger LOG = Logger.getLogger(ElectInfoDaoImpl.class);
	
	/**
	 * @Description  查询列表
	 * 
	 * @param TemplateBean  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几天开始
	 * @param maxPagesize	//当前页数
	 * @return  List
	 * @exception 
	 */
//查询电子考勤当前用户基本信息
	@Override
	public PagingBean findInfoList(ElectInfoBean contentBean, String sortName, String sortOrder, long offset, int maxPagesize) {

		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ElectInfoBean> list = new ArrayList<ElectInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" distinct(t.elect_id),t.start_time,to_char(t.datetime,'yyyy-mm-dd') datetime,t.username,t.start_ip ,t.end_time,t.end_ip,t.state");
		sql.append(" from sx_ta_oa_electcheck_info t ");
		
		sql.append("where t.userid =? ");
		if(contentBean != null) {
			
			if (!StringUtil.nullOrBlank(contentBean.getUserid())) {
				sql.append(" and t.userid like '%"+contentBean.getUserid()+"%'");
			}
			if (!StringUtil.nullOrBlank(contentBean.getState())) {
				sql.append(" and t.state like '%"+contentBean.getState()+"%'");
			}
			if (!StringUtil.nullOrBlank(contentBean.getDatetime())) {
				sql.append(" and t.datetime=to_date('"+contentBean.getDatetime()+"','yyyy-mm-dd ')");

			}
		}          
		sql.append(" order by " + sortName + " " + sortOrder);

		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, contentBean.getUserid());
			db.executePrepared();
			for(int i = 0;i < db.size();i++){

				ElectInfoBean ub = new ElectInfoBean();
				ub.setStart_time(db.getString(i, "start_time"));
				ub.setElect_id(db.getString(i, "elect_id"));
				ub.setDatetime(db.getString(i, "datetime"));
				ub.setStart_ip(db.getString(i,"start_ip"));
				ub.setEnd_ip(db.getString(i,"end_ip"));
				ub.setEnd_time(db.getString(i, "end_time"));
				ub.setUsername(db.getString(i,"username"));
				ub.setState(db.getString(i,"state"));
				list.add(ub);

			}	
		} catch (SQLException e) {
			LOG.error("执行列表查询报错："+e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	
	/**
	 * @Description 添加电子考勤基本信息
	 
	 * @return boolean
	 * @throws SQLException 
	 */
	@Override
	public void addInfos(ElectInfoBean electInfoBean) throws Exception {
		
		StringBuffer buf = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();

		db.executeSelect("select SEQ_SX_ELECTCHECK.nextval from dual");
		String annid = db.getString(0, 0);

		buf.append(" insert into SX_TA_OA_ELECTCHECK_INFO");
		buf.append(" (elect_id, start_time, end_time, rest_time,");
		buf.append(" auto_check, username, userid, orgid,");
		buf.append(" orgname, depart_id,start_ip,end_ip,datetime,state,");
		buf.append(" depart_name,details)");
	
		buf.append(" values('"+annid+"', ");
		buf.append(" ?, ?,?, ?, ?, ?, ?, ?, ?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?)");

		db.preparedInsert(buf.toString());

		//db.setString(1,contentBean.getYxsj());
		db.setString(1,electInfoBean.getStart_time());
		db.setString(2,electInfoBean.getEnd_time());
		db.setString(3,electInfoBean.getReset_time());
		db.setString(4,electInfoBean.getIsauto());
		db.setString(5,electInfoBean.getUsername());
		db.setString(6,electInfoBean.getUserid());
		db.setString(7,electInfoBean.getOrgid());
		db.setString(8,electInfoBean.getOrgname());
		db.setString(9,electInfoBean.getDept_id());
		db.setString(10,electInfoBean.getStart_ip());
		db.setString(11,electInfoBean.getEnd_ip());
		db.setString(12, electInfoBean.getDatetime());
		db.setString(13, electInfoBean.getState());
		db.setString(14,electInfoBean.getDept_name());
		db.setString(15,StringUtil.deNull(electInfoBean.getDetails()));

		db.executePrepared();

	}
	//查询当前日期的考勤数据
	@Override
	public ElectInfoBean isAddOrUpdate(ElectInfoBean electInfoBean) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.elect_id,t.start_time,t.end_time,t.datetime,t.state  ");
		sql.append(" from SX_TA_OA_ELECTCHECK_INFO t ");
		sql.append("	where t.DATETIME =to_date('"+electInfoBean.getDatetime()+"','yyyy-mm-dd ')");
		sql.append(" and t.userid='"+electInfoBean.getUserid()+"'");
		
		ElectInfoBean ub = new ElectInfoBean();
		db.preparedSelect(sql.toString()); 
	

		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ub.setElect_id(db.getString(i, "elect_id"));
			ub.setStart_time(db.getString(i, "start_time"));
			ub.setEnd_time(db.getString(i,"end_time"));
			ub.setDatetime(db.getString(i,"datetime"));
			ub.setState(db.getString(i,"state"));
		}
		return ub;
	}	

	@Override
	public boolean isAddOrUpdate1(ElectResetBean electResetInfoBean,String isuse,String reset_id,String start_time,String end_time,String isauto) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		PreparedDBUtil pdb2 = new PreparedDBUtil();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		boolean isset = false;

		try{
		
		}catch(Exception e){
			return false;
		}
	
		sql1.append("select t.elect_id ");
		sql1.append(" from sx_ta_oa_electcheck t");
		
		sql1.append("	where t.rest_time =2");

		
		
		sql3.append("update  sx_ta_oa_electcheck set isuse='"+isuse+"',rest_time='"+reset_id+"',start_time='"+start_time+"',end_time='"+end_time+"',AUTO_CHECK='"+isauto+"' ");
		
		sql3.append("	where rest_time =2");
		
	sql2.append("update  sx_ta_oa_electcheck set isuse=1");
		
		
		sql2.append("	where rest_time =1");
		
		
			pdb.preparedSelect(sql1.toString());
			
			pdb.executePrepared();
		 if(pdb.size() > 0){
			pdb1.preparedUpdate(sql3.toString());	
			if("0".equals(isuse)){
               pdb2.preparedUpdate (sql2.toString());	
				
				pdb2.executePrepared();	 
			}
			pdb1.executePrepared();	
			
		}
			else{
//			addInfos(electResetInfoBean);
		}

		return isset;
	}

	

//查询考勤设置中所选的作息时间基本信息
	@Override
	public ElectResetBean getContentBean() throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" t.isuse,t.start_time,t.end_time,t.REST_TIME");
		buf.append("  from SX_TA_OA_ELECTCHECK t ");
		buf.append("where t.isuse=0 ");
		PreparedDBUtil db = new PreparedDBUtil();
		ElectResetBean ub = new ElectResetBean();
		db.preparedSelect(buf.toString()); 
	

		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ub.setIsuse(db.getString(i, "isuse"));
			ub.setStart_time(db.getString(i, "start_time"));
			ub.setEnd_time(db.getString(i, "end_time"));
			ub.setReset_time(db.getString(i,"rest_time"));
		}
		return ub;
	}
	//更新上班状态
	@Override
	public void updateEndTime(ElectInfoBean electResetInfoBean)
			throws Exception {
    PreparedDBUtil pdb = new PreparedDBUtil();
	StringBuffer sql = new StringBuffer();
	if(StringUtil.nullOrBlank(electResetInfoBean.getEnd_time())){
		sql.append("update  SX_TA_OA_ELECTCHECK_INFO set state='"+electResetInfoBean.getState()+"'");
	}
	else{
	sql.append("update  SX_TA_OA_ELECTCHECK_INFO set END_TIME='"+electResetInfoBean.getEnd_time()+"',end_ip='"+electResetInfoBean.getEnd_ip()+"',state='"+electResetInfoBean.getState()+"'");
	
	}
	sql.append("  where userid='"+electResetInfoBean.getUserid()+"' and datetime= to_date(?,'yyyy-mm-dd') ");
	
	pdb.preparedUpdate (sql.toString());	
	pdb.setString(1, DateUtil.getCurrentDate());
	pdb.executePrepared();	 
	}
	
	
	//更新早上上班状态
	@Override
	public void updateHalfTime(ElectInfoBean electResetInfoBean)
			throws Exception {
	    PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update  SX_TA_OA_ELECTCHECK_INFO  set start_time = ?,start_ip=?,rest_time=?,state=? ");
		sql.append("  where userid=? and datetime= to_date(?,'yyyy-mm-dd') ");
		pdb.preparedUpdate (sql.toString());
		pdb.setString(1, electResetInfoBean.getStart_time());
		pdb.setString(2, electResetInfoBean.getStart_ip());
		pdb.setString(3, electResetInfoBean.getReset_time());
		pdb.setString(4, electResetInfoBean.getState());
		pdb.setString(5, electResetInfoBean.getUserid());
		pdb.setString(6, DateUtil.getCurrentDate());
		pdb.executePrepared();
	}
	
	
	@Override
	public void updateStartTime(ElectInfoBean electResetInfoBean)
			throws Exception {
    PreparedDBUtil pdb = new PreparedDBUtil();
	StringBuffer sql = new StringBuffer();
	sql.append("update  SX_TA_OA_ELECTCHECK_INFO set START_TIME='"+electResetInfoBean.getStart_time()+"',start_ip='"+electResetInfoBean.getStart_ip()+"'");
	
	
	pdb.preparedUpdate (sql.toString());	
	
	pdb.executePrepared();	 
	}


	@Override
	public boolean findButtonState(String datetime,String userid) throws Exception {
       PreparedDBUtil pdb = new PreparedDBUtil();
	
		StringBuffer sql1 = new StringBuffer();
		
		boolean isset = false;

	
		sql1.append("select t.button_id ");
		sql1.append(" from sx_ta_oa_elecrcheck_button t");
		
		sql1.append("	where   t.userid='"+userid+"'  and t.currenttime = to_date(?,'yyyy-mm-dd')" );
		
			pdb.preparedSelect(sql1.toString());
			pdb.setString(1, DateUtil.getCurrentDate());
			
			pdb.executePrepared();
		 if(pdb.size() > 0){
			 isset=true;
			
		}
			else{
				isset=false;
//			addInfos(electResetInfoBean);
		}

		return isset;
	}

	//给电子考勤控制按钮表添加数据
	@Override
	public void addButtonState(String datetime, String userid) throws Exception {
		StringBuffer buf = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();

		db.executeSelect("select SEQ_SX_ELECTCHECK.nextval from dual");
		String annid = db.getString(0, 0);

		buf.append(" insert into sx_ta_oa_elecrcheck_button");
		buf.append(" (button_id, userid, work_sys, end_sys,currenttime)");
		
	
		buf.append(" values('"+annid+"', ");
		buf.append(" ?, ?,?,to_date(?,'yyyy-mm-dd'))");

		db.preparedInsert(buf.toString());

		//db.setString(1,contentBean.getYxsj());
		db.setString(1,userid);
		db.setString(2,"0");
		db.setString(3,"1");
		db.setString(4,datetime);

		db.executePrepared();

	}

//查询按钮控制表中当前用户在当天是否有数据
	@Override
	public ElectInfoBean getButtonStateInfo(String datetime, String userid)
			throws Exception {
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" t.button_id,t.userid,t.work_sys,t.end_sys,to_char(t.currenttime,'yyyy-mm-dd') currenttime");
		buf.append("  from sx_ta_oa_elecrcheck_button t ");
		buf.append("where   t.userid='"+userid+"'");
		PreparedDBUtil db = new PreparedDBUtil();
		ElectInfoBean ub = new ElectInfoBean();
		db.preparedSelect(buf.toString()); 
	

		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ub.setButton_id(db.getString(i, "button_id"));
			ub.setUserid(db.getString(i, "userid"));
			ub.setEnd_sys(db.getString(i, "end_sys"));
			ub.setWork_sys(db.getString(i,"work_sys"));
			ub.setDatetime(db.getString(i,"currenttime"));
		}
		return ub;
	}


	@Override
	public void updateButtonState(String userid,String work_sys,String end_sys) throws Exception {
		 PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append("update  sx_ta_oa_elecrcheck_button set work_sys='"+work_sys+"',end_sys='"+end_sys+"' where userid='"+userid+"'");
			
			
			pdb.preparedUpdate (sql.toString());	
			
			pdb.executePrepared();	 
			}
	
	//修改考勤基本信息
	public void updateElectInfoBean(ElectInfoBean electInfoBean) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update sx_ta_oa_electcheck_info set state='"+electInfoBean.getState()+"'");
		if(!StringUtil.isBlank(electInfoBean.getStart_time())){
			sql.append(" , start_time ='"+electInfoBean.getStart_time()+"'");
		}
		if(!StringUtil.isBlank(electInfoBean.getStart_ip())){
			sql.append(" , start_ip ='"+electInfoBean.getStart_ip()+"'");
		}
		if(!StringUtil.isBlank(electInfoBean.getEnd_time())){
			sql.append(" , end_time ='"+electInfoBean.getEnd_time()+"'");
		}
		if(!StringUtil.isBlank(electInfoBean.getReset_time())){
			sql.append(" , rest_time ='"+electInfoBean.getReset_time()+"'");
		}
		if(!StringUtil.isBlank(electInfoBean.getEnd_ip())){
			sql.append(" , end_ip ='"+electInfoBean.getEnd_ip()+"'");
		}
		//出勤详细情况
		if(!StringUtil.isBlank(electInfoBean.getDetails())){
			sql.append(" , details ='"+electInfoBean.getDetails()+"'");
		}
		
		sql.append("  where userid='" + electInfoBean.getUserid()+ "' and datetime= to_date(?,'yyyy-mm-dd') ");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, electInfoBean.getDatetime());
		pdb.executePrepared();
	}


	/**
	 * 
	  * <b>Summary: 新增办公IP</b>
	  *     复写方法 insertWorkIPBean
	  * @param workIPBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#insertWorkIPBean(com.chinacreator.xtbg.core.directory.entity.WorkIPBean)
	 */
	public void insertWorkIPBean(WorkIPBean workIPBean) throws Exception {
		 PreparedDBUtil pdb = new PreparedDBUtil();
		 StringBuffer sql = new StringBuffer();
		 sql.append("insert into ta_oa_workip(workip_id,workip_start_ip,workip_end_ip,workip_remark) values (?,?,?,?)");
		 
		 pdb.preparedInsert(sql.toString());
		 int i = 1;
		 pdb.setString(i++, workIPBean.getWorkip_id());
		 pdb.setString(i++, workIPBean.getWorkip_start_ip());
		 pdb.setString(i++, workIPBean.getWorkip_end_ip());
		 pdb.setString(i++, workIPBean.getWorkip_remark());
		 
		 pdb.executePrepared();
	}


	/**
	 * 
	  * <b>Summary: 更新办公IP</b>
	  *     复写方法 updateWorkIPBean
	  * @param workIPBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#updateWorkIPBean(com.chinacreator.xtbg.core.directory.entity.WorkIPBean)
	 */
	public void updateWorkIPBean(WorkIPBean workIPBean) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
	    StringBuffer sql = new StringBuffer();
	    sql.append("update ta_oa_workip set workip_start_ip = ?, workip_end_ip = ?,workip_remark=? where workip_id = ? ");
		
	    pdb.preparedUpdate(sql.toString());
	    
	    int i = 1;
		pdb.setString(i++, workIPBean.getWorkip_start_ip());
		pdb.setString(i++, workIPBean.getWorkip_end_ip());
		pdb.setString(i++, workIPBean.getWorkip_remark());
		pdb.setString(i++, workIPBean.getWorkip_id());
	    
		pdb.executePrepared();
	}
	
	/**
	 *  更新
	 */


	/**
	 * 
	  * <b>Summary: 删除办公IP</b>
	  *     复写方法 deleteWorkIPBean
	  * @param ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#deleteWorkIPBean(java.lang.String)
	 */
	public boolean deleteWorkIPBean(String ids) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
	    StringBuffer sql = new StringBuffer();
	    ids = StringUtil.splitString(ids, ",", "'");
	    sql.append("delete ta_oa_workip where workip_id in ("+ids+") ");
	    
	    pdb.preparedDelete(sql.toString());
	    
	    pdb.executePrepared();
	    
	    return true;
	}


	/**
	 * 
	  * <b>Summary: 查询办公IP列表</b>
	  *     复写方法 findWorkIPInfoList
	  * @param contentBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#findWorkIPInfoList(com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findWorkIPInfoList(ElectInfoBean contentBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkIPBean> list = new ArrayList<WorkIPBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" distinct(t.workip_id),t.workip_start_ip,t.workip_end_ip,workip_remark ");
		sql.append(" from ta_oa_workip t ");
		sql.append(" order by " + sortName + " " + sortOrder);

		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0;i < db.size();i++){
				WorkIPBean ub = new WorkIPBean();
				ub.setWorkip_start_ip(db.getString(i, "workip_start_ip"));
				ub.setWorkip_end_ip(db.getString(i, "workip_end_ip"));
				ub.setWorkip_id(db.getString(i, "workip_id"));
				ub.setWorkip_remark(db.getString(i, "workip_remark"));
				list.add(ub);
			}	
		} catch (SQLException e) {
			LOG.error("执行列表查询报错："+e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());
		return pb;
	}


	/**
	 * 
	  * <b>Summary: 根据ID查询办公IP信息</b>
	  *     复写方法 findWorkIPInfo
	  * @param workip_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#findWorkIPInfo(java.lang.String)
	 */
	public WorkIPBean findWorkIPInfo(String workip_id) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		WorkIPBean ub = new WorkIPBean();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" distinct(t.workip_id),t.workip_start_ip,t.workip_end_ip,t.workip_remark ");
		sql.append(" from ta_oa_workip t ");
		sql.append(" where t.workip_id = ? ");

		try {
			db.preparedSelect(sql.toString());
			db.setString(1, workip_id);
			db.executePrepared();
			for(int i = 0;i < db.size();i++){
				ub.setWorkip_start_ip(db.getString(i, "workip_start_ip"));
				ub.setWorkip_end_ip(db.getString(i, "workip_end_ip"));
				ub.setWorkip_id(db.getString(i, "workip_id"));
				ub.setWorkip_remark(db.getString(i, "workip_remark"));
			}	
		} catch (SQLException e) {
			LOG.error("执行列表查询报错："+e.getMessage());
		}
		return ub;
	}


	/**
	 * 
	  * <b>Summary: 查询出所有办公IP段</b>
	  *     复写方法 findWorkIPList
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao#findWorkIPList()
	 */
	public List<WorkIPBean> findWorkIPList() throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkIPBean> list = new ArrayList<WorkIPBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" distinct(t.workip_id),t.workip_start_ip,t.workip_end_ip ");
		sql.append(" from ta_oa_workip t ");

		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for(int i = 0;i < db.size();i++){
				WorkIPBean ub = new WorkIPBean();
				ub.setWorkip_start_ip(db.getString(i, "workip_start_ip"));
				ub.setWorkip_end_ip(db.getString(i, "workip_end_ip"));
				ub.setWorkip_id(db.getString(i, "workip_id"));
				list.add(ub);
			}	
		} catch (SQLException e) {
			LOG.error("执行列表查询报错："+e.getMessage());
		}
		return list;
	}
	
	//查询考勤统计
	public PagingBean findInfoCountList(ElectInfoCountSearchBean bean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ElectInfoCountSearchBean> list = new ArrayList<ElectInfoCountSearchBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer wheresql = new StringBuffer();
		// 考勤查询开始时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))) {
			wheresql.append(" and t.datetime  >= to_date('" + bean.getStart_time() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		
		// 考勤查询时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))) {
			wheresql.append(" and t.datetime  <= to_date('" + bean.getEnd_time()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append("select td.user_id userid,");
		sql.append("       td.user_realname username,");
		sql.append("       org.org_id orgid,");
		sql.append("       org.org_name orgname,");
		sql.append("       decode(elect.cdcount, '', '0', elect.cdcount) cdcount,");
		sql.append("       decode(elect.ztcount, '', '0', elect.ztcount) ztcount,");
		sql.append("       decode(elect.kgcount, '', '0', elect.kgcount) kgcount,");
		sql.append("       decode(elect.cdztcount, '', '0', elect.cdztcount) cdztcount,");
		sql.append("       decode(elect.wqcount, '', '0', elect.wqcount) wqcount,");
		sql.append("       decode(elect.qjcount, '', '0', elect.qjcount) qjcount,");//请假
		sql.append("       decode(elect.sjcount, '', '0', elect.sjcount) sjcount,");//事假
		sql.append("       decode(elect.nxjcount, '', '0', elect.nxjcount) nxjcount,");//年休假
		sql.append("       decode(elect.xxpxjcount, '', '0', elect.xxpxjcount) xxpxjcount,");//学习培训假
		sql.append("       decode(elect.gcjcount, '', '0', elect.gcjcount) gcjcount,");//公差假
		sql.append("       decode(elect.bsjcount, '', '0', elect.bsjcount) bsjcount,");//病(伤)假
		sql.append("       decode(elect.cjcount, '', '0', elect.cjcount) cjcount,");//产假
		sql.append("       decode(elect.gsjcount, '', '0', elect.gsjcount) gsjcount,");//工伤假
		sql.append("       decode(elect.hjcount, '', '0', elect.hjcount) hjcount,");//婚假
		sql.append("       decode(elect.jhsyjcount, '', '0', elect.jhsyjcount) jhsyjcount,");//计划生育假
		sql.append("       decode(elect.sajcount, '', '0', elect.sajcount) sajcount,");//丧假
		sql.append("       decode(elect.zccount, '', '0', elect.zccount) zccount");
		sql.append("  from td_sm_user td");
		sql.append("  left join (select t.orgid,");
		sql.append("                    t.USERID,");
		sql.append("                    t.username,");
		sql.append("                    t.orgname,");
		sql.append("                    t.cdcount,");
		sql.append("                    t.ztcount,");
		sql.append("                    t.kgcount,");
		sql.append("                    t.cdztcount,");
		sql.append("                    t.wqcount,");
		sql.append("                    t.qjcount,");
		sql.append("                    t.sjcount,");
		sql.append("                    t.nxjcount,");
		sql.append("                    t.xxpxjcount,");
		sql.append("                    t.gcjcount,");
		sql.append("                    t.bsjcount,");
		sql.append("                    t.cjcount,");
		sql.append("                    t.gsjcount,");
		sql.append("                    t.hjcount,");
		sql.append("                    t.jhsyjcount,");
		sql.append("                    t.sajcount,");
		sql.append("                    t.zccount");
		sql.append("               from (select tt.orgid,");
		sql.append("                            tt.USERID,");
		sql.append("                            tt.username,");
		sql.append("                            tt.orgname,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%迟到%') as cdcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%早退%') as ztcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%旷工%') as kgcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%迟到并早退%') as cdztcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '外勤') as wqcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and (t.state = '事假' or t.state = '年休假' or t.state = '学习培训假' or t.state = '公差假' or t.state = '丧假' ");
		sql.append("                                or t.state = '病(伤)假' or t.state = '产假' or t.state = '工伤假' or t.state = '婚假' or t.state = '计划生育假' )) as qjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '事假') as sjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '年休假') as nxjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '学习培训假') as xxpxjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '公差假') as gcjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '病(伤)假') as bsjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '产假') as cjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '工伤假') as gsjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '婚假') as hjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '计划生育假') as jhsyjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '丧假') as sajcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%正常%') as zccount");
		sql.append("                       from sx_ta_oa_electcheck_info tt where 1=1 ");
		// 考勤开始时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))) {
			sql.append(" and tt.datetime  >= to_date('" + bean.getStart_time() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		
		// 考勤结束时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))) {
			sql.append(" and tt.datetime  <= to_date('" + bean.getEnd_time()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append("                      group by tt.orgid, tt.USERID, tt.username, tt.orgname) t) elect on td.user_id =");
		sql.append("                                                                                         elect.USERID");
		sql.append("  left join td_sm_orguser tdo on td.user_id = tdo.user_id");
		sql.append("  left join td_sm_organization org on tdo.org_id = org.org_id");
		sql.append(" left join sx_ta_oa_electcheck_info ttt on td.user_id = ttt.userid ");
		sql.append(" where 1 = 1");
		sql.append("   and td.user_id <> '1'");
		
		if (!StringUtil.isBlank(bean.getUsername())) {
			sql.append("       and td.user_realname like '%"+bean.getUsername()+"%'");
		}
		if(!StringUtil.isBlank(bean.getState())){
			sql.append(" and ttt.state = '"+bean.getState()+"' ");
		}
		// 所在单位
		if (!StringUtil.nullOrBlank(bean.getOrgid())) {
			String orgids = StringUtil.splitString(bean.getOrgid(), ",", "'");
			sql.append(" and org.org_id  in("+orgids+")");
		}
		//所属单位
		if(!StringUtil.nullOrBlank(bean.getUnit_id())){
			sql.append(" and OA_USERPROPERTY(org.org_id, '2')  = '"+bean.getUnit_id()+"'");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			ElectInfoCountSearchBean searchbean = new ElectInfoCountSearchBean();
			searchbean.setUserid(db.getString(i, "userid"));
			searchbean.setUsername(db.getString(i, "username"));
			searchbean.setOrgid(db.getString(i, "orgid"));
			searchbean.setOrgname(db.getString(i, "orgname"));
			searchbean.setCdcount(db.getString(i, "cdcount"));
			searchbean.setZtcount(db.getString(i, "ztcount"));
			searchbean.setKgcount(db.getString(i, "kgcount"));
			searchbean.setCdztcount(db.getString(i, "cdztcount"));
			searchbean.setWqcount(db.getString(i, "wqcount"));
			searchbean.setQjcount(db.getString(i, "qjcount"));
			searchbean.setZccount(db.getString(i, "zccount"));
			searchbean.setSjcount(db.getString(i, "sjcount"));
			searchbean.setNxjcount(db.getString(i, "nxjcount"));
			searchbean.setXxpxjcount(db.getString(i, "xxpxjcount"));
			searchbean.setGcjcount(db.getString(i, "gcjcount"));
			searchbean.setBsjcount(db.getString(i, "bsjcount"));
			searchbean.setCjcount(db.getString(i, "cjcount"));
			searchbean.setGsjcount(db.getString(i, "gsjcount"));
			searchbean.setHjcount(db.getString(i, "hjcount"));
			searchbean.setJhsyjcount(db.getString(i, "jhsyjcount"));
			searchbean.setSajcount(db.getString(i, "sajcount"));
			list.add(searchbean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	
	//查询考勤统计 导出Excel表
	public List<ElectInfoCountSearchBean> findCountExcelInfoList(ElectInfoCountSearchBean bean) throws Exception{
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ElectInfoCountSearchBean> list = new ArrayList<ElectInfoCountSearchBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer wheresql = new StringBuffer();
		// 考勤查询开始时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))) {
			wheresql.append(" and t.datetime  >= to_date('" + bean.getStart_time() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		
		// 考勤查询时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))) {
			wheresql.append(" and t.datetime  <= to_date('" + bean.getEnd_time()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append("select td.user_id userid,");
		sql.append("       td.user_realname username,");
		sql.append("       org.org_id orgid,");
		sql.append("       org.org_name orgname,");
		sql.append("       decode(elect.cdcount, '', '0', elect.cdcount) cdcount,");
		sql.append("       decode(elect.ztcount, '', '0', elect.ztcount) ztcount,");
		sql.append("       decode(elect.kgcount, '', '0', elect.kgcount) kgcount,");
		sql.append("       decode(elect.cdztcount, '', '0', elect.cdztcount) cdztcount,");
		sql.append("       decode(elect.wqcount, '', '0', elect.wqcount) wqcount,");
		sql.append("       decode(elect.qjcount, '', '0', elect.qjcount) qjcount,");//请假
		sql.append("       decode(elect.sjcount, '', '0', elect.sjcount) sjcount,");//事假
		sql.append("       decode(elect.nxjcount, '', '0', elect.nxjcount) nxjcount,");//年休假
		sql.append("       decode(elect.xxpxjcount, '', '0', elect.xxpxjcount) xxpxjcount,");//学习培训假
		sql.append("       decode(elect.gcjcount, '', '0', elect.gcjcount) gcjcount,");//公差假
		sql.append("       decode(elect.bsjcount, '', '0', elect.bsjcount) bsjcount,");//病(伤)假
		sql.append("       decode(elect.cjcount, '', '0', elect.cjcount) cjcount,");//产假
		sql.append("       decode(elect.gsjcount, '', '0', elect.gsjcount) gsjcount,");//工伤假
		sql.append("       decode(elect.hjcount, '', '0', elect.hjcount) hjcount,");//婚假
		sql.append("       decode(elect.jhsyjcount, '', '0', elect.jhsyjcount) jhsyjcount,");//计划生育假
		sql.append("       decode(elect.sajcount, '', '0', elect.sajcount) sajcount,");//丧假
		sql.append("       decode(elect.zccount, '', '0', elect.zccount) zccount");
		sql.append("  from td_sm_user td");
		sql.append("  left join (select t.orgid,");
		sql.append("                    t.USERID,");
		sql.append("                    t.username,");
		sql.append("                    t.orgname,");
		sql.append("                    t.cdcount,");
		sql.append("                    t.ztcount,");
		sql.append("                    t.kgcount,");
		sql.append("                    t.cdztcount,");
		sql.append("                    t.wqcount,");
		sql.append("                    t.qjcount,");
		sql.append("                    t.sjcount,");
		sql.append("                    t.nxjcount,");
		sql.append("                    t.xxpxjcount,");
		sql.append("                    t.gcjcount,");
		sql.append("                    t.bsjcount,");
		sql.append("                    t.cjcount,");
		sql.append("                    t.gsjcount,");
		sql.append("                    t.hjcount,");
		sql.append("                    t.jhsyjcount,");
		sql.append("                    t.sajcount,");
		sql.append("                    t.zccount");
		sql.append("               from (select tt.orgid,");
		sql.append("                            tt.USERID,");
		sql.append("                            tt.username,");
		sql.append("                            tt.orgname,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%迟到%') as cdcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%早退%') as ztcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%旷工%') as kgcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%迟到并早退%') as cdztcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '外勤') as wqcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and (t.state = '事假' or t.state = '年休假' or t.state = '学习培训假' or t.state = '公差假' or t.state = '丧假' ");
		sql.append("                                or t.state = '病(伤)假' or t.state = '产假' or t.state = '工伤假' or t.state = '婚假' or t.state = '计划生育假' )) as qjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '事假') as sjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '年休假') as nxjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '学习培训假') as xxpxjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '公差假') as gcjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '病(伤)假') as bsjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '产假') as cjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '工伤假') as gsjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '婚假') as hjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '计划生育假') as jhsyjcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state = '丧假') as sajcount,");
		sql.append("                            (select count(t.elect_id)");
		sql.append("                               from sx_ta_oa_electcheck_info t");
		sql.append("                              where t.userid = tt.userid");
		//时间查询过滤
		sql.append(" "+ wheresql.toString() );  
		sql.append("                                and t.state like '%正常%') as zccount");
		sql.append("                       from sx_ta_oa_electcheck_info tt where 1=1 ");
		// 考勤开始时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))) {
			sql.append(" and tt.datetime  >= to_date('" + bean.getStart_time() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		
		// 考勤结束时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))) {
			sql.append(" and tt.datetime  <= to_date('" + bean.getEnd_time()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append("                      group by tt.orgid, tt.USERID, tt.username, tt.orgname) t) elect on td.user_id =");
		sql.append("                                                                                         elect.USERID");
		sql.append("  left join td_sm_orguser tdo on td.user_id = tdo.user_id");
		sql.append("  left join td_sm_organization org on tdo.org_id = org.org_id");
		sql.append(" where 1 = 1");
		sql.append("   and td.user_id <> '1'");
		
		if (!StringUtil.isBlank(bean.getUsername())) {
			sql.append("       and td.user_realname like '%"+bean.getUsername()+"%'");
		}
		// 所在单位
		if (!StringUtil.nullOrBlank(bean.getOrgid())) {
			String orgids = StringUtil.splitString(bean.getOrgid(), ",", "'");
			sql.append(" and org.org_id  in("+orgids+")");
		}
		//所属单位
		if(!StringUtil.nullOrBlank(bean.getUnit_id())){
			sql.append(" and OA_USERPROPERTY(org.org_id, '2')  = '"+bean.getUnit_id()+"'");
		}
		sql.append("  order by org.org_sn, td.user_id asc ");
    	db.preparedSelect(sql.toString());
    	
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			ElectInfoCountSearchBean searchbean = new ElectInfoCountSearchBean();
			searchbean.setUserid(db.getString(i, "userid"));
			searchbean.setUsername(db.getString(i, "username"));
			searchbean.setOrgid(db.getString(i, "orgid"));
			searchbean.setOrgname(db.getString(i, "orgname"));
			searchbean.setCdcount(db.getString(i, "cdcount"));
			searchbean.setZtcount(db.getString(i, "ztcount"));
			searchbean.setKgcount(db.getString(i, "kgcount"));
			searchbean.setCdztcount(db.getString(i, "cdztcount"));
			searchbean.setWqcount(db.getString(i, "wqcount"));
			searchbean.setQjcount(db.getString(i, "qjcount"));
			searchbean.setZccount(db.getString(i, "zccount"));
			
			searchbean.setSjcount(db.getString(i, "sjcount"));
			searchbean.setNxjcount(db.getString(i, "nxjcount"));
			searchbean.setXxpxjcount(db.getString(i, "xxpxjcount"));
			searchbean.setGcjcount(db.getString(i, "gcjcount"));
			searchbean.setBsjcount(db.getString(i, "bsjcount"));
			searchbean.setCjcount(db.getString(i, "cjcount"));
			searchbean.setGsjcount(db.getString(i, "gsjcount"));
			searchbean.setHjcount(db.getString(i, "hjcount"));
			searchbean.setJhsyjcount(db.getString(i, "jhsyjcount"));
			searchbean.setSajcount(db.getString(i, "sajcount"));
			list.add(searchbean);
	    }
	    return list;
	}
	
	/**
	*<b>Summary: </b>
	* findElectInfoBeanById(根据主键ID 查询当天的考勤信息)
	* @param elect_id 
	* @return
	* @throws Exception
	 */
	public ElectInfoBean findElectInfoBeanById(String elect_id) throws Exception{
		
		StringBuffer sql = new StringBuffer();
		sql.append("select elect_id,");
		sql.append("       start_time,");
		sql.append("       start_ip,");
		sql.append("       end_time,");
		sql.append("       rest_time,");
		sql.append("       auto_check,");
		sql.append("       username,");
		sql.append("       userid,");
		sql.append("       orgid,");
		sql.append("       orgname,");
		sql.append("       depart_name,");
		sql.append("       depart_id,");
		sql.append("       end_ip,");
		sql.append("       state,");
		sql.append("       to_char(datetime,'yyyy-mm-dd') as datetime,");
		sql.append("       details");
		sql.append("  from sx_ta_oa_electcheck_info where 1=1 ");
		if(!StringUtil.isBlank(elect_id)){
			sql.append(" and elect_id='"+elect_id+"'");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		ElectInfoBean ub = new ElectInfoBean();
		db.preparedSelect(sql.toString()); 
	
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ub.setElect_id(db.getString(i, "elect_id"));
			ub.setStart_time(db.getString(i, "start_time"));
			ub.setStart_ip(db.getString(i, "start_ip"));
			ub.setEnd_time(db.getString(i, "end_time"));
			ub.setReset_time(db.getString(i, "rest_time"));
			ub.setUsername(db.getString(i, "username"));
			ub.setUserid(db.getString(i, "userid"));
			ub.setOrgid(db.getString(i, "orgid"));
			ub.setOrgname(db.getString(i, "orgname"));
			ub.setDept_name(db.getString(i, "depart_name"));
			ub.setDept_id(db.getString(i, "depart_id"));
			ub.setEnd_ip(db.getString(i, "end_ip"));
			ub.setState(db.getString(i, "state"));
			ub.setDatetime(db.getString(i, "datetime"));
			ub.setDetails(db.getString(i, "details"));
			
		}
		return ub;
	}
	
	/**
	*<b>Summary: </b>
	* queryHolidayTimes(查询节假日日期)
	* @param startTime
	* @param endTime
	* @return
	* @throws Exception
	* @author jia.tong   2013-08-30
	 */
	public List<String> queryHolidayTimes(String startTime,String endTime) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<String> holidayTimes = new ArrayList<String>();
		sql.append("select t.holiday");
		sql.append("               from TD_SP_HOLIDAY t ");
		sql.append("                where to_date(t.holiday,'yyyy-mm-dd') >= to_date('"+startTime+"', 'yyyy-mm-dd')");
		sql.append("                and   to_date(t.holiday,'yyyy-mm-dd') <= to_date('"+endTime+"', 'yyyy-mm-dd')");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
        for (int i = 0; i < pdb.size(); i++) {
			String holiday = pdb.getString(i,"holiday");
			holidayTimes.add(holiday);
		}		
		return holidayTimes;
	}
	
	/**
	 * 查询当前登陆人员有处于【销假申请】环节的请假单，
	 * 且请假单的状态为在办中请假结束日期  早于或等于当前系统日期，
	 * 则【上班打卡】、【下班打卡】按钮都被禁用无法点击
	 */
	public boolean queryflowleave(String username) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from VIEW_OA_WORK_LIST     t,");
		sql.append("       oa_flow_busitype      f_type,");
		sql.append("       oa_flow_busitype_type b_type,");
		sql.append("       ta_oa_attendanceleave leave");
		sql.append(" where 1 = 1");
		sql.append("   and t.busitype_code = f_type.busitype_code");
		sql.append("   and f_type.busitype_type_code = b_type.busitype_type_code");
		//当前登录用户
		sql.append("   and t.username = '"+username+"'");
		//请假的流程业务类型
		sql.append("   and t.busitype_code ='leadleave' ");
		sql.append("   and leave.t_id = t.BUSI_ID");
		sql.append("   and t.ACTION_DEFID='bmzyldqj_wp1_act6'");
		sql.append("   and leave.t_endtime <sysdate");
		sql.append(" order by accept_time desc");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size()>0){
			return true;
		} else {
			return false;
		}
	}


	@Override
	public Map<String,String> ishalfDay(String username) throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from VIEW_OA_WORK_LIST     t,");
		sql.append("       oa_flow_busitype      f_type,");
		sql.append("       oa_flow_busitype_type b_type,");
		sql.append("       ta_oa_attendanceleave leave");
		sql.append(" where 1 = 1");
		sql.append("   and t.busitype_code = f_type.busitype_code");
		sql.append("   and f_type.busitype_type_code = b_type.busitype_type_code");
		//当前登录用户
		sql.append("   and t.username = '"+username+"'");
		//请假的流程业务类型
		sql.append("   and t.busitype_code ='leadleave' ");
		sql.append("   and leave.t_id = t.BUSI_ID");
		sql.append("   and t.ACTION_DEFID='bmzyldqj_wp1_act6'");
		sql.append("   and to_date(to_char(leave.t_endtime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') ");
		sql.append(" order by accept_time desc");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size()>0){
				map.put("date_type", pdb.getString(0,"t_data_type"));
				map.put("title", pdb.getString(0,"t_type"));
				map.put("type", pdb.getString(0,"t_data_value"));
		}
		return map;
	}
	
	public PagingBean ta_oa_attendanceleave (ElectInfoCountSearchBean bean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ElectInfoCountSearchBean> list = new ArrayList<ElectInfoCountSearchBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer wheresql = new StringBuffer();
		// 考勤查询开始时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))) {
			wheresql.append(" and t.t_starttime  >= to_date('" + bean.getStart_time() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		// 考勤查询时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))) {
			wheresql.append(" and t.t_endtime  <= to_date('" + bean.getEnd_time()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		//事假
		String sjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t  left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='事假' or t.t_type='value7') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as sjcount";
		//年休假
		String nxjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and  (t.t_type='年休假' or t.t_type='value1') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as nxjcount";
		//学习培训假
		String xxpxjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and  (t.t_type='学习培训假' or t.t_type='value10') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as xxpxjcount ";
		//公差假
		String gcjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='公差假' or t.t_type='value8') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as gcjcount";
		//病(伤)假
		String bsjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='病(伤)假' or t.t_type='value6') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as bsjcount";
		//产假
		String cjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='产假' or t.t_type='value4') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as cjcount";
		//工伤假
		String gsjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='工伤假' or t.t_type='value3') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as gsjcount";
		//婚假
		String hjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='婚假' or t.t_type='value2') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as hjcount";
		//计划生育假
		String jhsyjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='计划生育假' or t.t_type='value5') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as jhsyjcount";
		//丧假
		String sajSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='丧假' or t.t_type='value9') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as sajcount";
		//陪产假
		String pcjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='陪产假' or t.t_type='value11') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as pcjcount";
		//调休假
		String txjSql = "(select sum(t.t_leavetimes) from ta_oa_attendanceleave t left join oa_flow_instance i on t.t_id = i.busi_id where 1=1 and (t.t_type='调休假' or t.t_type='value12') "+wheresql.toString()+" and t.t_name = t1.user_realname  and i.busi_id is not null) as breakoff";
		
		sql.append("select t1.user_id,t1.user_realname,t2.org_id,t3.org_name,"+sjSql+","+nxjSql+","+xxpxjSql+","+gcjSql+","+bsjSql+","+cjSql+","+gsjSql+","+hjSql+","+jhsyjSql+","+sajSql+","+pcjSql+","+txjSql+" from td_sm_user t1,td_sm_orguser t2,td_sm_organization t3 where t1.user_id=t2.user_id and t2.org_id=t3.org_id  ");
		
		if (!StringUtil.isBlank(bean.getUsername())) {
			sql.append("       and t1.user_realname like '%"+bean.getUsername()+"%'");
		}
		// 所在单位
		if (!StringUtil.nullOrBlank(bean.getOrgid())) {
			String orgids = StringUtil.splitString(bean.getOrgid(), ",", "'");
			sql.append(" and t3.org_id  in("+orgids+")");
		}
		//所属单位
		if(!StringUtil.nullOrBlank(bean.getUnit_id())){
			sql.append(" and OA_USERPROPERTY(t3.org_id, '2')  = '"+bean.getUnit_id()+"'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			ElectInfoCountSearchBean searchbean = new ElectInfoCountSearchBean();
			searchbean.setUserid(db.getString(i, "user_id"));
			searchbean.setUsername(db.getString(i, "user_realname"));
			searchbean.setOrgid(db.getString(i, "org_id"));
			searchbean.setOrgname(db.getString(i, "org_name"));
			searchbean.setCdcount("0");
			searchbean.setZtcount("0");
			searchbean.setKgcount("0");
			searchbean.setCdztcount("0");
			searchbean.setWqcount("0");
			searchbean.setQjcount("0");
			searchbean.setZccount("0");
			if(StringUtil.isBlank(db.getString(i, "sjcount"))){
				searchbean.setSjcount("0");
			}else{
				searchbean.setSjcount(db.getString(i, "sjcount"));
			}
			
			if(StringUtil.isBlank(db.getString(i, "nxjcount"))){
				searchbean.setNxjcount("0");
			}else{
				searchbean.setNxjcount(db.getString(i, "nxjcount"));
			}
			
			if(StringUtil.isBlank(db.getString(i, "xxpxjcount"))){
				searchbean.setXxpxjcount("0");
			}else{
				searchbean.setXxpxjcount(db.getString(i, "xxpxjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "gcjcount"))){
				searchbean.setGcjcount("0");
			}else{
				searchbean.setGcjcount(db.getString(i, "gcjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "bsjcount"))){
				searchbean.setBsjcount("0");
			}else{
				searchbean.setBsjcount(db.getString(i, "bsjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "cjcount"))){
				searchbean.setCjcount("0");
			}else{
				searchbean.setCjcount(db.getString(i, "cjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "gsjcount"))){
				searchbean.setGsjcount("0");
			}else{
				searchbean.setGsjcount(db.getString(i, "gsjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "hjcount"))){
				searchbean.setHjcount("0");
			}else{
				searchbean.setHjcount(db.getString(i, "hjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "jhsyjcount"))){
				searchbean.setJhsyjcount("0");
			}else{
				searchbean.setJhsyjcount(db.getString(i, "jhsyjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "sajcount"))){
				searchbean.setSajcount("0");
			}else{
				searchbean.setSajcount(db.getString(i, "sajcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "pcjcount"))){
				searchbean.setPcjcount("0");
			}else{
				searchbean.setPcjcount(db.getString(i,"pcjcount"));
			}
			if(StringUtil.isBlank(db.getString(i, "breakoff"))){
				searchbean.setBreakoff("0");
			}else{
				searchbean.setBreakoff(db.getString(i,"breakoff"));
			}
//			String sjcount = DaoUtil.SqlToField(sjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setSjcount(sjcount);
//			String nxjcount =DaoUtil.SqlToField(nxjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setNxjcount(nxjcount);
//			String xxpxjcount =DaoUtil.SqlToField(xxpxjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setXxpxjcount(xxpxjcount);
//			String gcjcount =DaoUtil.SqlToField(gcjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setGcjcount(gcjcount);
//			String bsjcount =DaoUtil.SqlToField(bsjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setBsjcount(bsjcount);
//			String cjcount =DaoUtil.SqlToField(cjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setCjcount(cjcount);
//			String gsjcount =DaoUtil.SqlToField(gsjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setGsjcount(gsjcount);
//			String hjcount =DaoUtil.SqlToField(hjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setHjcount(hjcount);
//			String jhsyjcount =DaoUtil.SqlToField(jhsyjSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setJhsyjcount(jhsyjcount);
//			String sajcount =DaoUtil.SqlToField(sajSql+" and t.t_user_id ='"+db.getString(i, "user_id")+"' ");
//			searchbean.setSajcount(sajcount);
			list.add(searchbean);
	    }
		 pb.setList(list);
		    pb.setRecords((long)db.getTotalSize());
			return pb;
	}


	@Override
	public PagingBean getDetails(AttendanceLeaveBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<AttendanceLeaveBean> list = new ArrayList<AttendanceLeaveBean>();
		sql.append("select t.t_id,");
		sql.append("       t.t_depart_name,");
		sql.append("       t.t_user_id,");
		sql.append("       t.t_name,");
		sql.append("	   decode(t.t_type,'value1','年休假','value2','婚假','value3','工伤假','value4','产假','value5','计划生育假','value6','病（伤）假','value7','事假','value8','公差假','value9','丧假','value10','学习培训假','value11','陪产假',t.t_type) as t_type,");
		sql.append("       t.t_title,");
		sql.append("       t.t_starttime,");
		sql.append("       t.t_endtime,");
		sql.append("       t.t_leavetimes,");
		sql.append("       t.t_sq_time");
		sql.append("  from ta_oa_attendanceleave t");
		sql.append("  left join td_sm_user a on t.t_name = a.user_realname");
		sql.append("  left join oa_flow_instance i on t.t_id = i.busi_id");
		sql.append(" where 1 = 1");
		sql.append("   and i.busi_id is not null");
		sql.append("   and (t.t_type = '"+bean.getT_type()+"' or t.t_type = '"+bean.getT_type_value()+"')");
		sql.append("   and a.user_id = '"+bean.getT_user_id()+"'");
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getT_starttime()))) {
			sql.append(" and t.t_starttime  >= to_date('" + bean.getT_starttime() + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		// 考勤查询时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getT_endtime()))) {
			sql.append(" and t.t_endtime  <= to_date('" + bean.getT_endtime()+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			AttendanceLeaveBean bean1 = new AttendanceLeaveBean();
			bean1.setT_id(db.getString(i, "t_id"));
			bean1.setT_depart_name(db.getString(i, "t_depart_name"));
			bean1.setT_user_id(db.getString(i, "t_user_id"));
			bean1.setT_name(db.getString(i, "t_name"));
			bean1.setT_type(db.getString(i, "t_type"));
			bean1.setT_title(db.getString(i, "t_title"));
			bean1.setT_starttime(db.getString(i, "t_starttime"));
			bean1.setT_endtime(db.getString(i, "t_endtime"));
			bean1.setT_leavetimes(db.getString(i, "t_leavetimes"));
			bean1.setT_sq_time(db.getString(i, "t_sq_time"));
			list.add(bean1);
	    }
		 pb.setList(list);
		    pb.setRecords((long)db.getTotalSize());
			return pb;
	}


	@Override
	public PagingBean getManageList(WorkFlowSearchBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from (select i.ins_id,");
		sql.append("               I.BUSITYPE_CODE,");
		sql.append("               t.busitype_name,");
		sql.append("               i.busi_id,");
		sql.append("               w.action_name as act_name,");
		sql.append("               I.INS_NAME,");
		sql.append("               i.ins_code,");
		sql.append("               i.accepter,");
		sql.append("               i.accept_time,");
		sql.append("               I.ACCEPTER_ID,");
		sql.append("               I.FLOW_ID,");
		sql.append("               i.def_id,");
		sql.append("               I.CC_FORM_INSTANCEID,");
		sql.append("               i.lastmodifedtime,");
		sql.append("               i.template_id,");
		sql.append("               u.activity,");
		sql.append("               u.user_name,");
		sql.append("               u.user_realname,");
		sql.append("               b.from_path action_form,");
		sql.append("               w.actiontype_code,");
		sql.append("               u.activity as actInsId,");
		sql.append("               u.activityprocessid as procId,");
		sql.append("               u.act_defid as action_defid");
		sql.append("          from (select t.ins_id,");
		sql.append("                       t.activity,");
		sql.append("                       t.act_defid,");
		sql.append("                       t.activityprocessid,");
		sql.append("                       zh_concat(distinct t.user_name) as user_name,");
		sql.append("                       zh_concat(distinct u.user_realname) as user_realname");
		sql.append("                  from oa_flow_actionuser t");
		sql.append("                  left join td_sm_user u on u.user_name = t.user_name");
		sql.append("                 group by t.ins_id,");
		sql.append("                          t.activity,");
		sql.append("                          t.act_defid,");
		sql.append("                          t.activityprocessid) u,");
		sql.append("               oa_flow_instance i,");
		sql.append("               OA_FLOW_WFACTION w,");
		sql.append("               oa_flow_baseinfo b,");
		sql.append("               oa_flow_busitype t");
		sql.append("         where u.ins_id = i.ins_id");
		sql.append("           and w.def_id = i.def_id");
		sql.append("           and w.action_defid = u.act_defid");
		sql.append("           and b.busitype_code = i.busitype_code");
		sql.append("           and i.busitype_code = t.busitype_code");
		sql.append("		   and t.busitype_type_code = 'kqgl'");
		sql.append("           and b.is_valid = 'Y'");
		sql.append("        union");
		//查询出来终止流程的数据
		sql.append("        select i.ins_id,");
		sql.append("               I.BUSITYPE_CODE,");
		sql.append("               t.busitype_name,");
		sql.append("               i.busi_id,");
		sql.append("               '' as act_name,");
		sql.append("               I.INS_NAME,");
		sql.append("               i.ins_code,");
		sql.append("               i.accepter,");
		sql.append("               i.accept_time,");
		sql.append("               I.ACCEPTER_ID,");
		sql.append("               I.FLOW_ID,");
		sql.append("               i.def_id,");
		sql.append("               I.CC_FORM_INSTANCEID,");
		sql.append("               i.lastmodifedtime,");
		sql.append("               i.template_id,");
		sql.append("               '' as activity,");
		sql.append("               '' as user_name,");
		sql.append("               '' as user_realname,");
		sql.append("               b.from_path action_form,");
		sql.append("               '04' as actiontype_code,");
		sql.append("               '' as actInsId,");
		sql.append("               '' as procId,");
		sql.append("               '' as action_defid");
		sql.append("          from oa_flow_instance i, oa_flow_baseinfo b, oa_flow_busitype t");
		sql.append("         where b.busitype_code = i.busitype_code");
		sql.append("           and i.busitype_code = t.busitype_code");
		sql.append("		   and t.busitype_type_code = 'kqgl'");
		sql.append("           and b.is_valid = 'Y'");
		sql.append("           and i.ins_id not in (select ins_id from oa_flow_actionuser)) m  where 1=1 ");
		
		if(!StringUtil.nullOrBlank(bean.getIns_code())){
			sql.append(" and m.ins_code like '%").append(bean.getIns_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(bean.getBusitype_name())){
			if(bean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and m.busitype_code in (").append(bean.getBusitype_name()).append(")");
			}
			
		}else{
			if(!StringUtil.nullOrBlank(bean.getPageType())&&"2".equals(bean.getPageType())){
				if(!StringUtil.nullOrBlank(bean.getBusitype_code())){
					if(bean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and m.busitype_code not in (").append(bean.getBusitype_code()).append(")");
					}else{
						sql.append(" and m.busitype_code = '"+bean.getBusitype_code()+"'");
					}
				}
			}else{
				if(!StringUtil.nullOrBlank(bean.getBusitype_code())){
					if(bean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and m.busitype_code in (").append(bean.getBusitype_code()).append(")");
					}else{
						sql.append(" and m.busitype_code like '%").append(bean.getBusitype_code()).append("%'");
					}
				}
			}
			
		}
		if(!StringUtil.nullOrBlank(bean.getIns_name())){
			sql.append(" and m.ins_name like '%").append(bean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(bean.getAccepter())){
			//特检院OA 2014-06-06 start 【后台管理】的发起人搜索条件，输入名称却搜索不到结果。
			//sql.append(" and t.accepter like '%").append(bean.getAccepter()).append("%'");
			sql.append(" and m.accepter like '%").append(bean.getAccepter()).append("%'");
			//特检院OA 2014-06-06 end 【后台管理】的发起人搜索条件，输入名称却搜索不到结果。
		}
		if(!StringUtil.nullOrBlank(bean.getStartSlTime())){
			sql.append(" and m.accept_time > to_date('").append(bean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(bean.getEndSlTime())){
			sql.append(" and m.accept_time < to_date('").append(bean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setCc_form_instanceid(db.getString(i, "cc_form_instanceid"));
	    	workFlowShowListBean.setIns_code(db.getString(i, "ins_code"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	if("".equals(db.getString(i, "act_name"))){
	    		workFlowShowListBean.setAct_name("一般办结");
	    	}else{
	    		workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	}
	    	
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setAction_defid(db.getString(i, "action_defid"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setUser_name(db.getString(i, "user_name"));
	    	workFlowShowListBean.setUser_realname(db.getString(i, "user_realname"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setActiontype_code(db.getString(i, "actiontype_code"));
	    	workFlowShowListBean.setProcId(db.getString(i, "procId"));
	    	workFlowShowListBean.setActInsId(db.getString(i, "actInsId"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}


	@Override
	public boolean del(String insId,Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete ta_oa_attendanceleave a where a.t_id = (select b.busi_id from oa_flow_instance b where b.ins_id = ?)");    
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, insId);
		pdb.executePrepared(conn);
		return true;
	}
}




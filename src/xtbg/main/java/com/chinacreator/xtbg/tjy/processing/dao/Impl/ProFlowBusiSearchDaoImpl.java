
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ProFlowBusiSearchDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.processing.dao.Impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.agency.dao.AgencyDao;
import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowShowListBean;
import com.chinacreator.xtbg.tjy.device.dao.DevAccountInfoDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevAccountInfoDaoImpl;
import com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl;
import com.chinacreator.xtbg.tjy.processing.dao.ProFlowBusiSearchDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ProFlowBusiSearchDaoImpl.java</p>
 *<p>Description:事务处理Dao层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class ProFlowBusiSearchDaoImpl extends XtDbBaseDao implements ProFlowBusiSearchDao{
	private static final Log LOG=LogFactory.getLog(ProFlowBusiSearchDaoImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findDoWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findDoWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findDoWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws Exception{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		ins_id,");
		sql.append(" 		busi_id,");
		sql.append(" 		actInsId,");
		sql.append(" 		cc_form_instanceid,");
		sql.append(" 		ins_code,");
		sql.append(" 		t.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		b_type.busitype_type_name,");
		sql.append(" 		ins_name,");
		sql.append(" 		accepter,");
		sql.append(" 		accept_time,");
		sql.append(" 		act_name,");
		sql.append(" 		def_id,");
		sql.append(" 		procId,");
		sql.append(" 		action_defid,");
		sql.append(" 		actiontype_code,");
		sql.append(" 		lastmodifedtime,");
		sql.append(" 		flow_form,");
		sql.append(" 		template_id,");
		sql.append(" 		'0' as is_agency,");
		sql.append(" 		'' as entrust_user_name");
		sql.append(" from VIEW_OA_WORK_LIST t,oa_flow_busitype f_type,oa_flow_busitype_type b_type ");
		sql.append("  where 1 = 1 and t.busitype_code = f_type.busitype_code ");
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code ");
		//sql.append(" and t.BUSITYPE_CODE in (select TT.BUSITYPE_CODE from OA_FLOW_BUSITYPE tt");
		//sql.append(" where tt.BUSITYPE_TYPE_CODE in (select TTT.BUSITYPE_TYPE_CODE from OA_FLOW_BUSITYPE_TYPE TTT WHERE TTT.IS_VALID = '1'))");
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUsername())){
			sql.append(" and t.username = '").append(workFlowSearchBean.getUsername()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
			sql.append(" and t.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_name())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_name()).append(")");
			}
			
		}else{
			if(!StringUtil.nullOrBlank(workFlowSearchBean.getPageType())&&"2".equals(workFlowSearchBean.getPageType())){
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
					if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and t.busitype_code not in (").append(workFlowSearchBean.getBusitype_code()).append(")");
					}else{
						sql.append(" and t.busitype_code = '"+workFlowSearchBean.getBusitype_code()+"'");
					}
				}
			}else{
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
					if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and t.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
					}else{
						sql.append(" and t.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
					}
				}
			}
			
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and t.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and t.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and t.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getInfo_type())){
			sql.append(" and b_type.busitype_type_code = '").append(workFlowSearchBean.getInfo_type()).append("'");
		}
		
		//组装委托代办列表
		String userName = workFlowSearchBean.getUsername();
		//查询出该人委托的人
		AgencyBean queryAgencyBean = new AgencyBean();
		queryAgencyBean.setAgency_id(userName);
		AgencyDao agencyDao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
		List<AgencyBean> agencyBeanList = agencyDao.findAgencyBeanList(queryAgencyBean);
		//如果有委托。
		if(agencyBeanList.size()>0 && agencyBeanList.get(0)!=null ){
			for(int j=0;j<agencyBeanList.size();j++){
				AgencyBean agencyBean = agencyBeanList.get(j);
				sql.append(" union ");
				sql.append("select");
				sql.append(" 		ins_id,");
				sql.append(" 		busi_id,");
				sql.append(" 		actInsId,");
				sql.append(" 		cc_form_instanceid,");
				sql.append(" 		ins_code,");
				sql.append(" 		busitype_code,");
				sql.append(" 		busitype_name,");
				sql.append(" 		ins_name||'<font color=''red''>（代'||'"+agencyBean.getEntrust_name()+"'||'处理）</font>' as ins_name ,");
				sql.append(" 		accepter,");
				sql.append(" 		accept_time,");
				sql.append(" 		act_name,");
				sql.append(" 		def_id,");
				sql.append(" 		procId,");
				sql.append(" 		action_defid,");
				sql.append(" 		actiontype_code,");
				sql.append(" 		lastmodifedtime,");
				sql.append(" 		flow_form,");
				sql.append(" 		template_id,");
				sql.append(" 		'1' as is_agency,");
				sql.append(" 		username as entrust_user_name");
				sql.append(" from VIEW_OA_WORK_LIST t where 1=1 ");
				sql.append(" and t.BUSITYPE_CODE in (select TT.BUSITYPE_CODE from OA_FLOW_BUSITYPE tt");
				sql.append(" where tt.BUSITYPE_TYPE_CODE in (select TTT.BUSITYPE_TYPE_CODE from OA_FLOW_BUSITYPE_TYPE TTT WHERE TTT.IS_VALID = '1'");
				sql.append(" and ttt.busitype_type_code = '"+agencyBean.getWork_type()+"'))  and t.username = '"+agencyBean.getEntrust_id()+"' ");
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
					sql.append(" and t.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
				}
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_name())){
					if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_name()).append(")");
					}
					
				}else{
					if(!StringUtil.nullOrBlank(workFlowSearchBean.getPageType())&&"2".equals(workFlowSearchBean.getPageType())){
						if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
							if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
								sql.append(" and t.busitype_code not in (").append(workFlowSearchBean.getBusitype_code()).append(")");
							}else{
								sql.append(" and t.busitype_code = '"+workFlowSearchBean.getBusitype_code()+"'");
							}
						}
					}else{
						if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
							if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
								sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_code()).append(")");
							}else{
								sql.append(" and t.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
							}
						}
					}
					
				}
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
					sql.append(" and t.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
				}
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
					sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
				}
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
					sql.append(" and t.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
				}
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
					sql.append(" and t.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
				}
			}
		}
		if(sortName.equals("busitype_name")){
			sql.append(" order by  f_type.busitype_order " + sortOrder);
		} else {
			sql.append(" order by  " + sortName + " " + sortOrder);
		}
		db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	//if(db.size()>0){
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setActInsId(db.getString(i, "actInsId"));
	    	workFlowShowListBean.setCc_form_instanceid(db.getString(i, "cc_form_instanceid"));
	    	workFlowShowListBean.setIns_code(db.getString(i, "ins_code"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setProcId(db.getString(i, "procId"));
	    	workFlowShowListBean.setAction_defid(db.getString(i, "action_defid"));
	    	workFlowShowListBean.setActiontype_code(db.getString(i, "actiontype_code"));
	    	workFlowShowListBean.setFlow_form(db.getString(i, "flow_form"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setIs_agency(db.getString(i, "is_agency"));
	    	workFlowShowListBean.setEntrust_user_name(db.getString(i, "entrust_user_name"));
	    	//特检院OA 事务处理模块 追加 【业务类别】 start
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i, "busitype_type_name"));
	    	//特检院OA 事务处理模块 追加 【业务类别】 end
	    	list.add(workFlowShowListBean);
	    }
    	/*}else{
    		throw new Exception("执行待办列表查询报错!")	;
    	}*/
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	public PagingBean findLsWorkList(WorkFlowSearchBean workFlowSearchBean,String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException{
		PagingBean pb = new PagingBean();
		Connection conn = null;
		StringBuffer sql = new StringBuffer();
		try {
			sql.append("select i.*,u.user_realname,f.recordid from ( select b.flow_name,i.*,ia.action_name,ia.tache_begin_time,ia.tache_end_time,ia.insert_order,ia.action_handername,ia.is_valid valid,ia.flow_action_id,b.flow_tyle  from  ");
			sql.append("(select t.* from OA_FLOW_INSTANCE t start with  parent_ins_id=? connect by prior t.ins_id=t.parent_ins_id ");
			sql.append("union select t.* from OA_FLOW_INSTANCE t start with  ins_id=? connect by prior t.parent_ins_id =t.ins_id ) i");
			sql.append(",oa_flow_inswfaction ia,oa_flow_baseinfo b  where i.ins_id=ia.ins_id and b.flow_id=i.flow_id ) i left join td_sm_user u on u.user_name=i.action_handername  left join oa_flow_document_file f on i.flow_action_id=f.flow_act_id");
			
			sql.append(" order by i." + sortName + " " + sortOrder);
	    	pb=queryToPagingBean(sql.toString(), 0, maxPagesize, conn, workFlowSearchBean.getIns_code(),workFlowSearchBean.getIns_code());
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally {
			DbManager.closeConnection(conn);
		}
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findToBeWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findToBeWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findToBeWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		ins_id,");
		sql.append(" 		busi_id,");
		sql.append(" 		actInsId,");
		sql.append(" 		cc_form_instanceid,");
		sql.append(" 		ins_code,");
		sql.append(" 		t.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		b_type.busitype_type_name,");
		sql.append(" 		ins_name,");
		sql.append(" 		accepter,");
		sql.append(" 		accept_time,");
		sql.append(" 		act_name,");
		sql.append(" 		def_id,");
		sql.append(" 		flow_form,template_id");
		sql.append(" from VIEW_OA_TOBEWORK_LIST t,oa_flow_busitype f_type,oa_flow_busitype_type  b_type ");
		//特检院OA 事务处理模块 追加 【业务类别】 start
		sql.append("   where 1=1  and t.BUSITYPE_CODE=f_type.busitype_code ");
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code ");
		//特检院OA 事务处理模块 追加 【业务类别】 end
		//sql.append(" and t.BUSITYPE_CODE in (select TT.BUSITYPE_CODE from OA_FLOW_BUSITYPE tt");
		//sql.append(" where tt.BUSITYPE_TYPE_CODE in (select TTT.BUSITYPE_TYPE_CODE from OA_FLOW_BUSITYPE_TYPE TTT WHERE TTT.IS_VALID = '1'))");
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUsername())){
			sql.append(" and t.username = '").append(workFlowSearchBean.getUsername()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
			sql.append(" and t.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and t.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
			}else{
				sql.append(" and t.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and t.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and t.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and t.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getInfo_type())){//业务类型分类用
			sql.append(" and b_type.busitype_type_code = '").append(StringUtil.deNull(workFlowSearchBean.getInfo_type())).append("'");
		}
		if(sortName.equals("busitype_name")){
			sql.append(" order by    f_type.busitype_order " + sortOrder);
		} else {
			sql.append(" order by    " + sortName + " " + sortOrder);
		}
		db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
	    for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setActInsId(db.getString(i, "actInsId"));
	    	workFlowShowListBean.setCc_form_instanceid(db.getString(i, "cc_form_instanceid"));
	    	workFlowShowListBean.setIns_code(db.getString(i, "ins_code"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setFlow_form(db.getString(i, "flow_form"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	//特检院OA 事务处理模块 追加 【业务类别】 start
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i, "busitype_type_name"));
	    	//特检院OA 事务处理模块 追加 【业务类别】 end
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findDoneWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findDoneWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findDoneWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		String isShow_NewestAct = OASystemCache.getContextProperty("workflow.DoneWorkList.isShow_NewestAct");
		sql.append("select distinct(accept_time),");
		sql.append("       ins_id,");
		sql.append("       busi_id,");
		sql.append("       busitype_name,");
		sql.append("       busitype_type_name,");
		sql.append("       ins_name,");
		sql.append("       accepter,");
		sql.append("       act_name,");
		sql.append("       action_form,");
		sql.append("       busitype_code,");
		sql.append("       status_name,");
		sql.append("       act_insid,");
		sql.append("       flow_id,");
		sql.append("       template_id,");
		sql.append("       def_id,");
		sql.append("       processid, ");
		sql.append("       action_handername, ");
		sql.append("       busitype_order,");
		sql.append("	   act_index ");
		sql.append("   from (");
		
		sql.append("select distinct(i.accept_time) accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       i.busitype_name,");
		sql.append("       b_type.busitype_type_name,");
		sql.append("       i.ins_name,");
		sql.append("       i.accepter,");
		sql.append("       i.action_name as act_name,");
		sql.append("       i.action_form,");
		sql.append("       i.busitype_code,");
		sql.append("       s.status_name,");
		sql.append("       i.act_insid,");
		sql.append("       i.flow_id,");
		sql.append("       i.template_id,");
		sql.append("       i.def_id, ");
		sql.append("       i.processid, ");
		sql.append("       i.action_handername, ");
		sql.append("       f_type.busitype_order busitype_order, ");
		if("true".equals(isShow_NewestAct)){//已办列表是否只展示最新的一条信息
			sql.append("	 ROW_NUMBER() OVER(partition by ins_id ORDER BY TACHE_END_TIME DESC) act_index ");
		}else{
			sql.append("	 ROW_NUMBER() OVER(partition by ins_id ORDER BY TACHE_END_TIME DESC) act_index ");
		}
		sql.append("  from view_oa_instance i, oa_flow_status s");
		sql.append("  ,oa_flow_busitype f_type,oa_flow_busitype_type  b_type ");
		sql.append(" where i.status_code = s.status_code");
		sql.append("  and i.busitype_code = f_type.busitype_code " );
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code " );
		sql.append("   and i.is_valid = 'Y'");
		sql.append("   and i.action_handername is not null");
		sql.append("   and i.action_handername = '"+workFlowSearchBean.getUsername()+"'");
		sql.append(") t where 1=1 ");
		if("true".equals(isShow_NewestAct)){//已办列表是否只展示最新的一条信息
			//sql.append(" and oa_getaction_index(i.ins_id, i.flow_action_id,'"+workFlowSearchBean.getUsername()+"') = '1'");
			sql.append(" and t.ins_id in(select tn.ins_id from oa_flow_inswfaction tn where tn.action_handername = '"+workFlowSearchBean.getUsername()+"')");
			sql.append(" and t.act_index = 1 ");
		}else{
			sql.append("   and t.action_handername = '"+workFlowSearchBean.getUsername()+"'");
			sql.append("   and t.action_handername is not null");
		}
//		sql.append(" and t.BUSITYPE_CODE in (select TT.BUSITYPE_CODE from OA_FLOW_BUSITYPE tt");
//		sql.append(" where tt.BUSITYPE_TYPE_CODE in (select TTT.BUSITYPE_TYPE_CODE from OA_FLOW_BUSITYPE_TYPE TTT WHERE TTT.IS_VALID = '1'))");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and t.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
			}else{
				sql.append(" and t.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getInfo_type())){//业务类型分类用
			sql.append(" and t.busitype_type_name ='").append(workFlowSearchBean.getInfo_type()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and t.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and t.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and t.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		
		if(sortName.equals("busitype_name")){
			sql.append(" order by    busitype_order " + sortOrder);
		} else {
			sql.append(" order by   " + sortName + " " + sortOrder);
		}
		
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	String myselectSql = "";
    	String act_index = "0";
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	if("true".equals(isShow_NewestAct)){//已办列表是否只展示最新的一条信息
				myselectSql = "select oa_is_back('"+workFlowShowListBean.getIns_id()+"','"+workFlowSearchBean.getUsername()+"') act_index from dual";
				act_index = DaoUtil.sqlToField(myselectSql);
				workFlowShowListBean.setAct_index(act_index);
			}else{
				myselectSql = "select oa_getaction_index1('"+db.getString(i, "processid")+"','"+workFlowShowListBean.getAct_insid()+"') act_index from dual";
				act_index = DaoUtil.sqlToField(myselectSql);
				workFlowShowListBean.setAct_index(act_index);
			}
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i,"busitype_type_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findDoneWorkFindList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findDoneWorkFindList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findDoneWorkFindList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select i.accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       b.busitype_name,");
		sql.append("       i.ins_name,");
		sql.append("       i.accepter,");
		sql.append("       i.org_id,");
		sql.append("       o.org_name,");
		sql.append("       i.busitype_code,");
		sql.append("       i.flow_id,i.template_id,fb.from_path action_form");
		sql.append("  from OA_FLOW_INSTANCE i,oa_flow_busitype b,td_sm_organization o,oa_flow_baseinfo fb ");
		sql.append(" where i.busitype_code = b.busitype_code and i.org_id=o.org_id and  i.busitype_code=fb.busitype_code");
		sql.append("   and i.is_valid = 'Y'");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUnit_id())){
			sql.append(" and i.org_id = '").append(workFlowSearchBean.getUnit_id()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIs_open())){
			sql.append(" and i.is_open = '").append(workFlowSearchBean.getIs_open()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStatus_code())){
			sql.append(" and i.status_code = '").append(workFlowSearchBean.getStatus_code()).append("'");
		}
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and i.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setOrg_id(db.getString(i, "org_id"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setOrg_name(db.getString(i, "org_name"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSituation
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findSituation(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findSituation(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select  ");
		sql.append(" 		ins_id,");
		sql.append(" 		busi_id,");
		sql.append(" 		actInsId,");
		sql.append(" 		cc_form_instanceid,");
		sql.append(" 		ins_code,");
		sql.append(" 		busitype_code,");
		sql.append(" 		busitype_name,");
		sql.append(" 		ins_name,");
		sql.append(" 		accepter,");
		sql.append(" 		accept_time,");
		sql.append(" 		act_name,");
		sql.append(" 		def_id,");
		sql.append(" 		procId,");
		sql.append(" 		action_defid,");
		sql.append(" 		laststatetime,");
		sql.append("        actiontype_code,");
		sql.append("        action_form");
		sql.append(" from v_oa_all_work_list t where 1=1 ");
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUsername())){
			sql.append(" and t.username = '").append(workFlowSearchBean.getUsername()).append("'");
		}
//		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
//			sql.append(" and t.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
//		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_name())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_name()).append(")");
			}
			
		}else{
			if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
				if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
					sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_code()).append(")");
				}else{
					sql.append(" and t.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
				}
				
			}
		}
//		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
//			sql.append(" and t.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
//		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and t.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and t.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		
		sql.append(" order by laststatetime desc");
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setIns_code(db.getString(i, "ins_code"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setActiontype_code(db.getString(i, "actiontype_code"));

	    	list.add(workFlowShowListBean);
	    }
	 	pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getProcInsIdByBussinessId
	  * @param bussinessid
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#getProcInsIdByBussinessId(java.lang.String)
	 */
	public String getProcInsIdByBussinessId(String bussinessid)
	throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select m.procinstanceid from td_proc_form_instancemap m where m.businessid='"
						+ bussinessid + "'");
		String result = DaoUtil.sqlToField(sql.toString());
		return result;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getProcInsIdByInsId
	  * @param ins_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#getProcInsIdByInsId(java.lang.String)
	 */
	public String getProcInsIdByInsId(String ins_id) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select cc_form_instanceid from oa_flow_instance where ins_id='"
						+ ins_id + "'");
		String result = DaoUtil.sqlToField(sql.toString());
		return result;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFlowManageList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findFlowManageList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowManageList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select i.*,u.user_realname from ( select");
		sql.append(" 		i.ins_id,");
		sql.append(" 		I.BUSITYPE_CODE,t.busitype_name,i.busi_id,");
		sql.append(" 		w.action_name as act_name,");
		sql.append(" 		I.INS_NAME,");
		sql.append(" 		i.ins_code,");
		sql.append(" 		i.accepter,");
		sql.append(" 		i.accept_time,");
		sql.append(" 		I.ACCEPTER_ID,");
		sql.append(" 		I.FLOW_ID,");
		sql.append(" 		i.def_id,");
		sql.append(" 		I.CC_FORM_INSTANCEID,");
		sql.append(" 		i.lastmodifedtime,");
		sql.append(" 		i.template_id,");
		sql.append(" 		u.activity,");
		sql.append(" 		u.user_name,b.from_path action_form ");
		
		sql.append(" from OA_FLOW_ACTIONUSER u,oa_flow_instance i,OA_FLOW_WFACTION w, oa_flow_baseinfo b,oa_flow_busitype  t  where u.ins_id=i.ins_id and w.def_id=i.def_id and  w.action_defid=u.act_defid and b.busitype_code=i.busitype_code and i.busitype_code=t.busitype_code ) i left join td_sm_user u on i.user_name=u.user_name");
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
			sql.append(" and i.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_name())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and i.busitype_code in (").append(workFlowSearchBean.getBusitype_name()).append(")");
			}
			
		}else{
			if(!StringUtil.nullOrBlank(workFlowSearchBean.getPageType())&&"2".equals(workFlowSearchBean.getPageType())){
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
					if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and i.busitype_code not in (").append(workFlowSearchBean.getBusitype_code()).append(")");
					}else{
						sql.append(" and i.busitype_code = '"+workFlowSearchBean.getBusitype_code()+"'");
					}
				}
			}else{
				if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
					if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
						sql.append(" and i.busitype_code in (").append(workFlowSearchBean.getBusitype_code()).append(")");
					}else{
						sql.append(" and i.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
					}
				}
			}
			
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and t.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
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
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setAction_defid(db.getString(i, "activity"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setUser_name(db.getString(i, "user_name"));
	    	workFlowShowListBean.setUser_realname(db.getString(i, "user_realname"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFlowChiefList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao#findFlowChiefList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowChiefList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select i.ins_id,");
		sql.append("       b.busitype_name,");
		sql.append("       i.busitype_code,");
		sql.append("       i.ins_name,");
		sql.append("       i.org_id,");
		sql.append("       i.flow_id,");
		sql.append("       i.def_id,");
		sql.append("       i.busi_id,");
		sql.append("       c.action_form,");
		sql.append("       c.action_name act_name,i.template_id,i.chief_endtime,i.accept_time,s.status_name");
		sql.append("  from OA_FLOW_BUSITYPE B,oa_flow_status s, OA_FLOW_INSTANCE I,(select * from OA_FLOW_INSWFACTION where insert_order in ( select max(insert_order) from  OA_FLOW_INSWFACTION  group by ins_id ) ) C ");
		sql.append(" where I.BUSITYPE_CODE = TRIM(B.BUSITYPE_CODE) AND I.INS_ID = C.INS_ID and i.status_code=s.status_code  and i.chief_endtime is not null");
		sql.append("   and i.is_valid = 'Y'");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUnit_id())){
			sql.append(" and i.org_id = '").append(workFlowSearchBean.getUnit_id()).append("'");
		}
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and i.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setChief_endtime(DateUtil.getTimeStringFull(db.getTimestamp(i, "chief_endtime")));
	    	workFlowShowListBean.setOrg_id(db.getString(i, "org_id"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringFull(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
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
	public PagingBean findPlandoneDeWorkList(WorkFlowSearchBean workFlowSearchBean,
		String sortName, String sortOrder, long offset, int maxPagesize)
				throws Exception{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select i.accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       i.busitype_name,");
		sql.append("       b_type.busitype_type_name,");
		sql.append("       i.ins_name,");
		//申购计划查询
		if(workFlowSearchBean.getBusitype_code().equals("uuid_520")){
			sql.append("       (select ob.t_org_name from ta_oa_osapplan ob where ob.t_id = i.BUSI_ID and ob.t_user_id= '"+workFlowSearchBean.getUserId()+"' ) as orgname,");
			//审批状态
			sql.append(" decode((select count(*) ");
			sql.append("  from ta_oa_osexamination t, oa_flow_instance it ");
			sql.append(" where t.t_osexa_id = it.busi_id");
			sql.append("   and it.status_code = '02'");
			sql.append("    and instr(t.t_ids,i.busi_id)>0),'0','未审批','已审批') as planStatus, ");
		//申购审批查询
		} if(workFlowSearchBean.getBusitype_code().equals("uuid_521")){
			sql.append("       (select ob.t_osexa_org_name from ta_oa_osexamination ob where ob.t_osexa_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
		//易耗品领用查询
		} else if(workFlowSearchBean.getBusitype_code().equals("uuid_620")){
			sql.append("       (select ob.t_appregyhp_org_name from ta_oa_osappregyhp ob where ob.t_appregyhp_id = i.BUSI_ID and ob.t_appregyhp_user_id= '"+workFlowSearchBean.getUserId()+"') as orgname,");
			sql.append(" '' as planStatus,");
			
		//固定资产申领审批
		} else if(workFlowSearchBean.getBusitype_code().equals("uuid_621")){
			sql.append("       (select ob.t_osnom_org_name from ta_oa_osnomove ob where ob.t_osnom_id = i.BUSI_ID and ob.t_osnom_user_id= '"+workFlowSearchBean.getUserId()+"') as orgname,");
			sql.append(" '' as planStatus,");
		}
		sql.append("       i.accepter,");
		sql.append("       i.action_name as act_name,");
		sql.append("       i.action_form,");
		sql.append("       i.busitype_code,");
		sql.append("       s.status_name,");
		sql.append("       i.act_insid,");
		sql.append("       i.flow_id,i.template_id,i.def_id,");
		sql.append(" 	   ' ' as act_index ");
		sql.append("  from view_oa_instance i, oa_flow_status s");
		sql.append("  ,oa_flow_busitype f_type,oa_flow_busitype_type  b_type ");
		sql.append(" where i.status_code = s.status_code");
		sql.append("  and i.busitype_code = f_type.busitype_code " );
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code " );
		sql.append("   and i.is_valid = 'Y'");
		
		sql.append(" and i.ins_id in(select tn.ins_id from oa_flow_inswfaction tn )");
		sql.append(" and OA_GETALLACTION_INDEX(i.ins_id, i.flow_action_id) = '1'");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and i.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
			}else{
				sql.append(" and i.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getOrg_name())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("uuid_520")){
				sql.append(" and (select ob.t_org_name from ta_oa_osapplan ob  where ob.t_id = i.BUSI_ID) like '%").append(workFlowSearchBean.getOrg_name()).append("%'");
			//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("uuid_521")){
				sql.append(" and (select ob.t_osexa_org_name from ta_oa_osexamination ob where ob.t_osexa_id = i.BUSI_ID) like '%").append(workFlowSearchBean.getOrg_name()).append("%'");
			//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_620")){
				sql.append(" and (select ob.t_appregyhp_org_name from ta_oa_osappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) like '%").append(workFlowSearchBean.getOrg_name()).append("%'");
			//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_621")){
				sql.append(" and (select ob.t_osnom_org_name from ta_oa_osnomove ob where ob.t_osnom_id = i.BUSI_ID)  like '%").append(workFlowSearchBean.getOrg_name()).append("%'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUserId())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("uuid_520")){
				sql.append(" and (select ob.t_user_id from ta_oa_osapplan ob  where ob.t_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
				//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("uuid_521")){
				sql.append(" and (select ob.t_osexa_user_id from ta_oa_osexamination ob where ob.t_osexa_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
				//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_620")){
				sql.append(" and (select ob.t_appregyhp_user_id from ta_oa_osappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
				//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_621")){
				sql.append(" and (select ob.t_osnom_user_id from ta_oa_osnomove ob where ob.t_osnom_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and i.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setAct_index(db.getString(i, "act_index"));
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i,"busitype_type_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setOrg_name(db.getString(i, "orgname"));
	    	workFlowShowListBean.setPlanStatus(db.getString(i,"planStatus"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 
	*<b>Summary: </b>
	* findDETPlandoneDeWorkList(根据条件查询所有人员的[检测耗材易耗品申购计划表]已办列表信息)
	* @param workFlowSearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findDETPlandoneDeWorkList(WorkFlowSearchBean workFlowSearchBean, 
		String sortName, String sortOrder, long offset, int maxPagesize) 
			throws Exception{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select i.accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       i.busitype_name,");
		sql.append("       b_type.busitype_type_name,");
		sql.append("       i.ins_name,");
		//申购计划查询
		if(workFlowSearchBean.getBusitype_code().equals("uuid_5201")){
			sql.append("       (select ob.t_org_name from ta_oa_detosapplan ob where ob.t_id = i.BUSI_ID) as orgname,");
			//审批状态
			sql.append(" decode((select count(*) ");
			sql.append("  from ta_oa_detosexamination t, oa_flow_instance it ");
			sql.append(" where t.t_osexa_id = it.busi_id");
			sql.append("   and it.status_code = '02'");
			sql.append("    and instr(t.t_ids,i.busi_id)>0),'0','未审批','已审批') as planStatus, ");
		//申购审批查询
		} if(workFlowSearchBean.getBusitype_code().equals("uuid_5211")){
			sql.append("       (select ob.t_osexa_org_name from ta_oa_detosexamination ob where ob.t_osexa_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
		//易耗品领用查询
		} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6201")){
			sql.append("       (select ob.t_appregyhp_org_name from ta_oa_detosappregyhp ob where ob.t_appregyhp_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
			
		//固定资产申领审批
		} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6211")){
			sql.append("       (select ob.t_osnom_org_name from ta_oa_detosnomove ob where ob.t_osnom_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
		}
		sql.append("       i.accepter,");
		sql.append("       i.action_name as act_name,");
		sql.append("       i.action_form,");
		sql.append("       i.busitype_code,");
		sql.append("       s.status_name,");
		sql.append("       i.act_insid,");
		sql.append("       i.flow_id,i.template_id,i.def_id,");
		sql.append(" 	   ' ' as act_index ");
		sql.append("  from view_oa_instance i, oa_flow_status s");
		sql.append("  ,oa_flow_busitype f_type,oa_flow_busitype_type  b_type ");
		sql.append(" where i.status_code = s.status_code");
		sql.append("  and i.busitype_code = f_type.busitype_code " );
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code " );
		sql.append("   and i.is_valid = 'Y'");
		
		sql.append(" and i.ins_id in(select tn.ins_id from oa_flow_inswfaction tn )");
		sql.append(" and OA_GETALLACTION_INDEX(i.ins_id, i.flow_action_id) = '1'");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and i.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
			}else{
				sql.append(" and i.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getOrg_name())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("uuid_5201")){
				sql.append(" and (select ob.t_org_name from ta_oa_detosapplan ob  where ob.t_id = i.BUSI_ID) like '%")
				.append(workFlowSearchBean.getOrg_name()).append("%'");
			//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("uuid_5211")){
				sql.append(" and (select ob.t_osexa_org_name from ta_oa_detosexamination ob where ob.t_osexa_id = i.BUSI_ID) like '%")
				.append(workFlowSearchBean.getOrg_name()).append("%'");
			//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6201")){
				sql.append(" and (select ob.t_appregyhp_org_name from ta_oa_detosappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) like '%")
				.append(workFlowSearchBean.getOrg_name()).append("%'");
			//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6211")){
				sql.append(" and (select ob.t_osnom_org_name from ta_oa_detosnomove ob where ob.t_osnom_id = i.BUSI_ID)  like '%")
				.append(workFlowSearchBean.getOrg_name()).append("%'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUserId())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("uuid_5201")){
				sql.append(" and (select ob.t_user_id from ta_oa_detosapplan ob  where ob.t_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
			//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("uuid_5211")){
				sql.append(" and (select ob.t_osexa_user_id from ta_oa_detosexamination ob where ob.t_osexa_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
			//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6201")){
				sql.append(" and (select ob.t_appregyhp_user_id from ta_oa_detosappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
			//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("uuid_6211")){
				sql.append(" and (select ob.t_osnom_user_id from ta_oa_detosnomove ob where ob.t_osnom_id = i.BUSI_ID) ='")
				.append(workFlowSearchBean.getUserId()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and i.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setAct_index(db.getString(i, "act_index"));
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i,"busitype_type_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setOrg_name(db.getString(i, "orgname"));
	    	workFlowShowListBean.setPlanStatus(db.getString(i,"planStatus"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary:根据条件查询所有人员的[食堂物品易耗品申购计划表]已办列表信息 </b>
	  *     复写方法 findCANPlandoneDeWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.processing.dao.ProFlowBusiSearchDao
	  * #findCANPlandoneDeWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean,
	  *  java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findCANPlandoneDeWorkList(
			WorkFlowSearchBean workFlowSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select i.accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       i.busitype_name,");
		sql.append("       b_type.busitype_type_name,");
		sql.append("       i.ins_name,");
		//申购计划查询
		if(workFlowSearchBean.getBusitype_code().equals("stwp_520")){
			sql.append("       (select ob.t_org_name from ta_oa_canosapplan ob where ob.t_id = i.BUSI_ID) as orgname,");
			//审批状态
			sql.append(" decode((select count(*) ");
			sql.append("  from ta_oa_canosexamination t, oa_flow_instance it ");
			sql.append(" where t.t_osexa_id = it.busi_id");
			sql.append("   and it.status_code = '02'");
			sql.append("    and instr(t.t_ids,i.busi_id)>0),'0','未审批','已审批') as planStatus, ");
		//申购审批查询
		} if(workFlowSearchBean.getBusitype_code().equals("stwp_521")){
			sql.append("       (select ob.t_osexa_org_name from ta_oa_canosexamination ob where ob.t_osexa_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
		//易耗品领用查询
		} else if(workFlowSearchBean.getBusitype_code().equals("stwp_620")){
			sql.append("       (select ob.t_appregyhp_org_name from ta_oa_canosappregyhp ob where ob.t_appregyhp_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
			
		//固定资产申领审批
		} else if(workFlowSearchBean.getBusitype_code().equals("stwp_621")){
			sql.append("       (select ob.t_osnom_org_name from ta_oa_canosnomove ob where ob.t_osnom_id = i.BUSI_ID) as orgname,");
			sql.append(" '' as planStatus,");
		}
		sql.append("       i.accepter,");
		sql.append("       i.action_name as act_name,");
		sql.append("       i.action_form,");
		sql.append("       i.busitype_code,");
		sql.append("       s.status_name,");
		sql.append("       i.act_insid,");
		sql.append("       i.flow_id,i.template_id,i.def_id,");
		sql.append(" 	   ' ' as act_index ");
		sql.append("  from view_oa_instance i, oa_flow_status s");
		sql.append("  ,oa_flow_busitype f_type,oa_flow_busitype_type  b_type ");
		sql.append(" where i.status_code = s.status_code");
		sql.append("  and i.busitype_code = f_type.busitype_code " );
		sql.append("  and f_type.busitype_type_code=b_type.busitype_type_code " );
		sql.append("   and i.is_valid = 'Y'");
		
		sql.append(" and i.ins_id in(select tn.ins_id from oa_flow_inswfaction tn )");
		sql.append(" and OA_GETALLACTION_INDEX(i.ins_id, i.flow_action_id) = '1'");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			if(workFlowSearchBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and i.busitype_code in (").append(StringUtil.splitString(workFlowSearchBean.getBusitype_code(), ",", "'")).append(")");
			}else{
				sql.append(" and i.busitype_code like '").append(workFlowSearchBean.getBusitype_code()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getOrg_name())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("stwp_520")){
				sql.append(" and (select ob.t_org_name from ta_oa_canosapplan ob  where ob.t_id = i.BUSI_ID) like '%")
				   .append(workFlowSearchBean.getOrg_name()).append("%'");
			//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("stwp_521")){
				sql.append(" and (select ob.t_osexa_org_name from ta_oa_canosexamination ob where ob.t_osexa_id = i.BUSI_ID) like '%")
				   .append(workFlowSearchBean.getOrg_name()).append("%'");
			//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("stwp_620")){
				sql.append(" and (select ob.t_appregyhp_org_name from ta_oa_canosappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) like '%")
				   .append(workFlowSearchBean.getOrg_name()).append("%'");
			//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("stwp_621")){
				sql.append(" and (select ob.t_osnom_org_name from ta_oa_canosnomove ob where ob.t_osnom_id = i.BUSI_ID)  like '%")
				   .append(workFlowSearchBean.getOrg_name()).append("%'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUserId())){
			//申购计划查询
			if(workFlowSearchBean.getBusitype_code().equals("stwp_520")){
				sql.append(" and (select ob.t_user_id from ta_oa_canosapplan ob  where ob.t_id = i.BUSI_ID) ='")
				   .append(workFlowSearchBean.getUserId()).append("'");
			//申购审批查询
			}if(workFlowSearchBean.getBusitype_code().equals("stwp_521")){
				sql.append(" and (select ob.t_osexa_user_id from ta_oa_canosexamination ob where ob.t_osexa_id = i.BUSI_ID) ='")
				   .append(workFlowSearchBean.getUserId()).append("'");
			//易耗品领用查询
			} else if(workFlowSearchBean.getBusitype_code().equals("stwp_620")){
				sql.append(" and (select ob.t_appregyhp_user_id from ta_oa_canosappregyhp  ob where ob.t_appregyhp_id = i.BUSI_ID) ='")
				   .append(workFlowSearchBean.getUserId()).append("'");
			//固定资产申领审批
			} else if(workFlowSearchBean.getBusitype_code().equals("stwp_621")){
				sql.append(" and (select ob.t_osnom_user_id from ta_oa_canosnomove ob where ob.t_osnom_id = i.BUSI_ID) ='")
				   .append(workFlowSearchBean.getUserId()).append("'");
			}
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getAccepter())){
			sql.append(" and i.accepter like '%").append(workFlowSearchBean.getAccepter()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getStartSlTime())){
			sql.append(" and i.accept_time > to_date('").append(workFlowSearchBean.getStartSlTime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getEndSlTime())){
			sql.append(" and i.accept_time < to_date('").append(workFlowSearchBean.getEndSlTime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(DateUtil.getTimeStringNos(db.getTimestamp(i, "accept_time")));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setAct_name(db.getString(i, "act_name"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setAct_index(db.getString(i, "act_index"));
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setBusitype_type_name(db.getString(i,"busitype_type_name"));
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	workFlowShowListBean.setOrg_name(db.getString(i, "orgname"));
	    	workFlowShowListBean.setPlanStatus(db.getString(i,"planStatus"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	@Override
	public void updateClgl() {
		Connection conn = null;
		PreparedDBUtil  db = new PreparedDBUtil ();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String sql = "update OA_FLOW_BUSITYPE_TYPE t set t.is_valid = '0' where t.busitype_type_code = 'clgl'";
			db.preparedUpdate(sql);
			db.executePrepared(conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		
	}
}

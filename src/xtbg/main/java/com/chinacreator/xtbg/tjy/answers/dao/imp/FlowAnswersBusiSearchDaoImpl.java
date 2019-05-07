
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2015 ICSS All Rights Reserved.
  * [FileName]
  *     FlowAnswersBusiSearchDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2015-2-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.answers.dao.imp;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowShowListBean;
import com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:FlowAnswersBusiSearchDaoImpl.java</p>
 *<p>Description:有问必答  数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2015-2-3
 */
public class FlowAnswersBusiSearchDaoImpl implements FlowAnswersBusiSearchDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findDoWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao#findDoWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findDoWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
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
		sql.append(" 		busitype_code,");
		sql.append(" 		busitype_name,");
		sql.append(" 		ins_name,");
		sql.append(" 		accepter,");
		sql.append(" 		accept_time,");
		sql.append(" 		act_name as act_name,");
		sql.append(" 		def_id,");
		sql.append(" 		procId,");
		sql.append(" 		action_defid,");
		sql.append(" 		actiontype_code,");
		sql.append(" 		lastmodifedtime,");
		sql.append(" 		flow_form,");
		sql.append(" 		info.p_types as template_id ");
		sql.append(" from VIEW_OA_WORK_LIST t ");
		sql.append("left join ta_oa_answers_info info  on t.busi_id = info.t_id  where 1=1 ");
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
						sql.append(" and t.busitype_code in (").append(workFlowSearchBean.getBusitype_code()).append(")");
					}else{
						sql.append(" and t.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
					}
					//只查有问必答的流程数据
				} else {
					sql.append(" and instr('uuid_ywbd',t.busitype_code) >0 ");
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
		

		sql.append(" order by " + sortName + " " + sortOrder);
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
	    	workFlowShowListBean.setProcId(db.getString(i, "procId"));
	    	workFlowShowListBean.setAction_defid(db.getString(i, "action_defid"));
	    	workFlowShowListBean.setActiontype_code(db.getString(i, "actiontype_code"));
	    	workFlowShowListBean.setFlow_form(db.getString(i, "flow_form"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findToBeWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao#findToBeWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findToBeWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
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
		sql.append(" 		busitype_code,");
		sql.append(" 		busitype_name,");
		sql.append(" 		ins_name,");
		sql.append(" 		accepter,");
		sql.append(" 		accept_time,");
		sql.append(" 		act_name,");
		sql.append(" 		def_id,");
		sql.append(" 		flow_form,");
		sql.append(" 		info.p_types as template_id ");
		sql.append(" from VIEW_OA_TOBEWORK_LIST t ");
		sql.append("  left join ta_oa_answers_info info  on t.busi_id = info.t_id  where 1=1 ");
		if(StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and instr('uuid_ywbd',t.busitype_code) >0 ");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getUsername())){
			sql.append(" and t.username = '").append(workFlowSearchBean.getUsername()).append("'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_code())){
			sql.append(" and t.ins_code like '%").append(workFlowSearchBean.getIns_code()).append("%'");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and t.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
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

		sql.append(" order by " + sortName + " " + sortOrder);
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
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findDoneWorkList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao#findDoneWorkList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findDoneWorkList(WorkFlowSearchBean workFlowSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		String isShow_NewestAct = OASystemCache.getContextProperty("workflow.DoneWorkList.isShow_NewestAct");
		
		sql.append("select i.accept_time,");
		sql.append("       i.ins_id,");
		sql.append("       i.busi_id,");
		sql.append("       i.busitype_name,");
		sql.append("       i.ins_name,");
		sql.append("       i.accepter,");
		sql.append("       i.action_name as act_name,");
		sql.append("       i.action_form,");
		sql.append("       i.busitype_code,");
		sql.append("       s.status_name,");
		sql.append("       i.act_insid,");
		sql.append("       i.flow_id,");
		sql.append("       info.p_types as template_id,i.def_id,");
		if("true".equals(isShow_NewestAct)){//已办列表是否只展示最新的一条信息
			sql.append("	   oa_is_back(i.ins_id,'"+workFlowSearchBean.getUsername()+"') act_index");
		}else{
			sql.append("	   oa_getaction_index1(i.processid,i.act_insid) act_index");
		}
		sql.append("  from view_oa_instance i, oa_flow_status s,ta_oa_answers_info info");
		sql.append(" where i.status_code = s.status_code");
		sql.append("   and i.busi_id=info.t_id ");//业务数据
		sql.append("   and i.is_valid = 'Y'");
		if("true".equals(isShow_NewestAct)){//已办列表是否只展示最新的一条信息
			sql.append(" and i.ins_id in(select tn.ins_id from oa_flow_inswfaction tn where tn.action_handername = '"+workFlowSearchBean.getUsername()+"')");
			sql.append(" and oa_getaction_index(i.ins_id, i.flow_action_id,'"+workFlowSearchBean.getUsername()+"') = '1'");
		}else{
			sql.append("   and i.action_handername = '"+workFlowSearchBean.getUsername()+"'");
			sql.append("   and i.action_handername is not null");
		}
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and i.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
		}
		//标题
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getIns_name())){
			sql.append(" and i.ins_name like '%").append(workFlowSearchBean.getIns_name()).append("%'");
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
	    	workFlowShowListBean.setDef_id(db.getString(i, "def_id"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findViewAnswersList
	  * @param workFlowSearchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao#findViewAnswersList(com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean findViewAnswersList(
			WorkFlowSearchBean workFlowSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select ins_id,");
		sql.append("       busi_id,");
		sql.append("       cc_form_instanceid,");
		sql.append("       ins_code,");
		sql.append("       busitype_code,");
		sql.append("       ins_name,");
		sql.append("       accepter,");
		sql.append("       to_char(infos.publish_time,'yyyy-mm-dd hh24:mi') as accept_time,");
		sql.append("       def_id,");
		sql.append("       lastmodifedtime,");
		sql.append("       infos.p_types as template_id,");
		sql.append("       infos.t_id as act_index");
		sql.append("  from OA_FLOW_INSTANCE t");
		sql.append("  ,ta_oa_answers_info infos");
		sql.append(" where  t.busi_id = infos.t_id ");
		sql.append("        and infos.ispublish = '1' ");
		
		if(!StringUtil.nullOrBlank(workFlowSearchBean.getBusitype_code())){
			sql.append(" and t.busitype_code like '%").append(workFlowSearchBean.getBusitype_code()).append("%'");
		}
		//标题
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
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(db.getString(i, "accept_time"));
	    	workFlowShowListBean.setStatus_name(db.getString(i, "status_name"));
	    	workFlowShowListBean.setAction_form(db.getString(i, "action_form"));
	    	workFlowShowListBean.setBusitype_name(db.getString(i, "busitype_name"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setAct_index(db.getString(i, "act_index"));
	    	workFlowShowListBean.setAct_insid(db.getString(i, "act_insid"));
	    	workFlowShowListBean.setFlow_id(db.getString(i, "flow_id"));
	    	workFlowShowListBean.setTemplate_id(db.getString(i, "template_id"));
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	list.add(workFlowShowListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
}

package com.chinacreator.xtbg.core.process.flowprocessing.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.CztFlowBusiSearchDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowShowListBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FlowBusiSearchDaoImpl.java</p>
 *<p>Description:查询公文列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public class CztFlowBusiSearchDaoImpl extends XtDbBaseDao implements CztFlowBusiSearchDao {
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
	public PagingBean findDoneWorkFindList(WorkFlowSearchBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException{
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<WorkFlowShowListBean> list = new ArrayList<WorkFlowShowListBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t.doc_id ins_id,");
		sql.append("       t.doc_title ins_name,");
		sql.append("       t.doc_type busitype_name,");
		sql.append("       t.doc_user_id,");
		sql.append("       t.doc_user_eng_name,");
		sql.append("       t.doc_user_name accepter,");
		sql.append("       t.doc_org_id org_id,");
		sql.append("       t.doc_org_name org_name,");
		sql.append("       t.doc_time accept_time,");
		sql.append("       t.doc_file template_id,");
		sql.append("       t.doc_assessory, b.filename flow_id ");
		sql.append("  from history_document t left join document_assessory b on t.doc_file = b.djsn ");
		sql.append("  where 1=1 ");
		if (!StringUtil.nullOrBlank(bean.getIns_name())) {
			sql.append("  and t.doc_title like '%"+bean.getIns_name()+"%'");
		}
		if (!StringUtil.nullOrBlank(bean.getStartSlTime())) {
			sql.append("  and to_date(t.doc_time, 'yyyy-mm-dd hh24:mi') >= to_date('"+bean.getStartSlTime()+" 00:00', 'yyyy-mm-dd hh24:mi')");
		}
		if (!StringUtil.nullOrBlank(bean.getEndSlTime())) {
			sql.append("  and to_date(t.doc_time, 'yyyy-mm-dd hh24:mi') <= to_date('"+bean.getEndSlTime()+" 23:59', 'yyyy-mm-dd hh24:mi')");
		}
		if (!StringUtil.nullOrBlank(bean.getBusitype_code()) && !bean.getBusitype_code().equals("---请选择---")) {
			sql.append("  and doc_type = '"+bean.getBusitype_code()+"'");
		}
		if (!StringUtil.nullOrBlank(bean.getUnit_id())) {
			sql.append("  and t.doc_org_id = '" + bean.getUnit_id() + "'");
		}
		sql.append("  order by t.doc_time desc");

    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
	    	WorkFlowShowListBean workFlowShowListBean = new WorkFlowShowListBean();
	    	workFlowShowListBean.setIns_id(db.getString(i, "ins_id"));
	    	workFlowShowListBean.setBusi_id(db.getString(i, "busi_id"));
	    	workFlowShowListBean.setBusitype_code(db.getString(i, "busitype_code"));
	    	workFlowShowListBean.setIns_name(db.getString(i, "ins_name"));
	    	workFlowShowListBean.setAccepter(db.getString(i, "accepter"));
	    	workFlowShowListBean.setAccept_time(db.getString(i, "accept_time"));
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
	
}

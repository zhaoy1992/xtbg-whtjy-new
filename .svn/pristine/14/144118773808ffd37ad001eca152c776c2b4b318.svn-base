package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.FlowOperExtDao;
import com.chinacreator.xtbg.core.archive.entity.DoBackBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FlowOperExtDaoImpl.java</p>
 *<p>Description:流程操作扩展Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-11-14
 */
public class FlowOperExtDaoImpl implements FlowOperExtDao {

	private static final Logger LOG = Logger.getLogger(FlowOperExtDaoImpl.class);
	
	@Override
	public PagingBean selDoBackList(DoBackBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<DoBackBean> list = new ArrayList<DoBackBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct w.ins_id,");
		sql.append("                w.act_defid,");
		sql.append("                w.action_name,");
		sql.append("                w.action_handername,");
		sql.append("                u.user_realname,  o.issignjoinbyorder");
		sql.append("  from oa_flow_inswfaction w, td_sm_user u, oa_flow_wfactionext o");
		sql.append(" where w.action_handername = u.user_name  and w.action_id = o.action_id");
		sql.append("   and w.ins_id = '" + bean.getIns_id()+"'");
		sql.append("   and w.action_handername is not null");
		sql.append("   and w.act_defid in ("+bean.getNext_actdefId()+")");
		
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0 ; i < db.size() ; i++){
				//add by shuqi.liu 2014-3-18 10:33:51  回退列表中过滤会签环节，不能回退到会签环节
				if(StringUtil.isBlank(db.getString(i,"issignjoinbyorder"))){
					DoBackBean doBackBean = new DoBackBean();
					doBackBean.setIns_id(db.getString(i,"ins_id"));
					doBackBean.setNext_actdefId(db.getString(i,"act_defid"));
					doBackBean.setNext_actName(db.getString(i,"action_name"));
					doBackBean.setUser_name(db.getString(i,"action_handername"));
					doBackBean.setUser_rename(db.getString(i,"user_realname"));
					list.add(doBackBean);
				}
			}
		} catch (SQLException e) {
			LOG.error("查询回退列表报错："+e.getMessage());
		}
		 pb.setList(list);
		 pb.setRecords((long)db.getTotalSize());
		return pb;
	}

}

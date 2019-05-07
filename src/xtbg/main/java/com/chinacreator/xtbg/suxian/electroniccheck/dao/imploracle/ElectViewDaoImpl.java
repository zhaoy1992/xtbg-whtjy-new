package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;


import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectViewDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class ElectViewDaoImpl implements ElectViewDao {
	/**
	 *<p>Title:ElectResetDaoImpl.java</p>
	 *<p>Description:电子考勤实例类</p> 
	 *<p>Company:湖南科创</p>
	 *@author 付程
	 *@version 1.0
	 *2012-2-24
	 */

	private static final Logger LOG = Logger.getLogger(ElectViewDaoImpl.class);
	
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
	public PagingBean findViewList(ElectInfoBean contentBean, String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ElectInfoBean> list = new ArrayList<ElectInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from (select");
		sql.append(" distinct(tt.elect_id),tt.start_time,to_char(tt.datetime,'yyyy-mm-dd') datetime,tt.orgid,tt.userid,tt.username,tt.start_ip ,tt.orgname,tt.end_time,tt.end_ip,tt.state,");
		sql.append(" decode((select count(t1.workip_id) ");
		sql.append(" from ta_oa_workip t1 ");
		sql.append(" where (fn_ipTonumber(tt.start_ip) between ");
		sql.append(" fn_ipTonumber(t1.workip_start_ip) and fn_ipTonumber(t1.workip_end_ip)) ");
		sql.append(" and  ((fn_ipTonumber(tt.end_ip) between  fn_ipTonumber(t1.workip_start_ip) and fn_ipTonumber(t1.workip_end_ip))  ");
		//追加判断下班IP如果为空 判断上班IP是否为办公IP
		sql.append("   or tt.end_ip is null )");
		sql.append(" ), '0','否','是' ) isWorkIP ");
		sql.append(" from sx_ta_oa_electcheck_info tt) t ");
		sql.append("where 1=1 ");
		if(!StringUtil.isBlank(contentBean.getOrgid())){
			/*sql.append("  and instr((select decode(to_char(wm_concat(o.org_id)),");
			sql.append("            '',");
			sql.append("         to_char(wm_concat(o.org_id)),");
			sql.append("         ',' || to_char(wm_concat(o.org_id))) ||");
			sql.append("   ',"+contentBean.getOrgid()+",'");
			sql.append("  from td_sm_organization o");
			sql.append("  where o.parent_id = '"+contentBean.getOrgid()+"'),'"+contentBean.getOrgid()+"')>0");*/
			String orgid = StringUtil.splitString(contentBean.getOrgid(), ",", "'");
			sql.append("  and t.ORGID in("+orgid+")");
		}
		if(contentBean != null) {
			if (!StringUtil.nullOrBlank(contentBean.getUserid())) {
				sql.append(" and t.userid = '"+contentBean.getUserid()+"'");
			}
			if (!StringUtil.nullOrBlank(contentBean.getState())) {
				sql.append(" and t.state like '%"+contentBean.getState()+"%'");
			}
			
			if (!StringUtil.nullOrBlank(contentBean.getStart_time())) {
				sql.append(" and to_date(t.datetime,'yyyy-mm-dd ')>=to_date('"+contentBean.getStart_time()+"','yyyy-mm-dd ')");

			}
			if (!StringUtil.nullOrBlank(contentBean.getEnd_time())) {
				sql.append(" and to_date(t.datetime,'yyyy-mm-dd ')<=to_date('").append(contentBean.getEnd_time() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");

			}
			if(!StringUtil.isBlank(contentBean.getDatetime())){
				sql.append(" and to_date(t.datetime,'yyyy-mm-dd ')=to_date('"+contentBean.getDatetime()+"','yyyy-mm-dd ')");
			}
			/*if("false".equals(contentBean.getRole())){*/
				if(!StringUtil.nullOrBlank(contentBean.getUsername())){
					sql.append(" and username like '%"+contentBean.getUsername()+"%'");
				}
			/*}*/
				
			if(!StringUtil.isBlank(contentBean.getIsWorkIP())){
				if ("1".equals(contentBean.getIsWorkIP())) {
					sql.append(" and t.isWorkIP = '是' ");
				}else if ("0".equals(contentBean.getIsWorkIP())){
					sql.append(" and t.isWorkIP = '否' ");
				}
			}	
		}          
		//sql.append(" order by orgname asc, elect_id desc ");
		sql.append(" order by " + sortName + " " + sortOrder +" ,elect_id desc ");

		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0;i < db.size();i++){

				ElectInfoBean ub = new ElectInfoBean();
				ub.setStart_time(db.getString(i, "start_time"));
				ub.setElect_id(db.getString(i, "elect_id"));
				ub.setDatetime(db.getString(i, "datetime"));
				ub.setStart_ip(db.getString(i,"start_ip"));
				ub.setOrgname(db.getString(i,"orgname"));
				ub.setEnd_ip(db.getString(i,"end_ip"));
				ub.setEnd_time(db.getString(i, "end_time"));
				ub.setUsername(db.getString(i,"username"));
				ub.setState(db.getString(i,"state"));
				ub.setIsWorkIP(db.getString(i,"isWorkIP"));
				list.add(ub);

			}	
		} catch (SQLException e) {
			LOG.error("执行列表查询报错："+e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	
	
}




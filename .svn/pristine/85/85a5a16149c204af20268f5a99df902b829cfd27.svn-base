package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsapPlanDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class OsapPlanDaoImpl implements OsapPlanDao{

	@Override
	public OsApplanBean getById(String tId,Connection conn) throws Exception {
		OsApplanBean bean = new OsApplanBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_id,");
		sql.append("       a.t_org_id,");
		sql.append("       a.t_org_name,");
		sql.append("       to_char(a.t_creator_time, 'yyyy-mm-dd') as t_creator_time,");
		sql.append("       a.t_title,");
		sql.append("       a.t_user_id,");
		sql.append("       a.t_user_name,");
		sql.append("       a.t_state");
		sql.append("  from ta_oa_osapplan a");
		sql.append("  where a.t_id = '"+tId+"'");
		
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		if(db.size()>0){
			bean.setT_id(StringUtil.deNull(db.getString(0, "t_id")));
			bean.setT_org_id(StringUtil.deNull(db.getString(0, "t_org_id")));
			bean.setT_org_name(StringUtil.deNull(db.getString(0, "t_org_name")));
			bean.setT_creator_time(StringUtil.deNull(db.getString(0, "t_creator_time")));
			bean.setT_title(StringUtil.deNull(db.getString(0, "t_title")));
			bean.setT_user_id(StringUtil.deNull(db.getString(0, "t_user_id")));
			bean.setT_user_name(StringUtil.deNull(db.getString(0, "t_user_name")));
			bean.setT_state(StringUtil.deNull(db.getString(0, "t_state")));
		}
		return bean;
	}

	@Override
	public boolean insertApplan(OsApplanBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_osapplan a (a.t_id,a.t_org_id,a.t_org_name,a.t_creator_time,a.t_title,a.t_user_id,a.t_user_name)");
		sql.append("values(?,?,?,to_date(?,'yyyy-MM-dd'),?,?,?)");
		
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getT_id());
		db.setString(2, bean.getT_org_id());
		db.setString(3, bean.getT_org_name());
		db.setString(4, bean.getT_creator_time());
		db.setString(5, bean.getT_title());
		db.setString(6, bean.getT_user_id());
		db.setString(7, bean.getT_user_name());
		db.executePrepared(conn);
		
		return true;
	}

	@Override
	public PagingBean getAppList(OsApplanBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OsApplanBean> list = new ArrayList<OsApplanBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_id,");
		sql.append("       a.t_org_name,");
		sql.append("       a.t_org_id,");
		sql.append("       to_char(a.t_creator_time, 'yyyy-MM-dd')  as t_creator_time,");
		sql.append("       a.t_title,");
		sql.append("       a.t_user_id,");
		sql.append("       a.t_user_name,");
		sql.append("       a.t_state");
		sql.append("       from ta_oa_osapplan a");
		sql.append("       where 1=1");
		if(!StringUtil.isBlank(bean.getT_state())){
			sql.append(" and a.t_state is null");
		}
		if(!StringUtil.isBlank(bean.getT_title())){
			sql.append(" and a.t_title like '%"+bean.getT_title()+"%'");
		}
		if(!StringUtil.isBlank(bean.getStart_time())){
			sql.append(" and a.t_creator_time >= to_date('"+bean.getStart_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getEnd_time())){
			sql.append(" and a.t_creator_time <= to_date('"+bean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getT_org_name())){
			sql.append(" and a.t_org_name like '%"+bean.getT_org_name()+"%'");
		}
		if(!StringUtil.isBlank(bean.getT_user_name())){
			sql.append(" and a.t_user_name like '%"+bean.getT_user_name()+"%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	if(db.size()>0){
    		for(int i=0;i<db.size();i++){
    			OsApplanBean appBean = new OsApplanBean();
    			appBean.setT_id(db.getString(i, "t_id"));
    			appBean.setT_org_id(db.getString(i, "t_org_id"));
    			appBean.setT_org_name(db.getString(i, "t_org_name"));
    			appBean.setT_creator_time(db.getString(i, "t_creator_time"));
    			appBean.setT_title(db.getString(i, "t_title"));
    			appBean.setT_user_id(db.getString(i, "t_user_id"));
    			appBean.setT_user_name(db.getString(i, "t_user_name"));
    			appBean.setT_state(db.getString(i, "t_state"));
    			list.add(appBean);
    		}
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public boolean changeState(OsApplanBean bean, Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ta_oa_osapplan set t_state = '1',");
		sql.append(" t_rkuser_id = ?,");
		sql.append(" t_rkuser_name = ?,");
		sql.append(" t_rkdate = to_date(?,'yyyy-MM-dd')");
		sql.append(" where t_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getT_rkuser_id());
		db.setString(2, bean.getT_rkuser_name());
		db.setString(3, bean.getT_rkdate());
		db.setString(4, bean.getT_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean changeItemState(OsAppObjectBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update TA_OA_OSAPP_OBJECT set IS_RK = '1',");
		sql.append(" RK_ID = ?,");
		sql.append(" RK_NAME = ?,");
		sql.append(" RK_DATE = to_date(?,'yyyy-MM-dd'),");
		sql.append(" ofustype_money = ?");
		sql.append(" where t_os_ob_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getRk_id());
		db.setString(2, bean.getRk_name());
		db.setString(3, bean.getRk_date());
		db.setString(4, bean.getOfustype_money());
		db.setString(5, bean.getT_os_ob_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public PagingBean getAppByUserID(OsApplanBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OsApplanBean> list = new ArrayList<OsApplanBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_id,");
		sql.append("       a.t_org_id,");
		sql.append("       a.t_org_name,");
		sql.append("       to_char(a.t_creator_time,'yyyy-MM-dd') as t_creator_time,");
		sql.append("       a.t_title,");
		sql.append("       a.t_user_id,");
		sql.append("       a.t_user_name");
		sql.append("  from ta_oa_osapplan a");
		sql.append("  where a.t_user_id = '"+bean.getT_user_id()+"'");
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	if(db.size()>0){
    		for(int i=0;i<db.size();i++){
    			OsApplanBean appBean = new OsApplanBean();
    			appBean.setT_id(db.getString(i, "t_id"));
    			appBean.setT_org_id(db.getString(i, "t_org_id"));
    			appBean.setT_org_name(db.getString(i, "t_org_name"));
    			appBean.setT_creator_time(db.getString(i, "t_creator_time"));
    			appBean.setT_title(db.getString(i, "t_title"));
    			appBean.setT_user_id(db.getString(i, "t_user_id"));
    			appBean.setT_user_name(db.getString(i, "t_user_name"));
    			list.add(appBean);
    		}
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}


}

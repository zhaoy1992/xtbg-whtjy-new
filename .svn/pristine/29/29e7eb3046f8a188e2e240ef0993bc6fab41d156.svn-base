package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegYhpDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class OsAppRegYhpDaoImpl implements OsAppRegYhpDao{

	@Override
	public PagingBean getAppList(OsAppRegYhpBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OsAppRegYhpBean> list = new ArrayList<OsAppRegYhpBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_appregyhp_id,");
		sql.append("       a.t_appregyhp_org_id,");
		sql.append("       a.t_appregyhp_org_name,");
		sql.append("       a.t_appregyhp_user_id,");
		sql.append("       a.t_appregyhp_user_name,");
		sql.append("	   to_char(a.t_appregyhp_date,'yyyy-MM-dd') as t_appregyhp_date,");
		sql.append("       a.t_appregyhp_appids,");
		sql.append("       a.t_appregyhp_title,");
		sql.append("       a.t_appregyhp_ckgly,");
		sql.append("       a.t_appregyhp_ischuku,");
		sql.append("       a.t_appregyhp_chuku_userid,");
		sql.append("       a.t_appregyhp_chuku_username,");
		sql.append("       to_char(a.t_appregyhp_chuku_date,'yyyy-MM-dd') as t_appregyhp_chuku_date");
		sql.append("  from ta_oa_osappregyhp a");
		sql.append(" where 1=1 and a.t_appregyhp_ckgly = '0'");
		if(!StringUtil.nullOrBlank(bean.getType())){
			sql.append("   and (a.t_appregyhp_ischuku is null or a.t_appregyhp_ischuku = '0')");
		}else{
			sql.append("   and a.t_appregyhp_ischuku = '1'");
		}
		if(!StringUtil.isBlank(bean.getT_appregyhp_title())){
			sql.append(" and a.t_appregyhp_title like '%"+bean.getT_appregyhp_title()+"%'");
		}
		if(!StringUtil.isBlank(bean.getStart_time())){
			sql.append(" and a.t_appregyhp_date >= to_date('"+bean.getStart_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getEnd_time())){
			sql.append(" and a.t_appregyhp_date <= to_date('"+bean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getT_appregyhp_org_name())){
			sql.append(" and a.t_appregyhp_org_name like '%"+bean.getT_appregyhp_org_name()+"%'");
		}
		if(!StringUtil.isBlank(bean.getT_appregyhp_user_name())){
			sql.append(" and a.t_appregyhp_user_name like '%"+bean.getT_appregyhp_user_name()+"%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	if(db.size()>0){
    		for(int i=0;i<db.size();i++){
    			OsAppRegYhpBean regBean = new OsAppRegYhpBean();
    			regBean.setT_appregyhp_id(db.getString(i, "t_appregyhp_id"));
    			regBean.setT_appregyhp_org_id(db.getString(i, "t_appregyhp_org_id"));
    			regBean.setT_appregyhp_org_name(db.getString(i, "t_appregyhp_org_name"));
    			regBean.setT_appregyhp_user_id(db.getString(i, "t_appregyhp_user_id"));
    			regBean.setT_appregyhp_user_name(db.getString(i, "t_appregyhp_user_name"));
    			regBean.setT_appregyhp_date(db.getString(i, "t_appregyhp_date"));
    			regBean.setT_appregyhp_appids(db.getString(i, "t_appregyhp_appids"));
    			regBean.setT_appregyhp_title(db.getString(i, "t_appregyhp_title"));
    			regBean.setT_appregyhp_ckgly(db.getString(i, "t_appregyhp_ckgly"));
    			regBean.setT_appregyhp_ischuku(db.getString(i, "t_appregyhp_ischuku"));
    			regBean.setT_appregyhp_chuku_userid(db.getString(i, "t_appregyhp_chuku_userid"));
    			regBean.setT_appregyhp_chuku_username(db.getString(i, "t_appregyhp_chuku_username"));
    			regBean.setT_appregyhp_chuku_date(db.getString(i, "t_appregyhp_chuku_date"));
    			list.add(regBean);
    		}
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public OsAppRegYhpBean getByID(String id,Connection conn) throws Exception{
		OsAppRegYhpBean regBean = new OsAppRegYhpBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_appregyhp_id,");
		sql.append("       a.t_appregyhp_org_id,");
		sql.append("       a.t_appregyhp_org_name,");
		sql.append("       a.t_appregyhp_user_id,");
		sql.append("       a.t_appregyhp_user_name,");
		sql.append("	   to_char(a.t_appregyhp_date,'yyyy-MM-dd') as t_appregyhp_date,");
		sql.append("       a.t_appregyhp_appids,");
		sql.append("       a.t_appregyhp_title,");
		sql.append("       a.t_appregyhp_ckgly,");
		sql.append("       a.t_appregyhp_ischuku,");
		sql.append("       a.t_appregyhp_chuku_userid,");
		sql.append("       a.t_appregyhp_chuku_username,");
		sql.append("       to_char(a.t_appregyhp_chuku_date,'yyyy-MM-dd') as t_appregyhp_chuku_date");
		sql.append("  from ta_oa_osappregyhp a where a.t_appregyhp_id = '"+id+"'");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		if(db.size()>0){
			regBean.setT_appregyhp_appids(db.getString(0, "t_appregyhp_id"));
			regBean.setT_appregyhp_org_id(db.getString(0, "t_appregyhp_org_id"));
			regBean.setT_appregyhp_org_name(db.getString(0, "t_appregyhp_org_name"));
			regBean.setT_appregyhp_user_id(db.getString(0, "t_appregyhp_user_id"));
			regBean.setT_appregyhp_user_name(db.getString(0, "t_appregyhp_user_name"));
			regBean.setT_appregyhp_date(db.getString(0, "t_appregyhp_date"));
			regBean.setT_appregyhp_appids(db.getString(0, "t_appregyhp_appids"));
			regBean.setT_appregyhp_title(db.getString(0, "t_appregyhp_title"));
			regBean.setT_appregyhp_ckgly(db.getString(0, "t_appregyhp_ckgly"));
			regBean.setT_appregyhp_ischuku(db.getString(0, "t_appregyhp_ischuku"));
			regBean.setT_appregyhp_chuku_userid(db.getString(0, "t_appregyhp_chuku_userid"));
			regBean.setT_appregyhp_chuku_username(db.getString(0, "t_appregyhp_chuku_username"));
			regBean.setT_appregyhp_chuku_date(db.getString(0, "t_appregyhp_chuku_date"));
		}
		return regBean;
	}

	@Override
	public boolean changeState(OsAppRegYhpBean bean,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ta_oa_osappregyhp set t_appregyhp_ischuku = '1',");
		sql.append(" t_appregyhp_chuku_userid = ?,");
		sql.append(" t_appregyhp_chuku_username = ?,");
		sql.append(" t_appregyhp_chuku_date = to_date(?,'yyyy-MM-dd')");
		sql.append(" where t_appregyhp_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1,bean.getT_appregyhp_chuku_userid());
		db.setString(2,bean.getT_appregyhp_chuku_username());
		db.setString(3,bean.getT_appregyhp_chuku_date());
		db.setString(4,bean.getT_appregyhp_id());
		db.executePrepared(conn);
		return true;
	}

}

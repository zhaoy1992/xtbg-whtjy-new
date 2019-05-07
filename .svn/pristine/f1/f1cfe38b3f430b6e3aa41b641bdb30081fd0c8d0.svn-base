package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppRegObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class OsAppRegObjectDaoImpl implements OsAppRegObjectDao{

	@Override
	public PagingBean getObjectList(OsAppRegObjectBean objectBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		List<OsAppRegObjectBean> list = new ArrayList<OsAppRegObjectBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select obj. t_osappreg_ob_id,");
		sql.append("       obj.t_appregyhp_id,");
		sql.append("       obj.oftype_id,");
		sql.append("       obj.oftype_name,");
		sql.append("       obj.ofustype_id,");
		sql.append("       obj.ofustype_name,");
		sql.append("       obj.it_id,");
		sql.append("       obj.it_name,");
		sql.append("       obj.t_osappreg_ob_no,");
		sql.append("       obj.t_osappreg_ob_bz,");
		sql.append("       obj.add_state,");
		sql.append("       obj.is_rk,");
		sql.append("       obj.rk_user_id,");
		sql.append("       obj.rk_user_name,");
		sql.append("       to_char(obj.rk_date,'yyyy-MM-dd') as rk_date");
		sql.append("  from TA_OA_OSAPPREG_OBJECT obj");
		sql.append(" where 1 = 1 and is_rk = '1'");
		if(!StringUtil.isBlank(objectBean.getStart_time())){
			sql.append(" and rk_date >= to_date('"+objectBean.getStart_time()+"','yyyy-MM-dd')");			
		}
		if(!StringUtil.isBlank(objectBean.getEnd_time())){
			sql.append(" and rk_date <= to_date('"+objectBean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(objectBean.getOfustype_name())){
			sql.append(" and ofustype_name like '%"+objectBean.getOfustype_name()+"%'");
		}
		//if(!StringUtil.isBlank(objectBean.getUnit_id())){
		//	sql.append(" and unit_id = '"+objectBean.getUnit_id()+"'");
		//}
		if(!StringUtil.isBlank(objectBean.getRk_user_name())){
			sql.append(" and rk_user_name like '%"+objectBean.getRk_user_name()+"%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	for(int i=0;i<db.size();i++){
    		OsAppRegObjectBean bean = new OsAppRegObjectBean();
    		bean.setT_osappreg_ob_id(db.getString(i, "t_osappreg_ob_id"));
    		bean.setT_appregyhp_id(db.getString(i, "t_appregyhp_id"));
    		bean.setOftype_id(db.getString(i, "oftype_id"));
    		bean.setOftype_name(db.getString(i, "oftype_name"));
    		bean.setOfustype_id(db.getString(i, "ofustype_id"));
    		bean.setOfustype_name(db.getString(i, "ofustype_name"));
    		bean.setIt_id(db.getString(i, "it_id"));
    		bean.setIt_name(db.getString(i, "it_name"));
    		bean.setT_osappreg_ob_no(db.getString(i, "t_osappreg_ob_no"));
    		bean.setT_osappreg_ob_bz(db.getString(i, "t_osappreg_ob_bz"));
    		bean.setAdd_state(db.getString(i, "add_state"));
    		bean.setIs_rk(db.getString(i, "is_rk"));
    		bean.setRk_user_id(db.getString(i, "rk_user_id"));
    		bean.setRk_user_name(db.getString(i, "rk_user_name"));
    		bean.setRk_date(db.getString(i, "rk_date"));
    		list.add(bean);
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public boolean changeItem(OsAppRegYhpBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ta_oa_osappreg_object set is_rk = '1',");
		sql.append(" rk_user_id = ?,");
		sql.append(" rk_user_name = ?,");
		sql.append(" rk_date = to_date(?,'yyyy-MM-dd')");
		sql.append(" where t_appregyhp_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1,bean.getT_appregyhp_chuku_userid());
		db.setString(2,bean.getT_appregyhp_chuku_username());
		db.setString(3,bean.getT_appregyhp_chuku_date());
		db.setString(4,bean.getT_appregyhp_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public PagingBean getMyObjectList(OsAppRegObjectBean objectBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OsAppRegObjectBean> list = new ArrayList<OsAppRegObjectBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_osappreg_ob_id,");
		sql.append("       a.t_appregyhp_id,");
		sql.append("       a.oftype_id,");
		sql.append("       a.oftype_name,");
		sql.append("       a.ofustype_id,");
		sql.append("       a.ofustype_name,");
		sql.append("       a.it_id,");
		sql.append("       a.it_name,");
		sql.append("       a.t_osappreg_ob_no,");
		sql.append("       a.t_osappreg_ob_bz,");
		sql.append("       to_char(b.t_appregyhp_date,'yyyy-MM-dd') as t_appregyhp_date,");
		sql.append("       b.t_appregyhp_user_id,");
		sql.append("       b.t_appregyhp_user_name");
		sql.append("  from ta_oa_osappreg_object a");
		sql.append("  left join ta_oa_osappregyhp b");
		sql.append("    on a.t_appregyhp_id = b.t_appregyhp_id");
		sql.append(" where 1=1");
		if(!StringUtil.isBlank(objectBean.getT_appregyhp_user_id())){
			sql.append(" and b.t_appregyhp_user_id = '"+objectBean.getT_appregyhp_user_id()+"'");
		}
		if(!StringUtil.isBlank(objectBean.getOfustype_name())){
			sql.append(" and a.ofustype_name like '%"+objectBean.getOfustype_name()+"%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	for(int i=0;i<db.size();i++){
    		OsAppRegObjectBean bean = new OsAppRegObjectBean();
    		bean.setT_osappreg_ob_id(db.getString(i, "t_osappreg_ob_id"));
    		bean.setT_appregyhp_id(db.getString(i, "t_appregyhp_id"));
    		bean.setOftype_id(db.getString(i, "oftype_id"));
    		bean.setOftype_name(db.getString(i, "oftype_name"));
    		bean.setOfustype_id(db.getString(i, "ofustype_id"));
    		bean.setOfustype_name(db.getString(i, "ofustype_name"));
    		bean.setIt_id(db.getString(i, "it_id"));
    		bean.setIt_name(db.getString(i, "it_name"));
    		bean.setT_osappreg_ob_no(db.getString(i, "t_osappreg_ob_no"));
    		bean.setT_osappreg_ob_bz(db.getString(i, "t_osappreg_ob_bz"));
    		bean.setT_appregyhp_date(db.getString(i, "t_appregyhp_date"));
    		bean.setT_appregyhp_user_id(db.getString(i, "t_appregyhp_user_id"));
    		bean.setT_appregyhp_user_name(db.getString(i, "t_appregyhp_user_name"));
    		list.add(bean);
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean getListByOrg(OsAppRegObjectBean objectBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OsAppRegObjectBean> list = new ArrayList<OsAppRegObjectBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct oftype_id,");
		sql.append("                oftype_name,");
		sql.append("                ofustype_id,");
		sql.append("                ofustype_name,");
		sql.append("                it_id,");
		sql.append("                it_name,");
		sql.append("				org_name");
		sql.append("  from TA_OA_OSAPPREG_OBJECT");
		sql.append(" where it_id in (");
		sql.append("                 select a.it_id");
		sql.append("                   from TA_OA_OSAPPREG_OBJECT a");
		sql.append("                   left join ta_oa_osappregyhp c");
		sql.append("                     on a.t_appregyhp_id = c.t_appregyhp_id");
		sql.append("                  where a.org_id = '"+objectBean.getOrg_id()+"'");
		sql.append("                    and a.is_rk = '1'");
		if(!StringUtil.isBlank(objectBean.getStart_time())){
			sql.append(" and c.t_appregyhp_date >= to_date('"+objectBean.getStart_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(objectBean.getEnd_time())){
			sql.append(" and c.t_appregyhp_date <= to_date('"+objectBean.getEnd_time()+"','yyyy-MM-dd')");
		}
		sql.append("                  group by a.it_id)");
		if(!StringUtil.isBlank(sortOrder)&&!StringUtil.isBlank(sortName)){
			sql.append(" order by " + sortName + " " + sortOrder);		
		}
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
    	for(int i=0;i<db.size();i++){
    		OsAppRegObjectBean bean = new OsAppRegObjectBean();
    		bean.setOftype_id(db.getString(i, "oftype_id"));
    		bean.setOftype_name(db.getString(i, "oftype_name"));
    		bean.setOfustype_id(db.getString(i, "ofustype_id"));
    		bean.setOfustype_name(db.getString(i, "ofustype_name"));
    		bean.setIt_id(db.getString(i, "it_id"));
    		bean.setIt_name(db.getString(i, "it_name"));
    		bean.setOrg_name(db.getString(i, "org_name"));
    		String sum_sql = "select sum(b.t_osappreg_ob_no) from TA_OA_OSAPPREG_OBJECT b left join ta_oa_osappregyhp c on b.t_appregyhp_id = c.t_appregyhp_id";
    		sum_sql = sum_sql + " where b.org_id = '"+objectBean.getOrg_id()+"' and b.is_rk = '1'and b.it_id = '"+db.getString(i, "it_id")+"'";
    		if(!StringUtil.isBlank(objectBean.getStart_time())){
    			sql.append(" and c.t_appregyhp_date >= to_date('"+objectBean.getStart_time()+"','yyyy-MM-dd')");
    		}
    		if(!StringUtil.isBlank(objectBean.getEnd_time())){
    			sql.append(" and c.t_appregyhp_date <= to_date('"+objectBean.getEnd_time()+"','yyyy-MM-dd')");
    		}
    		String sum = DaoUtil.sqlToField(sum_sql);
    		bean.setT_osappreg_ob_no(sum);
    		list.add(bean);
    	}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

}

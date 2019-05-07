package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.python.modules.newmodule;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:OsAppObjectDaoImpl.java</p>
 *<p>Description: 处理添加入计划表的物品数据DAO层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public class OsAppObjectDaoImpl extends XtDbBaseDao implements OsAppObjectDao {

	/**
	 * 
	  * <b>Summary: 根据计划表id查询出物品列表</b>
	  *     复写方法 selectOsAppObject
	  * @param t_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao#selectOsAppObject(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.t_os_ob_id,a.t_id,a.t_org_id,a.t_org_name,a.ofustype_id,a.ofustype_name,");
		sql.append(" a.it_id,a.it_name,a.t_os_ob_no,a.t_os_ob_bz,a.unit_id,a.unit_name,a.type_id,");
		sql.append(" a.type,a.p_type_id,a.p_type,decode(a.is_rk,'0','未入库','已入库') as is_rk,");
		sql.append(" a.rk_id,a.rk_name,a.ofustype_money,to_char(a.rk_date,'yyyy-MM-dd') as rk_date from TA_OA_OSAPP_OBJECT a");
		sql.append(" where a.t_id = ? ");
		viewMap = queryToListMap(sql.toString(), t_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: 根据计划表id删除物品</b>
	  *     复写方法 deleteOsAppObject
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao#deleteOsAppObject(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteOsAppObject(String t_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_OSAPP_OBJECT ");
		sql.append(" where T_ID in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, t_id);
		pdb.executePrepared(conn);
		return true;
	}

	@Override
	public PagingBean getObjectList(OsAppObjectBean objectBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		List<OsAppObjectBean> list = new ArrayList<OsAppObjectBean>();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("  select a.t_os_ob_id,");
		sql.append("         a.t_id,a.type_id,a.type,a.ofustype_id,a.ofustype_name,a.it_id,a.it_name,");
		sql.append("         a.t_os_ob_no,a.t_os_ob_bz,a.t_org_id,a.t_org_name,a.unit_id,a.unit_name,a.is_rk,");
		sql.append("         a.rk_id,a.rk_name,to_char(a.rk_date,'yyyy-MM-dd') as rk_date,a.ofustype_money ");
		sql.append("    from ta_oa_osapp_object a where 1 = 1 and a.is_rk = '1'");
		if(!StringUtil.isBlank(objectBean.getStart_time())){
			sql.append(" and rk_date >= to_date('"+objectBean.getStart_time()+"','yyyy-MM-dd')");			
		}
		if(!StringUtil.isBlank(objectBean.getEnd_time())){
			sql.append(" and rk_date <= to_date('"+objectBean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(objectBean.getOfustype_name())){
			sql.append(" and ofustype_name like '%"+objectBean.getOfustype_name()+"%'");
		}
		if(!StringUtil.isBlank(objectBean.getUnit_id())){
			sql.append(" and unit_id = '"+objectBean.getUnit_id()+"'");
		}
		if(!StringUtil.isBlank(objectBean.getRk_name())){
			sql.append(" and rk_name like '%"+objectBean.getRk_name()+"%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsAppObjectBean bean = new OsAppObjectBean();
			bean.setT_os_ob_id(StringUtil.deNull(db.getString(i, "t_os_ob_id")));
			bean.setT_id(StringUtil.deNull(db.getString(i, "t_id")));
			bean.setType_id(StringUtil.deNull(db.getString(i, "type_id")));
			bean.setType(StringUtil.deNull(db.getString(i, "type")));
			bean.setOfustype_id(StringUtil.deNull(db.getString(i, "ofustype_id")));
			bean.setOfustype_name(StringUtil.deNull(db.getString(i, "ofustype_name")));
			bean.setIt_id(StringUtil.deNull(db.getString(i, "it_id")));
			bean.setIt_name(StringUtil.deNull(db.getString(i, "it_name")));
			bean.setT_os_ob_no(StringUtil.deNull(db.getString(i, "t_os_ob_no")));
			bean.setT_os_ob_bz(StringUtil.deNull(db.getString(i, "t_os_ob_bz")));
			bean.setT_org_id(StringUtil.deNull(db.getString(i, "t_org_id")));
			bean.setT_org_name(StringUtil.deNull(db.getString(i, "t_org_name")));
			bean.setUnit_id(StringUtil.deNull(db.getString(i, "unit_id")));
			bean.setUnit_name(StringUtil.deNull(db.getString(i, "unit_name")));
			bean.setIs_rk(StringUtil.deNull(db.getString(i, "is_rk")));
			bean.setRk_id(StringUtil.deNull(db.getString(i, "rk_id")));
			bean.setRk_name(StringUtil.deNull(db.getString(i, "rk_name")));
			bean.setRk_date(StringUtil.deNull(db.getString(i, "rk_date")));
			bean.setOfustype_money(StringUtil.deNull(db.getString(i, "ofustype_money")));
			list.add(bean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public OsAppObjectBean getCountData(OsAppObjectBean bean,Connection conn) throws Exception {
		OsAppObjectBean objectBean = new OsAppObjectBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select sum(a.t_os_ob_no) as t_os_ob_no,sum(a.t_os_ob_no*a.ofustype_money) as ofustype_money");
		sql.append("    from ta_oa_osapp_object a  where 1 = 1 and a.is_rk = '1'");
		if(!StringUtil.isBlank(bean.getStart_time())){
			sql.append(" and rk_date >= to_date('"+bean.getStart_time()+"','yyyy-MM-dd')");			
		}
		if(!StringUtil.isBlank(bean.getEnd_time())){
			sql.append(" and rk_date <= to_date('"+bean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getOfustype_name())){
			sql.append(" and ofustype_name like '%"+bean.getOfustype_name()+"%'");
		}
		if(!StringUtil.isBlank(bean.getUnit_id())){
			sql.append(" and unit_id = '"+bean.getUnit_id()+"'");
		}
		if(!StringUtil.isBlank(bean.getRk_name())){
			sql.append(" and rk_name like '%"+bean.getRk_name()+"%'");
		}
    	db.preparedSelect(sql.toString());
    	db.executePrepared(conn);
    	if(db.size()>0){
    		if(!StringUtil.isBlank(db.getString(0, "t_os_ob_no"))){
    			objectBean.setT_os_ob_no(db.getString(0, "t_os_ob_no"));
    		}else{
    			objectBean.setT_os_ob_no("0");
    		}
    		if(!StringUtil.isBlank(db.getString(0, "ofustype_money"))){
        		objectBean.setOfustype_money(db.getString(0, "ofustype_money"));
    		}else{
    			objectBean.setOfustype_money("0");
    		}

    	}
		return objectBean;
	}

	@Override
	public List<Map<String, String>> getItemByID(String ids, Connection conn)
			throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		PreparedDBUtil pb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		ids = StringUtil.splitString(ids, ",", "'");
		sql.append("select a.t_os_ob_id,a.t_id,a.t_org_id,a.t_org_name,a.ofustype_id,a.ofustype_name,");
		sql.append(" a.it_id,a.it_name,a.t_os_ob_no,a.t_os_ob_bz,a.unit_id,a.unit_name,a.type_id,");
		sql.append(" a.type,a.p_type_id,a.p_type,decode(a.is_rk,'0','未入库','已入库') as is_rk,");
		sql.append(" a.rk_id,a.rk_name,a.ofustype_money,to_char(a.rk_date,'yyyy-MM-dd') as rk_date from TA_OA_OSAPP_OBJECT a");
		sql.append(" where a.t_id in (" +ids+")  ");
		pb.preparedSelect(sql.toString());
		pb.executePrepared();
		
		for (int i = 0; i < pb.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("t_os_ob_id", pb.getString(i, "t_os_ob_id"));
			map.put("t_id", pb.getString(i, "t_id"));
			map.put("t_org_id", pb.getString(i, "t_org_id"));
			map.put("t_org_name", pb.getString(i, "t_org_name"));
			map.put("ofustype_id", pb.getString(i, "ofustype_id"));
			map.put("ofustype_name", pb.getString(i, "ofustype_name"));
			map.put("it_id", pb.getString(i, "it_id"));
			map.put("it_name", pb.getString(i, "it_name"));
			map.put("t_os_ob_no", pb.getString(i, "t_os_ob_no"));
			map.put("t_os_ob_bz", pb.getString(i, "t_os_ob_bz"));
			map.put("unit_id", pb.getString(i, "unit_id"));
			map.put("unit_name", pb.getString(i, "unit_name"));
			map.put("type_id", pb.getString(i, "type_id"));
			map.put("type", pb.getString(i, "type"));
			map.put("p_type_id", pb.getString(i, "p_type_id"));
			map.put("p_type", pb.getString(i, "p_type"));
			list.add(map);
		}
		return list;
	}

	@Override
	public OsAppObjectBean getCount(OsAppObjectBean bean, Connection conn)
			throws Exception {
		OsAppObjectBean objectBean = new OsAppObjectBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select sum(a.t_osappreg_ob_no) as t_os_ob_no");
		sql.append("    from TA_OA_OSAPPREG_OBJECT a  where 1 = 1 and a.is_rk = '1'");
		if(!StringUtil.isBlank(bean.getStart_time())){
			sql.append(" and rk_date >= to_date('"+bean.getStart_time()+"','yyyy-MM-dd')");			
		}
		if(!StringUtil.isBlank(bean.getEnd_time())){
			sql.append(" and rk_date <= to_date('"+bean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.isBlank(bean.getOfustype_name())){
			sql.append(" and ofustype_name like '%"+bean.getOfustype_name()+"%'");
		}
		if(!StringUtil.isBlank(bean.getRk_name())){
			sql.append(" and rk_name like '%"+bean.getRk_name()+"%'");
		}
    	db.preparedSelect(sql.toString());
    	db.executePrepared(conn);
    	if(db.size()>0){
    		if(!StringUtil.isBlank(db.getString(0, "t_os_ob_no"))){
    			objectBean.setT_os_ob_no(db.getString(0, "t_os_ob_no"));
    		}else{
    			objectBean.setT_os_ob_no("0");
    		}
    	}
		return objectBean;
	}

}

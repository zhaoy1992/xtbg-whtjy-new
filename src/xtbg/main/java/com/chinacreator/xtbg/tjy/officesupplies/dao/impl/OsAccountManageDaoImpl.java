package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountManageDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountDetails;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 固定资产管理使用接口实现
 * @author 王淑滨
 *
 */
public class OsAccountManageDaoImpl extends XtDbBaseDao implements OsAccountManageDao{

	@Override
	public PagingBean getAccountManageList(OsAccountManagerBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<String> value = new ArrayList<String>();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		sql.append("select a.m_id,");
		sql.append("       a.m_type,");
		sql.append("       to_char(a.use_date, 'yyyy-MM-dd') as use_date,");
		sql.append("       a.user_id,");
		sql.append("       a.user_name,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.register_user_id,");
		sql.append("       a.register_user_name,");
		sql.append("       to_char(a.register_date,'yyyy-MM-dd') as register_date,");
		sql.append("       decode(a.gdzc_classify,'1','办公设备类','2','仪器设备类','3','土地房屋类','4','电器类','5','公用物资类','6','家具类','7','车辆类',a.gdzc_classify) as gdzc_classify");
		sql.append("  from ta_oa_whtjy_gdzc_manager a");
		sql.append(" where 1 = 1");
		if(!StringUtil.nullOrBlank(bean.getRegister_user_id())){
			sql.append("   and a.register_user_id = '"+bean.getRegister_user_id()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getM_type())){
			sql.append("   and a.m_type = '"+bean.getM_type()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getUser_name())){
			sql.append("   and a.user_name like '%"+bean.getUser_name()+"%'");
		}
		if(!StringUtil.nullOrBlank(bean.getGdzc_classify())){
			sql.append("   and a.gdzc_classify = '"+bean.getGdzc_classify()+"'");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
		db.preparedSelect(sql.toString(),offset, maxPagesize);
		db.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, value);
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	@Override
	public boolean insertManager(OsAccountManagerBean bean, Connection conn) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_whtjy_gdzc_manager a");
		sql.append("  (a.m_id,a.m_type,a.use_date,a.user_id,a.user_name,");
		sql.append("   a.org_id,a.org_name,a.register_user_id,");
		sql.append("   a.register_user_name,a.register_date,a.gdzc_classify)");
		sql.append("values");
		sql.append("  (?,?,to_date(?,'yyyy-MM-dd'),?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'),?)");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getM_id());
		db.setString(2, bean.getM_type());
		db.setString(3, bean.getUse_date());
		db.setString(4, bean.getUser_id());
		db.setString(5, bean.getUser_name());
		db.setString(6, bean.getOrg_id());
		db.setString(7, bean.getOrg_name());
		db.setString(8, bean.getRegister_user_id());
		db.setString(9, bean.getRegister_user_name());
		db.setString(10, bean.getRegister_date());
		db.setString(11, bean.getGdzc_classify());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public OsAccountManagerBean getByID(String id, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		OsAccountManagerBean bean = new OsAccountManagerBean();
		sql.append("select a.m_id,");
		sql.append("       a.m_type,");
		sql.append("       to_char(a.use_date, 'yyyy-MM-dd') as use_date,");
		sql.append("       a.user_id,");
		sql.append("       a.user_name,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.register_user_id,");
		sql.append("       a.register_user_name,");
		sql.append("       to_char(a.register_date) as register_date,");
		sql.append("       a.gdzc_classify");
		sql.append("  from ta_oa_whtjy_gdzc_manager a");
		sql.append(" where a.m_id = '"+id+"'");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		if(db.size()>0){
			bean.setM_id(db.getString(0, "m_id"));
			bean.setM_type(db.getString(0, "m_type"));
			bean.setUse_date(db.getString(0, "use_date"));
			bean.setUser_id(db.getString(0, "user_id"));
			bean.setUser_name(db.getString(0, "user_name"));
			bean.setOrg_id(db.getString(0, "org_id"));
			bean.setOrg_name(db.getString(0, "org_name"));
			bean.setRegister_user_id(db.getString(0, "register_user_id"));
			bean.setRegister_user_name(db.getString(0, "register_user_name"));
			bean.setRegister_date(db.getString(0, "register_date"));
			bean.setGdzc_classify(db.getString(0, "gdzc_classify"));
		}
		return bean;
	}

	@Override
	public List<Map<String, String>> getByMid(String id, Connection conn)throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.id,a.m_id,a.internal_no,");
		sql.append("       a.gdzc_num,a.gdzc_id,a.gdzc_name,");
		sql.append("       a.bar_code,a.body_no,a.state");
		sql.append("  from ta_oa_whtjy_gdzc_details a");
		sql.append(" where a.m_id = ?");
		list = queryToListMap(sql.toString(), id);
		return list;
	}

	@Override
	public boolean insertManagerDetails(OsAccountDetails bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_whtjy_gdzc_details a");
		sql.append("(a.id,a.m_id,a.internal_no,a.gdzc_num,a.gdzc_id,a.gdzc_name,a.bar_code,a.body_no,a.state)");
		sql.append("values(?,?,?,?,?,?,?,?,?)");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getId());
		db.setString(2, bean.getM_id());
		db.setString(3, bean.getInternal_no());
		db.setString(4, bean.getGdzc_num());
		db.setString(5, bean.getGdzc_id());
		db.setString(6, bean.getGdzc_name());
		db.setString(7, bean.getBar_code());
		db.setString(8, bean.getBody_no());
		db.setString(9, bean.getState());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean deleteManagerDetails(String mId, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from ta_oa_whtjy_gdzc_details  where m_id in ?");
		db.preparedDelete(sql.toString());
		db.setString(1, mId);
		db.executePrepared(conn);
		return true;
	}

}

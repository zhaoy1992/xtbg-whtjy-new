package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsKucunDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class OsKucunDaoImpl extends XtDbBaseDao implements OsKucunDao{

	@Override
	public Map<String, String> getByID(String t_ha_id,Connection conn) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.t_ha_id,b.oftype_id,b.oftype_name,b.ofustype_id,");
		sql.append(" b.ofustype_name,b.it_id,b.it_name,b.t_ha_dj,b.t_ha_no,");
		sql.append(" decode(b.t_ha_sbstate,'1','在库','2','领用 ','3','在修','4','报废')t_ha_sbstate,");
		sql.append(" b.t_ha_bz,b.t_ha_rkuser_id,b.t_ha_rkuser_name,");
		sql.append(" to_char(b.t_ha_rkuser_date,'yyyy-MM-dd')as t_ha_rkuser_date,");
		sql.append(" b.t_ha_org_id,b.t_ha_org_name,b.unit_id,b.unit_name,b.ofustype_no");
		sql.append(" from TA_OA_HAVA_OBJECT b where b.t_ha_id = ?");
		map = queryToSingleMap(conn, sql.toString(),t_ha_id);
		return map;
	}

	@Override
	public boolean insert(OsHavaObjectBean bean,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into TA_OA_HAVA_OBJECT a");
		sql.append(" (a.t_ha_id,a.oftype_id,a.oftype_name,a.ofustype_id,a.ofustype_name,a.it_id,");
		sql.append(" a.it_name,a.t_ha_no,a.t_ha_bz,a.t_ha_rkuser_id,a.t_ha_rkuser_name,a.t_ha_org_id,");
		sql.append(" a.t_ha_org_name,a.unit_id,a.unit_name,a.ofustype_no,a.t_ha_rkuser_date)");
		sql.append(" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'))");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getT_ha_id());
		db.setString(2, bean.getOftype_id());
		db.setString(3, bean.getOftype_name());
		db.setString(4, bean.getOfustype_id());
		db.setString(5, bean.getOfustype_name());
		db.setString(6, bean.getIt_id());
		db.setString(7, bean.getIt_name());
		db.setString(8, bean.getT_ha_no());
		db.setString(9, bean.getT_ha_bz());
		db.setString(10, bean.getT_ha_rkuser_id());
		db.setString(11, bean.getT_ha_rkuser_name());
		db.setString(12, bean.getT_ha_org_id());
		db.setString(13, bean.getT_ha_org_name());
		db.setString(14, bean.getUnit_id());
		db.setString(15, bean.getUnit_name());
		db.setInt(16, bean.getOfustype_no());
		db.setString(17, bean.getT_ha_rkuser_date());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean update(OsHavaObjectBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update TA_OA_HAVA_OBJECT a");
		sql.append("   set a.t_ha_id          = ?,");
		sql.append("       a.oftype_id        = ?,");
		sql.append("       a.oftype_name      = ?,");
		sql.append("       a.ofustype_id      = ?,");
		sql.append("       a.ofustype_name    = ?,");
		sql.append("       a.it_id            = ?,");
		sql.append("       a.it_name          = ?,");
		sql.append("       a.t_ha_no          = ?,");
		sql.append("       a.t_ha_rkuser_id   = ?,");
		sql.append("       a.t_ha_rkuser_name = ?,");
		sql.append("       a.t_ha_rkuser_date = to_date(?, 'yyyy-MM-dd'),");
		sql.append("       a.unit_id          = ?,");
		sql.append("       a.unit_name        = ?,");
		sql.append("       a.ofustype_no      = ?");
		sql.append(" where a.t_ha_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getT_ha_id());
		db.setString(2, bean.getOftype_id());
		db.setString(3, bean.getOftype_name());
		db.setString(4, bean.getOfustype_id());
		db.setString(5, bean.getOfustype_name());
		db.setString(6, bean.getIt_id());
		db.setString(7, bean.getIt_name());
		db.setString(8, bean.getT_ha_no());
		db.setString(9, bean.getT_ha_rkuser_id());
		db.setString(10, bean.getT_ha_rkuser_name());
		db.setString(11, bean.getT_ha_rkuser_date());
		db.setString(12, bean.getUnit_id());
		db.setString(13, bean.getUnit_name());
		db.setInt(14, bean.getOfustype_no());
		db.setString(15, bean.getT_ha_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean updateNo(OsHavaObjectBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update TA_OA_HAVA_OBJECT set T_HA_RKUSER_ID = ?,");
		sql.append(" T_HA_RKUSER_NAME = ?,T_HA_RKUSER_DATE = to_date(?,'yyyy-MM-dd'),");
		sql.append(" T_HA_NO = T_HA_NO + ?");
		sql.append(" where IT_ID = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getT_ha_rkuser_id());
		db.setString(2, bean.getT_ha_rkuser_name());
		db.setString(3, bean.getT_ha_rkuser_date());
		db.setString(4, bean.getT_ha_no());
		db.setString(5, bean.getIt_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean updateNumber(Map<String, String> map, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update TA_OA_HAVA_OBJECT set T_HA_RKUSER_ID = ?,");
		sql.append(" T_HA_RKUSER_NAME = ?,T_HA_RKUSER_DATE = to_date(?,'yyyy-MM-dd'),");
		sql.append(" T_HA_NO = T_HA_NO - ?");
		sql.append(" where IT_ID = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, map.get("t_ha_rkuser_id"));
		db.setString(2, map.get("t_ha_rkuser_name"));
		db.setString(3, map.get("t_ha_rkuser_date"));
		db.setString(4, map.get("t_osappreg_ob_no"));
		db.setString(5, map.get("it_id"));
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean delete(String ids,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from TA_OA_HAVA_OBJECT where t_ha_id in ("+ids+")");
		db.preparedDelete(sql.toString());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean deleteByItem(String id, Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from TA_OA_HAVA_OBJECT where ofustype_id = '"+id+"' and it_id is null");
		db.preparedDelete(sql.toString());
		db.executePrepared(conn);
		return true;
	}

}

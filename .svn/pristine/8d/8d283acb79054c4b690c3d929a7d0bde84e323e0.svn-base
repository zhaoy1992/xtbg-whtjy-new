package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevIssuedDetailsDao;
import com.chinacreator.xtbg.tjy.device.entity.DevIssuedDetailsBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 核验计划核验设备清单dao实现
 * @author 王淑滨
 *
 */
public class DevIssuedDetailsDaoImp extends XtDbBaseDao implements DevIssuedDetailsDao{

	@Override
	public boolean delete(String planId, Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devissuedplan_detail ");
		sql.append(" where plan_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, planId);
		pdb.executePrepared(conn);
		return true;
	}

	@Override
	public boolean insert(DevIssuedDetailsBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_devissuedplan_detail a (a.id,a.plan_id,a.sb_id,a.last_date)");
		sql.append("values(?,?,?,to_date(?,'yyyy-MM-dd'))");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getId());
		db.setString(2, bean.getPlan_id());
		db.setString(3, bean.getSb_id());
		db.setString(4, bean.getLast_date());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public List<Map<String, String>> getByPlanID(String id, Connection conn)
			throws Exception {
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		List<String> values = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.id,");
		sql.append("       a.plan_id,");
		sql.append("       a.sb_id,");
		sql.append("       b.internal_no,");
		sql.append("       b.name,");
		sql.append("       b.it,");
		sql.append("       b.manufacturer,");
		sql.append("       b.body_no,");
		sql.append("       b.bar_code,");
		sql.append("       to_char(a.last_date, 'yyyy-MM-dd') as last_date");
		sql.append("  from ta_oa_devissuedplan_detail a");
		sql.append("  left join ta_oa_whtjy_gdzc b");
		sql.append("    on a.sb_id = b.id");
		sql.append(" where a.plan_id = '"+id+"'");
		list = queryToListMap(sql.toString(), conn, values);
		return list;
	}

}

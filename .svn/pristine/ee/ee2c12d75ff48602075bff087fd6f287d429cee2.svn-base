package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountHistoryDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 固定资产使用历史
 * @author 王淑滨
 *
 */
public class OsAccountHistoryDaoImpl extends XtDbBaseDao implements OsAccountHistoryDao{

	@Override
	public PagingBean getAccountHistoryList(OsAccountHistoryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<String> value = new ArrayList<String>();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		sql.append("select a.id,");
		sql.append("       a.gdzc_id,");
		sql.append("       a.gdzc_name,");
		sql.append("       a.user_id,");
		sql.append("       a.user_name,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.use_type,");
		sql.append("       to_char(a.user_date, 'yyyy-MM-dd') as user_date,");
		sql.append("       a.ghdj_id");
		sql.append("  from ta_oa_whtjy_gdzc_history a");
		sql.append("  where 1 = 1");
		if(!StringUtil.nullOrBlank(bean.getGdzc_id())){
			sql.append("   and a.gdzc_id = '"+bean.getGdzc_id()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getUser_name())){
			sql.append("   and a.user_name like '%"+bean.getUser_name()+"%'");
		}
		//分院才进来 实现本部分院隔离
		if(!StringUtil.nullOrBlank(bean.getOrg_id())){
			sql.append("   and a.org_id = '"+bean.getOrg_id()+"'");
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
	public boolean insertAccountHistory(OsAccountHistoryBean bean,
			Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_whtjy_gdzc_history a ");
		sql.append("(a.id,a.gdzc_id,a.gdzc_name,a.user_id,a.user_name,a.org_id,a.org_name,a.use_type,a.user_date,a.ghdj_id)");
		sql.append("  values(?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'),?)");
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getId());
		db.setString(2, bean.getGdzc_id());
		db.setString(3, bean.getGdzc_name());
		db.setString(4, bean.getUser_id());
		db.setString(5, bean.getUser_name());
		db.setString(6, bean.getOrg_id());
		db.setString(7, bean.getOrg_name());
		db.setString(8, bean.getUse_type());
		db.setString(9, bean.getUser_date());
		db.setString(10, bean.getGhdj_id());
		db.executePrepared(conn);
		return true;
	}

}

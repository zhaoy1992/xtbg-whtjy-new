package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.core.archive.dao.BudgetFileDao;
import com.chinacreator.xtbg.core.archive.entity.BudgetFileBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:BudgetFileDaoImpl.java</p>
 *<p>Description:指标文拆分-指标文总信息Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public class BudgetFileDaoImpl implements BudgetFileDao {

	@Override
	public void insert(BudgetFileBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_budget_file");
		sql.append("  (id, file_code, bus_id, file_name, amount, branch_id, user_id, op_date, status,annual ) ");
		sql.append(" values");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), ? , ?)");
		SqlUtil<BudgetFileBean> sqlUtil = new SqlUtil<BudgetFileBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public PagingBean list(BudgetFileBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select f.id,");
		sql.append("       f.file_code,");
		sql.append("       f.bus_id,");
		sql.append("       ins.ins_name ins_name,");
		sql.append("       f.file_name,");
		sql.append("       f.amount,");
		sql.append("       f.branch_id,");
		sql.append("       o.org_name,");
		sql.append("       f.user_id,");
		sql.append("       u.user_realname user_name,");
		sql.append("       to_char(f.op_date,'yyyy-mm-dd hh24:mi:ss') op_date,");
		sql.append("       f.status");
		sql.append("  from oa_budget_file f");
		sql.append("  left join oa_flow_instance ins on f.bus_id = ins.ins_id");
		sql.append("  left join td_sm_user u on f.user_id = u.user_id");
		sql.append("  left join td_sm_organization o on f.branch_id = o.org_id");
		if(!StringUtil.isBlank(bean.getIns_name())){
			sql.append(" where ins.ins_name like ?");
			bean.setIns_name("%"+bean.getIns_name()+"%");
		}
		SqlUtil<BudgetFileBean> sqlUtil = new SqlUtil<BudgetFileBean>();
		PagingBean pageBean = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pageBean;
	}

	@Override
	public void update(BudgetFileBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("update oa_budget_file");
		sql.append("   set ");
		sql.append("       file_code = ?,");
		sql.append("       bus_id = ?,");
		sql.append("       file_name = ?,");
		sql.append("       amount = ?,");
		sql.append("       branch_id = ?,");
		sql.append("       user_id = ?,");
		sql.append("       op_date = to_date(?,'yyyy-mm-dd hh24:mi:ss'),");
		sql.append("       status = ?,");
		sql.append("       annual = ?");
		sql.append(" where id = ?");

		SqlUtil<BudgetFileBean> sqlUtil = new SqlUtil<BudgetFileBean>();
		sqlUtil.executeUpdate(sql.toString(), bean, con);
	}

	@Override
	public BudgetFileBean selectByBussid(BudgetFileBean bean,Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select id, file_code, bus_id, file_name, ");
		sql.append(" amount, branch_id, user_id, op_date, ");
		sql.append(" status from oa_budget_file ");
		sql.append(" where bus_id = ? ");
		
		SqlUtil<BudgetFileBean> sqlUtil = new SqlUtil<BudgetFileBean>();
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		return bean;
	}

	@Override
	public void deleteById(String id, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_budget_file where id = ?");
		
		SqlUtil<BudgetFileBean> sqlUtil = new SqlUtil<BudgetFileBean>();
		BudgetFileBean bean = new BudgetFileBean();
		bean.setId(id);
		sqlUtil.executeDelete(sql.toString(), bean, con);
	}
}

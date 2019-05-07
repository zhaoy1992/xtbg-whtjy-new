package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.core.archive.dao.BudgetDetailInfoDao;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailInfoBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;

public class BudgetDetailInfoDaoImpl implements BudgetDetailInfoDao {

	@Override
	public void insert(BudgetDetailInfoBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_budget_detail_info");
		sql.append("  (budget_detail_info_id, detail_id, project_name, amount, ");
		sql.append(" remark, fun_type_name,e_type_name)");
		sql.append(" values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?)");
		SqlUtil<BudgetDetailInfoBean> sqlUtil = new SqlUtil<BudgetDetailInfoBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public void deleteByDetailId(String detail_id, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_budget_detail_info where detail_id = ?");
		SqlUtil<BudgetDetailInfoBean> sqlUtil = new SqlUtil<BudgetDetailInfoBean>();
		BudgetDetailInfoBean bean = new BudgetDetailInfoBean();
		bean.setDetail_id(detail_id);
		sqlUtil.executeDelete(sql.toString(), bean, con);
	}
}
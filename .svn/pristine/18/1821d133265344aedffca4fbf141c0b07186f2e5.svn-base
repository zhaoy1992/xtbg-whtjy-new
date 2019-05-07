package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.BudgetAttachDao;
import com.chinacreator.xtbg.core.archive.entity.BudgetAttachBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;

/**
 * 
 *<p>Title:BudgetAttachDaoImpl.java</p>
 *<p>Description:指标文拆分-附件表DAOImpl</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public class BudgetAttachDaoImpl implements BudgetAttachDao{

	@Override
	public void insert(BudgetAttachBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_budget_attachment");
		sql.append("  (id, file_name, shown_name, file_path, file_size)");
		sql.append(" values");
		sql.append("  (?, ?, ?, ?, ?)");
		
		SqlUtil<BudgetAttachBean> sqlUtil = new SqlUtil<BudgetAttachBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public List<BudgetAttachBean> listById(BudgetAttachBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select id, file_name, shown_name, file_path, file_size from oa_budget_attachment  ");
		sql.append(" where id = ?");
		List<BudgetAttachBean> list = new ArrayList<BudgetAttachBean>();
		SqlUtil<BudgetAttachBean> sqlUtil = new SqlUtil<BudgetAttachBean>();
		list = sqlUtil.executeForList(sql.toString(), bean, con);
		return list;
	}

	@Override
	public void update(BudgetAttachBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_budget_attachment");
		sql.append("   set id = ?, ");
		sql.append("       shown_name = ?,");
		sql.append("       file_path = ?,");
		sql.append("       file_size = ?");
		sql.append(" where file_name = ?");
		
		SqlUtil<BudgetAttachBean> sqlUtil = new SqlUtil<BudgetAttachBean>();
		sqlUtil.executeUpdate(sql.toString(), bean, con);
	}

	@Override
	public void deleteById(String id, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_budget_attachment where id = ?");
		
		SqlUtil<BudgetAttachBean> sqlUtil = new SqlUtil<BudgetAttachBean>();
		BudgetAttachBean bean = new BudgetAttachBean();
		bean.setId(id);
		sqlUtil.executeDelete(sql.toString(), bean, con);
	}

	@Override
	public BudgetAttachBean getByIdAndShownName(BudgetAttachBean bean,Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select id, file_name, shown_name, file_path, file_size from oa_budget_attachment  ");
		sql.append(" where id = ? and shown_name = ? ");
		SqlUtil<BudgetAttachBean> sqlUtil = new SqlUtil<BudgetAttachBean>();
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		return bean;
	}

}

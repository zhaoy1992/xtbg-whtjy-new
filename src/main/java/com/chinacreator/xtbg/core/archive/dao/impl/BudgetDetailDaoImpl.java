package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.BudgetDetailDao;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

public class BudgetDetailDaoImpl implements BudgetDetailDao {
	@Override
	public void insert(BudgetDetailBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_budget_detail");
		sql.append("  (detail_id, budget_file_id, unit_id, shown_name, ");
		sql.append("   file_path, file_size, remark)");
		sql.append(" values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ? )");
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public PagingBean list(BudgetDetailBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select d.detail_id,");
		sql.append("		  d.budget_file_id,");
		sql.append("		  d.unit_id,");
		sql.append("          su.unit_name unit_name,");
		sql.append("		  d.shown_name,");
		sql.append("          gw.org_name gw_org_name,");
		sql.append("		  d.file_path,");
		sql.append("		  d.file_size,");
		sql.append("		  d.remark");
		sql.append("	from oa_budget_detail d ");
		sql.append("      left join oa_split_unit su on d.unit_id = su.unit_id");
		sql.append("      left join oa_gwcs_org gw on gw.org_id = su.gwcs_org_id");
		sql.append("      where d.budget_file_id = ?");
		
		if(!StringUtil.isBlank(bean.getShown_name())){
			sql.append(" and d.shown_name like ? ");
			bean.setShown_name("%"+bean.getShown_name()+"%");
		}
		
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		PagingBean pageBean = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pageBean;
	}

	@Override
	public void update(BudgetDetailBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_budget_detail");
		sql.append("   set ");
		sql.append("       budget_file_id = ?,");
		sql.append("       unit_id = ?,");
		sql.append("       shown_name = ?,");
		sql.append("       file_path = ?,");
		sql.append("       file_size = ?,");
		sql.append("       remark = ?");
		sql.append(" where detail_id = ?");

		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		sqlUtil.executeUpdate(sql.toString(), bean, con);
	}

	@Override
	public void deleteById(String id, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_budget_attachment where budget_file_id = ?");
		
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		BudgetDetailBean bean = new BudgetDetailBean();
		bean.setBudget_file_id(id);
		sqlUtil.executeDelete(sql.toString(), bean, con);		
	}
	
	@Override
	public void deleteByDetailId(String id,Connection con ) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_budget_detail where detail_id = ?");
		
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		BudgetDetailBean bean = new BudgetDetailBean();
		bean.setDetail_id(id);
		sqlUtil.executeDelete(sql.toString(), bean, con);
	}

	@Override
	public BudgetDetailBean getByFileIdAndUnitId(BudgetDetailBean bean,
			Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select detail_id,");
		sql.append("       budget_file_id,");
		sql.append("       unit_id,");
		sql.append("       shown_name,");
		sql.append("       file_path,");
		sql.append("       file_size,");
		sql.append("       remark");
		sql.append("  from oa_budget_detail where budget_file_id = ? and unit_id = ? ");
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		return bean;
	}

	@Override
	public List<BudgetDetailBean> getByFileId(BudgetDetailBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select bd.detail_id,");
		sql.append("       bd.budget_file_id,");
		sql.append("       bd.unit_id,");
		sql.append("       su.gwcs_org_id,");
		sql.append("       bd.file_path,");
		sql.append("       bd.file_size");
		sql.append("  from oa_budget_detail bd");
		sql.append("  left join oa_split_unit su on su.unit_id = bd.unit_id");
		sql.append("  where budget_file_id = ? and su.gwcs_org_id is not null");
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		List<BudgetDetailBean> list = sqlUtil.executeForList(sql.toString(), bean, con);
		return list;
	}

	@Override
	public BudgetDetailBean getByDetailId(BudgetDetailBean bean,Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select detail_id,");
		sql.append("       budget_file_id,");
		sql.append("       unit_id,");
		sql.append("       shown_name,");
		sql.append("       file_path,");
		sql.append("       file_size,");
		sql.append("       remark");
		sql.append("  from oa_budget_detail");
		sql.append("  where detail_id = ?");
		SqlUtil<BudgetDetailBean> sqlUtil = new SqlUtil<BudgetDetailBean>();
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		return bean;
	}
}

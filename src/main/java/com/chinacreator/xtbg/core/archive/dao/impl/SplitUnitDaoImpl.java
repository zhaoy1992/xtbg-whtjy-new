package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.SplitUnitDao;
import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:SplitUnitDaoImpl.java</p>
 *<p>Description:拆分单位接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class SplitUnitDaoImpl implements SplitUnitDao {

	@Override
	public void insert(SplitUnitBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_split_unit");
		sql.append("  (unit_id, parent_id, unit_name, remark, is_valid,gwcs_org_id)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?)");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public PagingBean list(SplitUnitBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select c.unit_id, c.parent_id,c1.unit_name as parent_name, " +
				"c.unit_name, c.remark, c.is_valid,c.gwcs_org_id,o.org_name gwcs_org_name from oa_split_unit c ");
		sql.append(" left join oa_split_unit c1 on c.parent_id = c1.unit_id  ");
		sql.append(" left join oa_gwcs_org o on c.gwcs_org_id = o.org_id where 1=1 ");
		if(!StringUtil.isBlank(bean.getUnit_name())){
			sql.append(" and c.unit_name like ?");
			bean.setUnit_name("%"+bean.getUnit_name()+"%");
		}
		if(!StringUtil.isBlank(bean.getIs_valid())){
			sql.append(" and c.is_valid = ?");	
		}
		sql.append(" order by c.unit_name asc");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		PagingBean pageBean = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		
		return pageBean;
	}

	@Override
	public SplitUnitBean getById(SplitUnitBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select u.unit_id, u.parent_id, u.unit_name, u.remark, u.is_valid, u.gwcs_org_id ,u.gwcs_org_id,o.org_name gwcs_org_name from oa_split_unit u ");
		sql.append(" left join oa_gwcs_org o on u.gwcs_org_id = o.org_id ");
		sql.append(" where u.unit_id = ?");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		
		return bean;
	}

	@Override
	public void update(SplitUnitBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_split_unit");
		sql.append("   set parent_id = ?,");
		sql.append("       unit_name = ?,");
		sql.append("       remark = ?,");
		sql.append("       is_valid = ?,");
		sql.append("       gwcs_org_id = ?");
		sql.append(" where unit_id = ?");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		sqlUtil.executeUpdate(sql.toString(), bean, con);
	}

	@Override
	public List<SplitUnitBean> list(SplitUnitBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select c.unit_id, c.parent_id,c1.unit_name as parent_name, " +
				"c.unit_name, c.remark, c.is_valid,c.gwcs_org_id,o.org_name from oa_split_unit c ");
		sql.append(" left join oa_split_unit c1 on c.parent_id = c1.unit_id ");
		sql.append(" left join oa_gwcs_org o on c.gwcs_org_id = o.org_id where 1=1 ");
		if(!StringUtil.isBlank(bean.getIs_valid())){
			sql.append(" and c.is_valid = ?");	
		}
		if(!StringUtil.isBlank(bean.getParent_id())){
			if(bean.getParent_id().equals("-1")){
				sql.append(" and c.parent_id is null");	//查询所有一级分类
			} else {
				sql.append(" and c.parent_id = ?");				
			}
		}
		sql.append(" order by c.unit_name asc");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		List<SplitUnitBean> list = sqlUtil.executeForList(sql.toString(), bean, con);
		
		return list;
	}

	@Override
	public void deleteById(String unit_ids, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		unit_ids = StringUtil.returnParam(unit_ids, ",");
		sql.append("update oa_split_unit set is_valid = '0' where unit_id in ( "+unit_ids+" )");
		
		pdb.preparedInsert(sql.toString());
		
		pdb.executePrepared();
	}

	@Override
	public SplitUnitBean getByUnitName(SplitUnitBean bean,Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select unit_id, parent_id, unit_name, remark, is_valid from oa_split_unit ");
		sql.append(" where is_valid = 1 and unit_name = ? ");
		
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		
		return bean;
	}

	@Override
	public SplitUnitBean getUnitByGwcsOrgId(SplitUnitBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select unit_id, parent_id, unit_name, remark, is_valid,gwcs_org_id from oa_split_unit ");
		sql.append(" where is_valid = 1 and gwcs_org_id = ? ");
		if(!StringUtil.isBlank(bean.getUnit_id())){
			sql.append(" and unit_id != ?");
		}
		SqlUtil<SplitUnitBean> sqlUtil = new SqlUtil<SplitUnitBean>();
		
		bean = sqlUtil.executeForObject(sql.toString(), bean, con);
		
		return bean;
	}
}

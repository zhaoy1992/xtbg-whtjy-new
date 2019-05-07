package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.GWCSUnitDao;
import com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:GWCSUnitDaoImpl.java</p>
 *<p>Description:公文传输的地址簿daoImpl</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Oct 31, 2013
 */
public class GWCSUnitDaoImpl implements GWCSUnitDao {

	@Override
	public List<GWCSUnitBean> list(GWCSUnitBean bean, Connection con) throws Exception {
		List<GWCSUnitBean> list = new ArrayList<GWCSUnitBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select org_id, org_name, org_addr, parent_id, isouter from oa_gwcs_org ");
		if(!StringUtil.isBlank(bean.getParent_id())){
			sql.append(" where parent_id = ?");
		} else {
			sql.append(" where parent_id != '0'");
		}
		sql.append(" order by org_name asc");
		SqlUtil<GWCSUnitBean> sqlUtil = new SqlUtil<GWCSUnitBean>();
		list = sqlUtil.executeForList(sql.toString(), bean, con);
		return list;
	}

	@Override
	public List<GWCSUnitBean> listByOrgNames(String names, Connection con)
			throws Exception {
		List<GWCSUnitBean> list = new ArrayList<GWCSUnitBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select org_id, org_name, org_addr, parent_id, isouter from oa_gwcs_org where org_name in ("+names+")");
		SqlUtil<GWCSUnitBean> sqlUtil = new SqlUtil<GWCSUnitBean>();
		list = sqlUtil.executeForList(sql.toString(), new GWCSUnitBean(), con);
		return list;
	}
}

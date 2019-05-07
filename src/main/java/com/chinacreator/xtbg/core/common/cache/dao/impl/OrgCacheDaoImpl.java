package com.chinacreator.xtbg.core.common.cache.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.cache.dao.OrgCacheDao;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:OrgCacheDaoImpl.java</p>
 *<p>Description:机构缓存Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-17
 */
public class OrgCacheDaoImpl implements OrgCacheDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOrgChacheList
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.cache.dao.OrgCacheDao#getOrgChacheList(java.sql.Connection)
	 */
	@Override
	public List<OrgCacheBean> getOrgChacheList(Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<OrgCacheBean> orgCacheBeanList = new ArrayList<OrgCacheBean>();
		OrgCacheBean orgCacheBean = null;
		sql.append("select o.org_id,");
		sql.append("       o.parent_id,");
		sql.append("       o.org_name,");
		sql.append("       o.remark5 org_name_other,");
		sql.append("       o.chargeorgid,");
		sql.append("       o.org_level,");
		sql.append("       o.org_sn,");
		sql.append("       o.org_id dept_type_id,");
		sql.append("       o.dept_org dept_org,");
		sql.append("       OA_USERPROPERTY(o.org_id, '2') as unit_id,");
		sql.append("       OA_USERPROPERTY(o.org_id, '1') as unit_name");
		sql.append("  from td_sm_organization o  where o.org_id  not in (  ");
		sql.append("  select distinct org_id from td_sm_organization  start with org_id in  ");
		sql.append("  (select distinct org_id from td_sm_organization where remark3='0') connect by prior  org_id=parent_id )  ");
		sql.append(" order by o.org_sn");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		for(int i = 0; i < db.size(); i++) {
			orgCacheBean = new OrgCacheBean();
			orgCacheBean.setOrg_id(db.getString(i, "org_id"));
			orgCacheBean.setParent_id(db.getString(i, "parent_id"));
			orgCacheBean.setOrg_name(db.getString(i, "org_name"));
			orgCacheBean.setOrg_name_other(db.getString(i, "org_name_other"));
			orgCacheBean.setChargeorgid(db.getString(i, "chargeorgid"));
			orgCacheBean.setOrg_level(db.getString(i, "org_level"));
			orgCacheBean.setOrg_sn(db.getString(i, "org_sn"));
			orgCacheBean.setUnit_id(db.getString(i, "unit_id"));
			orgCacheBean.setUnit_name(db.getString(i, "unit_name"));
			orgCacheBean.setDept_type_id(db.getString(i, "dept_type_id"));
			orgCacheBean.setDept_org(db.getString(i, "dept_org"));
			orgCacheBeanList.add(orgCacheBean);
		}
		return orgCacheBeanList;
	}

}

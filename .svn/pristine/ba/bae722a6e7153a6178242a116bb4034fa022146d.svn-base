package com.chinacreator.xtbg.core.purviewmanager.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.Organization;
import com.chinacreator.xtbg.core.purviewmanager.entity.Orgjob;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:OrgManagerDaoImpl.java</p>
 *<p>Description:机构管理实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-17
 */
public class OrgManagerDaoImpl implements OrgManagerDao {
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOrganization
	  * @param OrgId
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao#getOrganization(java.lang.String)
	 */
	public Organization getOrganization(String orgId, Connection con) throws Exception {
		Organization organization = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append("select o.org_id,");
		sql.append("       o.parent_id,");
		sql.append("       o.org_sn,");
		sql.append("       o.org_name,");
		sql.append("       o.jp,");
		sql.append("       o.qp,");
		sql.append("       o.orgnumber,");
		sql.append("       o.orgdesc,");
		sql.append("       o.remark1,");
		sql.append("       o.remark3,");
		sql.append("       o.remark5,");
		sql.append("       o.remark2,");
		sql.append("       o.remark4,");
		sql.append("       o.org_level,");
		sql.append("       o.org_xzqm");
		sql.append("  from td_sm_organization o where o.org_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString()); 
		db.setString(1, orgId);
		db.executePrepared(con);
		
		for(int i = 0; i < db.size(); i++) {
			organization = new Organization();
			organization.setOrg_id(db.getString(0, "org_id"));
			organization.setParent_id(db.getString(0, "parent_id"));
			organization.setOrg_sn(db.getString(0, "org_sn"));
			organization.setOrg_name(db.getString(0, "org_name"));
			organization.setJp(db.getString(0, "jp"));
			organization.setQp(db.getString(0, "qp"));
			organization.setOrgnumber(db.getString(0, "orgnumber"));
			organization.setOrgdesc(db.getString(0, "orgdesc"));
			organization.setRemark3(db.getString(0, "remark3"));
			organization.setRemark5(db.getString(0, "remark5"));
			organization.setRemark2(db.getString(0, "remark2"));
			organization.setRemark1(db.getString(0, "remark1"));
			organization.setRemark4(db.getString(0, "remark4"));
			organization.setOrg_level(db.getString(0, "org_level"));
			organization.setOrg_xzqm(db.getString(0, "org_xzqm"));
			
		}
		return organization;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addOrUpdateOrg
	  * @param org
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao#addOrUpdateOrg(com.chinacreator.xtbg.core.purviewmanager.entity.Organization)
	 */
	public boolean addOrUpdateOrg(Organization org, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		String org_id = org.getOrg_id();
		if(StringUtil.isBlank(org_id)) {
			org_id = StringUtil.getUUID();
			sql.append("insert into td_sm_organization");
			sql.append("   (org_id,");
			sql.append("   org_sn,");
			sql.append("   org_name,");
			sql.append("   parent_id,");
			sql.append("   jp,");
			sql.append("   qp,");
			sql.append("   creatingtime,");
			sql.append("   creator,");
			sql.append("   orgnumber,");
			sql.append("   orgdesc,");
			sql.append("   remark3,");
			sql.append("   remark5,");
			sql.append("   org_level,");
			sql.append("   org_xzqm,");
			sql.append("   remark2,");
			sql.append("   remark1,");
			sql.append("   remark4)");
			sql.append(" values");
			sql.append("  (?,?,?,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?)");
			
			db.preparedInsert(sql.toString());
			db.setString(1, org_id);
			db.setString(2, org.getOrg_sn());
			db.setString(3, org.getOrg_name());
			db.setString(4, org.getParent_id());
			db.setString(5, org.getJp());
			db.setString(6, org.getQp());
			db.setString(7, org.getCreator());
			db.setString(8, org.getOrgnumber());
			db.setString(9, org.getOrgdesc());
			db.setString(10, org.getRemark3());
			db.setString(11, org.getRemark5());
			db.setString(12, org.getOrg_level());
			db.setString(13, org.getOrg_xzqm());
			db.setString(14, org.getRemark2());
			db.setString(15, org.getRemark1());
			db.setString(16, org.getRemark4());
			
			Orgjob orgjob = new Orgjob();
			
			orgjob.setOrg_id(org_id);
			orgjob.setJob_id("1");
			orgjob.setJob_sn(Integer.valueOf(999));
			addOrgjob(orgjob, con);
			
			
		} else {
			sql.append("update td_sm_organization");
			sql.append("   set org_sn    = ?,");
			sql.append("       org_name  = ?,");
			sql.append("       jp        = ?,");
			sql.append("       qp        = ?,");
			sql.append("       orgdesc   = ?,");
			sql.append("       remark3   = ?,");
			sql.append("       remark5   = ?,");
			sql.append("       org_level   = ?,");
			sql.append("       remark1   = ?,");
			sql.append("       remark2   = ?,");
			sql.append("       remark4   = ?");
			sql.append(" where org_id = ?");
			db.preparedUpdate(sql.toString());
			db.setString(1, org.getOrg_sn());
			db.setString(2, org.getOrg_name());
			db.setString(3, org.getJp());
			db.setString(4, org.getQp());
			db.setString(5, org.getOrgdesc());
			db.setString(6, org.getRemark3());
			db.setString(7, org.getRemark5());
			db.setString(8, org.getOrg_level());
			db.setString(9, org.getRemark1());
			db.setString(10, org.getRemark2());
			db.setString(11, org.getRemark4());
			db.setString(12, org.getOrg_id());
			
		}
		
		db.executePrepared(con);
		
		//刷新机构缓冲
		OrgCacheManager orgCacheManager = OrgCacheManager.getInstance();
		orgCacheManager.reset();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addOrgjob
	  * @param orgjob 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao#addOrgjob(com.chinacreator.xtbg.core.purviewmanager.entity.Orgjob)
	 */
	public void addOrgjob(Orgjob orgjob, Connection con) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "insert into td_sm_orgjob (org_id, job_id, job_sn) values (?, ?, ?)";
		db.preparedInsert(sql.toString());
		db.setString(1, orgjob.getOrg_id());
		db.setString(2, orgjob.getJob_id());
		db.setInt(3, orgjob.getJob_sn());
		db.executePrepared(con);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 sortOrg
	  * @param org_id
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao#sortOrg(java.lang.String, java.sql.Connection)
	 */
	public boolean sortOrg(String org_ids, Connection conn) throws Exception {
		String sql = "update td_sm_organization o set o.org_sn = ? where o.org_id= ?";
		String[] org_idArray = null;
		PreparedDBUtil db = null;
		
		if(!StringUtil.isBlank(org_ids)) {
			org_idArray = org_ids.split(",");
			db = new PreparedDBUtil();
			for(int i=1; i< org_idArray.length ;i++){ //子节点成1开始遍历
				db.preparedUpdate(sql.toString());
				db.setInt(1, i);
				db.setString(2, org_idArray[i]);
				
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}
		//刷新机构缓冲
		OrgCacheManager orgCacheManager = OrgCacheManager.getInstance();
		orgCacheManager.reset();
		
		return true;
	}



	

}

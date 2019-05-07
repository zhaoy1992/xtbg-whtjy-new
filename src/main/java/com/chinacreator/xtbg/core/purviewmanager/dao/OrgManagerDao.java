package com.chinacreator.xtbg.core.purviewmanager.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.purviewmanager.entity.Organization;
import com.chinacreator.xtbg.core.purviewmanager.entity.Orgjob;

/**
 * 
 *<p>Title:OrgManagerDao.java</p>
 *<p>Description:机构管理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-17
 */
public interface OrgManagerDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* getOrganization(通过orgId查询机构基本信息)
	* @return
	 */
	public Organization getOrganization(String OrgId, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addOrUpdateOrg(添加或修改机构)
	* @return
	 */
	 public boolean addOrUpdateOrg(Organization org, Connection con) throws Exception;
	 
	 /**
	  * 
	 *<b>Summary: </b>
	 * addOrgjob(添加岗位信息)
	  */
	 public void addOrgjob(Orgjob orgjob, Connection con) throws SQLException;
	 
	 /**
	  * 
	 *<b>Summary: </b>
	 * sortOrg(机构排序)
	 * @param org_id
	 * @param con
	 * @return
	 * @throws Exception
	  */
	 public boolean sortOrg(String org_id, Connection conn) throws Exception;
	 
	 
}

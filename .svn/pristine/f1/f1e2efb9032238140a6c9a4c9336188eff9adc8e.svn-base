package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.configuration.PropertiesConfiguration;

import com.chinacreator.xtbg.core.common.commonlist.LoadConfigurationProperties;
import com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<li>
 * Title:ResouceConfigDaoImpl.java </p>
 *<p>
 * Description:查询配置信息
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-29
 */
public class ResouceConfigDaoImpl extends LoadConfigurationProperties implements
		ResourceConfigDao {
	private static final String PATHNAME = "resourcesLogo";// 配置文件名称
	private PropertiesConfiguration config;

	public ResouceConfigDaoImpl() throws Exception {
		if (null == config) {
			/**
			 * 暂时屏蔽掉查询资源信息的功能，等黄功能做好以后再加
			 */
			// LoadConfigurationProperties.setPath(PATHNAME);
			// config = LoadConfigurationProperties.getInstance();
		}
	}

	/**
	 * 查询机构对应的人(包括子机构对应的人员)
	 * 
	 * @param orgid
	 *            机构id
	 * @param resourceid
	 *            资源id
	 * @return List类型
	 */

	public List<ResourceRoleUserBean> queryOrginUserList(String orgid,
			String resourceType, String userid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer userIDs = new StringBuffer();
		String ids = "";
		String logo = getResourceLogo(resourceType);
		List<ResourceRoleUserBean> resourceRoleUserBeanList = new ArrayList<ResourceRoleUserBean>();
		sql.append("select c.ids ");
		sql.append("  from ta_oa_resources_config c ");
		sql.append(" where c.resources_configtypeid = ? ");
		sql.append("   and c.resources_id = (select r.resources_id ");
		sql.append("                           from ta_oa_resources r ");
		sql.append("                          where r.resources_logo = ?) ");

		String orgidArray[] = null;
		if (!StringUtil.isBlank(orgid)) {
			orgidArray = orgid.split(",");
			for (int k = 0; k < orgidArray.length; k++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, orgidArray[k]);
				pdb.setString(2, logo);
				pdb.executePrepared();
				if (pdb.size() > 0) {
					ids = pdb.getString(0, "ids");
					if (!StringUtil.isBlank(ids)) {
						userIDs.append(ids + ",");
					}
				}
			}
		}
		sql = new StringBuffer();
		sql.append(" select u.user_realname, ou.org_id ,org.org_name ");
		sql.append(" from td_sm_user u");
		sql.append(" left join td_sm_orguser ou on u.user_id = ou.user_id");
		sql
				.append(" left join td_sm_organization org on  ou.org_id= org.org_id");
		sql.append(" where u.user_id = ?");

		String userIDsArray[] = null;
		if (userIDs.length() > 0) {
			userIDsArray = userIDs.substring(0, userIDs.length() - 1)
					.split(",");
			for (int j = 0; j < userIDsArray.length; j++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, userIDsArray[j]);
				pdb.executePrepared();
				if (pdb.size() > 0) {
					ResourceRoleUserBean resUserBean = new ResourceRoleUserBean();
					resUserBean.setUserid(userIDsArray[j]);
					resUserBean.setUsername(pdb.getString(0, "user_realname"));
					resUserBean.setOrgid(pdb.getString(0, "org_id"));
					resUserBean.setOrgname(pdb.getString(0, "org_name"));
					resourceRoleUserBeanList.add(resUserBean);
				}
			}
		}

		return resourceRoleUserBeanList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryUserMatchOrg
	 * 
	 * @param userId
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao#queryUserMatchOrg(java.lang.String)
	 */
	public ResourceRoleUserBean queryUserMatchOrg(String userId)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		ResourceRoleUserBean rBean = null;

		sql
				.append(" select org.remark4,ou.org_id,org.org_name,org.remark1,u.user_realname");
		sql.append(" from td_sm_orguser ou");
		sql
				.append(" left join td_sm_organization org on ou.org_id = org.org_id");
		
		sql.append("  left join td_sm_user u on ou.user_id=u.user_id");
		sql.append(" where ou.user_id = '" + userId + "'");

		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if (pdb.size() == 0) {
			rBean = new ResourceRoleUserBean();
		}
		for (int i = 0; i < pdb.size(); i++) {
			rBean = new ResourceRoleUserBean();
			rBean.setRemark4(pdb.getString(i, "remark4"));
			rBean.setIsLeadOrg("N");//去掉了部门人员关系，是否部门领导都设置为否
			rBean.setOrgid(pdb.getString(i, "org_id"));
			rBean.setOrgname(pdb.getString(i, "org_name"));
			rBean.setDeptCode(pdb.getString(i, "remark1"));
			rBean.setUsername(pdb.getString(i, "user_realname"));
		}

		return rBean;
	}

	/**
	 * 
	 *<b>Summary: 获得配置的资源id</b> getResourceLogo(请用一句话描述这个方法的作用)
	 * 
	 * @param resourceType
	 * @return
	 * @throws Exception
	 */
	public String getResourceLogo(String resourceType) throws Exception {
		String resource = "";
		// 暂时屏蔽掉取配置信息的方式，等黄的配置功能做好以后再补充进来
		// if (null != config) {
		// resource = config.getString(resourceType).split("#")[0];
		// }
		return resource;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUnitReceiverUser
	  * @param org_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao#getUnitReceiverUser(java.lang.String, java.sql.Connection)
	 */
	public String getUnitReceiverUser(String org_id, Connection conn)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}

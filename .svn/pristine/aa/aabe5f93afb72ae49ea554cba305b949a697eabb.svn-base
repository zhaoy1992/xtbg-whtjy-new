package com.chinacreator.xtbg.core.dataresources.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:DataResourcesDaoImpl.java</p>
 *<p>Description:数据资源Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-22
 */
public class DataResourcesDaoImpl extends XtDbBaseDao implements DataResourcesDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataResourcesBeanMap
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#getDataResourcesBeanMap()
	 */
	@Override
	public List<Map<String, String>> getDataResourcesBeanMap() throws Exception{
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		String sql = "select r.resources_id,r.resources_name,r.resources_logo from oa_data_resources r where r.resources_type='2'";
		listMap = queryToListMap(sql);
		return listMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserBeanMap
	  * @param org_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#getUserBeanMap(java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getUserBeanMap(String org_id)
			throws Exception {
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("  select u.user_id, u.user_name, u.user_realname");
		sql.append("    from td_sm_user u, td_sm_orguser ou");
		sql.append("   where u.user_id = ou.user_id");
		sql.append("     and instr(',' || (select to_char(wmsys.wm_concat(a.org_id))");
		sql.append("                         from td_sm_organization a");
		sql.append("                        start with a.org_id = ?");
		sql.append("                       connect by prior a.org_id = a.parent_id) || ',',");
		sql.append("               ',' || ou.org_id || ',') > 0");
		listMap = queryToListMap(sql.toString(), org_id);
		return listMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertOrgResourceConfig
	  * @param boxvalue
	  * @param org_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#insertOrgResourceConfig(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public void insertOrgResourceConfig(String boxvalue, String org_id,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String boxvalueArray[] = null; 
		StringBuffer sql = null;
		if(!StringUtil.isBlank(boxvalue)) {
			boxvalueArray = boxvalue.split("-");
			for(int i = 0; i < boxvalueArray.length; i++) {
				sql = new StringBuffer();
				String userboxvalue = boxvalueArray[i];
				String userboxvalueArray[] = userboxvalue.split("@");
				if(userboxvalueArray.length > 1) {
					sql.append(" insert into oa_dataresources_config");
					sql.append("   (config_id,");
					sql.append("    resources_id,");
					sql.append("    config_type,");
					sql.append("    config_typeid,");
					sql.append("    config_range,");
					sql.append("    creator_time,");
					sql.append("    tree_jsondata,");
					sql.append("    config_ids)");
					sql.append(" values");
					sql.append("   (?, ?, '3', ?, '2', sysdate, ?, ?)");
					pdb.preparedInsert(sql.toString());
					pdb.setString(1, StringUtil.getUUID());
					pdb.setString(2, userboxvalueArray[0]);
					pdb.setString(3, org_id);
					pdb.setString(4, userboxvalueArray[1]);
					pdb.setString(5, userboxvalueArray[1]);
					pdb.addPreparedBatch();
				}
			}
			pdb.executePreparedBatch(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delOrgResourceConfig
	  * @param boxvalue
	  * @param org_id
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#delOrgResourceConfig(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public void delOrgResourceConfig(String boxvalue, String org_id,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String boxvalueArray[] = null; 
		String sql = "";
		if(!StringUtil.isBlank(boxvalue)) {
			boxvalueArray = boxvalue.split("-");
			for(int i = 0; i < boxvalueArray.length; i++) {
				String userboxvalue = boxvalueArray[i];
				String userboxvalueArray[] = userboxvalue.split("@");
				sql = "delete oa_dataresources_config where resources_id = ? and config_typeid = ?";
				pdb.preparedDelete(sql);
				pdb.setString(1, userboxvalueArray[0]);
				pdb.setString(2, org_id);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getChooseOrgUser
	  * @param org_id
	  * @param config_type
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#getChooseOrgUser(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> getChooseOrgUser(String org_id, Connection conn) throws Exception {
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		String sql = "select resources_id, config_ids from oa_dataresources_config where config_type = '3' and config_typeid = ?";
		listMap = queryToListMap(sql, org_id);
		return listMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delAllChooseOrgUser
	  * @param org_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#delAllChooseOrgUser(java.lang.String, java.sql.Connection)
	 */
	@Override
	public void delAllChooseOrgUser(String org_id, Connection conn)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "delete oa_dataresources_config where config_typeid = ? and config_type = '3'";
		pdb.preparedDelete(sql);
		pdb.setString(1, org_id);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataResourcesRecipient
	  * @param unit_id
	  * @param resources_logo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao#getDataResourcesRecipient(java.lang.String, java.lang.String)
	 */
	@Override
	public String getDataResourcesRecipient(String unit_id,
			String resources_logo) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select c.config_ids");
		sql.append("  from oa_dataresources_config c, oa_data_resources r");
		sql.append(" where c.resources_id = r.resources_id");
		sql.append("   and r.resources_logo = ?");
		sql.append("   and config_typeid = ?");
		Map<String, String> dataMap = queryToSingleMap(sql.toString(), resources_logo, unit_id);
		String config_ids = dataMap.get("config_ids");
		return config_ids;
	}

}

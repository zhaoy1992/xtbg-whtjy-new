package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class OfficeosupplietypeTreeDaoImpl extends TreeDataInfo{
	private static final Log LOG = LogFactory.getLog(OfficeosupplietypeTreeDaoImpl.class);
	/**
	 * 
	  * <b>Summary:查询办公用品分类tree</b>
	  *     复写方法 getTreeDateInfo
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		return queryOfficeType();
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSonOrg(获得子机构的节点)
	* @param orgId
	* @throws Exception
	 */
	public void getSonOrg(String orgId) throws Exception {
		getTreeDateInfo();
	}
	
	public 	List<Map<String, String>> queryOfficeType(){
		String user_id = accesscontroler.getUserID();//调用父类的accesscontroler
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(user_id);
		String unit_id = userCacheBean.getUnit_id();
		StringBuffer sql = new StringBuffer();
		sql.append("select oftype_name,oftype_id from ta_oa_osupplietype where 1 = 1 ");
		if(!StringUtil.nullOrBlank(unit_id)){
			sql.append(" and unit_id = '"+unit_id+"'");
		}
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if(sql.length()>0){
			PreparedDBUtil pdb = new PreparedDBUtil();
			Connection conn = null;
			try {
				conn = DbManager.getInstance().getConnection();
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				Map<String, String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					//树需要的
					tempVal.put("oftype_id",  pdb.getString(i, "oftype_id"));
					tempVal.put("name", pdb.getString(i, "oftype_name"));
					tempVal.put("open", "true");
					tempVal.put("readonly", "true");
					tempVal.put("parent_id", "");
					list.add(tempVal);
				}
			} catch (SQLException e) {
				LOG.error(e.getMessage(), e);
			}finally{
				DbManager.closeConnection(conn);
			}
		}
		return list;
	}
}

package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.entity.RcentlyUserBean;
import com.chinacreator.xtbg.core.common.tree.entity.TreeBean;
import com.chinacreator.xtbg.core.common.tree.entity.TreeHashMap;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:CommonTreeDaoImpl.java</p>
 *<p>Description:通用树处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-6
 */
public class CommonTreeDaoImpl {

	
	private static final Log LOG = LogFactory.getLog(CommonTreeDaoImpl.class);
	
	
	
	/**
	*<b>Summary: </b>
	* inqueryTreeMeetingOrganization(查询所有的机构树--不显示已选的)
	* @param bean
	* @return 
	*/
	public static Object inqueryTreeMeetingOrganization(TreeBean bean){
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		OrgCacheBean orgCacheBean = null;
		Map<String, String> tempVal = null;
		String userId = bean.getUserID();	
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids ="";
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		
		//得到传来的user参数
		Map<String, String> requestMap=bean.getRequestMap();
		
		String user=","+requestMap.get("user")+",";//已选单位
		
		if(orgCacheBeanList != null){
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
				if("1".equals(orgCacheBean.getOrg_level()) || "2".equals(orgCacheBean.getOrg_level())) {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("item_code", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("deptType",  orgCacheBean.getOrg_id());
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					if(user.indexOf(","+orgCacheBean.getOrg_id()+",")==-1){//过滤已选
						list.add(tempVal);
					}
				}
			}
		}
		if (0 == list.size()) {
			return "'none'";
		}
		return list;
	}
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeOrganization(查询所有的机构树)
	* @param bean
	* @return
	 */
	public static Object inqueryTreeOrganization(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		OrgCacheBean orgCacheBean = null;
		Map<String, String> tempVal = null;
		String userId = bean.getUserID();	
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids ="";
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		if(orgCacheBeanList != null){
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
				if("1".equals(orgCacheBean.getOrg_level()) || "2".equals(orgCacheBean.getOrg_level())) {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("item_code", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("deptType",  orgCacheBean.getOrg_id());
					tempVal.put("org_level",orgCacheBean.getOrg_level());
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
				}
			}
		}

		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeDept(查询所有的单位与部门)
	* @param bean
	* @return
	 */
	public static Object inqueryTreeDept(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		OrgCacheBean orgCacheBean = null;
		Map<String, String> tempVal = null;
		String userId = bean.getUserID();	
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids ="";
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		if(orgCacheBeanList != null){
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("item_code", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("deptType",  orgCacheBean.getOrg_id());
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
			}
		}

		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeUnit(查询所有的单位)
	* @param bean
	* @return
	 */
	public static Object inqueryTreeUnit(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		OrgCacheBean orgCacheBean = null;
		Map<String, String> tempVal = null;
		String userId = bean.getUserID();	
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids ="";
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		if(orgCacheBeanList != null){
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
				if("2".equals(orgCacheBean.getOrg_level())) {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("item_code", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("deptType",  orgCacheBean.getOrg_id());
					tempVal.put("org_level",orgCacheBean.getOrg_level());
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
				}
			}
		}

		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	
	/**
	 * 
	 *<b>Summary: </b> inqueryTreePerson(查询机构人员树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreePerson(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal = null;
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String userId = bean.getUserID();	
		userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids = "";
		String dept_org = OASystemCache.getContextProperty("dept_org");
		  
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		String path = bean.getRequest().getContextPath();
		 
		for(int i = 0; i < orgCacheBeanList.size(); i++) {
			orgCacheBean = orgCacheBeanList.get(i);
			if(!StringUtil.isBlank(dept_org)){//如果不是过滤字段。
				if(dept_org.equals(orgCacheBean.getDept_org())){
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("item_id", orgCacheBean.getOrg_id());

					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("deptType", orgCacheBean.getOrg_level());
					
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
				}
			}else{
				tempVal = new TreeHashMap<String, String>();
				tempVal.put("id", orgCacheBean.getOrg_id());
				tempVal.put("name", orgCacheBean.getOrg_name());
				tempVal.put("item_id", orgCacheBean.getOrg_id());

				tempVal.put("org_id", orgCacheBean.getOrg_id());
				tempVal.put("parent_id", orgCacheBean.getParent_id());
				tempVal.put("deptType", orgCacheBean.getOrg_level());
				
				if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
					tempVal.put("open", "true");
				}
				list.add(tempVal);
			}
			
		}
		
		List<UserCacheBean> userCacheBeanList = UserCache.getUserCacheBeanList();
		if (userCacheBeanList!=null){
			for(int j = 0; j < userCacheBeanList.size(); j++) {
				userCacheBean = userCacheBeanList.get(j);
				if(!StringUtil.isBlank(dept_org)){//如果不是过滤字段。
					if(dept_org.equals(userCacheBean.getDept_org())){
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", userCacheBean.getUser_id());
						tempVal.put("name", userCacheBean.getUser_realname());
						tempVal.put("parent_id", userCacheBean.getOrg_id());
						tempVal.put("item_id", userCacheBean.getUser_id());
						tempVal.put("user_id", userCacheBean.getUser_id());
						tempVal.put("item_code", userCacheBean.getUser_name());
						tempVal.put("user_mobiletel1", userCacheBean.getUser_mobiletel1());
						tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
						list.add(tempVal);
					}
					
				}else{
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", userCacheBean.getUser_id());
					tempVal.put("name", userCacheBean.getUser_realname());
					tempVal.put("parent_id", userCacheBean.getOrg_id());
					tempVal.put("item_id", userCacheBean.getUser_id());
					tempVal.put("user_id", userCacheBean.getUser_id());
					tempVal.put("item_code", userCacheBean.getUser_name());
					tempVal.put("user_mobiletel1", userCacheBean.getUser_mobiletel1());
					tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
					list.add(tempVal);
				}
			}
		}
		
		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	
	private static final String TREE_TYPE_ID = "select tree_type from oa_data_resources t where t.resources_id=?";
	private static final String USER_RESOURCES = "select c.tree_jsondata, c.config_ids from oa_dataresources_config c where c.resources_id = ? and c.config_typeid = ?";
	/**
	 * 
	*<b>Summary: </b>
	* getResourcesConfigTree(获得资源配置树)
	* @param bean
	* @return
	 */
	public static Object getResourcesConfigTree(TreeBean bean){
		Map<String, String> request = bean.getRequestMap();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String type = request.get("type");
		Map<String, String> tempVal = null;
		String tree_jsondata = "";
		String config_ids = "";
		String cur_unit_id = "";
		String cur_unit_ids = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String path = bean.getRequest().getContextPath();
		
		String treeType = "1";
		try {
			
			//查询权限树的类型
			pdb.preparedSelect(TREE_TYPE_ID);
			pdb.setString(1, type);
			pdb.executePrepared();
			if(pdb.size() > 0) {
				treeType = pdb.getString(0, "tree_type");
			} 
			
			//查询配置的权限值
			pdb.preparedSelect(USER_RESOURCES);
			pdb.setString(1, type);
			pdb.setString(2, bean.getUserID());
			pdb.executePrepared();
			
			if(pdb.size() > 0) {
				tree_jsondata = ","+ pdb.getString(0, "tree_jsondata") + ",";
				config_ids = ","+ pdb.getString(0, "config_ids") + ",";
				if("2".equals(treeType)) { //如果是机构树将配置结点与配置结点以上的结点拼接在一起
					tree_jsondata = tree_jsondata + config_ids + ",";
				}
			}
			
			List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
			String userId = bean.getUserID();	
			userCacheBean = UserCache.getUserCacheBean(userId);
			if(userCacheBean != null) {
				cur_unit_ids = "," + userCacheBean.getUnit_ids() + ",";
				cur_unit_id = userCacheBean.getUnit_id();
			}
			
			//构成机构结点
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
				if("1".equals(treeType) && (cur_unit_ids.indexOf(","+orgCacheBean.getUnit_id() + ",") > -1 || tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1)) { //人员树，默认权限，配置权限
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("org_level", orgCacheBean.getOrg_level());
					if(cur_unit_ids.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
				} else if (tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1
						&& ("1".equals(orgCacheBean.getOrg_level()) || "2".equals(orgCacheBean.getOrg_level())))  {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("item_id", orgCacheBean.getOrg_id());
					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("org_level", orgCacheBean.getOrg_level());
					list.add(tempVal);
				}
			}
			
			if("1".equals(treeType)) { //人员树
				List<UserCacheBean> userCacheBeanList = UserCache.getUserCacheBeanList();
				
				for(int j = 0; j < userCacheBeanList.size(); j++) {
					userCacheBean = userCacheBeanList.get(j);
					String unit_id = userCacheBean.getUnit_id();
					if(cur_unit_id.equals(unit_id) || config_ids.indexOf(","+userCacheBean.getUser_id() + ",") > -1) { //默认权限, 配置权限
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", userCacheBean.getUser_id());
						tempVal.put("name", userCacheBean.getUser_realname());
						tempVal.put("parent_id", userCacheBean.getOrg_id());
						tempVal.put("item_id", userCacheBean.getUser_id());
						tempVal.put("user_id", userCacheBean.getUser_id());
						tempVal.put("item_code", userCacheBean.getUser_name());
						tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
						list.add(tempVal);
					} 
				}
			}
			
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	/**
	 * 数据字典树参数名:字典编号
	 */
	public static final String DICT_CODE_FLAG = "dictCode";
	/**
	 * 数据字典.文件字号:oa_dict_type.dict_code
	 */
	public static final String DICT_CODE_WJZH = "wenjianzihao";
	/**
	 * 
	 *<b>Summary: </b>
	 * inqueryTreeDictDataByDictType(数据字典树:依据DictType信息查询DictData的tree)
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeDictDataByDictType(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			String dictCode=bean.getRequestMap().get(DICT_CODE_FLAG);
			if(dictCode!=null){
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select *");
				sql.append("  from oa_dict_data");
				sql.append(" where dict_id in");
				sql.append("       (select dict_id from oa_dict_type where dict_code = '"+dictCode+"')");
				sql.append(" order by dictdata_order");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("parent_id", pdb.getString(i,"dictdata_parent_id"));
						tempVal.put("open", "true");
						
						tempVal.put("org_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("name", pdb.getString(i,"dictdata_name"));
						tempVal.put("id", pdb.getString(i, "dictdata_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					
					tempVal.put("name", "维护字典[CD:"+dictCode+"]");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			}
			//模拟根节点
			if (0 == list.size()) {
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryOfTypeTree(办公用品类别树)
	 * @param bean 
	* @param bean
	* @return
	 */
	public static Object inqueryOfTypeTree(com.chinacreator.xtbg.pub.tree.entity.TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		UserCacheBean userCacheBean = null;
		String cur_unit_id = "";
		try {
				String userId = bean.getUserID();	
				userCacheBean = UserCache.getUserCacheBean(userId);
				if(userCacheBean != null) {
					cur_unit_id = userCacheBean.getUnit_id();
				}
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select t.oftype_id as dictdata_id, t.oftype_name as dictdata_name from ta_oa_osupplietype t where t.unit_id = '"+cur_unit_id+"'");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("parent_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("open", "true");
						tempVal.put("org_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("name", pdb.getString(i,"dictdata_name"));
						tempVal.put("id", pdb.getString(i, "dictdata_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			//模拟根节点
			if (0 == list.size()) {
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryDETTypeTree(检测耗材用品类别树)
	 * @param bean 
	* @param bean
	* @return
	 */
	public static Object inqueryDETTypeTree(com.chinacreator.xtbg.pub.tree.entity.TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		UserCacheBean userCacheBean = null;
		String cur_unit_id = "";
		try {
				String userId = bean.getUserID();	
				userCacheBean = UserCache.getUserCacheBean(userId);
				if(userCacheBean != null) {
					cur_unit_id = userCacheBean.getUnit_id();
				}
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select t.oftype_id as dictdata_id, t.oftype_name as dictdata_name from ta_oa_detosupplietype t where t.unit_id = '"+cur_unit_id+"'");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("parent_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("open", "true");
						tempVal.put("org_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("name", pdb.getString(i,"dictdata_name"));
						tempVal.put("id", pdb.getString(i, "dictdata_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			//模拟根节点
			if (0 == list.size()) {
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryCANTypeTree(食堂物品类别树)
	 * @param bean 
	* @param bean
	* @return
	 */
	public static Object inqueryCANTypeTree(com.chinacreator.xtbg.pub.tree.entity.TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		UserCacheBean userCacheBean = null;
		String cur_unit_id = "";
		try {
				String userId = bean.getUserID();	
				userCacheBean = UserCache.getUserCacheBean(userId);
				if(userCacheBean != null) {
					cur_unit_id = userCacheBean.getUnit_id();
				}
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select t.oftype_id as dictdata_id, t.oftype_name as dictdata_name from ta_oa_canosupplietype t where t.unit_id = '"+cur_unit_id+"'");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("parent_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("open", "true");
						tempVal.put("org_id", pdb.getString(i,"dictdata_id"));
						tempVal.put("name", pdb.getString(i,"dictdata_name"));
						tempVal.put("id", pdb.getString(i, "dictdata_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			//模拟根节点
			if (0 == list.size()) {
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	private static final String RCENTLYUSER_SEL = "select ru_data from oa_recently_user where ru_logn = ? and user_id = ?";
	private static final String RCENTLYUSER_DEL = "delete  oa_recently_user where ru_logn = ? and user_id = ?";
	private static final String RCENTLYUSER_INSERT = "insert into oa_recently_user(ru_id,ru_logn,ru_type,ru_data,user_id) values(?,?,?,?,?)";
	public static void insertRcentlyUser(RcentlyUserBean rcentlyUserBean, Connection conn) throws Exception {
		if(rcentlyUserBean != null) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			String ru_data = "";
			String endRuData = "";
			String[] new_ruDataArray = null;
			String new_ruData = rcentlyUserBean.getRu_data();
			pdb.preparedSelect(RCENTLYUSER_SEL);
			pdb.setString(1, rcentlyUserBean.getRu_logn());
			pdb.setString(2, rcentlyUserBean.getUser_id());
			pdb.executePrepared(conn);
			if (pdb.size() > 0) {
				ru_data = pdb.getString(0, "ru_data");
				
				
				new_ruDataArray = new_ruData.split(",");
				if(!StringUtil.isBlank(ru_data)) {
					endRuData = ru_data;
					for(int i = 0; i < new_ruDataArray.length; i++) {
						String dbru_data = "," + ru_data + ",";
						if(dbru_data.indexOf(","+new_ruDataArray[i]+",")!= -1){
						}else{
							if(ru_data.split(",").length >= 20 || endRuData.split(",").length >= 20) {
								endRuData = endRuData.substring(endRuData.indexOf(",") + 1,endRuData.length()) + "," + new_ruDataArray[i];
							} else {
								endRuData += "," + new_ruDataArray[i];
							}
						}
					}
				} else {
					endRuData = new_ruData;
				}
			} else {
				endRuData = new_ruData;
			}
			
			pdb.preparedDelete(RCENTLYUSER_DEL);
			pdb.setString(1, rcentlyUserBean.getRu_logn());
			pdb.setString(2, rcentlyUserBean.getUser_id());
			pdb.executePrepared(conn);
	
			pdb.preparedInsert(RCENTLYUSER_INSERT);
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, rcentlyUserBean.getRu_logn());
			pdb.setString(3, rcentlyUserBean.getRu_type());
			pdb.setString(4, endRuData);
			pdb.setString(5, rcentlyUserBean.getUser_id());
			pdb.executePrepared(conn);
		}
	}
	/**
	 * 指向程序界面表中的ID的参数名
	 */
	public static final String OA_FILE_PROGRAM_PAGE__F_PROGRAM_ID = "programId";
	/**
	 * 
	 *<b>Summary: </b>
	 * inqueryTreeFileTreeInOneProgramPage(把同关联同一种程序界面的所有三级档案分类 及其 父级分类查出来,支持公文归档成档案文件)
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeFileTreeInOneProgramPage(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			String programId=bean.getRequestMap().get(OA_FILE_PROGRAM_PAGE__F_PROGRAM_ID);
			String orgId=bean.getRequestMap().get("orgId");
			if(!StringUtil.nullOrBlank(programId)){
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select distinct oft.*");
				sql.append("  from oa_file_type oft");
				sql.append(" connect by prior f_parent_type_id = f_type_id ");
				sql.append(" start with f_type_id in (select f_type_id");
				sql.append("                            from oa_file_type oft");
				sql.append("                           where oft.f_program_id =");
				sql.append("                                 '"+programId+"'");
				sql.append("                             and f_type_level = '"+FileTypeBean.F_TYPE_LEVEL_THREE+"'");
				sql.append("                             and F_ORG_ID = '"+orgId+"')   order by f_type_order");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"f_type_id"));
						tempVal.put("parent_id", pdb.getString(i,"f_parent_type_id"));
						tempVal.put("open", "true");
						if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(pdb.getString(i,"f_type_level"))){
							tempVal.put("org_id", pdb.getString(i,"f_type_id"));							
						}
						tempVal.put("name", pdb.getString(i,"f_type_name"));
						tempVal.put("allName", pdb.getString(i,"f_type_parentname"));
						tempVal.put("id", pdb.getString(i, "f_type_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					
					tempVal.put("name", "找不到适合的分类");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			}else{
				PreparedDBUtil pdb = new PreparedDBUtil();
				conn = DbManager.getInstance().getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("select distinct oft.*");
				sql.append("  from oa_file_type oft");
				sql.append(" connect by prior f_type_id =  f_parent_type_id");
				sql.append(" start with f_parent_type_id is null and F_ORG_ID = '"+orgId+"' order by f_type_order");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()>0){
					for (int i = 0; i < pdb.size(); i++) {
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("item_id", pdb.getString(i,"f_type_id"));
						tempVal.put("parent_id", pdb.getString(i,"f_parent_type_id"));
						tempVal.put("open", "true");
						tempVal.put("org_id", pdb.getString(i,"f_type_id"));
						tempVal.put("name", pdb.getString(i,"f_type_name"));
						tempVal.put("id", pdb.getString(i, "f_type_id"));
						list.add(tempVal);
					}
				}else{
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("item_code", "a");
					tempVal.put("parent_id", "");
					tempVal.put("open", "true");
					
					tempVal.put("name", "找不到适合的分类");
					tempVal.put("id", "a");
					list.add(tempVal);
				}
			}
			//模拟根节点
			if (0 == list.size()) {
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	
	//财政厅 通知公告内部人员树
	private static final String CZT_NBUSER_TREE = "select o.org_id, t.user_id, t.user_name, t.user_realname,oa_userproperty(ou.org_id, '2') as unit_id from (select rownum index_sn, org.org_id,org.org_name from td_sm_organization org start with org.org_id IN ('000')  connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user t on t.user_id = ou.user_id left join td_sm_userjoborg a  on a.user_id = ou.user_id and ou.org_id = a.org_id where t.user_id is not null and instr((select ',' || config_ids || ','  from oa_dataresources_config  where resources_id = ? and config_typeid = ?  and rownum = 1), ',' || t.user_id || ',') > 0 order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	//财政厅 通知公告外部人员树
	private static final String CZT_WBUSER_TREE = "select o.org_id, t.user_id, t.user_name, t.user_realname,oa_userproperty(ou.org_id, '2') as unit_id from (select rownum index_sn, org.org_id,org.org_name from td_sm_organization org start with org.org_id IN ('001','002')  connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user t on t.user_id = ou.user_id left join td_sm_userjoborg a  on a.user_id = ou.user_id and ou.org_id = a.org_id where t.user_id is not null and instr((select ',' || config_ids || ','  from oa_dataresources_config  where resources_id = ? and config_typeid = ?  and rownum = 1), ',' || t.user_id || ',') > 0 order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeUserTree(财政厅 通知公告内外部人员树)
	* @param bean
	* @return
	 */
	public static Object getNoticeUserTree(TreeBean bean){
		Map<String, String> request = bean.getRequestMap();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String type = request.get("type");
		String pro_type="";
		String treeType = "1";
		String tree_user_type ="";
		if(type.equals("czt_nb_6")||type.equals("czt_wb_6")){
			tree_user_type=type;
			type="6";
		}
		if(type.equals("czt_nb_7")||type.equals("czt_wb_7")){
			tree_user_type=type;
			type="7";
		}
		Map<String, String> tempVal = null;
		String tree_jsondata = "";
		String config_ids = "";
		String cur_unit_id = "";
		String cur_unit_ids = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String path = bean.getRequest().getContextPath();
		
		try {
			
			//查询权限树的类型
			pdb.preparedSelect(TREE_TYPE_ID);
			pdb.setString(1, type);
			pdb.executePrepared();
			if(pdb.size() > 0) {
				treeType = pdb.getString(0, "tree_type");
			} 
			
			//查询配置的权限值
			pdb.preparedSelect(USER_RESOURCES);
			pdb.setString(1, type);
			pdb.setString(2, bean.getUserID());
			pdb.executePrepared();
			
			if(pdb.size() > 0) {
				tree_jsondata = ","+ pdb.getString(0, "tree_jsondata") + ",";
				config_ids = ","+ pdb.getString(0, "config_ids") + ",";
				if("2".equals(treeType)) { //如果是机构树将配置结点与配置结点以上的结点拼接在一起
					tree_jsondata = tree_jsondata + config_ids + ",";
				}
			}
			
			List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
			String userId = bean.getUserID();	
			userCacheBean = UserCache.getUserCacheBean(userId);
			if(userCacheBean != null) {
				cur_unit_ids = "," + userCacheBean.getUnit_ids() + ",";
				cur_unit_id = userCacheBean.getUnit_id();
			}
			//构成机构结点
			for(int i = 0; i < orgCacheBeanList.size(); i++) {
				orgCacheBean = orgCacheBeanList.get(i);
				//内部机构
				if("czt_nb_6".equals(tree_user_type)&&"000".equals(orgCacheBean.getDept_type_id())){
					if("1".equals(treeType) &&  tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1) { //人员树，默认权限，配置权限
						tempVal = new TreeHashMap<String, String>();
							tempVal.put("id", orgCacheBean.getOrg_id());
							tempVal.put("name", orgCacheBean.getOrg_name());
							tempVal.put("item_id", orgCacheBean.getOrg_id());
							tempVal.put("org_id", orgCacheBean.getOrg_id());
							tempVal.put("parent_id", orgCacheBean.getParent_id());
							tempVal.put("org_level", orgCacheBean.getOrg_level());
							if(cur_unit_ids.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1) {
								tempVal.put("open", "true");
							}
							list.add(tempVal);
					} 
				//外部机构
				}else if("czt_wb_6".equals(tree_user_type)&&("001".equals(orgCacheBean.getDept_type_id())||"002".equals(orgCacheBean.getDept_type_id()))){
					if("1".equals(treeType) && (cur_unit_ids.indexOf(","+orgCacheBean.getUnit_id() + ",") > -1 || tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1)) { //人员树，默认权限，配置权限
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", orgCacheBean.getOrg_id());
						tempVal.put("name", orgCacheBean.getOrg_name());
						tempVal.put("item_id", orgCacheBean.getOrg_id());
						tempVal.put("org_id", orgCacheBean.getOrg_id());
						tempVal.put("parent_id", orgCacheBean.getParent_id());
						tempVal.put("org_level", orgCacheBean.getOrg_level());
						if(cur_unit_ids.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1) {
							tempVal.put("open", "true");
						}
						list.add(tempVal);
					}
				}else if("czt_nb_7".equals(tree_user_type)&&"000".equals(orgCacheBean.getDept_type_id())){
					if (tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1
							&& ("1".equals(orgCacheBean.getOrg_level()) || "2".equals(orgCacheBean.getOrg_level())))  {
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", orgCacheBean.getOrg_id());
						tempVal.put("name", orgCacheBean.getOrg_name());
						tempVal.put("item_id", orgCacheBean.getOrg_id());
						tempVal.put("org_id", orgCacheBean.getOrg_id());
						tempVal.put("parent_id", orgCacheBean.getParent_id());
						tempVal.put("org_level", orgCacheBean.getOrg_level());
						list.add(tempVal);
					}
				}else if("czt_wb_7".equals(tree_user_type)&&("001".equals(orgCacheBean.getDept_type_id())||"002".equals(orgCacheBean.getDept_type_id()))){
					if (tree_jsondata.indexOf(","+orgCacheBean.getOrg_id() + ",") > -1
							&& ("1".equals(orgCacheBean.getOrg_level()) || "2".equals(orgCacheBean.getOrg_level())))  {
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", orgCacheBean.getOrg_id());
						tempVal.put("name", orgCacheBean.getOrg_name());
						tempVal.put("item_id", orgCacheBean.getOrg_id());
						tempVal.put("org_id", orgCacheBean.getOrg_id());
						tempVal.put("parent_id", orgCacheBean.getParent_id());
						tempVal.put("org_level", orgCacheBean.getOrg_level());
						list.add(tempVal);
					}
				}
			}
			if("1".equals(treeType)) { //财政厅人员树
				if(tree_user_type.equals("czt_nb_6")){ //内部单位
					pdb.preparedSelect(CZT_NBUSER_TREE);
				}else if(tree_user_type.equals("czt_wb_6")){
					pdb.preparedSelect(CZT_WBUSER_TREE);
				}
				pdb.setString(1, type);
				pdb.setString(2, bean.getUserID());
				pdb.executePrepared();
				for(int j = 0; j < pdb.size(); j++) {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", pdb.getString(j, "user_id"));
					tempVal.put("name", pdb.getString(j, "user_realname"));
					tempVal.put("parent_id", pdb.getString(j, "org_id"));
					tempVal.put("item_id", pdb.getString(j, "user_id"));
					tempVal.put("user_id", pdb.getString(j, "user_id"));
					tempVal.put("item_code", pdb.getString(j, "user_name"));
					tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
					list.add(tempVal);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
	
	/**
	 * 
	 *<b>Summary: </b> inqueryTreeOnePerson(查询机构人员树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeOnePerson(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal = null;
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String userId = bean.getUserID();	
		userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids = "";
		String dept_org = bean.getOrgID();
		  
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		String path = bean.getRequest().getContextPath();
		 
		for(int i = 0; i < orgCacheBeanList.size(); i++) {
			orgCacheBean = orgCacheBeanList.get(i);
			if(!StringUtil.isBlank(dept_org)){//如果不是过滤字段。
				if(dept_org.equals(orgCacheBean.getOrg_id())){
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", orgCacheBean.getOrg_id());
					tempVal.put("name", orgCacheBean.getOrg_name());
					tempVal.put("item_id", orgCacheBean.getOrg_id());

					tempVal.put("org_id", orgCacheBean.getOrg_id());
					tempVal.put("parent_id", orgCacheBean.getParent_id());
					tempVal.put("deptType", orgCacheBean.getOrg_level());
					
					if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
						tempVal.put("open", "true");
					}
					list.add(tempVal);
				}
			}else{
				tempVal = new TreeHashMap<String, String>();
				tempVal.put("id", orgCacheBean.getOrg_id());
				tempVal.put("name", orgCacheBean.getOrg_name());
				tempVal.put("item_id", orgCacheBean.getOrg_id());

				tempVal.put("org_id", orgCacheBean.getOrg_id());
				tempVal.put("parent_id", orgCacheBean.getParent_id());
				tempVal.put("deptType", orgCacheBean.getOrg_level());
				
				if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
					tempVal.put("open", "true");
				}
				list.add(tempVal);
			}
			
		}
		
		List<UserCacheBean> userCacheBeanList = UserCache.getUserCacheBeanList();
		if (userCacheBeanList!=null){
			for(int j = 0; j < userCacheBeanList.size(); j++) {
				userCacheBean = userCacheBeanList.get(j);
				if(!StringUtil.isBlank(dept_org)){//如果不是过滤字段。
					if(dept_org.equals(userCacheBean.getOrg_id())){
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", userCacheBean.getUser_id());
						tempVal.put("name", userCacheBean.getUser_realname());
						tempVal.put("parent_id", userCacheBean.getOrg_id());
						tempVal.put("item_id", userCacheBean.getUser_id());
						tempVal.put("user_id", userCacheBean.getUser_id());
						tempVal.put("item_code", userCacheBean.getUser_name());
						tempVal.put("user_mobiletel1", userCacheBean.getUser_mobiletel1());
						tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
						list.add(tempVal);
					}
					
				}else{
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", userCacheBean.getUser_id());
					tempVal.put("name", userCacheBean.getUser_realname());
					tempVal.put("parent_id", userCacheBean.getOrg_id());
					tempVal.put("item_id", userCacheBean.getUser_id());
					tempVal.put("user_id", userCacheBean.getUser_id());
					tempVal.put("item_code", userCacheBean.getUser_name());
					tempVal.put("user_mobiletel1", userCacheBean.getUser_mobiletel1());
					tempVal.put("icon",path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
					list.add(tempVal);
				}
			}
		}
		
		if (0 == list.size()) {
			return "'none'";
		}

		return list;
	}
}

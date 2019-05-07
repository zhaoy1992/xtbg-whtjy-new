package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.entity.TreeBean;
import com.chinacreator.xtbg.core.common.tree.entity.TreeHashMap;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ListUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:TreeBusinessDaoImpl.javaqueryParentFileTypeForUpdateFileType
 * </p>
 *<p>
 * Description:业务树查询
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 黄艺平
 *@version 1.0 2013-5-15
 */
public class TreeBusinessDaoImpl {

	private static final Log LOG = LogFactory.getLog(TreeBusinessDaoImpl.class);
	private static final String SELECT_RES_ORG_TYPE = "select * from td_sm_organization order by org_sn";
	//private static final String TREE_SELECT_USER = " select o.org_id , t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id = (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	//private static final String TREE_JSONSQL_SELECT = "select userid,treeid,treejson,selectedids from ta_oa_group_resources where userid=? and treeid=?";
	//2013-07-08 新建分组表 ta_oa_group_resources 更改为   oa_group_resources
	private static final String TREE_SELECT_IDS = "select c.config_ids from oa_dataresources_config c where c.resources_id = ?  and c.config_typeid = ?";

	//private static final String TREE_SELECT_USER_1 = " select o.org_id , t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id = (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and t.user_id in (?)　order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	//private static final String SELECT_RES_ORG_TYPE_1 = "select * from td_sm_organization t where t.org_id in (select GETORGLISTBYUSERIDS(?) from  dual) order by org_sn";
	private static final String SELECT_RES_ORG_IFMANAGER = "select *   from td_sm_organization r connect by prior r.org_id = r.parent_id  start with r.org_id = ?  order by r.org_sn";
	private static final String SELECT_DATA_RESOURCES = "select r.resources_id, r.resources_parent_id, r.resources_name, r.tree_type from oa_data_resources r where r.resources_type = '1' and r.is_view = '1'";
	//private static final String SELECT_UNIT = "select * from td_sm_organization o where to_number(o.org_level) < 3 order by o.org_sn";
	//new add 
	private static final String TREE_SELECT_USER_IFMANAGER = " select o.org_id , t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	/**
	*<b>Summary: </b>
	* inqueryTreeOrganization4ids(按机构ids查询过滤机构树的记录集)
	* @param bean
	* @return 
	*/
	public static Object inqueryTreeOrganization4ids(TreeBean bean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			String sql = "select * from td_sm_organization where 1=1 ";
			String org_ids = bean.getRequestMap().get("org_ids");
			if(!StringUtil.nullOrBlank(org_ids)){
				sql+=" and org_id IN ('"+org_ids.replace(",", "','")+"') ";
			}else{
				sql+=" and 1=2";
			}
			sql+="  order by org_sn";
			pdb.executeSelect(sql);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "ORG_ID"));
				tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
				tempVal.put("deptType", pdb.getString(i, "remark4"));
				list.add(tempVal);
			}

			if (0 == list.size()) {
				return "'none'";
			}

			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		return null;
	}

	
	public static Object inqueryTreeShowType(TreeBean bean) {
		Map<String, String> tempVal = new HashMap<String, String>();
		return tempVal;
	}

	/**
	 * 
	 *<b>Summary: 查询得到常用分组</b> getTree2JsonValue(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object getTree2JsonValue(TreeBean bean) {
		// Map<String, String> resp = new HashMap<String, String>();
		String resp = "{'nodes':null}";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String noticetype = request.get("noticetype");
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			if(!StringUtil.nullOrBlank(noticetype)){ //财政厅通知公告拆分内外部通知  add by tao.ren
				pdb.preparedSelect(TREE_JSONSQL_SELECT_CZT);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.setString(3, noticetype);
			}else{
				pdb.preparedSelect(TREE_JSONSQL_SELECT);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
			}
			pdb.executePrepared();
			for (int i = 0; i < pdb.size();) {
				String jsonString = pdb.getString(0, "treejson");
				if ("".equals(jsonString.trim())) {
					jsonString = "null";
				}
				resp = "{\"nodes\":" + jsonString + "," + "\"selectedids\":"
						+ "\"" + pdb.getString(0, "selectedids") + "\"}";
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resp;
	}
	
	
	private static final String TREE_JSONSQL_SELECT = "select userid,treeid,treejson,selectedids from oa_group_resources where userid=? and treeid=?";
	private static final String TREE_JSONSQL_DEL = "delete  oa_group_resources where userid=? and treeid=?";
	private static final String TREE_JSONSQL_INSERT = "insert into oa_group_resources(userid,treeid,treejson,selectedids) values(?,?,?,?)";

	private static final String TREE_JSONSQL_SELECT_CZT = "select userid,treeid,treejson,selectedids from oa_group_resources where userid=? and treeid=? and noticetype =? ";
	private static final String TREE_JSONSQL_DEL_CZT = "delete  oa_group_resources where userid=? and treeid=? and noticetype =?  ";
	private static final String TREE_JSONSQL_INSERT_CZT = "insert into oa_group_resources(userid,treeid,treejson,selectedids,noticetype) values(?,?,?,?,?)";
	/**
	 * 
	 *<b>Summary:保存常用分组信息 </b> getTreeInsertJsonValue(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            树的对象
	 * @return
	 */
	public static Object getTreeInsertJsonValue(TreeBean bean) {
		String resp = "'none'";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String treejson = request.get("treejson");
		String noticetype = request.get("noticetype"); //add by tao.ren
		String selectedids = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			if(!StringUtil.nullOrBlank(noticetype)){ //财政厅通知公告拆分内外部通知  add by tao.ren
				pdb.preparedSelect(TREE_JSONSQL_SELECT_CZT);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.setString(3, noticetype);
				pdb.executePrepared();
				if (pdb.size() > 0) {
					selectedids = pdb.getString(0, "selectedids");
				}
				pdb.preparedDelete(TREE_JSONSQL_DEL_CZT);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.setString(3, noticetype);
				pdb.executePrepared();

				pdb.preparedInsert(TREE_JSONSQL_INSERT_CZT);

				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.setString(3, treejson);
				pdb.setString(4, selectedids);
				pdb.setString(5, noticetype);
				pdb.executePrepared();

			}else{
				pdb.preparedSelect(TREE_JSONSQL_SELECT);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.executePrepared();
				if (pdb.size() > 0) {
					selectedids = pdb.getString(0, "selectedids");
				}
				pdb.preparedDelete(TREE_JSONSQL_DEL);
				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.executePrepared();

				pdb.preparedInsert(TREE_JSONSQL_INSERT);

				pdb.setString(1, bean.getUserID());
				pdb.setString(2, type);
				pdb.setString(3, treejson);
				pdb.setString(4, selectedids);
				pdb.executePrepared();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resp;
	}

	/**
	 * 
	 *<b>Summary:查询用户角色 </b> inqueryPersonRule(请用一句话描述这个方法的作用)
	 * 
	 * @param type
	 * @param userID
	 * @return
	 */
	public static String inqueryPersonRule(String type, String userID) {
		String resp = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(TREE_SELECT_IDS);
			pdb.setString(1, type);
			pdb.setString(2, userID);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size();) {
				resp = pdb.getString(0, "ids");
				break;
			}
		} catch (SQLException e) {
			LOG.error("查询用户角色出现异常", e);
		}

		return resp;
	}

	/**
	 * 根据当前用户信息对allOrgList进行更新
	 * 
	 * @param bean
	 * @param allOrgList
	 * @return
	 */
	public static List<UserOrgStatusBean> updateAllOrgListWithCurUser(
			TreeBean bean, List<UserOrgStatusBean> allOrgList) {
		if ("admin".equals(bean.getUserKey())) {
			UserOrgStatusBean uosBean = new UserOrgStatusBean();
			uosBean.setOrgID(bean.getOrgID());
			allOrgList.add(uosBean);
		}
		return allOrgList;
	}

	/**
	 * 根据条件来加载SelectResOrg语句
	 * 
	 * @param bean
	 *            树的基本bean
	 * @param isCurOrgManager
	 *            是否为当前机构管理员
	 * @param CurOrgId
	 *            当前机构id
	 * @param pdb
	 * @throws SQLException
	 */
	public static void loadSelectResOrgSqlWithCondition(TreeBean bean,
			boolean isCurOrgManager, String CurOrgId, PreparedDBUtil pdb)
			throws SQLException {
		Map<String, String> request = bean.getRequestMap();
		String select_res_org = "";

		String isManager = request.get("isManager");// 当前用户是否为管理员（不包括系统管理员）
		if ("true".equals(isManager) && !"admin".equals(bean.getUserKey())) {
			if (isCurOrgManager) {// 判断用户在指定的机构中是否为管理员
				select_res_org = SELECT_RES_ORG_IFMANAGER;
				pdb.preparedSelect(select_res_org);
				int p = 1;
				pdb.setString(p++, CurOrgId);
			}
		} else {
			select_res_org = SELECT_RES_ORG_TYPE;
			pdb.preparedSelect(select_res_org);
		}
		// sql不为空才执行
		if (!StringUtil.nullOrBlank(select_res_org)) {
			pdb.executePrepared();
		} else {
			clearPdbUtilResult(pdb);// 必须清空结果集
		}

	}

	/**
	 * 清空pdbUtil中的结果集，避免被再次使用
	 * 
	 * @param pdb
	 * @throws SQLException
	 */
	public static void clearPdbUtilResult(PreparedDBUtil pdb)
			throws SQLException {
		pdb.preparedSelect("select * from dual where 1=2");
		pdb.executePrepared();
	}

	@SuppressWarnings("unchecked")
	public static Object inqueryTreeReportOrganization(TreeBean bean) {
		List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();// 获取公共servlet中塞入的用户全部机构信息
		PreparedDBUtil pdb = new PreparedDBUtil();
		IOrgManagerExt om = new OrgManagerExtImpl();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			allOrgList = updateAllOrgListWithCurUser(bean, allOrgList);
			/*
			 * 2013.3.22 修改为根据用户的所有机构来查看 by tian.xia
			 */
			for (UserOrgStatusBean uosBean : allOrgList) {
				/*
				 * 是否为当前机构管理员
				 */
				boolean isCurOrgManager = om.isCurOrgManager(
						uosBean.getOrgID(), bean.getUserID());
				loadSelectResOrgSqlWithCondition(bean, isCurOrgManager, uosBean
						.getOrgID(), pdb);
				Map<String, String> tempVal = null;

				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType", pdb.getString(i, "remark4"));
					setOpenValue(tempVal, pdb.getString(i, "remark4"), bean);
					list.add(tempVal);
				}
			}
			if (0 == list.size()) {
				return "'none'";
			}
			/* 《如果需要向上遍历展开树的所有根节点，则要做排重处理》 */
			list = (ArrayList<Map<String, String>>) listRemoveDuplicateIfNotAdmin(
					bean, list);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据条件来设置树节点的展开
	 * 
	 * @param val
	 * @param remark4
	 * @param bean
	 */
	private static void setOpenValue(Map<String, String> val, String remark4,
			TreeBean bean) {
		Map<String, String> request = bean.getRequestMap();
		String isManager = request.get("isManager");// 当前用户是否为管理员（不包括系统管理员）
		String onelevel = request.get("onelevel");// 苏仙项目的全机构树只展开一层
		if (null != remark4 && !"".equals(remark4)) {
			int temp = 2;
			try {
				temp = Integer.parseInt(remark4.substring(1, 2));

			} catch (Exception e) {
			}
			;

			if (("A".equals(remark4.substring(0, 1)) && temp < 2)
					|| (!"A".equals(remark4.substring(0, 1)) && temp < 1)) {
				val.put("open", "true");
			}
			if ("true".equals(isManager) && !isAdmin(bean)) {// 管理员的节点都展开
				val.put("open", "true");
			}
			if ("true".equals(onelevel)) {// 苏仙项目的全机构树只展开顶层
				if ("0".equals(val.get("parent_id"))) {
					val.put("open", "true");
				} else {
					val.put("open", "false");
				}
			}
		}
	}

	/**
	 * 
	 *<b>Summary: 判断是否管理员</b> isAdmin(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 * @return
	 */
	public static boolean isAdmin(TreeBean bean) {
		return "admin".equals(bean.getUserKey());
	}

	/**
	 * 
	 *<b>Summary: </b> ListRemoveDuplicateIfNotAdmin(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 * @param list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List listRemoveDuplicateIfNotAdmin(TreeBean bean, List list) {
		if (!isAdmin(bean))// 如果是admin则不排重，因为排重需要消耗性能
			list = ListUtil.removeDuplicateWithOrder(list);
		return list;
	}

	/**
	 * 
	 *<b>Summary: </b> inqueryTreeUser(根据用户ID查询机构树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeUser(TreeBean bean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String ru_logn = bean.getRequestMap().get("ru_logn");
		String user = bean.getRequestMap().get("user");
		String path = bean.getRequest().getContextPath();
		Map<String, String> tempVal = null;
		try { // TODO 此处是否可以改造成预编译。
			
			if(!StringUtil.isBlank(ru_logn)) {
				String ruDataSql = "select ru.ru_data from oa_recently_user ru where ru.ru_logn='"+ru_logn+"' and ru.user_id = '"+bean.getUserID()+"'";
				pdb.executeSelect(ruDataSql);
				String ru_data = "";
				if (pdb.size() > 0) {
					ru_data = pdb.getString(0, "ru_data");
					if(!StringUtil.isBlank(ru_data)) {
						user = ru_data;
					}
				}
			}
			
			if(!StringUtil.isBlank(user) && !"undefined".equals(user)) {
				String sql0 = "select to_char(OA_GETORGLISTBYUSERIDS('"
						+ user
						+ "')) as  org_ids from dual";
				pdb.executeSelect(sql0);
				String org_ids = "";
				if (pdb.size() > 0) {
					org_ids = pdb.getString(0, "org_ids");
				}
				String sql = "select * from td_sm_organization t ";
				if (!StringUtil.nullOrBlank(org_ids)){
					sql+= " where t.org_id in ("+ org_ids + ") order by org_sn";
				}else{
					sql+= " where 1=2                          order by org_sn";
				}
				pdb.executeSelect(sql);
	
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
	
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType", pdb.getString(i, "remark4"));
					list.add(tempVal);
				}
				if(!StringUtil.nullOrBlank(user)){
					String sql1 = "select o.org_id , t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and t.user_id in ("
						+ user
						+ ")　order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
					pdb.executeSelect(sql1);
		
					for (int j = 0; j < pdb.size(); j++) {
						tempVal = new TreeHashMap<String, String>();
						tempVal.put("id", pdb.getString(j, "user_id"));
						tempVal.put("name", pdb.getString(j, "user_realname"));
						tempVal.put("parent_id", pdb.getString(j, "org_id"));
		
						tempVal.put("item_id", pdb.getString(j, "user_id"));
		
						tempVal.put("user_id", pdb.getString(j, "user_id"));
						tempVal.put("item_code", pdb.getString(j, "user_name"));
		
						tempVal.put("icon",
								path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
						list.add(tempVal);
					}
				}
			
			}
			if (0 == list.size()) {
				return "'none'";
			}

			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		return null;

	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selDataResources(查询数据资源数据)
	* @param bean
	* @return
	 */
	public static Object selDataResources(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = null;
		try {
			list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
			pdb.preparedSelect(SELECT_DATA_RESOURCES);
			pdb.executePrepared();
			if(0 == pdb.size()){
				return "'none'";
			}
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "resources_id"));
				tempVal.put("item_id", pdb.getString(i, "resources_id"));
				tempVal.put("name", pdb.getString(i, "resources_name"));
				tempVal.put("parent_id", pdb.getString(i, "resources_parent_id"));
				tempVal.put("open", "true");
				tempVal.put("treeType", pdb.getString(i, "tree_type"));
				list.add(tempVal);
			}
			
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selAllUserrTree(查询机构用户所有的树)
	* @param bean
	* @return
	 */
	public static Object selAllUserrTree(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal = null;
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String userId = bean.getUserID();	
		userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids = "";
		if(userCacheBean != null) {
			orgids = "," + userCacheBean.getUnit_ids() + ",";
		}
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		 
		for(int i = 0; i < orgCacheBeanList.size(); i++) {
			orgCacheBean = orgCacheBeanList.get(i);
			tempVal = new TreeHashMap<String, String>();
			tempVal.put("id", orgCacheBean.getOrg_id());
			tempVal.put("name", orgCacheBean.getOrg_name());
			tempVal.put("item_id", orgCacheBean.getOrg_id());

			tempVal.put("org_id", orgCacheBean.getOrg_id());
			tempVal.put("parent_id", orgCacheBean.getParent_id());
			
			if(orgids.indexOf(orgCacheBean.getOrg_id()) > -1) {
				tempVal.put("open", "true");
			}
			list.add(tempVal);
		}
		
		List<UserCacheBean> userCacheBeanList = UserCache.getUserCacheBeanList();
		
		for(int j = 0; j < userCacheBeanList.size(); j++) {
			userCacheBean = userCacheBeanList.get(j);
			tempVal = new TreeHashMap<String, String>();
			tempVal.put("id", userCacheBean.getUser_id());
			tempVal.put("name", userCacheBean.getUser_realname());
			tempVal.put("parent_id", userCacheBean.getOrg_id());
			tempVal.put("item_id", userCacheBean.getUser_id());
			tempVal.put("user_id", userCacheBean.getUser_id());
			tempVal.put("item_code", userCacheBean.getUser_name());
			tempVal.put("icon","../../../resources/style/blue/images/user_nonFolder.gif");
			list.add(tempVal);
		}
		
		if (0 == list.size()) {
			return "'none'";
		}

		return list;

	}
	
	/**
	 * 
	 *<b>Summary: </b> selAllUnit(查询所有的单位树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object selAllUnit(TreeBean bean) {

		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		OrgCacheBean orgCacheBean = null;
		Map<String, String> tempVal = null;
		String userId = bean.getUserID();	
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids = "";
		if(userCacheBean != null) {
			orgids = "," + userCacheBean.getUnit_ids() + ",";
		}
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();

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
	 * selMyUnit(获得当前用户所在单位和部分tree)
	 * @param bean
	 * @return
	 */
	public static Object selMyUnit(TreeBean bean) {
		String userId = bean.getUserID();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if(userId!=null){
			UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
			if(userCacheBean != null&&userCacheBean.getUnit_id()!=null) {
				String unitId = userCacheBean.getUnit_id();
				StringBuffer sql = new StringBuffer();
				sql.append("select *");
				sql.append("  from (select tso.*,");
				sql.append("               OA_USERPROPERTY(tso.org_id, '2') unit_id,");
				sql.append("               OA_USERPROPERTY(tso.org_id, '1') as unit_name");
				sql.append("          from td_sm_organization tso) tso");
				sql.append(" where tso.unit_id = '"+unitId+"'");
				sql.append(" order by tso.org_sn");
				Connection conn = null;
				try{
					PreparedDBUtil pdb = new PreparedDBUtil();
					pdb.preparedSelect(sql.toString());
					conn = DbManager.getInstance().getConnection();
					pdb.executePrepared(conn);
					
					//循环添加部门
					for (int i = 0; i < pdb.size(); i++) {
						if(!unitId.equals(pdb.getString(i,"org_id"))){
							Map<String, String> tempVal = new HashMap<String, String>();
							//ztree必须
							tempVal.put("id", pdb.getString(i,"org_id"));
							tempVal.put("item_id", pdb.getString(i,"org_id"));
							//tempVal.put("parent_id",unitId);
							tempVal.put("parent_id",pdb.getString(i,"parent_id"));
							tempVal.put("name", pdb.getString(i,"org_name"));
							tempVal.put("open", "true");
							//自定义:依赖于:ifrom-ui-ztree.1.1.js:function OK
							//s.isType = "dept" + tempVal.put("org_id") 才能是页面得到id
							tempVal.put("org_id",pdb.getString(i,"org_id"));
							list.add(tempVal);
						}
					}
					//添加机构
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("id", unitId);
					tempVal.put("item_id", unitId);
					tempVal.put("parent_id","");
					tempVal.put("name", userCacheBean.getUnit_name());
					tempVal.put("open", "true");
					tempVal.put("org_id",unitId);
					list.add(tempVal);
				}catch(Exception e){
					LOG.error(e.getMessage(), e);
				}finally{
					DbManager.closeConnection(conn);
				}
			}
		}
		if (0 == list.size()){
			return "'none'";
		}
		return list;
	}
	/**
	 * 
	*<b>Summary: </b>
	* selUserSelectValue(查询用户选中的值)
	* @param bean
	* @return
	 */
	public static Object selUserSelectValue(TreeBean bean){
    	String resp ="'none'";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String userID = request.get("selectUserId");

		
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(TREE_SELECT_IDS);
			pdb.setString(1, type);
			pdb.setString(2, userID);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size();) {
				resp = pdb.getString(0, "config_ids");
				if(null == resp || "".equals(resp.trim())){
					resp ="'none'";
				}
				else{
					resp = "'"+resp+"'";
				}
				break;
			}
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}
		
		return resp;
    }
	
	private static final String INSERT_RES = "insert into oa_dataresources_config (config_id, resources_id,config_type,config_typeid,config_range,creator_time,tree_jsondata,config_ids) values(?,?,'2',?,'2',sysdate,?,?)";
    private static final String DEL_RES = "delete oa_dataresources_config c where c.config_typeid = ? and c.resources_id = ?";
    /**
     * 
    *<b>Summary: </b>
    * batchSaveDateResources(保存资源配置)
    * @param bean
    * @return
     */
	public static Object batchSaveDateResources(TreeBean bean){
    	String resp ="'none'";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String userIds = request.get("userIds");
		String selectUserIds = request.get("selectUserIds");
		String json =  request.get("json");
		if(userIds == null || "".equals(userIds)){
			return resp;
		}
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			String[] userArray = userIds.split(",");
			for (int i = 0; i < userArray.length; i++) {
				pdb.preparedDelete(DEL_RES);
				pdb.setString(1, userArray[i]);
				pdb.setString(2, type);
				pdb.addPreparedBatch();
				pdb.preparedInsert(INSERT_RES);
				pdb.setString(1, StringUtil.getUUID());
				pdb.setString(2, type);
				pdb.setString(3, userArray[i]);
				pdb.setString(4, json);
				pdb.setString(5, selectUserIds);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch();
			
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
    	
    	return resp;
    }
		
	/**
	 * 
	 *<b>Summary: </b>
	 * queryUserGroup(获得用户组列表)
	 * @param bean
	 * @return
	 */
	public static Object queryUserGroup(TreeBean bean) {
		Connection conn = null;
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT TSG.GROUP_ID, TSG.GROUP_NAME||':'||TSG.GROUP_DESC GROUP_NAME, TSG.PARENT_ID");
			sql.append("  FROM TD_SM_GROUP TSG");
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql.toString());
			conn = DbManager.getInstance().getConnection();
			pdb.executePrepared(conn);
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			for (int i = 0; i < pdb.size(); i++) {
				Map<String, String> tempVal = new HashMap<String, String>();
				//ztree必须
				tempVal.put("item_id", pdb.getString(i, "GROUP_ID"));
				tempVal.put("parent_id",pdb.getString(i, "PARENT_ID"));
				tempVal.put("name", pdb.getString(i, "GROUP_NAME"));
				tempVal.put("open", "true");
				//自定义:依赖于:ifrom-ui-ztree.1.1.js:function OK
				//s.isType = "dept" + tempVal.put("org_id") 才能是页面得到id
				tempVal.put("org_id",pdb.getString(i, "GROUP_ID"));
				list.add(tempVal);
			}
			//添加根节点:根节点没有org_id,不会被选中
			Map<String, String> tempVal = new HashMap<String, String>();
			tempVal.put("item_id", "0");
			tempVal.put("parent_id","");
			tempVal.put("name", "[所有用户组]");
			tempVal.put("open", "true");
			list.add(tempVal);
			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	*<b>Summary:查询档案存放位置 </b>
	* queryFileAddress()
	* @param bean
	* @return
	 */
	public static Object queryFileAddress(TreeBean bean) {

		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select f_storage_id,");
			sql.append("       f_storage_shotname,");
			sql.append("       f_storage_fullname,");
			sql.append("       f_org_id,");
			sql.append("       f_org_name,");
			sql.append("       f_perant_id,");
			sql.append("       f_remark,");
			sql.append("       f_user_id,");
			sql.append("       f_user_name,");
			sql.append("       f_creator_time,");
			sql.append("       f_storage_urlname,");
			sql.append("       f_dept_id,");
			sql.append("       f_dept_name");
			sql.append("  from oa_file_storage_location");
			sql.append(" where f_storage_id is not null ");
		    Map<String,String> requestMap = bean.getRequestMap();
		    
		    if(!StringUtil.nullOrBlank(requestMap.get("ids"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("ids").replaceAll("'", "")
						+",',','||f_storage_id||',')>0");
			}
			if(!StringUtil.nullOrBlank(requestMap.get("f_org_id"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("f_org_id").replaceAll("'", "")
						+",',','||f_org_id||',')>0");
			}
			if(!StringUtil.nullOrBlank(requestMap.get("f_dept_id"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("f_dept_id").replaceAll("'", "")
						+",',','||f_dept_id||',')>0");
			}
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("item_code",  pdb.getString(i, "f_storage_id"));
				tempVal.put("org_id", pdb.getString(i,"f_org_id"));
				tempVal.put("item_id",  pdb.getString(i, "f_storage_id"));				
				tempVal.put("id", pdb.getString(i, "f_storage_id"));
				tempVal.put("parent_id", pdb.getString(i, "f_perant_id"));
				tempVal.put("name", pdb.getString(i, "f_storage_shotname"));
				tempVal.put("deptType", pdb.getString(i, "f_remark"));				
				tempVal.put("open", "true");
				tempVal.put("f_storage_id",  pdb.getString(i, "f_storage_id"));
				tempVal.put("f_org_id", pdb.getString(i, "f_org_id"));
				tempVal.put("f_org_name", pdb.getString(i, "f_org_name"));
				tempVal.put("f_storage_urlname", pdb.getString(i, "f_storage_urlname"));
				tempVal.put("f_creator_time", pdb.getString(i, "f_creator_time"));
				tempVal.put("f_user_id", pdb.getString(i, "f_user_id"));
				tempVal.put("f_user_name", pdb.getString(i, "f_user_name"));
				tempVal.put("f_remark", pdb.getString(i, "f_remark"));
				tempVal.put("f_dept_id", pdb.getString(i, "f_dept_id"));
				tempVal.put("f_dept_name", pdb.getString(i, "f_dept_name"));
				list.add(tempVal);
			}

			if (0 == list.size()) {
				return "'none'";
			}

			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	
	
	/**
	 * 
	*<b>Summary:查询档案类型</b>
	* queryFileAddress()
	* @param bean
	* @return
	 */
	public static Object queryFileType(TreeBean bean) {

		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select * ");
			sql.append("   from oa_file_type");
			sql.append("  where f_type_id is not null ");
		    Map<String,String> requestMap = bean.getRequestMap();
		    if(!StringUtil.nullOrBlank(requestMap.get("ids"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("ids").replaceAll("'", "")
						+",',','||f_type_id||',')>0");
			}
			//根据单位id筛选
		    if(!StringUtil.nullOrBlank(requestMap.get("f_org_id"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("f_org_id").replaceAll("'", "")
						+",',','||f_org_id||',')>0");
			}
			//根据部门id筛选
			if(!StringUtil.nullOrBlank(requestMap.get("f_dept_id"))){
				//允许传入多个id
				sql.append(" and instr (',"
						+requestMap.get("f_dept_id").replaceAll("'", "")
						+",',','||f_dept_id||',')>0");
			}
			sql.append(" order by f_type_order asc ");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				//树需要的
				tempVal.put("item_code",  pdb.getString(i, "f_type_id"));
				tempVal.put("org_id", pdb.getString(i,"f_org_id"));
				tempVal.put("item_id",  pdb.getString(i, "f_type_id"));				
				tempVal.put("id", pdb.getString(i, "f_type_id"));
				tempVal.put("parent_id", pdb.getString(i, "f_parent_type_id"));
				tempVal.put("name", pdb.getString(i, "f_type_name"));
				tempVal.put("deptType", pdb.getString(i, "f_type_id"));	
				tempVal.put("open", "true");
				//自己的
				tempVal.put("f_type_id",  pdb.getString(i, "f_type_id"));
				tempVal.put("f_parent_type_id", pdb.getString(i, "f_parent_type_id"));
				tempVal.put("f_type_name", pdb.getString(i, "f_type_name"));
				tempVal.put("f_type_level", pdb.getString(i, "f_type_level"));
				tempVal.put("f_org_id", pdb.getString(i, "f_org_id"));
				tempVal.put("f_org_name", pdb.getString(i, "f_org_name"));
				tempVal.put("f_dept_id", pdb.getString(i, "f_dept_id"));
				tempVal.put("f_dept_name", pdb.getString(i, "f_dept_name"));
				tempVal.put("f_typeno", pdb.getString(i, "f_typeno"));
				tempVal.put("f_type_order", pdb.getString(i, "f_type_order"));
				tempVal.put("f_type_parentname", pdb.getString(i, "f_type_parentname"));
				tempVal.put("f_type_parentid", pdb.getString(i, "f_type_parentid"));
				tempVal.put("f_type_table", pdb.getString(i, "f_type_table"));
				list.add(tempVal);
			}

			if (0 == list.size()) {
				return "'none'";
			}

			return list;
		} catch (SQLException e) {
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	
	
	/**
	 * new add  -------------
	*<b>Summary: </b>
	* inqueryTreePerson4Other(单位通讯录人员)
	* @param bean
	* @return 
	*/
	public static Object inqueryTreePerson4Other(TreeBean bean){
		Map<String, String> request = bean.getRequestMap();
		String AllOpen = request.get("AllOpen");//是否全展开
		List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	PreparedDBUtil pdb1 = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	Map<String,String> tempVal = null;
    	String path = bean.getRequest().getContextPath();
    	try {
    		
    		allOrgList = updateAllOrgListWithCurUser(bean,allOrgList);
    		
    		/*
    		 * 2013.3.22 修改为根据用户的所有机构来查看 by tian.xia
    		 */
    		for(UserOrgStatusBean uosBean : allOrgList ){
    			/*
    			 * 是否为当前机构管理员
    			 */
    			boolean isCurOrgManager = om.isCurOrgManager(uosBean.getOrgID(),bean.getUserID());
    			loadSelectResOrgSqlWithCondition(bean,isCurOrgManager, uosBean.getOrgID(), pdb);
                
    			for(int i = 0; i < pdb.size(); i++){
    				tempVal = new TreeHashMap<String, String>();
    				tempVal.put("id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
    				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
    				tempVal.put("deptType",  pdb.getString(i, "remark4"));
    				/*该方法于2013.3.19关闭，此需求暂不考虑，by tian.xia,yiping.huang
    				 * 2013.3.21 方法开启,不过需要AllOpen参数为true,
    				 * 修改原因是因为影响到了资源配置管理中的人员树的全展开
    				 * setOpenValue(tempVal,pdb.getString(i, "remark4"));*/
    				if("true".equals(AllOpen)){
    					setOpenValue(tempVal,pdb.getString(i, "remark4"),bean);
    				}
    				list.add(tempVal);
    				

    				loadTreeSelectUserSqlWithCondition(bean,isCurOrgManager,pdb.getString(i, "ORG_ID"),pdb1,false);
        				
    				for(int j = 0; j < pdb1.size(); j++){
    					
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("user_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb1.getString(j, "org_id"));
    					tempVal.put("icon", path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}

    				
    			}
    	
				
    		}		
            if(0 == list.size()){
				return "'none'";
			}
            if(!isAdmin(bean))//如果是admin则不排重，因为排重需要消耗大量性能
                list = (ArrayList<Map<String,String>>)ListUtil.removeDuplicateWithOrder(list);
    		return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
    
    /**
    *<b>Summary: </b>
    * loadTreeSelectUserSqlWithCondition
    * @param bean
    * @param isCurOrgManager
    * @param CurOrgId
    * @param pdb
    * @param isValidOrgManager
    * @throws SQLException 
    */
    public static void loadTreeSelectUserSqlWithCondition(TreeBean bean,boolean isCurOrgManager,String CurOrgId,PreparedDBUtil pdb,boolean isValidOrgManager) throws SQLException{
    	Map<String, String> request = bean.getRequestMap();
    	String isNotUserVaild = request.get("isNotUserVaild");//不许要验证用户的user_isvalid
		String isManager = request.get("isManager");//当前用户是否为管理员（不包括系统管理员）
    	String tree_select_user = TREE_SELECT_USER_IFMANAGER;
		boolean ifmanager = false;//是否为管理员
		if("true".equals(isManager) && !"admin".equals(bean.getUserKey())){
			if(isCurOrgManager || !isValidOrgManager)//如果是当前机构管理员
				tree_select_user = TREE_SELECT_USER_IFMANAGER;
			else
				tree_select_user = "";
			ifmanager = true;
		}
		if("true".equals(isNotUserVaild))
			tree_select_user = tree_select_user.replace("and t.user_isvalid != '3'", "");
		
		//sql不为空才执行
		if(!StringUtil.nullOrBlank(tree_select_user)){
			pdb.preparedSelect(tree_select_user);

				int p = 1;
				pdb.setString(p++, CurOrgId);
			pdb.executePrepared();
		}else{
			clearPdbUtilResult(pdb);
		}
    }
    
    //个人通讯录
	private static final String group_name="select distinct g.group_id, g.group_name,g.user_id from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id  where user_id = ? and is_public_group = '0'";
	private static final String group_person="select t.person_id,name,(select t1.field_value from oa_personwork_extrainfo t1 where t1.person_id = t.person_id and t1.field_name = '办公手机' and rownum = 1) commonlymobile," 
										+ " (select to_char(wmsys.wm_concat(g.group_name)) from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id where t.person_id = t1.person_id) " 
										+ " group_name, (select to_char(wmsys.wm_concat(t1.group_id)) from oa_personwork_persongroup t1  where t.person_id = t1.person_id) group_id, '个人通讯录' as info_source_name,  t.user_id," 
										+ " t.eng_name from oa_personwork_personinfo t   where t.info_type = 'personal'  and t.is_public = '0'  and t.user_id= ? ";
	
	/**
	*<b>Summary: </b>
	* inqueryTreeGrtxl(个人通讯录)
	* @param bean
	* @return 
	*/
	public static Object inqueryTreeGrtxl(TreeBean bean){
			PreparedDBUtil pdb = new PreparedDBUtil();
			try {
				pdb.preparedSelect(group_name); //个人通讯录组名
				pdb.setString(1, bean.getUserID());
				pdb.executePrepared();
				ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
				Map<String,String> tempVal = null;
				String path = bean.getRequest().getContextPath();
				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "group_id"));
					tempVal.put("user_id", "");
					tempVal.put("item_id", pdb.getString(i, "group_id"));
					tempVal.put("name", pdb.getString(i, "group_name"));
					tempVal.put("parent_id", pdb.getString(i, "group_id"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				
				pdb.preparedSelect(group_person);
				pdb.setString(1, bean.getUserID());
				pdb.executePrepared();
				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "person_id"));
					tempVal.put("user_id", pdb.getString(i, "person_id"));
					tempVal.put("item_id", pdb.getString(i, "person_id"));
					tempVal.put("name", pdb.getString(i, "name"));
					tempVal.put("parent_id", pdb.getString(i, "group_id"));
					tempVal.put("icon",path+"ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
					list.add(tempVal);
				}
				 if(0 == list.size()){
						return "'none'";
					}
				return list;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return null;
	 }
	//公共通讯录
	private static final String public_group_name="select distinct  g.group_id, g.group_name,g.user_id from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id  where is_public_group='1'";
	private static final String public_group_person="select t.person_id,name,(select t1.field_value from oa_personwork_extrainfo t1 where t1.person_id = t.person_id and t1.field_name = '办公手机' and rownum = 1) commonlymobile," 
		+ " (select to_char(wmsys.wm_concat(g.group_name)) from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id where t.person_id = t1.person_id) " 
		+ " group_name, (select to_char(wmsys.wm_concat(t1.group_id)) from oa_personwork_persongroup t1  where t.person_id = t1.person_id) group_id, '个人通讯录' as info_source_name,  t.user_id," 
		+ " t.eng_name from oa_personwork_personinfo t  where t.info_type = 'personal'  and t.is_public = '1' ";
	
	/**
	*<b>Summary: </b>
	* publicinqueryTreeGrtxl(公共通讯录)
	* @param bean
	* @return 
	*/
	public static Object publicinqueryTreeGrtxl(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(public_group_name); //公共通讯录组名
			pdb.executePrepared();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
			String path = bean.getRequest().getContextPath();
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "group_id"));
				tempVal.put("user_id","");
				tempVal.put("item_id", pdb.getString(i, "group_id"));
				tempVal.put("name", pdb.getString(i, "group_name"));
				tempVal.put("parent_id", pdb.getString(i, "group_id"));
				tempVal.put("open", "true");
				list.add(tempVal);
			}
			
			pdb.preparedSelect(public_group_person);
			pdb.executePrepared();
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "person_id"));
				tempVal.put("user_id", pdb.getString(i, "person_id"));
				tempVal.put("item_id", pdb.getString(i, "person_id"));
				tempVal.put("name", pdb.getString(i, "name"));
				tempVal.put("parent_id", pdb.getString(i, "group_id"));
				tempVal.put("icon", path+"/ccapp/oa/resources/style/blue/images/user_nonFolder.gif");
				list.add(tempVal);
			}
			if(0 == list.size()){
				return "'none'";
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	*<b>Summary: </b>
	* queryKbmDocTypeTree(知识分类树)
	* @param bean
	* @return 
	*/
	public static Object queryKbmDocTypeTree(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			//Map<String,String> requestMap = bean.getRequestMap();
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select *");
			sql.append("  from oa_kbm_doc_type");
			/*if(!StringUtil.isBlank(requestMap.get("k_unit"))){
				
				sql.append(" where k_type_unit = '"+requestMap.get("k_unit")+"'");
			}*/
			sql.append(" order by k_type_order");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				//树需要的
				tempVal.put("user_id", pdb.getString(i, "k_type_id"));
				tempVal.put("id", pdb.getString(i, "k_type_id"));
				tempVal.put("item_code", pdb.getString(i, "k_type_id"));
				tempVal.put("k_type_id", pdb.getString(i, "k_type_id"));
				tempVal.put("name", pdb.getString(i, "k_type_name"));
				tempVal.put("parent_id", pdb.getString(i, "k_parent_type_id"));	
				tempVal.put("open", "true");
				tempVal.put("item_id",  pdb.getString(i, "k_type_id"));	
				tempVal.put("deptType", pdb.getString(i, "k_type_id"));	
				
				tempVal.put("k_remark", pdb.getString(i, "k_remark"));
				tempVal.put("k_content_template", pdb.getString(i, "k_content_template"));
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
		return null;
	}
	
	/**
	*<b>Summary: </b>
	* queryPsdataTypeTree(个人资料分类树)
	* @param bean
	* @return 
	*/
	public static Object queryPsdataTypeTree(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			Map<String,String> requestMap = bean.getRequestMap();
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select *");
			sql.append("  from oa_persondata_type  where 1=1 ");
			//所属机构
			if(!StringUtil.isBlank(requestMap.get("p_type_unit"))){
				
				sql.append(" and p_type_unit = '"+requestMap.get("p_type_unit")+"'");
			}
			//当前用户ID
			if(!StringUtil.isBlank(requestMap.get("user_id"))){
				
				sql.append(" and p_creater_userid = '"+requestMap.get("user_id")+"'");
			}
			sql.append(" order by p_type_order");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				//树需要的
				tempVal.put("id", pdb.getString(i, "p_type_id"));
				tempVal.put("org_id", pdb.getString(i, "p_type_id"));
				tempVal.put("item_code", pdb.getString(i, "p_type_id"));
				tempVal.put("p_type_id", pdb.getString(i, "p_type_id"));
				tempVal.put("name", pdb.getString(i, "p_type_name"));
				tempVal.put("parent_id", pdb.getString(i, "p_type_parentid"));	
				tempVal.put("open", "true");
				tempVal.put("item_id",  pdb.getString(i, "p_type_id"));	
				tempVal.put("deptType", pdb.getString(i, "p_type_id"));	
				
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
		return null;
	}
	/**
	*<b>Summary: </b>
	* queryPsdataTypeTree(资料分类树)
	* @param bean
	* @return 
	*/
	public static Object queryDataTypeTree(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			Map<String,String> requestMap = bean.getRequestMap();
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select *");
			sql.append("  from oa_data_type  where 1=1  ");
			if("parent".equals(requestMap.get("typeis"))){
				sql.append("  and d_type_level='1'  ");
			}else{
				sql.append("  and d_type_level='2'  ");
			}
			//所属机构
			if(!StringUtil.isBlank(requestMap.get("d_data_unit_id"))){
				
				sql.append(" and d_type_unit_id = '"+requestMap.get("d_data_unit_id")+"'");
			}
			
			
			sql.append(" order by d_type_order");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				//树需要的
				tempVal.put("id", pdb.getString(i, "d_type_id"));
				tempVal.put("org_id", pdb.getString(i, "d_type_id"));
				tempVal.put("item_code", pdb.getString(i, "d_type_id"));
				tempVal.put("p_type_id", pdb.getString(i, "d_type_id"));
				tempVal.put("name", pdb.getString(i, "d_type_name"));
				tempVal.put("parent_id", pdb.getString(i, "d_type_parent_id"));	
				tempVal.put("open", "true");
				tempVal.put("item_id",  pdb.getString(i, "d_type_id"));	
				tempVal.put("deptType", pdb.getString(i, "d_type_id"));	
				
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
		return null;
	}
	
	/**
	 * 
	 *<b>Summary: </b> inqueryTreeMeetingPerson(查询机构人员树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeMeetingPerson(TreeBean bean) {
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> tempVal = null;
		OrgCacheBean orgCacheBean = null;
		UserCacheBean userCacheBean = null;
		String userId = bean.getUserID();	
		userCacheBean = UserCache.getUserCacheBean(userId);
		String orgids = "";
		if(userCacheBean!=null) orgids = "," + userCacheBean.getUnit_ids() + ",";
		List<OrgCacheBean> orgCacheBeanList = OrgCache.getOrgCacheBeanList();
		String path = bean.getRequest().getContextPath();
		
		//得到传来的userids参数
		Map<String, String> requestMap=bean.getRequestMap();
		String userids=","+requestMap.get("userids")+",";
		
		for(int i = 0; i < orgCacheBeanList.size(); i++) {
			orgCacheBean = orgCacheBeanList.get(i);
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
		
		List<UserCacheBean> userCacheBeanList = UserCache.getUserCacheBeanList();
		if (userCacheBeanList!=null){
			for(int j = 0; j < userCacheBeanList.size(); j++) {
				userCacheBean = userCacheBeanList.get(j);
				
				//判断用户是否存在userids,存在让他不可点
				if(userids.indexOf(","+userCacheBean.getUser_id()+",")==-1){
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
	
	/**
	 * 查询档案分类类型为 修改父级档案分类
	 *<b>Summary: </b>
	 * queryParentFileTypeForUpdateFileType(请用一句话描述这个方法的作用)
	 * @param bean
	 * @return
	 */
	public static Object queryParentFileTypeForUpdateFileType(TreeBean bean) {
		Map<String,String> requestMap = bean.getRequestMap();
		String moveLevel = requestMap.get("moveLevel");
		String thisFileType = requestMap.get("thisFileType");
		String orgId = requestMap.get("orgId");
		
		StringBuffer sql = new StringBuffer();
		if(!StringUtil.nullOrBlank(thisFileType)){
			if(FileTypeBean.F_TYPE_LEVEL_TWO.equals(moveLevel)){
				sql.append("select *");
				sql.append("  from oa_file_type");
				sql.append(" where f_type_id not in");
				sql.append("       (select f_type_id");
				sql.append("          from oa_file_type");
				sql.append("         start with f_type_id = '"+thisFileType+"'");
				sql.append("        connect by prior f_type_id = f_parent_type_id)");
				sql.append("   and f_org_id = '"+orgId+"'");
				sql.append("   and (f_type_level = '1' or f_type_level = '2')");
				sql.append(" order by f_type_order");
			}else if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(moveLevel)){
				sql.append("select *");
				sql.append("  from oa_file_type");
				sql.append(" where f_type_id not in");
				sql.append("       (select f_type_id");
				sql.append("          from oa_file_type");
				sql.append("         start with f_type_id = '"+thisFileType+"'");
				sql.append("        connect by prior f_type_id = f_parent_type_id)");
				sql.append("   and f_org_id = '"+orgId+"'");
				sql.append("   and (f_type_level = '1' or f_type_level = '2')");
				sql.append(" order by f_type_order");
			}
		}
		if(sql.length()>0){
			PreparedDBUtil pdb = new PreparedDBUtil();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Connection conn = null;
			try {
				conn = DbManager.getInstance().getConnection();
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				Map<String, String> tempVal = null;

				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					//树需要的
					tempVal.put("item_code",  pdb.getString(i, "f_type_id"));
					tempVal.put("org_id", pdb.getString(i,"f_org_id"));
					tempVal.put("item_id",  pdb.getString(i, "f_type_id"));
					tempVal.put("id", pdb.getString(i, "f_type_id"));
					if(StringUtil.nullOrBlank(pdb.getString(i, "f_parent_type_id"))){
						tempVal.put("parent_id", FileTypeTree.FILE_TYPE_TREE_ROOT_NODE);
					}else{
						tempVal.put("parent_id", pdb.getString(i, "f_parent_type_id"));
					}
					tempVal.put("name", pdb.getString(i, "f_type_name"));
					tempVal.put("deptType", pdb.getString(i, "f_type_id"));	
					tempVal.put("open", "true");
					tempVal.put("icon",FileTypeTree.OPEN_ICON_URL_B);
					//自己的
					tempVal.put("f_type_id",  pdb.getString(i, "f_type_id"));
					tempVal.put("f_parent_type_id", pdb.getString(i, "f_parent_type_id"));
					tempVal.put("f_type_name", pdb.getString(i, "f_type_name"));
					tempVal.put("f_type_level", pdb.getString(i, "f_type_level"));
					tempVal.put("f_org_id", pdb.getString(i, "f_org_id"));
					tempVal.put("f_org_name", pdb.getString(i, "f_org_name"));
					tempVal.put("f_dept_id", pdb.getString(i, "f_dept_id"));
					tempVal.put("f_dept_name", pdb.getString(i, "f_dept_name"));
					tempVal.put("f_typeno", pdb.getString(i, "f_typeno"));
					tempVal.put("f_type_order", pdb.getString(i, "f_type_order"));
					tempVal.put("f_type_parentname", pdb.getString(i, "f_type_parentname"));
					tempVal.put("f_type_parentid", pdb.getString(i, "f_type_parentid"));
					tempVal.put("f_type_table", pdb.getString(i, "f_type_table"));
					
					list.add(tempVal);
				}
				tempVal = new HashMap<String, String>();
				tempVal.put("id",FileTypeTree.FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("item_code", FileTypeTree.FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("item_id", FileTypeTree.FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("f_type_id", FileTypeTree.FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("name","档案分类");
				tempVal.put("parent_id","");
				tempVal.put("deptType","F_TYPE_REMARK");
				tempVal.put("isParent","true");
				tempVal.put("open", "true");
				tempVal.put("icon",FileTypeTree.OPEN_ICON_URL_B);
				list.add(tempVal);
				if (0 == list.size()) {
					return "'none'";
				}
				return list;
			} catch (SQLException e) {
				LOG.error(e.getMessage(), e);
			}finally{
				DbManager.closeConnection(conn);
			}
		}
		return "'none'";
	}
	
	public static Object queryGwcsOrgTree(TreeBean bean) {
		Map<String,String> requestMap = bean.getRequestMap();
		//String orgId = requestMap.get("orgId");
		
		StringBuffer sql = new StringBuffer();
		sql.append("select org_id, org_name, org_addr, parent_id, isouter from oa_gwcs_org ");
		
		if(sql.length()>0){
			PreparedDBUtil pdb = new PreparedDBUtil();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Connection conn = null;
			try {
				conn = DbManager.getInstance().getConnection();
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				Map<String, String> tempVal = null;

				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					//树需要的
					tempVal.put("item_code",  pdb.getString(i, "org_id"));
					tempVal.put("parent_id", pdb.getString(i, "org_id"));
					tempVal.put("item_id",  pdb.getString(i, "org_id"));
					tempVal.put("id", pdb.getString(i, "org_id"));
					//这个树特殊，所有数据都可以选择，包括父节点，所以，所有节点都平级，没有父子关系
					//tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					
					tempVal.put("org_id", pdb.getString(i,"org_id"));
					tempVal.put("name", pdb.getString(i, "org_name"));
					tempVal.put("deptType", pdb.getString(i, "org_id"));	
					tempVal.put("open", "true");
					tempVal.put("readonly", "true");
					tempVal.put("icon",FileTypeTree.OPEN_ICON_URL_B);
					
					list.add(tempVal);
				}
				if (0 == list.size()) {
					return "'none'";
				}
				return list;
			} catch (SQLException e) {
				LOG.error(e.getMessage(), e);
			}finally{
				DbManager.closeConnection(conn);
			}
		}
		return "'none'";
	}
	
	/**
	*<b>Summary: </b>
	*  发改委法律知识库树
	* @param bean
	* @return 
	*/
	public static Object queryFgwKbmDocTypeTree(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("  select *");
			sql.append("  from fgw_kbm_doc_type");
			sql.append("  order by k_type_order");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			Map<String, String> tempVal = null;

			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				//树需要的
				tempVal.put("user_id", pdb.getString(i, "k_type_id"));
				tempVal.put("id", pdb.getString(i, "k_type_id"));
				tempVal.put("item_code", pdb.getString(i, "k_type_id"));
				tempVal.put("k_type_id", pdb.getString(i, "k_type_id"));
				tempVal.put("name", pdb.getString(i, "k_type_name"));
				tempVal.put("parent_id", pdb.getString(i, "k_parent_type_id"));	
				tempVal.put("open", "true");
				tempVal.put("item_id",  pdb.getString(i, "k_type_id"));	
				tempVal.put("deptType", pdb.getString(i, "k_type_id"));	
				
				tempVal.put("k_remark", pdb.getString(i, "k_remark"));
				tempVal.put("k_content_template", pdb.getString(i, "k_content_template"));
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
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b> inqueryTreeMeetingPerson(查询机构人员树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object queryOfficeosupplietype(TreeBean bean) {
		
		StringBuffer sql = new StringBuffer();
		sql.append("select oftype_name,oftype_id,parent_id,unit_name,unit_id from ta_oa_osupplietype order by oftype_no");
		
		if(sql.length()>0){
			PreparedDBUtil pdb = new PreparedDBUtil();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
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
					tempVal.put("oftype_name", pdb.getString(i, "oftype_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));	
					tempVal.put("item_id",  pdb.getString(i, "oftype_id"));
					tempVal.put("org_id", pdb.getString(i,"oftype_id"));
					tempVal.put("name", pdb.getString(i, "oftype_name"));
					tempVal.put("deptType", pdb.getString(i, "oftype_id"));	
					
					tempVal.put("open", "true");
					tempVal.put("readonly", "true");
					
					list.add(tempVal);
				}
				if (0 == list.size()) {
					return "'none'";
				}
				return list;
			} catch (SQLException e) {
				LOG.error(e.getMessage(), e);
			}finally{
				DbManager.closeConnection(conn);
			}
		}
		return "'none'";
	}
}

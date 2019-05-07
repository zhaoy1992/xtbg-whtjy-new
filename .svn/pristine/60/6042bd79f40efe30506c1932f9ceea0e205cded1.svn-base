package com.chinacreator.xtbg.pub.tree.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.pub.tree.dao.TreeOtherResourcesDao;
import com.chinacreator.xtbg.pub.tree.dao.impl.otherResources.YuewenFileTypeTreeImpl;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.chinacreator.xtbg.pub.tree.entity.TreeHashMap;
import com.chinacreator.xtbg.pub.util.ListUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;


public class TreeBusinessDaoImpl{
	private static String OUT_ORG_ID = "b2fa23cc-9754-4cbe-9627-52d5c74bf9f2";	//外部单位id
	private static String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	//sql
	private static final String SELECT_RES_TYPE="select * from ta_oa_resources_type where is_public = 'Y' or instr(','||sys_code||',',"+userArea+") > 0";
	private static final String SELECT_RES_CONFIG_TYPE = "select * from ta_oa_resources where RESOURCES_TYPE = '1' and (is_public='Y' or instr(','||sys_code||',',"+userArea+") > 0)";
	private static final String SELECT_RES_ORG_TYPE = "select * from td_sm_organization order by org_sn";
	//private static final String SELECT_RES_ORG ="select *  from td_sm_organization r where (remark4 < 'A4' and substr(remark4,0,1) ='A') or  (substr(remark4,0,1) <>'A' and substr(remark4,2,3) < '3')  order by org_sn";
	private static final String SELECT_RES_ORG ="select *  from td_sm_organization r order by r.org_sn";
	private static final String SELECT_RES_ORG_REG ="select r.org_name, r.parent_id,r.org_id, r.remark4,"
       + " decode((select distinct o.parent_id from td_sm_organization o where o.parent_id = r.org_id),'',1,0) isTip "
       + " from td_sm_organization r "
       + " order by r.org_sn";
	//private static final String SELECT_RES_ORG_IFMANAGER = "select * from td_sm_organization r connect by prior r.parent_id = r.org_id start with r.org_id = ? order by r.org_sn";
	private static final String SELECT_RES_ORG_IFMANAGER = "select *   from td_sm_organization r connect by prior r.org_id = r.parent_id  start with r.org_id = ?  order by r.org_sn";
	private static final String TREE_SELECT_IDS="select t.ids  from ta_oa_resources_config t where t.resources_id=? and t.resources_configtype='2' and t.resources_configtypeid=?";
	private static final String TREE_SELECT_USER = " select o.org_id , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1 from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	private static final String TREE_SELECT_USER_IFMANAGER = " select o.org_id,o.org_name , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1  from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	private static final String TREE_SELECT_DIR_USER = "select  m.* from  (select rownum index_sn, org.org_id, org.org_name  from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd where cd.parent_id='0') connect by prior org.org_id = org.parent_id  order siblings by org.org_sn) o left join ta_oa_directory_manage m on m.orgid=o.org_id left join ta_oa_userorderby  a on  a.user_id=m.directoryid  and (o.org_id= a.dept_id) where m.orgid is not null order by to_number(o.index_sn),a.orderby,m.directory_sn";
	//查询机构所有的叶子节点
	private static final String SELECT_ORG_CHILD_NODE ="SELECT CONNECT_BY_ISLEAF, o.* FROM td_sm_organization o connect by prior o.org_id = o.parent_id  START WITH o.parent_id = '0' order by o.org_sn";
	

	/**
	 * 
	*<b>Summary: 加载其他资源类别的树的数据</b>
	* @param bean
	* @return
	 */
	public static Object inqueryTreeOtherResources(TreeBean bean){
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");

		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		TreeOtherResourcesDao treeOtherResourcesDao = null;
		try {
			if(type.indexOf("filetype") != -1){
				treeOtherResourcesDao = new YuewenFileTypeTreeImpl();
			}
			list = (ArrayList<Map<String, String>>)treeOtherResourcesDao.inqueryTreeOtherResources(bean);
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public static Object inqueryTreePurview(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		try {
			pdb.preparedSelect(SELECT_RES_TYPE);
			pdb.executePrepared();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
            if(0 == pdb.size()){
				return "'none'";
			}
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "p"+pdb.getString(i, "RESOURCES_TYPEID"));
				tempVal.put("item_id", "p"+pdb.getString(i, "RESOURCES_TYPEID"));
				tempVal.put("name", pdb.getString(i, "RESOURCES_TYPENAME"));
				tempVal.put("parent_id", "0");
				tempVal.put("open", "true");
				list.add(tempVal);
			}
			
			pdb.preparedSelect(SELECT_RES_CONFIG_TYPE);
			pdb.executePrepared();
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "RESOURCES_ID"));
				tempVal.put("item_id", pdb.getString(i, "RESOURCES_ID"));
				tempVal.put("name", pdb.getString(i, "RESOURCES_NAME"));
				tempVal.put("parent_id", "p"+pdb.getString(i, "RESOURCES_TYPEID"));
				tempVal.put("treeType", pdb.getString(i, "TREE_TYPE"));
				list.add(tempVal);
			}
			
			return list;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	

	public static Object inqueryTreeReportPerson(TreeBean bean) {

		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(SELECT_RES_ORG_TYPE);
			
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String, String> tempVal = null;
			pdb.executePrepared();
			if (0 == pdb.size()) {
				return "'none'";
			}
			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "ORG_ID"));
				tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
				tempVal.put("deptType", pdb.getString(i, "remark4"));
				setOpenValue(tempVal, pdb.getString(i, "remark4"), bean);
				list.add(tempVal);
			}

			pdb.preparedSelect(TREE_SELECT_DIR_USER);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "DIRECTORYID"));
				tempVal.put("user_id", pdb.getString(i, "DIRECTORYID"));
				tempVal.put("item_id", pdb.getString(i, "DIRECTORYID"));
				tempVal.put("item_code", pdb.getString(i, "ENG_NAME"));
				tempVal.put("name", pdb.getString(i, "DIRECTORYNAME"));
				tempVal.put("parent_id", pdb.getString(i, "ORGID"));
				tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
				list.add(tempVal);
			}

			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	

	
    public static Object inqueryTreePerson(TreeBean bean){
		Map<String, String> request = bean.getRequestMap();
		String AllOpen = request.get("AllOpen");//是否全展开
		List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	PreparedDBUtil pdb1 = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	Map<String,String> tempVal = null;
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
        			String path = bean.getRequest().getContextPath();
    				for(int j = 0; j < pdb1.size(); j++){
    					
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("user_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb1.getString(j, "org_id"));
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("org_name", pdb1.getString(j, "ORG_NAME"));
    					//特检院 OA 2012-02-20 start  解决人员树不能显示图片 
    					//tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
    					tempVal.put("icon", path+"/ccapp/xtbg/resources/images/user_nonFolder.gif");
    					//特检院 OA 2012-02-20 end
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
     * 
    *<b>Summary: 望城短信，个性化的机构树，排除外部单位数据</b>
    * inqueryTreePersonForSmsSend()
    * @param bean
    * @return
     */
    public static Object inqueryTreePersonForSmsSend(TreeBean bean){
    	Map<String, String> request = bean.getRequestMap();
    	String AllOpen = request.get("AllOpen");//是否全展开
    	List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	PreparedDBUtil pdb1 = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	Map<String,String> tempVal = null;
    	try {
    		
    		allOrgList = updateAllOrgListWithCurUser(bean,allOrgList);
    		
    		for(UserOrgStatusBean uosBean : allOrgList ){
    			boolean isCurOrgManager = om.isCurOrgManager(uosBean.getOrgID(),bean.getUserID());
    			loadSelectResOrgSqlWithConditionForSmsSend(bean,isCurOrgManager, uosBean.getOrgID(), pdb);
    			
    			for(int i = 0; i < pdb.size(); i++){
    				tempVal = new TreeHashMap<String, String>();
    				tempVal.put("id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
    				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
    				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
    				tempVal.put("deptType",  pdb.getString(i, "remark4"));
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
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
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
     * 根据当前用户信息对allOrgList进行更新
     * @param bean
     * @param allOrgList
     * @return
     */
    public static List<UserOrgStatusBean> updateAllOrgListWithCurUser(TreeBean bean, List<UserOrgStatusBean> allOrgList){
    	if("admin".equals(bean.getUserKey())){
    		UserOrgStatusBean uosBean = new UserOrgStatusBean();
    		uosBean.setOrgID(bean.getOrgID());
    		allOrgList.add(uosBean);
    	}
    	return allOrgList;
    }
    
    /**
     * 根据条件来加载SelectResOrg语句
     * @param bean 树的基本bean
     * @param isCurOrgManager 是否为当前机构管理员
     * @param CurOrgId 当前机构id
     * @param pdb
     * @throws SQLException
     */
	public static void  loadSelectResOrgSqlWithCondition(TreeBean bean,boolean isCurOrgManager,String CurOrgId,PreparedDBUtil pdb) throws SQLException{
		Map<String, String> request = bean.getRequestMap();
		String userId = bean.getUserID();
		String select_res_org = "";

		String isManager = request.get("isManager");//当前用户是否为管理员（不包括系统管理员）
		if("true".equals(isManager) && !"admin".equals(bean.getUserKey())){
			if(isCurOrgManager){//判断用户在指定的机构中是否为管理员
				select_res_org = SELECT_RES_ORG_IFMANAGER;
				pdb.preparedSelect(select_res_org);
				int p = 1;
				pdb.setString(p++, CurOrgId);
			}
		}else{
			select_res_org = SELECT_RES_ORG_TYPE;
			pdb.preparedSelect(select_res_org);
		}
		//sql不为空才执行
		if(!StringUtil.nullOrBlank(select_res_org)){
			pdb.executePrepared();
		}else{
			clearPdbUtilResult(pdb);//必须清空结果集
		}
		
	}
	/**
	 * 根据条件来加载SelectResOrg语句,为望城短信发送个性化功能
	 * @param bean 树的基本bean
	 * @param isCurOrgManager 是否为当前机构管理员
	 * @param CurOrgId 当前机构id
	 * @param pdb
	 * @throws SQLException
	 */
	public static void  loadSelectResOrgSqlWithConditionForSmsSend(TreeBean bean,boolean isCurOrgManager,String CurOrgId,PreparedDBUtil pdb) throws SQLException{
		Map<String, String> request = bean.getRequestMap();
		String userId = bean.getUserID();
		StringBuffer sql = new StringBuffer();
		
		String isManager = request.get("isManager");//当前用户是否为管理员（不包括系统管理员）
		if("true".equals(isManager) && !"admin".equals(bean.getUserKey())){
			if(isCurOrgManager){//判断用户在指定的机构中是否为管理员
				sql = sql.append(SELECT_RES_ORG_IFMANAGER);
				pdb.preparedSelect(sql.toString());
				int p = 1;
				pdb.setString(p++, CurOrgId);
			}
		}else{
			//查询所有机构，但不包括外部机构，外部机构id写死
			sql.append("select *");
			sql.append("  from td_sm_organization o");
			sql.append(" where o.org_id not in");
			sql.append("       (select r.org_id");
			sql.append("          from td_sm_organization r");
			sql.append("        connect by prior r.org_id = r.parent_id");
			sql.append("         start with r.org_id = '"+OUT_ORG_ID+"')");
			sql.append(" order by o.org_sn");
			pdb.preparedSelect(sql.toString());
		}
		//sql不为空才执行
		if(!StringUtil.nullOrBlank(sql.toString())){
			pdb.executePrepared();
		}else{
			clearPdbUtilResult(pdb);//必须清空结果集
		}
	}
	
	/**
     * 根据条件来加载SelectResOrg语句
     * @param bean 树的基本bean
     * @param isCurOrgManager 是否为当前机构管理员
     * @param CurOrgId 当前机构id
     * @param pdb
     * @throws SQLException
     *  当机构数加载出来时，点击确定后只选择叶子节点机构
     */
	public static void  loadSelectResOrgSqlWithConditionChild(TreeBean bean,boolean isCurOrgManager,String CurOrgId,PreparedDBUtil pdb) throws SQLException{
		Map<String, String> request = bean.getRequestMap();
		String userId = bean.getUserID();
		String select_res_org = "";

		String isManager = request.get("isManager");//当前用户是否为管理员（不包括系统管理员）
		if("true".equals(isManager) && !"admin".equals(bean.getUserKey())){
			if(isCurOrgManager){//判断用户在指定的机构中是否为管理员
				select_res_org = SELECT_ORG_CHILD_NODE;
				pdb.preparedSelect(select_res_org);
				int p = 1;
				pdb.setString(p++, CurOrgId);
			}
		}else{
			select_res_org = SELECT_ORG_CHILD_NODE;
			pdb.preparedSelect(select_res_org);
		}
		//sql不为空才执行
		if(!StringUtil.nullOrBlank(select_res_org)){
			pdb.executePrepared();
		}else{
			clearPdbUtilResult(pdb);//必须清空结果集
		}
		
	}
	
	/**
	 * 清空pdbUtil中的结果集，避免被再次使用
	 * @param pdb
	 * @throws SQLException
	 */
	public static void clearPdbUtilResult(PreparedDBUtil pdb)  throws SQLException{
		pdb.preparedSelect("select * from dual where 1=2");
		pdb.executePrepared();
	}
    /**
     * 根据条件来加载TreeSelectUser语句
     * @param bean 树的基本bean
     * @param isCurOrgManager 是否为当前机构管理员
     * @param CurOrgId 当前机构id
     * @param pdb
     * @param isValidOrgManager 是否验证机构管理员
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
    
    public static void loadTreeSelectUserSqlIfAdmin(TreeBean bean,PreparedDBUtil pdb) throws SQLException{
    	Map<String, String> request = bean.getRequestMap();
    	String isNotUserVaild = request.get("isNotUserVaild");//不许要验证用户的user_isvalid
    	String tree_select_user = TREE_SELECT_USER;
    	if("true".equals(isNotUserVaild))
			tree_select_user = tree_select_user.replace("and t.user_isvalid != '3'", "");
    	pdb.preparedSelect(tree_select_user);
    	pdb.executePrepared();
    }
    
    public static boolean isAdmin(TreeBean bean){
    	return "admin".equals(bean.getUserKey());
    }

    
    public static Object inqueryTreeReportOrganization(TreeBean bean){
    	Map<String, String> request = bean.getRequestMap();
    	List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
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
				Map<String,String> tempVal = null;

				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType",  pdb.getString(i, "remark4"));
					setOpenValue(tempVal,pdb.getString(i, "remark4"),bean);
					list.add(tempVal);
				}
    		}
    		 if(0 == list.size()){
 				return "'none'";
 			}
             /*《如果需要向上遍历展开树的所有根节点，则要做排重处理》*/
             list = (ArrayList<Map<String,String>>)ListRemoveDuplicateIfNotAdmin(bean,list);
 			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
    
    /**
     * 
    *<b>Summary: </b>
    * inqueryTreeReportOrganization(不带科室的机构树)
    * @param bean
    * @return
     */
    public static Object inqueryTreeReportUNIT(TreeBean bean){
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
    * inqueryTreeReportOrganizationChild( 当机构数加载出来时，点击确定后只选择叶子节点机构)
    * @param bean
    * @return
     */
    public static Object inqueryTreeReportOrganizationChild(TreeBean bean){
    	Map<String, String> request = bean.getRequestMap();
    	List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
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
    			loadSelectResOrgSqlWithConditionChild(bean,isCurOrgManager, uosBean.getOrgID(), pdb);
				Map<String,String> tempVal = null;

				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType",  pdb.getString(i, "remark4"));
					tempVal.put("connect_by_isleaf",  pdb.getString(i, "CONNECT_BY_ISLEAF"));
					//setOpenValue(tempVal,pdb.getString(i, "remark4"),bean);
					list.add(tempVal);
				}
    		}
    		 if(0 == list.size()){
 				return "'none'";
 			}
             /*《如果需要向上遍历展开树的所有根节点，则要做排重处理》*/
             list = (ArrayList<Map<String,String>>)ListRemoveDuplicateIfNotAdmin(bean,list);
 			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
    
    public static Object inqueryTreeOrganization(TreeBean bean){
    	Map<String, String> request = bean.getRequestMap();
    	List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	IOrgManagerExt om = new OrgManagerExtImpl();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
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
	            
				Map<String,String> tempVal = null;

				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType",  pdb.getString(i, "remark4"));
					setOpenValue(tempVal,pdb.getString(i, "remark4"),bean);
					list.add(tempVal);
				}
    		}
            if(0 == list.size()){
				return "'none'";
			}
            /*《如果需要向上遍历展开树的所有根节点，则要做排重处理》*/
             list = (ArrayList<Map<String,String>>)ListRemoveDuplicateIfNotAdmin(bean,list);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
    
    public static Object inqueryAllTreeOrganization(TreeBean bean){
    	PreparedDBUtil pdb = new PreparedDBUtil();
    	ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	try {
    			pdb.preparedSelect(SELECT_RES_ORG_REG);
    			pdb.executePrepared();
	            
				Map<String,String> tempVal = null;

				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_code", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType",  pdb.getString(i, "remark4"));
					tempVal.put("nocheck","0".equals(pdb.getString(i, "isTip"))?"true":"");
					setOpenValue(tempVal,pdb.getString(i, "remark4"),new TreeBean());
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
    
    public static List ListRemoveDuplicateIfNotAdmin(TreeBean bean,List list){
    	if(!isAdmin(bean))//如果是admin则不排重，因为排重需要消耗性能
    		list = ListUtil.removeDuplicateWithOrder(list);
    	return list;
    }
    
    public static Object inqueryPersonSelectValue(TreeBean bean){
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
				resp = pdb.getString(0, "ids");
				if(null == resp || "".equals(resp.trim())){
					resp ="'none'";
				}
				else{
					resp = "'"+resp+"'";
				}
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return resp;
    }
    
    public static String inqueryPersonRule(String type ,String userID){
    	String resp ="";
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
			e.printStackTrace();
		}
		
		return resp;
    }
    private static final String SELSCT_CONFIG = "select 1 from ta_oa_resources_config g where g.resources_configtypeid =? and g.resources_id = ?";
    private static final String INSERT_RES = "insert into ta_oa_resources_config (resources_configid, resources_id,resources_configtype,resources_configtypeid,resources_configrange,creator_time,TREE_JSONDATA,ids) values(seq_oa_resources_config.nextval||'',?,'2',?,'2',sysdate,?,?)";
    private static final String DEL_RES = "delete ta_oa_resources_config t where t.resources_configtypeid=? and resources_id = ?";
    public static Object batchSave(TreeBean bean){
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
				pdb.setString(1, type);
				pdb.setString(2, userArray[i]);
				pdb.setString(3, json);
				pdb.setString(4, selectUserIds);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch();
			insertAndroidWait(type,userIds);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    	
    	return resp;
    }
    /**
     * 根据条件来设置树节点的展开
     * @param val
     * @param remark4
     * @param bean
     */
    private static void setOpenValue(Map<String,String> val,String remark4,TreeBean bean){
    	Map<String, String> request = bean.getRequestMap();
    	String isManager = request.get("isManager");//当前用户是否为管理员（不包括系统管理员）
    	String onelevel= request.get("onelevel");//苏仙项目的全机构树只展开一层
    	if(null != remark4 && !"".equals(remark4)){
    		int temp = 2;
    		try{
    			temp = Integer.parseInt(remark4.substring(1, 2));
    			
    		}catch(Exception e){};
    		
    		if(("A".equals(remark4.substring(0, 1)) && temp < 2 ) || (!"A".equals(remark4.substring(0, 1)) &&  temp < 1)){
    			val.put("open", "true");
    		}
    		if("true".equals(isManager) && !isAdmin(bean)){//管理员的节点都展开
    			val.put("open", "true");
    		}
    		if("true".equals(onelevel)){//苏仙项目的全机构树只展开顶层
    			if("0".equals(val.get("parent_id"))){
    				val.put("open", "true");
    			}else{
    				val.put("open", "false");
    			}
    		}
    	}
    }
    

	private static void insertAndroidWait(String type, String userids) throws Exception{
		String tableName = "";
		String recordId = "";
		String userIdString = userids;
		// if ("0004".equals(rscBean.getResources_id()))
		boolean flag = false;
		if ("69".equals(type))
		{
			tableName = "ta_oa_personwork_personinfo_config";
			recordId = "personinfo_config";
			flag = true;
		}
		else if ("22".equals(type))
		{
			tableName = "ta_oa_leaderschedule_config";
			recordId = "schedule_config";
			flag = true;
		}
		if(flag){
//			PreparedDBUtil db = new PreparedDBUtil();
//			AndroidCommonDao androidCommonDao = new AndroidCommonDaoImpl();
//			androidCommonDao.saveAndroidWaitTableRecord(db, userIdString, tableName, recordId, "2", "");
//			db.executePreparedBatch();
		}
	}
	
	private static final String INQ_BRIEFS_PUBLIC ="select b.briefstype_id,b.briefstype_name from TA_OA_BRIEFS_TYPE b where b.ispublic='2'";
	private static final String INQ_BRIEFS_ORG ="select a.org_id,a.parent_id,a.org_name,a.remark4 from td_sm_organization a  where (substr(a.remark4, 1, 1) = 'A' and  to_number( substr(a.remark4, 2, 1)) <3) or (substr(a.remark4, 1, 1) != 'A' and   to_number(substr(a.remark4, 2, 1)) <2) order by a.org_sn";//閿熸枻鎷疯閿熸枻鎷烽敓鏂ゆ嫹閿熷彨鐨勮鎷烽敓鏂ゆ嫹
	private static final String INQ_BRIEFS_TYPE=" select t.BRIEFSTYPE_NAME, o.org_name, t.BRIEFSTYPE_ID, o.org_id,o.parent_id, o.remark4 from TA_OA_BRIEFS_TYPE t left join td_sm_organization o on t.org_id = o.org_id left join ta_oa_organdtype a on o.org_id = a.org_id  where (a.is_leadorg <> 'Y' or a.is_leadorg is null) and t.ispublic<>'2' order by o.org_sn ";
	
	public static Object inqueryTreeBriefs(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		try {
			pdb.preparedSelect(INQ_BRIEFS_ORG);
			pdb.executePrepared();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "org_id"));
				tempVal.put("item_id", pdb.getString(i, "org_id"));
				tempVal.put("name", pdb.getString(i, "org_name"));
				tempVal.put("parent_id", pdb.getString(i, "parent_id"));
				list.add(tempVal);
			}
			
			pdb.preparedSelect(INQ_BRIEFS_TYPE);
			pdb.executePrepared();
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "briefstype_id"));
				tempVal.put("item_id", pdb.getString(i, "briefstype_id"));
				tempVal.put("name", "<<"+pdb.getString(i, "BRIEFSTYPE_NAME")+">>("+pdb.getString(i, "org_name")+")");
				tempVal.put("parent_id", pdb.getString(i, "parent_id"));
				tempVal.put("type", "1");
				list.add(tempVal);
			}
			
			pdb.preparedSelect(INQ_BRIEFS_PUBLIC);
			pdb.executePrepared();
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "briefstype_id"));
				tempVal.put("item_id", pdb.getString(i, "briefstype_id"));
				tempVal.put("name", "<<"+pdb.getString(i, "BRIEFSTYPE_NAME")+">>()");
				tempVal.put("parent_id", "1");
				tempVal.put("type", "1");
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
	
	private static String z_S_Depart1User2 = CacheCommonManage.getInstance().getSystemParam("z_tree_leftRigth.showType.depart1user2"); 
	
	public static Object inqueryTreeShowType(TreeBean bean){
		Map<String,String> tempVal = new HashMap<String, String>();
		if(z_S_Depart1User2.indexOf(userArea) != -1){
			tempVal.put("z_S_Depart1User2", "true");
		}
		return tempVal;
	}
	//个人通讯录
	private static final String group_name="select  group_id, group_name,user_id from oa_personwork_group  where user_id = ? and is_public_group = '0'";
	private static final String group_person="select t.person_id,name,(select t1.field_value from oa_personwork_extrainfo t1 where t1.person_id = t.person_id and t1.field_name = '办公手机' and rownum = 1) commonlymobile," 
										+ " (select to_char(wmsys.wm_concat(g.group_name)) from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id where t.person_id = t1.person_id) " 
										+ " group_name, (select to_char(wmsys.wm_concat(t1.group_id)) from oa_personwork_persongroup t1  where t.person_id = t1.person_id) group_id, '个人通讯录' as info_source_name,  t.user_id," 
										+ " t.eng_name from oa_personwork_personinfo t where t.info_type = 'personal'  and t.is_public = '0'  and t.user_id= ? ";
	public static Object inqueryTreeGrtxl(TreeBean bean){
			PreparedDBUtil pdb = new PreparedDBUtil();
			try {
				pdb.preparedSelect(group_name); //个人通讯录组名
				pdb.setString(1, bean.getUserID());
				pdb.executePrepared();
				ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
				Map<String,String> tempVal = null;
				for(int i = 0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", "G"+pdb.getString(i, "group_id"));
					tempVal.put("user_id", "");
					tempVal.put("item_id", "G"+pdb.getString(i, "group_id"));
					tempVal.put("name", pdb.getString(i, "group_name"));
					tempVal.put("parent_id", "G"+StringUtil.deNull(pdb.getString(i, "group_id")));
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
					tempVal.put("parent_id", "G"+pdb.getString(i, "group_id"));
					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
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
	private static final String public_group_name="select  group_id, group_name,user_id from oa_personwork_group  where is_public_group='1'";
	private static final String public_group_person="select t.person_id,name,(select t1.field_value from oa_personwork_extrainfo t1 where t1.person_id = t.person_id and t1.field_name = '办公手机' and rownum = 1) commonlymobile," 
		+ " (select to_char(wmsys.wm_concat(g.group_name)) from oa_personwork_group g inner join oa_personwork_persongroup t1 on t1.group_id = g.group_id where t.person_id = t1.person_id) " 
		+ " group_name, (select to_char(wmsys.wm_concat(t1.group_id)) from oa_personwork_persongroup t1  where t.person_id = t1.person_id) group_id, '个人通讯录' as info_source_name,  t.user_id," 
		+ " t.eng_name from oa_personwork_personinfo t  left join oa_personwork_extrainfo e  on t.person_id = e.person_id  where t.info_type = 'personal'  and t.is_public = '1' ";
	public static Object publicinqueryTreeGrtxl(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(public_group_name); //公共通讯录组名
			pdb.executePrepared();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
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
				tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
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
	private static final String out_group_name="select * from td_sm_organization r connect by prior r.org_id = r.parent_id start with r.org_id = '"+OUT_ORG_ID+"'";
	public static Object inqueryTreeGrtxlForOut(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		try {
			pdb.preparedSelect(out_group_name); //公共通讯录组名
			pdb.executePrepared();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			Map<String,String> tempVal = null;
			for(int i = 0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "ORG_ID"));
				tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
				tempVal.put("deptType",  pdb.getString(i, "remark4"));
				list.add(tempVal);
				
				loadTreeSelectUserSqlWithCondition(bean,false,pdb.getString(i, "ORG_ID"),pdb1,false);
				for(int j = 0; j < pdb1.size(); j++){
					
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", pdb1.getString(j, "user_id"));
					tempVal.put("user_id", pdb1.getString(j, "user_id"));
					tempVal.put("item_id", pdb1.getString(j, "user_id"));
					tempVal.put("item_code", pdb1.getString(j, "user_name"));
					tempVal.put("name", pdb1.getString(j, "user_realname"));
					tempVal.put("parent_id", pdb1.getString(j, "org_id"));
					tempVal.put("org_name", pdb1.getString(j, "org_name"));
					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
					list.add(tempVal);
				}
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
	 * 
	*<b>Summary: </b>
	* queryTop10(查询)
	* @return
	 */
	public static Object queryTop10(TreeBean bean){
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql =new StringBuffer();
		Map<String,String> tempVal = null;
		Map<String,String> map = null;
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		Set<Map<String, String>> set= new HashSet<Map<String,String>>();
		String receivepnames="";
		String receivepids="";
		String[] receivepnamesArr={};
		String[] receivepidsArr={};
		sql.append("select to_char(wmsys.wm_concat(receivepname) over(partition by mid )) as receivepnames, to_char(wmsys.wm_concat(receivepid) over(partition by mid )) as receivepids");
		sql.append("  from (select distinct tt.mid,");
		sql.append("                        tt.title,");
		sql.append("                        t.receivepname as receivepname,");
		sql.append("                        t.receivepid as receivepid,");
		sql.append("                        tt.createtime");
		sql.append("          from ymj_oa_jbxx_mail tt");
		sql.append("          left join ymj_oa_user_mail t on tt.mid = t.mid");
		sql.append("         where 1 = 1");
		sql.append("           and tt.sendpid = '"+bean.getUserID()+"'");
		sql.append("           and tt.state = '1'");
		sql.append("         order by tt.createtime desc)");
		sql.append(" where rownum < 11");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				receivepnames+= pdb.getString(i, "receivepnames")+",";
				receivepids +=pdb.getString(i, "receivepids")+",";
				
			}
			if(!"".equals(receivepnames)){
				receivepnames=receivepnames.substring(0, receivepnames.length()-1);
				receivepids=receivepids.substring(0, receivepids.length()-1);
			}
			if(!"".equals(receivepnames)&&!"".endsWith(receivepids)){
				receivepnamesArr=receivepnames.split(",");
				receivepidsArr=receivepids.split(",");
			
			List<Map<String, String>> tlist =new ArrayList<Map<String,String>>();	
			
			String[] tempId =quchong(receivepidsArr, 10);
			String[] tempName=quchong(receivepnamesArr, 10);
			if(tempId.length==tempName.length){
				for (int i = 0; i < tempId.length; i++) {
					if(!StringUtil.isBlank(tempId[i])){
						map=new HashMap<String, String>();
						map.put("id", tempId[i]);
						map.put("name", tempName[i]);
						tlist.add(map);
					}
				}
			}
			for (int i = 0; i < tlist.size(); i++) {
				tempVal = new TreeHashMap<String, String>();
				tempVal.put("user_id",tlist.get(i).get("id"));
				tempVal.put("item_id", tlist.get(i).get("id"));
				tempVal.put("name", tlist.get(i).get("name"));
				tempVal.put("parent_id", "0");
				tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
				list.add(tempVal);
			}
			tempVal = new TreeHashMap<String, String>();
			tempVal.put("user_id","0");
			tempVal.put("item_id", "0");
			tempVal.put("name", "最近联系人");
			tempVal.put("open", "true");
			list.add(tempVal);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	//数组去重
	public static String[] quchong(String[] arr,int num){
		String[] tempArr=new String[num];
		boolean flag=false;
		int a=0;
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < tempArr.length; j++) {
				if(arr[i].equals(tempArr[j])){
					flag=false;
					break;
				}else{
					flag=true;				
				}
			}
			if(a>num-1){
				break;
			}
			if (flag) {
				tempArr[a++]=arr[i];
			}

		}
		return tempArr;
	}
}


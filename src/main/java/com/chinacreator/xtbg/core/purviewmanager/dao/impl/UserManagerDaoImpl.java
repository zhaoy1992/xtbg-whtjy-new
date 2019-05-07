package com.chinacreator.xtbg.core.purviewmanager.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.OrgUserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserJobOrgBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:UserManagerDaoImpl.java</p>
 *<p>Description:用户管理Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public class UserManagerDaoImpl extends XtDbBaseDao implements UserManagerDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserBean
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#getUserBean(java.lang.String)
	 */
	public Map<String, String> getUserBean(String user_id, Connection con) throws Exception{
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select user_id,");
		sql.append("       user_name,");
		sql.append("       user_realname,");
		sql.append("       user_password,");
		sql.append("       user_idcard,");
		sql.append("       user_worktel,");
		sql.append("       user_sex,");
		sql.append("       user_hometel,");
		sql.append("       user_email,");
		sql.append("       user_mobiletel1,");
		sql.append("       remark4,");
		sql.append("       user_mobiletel2,");
		sql.append("       remark5,");
		sql.append("       user_pinyin,");
		sql.append("       user_type,");
		sql.append("       user_postalcode,");
		sql.append("       user_fax,");
		sql.append("       user_oicq,");
		sql.append("       user_birthday,");
		sql.append("       user_address,");
		sql.append("       user_logincount,");
		sql.append("       user_isvalid,");
		sql.append("       user_regdate,");
		sql.append("       user_oicq,");
		sql.append("       user_sn,");
		sql.append("       remark3");
		sql.append("  from td_sm_user");
		sql.append(" where user_id = ?");
		
		viewMap = queryToSingleMap(con, sql.toString(), user_id);
		
		return viewMap;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addorUpdateUser
	  * @param userbean
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#addorUpdateUser(com.chinacreator.xtbg.core.purviewmanager.entity.UserBean)
	 */
	public boolean addorUpdateUser(UserBean userbean, Connection con) throws Exception{
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addUserJob
	  * @param userJobOrgBean
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#addUserJob(com.chinacreator.xtbg.core.purviewmanager.entity.UserJobOrgBean, java.sql.Connection)
	 */
	public void addUserJob(UserJobOrgBean userJobOrgBean, Connection con)
			throws Exception {
	
		int samesn = 1;
		String sqlsn = "select max(same_job_user_sn) as sn from  td_sm_userjoborg where  org_id ='" + userJobOrgBean.getOrg_id() + "'";
		
		PreparedDBUtil dbu = new PreparedDBUtil();
		dbu.executeSelect(sqlsn);
		dbu.executePrepared(con);
		
		if ((dbu != null) && (dbu.getInt(0, 0) > 0)) {
		   samesn = dbu.getInt(0, "sn") + 1;
		} 
	      
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into td_sm_userjoborg");
		sql.append("  (user_id,");
		sql.append("   job_id,");
		sql.append("   org_id,");
		sql.append("   job_sn,");
		sql.append("   same_job_user_sn,");
		sql.append("   job_starttime,");
		sql.append("   job_fettle)");
		sql.append("values");
		sql.append("  (?, ?, ?, '999', ?, sysdate, '1')");
		
		db.preparedInsert(sql.toString());
		db.setString(1, userJobOrgBean.getUser_id());
		db.setString(2, userJobOrgBean.getJob_id());
		db.setString(3, userJobOrgBean.getOrg_id());
		db.setInt(4, samesn);
		db.executePrepared(con);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addOrgUser
	  * @param orgUserBean
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#addOrgUser(com.chinacreator.xtbg.core.purviewmanager.entity.OrgUserBean, java.sql.Connection)
	 */
	public void addOrgUser(OrgUserBean orgUserBean, Connection con)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "insert into td_sm_orguser (org_id, user_id) values (?, ?)";
		db.preparedInsert(sql);
		db.setString(1, orgUserBean.getOrg_id());
		db.setString(2, orgUserBean.getUser_id());
		db.executePrepared(con);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isUserExist
	  * @param user_name
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#isUserExist(java.lang.String, java.sql.Connection)
	 */
	public boolean isUserExist(String user_name, Connection con)
			throws Exception {
		boolean flag = false;
		
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "select count(*) as userCount from td_sm_user where user_name = ? ";
		db.preparedSelect(sql);
		db.setString(1, user_name);
		db.executePrepared(con);
		if (db.size() > 0) {
			if(db.getInt(0, "userCount") > 0) {
				flag = true;
			}
		} 
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isUserRealnameExist
	  * @param user_realname
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#isUserRealnameExist(java.lang.String, java.sql.Connection)
	 */
	public boolean isUserRealnameExist(String user_realname, Connection con)
			throws Exception {
		boolean flag = false;
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "select count(*) as userCount from td_sm_user where user_realname = ?";
		db.preparedSelect(sql);
		db.setString(1, user_realname);
		db.executePrepared(con);
		if (db.size() > 0) {
			if(db.getInt(0, "userCount") > 0) {
				flag = true;
			}
		} 
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getJobId
	  * @param org_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#getJobId(java.lang.String, java.sql.Connection)
	 */
	public String getJobUserSn(String org_id, Connection conn) throws Exception {
		int samesn = 1;
		String sqlsn = "select max(same_job_user_sn) as sn from  td_sm_userjoborg where  org_id ='" + org_id + "'";
		
		PreparedDBUtil dbu = new PreparedDBUtil();
		dbu.preparedSelect(sqlsn);
		dbu.executePrepared(conn);
		
		if ((dbu != null) && (dbu.getInt(0, 0) > 0)) {
			samesn = dbu.getInt(0, "sn") + 1;
		}
		return String.valueOf(samesn);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRightMenu
	  * @param mapparm
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#getRightMenu(java.util.Map)
	 */
	public String getRightMenu(Map<String, String> mapparm) throws Exception {
//		String user_id = mapparm.get("user_id");
//		String user_name = mapparm.get("user_name");
//		String org_id = mapparm.get("org_id");
//		String currentOrgId = mapparm.get("currentOrgId");
//		String curUserId = mapparm.get("curUserId");
//		
//		AccessControl accesscontroler = AccessControl.getAccessControl();
//		
//		OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
//		
//		//岗位功能开关
//		boolean isJobOpen = ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false);
//		
//		//是否出现  "是否税管员" 复选框
//		boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
//		//是否允许用户存在多个机构下
//		boolean isUserOrgs = ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", false);
//		//用户组开关
//		boolean isGroup = ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false);
//		
//	  	//判断是否禁用机构用户增删改菜单开关
//	  	//minghua.guo[2010-12-13]
//	  	boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden",false);
//	  	
//	  	// 权限是否关联机构
//		// 彭盛 2011-3-15 
//		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
//	  	
//	
//		//是否是管理员
//		boolean isOrgManager = false;
//		if(isrolerelatedorg){							
//			isOrgManager = orgAdministratorImpl.isOrgAdmin(user_id,org_id);
//		}else{
//			isOrgManager = orgAdministratorImpl.isOrgManager(user_id);
//		}
//		//是否拥有超级管理员角色
//		boolean isRoleAdmin = accesscontroler.isAdminByUserid(user_id);
//		//列表中的用户是否是自己
//		boolean isSelf = user_id.equals(curUserId);
//		//列表中的用户是否是同级部门管理员
//		boolean isSisterOrgManager = currentOrgId.equals(org_id) && isOrgManager;
//		String isRoleAdminOrOrgManager = "";//是否拥有超级管理员角色与部门管理员角色
//		if(isOrgManager && isRoleAdmin){
//			isRoleAdminOrOrgManager = "(部门管理员；超级管理员角色)";
//		}else if(isRoleAdmin){
//			isRoleAdminOrOrgManager = "(超级管理员角色)";
//		}else if(isOrgManager){
//			isRoleAdminOrOrgManager = "(部门管理员)";
//		}
//		//屏蔽被借调用户  彭盛 2011-3-10							
//		boolean isSecondUserByOrg = !UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(""+user_id,org_id,null);
//		boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUser(""+user_id,null);
//		// 是否主机构 彭盛 2011-3-10
//		boolean isMainOrg = UserCheckOrgFactory.getIUserCheckOrgInstance().isMainOrg(""+user_id,org_id);	
//		
//		if("1".equals(curUserId)){//如果当前登陆用户为admin
//			if(isSecondUserByOrg) {//屏蔽被借调用户
//				if(!isRoleAdmin && !isSelf){//如果选中的用户不是拥有超级管理员角色或不是自己
//					
//				}
//			}
//		}
		
		return null;
	}

	/**
	 * 
	  * <b>Summary: 用户排序的更新</b>
	  *     复写方法 setUserOrder
	  * @param userids
	  * @param orgid
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao#setUserOrder(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean setUserOrder(String userids, String orgid, Connection con)
			throws Exception {
		String sql = "update td_sm_userjoborg o set o.same_job_user_sn = ? where o.org_id='"+orgid+"' and o.user_id=?";
		String[] org_idArray = null;
		PreparedDBUtil db = null;
		
		if(!StringUtil.isBlank(userids)) {
			org_idArray = userids.split(",");
			db = new PreparedDBUtil();
			for(int i=0; i< org_idArray.length ;i++){ 
				db.preparedUpdate(sql);
				db.setInt(1, i);
				db.setString(2, org_idArray[i]);
				
				db.addPreparedBatch();
			}
			db.executePreparedBatch(con);
		}
		//刷新用户缓存
		UserCache userCache=new UserCache();
		userCache.init();
		
		return true;
	}

	

}

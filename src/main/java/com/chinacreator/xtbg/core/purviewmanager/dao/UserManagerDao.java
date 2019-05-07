package com.chinacreator.xtbg.core.purviewmanager.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.purviewmanager.entity.OrgUserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserJobOrgBean;

/**
 * 
 *<p>Title:UserManager.java</p>
 *<p>Description:用户管理dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public interface UserManagerDao {

	/**
	 * 
	*<b>Summary: </b>
	* getUserBean(通过用户ID查询用户基本信息)
	* @param user_id
	* @return
	 */
	public Map<String, String> getUserBean(String user_id, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addorUpdateUser(添加或修改用户基本信息)
	* @param userbean
	* @return
	 */
	public boolean addorUpdateUser(UserBean userbean, Connection con) throws Exception; 
	
	/**
	 * 
	*<b>Summary: </b>
	* getJobId(获得岗位排序)
	* @return
	* @throws Exception
	 */
	public String getJobUserSn(String org_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* addUserJob(保存用户岗位信息)
	* @param userJobOrgBean
	* @param con
	* @throws Exception
	 */
	public void addUserJob(UserJobOrgBean userJobOrgBean, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* addOrgUser(添加机构与用户关系)
	* @param orgUserBean
	* @param con
	* @throws Exception
	 */
	public void addOrgUser(OrgUserBean orgUserBean, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isUserExist(登陆名称是否存在)
	* @param user_name
	* @return
	 */
	public boolean isUserExist(String user_name, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isUserRealnameExist(中文名称是否存在)
	* @param user_realname
	* @return
	 */
	public boolean isUserRealnameExist(String user_realname, Connection con) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getRightMenu(获得用户右键菜单)
	* @param mapparm
	* @return
	* @throws Exception
	 */
	public String getRightMenu(Map<String, String> mapparm) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* setUserOrder(请用一句话描述这个方法的作用)
	* @param userids
	* @param orgid
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean setUserOrder(String userids,String orgid, Connection con) throws Exception;
		
}

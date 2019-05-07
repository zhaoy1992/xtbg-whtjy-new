package com.chinacreator.xtbg.core.purviewmanager.service;

import java.util.Map;

import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;

/**
 * 
 *<p>Title:UserManagerServiceIfc.java</p>
 *<p>Description:用户管理服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public interface UserManagerServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* getUserBean(通过用户ID查询用户基本信息)
	* @param user_id
	* @return
	 */
	public Map<String, String> getUserBean(String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* addorUpdateUser(添加或修改用户基本信息)
	* @param userbean
	* @return
	 */
	public boolean addorUpdateUser(UserBean userbean); 
	
	/**
	 * 
	*<b>Summary: </b>
	* isUserExist(登陆名称是否存在)
	* @param user_name
	* @return
	 */
	public boolean isUserExist(String user_name);
	
	/**
	 * 
	*<b>Summary: </b>
	* isUserRealnameExist(中文名称是否存在)
	* @param user_realname
	* @return
	 */
	public boolean isUserRealnameExist(String user_realname);
	
	/**
	 * 
	*<b>Summary: </b>
	* getRightMenu(获得用户右键菜单)
	* @param mapparm
	* @return
	 */
	public String getRightMenu(Map<String, String> mapparm);
	/**
	 * 
	*<b>Summary: </b>
	* setUserOrder(用户排序的更新)
	* @param userids
	* @param orgid
	* @return
	 */
	public boolean setUserOrder(String userids,String orgid);
}

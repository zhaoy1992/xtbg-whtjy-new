package com.chinacreator.xtbg.pub.sso.dao;
/**
 * 
 *<p>Title:SSODao.java</p>
 *<p>Description:单点登录DAO接口</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-15
 */
public interface SSODao {
	/**
	 * 
	*<b>Summary: </b>
	* getUserMappingByUserName(根据用户名获取映射信息。)
	* @param userName
	* @return
	* @throws Exception
	 */
	public String getUserMappingByUserName(String userName) throws Exception;
}

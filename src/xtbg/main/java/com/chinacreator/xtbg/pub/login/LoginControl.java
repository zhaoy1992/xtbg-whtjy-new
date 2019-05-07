package com.chinacreator.xtbg.pub.login;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:LoginControl.java</p>
 *<p>Description:登录控制类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2013-11-14
 */
public class LoginControl {
	private static final Logger logger = Logger.getLogger(LoginControl.class.getName());
	/**
	 * 
	*<b>Summary: </b>
	* zhongwenLogin(可以使用中文名登录，如果根据中文名检测出有两个用户则提示 “系统中有重名，请用帐号登陆”)
	* @param username (可能传的是中文名，也可能是用户名)
	* @param password
	* @return
	 */
	public ZhongwenLoginBean zhongwenLogin(String username,String password){
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		ZhongwenLoginBean zhongwenLoginBean = new ZhongwenLoginBean(); 

		sql.append("select t.user_realname,t.user_name,t.user_password from td_sm_user t where t.user_realname=?");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, username);
			pdb.executePrepared();
			if(pdb.size() > 1){
				zhongwenLoginBean.setCanLogin(false);
				zhongwenLoginBean.setAlertMsg("系统中有重名，请用帐号登陆");
				return zhongwenLoginBean;
			}else if(pdb.size() == 1){
				zhongwenLoginBean.setUsername(pdb.getString(0, "user_name"));
				zhongwenLoginBean.setPassword(pdb.getString(0, "user_password"));
				zhongwenLoginBean.setCanLogin(true);
				return zhongwenLoginBean;
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("登录控制类报错："+e.getMessage());
		}
		zhongwenLoginBean.setCanLogin(true);
		zhongwenLoginBean.setUsername(username);
		zhongwenLoginBean.setPassword(password);
		return zhongwenLoginBean;
		
		
		
	}
}

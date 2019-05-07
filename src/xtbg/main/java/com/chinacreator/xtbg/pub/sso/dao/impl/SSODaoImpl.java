package com.chinacreator.xtbg.pub.sso.dao.impl;
import com.chinacreator.xtbg.pub.sso.dao.SSODao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:SSODaoImpl.java</p>
 *<p>Description:单点登录DAO实现类</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-22
 */
public class SSODaoImpl implements SSODao {
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserMappingByUserName
	  * @param userName
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.sso.dao.SSODao#getUserMappingByUserName(java.lang.String)
	 */
	@Override
	public String getUserMappingByUserName(String userName) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select USER_NAME, USER_PASSWORD from TD_SM_USER where USER_NAME = ?");
    	db.preparedSelect(sql.toString());
    	db.setString(1,userName);
    	db.executePrepared();
	    if(db.size()>0){
	    	return  db.getString(0, "USER_NAME")+"#"+db.getString(0, "USER_PASSWORD");
	    }else{
	    	return "";
	    }
	    
	}
}

package com.chinacreator.xtbg.core.workbench.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.workbench.dao.UserLoginInfoDao;
import com.chinacreator.xtbg.core.workbench.entity.UserCacheBean;
import com.chinacreator.xtbg.core.workbench.support.WorkbenchConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:UserLoginInfoDaoImpl.java</p>
 *<p>Description:用户登录信息dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class UserLoginInfoDaoImpl implements UserLoginInfoDao {

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryAllUserLoginInfo
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.workbench.dao.UserLoginInfoDao#queryAllUserLoginInfo()
	 */
	@Override
	public List<UserCacheBean> queryAllUserLoginInfo(Connection conn) throws SQLException {
		String sql = "select t.username,t.userid,t.loginnumber,t.lastlogin,t.lastout,t.lastloginip,t.remark from oa_user_logininfo t ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		List<UserCacheBean> list = new ArrayList<UserCacheBean>();
		for(int i = 0; i < pdb.size() ; i++){
			UserCacheBean bean = new UserCacheBean();
			bean.setUsername(pdb.getString(i, "username"));
			bean.setUserid(pdb.getString(i, "userid"));
			bean.setLoginnumber(pdb.getInt(i, "loginnumber"));
			bean.setLastlogin(pdb.getTimestamp(i, "lastlogin"));
			bean.setLastout(pdb.getTimestamp(i, "lastout"));
			bean.setLastloginip(pdb.getString(i, "lastloginip"));
			bean.setRemark(pdb.getString(i, "remark"));
			list.add(bean);
		}
		return list;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 operLoginInfo
	  * @param list
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.workbench.dao.UserLoginInfoDao#operLoginInfo(java.util.List, java.sql.Connection)
	 */
	public boolean operLoginInfo(List<UserCacheBean> list,Connection conn) throws SQLException{
		//初次登陆入库语句
		String insertSql = "insert into oa_user_logininfo(userid,username,loginnumber,lastlogin,lastout,lastloginip,remark) values (?,?,?,?,?,?,?)";
		//登陆更新语句
		String loginInUpdatesql = "update oa_user_logininfo t set t.loginnumber=?,t.lastlogin=?,t.lastloginip=? where t.userid=?";
		//退出更新语句
		String loginOutUpdatesql = "update oa_user_logininfo t set t.lastout=? where t.userid=?";
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(UserCacheBean bean : list){
			String action = bean.getAction();
			if(WorkbenchConstants.ADD.equals(action)){//新增操作
				pdb.preparedInsert(insertSql);
				pdb.setString(1, bean.getUserid());
				pdb.setString(2, bean.getUsername());
				pdb.setInt(3, bean.getLoginnumber());
				pdb.setTimestamp(4, bean.getLastlogin());
				pdb.setTimestamp(5, bean.getLastout());
				pdb.setString(6, bean.getLastloginip());
				pdb.setString(7, bean.getRemark());
				pdb.addPreparedBatch();
			}else if(WorkbenchConstants.LOGIN_IN_UPDATE.equals(action)){//登陆更新操作
				pdb.preparedUpdate(loginInUpdatesql);
				pdb.setInt(1, bean.getLoginnumber());
				pdb.setTimestamp(2, bean.getLastlogin());
				pdb.setString(3, bean.getLastloginip());
				pdb.setString(4, bean.getUserid());
				pdb.addPreparedBatch();
			}else if(WorkbenchConstants.LOGIN_OUT_UPDATE.equals(action)){//退出更新操作
				pdb.preparedUpdate(loginOutUpdatesql);
				pdb.setTimestamp(1, bean.getLastout());
				pdb.setString(2, bean.getUserid());
				pdb.addPreparedBatch();
			}
		}
		pdb.executePreparedBatch(conn);
		return true;
	}

}

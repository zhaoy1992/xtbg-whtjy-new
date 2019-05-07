package com.chinacreator.xtbg.pub.directory.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.pub.directory.dao.UserDataDao;
import com.chinacreator.xtbg.pub.directory.entity.UserData;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:UserDataDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Jul 25, 2013
 */
public class UserDataDaoImpl implements UserDataDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insert
	  * @param bean
	  * @param con
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.directory.dao.UserDataDao#insert(com.chinacreator.xtbg.pub.directory.entity.UserData, java.sql.Connection)
	 */
	@Override
	public void insert(UserData bean, Connection con) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into wc_user_data");
		sql.append("  (id, user_id, type,created,arg1, arg2, arg3, arg4, arg5, arg6)");
		sql.append("  values");
		sql.append("  (?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?) ");
		
		pdb.preparedInsert(sql.toString());
		int i = 1;
		pdb.setString(i++, bean.getId());
		pdb.setString(i++, bean.getUser_id());
		pdb.setString(i++, bean.getType());
		pdb.setString(i++, bean.getArg1());
		pdb.setString(i++, bean.getArg2());
		pdb.setString(i++, bean.getArg3());
		pdb.setString(i++, bean.getArg4());
		pdb.setString(i++, bean.getArg5());
		pdb.setString(i++, bean.getArg6());
		
		pdb.executePrepared(con);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 update
	  * @param bean
	  * @param con
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.directory.dao.UserDataDao#update(com.chinacreator.xtbg.pub.directory.entity.UserData, java.sql.Connection)
	 */
	@Override
	public void update(UserData bean, Connection con) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update wc_user_data");
		sql.append("   set user_id = ?,");
		sql.append("       type = ?,");
		sql.append("       arg1 = ?,");
		sql.append("       arg2 = ?,");
		sql.append("       arg3 = ?,");
		sql.append("       arg4 = ?,");
		sql.append("       arg5 = ?,");
		sql.append("       arg6 = ?");
		sql.append(" where id = ?");
		pdb.preparedUpdate(sql.toString());
		int i = 1;
		pdb.setString(i++, bean.getUser_id());
		pdb.setString(i++, bean.getType());
		pdb.setString(i++, bean.getArg1());
		pdb.setString(i++, bean.getArg2());
		pdb.setString(i++, bean.getArg3());
		pdb.setString(i++, bean.getArg4());
		pdb.setString(i++, bean.getArg5());
		pdb.setString(i++, bean.getArg6());
		pdb.setString(i++, bean.getId());
		
		pdb.executePrepared(con);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 list
	  * @param bean
	  * @param con
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.directory.dao.UserDataDao#list(com.chinacreator.xtbg.pub.directory.entity.UserData, java.sql.Connection)
	 */
	@Override
	public List<UserData> list(UserData bean, Connection con) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<UserData> list = new ArrayList<UserData>();
		StringBuffer sql = new StringBuffer();
		sql.append("select id, user_id, type, arg1, arg2, arg3, arg4, arg5, arg6 from wc_user_data where user_id = ? order by created ");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1,bean.getUser_id());
		
		pdb.executePrepared(con);
		
		for(int i=0;i<pdb.size();i++){
			UserData dataBean = new UserData();
			dataBean.setId(pdb.getString(i, "id"));
			dataBean.setUser_id(pdb.getString(i, "user_id"));
			dataBean.setType(pdb.getString(i, "type"));
			dataBean.setArg1(pdb.getString(i, "arg1"));
			dataBean.setArg2(pdb.getString(i, "arg2"));
			dataBean.setArg3(pdb.getString(i, "arg3"));
			dataBean.setArg4(pdb.getString(i, "arg4"));
			dataBean.setArg5(pdb.getString(i, "arg5"));
			dataBean.setArg6(pdb.getString(i, "arg6"));
			list.add(dataBean);
		}
		return list;
	}

	@Override
	public void delete(UserData bean, Connection con) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete wc_user_data where id = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, bean.getId());
		pdb.executePrepared(con);
	}

}

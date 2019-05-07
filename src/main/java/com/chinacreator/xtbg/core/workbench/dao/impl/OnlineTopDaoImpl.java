package com.chinacreator.xtbg.core.workbench.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao;
import com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:OnlineTopDaoImpl.java</p>
 *<p>Description:系统最高在线用户数记录dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-26
 */
public class OnlineTopDaoImpl extends XtDbBaseDao implements OnlineTopDao {

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryOnlineTop
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao#queryOnlineTop()
	 */
	@Override
	public OnlineTopBean queryOnlineTop(Connection conn) throws SQLException {
		OnlineTopBean bean = new OnlineTopBean();
		String sql = "select id,personnum,recode_time from (select t.id,t.personnum,t.recode_time from" +
				" oa_onlinetop t order by t.personnum desc)  where rownum < 2 ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if(pdb.size() > 0){
			bean.setId(pdb.getString(0, "id"));
			bean.setPersonnum(pdb.getInt(0, "personnum"));
			bean.setRecode_time(pdb.getTimestamp(0, "recode_time"));
		}
		return bean;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertOnlineTop
	  * @param bean
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao#insertOnlineTop(com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean)
	 */
	@Override
	public boolean insertOnlineTop(OnlineTopBean bean,Connection conn) throws SQLException {
		String sql = "insert into oa_onlinetop(id,personnum,recode_time)values(?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		pdb.setString(1, bean.getId());
		pdb.setInt(2, bean.getPersonnum());
		pdb.setTimestamp(3, bean.getRecode_time());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOnlineTree
	  * @param user_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao#getOnlineTree(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getOnlineTree(String user_id,
			Connection conn) throws Exception{
		List<Map<String, String>> onlineTreeListMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.org_id,");
		sql.append("         a.org_name,");
		sql.append("         a.parent_id,");
		sql.append("         a.remark5");
		sql.append("    from td_sm_organization a order by a.org_sn");
		onlineTreeListMap = queryToListMap(sql.toString());
		return onlineTreeListMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOnlineUser
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao#getOnlineUser(java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> getOnlineUser(Connection con)
			throws Exception {
		List<Map<String, String>> userTreeListMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		if(true){//2013-11-27 将在线用户统计树 用户排序方式 与 权限管理用户列表排序 统一
			sql.append("select u.user_id, u.user_name, u.user_realname, o.org_id,nvl(y.same_job_user_sn,0) order_col");
			sql.append("  from td_sm_user u                                                                         ");
			sql.append(" inner join td_sm_orguser ou                                                                ");
			sql.append("    on u.user_id = ou.user_id                                                               ");
			sql.append(" inner join td_sm_organization o                                                            ");
			sql.append("    on ou.org_id = o.org_id                                                                 ");
			sql.append("  left join (                                                                               ");
			sql.append("       select user_id, MIN(same_job_user_sn) same_job_user_sn                               ");
			sql.append("        from td_sm_userjoborg                                                               ");
			sql.append("       group by user_id                                                                     ");
			sql.append("  ) y                                                                                       ");
			sql.append("    on u.user_id = y.user_id                                                                ");
			sql.append(" order by order_col,u.user_id,u.user_sn                                                     ");
		}else{
			sql.append("     select u.user_id, u.user_name, u.user_realname, o.org_id");
			sql.append("       from td_sm_user u, td_sm_orguser ou, td_sm_organization o");
			sql.append("      where u.user_id = ou.user_id");
			sql.append("        and ou.org_id = o.org_id order by u.user_sn");
		}
		userTreeListMap = queryToListMap(sql.toString());
		return userTreeListMap;
	}

}

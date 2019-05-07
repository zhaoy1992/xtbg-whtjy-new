package com.chinacreator.xtbg.core.file.util;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 档案管理-模块管理-工具类
 *<p>Title:ModuleUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-4-24
 */
public class ModuleUtil {

	private static final Logger LOG = Logger.getLogger(ModuleUtil.class);
	/**
	 * 公文待归档页面的三个角色
	 */
	public static final String ROLE_DWDAGLY = "单位档案管理员";
	public static final String ROLE_BMDAGLY = "部门档案管理员";//部门综合岗(部门档案管理员)
	public static final String ROLE_GWNGR = "公文拟稿人";
	/**
	 * 
	 *<b>Summary: </b>
	 * checkRoleForGWDGD(公文待归档时,检查角色)
	 * @return
	 */
	public static String checkRoleForGWDGD(String user_id){
		if(isRolesUser(user_id, ROLE_DWDAGLY)){
			return ROLE_DWDAGLY;
		}else if(isRolesUser(user_id, ROLE_BMDAGLY)){
			return ROLE_BMDAGLY;
		}else{
			return ROLE_GWNGR;
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * isRolesUser(请用一句话描述这个方法的作用)
	 * @param user_id
	 * @param role_name
	 * @return
	 */
	public static boolean isRolesUser(String user_id,String role_name) {
		Connection conn = null;
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select role_name from td_sm_userrole d ,td_sm_role t where d.role_id=t.role_id and d.user_id=? and t.role_name=? ";
			pdb.preparedSelect(sql);
			pdb.setString(1, user_id);
			pdb.setString(2, role_name);
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}

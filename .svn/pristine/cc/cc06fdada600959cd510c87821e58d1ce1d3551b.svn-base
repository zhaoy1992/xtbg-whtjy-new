package com.chinacreator.xtbg.core.file.util;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.frameworkset.common.poolman.PreparedDBUtil;


public class FileUtil {
	
	private static final Log LOG = LogFactory.getLog(FileUtil.class);
	
	/**
	*<b>Summary: </b>
	* getRoleName(是否为角色用户，判断user_id是否有role_name角色)
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

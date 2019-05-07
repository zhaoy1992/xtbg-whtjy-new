package com.chinacreator.xtbg.core.kbm.util;

import java.sql.Connection;
import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class KbmUtil {

	private static final Log LOG = LogFactory.getLog(KbmUtil.class);

	
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
	
	
	/**
	*<b>Summary: </b>
	* isHaveRight(是否有知识分类中定义的权限)
	* @param k_secrecy_id
	* @param k_type_id
	* @param k_user
	* @param type_unit 用户单位
	* @param type_dept 用户部门
	* @return 
	*/
	public static boolean isHaveRight(String k_secrecy_id,String k_type_id,String k_user,String type_unit,String type_dept) {
		Connection conn = null;
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil rightpdb = new PreparedDBUtil();
		StringBuffer rightsql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			String sqlWhere = "1=2";//k_role_ids
			String sql = "select t.group_id from td_sm_usergroup d,td_sm_group t where d.group_id=t.group_id and d.user_id=? ";
			pdb.preparedSelect(sql);
			pdb.setString(1, k_user);
			pdb.executePrepared(conn);
			for(int i=0;i<pdb.size();i++){
				sqlWhere += " or ',' || dd.k_role_ids || ',' like ('%,"+pdb.getString(0, "group_id")+",%')";
			}
			//得到sqlWhere当前查询文档人员的用户组条件
			
			rightsql.append("select count(*) iCount");
			rightsql.append("  from (select dd.*");
			rightsql.append("          from (select t.k_type_name,");
			rightsql.append("                       d.k_role_range,");
			rightsql.append("                       d.k_role_range_name,");
			rightsql.append("                       decode(nvl(d.k_role_range, ''), '', k_role_ids) role_ids,");
			rightsql.append("                       decode(d.k_role_range, 1, t.k_type_unit) type_unit,");
			rightsql.append("                       decode(d.k_role_range, 0, t.k_type_dept) type_dept,");
			rightsql.append("                       t.k_type_unit_name,");
			rightsql.append("                       t.k_type_dept_name,");
			rightsql.append("                       d.k_role_ids");
			rightsql.append("                  from OA_KBM_DOC_TYPE_RIGHT_CONFIG d, OA_KBM_DOC_TYPE t");
			rightsql.append("                 where t.k_type_id = d.k_type_id");
			rightsql.append("                   and d.k_secrecy_id = ? "); 
			rightsql.append("                   and t.k_type_id = ? ");
			rightsql.append("                ) dd");
			rightsql.append("         where ("+sqlWhere+" or");
			rightsql.append("               dd.type_unit = ? or");
			rightsql.append("               dd.type_dept = ? ))");
			
			rightpdb.preparedSelect(rightsql.toString());
			rightpdb.setString(1, k_secrecy_id);
			rightpdb.setString(2, k_type_id);
			rightpdb.setString(3, type_unit);
			rightpdb.setString(4, type_dept);
			rightpdb.executePrepared(conn);
			if(rightpdb.size() > 0) {
				if(!rightpdb.getString(0, "iCount").equalsIgnoreCase("0")){
					flag=true;
				}
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	
	/**
	*<b>Summary: </b>
	* isSuggestUser(文档是否推荐给了当前用户)
	* @param user_id
	* @param role_name
	* @return 
	*/
	public static boolean isSuggestUser(String k_doc_id,String k_user) {
		Connection conn = null;
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select k_user from oa_kbm_doc_suggest s where s.k_doc_id =? and s.k_user =? ";
			pdb.preparedSelect(sql);
			pdb.setString(1, k_doc_id);
			pdb.setString(2, k_user);
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
	
	
	/**
	*<b>Summary: </b>
	* getUserNames(得到用户names)
	* @param userIds
	* @return 
	*/
	public static String getUserNames(String userIds){
		Connection conn = null;
		String userNames = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append("select wm_concat(u.user_realname) userNames");
			sql.append("   from td_sm_user u");
			sql.append("  where u.user_id in ('"+userIds.replaceAll(",", "','")+"')");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				userNames = pdb.getString(0, "userNames");
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return userNames;
	
	}
	
	/**
	*<b>Summary: </b>
	* getSuggestUserByDocId(得到文档的推荐人)
	* @param k_doc_id
	* @return 
	*/
	public static String getSuggestUserByDocId(String k_doc_id) {
		Connection conn = null;
		String k_users = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append("select wm_concat(t.k_user) k_users");
			sql.append("   from OA_KBM_DOC_suggest t");
			sql.append("  where t.k_doc_id = ?");
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, k_doc_id);
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				k_users = pdb.getString(0, "k_users");
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return k_users;
	}
	/**
	 * 
	*<b>Summary: </b>
	* getOrder(得到传入相应表的排序号最大的下一个)
	* @param order
	* @param tablename
	* @return
	 */
	public static int getOrder(String order,String tablename,String findname,String findvalue) {
		Connection conn = null;
		int count=1;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append(" select "+order+" table_order from (select "+order+",decode("+findname+",null,'0','','0',"+findname+")  "+findname+ " from "+tablename+" where "+order+" is not null) where 1=1   ");
			if(!StringUtil.isBlank(findname)){
				if(StringUtil.isBlank(findvalue)){
					findvalue="0";
				}
				sql.append(" and "+findname+ "='"+findvalue+"' ");
			}
			sql.append(" order by "+order+" desc");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				count=pdb.getInt(0, "table_order")+1;
			}
		} catch (SQLException e) {
			LOG.error("获得默认排序号失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return count;
	}
}

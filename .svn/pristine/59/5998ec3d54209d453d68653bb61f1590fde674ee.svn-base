package com.chinacreator.xtbg.core.personwork.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.personwork.dao.PriManageDao;
import com.chinacreator.xtbg.core.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.core.personwork.entity.PriManageBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:PriManageDaoImpl.java
 * </p>
 *<p>
 * Description:
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-7
 */
public class PriManageDaoImpl implements PriManageDao {

	/**
	 * 
	 * <b>Summary: 查询登录用户权限下的所有公共通讯录条目 return pb 分页实体 PagingBean</b> 复写方法
	 * findPriManageBeanList
	 * 
	 * @param prBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PriManageDao#findPriManageBeanList(com.chinacreator.xtbg.core.personwork.entity.PriManageBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findPriManageBeanList(PriManageBean prBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PagingBean pb = new PagingBean();

			PreparedDBUtil db = new PreparedDBUtil();
			List<PriManageBean> list = new ArrayList<PriManageBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		u.user_realname,");
			sql.append("        r.leaders, ");
			sql.append("        r.user_id");
			sql.append(" from td_sm_user u,oa_personwork_role r ");
			sql.append(" where u.user_id=r.user_id ");

			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				PriManageBean pib = new PriManageBean();
				pib.setLoginUserName(db.getString(i, "user_realname"));
				pib.setLeaders(db.getString(i, "leaders"));
				pib.setLeadID(db.getString(i, "user_id"));
				list.add(pib);
			}

			pb.setList(list);
			pb.setRecords((long) db.getTotalSize());
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: 增加条目s</b> 复写方法 insertPrivilege
	 * 
	 * @param prBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PriManageDao#insertPrivilege(com.chinacreator.xtbg.core.personwork.entity.PriManageBean)
	 */
	public boolean insertPrivilege(PriManageBean prBean) throws SQLException {
		boolean flag = true;
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql
					.append("insert into oa_personwork_role (role_id,user_id,leaders,leaders_userid) ");
			sql.append("values(?,?,?,?)");

			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.getUUID());
			db.setString(2, StringUtil.deNull(prBean.getLeadID()));
			db.setString(3, StringUtil.deNull(prBean.getPersons()));
			db.setString(4, StringUtil.deNull(prBean.getPersonsID()));
			db.executePrepared(conn);

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary: 查询用户id是否已经存在</b> queryUserID(请用一句话描述这个方法的作用)
	 * 
	 * @param pBean
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List queryUserID(PriManageBean pBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			List list = new ArrayList();
			StringBuffer sql = new StringBuffer();
			sql
					.append("select user_id,leaders,leaders_userid  from oa_personwork_role where user_id=? ");

			db.preparedSelect(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.executePrepared(conn);
			if (db.size() != 0) {
				for (int i = 0; i < db.size(); i++) {
					pBean.setReLeaders(db.getString(i, "leaders"));
					pBean.setRepersonsID(db.getString(i, "leaders_userid"));
					list.add(pBean);
				}
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary: 更新数据</b> updatePriInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param pBean
	 * @return
	 * @throws SQLException
	 */
	public boolean updatePriInfo(PriManageBean pBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			boolean flag = true;
			sql.append("update");
			sql
					.append(" oa_personwork_role set leaders = ? , leaders_userid =?  ");
			sql.append(" where user_id= ? ");

			db.preparedUpdate(sql.toString());
			db.setString(1, pBean.getPersons());
			db.setString(2, pBean.getPersonsID());
			db.setString(3, pBean.getLeadID());
			db.executePrepared(conn);

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary:删除记录 </b> deletePriInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param pBean
	 * @return
	 * @throws SQLException
	 */
	public boolean deletePriInfo(PriManageBean pBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			boolean flag = true;
			sql.append("delete");
			sql.append(" from oa_personwork_role ");
			sql.append(" where user_id = ? ");

			db.preparedDelete(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.executePrepared(conn);

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary:查询单条记录 </b> querySingle(请用一句话描述这个方法的作用)
	 * 
	 * @param pBean
	 * @return
	 * @throws SQLException
	 */
	public PriManageBean querySingle(PriManageBean pBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql
					.append(" r.leaders, u.user_realname from oa_personwork_role r,td_sm_user u  ");
			sql.append(" where u.user_id=? and r.user_id=? ");

			db.preparedSelect(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.setString(2, pBean.getLeadID());
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				pBean.setLeadName(db.getString(i, "user_realname"));
				pBean.setPersons(db.getString(i, "leaders"));
			}

			return pBean;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: 查询分组表</b> 复写方法 queryGroup
	 * 
	 * @param pbGroupBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PriManageDao#queryGroup(com.chinacreator.xtbg.core.personwork.entity.PGroupBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryGroup(PGroupBean pbGroupBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PagingBean pb = new PagingBean();
			PreparedDBUtil db = new PreparedDBUtil();
			List<PGroupBean> list = new ArrayList<PGroupBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		rownum , ");
			sql.append("        group_name, ");
			sql.append("        group_id ");
			sql.append(" from oa_personwork_group ");
			sql.append(" where user_id = ? ");

			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, pbGroupBean.getLoginUserID());
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				PGroupBean pgb = new PGroupBean();
				pgb.setRownum(db.getString(i, "rownum"));
				pgb.setGroupName(db.getString(i, "group_name"));
				pgb.setGroupID(db.getString(i, "group_id"));
				list.add(pgb);
			}

			pb.setList(list);
			pb.setRecords((long) db.getTotalSize());
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryGroup4List
	 * 
	 * @param pbGroupBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.personwork.dao.PriManageDao#queryGroup4List(com.chinacreator.xtbg.core.personwork.entity.PGroupBean)
	 */
	@Override
	public List<PGroupBean> queryGroup4List(PGroupBean pbGroupBean)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PreparedDBUtil db = new PreparedDBUtil();
			List<PGroupBean> list = new ArrayList<PGroupBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		rownum , ");
			sql.append("        group_name, ");
			sql.append("        group_id ");
			sql.append(" from oa_personwork_group ");
			if (StringUtil.deNull(pbGroupBean.getIs_public_group()).equals("1")) {//公共通讯录，任何人都可以查看
				sql.append(" where is_public_group = ?");
			} else {
				sql.append(" where user_id = ? and is_public_group = ?");
			}
			db.preparedSelect(sql.toString());
			if (StringUtil.deNull(pbGroupBean.getIs_public_group()).equals("1")) {//公共通讯录，任何人都可以查看
				db.setString(1, pbGroupBean.getIs_public_group());
			} else {
				db.setString(1, pbGroupBean.getLoginUserID());
				db.setString(2, pbGroupBean.getIs_public_group());
			}
			db.executePrepared(conn);
			for (int i = 0; i < db.size(); i++) {
				PGroupBean pgb = new PGroupBean();
				pgb.setRownum(db.getString(i, "rownum"));
				pgb.setGroupName(db.getString(i, "group_name"));
				pgb.setGroupID(db.getString(i, "group_id"));
				pgb.setIs_public_group(pbGroupBean.getIs_public_group());
				list.add(pgb);
			}

			return list;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	*<b>Summary: 根据分组id查询分组信息</b>
	* queryGroup(请用一句话描述这个方法的作用)
	* @param groupId  通讯录分组的id
	* @return  分组对象
	* @throws SQLException
	 */
	public PGroupBean queryGroup(String groupId) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			PGroupBean pgb = new PGroupBean();
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append("        group_name");

			sql.append(" from oa_personwork_group ");
			sql.append(" where group_id = ? ");

			db.preparedSelect(sql.toString());
			db.setString(1, groupId);
			db.executePrepared(conn);
			if (db.size() > 0) {
				pgb.setGroupName(db.getString(0, "group_name"));
			}

			return pgb;
		} finally {
			DbManager.closeConnection(conn);
		}

	}

	/**
	 * 增加分组
	 * 
	 * @throws SQLException
	 */
	public boolean insertGroup(PGroupBean pGroupBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			boolean flag = true;
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql
					.append(" insert into oa_personwork_group (group_id,user_id,group_name,is_public_group) ");
			sql.append(" values (?, ? , ?, ?) ");

			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.getUUID());
			db.setString(2, StringUtil.deNull(pGroupBean.getLoginUserID()));
			db.setString(3, StringUtil.deNull(pGroupBean.getGroupName()));
			db.setString(4, StringUtil.deNull(pGroupBean.getIs_public_group()));
			db.executePrepared(conn);

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 更新分组
	 * 
	 * @throws SQLException
	 */
	public boolean updateGroup(PGroupBean pGroupBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			boolean flag = true;
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append(" update oa_personwork_group set group_name=?  ");
			sql.append(" where group_id =  ?  ");

			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(pGroupBean.getGroupName()));
			db.setString(2, StringUtil.deNull(pGroupBean.getGroupID()));
			db.executePrepared(conn);

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 查询分组是否已存在
	 * 
	 * @throws SQLException
	 */
	public boolean queryExist(PGroupBean pGroupBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			boolean flag = true;
			PreparedDBUtil db = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from oa_personwork_group ");
			sql.append(" where group_name= ? and user_id= ? and is_public_group = ?");

			db.preparedSelect(sql.toString());
			db.setString(1, StringUtil.deNull(pGroupBean.getGroupName()));
			db.setString(2, StringUtil.deNull(pGroupBean.getLoginUserID()));
			db.setString(3, StringUtil.deNull(pGroupBean.getIs_public_group()));
			db.executePrepared(conn);
			if (db.size() != 0) {
				flag = false;
			}

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 删除分组
	 * 
	 * @throws SQLException
	 */
	public boolean deleteGroup(PGroupBean pGroupBean) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			boolean flag = true;
			PreparedDBUtil db = new PreparedDBUtil();
			PreparedDBUtil dbd = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			StringBuffer sqld = new StringBuffer();
			if (!StringUtil.nullOrBlank(pGroupBean.getGroupID())) {
				sql.append(" delete from oa_personwork_persongroup ");
				if (pGroupBean.getGroupID().indexOf(",") != -1) {
					sql.append(" where group_id in (").append(
							StringUtil.deNull(pGroupBean.getGroupID())).append(
							")");
				} else {
					sql.append(" where group_id = '").append(
							StringUtil.deNull(pGroupBean.getGroupID())).append(
							"'");
				}

				sqld.append(" delete from oa_personwork_group ");
				if (pGroupBean.getGroupID().indexOf(",") != -1) {
					sqld.append(" where group_id in (").append(
							StringUtil.deNull(pGroupBean.getGroupID())).append(
							")");
				} else {
					sqld.append(" where group_id = '").append(
							StringUtil.deNull(pGroupBean.getGroupID())).append(
							"'");
				}

				db.preparedDelete(sql.toString());
				dbd.preparedDelete(sqld.toString());
				db.executePrepared(conn);
				dbd.executePrepared(conn);

			}

			return flag;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

}

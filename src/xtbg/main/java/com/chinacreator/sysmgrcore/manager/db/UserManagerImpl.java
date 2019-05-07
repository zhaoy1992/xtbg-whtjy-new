package com.chinacreator.sysmgrcore.manager.db;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;
import org.frameworkset.event.Event;
import org.frameworkset.event.EventHandle;
import org.frameworkset.event.EventImpl;
import org.frameworkset.spi.SPIException;

import com.chinacreator.config.ConfigManager;
import com.chinacreator.epp.applymanager.dbmanager.OrgUserManager;
import com.chinacreator.epp.util.AppIdThreadLocal;
import com.chinacreator.epp.util.EgpManager;
import com.chinacreator.security.AccessControl;
import com.chinacreator.security.authentication.EncrpyPwd;
import com.chinacreator.security.event.ACLEventType;
import com.chinacreator.sysmgrcore.control.DataControl;
import com.chinacreator.sysmgrcore.control.PageConfig;
import com.chinacreator.sysmgrcore.control.Parameter;
import com.chinacreator.sysmgrcore.entity.Accredit;
import com.chinacreator.sysmgrcore.entity.Dictdata;
import com.chinacreator.sysmgrcore.entity.Group;
import com.chinacreator.sysmgrcore.entity.Job;
import com.chinacreator.sysmgrcore.entity.Log;
import com.chinacreator.sysmgrcore.entity.Operation;
import com.chinacreator.sysmgrcore.entity.Organization;
import com.chinacreator.sysmgrcore.entity.Orgjob;
import com.chinacreator.sysmgrcore.entity.Res;
import com.chinacreator.sysmgrcore.entity.Role;
import com.chinacreator.sysmgrcore.entity.Tempaccredit;
import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.sysmgrcore.entity.UserAndSn;
import com.chinacreator.sysmgrcore.entity.UserJobs;
import com.chinacreator.sysmgrcore.entity.Userattr;
import com.chinacreator.sysmgrcore.entity.Usergroup;
import com.chinacreator.sysmgrcore.entity.Userjoborg;
import com.chinacreator.sysmgrcore.entity.Userresop;
import com.chinacreator.sysmgrcore.entity.Userrole;
import com.chinacreator.sysmgrcore.exception.ControlException;
import com.chinacreator.sysmgrcore.exception.ManagerException;
import com.chinacreator.sysmgrcore.manager.LogManager;
import com.chinacreator.sysmgrcore.manager.OrgManager;
import com.chinacreator.sysmgrcore.manager.SecurityDatabase;
import com.chinacreator.sysmgrcore.manager.UserManager;
import com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionException;
import com.frameworkset.orm.transaction.TransactionManager;
import com.frameworkset.util.ListInfo;
import com.frameworkset.util.StringUtil;

/**
 * 项目：SysMgrCore <br>
 * 描述：用户管理(DB实现类) <br>
 * 版本：1.0 <br>
 * 
 * @author 吴卫雄
 */
public class UserManagerImpl extends EventHandle implements UserManager {

	private DataControl cb = DataControl
			.getInstance(DataControl.CONTROL_INSTANCE_DB);

	private static Logger logger = Logger.getLogger(UserManagerImpl.class
			.getName());

	public class UserComparator implements Comparator {

		public int compare(Object arg0, Object arg1) {
			Object[] o1 = (Object[]) arg0;
			Object[] o2 = (Object[]) arg1;

			if (o1[1] != null && o2[1] != null) {
				return ((Integer) o1[1]).intValue()
						- ((Integer) o2[1]).intValue();
			} else {
				return 0;
			}
		}
	}

	/**
	 * 没有被使用
	 * 
	 * @param user
	 * @return
	 * @throws ManagerException
	 * @deprecated 不推荐使用该方法保存用户，已经被addUser(User)方法替代
	 */
	public boolean storeUser(User user) throws ManagerException {
		// boolean r = false;
		// if (user != null) {
		// try {
		// // 检查当前用户实例是否来自LDAP，因为LDAP中的用户ID(UID)是采用用户名标识其唯一性
		// if (user.getUserId() != null
		// && user.getUserId().intValue() == -1) {
		// User oldUser = getUser("userName", user.getUserName());
		// if (oldUser == null)
		// user.setUserId(null);
		// else {
		//
		// user.setUserId(oldUser.getUserId());
		// String oldpassword = StringUtil.replaceNull(oldUser
		// .getUserPassword());
		// String newpassword = StringUtil.replaceNull(user
		// .getUserPassword());
		// if (!oldpassword.equals(EncrpyPwd
		// .encodePassword(newpassword)))
		// user.setUserPassword(EncrpyPwd
		// .encodePassword(newpassword));
		//
		// }
		//
		// } else {
		// String password = StringUtil.replaceNull(user
		// .getUserPassword());
		// user.setUserPassword(EncrpyPwd.encodePassword(password));
		// }
		// Parameter p = new Parameter();
		//
		// // 保存
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(user);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// e.printStackTrace();
		// }
		// }
		System.out
				.println("hibernate->使用了UserManagerImpl类下的storeUser(User user)方法。。。");
		return false;
	}

	/**
	 * 没有被使用
	 * 
	 * @deprecated 不推荐使用该方法，系统中没用使用该方法
	 */
	public boolean storeUser(User user, String propName, String value)
			throws ManagerException {
		boolean r = false;

		// if (user != null) {
		// try {
		// // 检查数据库中是否存在与属性以及属性值相同的记录，有则用 user 对象实例中的值
		// // 更新该记录否则插入新的记录
		// User oldUser = getUser(propName, value);
		// if (oldUser == null)
		// user.setUserId(null);
		// else
		// user.setUserId(oldUser.getUserId());
		//
		// Parameter p = new Parameter();
		//
		// // 保存
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(user);
		// cb.execute(p);
		// Event event = new EventImpl("", ACLEventType.USER_INFO_ADD);
		// super.change(event);
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	public boolean storeLogincount(String userName) throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		String sql = "update td_sm_user set  USER_LOGINCOUNT=USER_LOGINCOUNT+1"
				+ " where  USER_NAME='" + userName + "'";
		try {
			db.executeUpdate(sql);
			r = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return r;

	}

	/**
	 * 无效的方法
	 * 
	 * @deprecated 无效的方法，方法实现已经删除
	 */
	public boolean storeUserattr(Userattr userattr) throws ManagerException {
		boolean r = false;

		// if (userattr != null) {
		// try {
		// Parameter p = new Parameter();

		// // 先查找数据库中当前用户是否存在同名的属性，如果有则取该属性的ID
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from Userattr ua where ua.userattrName='"
		// + userattr.getUserattrName() + "' and ua.user.userId='"
		// + userattr.getUserId() + "'");
		// List list = (List) cb.execute(p);
		// if (list != null && !list.isEmpty()) {
		// Userattr oldUserattr = (Userattr) list.get(0);
		// userattr.setUserattrId(oldUserattr.getUserattrId());
		// }
		//		
		// // 保存
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(userattr);
		// cb.execute(p);
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		System.out
				.println("hibernate->使用了UserManagerImpl类下的storeUserattr(Userattr userattr)方法。。。");
		return r;
	}

	public boolean storeUserjoborg(Userjoborg userjoborg)
			throws ManagerException {
		boolean r = false;

		if (userjoborg != null) {
			DBUtil dbUtil = new DBUtil();
			try {
				// Parameter p = new Parameter();
				//
				// p.setCommand(Parameter.COMMAND_STORE);
				// p.setObject(userjoborg);
				// cb.execute(p);
				StringBuffer sql = new StringBuffer();
				sql
						.append(
								"insert into TD_SM_USERJOBORG(USER_ID, JOB_ID, ORG_ID, SAME_JOB_USER_SN, JOB_SN, JOB_STARTTIME, JOB_FETTLE) ")
						.append("values('")
						.append(userjoborg.getUser().getUserId())
						.append("', '")
						.append(userjoborg.getJob().getJobId())
						.append("', '")
						.append(userjoborg.getOrg().getOrgId())
						.append("', '")
						.append(userjoborg.getSameJobUserSn())
						.append("', '")
						.append(userjoborg.getJobSn())
						.append("', ")
						.append(
								String.valueOf(userjoborg.getStartTime()) == "null" ? "''"
										: DBUtil.getDBDate(userjoborg
												.getStartTime()
												.toLocaleString())).append(
								", '").append(userjoborg.getFettle()).append(
								"')");
				dbUtil.executeInsert(sql.toString());
				Event event = new EventImpl(String.valueOf(userjoborg.getUser()
						.getUserId()), ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean storeUserrole(Userrole userrole) throws ManagerException {
		boolean r = false;

		// if (userrole != null) {
		// try {
		// Parameter p = new Parameter();
		//
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(userrole);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		String saveUserRole = "insert into td_sm_userrole(user_id,role_id) values('"
				+ userrole.getUser().getUserId()
				+ "','"
				+ userrole.getRole().getRoleId() + "')";
		DBUtil db = new DBUtil();
		try {
			db.executeInsert(saveUserRole);
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
			r = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean storeUsergroup(Usergroup usergroup) throws ManagerException {
		boolean r = false;

		// if (usergroup != null) {
		// try {
		// Parameter p = new Parameter();
		//
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(usergroup);
		// cb.execute(p);
		//
		// // Event event = new EventImpl(usergroup,
		// // ACLEventType.GROUP_INFO_ADD);
		// // super.change(event);
		//
		// r = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_GROUP_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		String saveUserGroup = "insert into td_sm_usergroup(group_id,user_id) values('"
				+ usergroup.getGroup().getGroupId()
				+ "','"
				+ usergroup.getUser().getUserId() + "')";
		DBUtil db = new DBUtil();
		try {
			db.executeInsert(saveUserGroup);
			Event event = new EventImpl("", ACLEventType.USER_GROUP_INFO_CHANGE);
			super.change(event);
			r = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return r;
	}

	/**
	 * 保存用户 用户组关系
	 * 
	 * @param usergroup
	 * @return
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean addUsergroup(Integer userid, String[] groupid)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		// TransactionManager tm = new TransactionManager();
		// PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		// StringBuffer sql = new StringBuffer();
		try {
			// tm.begin();
			for (int i = 0; (groupid != null) && (i < groupid.length); i++) {
				// sql.append("insert into td_sm_usergroup(user_id,group_id) ")
				// .append("(select ? as user_id,? as group_id from dual ")
				// .append(" where not exists (select user_id,group_id from
				// td_sm_usergroup where ")
				// .append(" user_id = ? and group_id=?))");
				// preparedDBUtil.preparedInsert(sql.toString());
				// preparedDBUtil.setString(1, String.valueOf(userid));
				// preparedDBUtil.setString(2, groupid[i]);
				// preparedDBUtil.setString(3, String.valueOf(userid));
				// preparedDBUtil.setString(4, groupid[i]);
				//				
				// preparedDBUtil.addPreparedBatch();
				String sql = "insert into td_sm_usergroup(user_id,group_id) "
						+ "(select "
						+ String.valueOf(userid)
						+ " as user_id ,"
						+ groupid[i]
						+ " as group_id "
						+ " from dual where not exists (select * from td_sm_usergroup where "
						+ " user_id =" + String.valueOf(userid)
						+ " and group_id=" + groupid[i] + "))";
				db.addBatch(sql);
				logger.warn(sql);
			}
			db.executeBatch();
			// preparedDBUtil.executePreparedBatch();
			r = true;
			// tm.commit();
			Event event = new EventImpl("", ACLEventType.USER_GROUP_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			// try {
			// tm.rollback();
			// } catch (RollbackException e1) {
			// e1.printStackTrace();
			// }
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}

		return r;
	}

	/**
	 * 保存用户 用户组关系
	 * 
	 * @param userid
	 *            用户ID
	 * @param groupid
	 *            用户组ID
	 * @param orgId
	 *            机构ID
	 * @return true:成功 false:失败
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author 彭盛 2011-3-15
	 */
	public boolean addUsergroup(Integer userid, String[] groupid, String orgId)
			throws ManagerException {
		boolean r = false;
		if (null != groupid && groupid.length > 0 && null != orgId
				&& !orgId.trim().equals("")) {
			TransactionManager tm = new TransactionManager();
			PreparedDBUtil select_preparedDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();
			StringBuffer select_sql = new StringBuffer();
			select_sql
					.append("select count(*) from td_sm_usergroup where user_id=? and group_id=? and org_id=?");
			StringBuffer insert_sql = new StringBuffer();
			insert_sql
					.append("insert into td_sm_usergroup(user_id,group_id,org_id) values(?,?,?)");
			boolean bl = false;
			try {
				tm.begin();
				for (int i = 0; (groupid != null) && (i < groupid.length); i++) {
					select_preparedDBUtil.preparedSelect(select_sql.toString());
					select_preparedDBUtil.setString(1, String.valueOf(userid));
					select_preparedDBUtil.setString(2, groupid[i]);
					select_preparedDBUtil.setString(3, orgId);
					select_preparedDBUtil.executePrepared();

					if (null != select_preparedDBUtil
							&& select_preparedDBUtil.getInt(0, 0) <= 0) {
						insert_preparedDBUtil.preparedInsert(insert_sql
								.toString());
						insert_preparedDBUtil.setString(1, String
								.valueOf(userid));
						insert_preparedDBUtil.setString(2, groupid[i]);
						insert_preparedDBUtil.setString(3, orgId);
						insert_preparedDBUtil.addPreparedBatch();
						bl = true;
					}
				}
				if (bl)
					insert_preparedDBUtil.executePreparedBatch();
				r = true;
				tm.commit();
				Event event = new EventImpl("",
						ACLEventType.USER_GROUP_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
				throw new ManagerException(e.getMessage());
			}
		} else {
			throw new ManagerException("保存用户与用户组关系失败！参数为空！");
		}
		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean storeUserresop(Userresop userresop) throws ManagerException {
		boolean r = false;

		// if (userresop != null) {
		// try {
		// Parameter p = new Parameter();
		//
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(userresop);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean storeTempaccredit(Tempaccredit tempaccredit)
			throws ManagerException {
		boolean r = false;

		// if (tempaccredit != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(tempaccredit);
		//
		// cb.execute(p);
		//
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean storeAccredit(Accredit accredit) throws ManagerException {
		boolean r = false;

		// if (accredit != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(accredit);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 删除用户所有资源
	 */
	public boolean deleteUserRes(User user) throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		// String sql = "delete from TD_SM_USER_ADDONS where user_id ="
		// + user.getUserId() + "";
		// TD_SM_USER_ADDONS 不存在

		// 删除用户的主机构
		String sql1 = "delete from TD_SM_ORGUSER where user_id ="
				+ user.getUserId() + "";
		// 判断是否有这个表 有的话 再删除.
		String sql2 = "delete from TD_cms_siteuser where user_id ="
				+ user.getUserId() + "";
		// 删除用户自身资源
		String sql3 = "delete TD_SM_roleresop a where" + " a.role_id='"
				+ user.getUserId() + "' and a.types='user'";
		// 删除用户对应的机构管理员td_sm_orgmanager关系表---add gao.tang 2007.11.19
		String sql4 = "delete from TD_SM_ORGMANAGER where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户的用户组所关联的 Usergroup 对象---add gao.tang 2007.11.19
		String sql5 = "delete from TD_SM_USERGROUP where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户机构岗位关系表---add gao.tang 2007.11.19
		String sql6 = "delete from TD_SM_USERJOBORG where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户角色资源---add gao.tang 2007.11.19
		String sql7 = "delete from TD_SM_USERROLE where USER_ID = '"
				+ user.getUserId() + "' ";
		TransactionManager tm = new TransactionManager();
		if (user != null) {
			try {
				tm.begin();
				// 批处理操作
				db.addBatch(sql1);
				if (db.getTableMetaData("TD_cms_siteuser") != null) {
					db.addBatch(sql2);
				}
				db.addBatch(sql3);
				db.addBatch(sql4);
				db.addBatch(sql5);
				db.addBatch(sql6);
				if (!"1".equals(String.valueOf(user.getUserId()))) {// 删除机构时机构中存在admin超级管理员，不删除超级管理员与较色的关系
					db.addBatch(sql7);
				}
				db.executeBatch();
				tm.commit();

				r = true;
				Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
				super.change(event);
			} catch (SQLException e2) {
				e2.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			}
		}
		// try {

		// cb.setAutoCommit(false);
		//
		// SchedularManagerImpl schImpl = new SchedularManagerImpl();
		// schImpl.deleteAllSchTableByUserId(user.getUserId().intValue());
		//
		// // 删除当前用户的所关联的 Userjoborg 对象
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Userjoborg ujo where ujo.id.userId = "
		// + user.getUserId());
		// cb.execute(p);
		//
		// // 删除当前用户的所关联的 Userrole 对象
		// p.setObject("from Userrole ur where ur.id.userId = "
		// + user.getUserId());
		// cb.execute(p);
		//
		// // 删除当前用户的所关联的 Usergroup 对象
		// p.setObject("from Usergroup ug where ug.id.userId = "
		// + user.getUserId());
		// cb.execute(p);
		//
		// // 删除指定的用户实例
		// p.setObject("from User u where u.userId = " + user.getUserId());
		// cb.execute(p);
		// cb.commit(true);
		// r = true;
		// // 触发删除缓冲中用户的事件
		// Event event = new EventImpl(user.getUserId().toString(),
		// ACLEventType.USER_INFO_DELETE);
		// super.change(event);
		// } catch (ControlException e) {
		//
		// try {
		// cb.rollback(true);
		// } catch (ControlException e1) {
		// logger.error(e1);
		// }
		//
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	public boolean deleteUser(User user) throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		// String sql = "delete from TD_SM_USER_ADDONS where user_id ="
		// + user.getUserId() + "";
		// TD_SM_USER_ADDONS 不存在
		// 删除用户的主机构

		// 删除用户
		String sql = "delete from TD_SM_USER where user_id ="
				+ user.getUserId();

		String sql1 = "delete from TD_SM_ORGUSER where user_id ="
				+ user.getUserId() + "";
		// 111
		String sql2 = "delete from TD_cms_siteuser where user_id ="
				+ user.getUserId() + "";
		// 删除用户自身资源
		String sql3 = "delete TD_SM_roleresop a where" + " a.role_id='"
				+ user.getUserId() + "' and a.types='user'";
		// 删除用户对应的机构管理员td_sm_orgmanager关系表---add gao.tang 2007.11.19
		String sql4 = "delete from TD_SM_ORGMANAGER where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户的用户组所关联的 Usergroup 对象---add gao.tang 2007.11.19
		String sql5 = "delete from TD_SM_USERGROUP where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户机构岗位关系表---add gao.tang 2007.11.19
		String sql6 = "delete from TD_SM_USERJOBORG where USER_ID = '"
				+ user.getUserId() + "' ";
		// 删除用户角色资源---add gao.tang 2007.11.19
		String sql7 = "delete from TD_SM_USERROLE where USER_ID = '"
				+ user.getUserId() + "' ";

		// 删除用户历史任职表记录 gao.tang add by 2008.09.09
		String sql8 = "delete from td_sm_userjoborg_history where user_id = "
				+ user.getUserId();
		
		// 删除用户调动信息 彭盛 2011-4-15
		String sql9 = "delete from td_sm_userchangeorg_data where user_id="
				+ user.getUserId();

		TransactionManager tm = new TransactionManager();
		if (user != null) {
			try {
				// 批处理操作
				tm.begin();
				db.addBatch(sql1);
				if (db.getTableMetaData("td_cms_siteuser") != null) {
					db.addBatch(sql2);
				}
				db.addBatch(sql3);
				db.addBatch(sql4);
				db.addBatch(sql5);
				db.addBatch(sql6);
				db.addBatch(sql7);
				db.addBatch(sql8);
				db.addBatch(sql9);
				db.addBatch(sql);
				db.executeBatch();

				// 同步所有应用的数据 add by minghua.guo 2010-6-22
				OrgUserManager.appUserDelSynchronizer(user.getUserId()
						.toString());

				tm.commit();
				r = true;
				Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
				super.change(event);
			} catch (SQLException e2) {
				e2.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			}
		}
		return r;
	}

	/**
	 * 批量删除用户时改为批出理，gao.tang 修改
	 */
	public boolean deleteBatchUser(String userIds[]) throws ManagerException {
	    	boolean flag=true;
		User[] users = new User[userIds.length];
		User user = null;
		DBUtil db = new DBUtil();
		StringBuffer sql=new StringBuffer();
		String userIdStr="";
		PreparedDBUtil pdb = new PreparedDBUtil();
	
		for (int i = 0; i < userIds.length; i++) {
			if (null == userIds[i] || userIds[i].trim().equals("")) {
				userIds[i] = "-1";
			}
			try {
				db
						.executeSelect("select user_name,user_realname from td_sm_user where user_id="
								+ userIds[i] + "");
				user = new User();
				if (null != db && db.size() > 0) {
					user.setUserName(db.getString(0, "user_name"));
					user.setUserRealname(db.getString(0, "user_realname"));
				}
				user.setUserId(Integer.valueOf(userIds[i]));
				users[i] = user;
				userIdStr+=userIds[i];
				if(i!=userIds.length-1){
				    userIdStr+=",";
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		try {
		    	flag=SecurityDatabase.getUserManager().deleteBatchUser(users);
		  	sql.append("delete ta_oa_userandsn t where t.userid in("+userIdStr+") ");
		  	pdb.preparedDelete(sql.toString());
		  	pdb.executePrepared();
		} catch (SPIException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (SQLException e) {
		    e.printStackTrace();
		}
		return flag;
	}

	public boolean deleteBatchUser(User[] users) throws ManagerException {
		boolean r = false;
		DBUtil dbUtil = null;
		TransactionManager tm = new TransactionManager();
		if (users != null) {
			try {
				tm.begin();
				// cb.setAutoCommit(false);
				dbUtil = new DBUtil();
				for (int i = 0; i < users.length; i++) {
					// User user = getUser("userId", userIds[i]);

					// 删除当前用户的所关联的 Userjoborg 对象
					// Parameter p = new Parameter();
					// p.setCommand(Parameter.COMMAND_DELETE);
					// p.setObject("from Userjoborg ujo where ujo.id.userId = '"
					// + userIds[i] + "'");
					// cb.execute(p);
					String userId = String.valueOf(users[i].getUserId());
					String sql7 = "delete from TD_SM_ORGUSER where user_id ="
							+ userId + "";
					dbUtil.addBatch(sql7);

					String sql1 = "delete from TD_SM_USERJOBORG where USER_ID = "
							+ userId + " ";
					dbUtil.addBatch(sql1);
					// 删除当前用户的所关联的 Userrole 对象
					// p.setObject("from Userrole ur where ur.id.userId = '"
					// + userIds[i] + "'");
					// cb.execute(p);

					String sql2 = "delete from TD_SM_USERROLE where USER_ID = "
							+ userId + " ";
					if (!"1".equals(userId)) {
						dbUtil.addBatch(sql2);
					}
					// 删除当前用户的所关联的 Userresop 对象
					// p.setObject("from Userresop uro where uro.id.userId = '"
					// + userIds[i] + "'");
					// cb.execute(p);
					String sql3 = "delete from TD_SM_ROLERESOP a where a.ROLE_ID = '"
							+ userId + "' and a.types='user' ";
					dbUtil.addBatch(sql3);

					// 删除当前用户的所关联的 Usergroup 对象
					// p.setObject("from Usergroup ug where ug.id.userId = '"
					// + userIds[i] + "'");
					// cb.execute(p);
					String sql4 = "delete from TD_SM_USERGROUP where USER_ID = "
							+ userId + " ";
					dbUtil.addBatch(sql4);

					// 删除当前用户的所关联的 Tempaccredit 对象
					// p.setObject("from Tempaccredit ta where ta.id.userId = '"
					// + userIds[i] + "'");
					// cb.execute(p);
					// 删除用户对应的机构管理员td_sm_orgmanager关系表
					String sql5 = "delete from TD_SM_ORGMANAGER where USER_ID = "
							+ userId + " ";
					dbUtil.addBatch(sql5);
					// 删除指定的用户实例
					// p.setObject("from User u where u.userId = '" + userIds[i]
					// + "'");
					// cb.execute(p);
					String sql6 = "delete from TD_SM_USER where USER_ID = "
							+ userId + " ";
					dbUtil.addBatch(sql6);
				}
				dbUtil.executeBatch();

				tm.commit();
				// 触发删除缓冲中用户的事件
				Event event = new EventImpl("", ACLEventType.USER_INFO_DELETE);
				super.change(event);
				r = true;

			} catch (SQLException e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			}

			// 同步所有应用的数据 add by minghua.guo 2010-6-22
			String appid = AppIdThreadLocal.get();
			if ("module".equals(appid)) {
				OrgUserManager.appUserDelSynchronizer(users);
			}
		}
		return r;
	}

	/**
	 * 批量删除用户资源时改为批出理，gao.tang 修改
	 */
	public boolean deleteBatchUserRes(String userIds[]) throws ManagerException {
		boolean r = false;
		DBUtil dbUtil = null;
		TransactionManager tm = new TransactionManager();
		if (userIds != null) {
			try {
				tm.begin();
				int count = 0;
				dbUtil = new DBUtil();
				for (int i = 0; i < userIds.length; i++) {

					// 删除当前用户的所关联的 Userjoborg 对象
					String sql7 = "delete from TD_SM_ORGUSER where user_id ='"
							+ userIds[i] + "'";
					dbUtil.addBatch(sql7);

					String sql1 = "delete from TD_SM_USERJOBORG where USER_ID = '"
							+ userIds[i] + "' ";
					dbUtil.addBatch(sql1);

					// 删除当前用户的所关联的 Userrole 对象
					String sql2 = "delete from TD_SM_USERROLE where USER_ID = '"
							+ userIds[i] + "' ";
					// 如果删除的用户是admin不删除admin与角色的关系。删除机构时会出现下面现象
					if (!userIds[i].equals("1")) {
						dbUtil.addBatch(sql2);
					}
					// 删除当前用户的所关联的 Userresop 对象
					String sql3 = "delete from TD_SM_ROLERESOP a where a.ROLE_ID = '"
							+ userIds[i] + "' and a.types='user' ";
					dbUtil.addBatch(sql3);

					String sql4 = "delete from TD_SM_USERGROUP where USER_ID = '"
							+ userIds[i] + "' ";
					dbUtil.addBatch(sql4);

					// 删除用户对应的机构管理员td_sm_orgmanager关系表
					String sql5 = "delete from TD_SM_ORGMANAGER where USER_ID = '"
							+ userIds[i] + "' ";
					dbUtil.addBatch(sql5);
					count++;
					if (count > 900) {
						dbUtil.executeBatch();
						count = 0;
					}

				}
				dbUtil.executeBatch();
				tm.commit();
				// 触发删除缓冲中用户的事件
				Event event = new EventImpl(userIds,
						ACLEventType.USER_INFO_DELETE);
				super.change(event);
				r = true;

			} catch (SQLException e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			}
		}

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteUserattr(Userattr userattr) throws ManagerException {
		boolean r = false;

		// if (userattr != null) {
		// try {
		// // 先删除当前用户的所有 Userjoborg 对象
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(userattr);
		// cb.execute(p);
		//
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	public boolean deleteUserjoborg(Userjoborg userjoborg)
			throws ManagerException {
		boolean r = false;

		if (userjoborg != null) {
			try {
				DBUtil dbUtil = new DBUtil();
				// Parameter p = new Parameter();
				// p.setCommand(Parameter.COMMAND_DELETE);
				// p.setObject(userjoborg);
				// cb.execute(p);
				StringBuffer sql = new StringBuffer();
				sql.append("delete from TD_SM_USERJOBORG where USER_ID='")
						.append(userjoborg.getUser().getUserId()).append(
								"' and ").append("JOB_ID='").append(
								userjoborg.getJob().getJobId())
						.append("' and ").append("ORG_ID='").append(
								userjoborg.getOrg().getOrgId()).append("' ");
				dbUtil.executeDelete(sql.toString());
				Event event = new EventImpl(String.valueOf(userjoborg.getUser()
						.getUserId()), ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteUserjoborg(User user) throws ManagerException {
		boolean r = false;

		// if (user != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Userjoborg ujo where ujo.id.userId = '"
		// + user.getUserId() + "'");
		// cb.execute(p);
		// Event event = new EventImpl(String.valueOf(user.getUserId()),
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (user != null) {
			String delUserJobOrgsql = "delete from td_sm_userjoborg where user_id='"
					+ user.getUserId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(delUserJobOrgsql);
				Event event = new EventImpl(String.valueOf(user.getUserId()),
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	public boolean deleteUserjoborg(Job job, Organization org)
			throws ManagerException {
		boolean r = false;

		if (job != null && org != null) {
			DBUtil dbUtil = new DBUtil();
			String sql = "delete from TD_SM_USERJOBORG where JOB_ID ='"
					+ job.getJobId() + "' and" + " ORG_ID = '" + org.getOrgId()
					+ "'";
			try {
				dbUtil.executeDelete(sql);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// try {
			// Parameter p = new Parameter();
			// p.setCommand(Parameter.COMMAND_DELETE);
			// p.setObject("from Userjoborg ujo where ujo.id.orgId = '"
			// + org.getOrgId() + "' and ujo.id.jobId ='"
			// + job.getJobId() + "'");
			// cb.execute(p);
			// r = true;
			// } catch (ControlException e) {
			// throw new ManagerException(e.getMessage());
			// }
		}

		return r;

	}

	public boolean deleteUserjoborg(Job job, User user) throws ManagerException {
		boolean r = false;

		if (job != null && user != null) {
			try {
				DBUtil dbUtil = new DBUtil();
				// Parameter p = new Parameter();
				// p.setCommand(Parameter.COMMAND_DELETE);
				// p.setObject("from Userjoborg ujo where ujo.id.userId = '"
				// + user.getUserId() + "' and ujo.id.jobId ='"
				// + job.getJobId() + "'");
				// cb.execute(p);
				StringBuffer sql = new StringBuffer();
				sql.append("delete from TD_SM_USERJOBORG where USER_ID='")
						.append(user.getUserId()).append("' and ").append(
								"JOB_ID='").append(job.getJobId()).append("' ");
				dbUtil.executeDelete(sql.toString());
				r = true;
				Event event = new EventImpl(String.valueOf(user.getUserId()),
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;

	}

	public boolean deleteUserjoborg(Organization org, User user)
			throws ManagerException {
		boolean r = false;
		DBUtil dbUtil = null;
		TransactionManager tm = new TransactionManager();
		if (org != null) {
			try {
				tm.begin();
				dbUtil = new DBUtil();
				// Parameter p = new Parameter();
				// p.setCommand(Parameter.COMMAND_DELETE);
				// p.setObject("from Userjoborg ujo where ujo.id.orgId = '"
				// + org.getOrgId() + "' and ujo.id.userId="
				// + user.getUserId() + "");
				// cb.execute(p);
				// 删除TD_SM_USERJOBORG表中该用户在该机构下的所有岗位的记录
				StringBuffer sql = new StringBuffer();
				sql.append("delete from TD_SM_USERJOBORG where USER_ID='")
						.append(user.getUserId()).append("' and ORG_ID='")
						.append(org.getOrgId()).append("' ");

				// 删除TD_SM_ORGMANAGER表中该用户与该机构管理员的关系记录
				StringBuffer sql1 = new StringBuffer();
				// sql1.append("delete from td_sm_orgmanager where USER_ID='")
				// .append(user.getUserId()).append("' and ORG_ID='")
				// .append(org.getOrgId()).append("' ");
				sql1.append("delete from td_sm_orgmanager where USER_ID='")
						.append(user.getUserId()).append("' ");

				dbUtil.addBatch(sql.toString());
				dbUtil.addBatch(sql1.toString());
				dbUtil.executeBatch();
				tm.commit();
				Event event = new EventImpl(String.valueOf(user.getUserId()),
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
				r = true;

			} catch (SQLException e) {
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} catch (Exception e) {
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} finally {
				dbUtil.resetBatch();
			}
		}
		return r;
	}

	public boolean deleteUsergroup(Usergroup usergroup) throws ManagerException {
		boolean r = false;

		// if (usergroup != null) {
		// try {
		// List userList = getUserList(usergroup.getGroup());
		// String src[][] = new String[1][userList.size() + 1];
		//
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(usergroup);
		// cb.execute(p);
		// r = true;
		//
		// // 触发事件
		// src[0][0] = usergroup.getGroup().getGroupName();
		// for (int i = 0; i < userList.size(); i++) {
		// User user = (User) userList.get(i);
		// src[0][i + 1] = user.getUserName();
		// }
		//
		// Event event = new EventImpl("",
		// ACLEventType.USER_GROUP_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (usergroup != null) {
			String deleteUsergroupSql = "delete from td_sm_usergroup where user_id='"
					+ usergroup.getUser().getUserId()
					+ "' and group_id='"
					+ usergroup.getGroup().getGroupId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(deleteUsergroupSql);
				Event event = new EventImpl("",
						ACLEventType.USER_GROUP_INFO_CHANGE);
				super.change(event);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 删除用户,用户组关系
	 * 
	 * @param userid
	 * @param groupid
	 * @return
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean deleteUsergroup(Integer userid, String[] groupids)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		try {
			for (int i = 0; (groupids != null) && (i < groupids.length); i++) {
				String groupid = groupids[i];
				String sql = "delete from td_sm_usergroup where GROUP_ID="
						+ groupid + " and USER_ID=" + String.valueOf(userid);
				db.addBatch(sql);
			}
			db.executeBatch();
			r = true;
			Event event = new EventImpl(String.valueOf(userid),
					ACLEventType.USER_GROUP_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			db.resetBatch();
		}
		return r;
	}

	/**
	 * 删除用户,用户组关系
	 * 
	 * @param userid
	 *            用户ID
	 * @param groupids
	 *            用户组ID
	 * @param orgId
	 *            机构ID
	 * @return true:成功 false:失败
	 * @throws ManagerException
	 * @author 彭盛 2011-3-15
	 */
	public boolean deleteUsergroup(Integer userid, String[] groupids,
			String orgId) throws ManagerException {
		boolean r = false;
		if (null != groupids && groupids.length > 0 && null != orgId
				&& !orgId.trim().equals("")) {
			PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
			TransactionManager tm = new TransactionManager();
			StringBuffer sql = new StringBuffer();
			sql
					.append("delete from td_sm_usergroup where group_id=? and user_id=? and org_id=?");
			try {
				tm.begin();
				for (int i = 0; (groupids != null) && (i < groupids.length); i++) {
					preparedDBUtil.preparedInsert(sql.toString());
					preparedDBUtil.setString(1, groupids[i]);
					preparedDBUtil.setString(2, userid + "");
					preparedDBUtil.setString(3, orgId);
					preparedDBUtil.addPreparedBatch();
				}
				preparedDBUtil.executePreparedBatch();
				tm.commit();
				r = true;
				Event event = new EventImpl(String.valueOf(userid),
						ACLEventType.USER_GROUP_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} finally {
				preparedDBUtil.resetPrepare();
			}
		}
		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteUsergroup(User user) throws ManagerException {
		boolean r = false;

		// if (user != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Usergroup ug where ug.id.userId = '"
		// + user.getUserId() + "'");
		// cb.execute(p);
		// Event event = new EventImpl(String.valueOf(user.getUserId()),
		// ACLEventType.USER_GROUP_INFO_CHANGE);
		// super.change(event);
		// r = true;
		//
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (user != null) {
			String deleteUsergroupSql = "delete from td_sm_usergroup where user_id='"
					+ user.getUserId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(deleteUsergroupSql);
				Event event = new EventImpl(String.valueOf(user.getUserId()),
						ACLEventType.USER_GROUP_INFO_CHANGE);
				super.change(event);
				r = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteUsergroup(Group group) throws ManagerException {
		boolean r = false;

		// if (group != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Usergroup ug where ug.id.groupId = '"
		// + group.getGroupId() + "'");
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_GROUP_INFO_CHANGE);
		// super.change(event);
		//
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (group != null) {
			String deleteUsergroupSql = "delete from td_sm_usergroup where group_id='"
					+ group.getGroupId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(deleteUsergroupSql);
				r = true;
				Event event = new EventImpl("",
						ACLEventType.USER_GROUP_INFO_CHANGE);
				super.change(event);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteUserrole(Userrole userrole) throws ManagerException {
		boolean r = false;

		// if (userrole != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(userrole);
		// cb.execute(p);
		//
		// r = true;
		//
		// // 触发事件
		// String src[] = new String[] { userrole.getUser().getUserName(),
		// userrole.getRole().getRoleName() };
		// Event event = new EventImpl(src,
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteUserresop(Userresop userresop) throws ManagerException {
		boolean r = false;

		// if (userresop != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(userresop);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new
		// EventImpl(String.valueOf(userresop.getUser().getUserId()),
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteAccredit(Accredit accredit) throws ManagerException {
		boolean r = false;

		// if (accredit != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(accredit);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteTempaccredit(Tempaccredit tempaccredit)
			throws ManagerException {
		boolean r = false;

		// if (tempaccredit != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(tempaccredit);
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 修改为sql
	 */
	public boolean deleteUserrole(User user) throws ManagerException {
		boolean r = false;

		// if (user != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Userrole ur where ur.id.userId = '"
		// + user.getUserId() + "'");
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl(String.valueOf(user.getUserId()),
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (user != null) {
			String deleteUserroleSql = "delete from td_sm_userrole where user_id='"
					+ user.getUserId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(deleteUserroleSql);
				r = true;
				Event event = new EventImpl(String.valueOf(user.getUserId()),
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean deleteUserrole(Organization org, Role role)
			throws ManagerException {
		boolean r = false;

		// if (role != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject("from Userrole ur where ur.id.roleId = '"
		// + role.getRoleId()
		// + "' and ur.id.userId in (select ujo.id.userId from "
		// + "Userjoborg ujo where ujo.id.orgId = '"
		// + org.getOrgId() + "')");
		// cb.execute(p);
		// r = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	private List getUsers(DBUtil dbUtil) throws ManagerException {
		List list = new ArrayList();
		for (int i = 0; i < dbUtil.size(); i++) {

			try {
				User user = new User();
				user.setUserId(new Integer(dbUtil.getInt(i, "user_id")));
				user.setUserSn(new Integer(dbUtil.getInt(i, "user_sn")));
				user.setUserName(dbUtil.getString(i, "user_name"));
				user.setUserPassword(dbUtil.getString(i, "USER_PASSWORD"));
				user.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
				user.setUserPinyin(dbUtil.getString(i, "USER_PINYIN"));
				user.setUserSex(dbUtil.getString(i, "USER_SEX"));
				user.setUserHometel(dbUtil.getString(i, "USER_HOMETEL"));
				user.setUserWorktel(dbUtil.getString(i, "USER_WORKTEL"));
				user.setUserWorknumber(dbUtil.getString(i, "USER_WORKNUMBER"));
				user.setUserMobiletel1(dbUtil.getString(i, "USER_MOBILETEL1"));
				user.setUserMobiletel2(dbUtil.getString(i, "USER_MOBILETEL2"));
				user.setUserFax(dbUtil.getString(i, "USER_FAX"));
				user.setUserOicq(dbUtil.getString(i, "USER_OICQ"));
				user.setCretSn(dbUtil.getString(i, "CERT_SN"));

				// 生日日期
				if (String.valueOf(dbUtil.getTimestamp(i, "USER_BIRTHDAY")) != "null") {
					user.setUserBirthday(new java.sql.Date(dbUtil.getTimestamp(
							i, "USER_BIRTHDAY").getTime()));
				} else {
					user.setUserBirthday((java.sql.Date) dbUtil.getDate(i,
							"USER_BIRTHDAY"));
				}

				user.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
				user.setUserAddress(dbUtil.getString(i, "USER_ADDRESS"));
				user.setUserPostalcode(dbUtil.getString(i, "USER_POSTALCODE"));
				user.setUserIdcard(dbUtil.getString(i, "USER_IDCARD"));
				user.setUserIsvalid(new Integer(dbUtil
						.getInt(i, "USER_ISVALID")));

				// 注册日期
				if (String.valueOf(dbUtil.getTimestamp(i, "USER_REGDATE")) != "null") {
					user.setUserRegdate(new java.sql.Date(dbUtil.getTimestamp(
							i, "USER_REGDATE").getTime()));
				} else {
					user.setUserRegdate((java.sql.Date) dbUtil.getDate(i,
							"USER_REGDATE"));
				}

				user.setUserLogincount(new Integer(dbUtil.getInt(i,
						"USER_LOGINCOUNT")));
				user.setUserType(dbUtil.getString(i, "USER_TYPE"));
				user.setRemark1(dbUtil.getString(i, "REMARK1"));
				user.setRemark2(dbUtil.getString(i, "REMARK2"));
				user.setRemark3(dbUtil.getString(i, "REMARK3"));
				user.setRemark4(dbUtil.getString(i, "REMARK4"));
				user.setRemark5(dbUtil.getString(i, "REMARK5"));

				// 过期日期
				if (String.valueOf(dbUtil.getTimestamp(i, "PAST_TIME")) != "null") {
					user.setPastTime(new java.sql.Date(dbUtil.getTimestamp(i,
							"PAST_TIME").getTime()));
				} else {
					user.setPastTime((java.sql.Date) dbUtil.getDate(i,
							"PAST_TIME"));
				}

				user.setDredgeTime(dbUtil.getString(i, "DREDGE_TIME"));

				// 用户最后登陆时间
				if (String.valueOf(dbUtil.getTimestamp(i, "LASTLOGIN_DATE")) != "null") {
					user.setLastlogindate(new java.sql.Date(dbUtil
							.getTimestamp(i, "LASTLOGIN_DATE").getTime()));
				} else {
					user.setLastlogindate((java.sql.Date) dbUtil.getDate(i,
							"LASTLOGIN_DATE"));
				}

				user.setWorklength(dbUtil.getString(i, "WORKLENGTH"));
				user.setPolitics(dbUtil.getString(i, "POLITICS"));
				user.setIstaxmanager(dbUtil.getInt(i, "ISTAXMANAGER"));
				list.add(user);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	private User getUser(DBUtil dbUtil) throws ManagerException {
		User user = new User();
		try {
			user.setUserId(new Integer(dbUtil.getInt(0, "user_id")));
			user.setUserSn(new Integer(dbUtil.getInt(0, "user_sn")));
			user.setUserName(dbUtil.getString(0, "user_name"));
			user.setUserPassword(dbUtil.getString(0, "USER_PASSWORD"));
			user.setUserRealname(dbUtil.getString(0, "USER_REALNAME"));
			user.setUserPinyin(dbUtil.getString(0, "USER_PINYIN"));
			user.setUserSex(dbUtil.getString(0, "USER_SEX"));
			user.setUserHometel(dbUtil.getString(0, "USER_HOMETEL"));
			user.setUserWorktel(dbUtil.getString(0, "USER_WORKTEL"));
			user.setUserWorknumber(dbUtil.getString(0, "USER_WORKNUMBER"));
			user.setUserMobiletel1(dbUtil.getString(0, "USER_MOBILETEL1"));
			user.setUserMobiletel2(dbUtil.getString(0, "USER_MOBILETEL2"));
			user.setUserFax(dbUtil.getString(0, "USER_FAX"));
			user.setUserOicq(dbUtil.getString(0, "USER_OICQ"));
			user.setCretSn(dbUtil.getString(0, "CERT_SN"));

			// 生日日期
			if (String.valueOf(dbUtil.getTimestamp(0, "USER_BIRTHDAY")) != "null") {
				user.setUserBirthday(new java.sql.Date(dbUtil.getTimestamp(0,
						"USER_BIRTHDAY").getTime()));
			} else {
				user.setUserBirthday((java.sql.Date) dbUtil.getDate(0,
						"USER_BIRTHDAY"));
			}

			user.setUserEmail(dbUtil.getString(0, "USER_EMAIL"));
			user.setUserAddress(dbUtil.getString(0, "USER_ADDRESS"));
			user.setUserPostalcode(dbUtil.getString(0, "USER_POSTALCODE"));
			user.setUserIdcard(dbUtil.getString(0, "USER_IDCARD"));
			user.setUserIsvalid(new Integer(dbUtil.getInt(0, "USER_ISVALID")));

			// 注册日期
			if (String.valueOf(dbUtil.getTimestamp(0, "USER_REGDATE")) != "null") {
				user.setUserRegdate(new java.sql.Date(dbUtil.getTimestamp(0,
						"USER_REGDATE").getTime()));
			} else {
				user.setUserRegdate((java.sql.Date) dbUtil.getDate(0,
						"USER_REGDATE"));
			}

			user.setUserLogincount(new Integer(dbUtil.getInt(0,
					"USER_LOGINCOUNT")));
			user.setUserType(dbUtil.getString(0, "USER_TYPE"));
			user.setRemark1(dbUtil.getString(0, "REMARK1"));
			user.setRemark2(dbUtil.getString(0, "REMARK2"));
			user.setRemark3(dbUtil.getString(0, "REMARK3"));
			user.setRemark4(dbUtil.getString(0, "REMARK4"));
			user.setRemark5(dbUtil.getString(0, "REMARK5"));

			// 过期日期
			if (String.valueOf(dbUtil.getTimestamp(0, "PAST_TIME")) != "null") {
				user.setPastTime(new java.sql.Date(dbUtil.getTimestamp(0,
						"PAST_TIME").getTime()));
			} else {
				user
						.setPastTime((java.sql.Date) dbUtil.getDate(0,
								"PAST_TIME"));
			}

			user.setDredgeTime(dbUtil.getString(0, "DREDGE_TIME"));

			// 用户最后登陆时间
			if (String.valueOf(dbUtil.getTimestamp(0, "LASTLOGIN_DATE")) != "null") {
				user.setLastlogindate(new java.sql.Date(dbUtil.getTimestamp(0,
						"LASTLOGIN_DATE").getTime()));
			} else {
				user.setLastlogindate((java.sql.Date) dbUtil.getDate(0,
						"LASTLOGIN_DATE"));
			}

			user.setWorklength(dbUtil.getString(0, "WORKLENGTH"));
			user.setPolitics(dbUtil.getString(0, "POLITICS"));
			user.setIstaxmanager(dbUtil.getInt(0, "ISTAXMANAGER"));
			
			
			user.setMobileSn(dbUtil.getString(0, "mobile_sn"));
			user.setMobile2(dbUtil.getString(0,"mobile2"));
			user.setWorkphone(dbUtil.getString(0,"workphone"));
		} catch (SQLException e) {
			throw new ManagerException(e.getMessage());
		} catch (Exception e) {
			throw new ManagerException(e.getMessage());
		}
		return user;
	}

	public User getUser(String propName, String value) throws ManagerException {
		User user = null;
		try {

			DBUtil db = new DBUtil();

			if (propName == null || value == null
					|| propName.trim().length() == 0
					|| value.trim().length() == 0) {
				return user;
			} else {
				if (propName.equalsIgnoreCase("userId"))
					propName = "user_id";
				if (propName.equalsIgnoreCase("username"))
					propName = "user_name";
			}

			// String sql = "select * from td_sm_user where " + propName + "='"
			// + value + "'";
			StringBuffer sql = new StringBuffer();
			sql
					.append(
							"select USER_ID, USER_SN, USER_NAME, USER_PASSWORD, USER_REALNAME, USER_PINYIN, ")
					.append(
							"USER_SEX, USER_HOMETEL, USER_WORKTEL, USER_WORKNUMBER, USER_MOBILETEL1, ")
					.append(
							"USER_MOBILETEL2, USER_FAX, USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS, ")
					.append(
							"USER_POSTALCODE, USER_IDCARD, USER_ISVALID, USER_REGDATE, USER_LOGINCOUNT, ")
					.append(
							"USER_TYPE, REMARK1, REMARK2, REMARK3, REMARK4, REMARK5, PAST_TIME, DREDGE_TIME, ")
					.append(
							"LASTLOGIN_DATE, WORKLENGTH, POLITICS, ISTAXMANAGER from TD_SM_USER ")
					.append("where ").append(propName).append(" = '").append(
							value).append("' ");
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				user = this.getUser(db);
			}
			// Parameter p = new Parameter();
			// p.setCommand(Parameter.COMMAND_GET);
			// p.setObject("from User user where user." + propName + "='" +
			// value
			// + "'");
			// List list = (List) cb.execute(p);
			//
			// if (list != null && !list.isEmpty())
			// user = (User) list.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	public User getUserById(String userId) throws ManagerException {
		User user = null;
		try {
			DBUtil db = new DBUtil();
			StringBuffer sql = new StringBuffer();
			PreparedDBUtil pdb=new PreparedDBUtil();
			
			sql.append("select u.USER_ID,");
			sql.append("       u.USER_SN,");
			sql.append("       u.USER_NAME,");
			sql.append("       u.USER_PASSWORD,");
			sql.append("       u.USER_REALNAME,");
			sql.append("       u.USER_PINYIN,");
			sql.append("       u.USER_SEX,");
			sql.append("       u.USER_HOMETEL,");
			sql.append("       u.USER_WORKTEL,");
			sql.append("       u.USER_WORKNUMBER,");
			sql.append("       u.USER_MOBILETEL1,");
			sql.append("       u.USER_MOBILETEL2,");
			sql.append("       u.USER_FAX,");
			sql.append("       u.USER_OICQ,");
			sql.append("       u.USER_BIRTHDAY,");
			sql.append("       u.USER_EMAIL,");
			sql.append("       u.USER_ADDRESS,");
			sql.append("       u.USER_POSTALCODE,");
			sql.append("       u.USER_IDCARD,");
			sql.append("       u.USER_ISVALID,");
			sql.append("       u.USER_REGDATE,");
			sql.append("       u.USER_LOGINCOUNT,");
			sql.append("       u.USER_TYPE,");
			sql.append("       u.REMARK1,");
			sql.append("       u.REMARK2,");
			sql.append("       u.REMARK3,");
			sql.append("       u.REMARK4,");
			sql.append("       u.REMARK5,");
			sql.append("       u.PAST_TIME,");
			sql.append("       u.DREDGE_TIME,");
			sql.append("       u.LASTLOGIN_DATE,");
			sql.append("       u.WORKLENGTH,");
			sql.append("       u.POLITICS,");
			sql.append("       u.ISTAXMANAGER,");
			sql.append("       u.CERT_SN,");
			sql.append("       s.MOBILE_SN");
			sql.append("  from TD_SM_USER u");
			sql.append("  left join ta_oa_userandsn s on u.user_id = s.userid");
			sql.append(" where USER_ID = ").append(userId).append(" ");
			
			

			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				user = this.getUser(db);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ManagerException e) {
			e.printStackTrace();
		}
		return user;
	}

	public boolean UpdateUserById(User user) {
		boolean flag = true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update TD_SM_USER set USER_SEX=?,USER_MOBILETEL1=?,USER_EMAIL=?,user_worktel=?,remark2=?   where  user_id =?");
		try {
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, user.getUser_fax());
			pdb.setString(2, user.getUser_mobiletel1());
			pdb.setString(3, user.getUser_email());
			pdb.setString(4, user.getUser_worktel());
			pdb.setString(5, user.getRemark2());
			pdb.setString(6, user.getUser_id());
			pdb.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}
	public User getUserByName(String userName) throws ManagerException {
		User user = null;
		try {
			DBUtil db = new DBUtil();
			StringBuffer sql = new StringBuffer();
			sql
					.append(
							"select USER_ID, USER_SN, USER_NAME, USER_PASSWORD, USER_REALNAME, USER_PINYIN, ")
					.append(
							"USER_SEX, USER_HOMETEL, USER_WORKTEL, USER_WORKNUMBER, USER_MOBILETEL1, ")
					.append(
							"USER_MOBILETEL2, USER_FAX, USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS, ")
					.append(
							"USER_POSTALCODE, USER_IDCARD, USER_ISVALID, USER_REGDATE, USER_LOGINCOUNT, ")
					.append(
							"USER_TYPE, REMARK1, REMARK2, REMARK3, REMARK4, REMARK5, PAST_TIME, DREDGE_TIME, ")
					.append(
							"LASTLOGIN_DATE, WORKLENGTH, POLITICS, ISTAXMANAGER from TD_SM_USER ")
					.append("where USER_NAME = '").append(userName)
					.append("' ");

			db.executeSelect(sql.toString());

			if (db.size() > 0) {
				user = this.getUser(db);
			}
		} catch (SQLException e) {
			throw new ManagerException("通过用户帐号[" + userName + "]获取用户信息失败："
					+ e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException("通过用户帐号[" + userName + "]获取用户信息失败"
					+ e.getMessage());
		}
		return user;
	}

	/**
	 * 没有被使用的方法
	 */
	public User getUser(String hsql) throws ManagerException {
		User user = null;
		// // DBUtil db = new DBUtil();
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject(hsql);
		// List list = (List) cb.execute(p);
		// // List list = db.execute;
		// if (list != null && !list.isEmpty())
		// user = (User) list.get(0);
		// } catch (ControlException e) {
		// e.printStackTrace();
		// throw new ManagerException(e.getMessage());
		// }

		return user;
	}

	public List getUserList(String propName, String value, boolean isLike)
			throws ManagerException {

		List list = null;
		DBUtil dbUtil = new DBUtil();
		try {
			// Parameter p = new Parameter();
			// p.setCommand(Parameter.COMMAND_GET);
			// if (!isLike)
			// p.setObject("from User u where u." + propName + " = '" + value
			// + "'");
			// else
			// p.setObject("from User u where u." + propName + " like '"
			// + value + "'");
			//
			// list = (List) cb.execute(p);
			StringBuffer sql = new StringBuffer();
			if (!isLike) {
				sql
						.append(
								"select USER_ID, USER_SN, USER_NAME, USER_PASSWORD, USER_REALNAME, USER_PINYIN, ")
						.append(
								"USER_SEX, USER_HOMETEL, USER_WORKTEL, USER_WORKNUMBER, USER_MOBILETEL1, ")
						.append(
								"USER_MOBILETEL2, USER_FAX, USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS, ")
						.append(
								"USER_POSTALCODE, USER_IDCARD, USER_ISVALID, USER_REGDATE, USER_LOGINCOUNT, ")
						.append(
								"USER_TYPE, REMARK1, REMARK2, REMARK3, REMARK4, REMARK5, PAST_TIME, DREDGE_TIME, ")
						.append(
								"LASTLOGIN_DATE, WORKLENGTH, POLITICS, ISTAXMANAGER from TD_SM_USER ")
						.append("where ").append(propName).append(" = '")
						.append(value).append("' ");
				dbUtil.executeSelect(sql.toString());
				if (dbUtil.size() > 0) {
					list = this.getUsers(dbUtil);
				}
			} else {
				sql
						.append(
								"select USER_ID, USER_SN, USER_NAME, USER_PASSWORD, USER_REALNAME, USER_PINYIN, ")
						.append(
								"USER_SEX, USER_HOMETEL, USER_WORKTEL, USER_WORKNUMBER, USER_MOBILETEL1, ")
						.append(
								"USER_MOBILETEL2, USER_FAX, USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS, ")
						.append(
								"USER_POSTALCODE, USER_IDCARD, USER_ISVALID, USER_REGDATE, USER_LOGINCOUNT, ")
						.append(
								"USER_TYPE, REMARK1, REMARK2, REMARK3, REMARK4, REMARK5, PAST_TIME, DREDGE_TIME, ")
						.append(
								"LASTLOGIN_DATE, WORKLENGTH, POLITICS, ISTAXMANAGER from TD_SM_USER ")
						.append("where ").append(propName).append(" like '%")
						.append(value).append("%' ");
				dbUtil.executeSelect(sql.toString());
				if (dbUtil.size() > 0) {
					list = this.getUsers(dbUtil);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public List getUserList(Group group) throws ManagerException {
		List list = null;

		// if (group != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select ug.id.userId from Usergroup ug where ug.id.groupId = '"
		// + group.getGroupId()
		// + "') order by user.userRealname");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (group != null) {
			String getUserListSql = "select * from td_sm_user where user_id in("
					+ "select user_id from td_sm_usergroup where group_id='"
					+ group.getGroupId() + "') order by user_realname";
			DBUtil db = new DBUtil();
			try {
				db.executeSelect(getUserListSql);
				list = getUsers(db);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	/**
	 * 没有被使用的方法
	 */
	public List getUserList(Job job) throws ManagerException {
		List list = null;

		// if (job != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select ujo.id.userId from Userjoborg ujo where ujo.id.jobId = '"
		// + job.getJobId() + "')");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	/**
	 * 没有被使用的方法
	 */
	public List getUserList(Operation oper) throws ManagerException {
		List list = null;

		// if (oper != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select uro.id.userId from Userresop uro where uro.id.opId = '"
		// + oper.getOpId() + "')");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	/**
	 * 没有被使用的方法
	 */
	public List getUserList(Res res) throws ManagerException {
		List list = null;

		// if (res != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select uro.id.userId from Userresop uro where uro.id.resId = '"
		// + res.getResId() + "')");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	/**
	 * 通过机构id获取机构下隶属的用户列表 added by biaoping.yin on 2007.5.26
	 * 
	 * @param orgid
	 * @return
	 */
	public List getOrgUserList(String orgid) throws ManagerException {
		List allUser = new ArrayList();
		DBUtil db = new DBUtil();
		String sql = "select a.USER_ID,a.USER_SN,a.USER_NAME,a.USER_PASSWORD,a.USER_REALNAME,a.USER_WORKNUMBER,"
				+ "a.USER_PINYIN,a.USER_SEX,a.USER_HOMETEL,a.USER_WORKTEL,a.USER_MOBILETEL1,a.USER_MOBILETEL2,"
				+ "a.USER_FAX,a.USER_OICQ,a.USER_BIRTHDAY,a.USER_EMAIL,a.USER_ADDRESS,a.USER_POSTALCODE,a.USER_IDCARD,"
				+ "a.USER_ISVALID,a.USER_REGDATE,a.USER_LOGINCOUNT,a.USER_TYPE,a.REMARK1,a.REMARK2,a.REMARK3,a.REMARK4,"
				+ "a.REMARK5,max(b.same_job_user_sn) aa,max(b.job_sn) bb "
				+ " from td_sm_user a, td_sm_userjoborg b "
				+ "where a.user_id = b.user_id and b.org_id='"
				+ orgid
				+ "' "
				+ "group by a.USER_ID,a.USER_SN,a.USER_NAME,a.USER_PASSWORD,a.USER_REALNAME,a.USER_WORKNUMBER,"
				+ "a.USER_PINYIN,a.USER_SEX,a.USER_HOMETEL,a.USER_WORKTEL,a.USER_MOBILETEL1,a.USER_MOBILETEL2,"
				+ "a.USER_FAX,a.USER_OICQ,a.USER_BIRTHDAY,a.USER_EMAIL,a.USER_ADDRESS,a.USER_POSTALCODE,a.USER_IDCARD,"
				+ "a.USER_ISVALID,a.USER_REGDATE,a.USER_LOGINCOUNT,a.USER_TYPE,a.REMARK1,"
				+ "a.REMARK2,a.REMARK3,a.REMARK4,a.REMARK5 "
				+ " order by bb asc,aa asc";

		try {
			db.executeSelect(sql);
			for (int i = 0; i < db.size(); i++) {
				User user = new User();
				int userid = db.getInt(i, "user_id");
				user.setUserId(new Integer(userid));
				user.setUserName(db.getString(i, "USER_NAME"));
				user.setUserRealname(db.getString(i, "USER_REALNAME"));
				allUser.add(user);

			}
			return allUser;
		} catch (SQLException e) {

			e.printStackTrace();
			throw new ManagerException("获取机构[" + orgid + "]的用户失败:"
					+ e.getMessage());
		}

	}

	/**
	 * 通过机构id获取机构下隶属的用户列表,如果不是系统管理员将不出现admin
	 * 
	 * @param orgid
	 * @param userId
	 * @return
	 * @throws ManagerException
	 */
	public List getOrgUserList(String orgid, String userId)
			throws ManagerException {
		List allUser = new ArrayList();
		DBUtil db = new DBUtil();
		String sql = "select a.USER_ID,a.USER_SN,a.USER_NAME,a.USER_PASSWORD,a.USER_REALNAME,a.USER_WORKNUMBER,"
				+ "a.USER_PINYIN,a.USER_SEX,a.USER_HOMETEL,a.USER_WORKTEL,a.USER_MOBILETEL1,a.USER_MOBILETEL2,"
				+ "a.USER_FAX,a.USER_OICQ,a.USER_BIRTHDAY,a.USER_EMAIL,a.USER_ADDRESS,a.USER_POSTALCODE,a.USER_IDCARD,"
				+ "a.USER_ISVALID,a.USER_REGDATE,a.USER_LOGINCOUNT,a.USER_TYPE,a.REMARK1,a.REMARK2,a.REMARK3,a.REMARK4,"
				+ "a.REMARK5,max(b.same_job_user_sn) aa,max(b.job_sn) bb "
				+ " from td_sm_user a, td_sm_userjoborg b "
				+ "where a.user_id = b.user_id and b.org_id='"
				+ orgid
				+ "' "
				+ "group by a.USER_ID,a.USER_SN,a.USER_NAME,a.USER_PASSWORD,a.USER_REALNAME,a.USER_WORKNUMBER,"
				+ "a.USER_PINYIN,a.USER_SEX,a.USER_HOMETEL,a.USER_WORKTEL,a.USER_MOBILETEL1,a.USER_MOBILETEL2,"
				+ "a.USER_FAX,a.USER_OICQ,a.USER_BIRTHDAY,a.USER_EMAIL,a.USER_ADDRESS,a.USER_POSTALCODE,a.USER_IDCARD,"
				+ "a.USER_ISVALID,a.USER_REGDATE,a.USER_LOGINCOUNT,a.USER_TYPE,a.REMARK1,"
				+ "a.REMARK2,a.REMARK3,a.REMARK4,a.REMARK5 "
				+ " order by bb asc,aa asc";

		try {
			db.executeSelect(sql);
			for (int i = 0; i < db.size(); i++) {
				User user = new User();
				int userid = db.getInt(i, "user_id");
				// 如果当前用户不是超级管理员并且userid为超级管理员的ID则屏蔽掉超级管理员
				if (!"1".equals(userId) && userid == 1) {
					continue;
				}
				// 如果当前用户不是超级管理员并且userid的值与userId相等则过滤此用户
				// if(!"1".equals(userId) &&
				// String.valueOf(userid).equals(userId)){
				// continue;
				// }
				user.setUserId(new Integer(userid));
				user.setUserName(db.getString(i, "USER_NAME"));
				user.setUserRealname(db.getString(i, "USER_REALNAME"));
				allUser.add(user);

			}
			return allUser;
		} catch (SQLException e) {

			e.printStackTrace();
			throw new ManagerException("获取机构[" + orgid + "]的用户失败:"
					+ e.getMessage());
		}

	}

	public List getUserList(Organization org) throws ManagerException {
		List list = new ArrayList();

		// if (org != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// // 吴卫雄修改：实现排序
		// // p
		// // .setObject("from User user where user.userId in ("
		// // + "select ujo.id.userId from Userjoborg ujo where
		// // ujo.id.orgId = '"
		// // + org.getOrgId() + "')");
		// // list = (List) cb.execute(p);
		//
		// p.setObject("select ujo.id.userId,ujo.jobSn from Userjoborg ujo where
		// ujo.id.orgId = '"
		// + org.getOrgId() + "'");
		// List ujos = (List) cb.execute(p);
		// // 排序列表中的记录（目前仅实现按岗位排序）
		// Collections.sort(ujos, new UserComparator());
		//
		// list = new ArrayList();
		// // 将排序后的用户添加到列表中
		// for (int i = 0; i < ujos.size(); i++) {
		// Object[] uj = (Object[]) ujos.get(i);
		// User user = getUser("userId", String.valueOf(uj[0]));
		// if (user != null) {
		// if (!list.contains(user))
		// list.add(user);
		// }
		// }
		//
		// // 吴卫雄修改结束
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		DBUtil dbUtil = new DBUtil();
		StringBuffer sql = new StringBuffer()
				.append(
						"select ujo.user_id, ujo.job_id, ujo.job_sn, ujo.same_job_user_sn, u.* ")
				.append("from td_sm_userjoborg ujo, td_sm_user u ").append(
						"where ujo.org_id = '").append(org.getOrgId()).append(
						"' ").append(
						"and ujo.user_id = u.user_id and ujo.job_id='1' ")
				.append("order by ujo.same_job_user_sn");
		try {
			dbUtil.executeSelect(sql.toString());
			list = this.getUsers(dbUtil);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public List getUserList(Role role) throws ManagerException {
		List list = null;

		// if (role != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from User user where user.userId in ("
		// + "select ur.id.userId from Userrole ur where ur.id.roleId = '"
		// + role.getRoleId() + "')");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		String getUserListSql = "select * from td_sm_user where user_id in(select user_id "
				+ " from td_sm_userrole where role_id='"
				+ role.getRoleId()
				+ "')";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(getUserListSql);
			list = getUsers(db);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	/**
	 * 获取角色对应的用户列表
	 * 
	 * @param role
	 * @return
	 * @throws ManagerException
	 */
	public List getUsersListOfRole(String roleid) throws ManagerException {
		List list = new ArrayList();

		if (roleid != null && roleid.length() > 0) {
			// String userssql =
			// "select a.* from td_sm_user a inner join td_sm_userrole b on a.user_id = b.user_id and b.role_id='"
			// + roleid + "'";
			// 彭盛 2011-3-12
			String userssql = "select * from td_sm_user a,td_sm_userrole b where a.user_id=b.user_id and b.role_id='"
					+ roleid + "'";
			DBUtil dbUtil = new DBUtil();
			try {
				dbUtil.executeSelect(userssql);
				for (int i = 0; i < dbUtil.size(); i++) {
					int userid = dbUtil.getInt(i, "user_id");
					int isvalid = dbUtil.getInt(i, "USER_ISVALID");

					User user = new User();
					user.setUserId(new Integer(userid));
					user.setUserName(dbUtil.getString(i, "USER_NAME"));
					user.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
					user.setUserPassword(dbUtil.getString(i, " USER_PASSWORD"));
					user.setUserSex(dbUtil.getString(i, "USER_SEX"));
					user.setUserMobiletel1(dbUtil.getString(i,
							"USER_MOBILETEL1"));
					user.setUserMobiletel2(dbUtil.getString(i,
							"USER_MOBILETEL2"));
					user.setUserIsvalid(new Integer(isvalid));
					user.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
					user.setUserType(dbUtil.getString(i, "USER_TYPE"));

					list.add(user);
				}
			} catch (SQLException e) {
				throw new ManagerException("获取角色的用户列表失败[roleid=" + roleid
						+ "]：" + e.getMessage());
			}
		}

		return list;
	}

	/**
	 * 获取当前机构的当前角色对应的用户列表
	 * 
	 * @param role
	 * @return
	 * @throws ManagerException
	 */
	public List getUsersListOfRoleInOrg(String roleid, String orgId)
			throws ManagerException {
		List list = new ArrayList();
		if (roleid != null && roleid.length() > 0) {
			// 权限是否关联机构
			// 彭盛 2011-3-15
			boolean isrolerelatedorg = ConfigManager.getInstance()
					.getConfigBooleanValue("isrolerelatedorg", false);

			StringBuffer sql = new StringBuffer();
			if (isrolerelatedorg) {
				sql
						.append("select distinct a.* from td_sm_user a,td_sm_userrole b where a.user_id=b.user_id and b.org_id='");
				sql.append(orgId);
				sql.append("' and b.role_id='");
				sql.append(roleid);
				sql.append("'");
			} else {
				sql
						.append("select distinct a.* from td_sm_user a inner join td_sm_userrole b on a.user_id = b.user_id and b.role_id='");
				sql.append(roleid);
				sql
						.append("' inner join td_sm_userjoborg c on a.user_id = c.user_id and c.org_id='");
				sql.append(orgId);
				sql.append("'");
			}

			DBUtil dbUtil = new DBUtil();
			try {
				dbUtil.executeSelect(sql.toString());
				for (int i = 0; i < dbUtil.size(); i++) {
					int userid = dbUtil.getInt(i, "user_id");
					int isvalid = dbUtil.getInt(i, "USER_ISVALID");

					User user = new User();
					user.setUserId(new Integer(userid));
					user.setUserName(dbUtil.getString(i, "USER_NAME"));
					user.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
					user.setUserPassword(dbUtil.getString(i, " USER_PASSWORD"));
					user.setUserSex(dbUtil.getString(i, "USER_SEX"));
					user.setUserMobiletel1(dbUtil.getString(i,
							"USER_MOBILETEL1"));
					user.setUserMobiletel2(dbUtil.getString(i,
							"USER_MOBILETEL2"));
					user.setUserIsvalid(new Integer(isvalid));
					user.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
					user.setUserType(dbUtil.getString(i, "USER_TYPE"));

					list.add(user);
				}
			} catch (SQLException e) {
				throw new ManagerException("获取当前机构的当前角色的用户列表失败[roleid="
						+ roleid + "]：" + e.getMessage());
			}
		}
		return list;
	}

	public List getUserList(Organization org, Role role)
			throws ManagerException {
		List list = null;

		// if (role != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select ur.id.userId from Userrole ur where ur.id.roleId = '"
		// + role.getRoleId()
		// + "' and ur.id.userId in (select ujo.id.userId from Userjoborg ujo
		// where ujo.id.orgId = '"
		// + org.getOrgId() + "'))");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		if (null != org && null != role) {
			// 定义预编组件实例
			PreparedDBUtil preDBUtil = new PreparedDBUtil();
			// 创建SQL语句
			String sql = "select u.* from td_sm_user u where u.user_id in(select r.user_id from td_sm_userrole r where r.role_id = ? and r.user_id in(select o.user_id from td_sm_userjoborg o where o.org_id = ?))";
			try {
				// 预编sql语句
				preDBUtil.preparedSelect(sql);

				// 填充参数
				preDBUtil.setString(1, role.getRoleId());
				preDBUtil.setString(2, org.getOrgId());

				// 执行填充了参数的预编译语句
				preDBUtil.executePrepared();
				list = this.getUsers(preDBUtil);
			} catch (SQLException e) {
				logger.error(e);
				e.printStackTrace();
				return null;
			}
		}

		return list;
	}

	/**
	 * 根据orgid 和 jobid 获得在该org下但岗位不是jobid的用户列表 add by 景峰
	 */
	public List getUserList(Orgjob orgjob) throws ManagerException {
		List list = null;

		if (orgjob != null) {
			try {
				Parameter p = new Parameter();
				p.setCommand(Parameter.COMMAND_GET);
				p
						.setObject("select distinct ujo.user.userId, ujo.user.userName from UserJoborg ujo where ujo.org.orgId = '"
								+ orgjob.getId().getOrgId()
								+ "' and ujo.job.jobId != '"
								+ orgjob.getJob().getJobId() + "'))");
				list = (List) cb.execute(p);
			} catch (ControlException e) {
				throw new ManagerException(e.getMessage());
			}
		}

		return list;
	}

	/**
	 * 获取机构相应岗位下的用户信息
	 * 
	 * 没有被使用的方法
	 * 
	 * @param orgid
	 * @param jobid
	 * @return java.util.List<User>
	 * @throws ManagerException
	 */
	public List getUserList(String orgid, String jobid) throws ManagerException {
		List list = null;
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from User user where user.userId in ("
		// + "select distinct ujo.id.userId from Userjoborg ujo where
		// ujo.id.orgId = '"
		// + orgid + "' and ujo.id.jobId = '" + jobid + "')");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }

		return list;
	}

	/**
	 * 去掉hibernate后的方法---20080509
	 */
	public List getUserList(Organization org, Job job) throws ManagerException {
		List list = null;
		if (job != null) {
			String getUserListSql = "select * from td_sm_user where user_id in ("
					+ "select user_id from td_sm_userjoborg where job_id='"
					+ job.getJobId() + "' and org_id='" + org.getOrgId() + "')";
			DBUtil db = new DBUtil();
			try {
				db.executeSelect(getUserListSql);
				list = getUsers(db);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		// if (job != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// // 吴卫雄修改：实现同一机构下同一岗位的用户排序
		// // p
		// // .setObject("from User user where user.userId in ("
		// // + "select ujo.id.userId from Userjoborg ujo where
		// // ujo.id.jobId = '"
		// // + job.getJobId() + "' and ujo.id.orgId = '"
		// // + org.getOrgId() + "')");
		//
		// p.setObject("from User user where user.userId in (select
		// ujo.id.userId from Userjoborg ujo where "
		// + "ujo.id.jobId = '"
		// + job.getJobId()
		// + "' and ujo.id.orgId = '"
		// + org.getOrgId()
		// + "')");
		//
		// List users = (List) cb.execute(p);
		// list = new ArrayList();
		//
		// // for (int i = 0; i < users.size(); i++) {
		// // Object objs[] = (Object[]) users.get(i);
		// // list.add(objs[0]);
		// // }
		// return users;
		//
		// // 吴卫雄修改结束
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }
		// list = new ArrayList();
		return list;
	}

	// public List getUserList(String hsql) throws ManagerException {
	// List list = null;
	//
	// try {
	// Parameter p = new Parameter();
	// p.setCommand(Parameter.COMMAND_GET);
	// p.setObject(hsql);
	//		
	// list = (List) cb.execute(p);
	// } catch (ControlException e) {
	// throw new ManagerException(e.getMessage());
	// }
	//
	// return list;
	// }

	public boolean getUserSnList(String orgId, String jobId, int jobSn)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		// DBUtil db1 = new DBUtil();
		// int jsn;
		// int usn;
		// int userId;
		String sql = "update TD_SM_USERJOBORG set  JOB_SN =" + jobSn
				+ " where  JOB_ID ='" + jobId + "'" + "and ORG_ID ='" + orgId
				+ "'";

		try {
			db.executeUpdate(sql);
			// String str ="select JOB_SN,SAME_JOB_USER_SN,user_id from
			// TD_SM_USERJOBORG " +
			// "where JOB_ID ='" + jobId + "'" + "and ORG_ID ='" + orgId +"'";
			// db1.executeSelect(str);
			// if (db1 != null && db1.size() > 0) {
			// jsn = db1.getInt(0,"JOB_SN");
			//				
			//				
			// for(int i=0;i<db1.size();i++){
			// usn = db1.getInt(i,"SAME_JOB_USER_SN");
			// String SN = String.valueOf(jsn)+String.valueOf(usn);
			// userId = db1.getInt(i,"user_id");
			// String sqlstr = "update TB_Employee set FD_EMPLOYEE_POSITION = "+
			// SN +""
			// + "where FD_Employee_ID=" + String.valueOf(userId) + "";
			// db.executeUpdate(sqlstr);
			//	
			// }
			// }
			r = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return r;

	}

	/**
	 * 去掉hibernate后的方法
	 */
	public List getUserList() throws ManagerException {
		List list = null;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from User");
		//
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "select * from td_sm_user";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			list = getUsers(db);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	/**
	 * 无效的方法
	 */
	public List getAccreditList(String userId) throws ManagerException {
		List list = new ArrayList();

		// if (userId != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from Accredit accredit where accredit.user.userId = '"
		// + userId + "'");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	/**
	 * 无效的方法
	 */
	public List getTempaccredit(String userId) throws ManagerException {
		List list = new ArrayList();
		//
		// if (userId != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from Tempaccredit temp where temp.id.userId = '"
		// + userId + "'");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean isUserExist(User user) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from User user where user.userName='"
		// + user.getUserName() + "'");
		// List list = (List) cb.execute(p);
		//
		// if (list != null && list.size() > 0)
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "select count(1) from td_sm_user where user_name='"
				+ user.getUserName() + "'";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(EgpManager.getEgpDBName(),sql);
			if (db.getInt(0, 0) > 0) {
				r = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean isUserroleExist(Userrole userrole) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from Userrole ur where ur.id.userId='"
		// + userrole.getUser().getUserId() + "' and ur.id.roleId='"
		// + userrole.getRole().getRoleId() + "'");
		// List list = (List) cb.execute(p);
		//
		// if (list != null && list.size() > 0)
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 */
	public boolean isUserjoborgExist(Userjoborg userjoborg)
			throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("from Userjoborg ujo where ujo.id.userId='"
		// + userjoborg.getId().getUserId() + "' and ujo.id.jobId='"
		// + userjoborg.getId().getJobId() + "' and ujo.id.orgId='"
		// + userjoborg.getId().getOrgId());
		// List list = (List) cb.execute(p);
		//
		// if (list != null && list.size() > 0)
		// r = true;
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public User loadAssociatedSet(String userId, String associated)
			throws ManagerException {
		User returnUser = new User();

		// try {
		// DataControl cb = DataControl
		// .getInstance(DataControl.CONTROL_INSTANCE_DB);
		// Parameter par = new Parameter();
		// par.setCommand(Parameter.COMMAND_GET);
		// par.setObject("from User u left join fetch u." + associated
		// + " where u.userId = '" + userId + "'");
		//
		// List list = (List) cb.execute(par);
		// if (list != null && !list.isEmpty()) {
		// userRel = (User) list.get(0);
		// }
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "select * from td_sm_userjoborg where user_id='" + userId
				+ "'";
		DBUtil db = new DBUtil();

		Userjoborg userjoborg = null;
		Organization organization = null;
		User user = null;
		Job job = null;
		Set set = new HashSet();
		try {
			db.executeSelect(sql);
			for (int i = 0; i < db.size(); i++) {
				user = new User();
				job = new Job();
				organization = new Organization();
				userjoborg = new Userjoborg();
				organization = new OrgManagerImpl().getOrgById(db.getString(i,
						"org_id"));
				user = getUserById(db.getString(i, "user_id"));
				job = new JobManagerImpl()
						.getJobById(db.getString(i, "job_id"));
				userjoborg.setOrg(organization);
				userjoborg.setJob(job);
				userjoborg.setUser(user);
				set.add(userjoborg);
			}
			returnUser.setUserjoborgSet(set);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnUser;
	}

	/**
	 * 不使用的方法--
	 */
	public PageConfig getPageConfig() throws ManagerException {
		// try {
		// return cb.getPageConfig();
		// } catch (ControlException e) {
		// logger.error(e);
		// return null;
		// }
		return null;
	}

	// 王卓添加
	/**
	 * 没有被使用
	 */
	public boolean deleteUserrole(Role role, Group group)
			throws ManagerException {
		boolean r = false;

		// if (role != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p
		// .setObject("from Userrole ur where ur.id.roleId = '"
		// + role.getRoleId()
		// + "' and ur.id.userId in(select u.id.userId from Usergroup u where
		// u.id.groupId='"
		// + group.getGroupId() + "')");
		// cb.execute(p);
		//
		// r = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (ControlException e) {
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * modify by ge.tao 2007-09-07 新增了 函数 getUserorginfos 用户管理 列表
	 */
	public ListInfo getUserList(String sql, int offset, int maxItem)
			throws ManagerException {
		DBUtil dbUtil = new DBUtil();
		DBUtil db = new DBUtil();
		String orgjob = "";// 用户所属的org job
		try {
			dbUtil.executeSelect(sql, offset, maxItem);
			ListInfo listInfo = new ListInfo();
			List list = new ArrayList();
			UserJobs uj;
			for (int i = 0; i < dbUtil.size(); i++) {

				int userid = dbUtil.getInt(i, "user_id");
				// String str = "select getuserorgjobinfos('" + userid
				// + "') as org from dual";
				// db.executeSelect(str);
				// if (db.size() > 0) {
				// orgjob = db.getString(0, "org");
				// if (orgjob.endsWith("、")) {
				// orgjob = orgjob.substring(0, orgjob.length() - 1);
				// }
				// }

				uj = new UserJobs();
				uj.setUserId(new Integer(userid));
				uj.setUserName(dbUtil.getString(i, "USER_NAME"));
				uj.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
				uj.setUserMobiletel1(dbUtil.getString(i, "USER_MOBILETEL1"));
				uj.setUserType(dbUtil.getString(i, "USER_TYPE"));
				uj.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
				uj.setUserSex(dbUtil.getString(i, "USER_SEX"));
				uj.setUser_isvalid(dbUtil.getString(i, "USER_ISVALID"));
				uj.setUser_regdate(dbUtil.getString(i, "USER_REGDATE"));
				uj.setDredge_time(dbUtil.getString(i, "DREDGE_TIME"));
				uj
						.setIstaxmanager(new Integer(dbUtil.getInt(i,
								"ISTAXMANAGER")));
				try {
					orgjob = dbUtil.getString(i, "org_job");
				} catch (Exception e) {
					orgjob = "";
				}
				uj.setOrgName(orgjob);
				uj.setJobName(orgjob);
				uj.setOrg_Name(orgjob);
				// System.out.println("orgId = " + dbUtil.getString(i,
				// "org_id"));
				uj.setOrgId(dbUtil.getString(i, "org_id"));
				list.add(uj);

			}
			listInfo.setDatas(list);
			listInfo.setTotalSize(dbUtil.getTotalSize());
			return listInfo;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());

		}

	}

	/**
	 * modify by ge.tao 2007-09-07 新增了 函数 getUserorginfos 机构管理 列表
	 */
	public ListInfo getUserInfoList(String sql, int offset, int maxItem)
			throws ManagerException {
		DBUtil dbUtil = new DBUtil();
		DBUtil db = new DBUtil();
		String orgjob = "";// 用户所属的org job
		try {
			dbUtil.executeSelect(sql, offset, maxItem);
			ListInfo listInfo = new ListInfo();
			List list = new ArrayList();
			UserJobs uj;
			for (int i = 0; i < dbUtil.size(); i++) {

				int userid = dbUtil.getInt(i, "user_id");
				String str = "select getUserorgjobinfos('" + userid
						+ "') as org from dual";
				db.executeSelect(str);
				if (db.size() > 0) {
					orgjob = db.getString(0, "org");
					if (orgjob.endsWith("、")) {
						orgjob = orgjob.substring(0, orgjob.length() - 1);
					}
				}

				uj = new UserJobs();
				uj.setUserId(new Integer(userid));
				uj.setUserName(dbUtil.getString(i, "USER_NAME"));
				uj.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
				uj.setUserMobiletel1(dbUtil.getString(i, "USER_MOBILETEL1"));
				uj.setUserType(dbUtil.getString(i, "USER_TYPE"));
				uj.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
				uj.setUserSex(dbUtil.getString(i, "USER_SEX "));
				uj.setUser_isvalid(dbUtil.getString(i, "USER_ISVALID"));
				uj.setUser_regdate(dbUtil.getString(i, "USER_REGDATE"));
				uj.setDredge_time(dbUtil.getString(i, "DREDGE_TIME"));
				uj.setOrgName(orgjob);
				uj.setJobName(orgjob);
				uj.setOrg_Name(orgjob);
				// if (dbUtil.getDate(i, "JOB_STARTTIME") != null)
				// uj.setJobStartTime(dbUtil.getDate(i, "JOB_STARTTIME"));
				// if (dbUtil.getString(i, "JOB_FETTLE") != null)
				// uj.setFettle(dbUtil.getString(i, "JOB_FETTLE"));
				list.add(uj);
			}
			listInfo.setDatas(list);
			listInfo.setTotalSize(dbUtil.getTotalSize());
			return listInfo;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());

		}

	}

	public List getUserList(String sql) throws ManagerException {
		DBUtil dbUtil = new DBUtil();
		try {
			dbUtil.executeSelect(sql);
			// ListInfo listInfo = new ListInfo();
			List list = new ArrayList();
			for (int i = 0; i < dbUtil.size(); i++) {

				int userid = dbUtil.getInt(i, "user_id");
				int isvalid = dbUtil.getInt(i, "USER_ISVALID");

				User user = new User();
				user.setUserId(new Integer(userid));
				user.setUserName(dbUtil.getString(i, "USER_NAME"));
				user.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
				user.setUserPassword(dbUtil.getString(i, " USER_PASSWORD"));
				user.setUserSex(dbUtil.getString(i, "USER_SEX"));
				user.setUserMobiletel1(dbUtil.getString(i, "USER_MOBILETEL1"));
				user.setUserMobiletel2(dbUtil.getString(i, "USER_MOBILETEL2"));
				user.setUserIsvalid(new Integer(isvalid));
				user.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
				user.setUserType(dbUtil.getString(i, "USER_TYPE"));

				list.add(user);
			}

			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());

		}
	}

	public List getUserjoborgList(String userId, String orgId)
			throws ManagerException {
		DBUtil dbUtil = new DBUtil();
		try {
			String sql = "select * from td_sm_userjoborg where " + "USER_ID="
					+ userId + " and ORG_ID='" + orgId + "'";
			dbUtil.executeSelect(sql);

			List list = new ArrayList();
			for (int i = 0; i < dbUtil.size(); i++) {

				int userid = dbUtil.getInt(i, "user_id");

				Userjoborg ujo = new Userjoborg();
				ujo.getId().setUserId(new Integer(userid));

				list.add(ujo);
			}

			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());

		}
	}

	/**
	 * 得离散用户列表
	 */
	public List getDicList() throws ManagerException {
		List list = new ArrayList();
		DBUtil db = new DBUtil();
		String sql = "select t.* from td_sm_user t "
				+ "where t.user_id not in "
				+ "(select u.user_id from td_sm_userjoborg u) "
				+ "order by t.user_realname";
		try {
			db.executeSelect(sql);
			list = this.getUsers(db);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * modify by ge.tao 2007-08-31 调入岗位时,如果在该机构下已有岗位, 保持SAME_JOB_USER_SN与原来一致
	 * 如果在该机构下无岗位, SAME_JOB_USER_SN是该机构下最大的 添加 ,boolean needevent参数设置是否需要事件处理
	 */
	public boolean storeUserjoborg(String userId, String jobId, String orgId,
			boolean needevent) throws ManagerException {
		boolean b = false;
		int samejobsn = 1;
		int jobsn = 1;
		DBUtil db = new DBUtil();
		PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
		PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

		StringBuffer selete_sql = new StringBuffer();
		selete_sql
				.append("select count(1) as totalsize from TD_SM_USERJOBORG where USER_ID=? and JOB_ID=? and ORG_ID=?");
		StringBuffer insert_sql = new StringBuffer();
		insert_sql
				.append("insert into TD_SM_USERJOBORG(USER_ID,JOB_ID,ORG_ID,SAME_JOB_USER_SN, JOB_SN,JOB_STARTTIME,JOB_FETTLE) values (?,?,?,?,?,sysdate,1)");

		TransactionManager tm = new TransactionManager();
		try {
			// DBUtil db1 = new DBUtil();
			DBUtil db2 = new DBUtil();
			// String str1 ="select * from td_sm_userjoborg where org_id ='"+
			// orgId +"' " +
			// "and job_id ='1' and user_id ="+ userId +"";
			// String str2 ="delete from td_sm_userjoborg where org_id ='"+
			// orgId +"' " +
			// "and job_id ='1' and user_id ="+ userId +"";
			// db.executeSelect(str1);
			// if(db.size()>0){
			// db1.executeDelete(str2);
			// }

			/* 初始化数据 TD_SM_USERJOBORG 里有job_sn 和same_job_user_sn 为null的数据 */
			// DBUtil initdb = new DBUtil();
			// String initData = "update TD_SM_USERJOBORG set job_sn=1 ,
			// same_job_user_sn=1 where same_job_user_sn is null ";
			// initdb.executeUpdate(initData);
			/* 机构下改用户原来就有岗位 新调入的岗位SAME_JOB_USER_SN与原来的保持一致 */
			DBUtil addorgjob = new DBUtil();
			String minSN = "select min(SAME_JOB_USER_SN) as minsn from TD_SM_USERJOBORG where user_id ="
					+ userId
					+ " and"
					+ " org_id ='"
					+ orgId
					+ "' and same_job_user_sn is not null ";
			addorgjob.executeSelect(minSN);

			/* 用户新调入机构 SAME_JOB_USER_SN为改机构下最大的 */
			DBUtil neworgjob = new DBUtil();
			String maxSN = " select max(same_job_user_sn) as maxsn from td_sm_userjoborg where "
					+ " org_id ='"
					+ orgId
					+ "' and same_job_user_sn is not null ";
			neworgjob.executeSelect(maxSN);

			if (addorgjob != null && addorgjob.size() > 0) {
				samejobsn = addorgjob.getInt(0, "minsn");
			} else {
				if (neworgjob != null && neworgjob.size() > 0) {
					samejobsn = neworgjob.getInt(0, "maxsn") + 1;
				}
			}

			/* 获取JOB_SN */
			String jobSN = "select JOB_SN from TD_SM_ORGJOB where job_id ='"
					+ jobId + "' and" + " org_id ='" + orgId + "'";
			db2.executeSelect(jobSN);
			if (db2 != null && db2.size() > 0) {
				jobsn = db2.getInt(0, "JOB_SN");
			}

			tm.begin();

			selete_preparedDBUtil.preparedSelect(selete_sql.toString());
			selete_preparedDBUtil.setString(1, userId);
			selete_preparedDBUtil.setString(2, jobId);
			selete_preparedDBUtil.setString(3, orgId);
			selete_preparedDBUtil.executePrepared();

			if (null != selete_preparedDBUtil
					&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
				insert_preparedDBUtil.preparedInsert(insert_sql.toString());
				insert_preparedDBUtil.setString(1, userId);
				insert_preparedDBUtil.setString(2, jobId);
				insert_preparedDBUtil.setString(3, orgId);
				insert_preparedDBUtil.setInt(4, samejobsn);
				insert_preparedDBUtil.setInt(5, jobsn);
				insert_preparedDBUtil.addPreparedBatch();
				insert_preparedDBUtil.executePreparedBatch();
			}

			// /* 插入三元关系表 */
			// StringBuffer sql = new StringBuffer();
			// sql.append("insert all when totalsize <= 0 then into
			// TD_SM_USERJOBORG(USER_ID,JOB_ID,ORG_ID,SAME_JOB_USER_SN, ")
			// .append("JOB_SN,JOB_STARTTIME,JOB_FETTLE)values
			// (").append(userId).append(",'").append(jobId).append("','")
			// .append(orgId).append("','").append(samejobsn)
			// .append("','").append(jobsn).append("',").append(
			// DBUtil.getDBDate(new Date())).append(",1) select count(1) as
			// totalsize from TD_SM_USERJOBORG where ")
			// .append("USER_ID='").append(userId).append("' and
			// JOB_ID='").append(jobId).append("' and ")
			// .append("ORG_ID='").append(orgId).append("'");
			// logger.warn(sql.toString());
			// db.executeInsert(sql.toString());

			tm.commit();
			b = true;
			if (needevent) {
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			throw new ManagerException(e.getMessage());
		} finally {
			insert_preparedDBUtil.resetPrepare();
		}

		return b;

	}

	/**
	 * modify by ge.tao 2007-09-02
	 * sysmanager/user/userManager.do?method=getOrgList2 机构下的用户调入调出
	 * 
	 */
	public boolean storeUserjoborg(String userId, String jobId[], String orgId)
			throws ManagerException {
		boolean b = false;
		if (userId == null || userId.trim().length() <= 0)
			return b;
		int userSN = 1;
		int jobsn = 1;
		DBUtil batchdb = new DBUtil();
		try {

			for (int i = 0; (jobId != null) && (i < jobId.length); i++) {
				DBUtil db = new DBUtil();
				String existsql = "select *  from TD_SM_USERJOBORG where job_id ='"
						+ jobId[i]
						+ "' and"
						+ " org_id ='"
						+ orgId
						+ "' and user_id =" + userId + "";
				db.executeSelect(existsql);
				// 如果记录已有，不进行操作
				if (db.size() > 0) {
					continue;
				} else {
					DBUtil db1 = new DBUtil();
					DBUtil db2 = new DBUtil();

					String maxUser = "select max(SAME_JOB_USER_SN) as Sn from TD_SM_USERJOBORG where "
							+ " org_id ='" + orgId + "'";
					db1.executeSelect(maxUser);
					if (db1 != null && db1.size() > 0) {
						userSN = db1.getInt(0, "Sn") + 1;
					}

					String jobSN = "select JOB_SN from TD_SM_ORGJOB where job_id ='"
							+ jobId[i] + "' and" + " org_id ='" + orgId + "'";
					db2.executeSelect(jobSN);

					if (db2 != null && db2.size() > 0) {
						jobsn = db2.getInt(0, "JOB_SN");
					}

					String sql = "insert into TD_SM_USERJOBORG(USER_ID,JOB_ID,ORG_ID,SAME_JOB_USER_SN,JOB_SN,JOB_STARTTIME,JOB_FETTLE) "
							+ "values ("
							+ userId
							+ ","
							+ "'"
							+ jobId[i]
							+ "','"
							+ orgId
							+ "',"
							+ userSN
							+ ","
							+ jobsn
							+ ","
							+ DBUtil.getDBDate(new Date()) + ",1)";

					batchdb.addBatch(sql);
				}
			}
			batchdb.executeBatch();
			b = true;
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} catch (Exception e) {

			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			batchdb.resetBatch();
		}

		return b;

	}

	public boolean deleteUserjoborg(String userId, String jobId, String orgId)
			throws ManagerException {
		// boolean b = false;
		// DBUtil db = new DBUtil();
		// String sql = "delete from TD_SM_USERJOBORG where job_id ='" + jobId
		// + "' and" + " org_id ='" + orgId + "' and user_id =" + userId
		// + "";
		// try {
		// db.executeDelete(sql);
		// b = true;
		// Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (SQLException e) {
		// e.printStackTrace();
		// throw new ManagerException(e.getMessage());
		// }
		return deleteUserjoborg(userId, jobId, orgId, true);

	}

	public boolean deleteUserjoborg(String userId, String jobId, String orgId,
			boolean sendEvent) throws ManagerException {
		boolean b = false;
		DBUtil db = new DBUtil();
		String sql = "delete from TD_SM_USERJOBORG where job_id ='" + jobId
				+ "' and" + " org_id ='" + orgId + "' and user_id =" + userId
				+ "";
		try {
			db.executeDelete(sql);
			b = true;
			if (sendEvent) {
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}
		return b;

	}

	public boolean userResCopy(String userId, String[] userid)
			throws ManagerException {
		boolean b = false;
		DBUtil db = new DBUtil();
		DBUtil db1 = new DBUtil();
		TransactionManager tm = new TransactionManager();
		try {

			if (userid != null) {
				tm.begin();
				for (int i = 0; i < userid.length; i++) {
					String sql = "insert into td_sm_roleresop(op_id,res_id,res_name,restype_id,types,role_id) "
							+ " select b.op_id,b.res_id,b.res_name,b.restype_id,b.types,'"
							+ userid[i]
							+ "' from "
							+ " td_sm_roleresop b  where b.role_id ='"
							+ userId
							+ "' minus select "
							+ " c.op_id,c.res_id,c.res_name,c.restype_id,c.types,c.role_id from td_sm_roleresop c "
							+ " where c.role_id='" + userid[i] + "'";

					db.addBatch(sql);
					// 复制用户的角色给选定用户
					String sqlrole = "select role_id from td_sm_userrole where user_id ="
							+ userId;
					db1.executeSelect(sqlrole);
					if (db1.size() > 0) {
						for (int j = 0; j < db1.size(); j++) {
							String sqlselect = "select count(*) from td_sm_userrole where "
									+ " user_id="
									+ userid[i]
									+ " and role_id='"
									+ db1.getString(j, "role_id") + "'";
							String str = "insert into td_sm_userrole(user_id ,role_id) "
									+ " values("
									+ userid[i]
									+ ",'"
									+ db1.getString(j, "role_id") + "')";
							db1.executeSelect(sqlselect);
							if (db1.getInt(0, 0) == 0) {
								db1.executeInsert(str);
							}
						}
					}
				}
				db.executeBatch();
				tm.commit();
				b = true;
				Event event = new EventImpl("",
						ACLEventType.RESOURCE_ROLE_INFO_CHANGE);
				super.change(event);
			}

		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			db.resetBatch();
		}
		return b;

	}

	@Deprecated
	public boolean storeAlotUserRole(String[] ids, String[] roleid)
			throws ManagerException {
		boolean b = false;
		boolean bl = false;

		if (ids != null && roleid != null && ids.length > 0
				&& roleid.length > 0) {

			PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

			StringBuffer selete_sql = new StringBuffer();
			selete_sql
					.append("select count(role_id ) totalsize from td_sm_userrole where user_id =? and role_id =?");
			StringBuffer insert_sql = new StringBuffer();
			insert_sql
					.append("insert into td_sm_userrole(user_id,role_id) values(?,?)");

			TransactionManager tm = new TransactionManager();
			try {
				tm.begin();

				for (int i = 0; i < ids.length; i++) {
					for (int j = 0; j < roleid.length; j++) {
						selete_preparedDBUtil.preparedSelect(selete_sql
								.toString());
						selete_preparedDBUtil.setString(1, ids[i]);
						selete_preparedDBUtil.setString(2, roleid[j]);
						selete_preparedDBUtil.executePrepared();

						if (null != selete_preparedDBUtil
								&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
							insert_preparedDBUtil.preparedInsert(insert_sql
									.toString());
							insert_preparedDBUtil.setString(1, ids[i]);
							insert_preparedDBUtil.setString(2, roleid[j]);
							insert_preparedDBUtil.addPreparedBatch();
							bl = true;
						}
					}
				}
				if (bl)
					insert_preparedDBUtil.executePreparedBatch();
				tm.commit();
				b = true;
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			} finally {
				insert_preparedDBUtil.resetPrepare();
			}
		}
		// DBUtil db = new DBUtil();
		// try {
		// if (ids != null && roleid != null && ids.length > 0 && roleid.length
		// > 0) {
		// for (int i = 0; i < ids.length; i++)
		// {
		// int id = Integer.parseInt(ids[i]);
		// for (int j = 0; j < roleid.length; j++) {
		// String sqlins = "insert all when totalsize <= 0 then into
		// td_sm_userrole(user_id,role_id) values("
		// + id + ",'" + roleid[j] + "') select count(role_id ) totalsize from
		// td_sm_userrole where user_id = "
		// + id + " and role_id = '" + roleid[j] + "'";
		//
		// db.addBatch(sqlins);
		//						
		// }
		// }
		// db.executeBatch();
		// b = true;
		// Event event = new EventImpl("",
		// ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// }
		//
		// } catch (Exception e) {
		// e.printStackTrace();
		// throw new ManagerException(e.getMessage());
		// }finally{
		// db.resetBatch();
		// }
		return b;

	}

	/**
	 * 批量用户角色授权
	 * 
	 * @param ids
	 *            用户IDs
	 * @param roleid
	 *            角色IDs
	 * @param currentUserId
	 *            授予角色的用户ID
	 * @param orgId
	 *            机构ID
	 * @return true:成功 false:失败
	 * @throws ManagerException
	 * @author 彭盛 2011-3-11
	 */
	public boolean storeAlotUserRole(String[] ids, String[] roleid,
			String currentUserId, String orgId) throws ManagerException {
		boolean b = false;
		boolean bl = false;

		if (ids != null && roleid != null && ids.length > 0
				&& roleid.length > 0 && null != currentUserId
				&& !currentUserId.trim().equals("") && null != orgId
				&& !orgId.trim().equals("")) {

			PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

			StringBuffer selete_sql = new StringBuffer();
			selete_sql
					.append("select count(role_id ) totalsize from td_sm_userrole where user_id =? and role_id =?");
			StringBuffer insert_sql = new StringBuffer();
			insert_sql
					.append("insert into td_sm_userrole(user_id,role_id,resop_origin_userid,org_id) values(?,?,?,?)");

			TransactionManager tm = new TransactionManager();
			try {
				tm.begin();

				for (int i = 0; i < ids.length; i++) {
					for (int j = 0; j < roleid.length; j++) {
						selete_preparedDBUtil.preparedSelect(selete_sql
								.toString());
						selete_preparedDBUtil.setString(1, ids[i]);
						selete_preparedDBUtil.setString(2, roleid[j]);
						selete_preparedDBUtil.executePrepared();

						if (null != selete_preparedDBUtil
								&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
							insert_preparedDBUtil.preparedInsert(insert_sql
									.toString());
							insert_preparedDBUtil.setString(1, ids[i]);
							insert_preparedDBUtil.setString(2, roleid[j]);
							insert_preparedDBUtil.setString(3, currentUserId);
							insert_preparedDBUtil.setString(4, orgId);
							insert_preparedDBUtil.addPreparedBatch();
							bl = true;
						}
					}
				}
				if (bl)
					insert_preparedDBUtil.executePreparedBatch();
				tm.commit();
				b = true;
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			} finally {
				insert_preparedDBUtil.resetPrepare();
			}
		} else {
			logger.error("批量用户角色授权失败！参数为空！");
		}
		return b;
	}

	public boolean delAlotUserRole(String[] ids, String[] roleid)
			throws ManagerException {
		boolean b = false;
		DBUtil dbl = new DBUtil();
		try {
			if (ids != null && roleid != null && roleid.length > 0
					&& ids.length > 0) {
				for (int i = 0; i < ids.length; i++) {
					int id = Integer.parseInt(ids[i]);
					for (int j = 0; j < roleid.length; j++) {

						String sql = "delete from td_sm_userrole where user_id = "
								+ id + " and role_id = '" + roleid[j] + "'";
						dbl.addBatch(sql);
					}
				}
				dbl.executeBatch();
				b = true;
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			dbl.resetBatch();
		}
		return b;

	}

	/**
	 * 删除已有的用户角色
	 * 
	 * @param ids
	 *            用户ID
	 * @param roleid
	 *            角色ID
	 * @param orgId
	 *            机构ID
	 * @return true:成功 false:失败
	 * @throws ManagerException
	 * @author 彭盛 2011-3-15
	 */
	public boolean delAlotUserRole(String[] ids, String[] roleid, String orgId)
			throws ManagerException {
		boolean b = false;
		DBUtil dbl = new DBUtil();
		try {
			if (ids != null && roleid != null && roleid.length > 0
					&& ids.length > 0 && null != orgId
					&& !orgId.trim().equals("")) {
				for (int i = 0; i < ids.length; i++) {
					int id = Integer.parseInt(ids[i]);
					for (int j = 0; j < roleid.length; j++) {
						String sql = "delete from td_sm_userrole where user_id = "
								+ id
								+ " and role_id = '"
								+ roleid[j]
								+ "' and org_id='" + orgId + "'";
						dbl.addBatch(sql);
					}
				}
				dbl.executeBatch();
				b = true;
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			dbl.resetBatch();
		}
		return b;
	}

	public List getUserList(String[][] orgjobs) throws ManagerException {
		List list = new ArrayList();
		try {
			StringBuffer sql = new StringBuffer(
					"select distinct * from td_sm_user where user_id in (");
			boolean flag = false;
			for (int i = 0; orgjobs != null && i < orgjobs.length; i++) {
				if (flag)
					sql
							.append(" union select user_id from td_sm_userjoborg where org_id = '"
									+ orgjobs[i][0]
									+ "' and job_id = '"
									+ orgjobs[i][1] + "'");
				else {
					sql
							.append("select user_id from td_sm_userjoborg where org_id = '"
									+ orgjobs[i][0]
									+ "' and job_id = '"
									+ orgjobs[i][1] + "'");
					flag = true;

				}
			}
			if (flag)
				sql.append(")");
			else
				return new ArrayList();
			DBUtil dbUtil = new DBUtil();
			dbUtil.executeSelect(sql.toString());
			for (int i = 0; i < dbUtil.size(); i++) {

				int userid = dbUtil.getInt(i, "user_id");
				int isvalid = dbUtil.getInt(i, "USER_ISVALID");

				User user = new User();
				user.setUserId(new Integer(userid));
				user.setUserName(dbUtil.getString(i, "USER_NAME"));
				user.setUserRealname(dbUtil.getString(i, "USER_REALNAME"));
				user.setUserPassword(dbUtil.getString(i, " USER_PASSWORD"));
				user.setUserSex(dbUtil.getString(i, "USER_SEX"));
				user.setUserMobiletel1(dbUtil.getString(i, "USER_MOBILETEL1"));
				user.setUserMobiletel2(dbUtil.getString(i, "USER_MOBILETEL2"));
				user.setUserIsvalid(new Integer(isvalid));
				user.setUserEmail(dbUtil.getString(i, "USER_EMAIL"));
				user.setUserType(dbUtil.getString(i, "USER_TYPE"));

				list.add(user);
			}

		} catch (SQLException e) {
			throw new ManagerException(e.getMessage());
		}

		return list;
	}

	public boolean deleteUsergroup(String userId, String groupId)
			throws ManagerException {
		DBUtil db = new DBUtil();
		String sql = "delete from td_sm_usergroup where GROUP_ID =" + groupId
				+ " and USER_ID=" + userId + "";
		try {
			db.executeDelete(sql);
			Event event = new EventImpl("", ACLEventType.USER_GROUP_INFO_CHANGE);
			super.change(event);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;

	}

	public boolean storeUserjoborg(String userId, String jobId, String orgId,
			String jobuserSn, String jobSn, boolean needevent)
			throws ManagerException {
		boolean b = false;

		DBUtil db = new DBUtil();
		String sql = "insert into TD_SM_USERJOBORG(USER_ID,JOB_ID,ORG_ID,SAME_JOB_USER_SN,JOB_SN,JOB_STARTTIME,JOB_FETTLE) "
				+ "values ("
				+ userId
				+ ","
				+ "'"
				+ jobId
				+ "','"
				+ orgId
				+ "',"
				+ jobuserSn
				+ ","
				+ jobSn
				+ ","
				+ DBUtil.getDBDate(new Date()) + ",1)";
		try {
			db.executeInsert(sql);
			b = true;
			if (needevent) {
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}
		} catch (SQLException e) {
			throw new ManagerException(e.getMessage());

		}

		return b;

	}

	/**
	 * 获取机构用户排序号，如果用户在机构下已经存在，则保持用户的排序号不变 如果不存在，则将本机构下最大的用户排序号加1返回
	 * 
	 * @param orgid
	 * @param userid
	 * @return
	 */
	public int getUserSN(String orgid, String userid) {
		try {
			String sqlsn = "select same_job_user_sn as sn from  td_sm_userjoborg"
					+ " where  org_id ='"
					+ orgid
					+ "' and user_id="
					+ userid
					+ " ";
			DBUtil dbutil = new DBUtil();
			dbutil.executeSelect(sqlsn);
			int samesn = 0;
			if (dbutil.size() > 0) {
				sqlsn = "select min(same_job_user_sn) as sn from  td_sm_userjoborg"
						+ " where  org_id ='"
						+ orgid
						+ "' and user_id="
						+ userid + " ";

				dbutil.executeSelect(sqlsn);
				samesn = dbutil.getInt(0, 0);
			} else {
				DBUtil dbutil1 = new DBUtil();
				sqlsn = "select max(same_job_user_sn) as sn from  td_sm_userjoborg"
						+ " where  org_id ='" + orgid + "'";
				dbutil1.executeSelect(sqlsn);
				if (dbutil1.size() > 0)
					samesn = dbutil1.getInt(0, 0) + 1;
				else
					samesn = 0;

			}
			return samesn;
		} catch (Exception e) {

		}
		return 0;
	}

	/**
	 * 保存多个用户在同一个机构下的多个岗位关系
	 */
	public boolean storeAlotUserJob(String[] ids, String[] jobid, String orgid)
			throws ManagerException {

		boolean b = false;

		try {

			DBUtil dbl = new DBUtil();

			if (ids != null && jobid != null) {
				for (int i = 0; i < ids.length; i++) {
					String id = ids[i];
					int samesn = this.getUserSN(orgid, id);
					for (int j = 0; j < jobid.length; j++) {
						String sql = "select * from td_sm_userjoborg where "
								+ "user_id = " + id + " and job_id = '"
								+ jobid[j] + "' and org_id ='" + orgid + "'";
						dbl.executeSelect(sql);
						if (dbl.size() == 0) {

							saveUser(id, jobid[j], orgid, samesn);
						}
					}

				}
				b = true;
				Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
				super.change(event);
				Event event1 = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event1);
			}

		} catch (Exception e) {
			throw new ManagerException(e.getMessage());
		}
		return b;
	}

	private void saveUser(String userId, String jobId, String orgId, int samesn) {
		try {
			String jobsnsql = "select c.job_sn from td_sm_orgjob c where c.org_id ='"
					+ orgId + "' and c.job_id='" + jobId + "'";
			DBUtil temp = new DBUtil();
			temp.executeSelect(jobsnsql);

			String jobsn = "1";
			if (temp.size() > 0)
				jobsn = temp.getInt(0, 0) + "";

			DBUtil db = new DBUtil();

			String sql = "insert into td_sm_userjoborg"
					+ " (user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)"
					+ " values(" + userId + ",'" + jobId + "','" + orgId + "',"
					+ jobsn + "," + samesn + ",sysdate,1)";
			db.executeInsert(sql);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 删除多个用户在同一个机构下的多个岗位，
	 * 同时如果用户在机构下没有任何岗位时并且本机构是用户的主机构，需删除本机构和用户的主机构关系，并且重新设置用户的主机构
	 * 
	 */
	public boolean delAlotJobRole(String[] ids, String[] jobid, String orgId)
			throws ManagerException {
		boolean b = false;
		DBUtil dbl = new DBUtil();
		DBUtil db2 = new DBUtil();
		try {
			if (ids != null && jobid != null) {
				for (int i = 0; i < ids.length; i++) {

					for (int j = 0; j < jobid.length; j++) {
						int id = Integer.parseInt(ids[i]);
						String sqlselect = "select * from TD_SM_USERJOBORG a,td_sm_job b,td_sm_organization c where a.job_id ='"
								+ jobid[j]
								+ "'and a.job_id=b.job_id and a.ORG_ID=c.ORG_ID and"
								+ " a.org_id ='"
								+ orgId
								+ "' and user_id ="
								+ id + "";
						String sql = "delete from td_sm_userjoborg where user_id = "
								+ id
								+ " and job_id = '"
								+ jobid[j]
								+ "' and org_id ='" + orgId + "'";
						db2.executeSelect(sqlselect);
						for (int k = 0; k < db2.size(); k++) {
							int userid = db2.getInt(k, "user_id");
							String jid = db2.getString(k, "JOB_ID");
							String oid = db2.getString(k, "ORG_ID");
							String jname = db2.getString(k, "JOB_NAME");
							String oname = db2.getString(k, "ORG_NAME");
							Date starttime = db2.getDate(k, "JOB_STARTTIME");
							SimpleDateFormat time = new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss");
							String starttimestr = time.format(starttime)
									.toString();
							String sql2 = "insert into TD_SM_USERJOBORG_HISTORY values("
									+ userid
									+ ",'"
									+ jid
									+ "','"
									+ jname
									+ "','"
									+ oid
									+ "','"
									+ oname
									+ "',to_date('"
									+ starttimestr
									+ "','yyyy-mm-dd hh24:mi:ss'),"
									+ "sysdate,0)";
							db2.executeInsert(sql2);
						}
						dbl.executeDelete(sql);

					}
					resetUserMainOrg(ids[i], orgId);
				}
				b = true;
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			}
		} catch (Exception e) {
			throw new ManagerException(e.getMessage());
		}

		return b;
	}

	/**
	 * 更改用户的主机构，所有取消用户岗位的方法在处理完后需要调用本方法进行检测，并进行相应的主机构处理
	 * 
	 * @param id
	 */
	public void resetUserMainOrg(String userid, String oldmainorg) {
		String user_sql = "select count(user_id) from td_sm_userjoborg where user_id="
				+ userid + " and org_id='" + oldmainorg + "'";
		DBUtil dbUtil = new DBUtil();
		TransactionManager tm = new TransactionManager();
		try {
			dbUtil.executeSelect(user_sql);

			if (dbUtil.getInt(0, 0) == 0)// 用户在oldmainorg没有任职的情况处理,并且检测用户的主机构是否是oldmainorg，如果是则删除用户的主机构信息，并且重新为用户设置一个主机构
			{
				tm.begin();
				String mainsql = "select user_id,org_id from td_sm_orguser where user_id = "
						+ userid;
				dbUtil.executeSelect(mainsql);
				if (dbUtil.size() != 0) {
					String t_org_id = dbUtil.getString(0, "org_id");
					if (t_org_id.equals(oldmainorg)) {
						String slq = "delete from td_sm_orguser where user_id="
								+ userid + " and org_id='" + oldmainorg + "'";
						dbUtil.executeDelete(slq);
						user_sql = "select user_id,org_id from td_sm_userjoborg where user_id="
								+ userid + " order by job_starttime asc";
						dbUtil.executeSelect(user_sql);
						if (dbUtil.size() > 0) {
							user_sql = "insert into td_sm_orguser(user_id,org_id) values("
									+ userid
									+ ","
									+ dbUtil.getString(0, "org_id") + ")";
						}
					}
				}
				tm.commit();

			} else {

			}
			Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {

		}

	}

	public List getmemberTypeList(String typeid) throws ManagerException {
		String sql = "select DICTDATA_VALUE,DICTDATA_NAME from TD_SM_DICTDATA where DICTTYPE_ID='"
				+ typeid + "'";
		List list = null;

		try {
			DBUtil db1 = new DBUtil();
			db1.executeSelect(sql);
			list = new ArrayList();
			for (int i = 0; i < db1.size(); i++) {
				Dictdata ddata = new Dictdata();
				ddata.setDictdataValue(db1.getString(i, "DICTDATA_VALUE"));
				ddata.setDictdataName(db1.getString(i, "DICTDATA_NAME"));
				list.add(ddata);

			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.toString());
		}

		return list;
	}

	public void storeUserrole(String userId, String roleId)
			throws ManagerException {

		DBUtil db = new DBUtil();
		DBUtil dbl = new DBUtil();
		try {

			String sql = "select count(*) from td_sm_userrole where "
					+ " user_id = " + userId + " and role_id ='" + roleId + "'";

			dbl.executeSelect(sql);
			if (dbl.getInt(0, 0) == 0) {
				String sqlins = "insert into td_sm_userrole(user_id,role_id) "
						+ " values(" + userId + ",'" + roleId + "')";
				db.executeInsert(sqlins);
			}

			Event event = new EventImpl("",
					ACLEventType.RESOURCE_ROLE_INFO_CHANGE);
			super.change(event);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}

	}

	/**
	 * 保存用户 角色
	 * 
	 * @param userId
	 * @param roleIds
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 * @deprecated
	 */
	public void addUserrole(String userId, String[] roleIds)
			throws ManagerException {
		DBUtil db = new DBUtil();
		try {
			for (int i = 0; i < roleIds.length; i++) {
				String roleId = roleIds[i];
				String sql = "insert into td_sm_userrole(user_id,role_id) (select "
						+ userId
						+ " as user_id ,'"
						+ roleId
						+ "' as role_id from dual where "
						+ " not exists (select * from td_sm_userrole where user_id= "
						+ userId + " and " + " role_id = '" + roleId + "'))";
				db.addBatch(sql);
			}
			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			db.resetBatch();
		}

	}

	/**
	 * 保存用户 角色
	 * 
	 * @param userId
	 * @param roleIds
	 * @param currentUserId
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 * @deprecated
	 */
	public void addUserrole(String userId, String[] roleIds,
			String currentUserId) throws ManagerException {
		if (null != userId && !userId.trim().equals("") && null != roleIds
				&& null != currentUserId && !currentUserId.trim().equals("")) {
			PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

			StringBuffer selete_sql = new StringBuffer();
			selete_sql
					.append("select count(1) as totalsize from td_sm_userrole where user_id=? and role_id=?");
			StringBuffer insert_sql = new StringBuffer();
			insert_sql
					.append("insert into td_sm_userrole(user_id,role_id,resop_origin_userid) values(?,?,?)");

			TransactionManager tm = new TransactionManager();

			try {
				tm.begin();
				for (int i = 0; i < roleIds.length; i++) {
					selete_preparedDBUtil.preparedSelect(selete_sql.toString());
					selete_preparedDBUtil.setString(1, userId);
					selete_preparedDBUtil.setString(2, roleIds[i]);
					selete_preparedDBUtil.executePrepared();

					if (null != selete_preparedDBUtil
							&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
						insert_preparedDBUtil.preparedInsert(insert_sql
								.toString());
						insert_preparedDBUtil.setString(1, userId);
						insert_preparedDBUtil.setString(2, roleIds[i]);
						insert_preparedDBUtil.setString(3, currentUserId);
						insert_preparedDBUtil.addPreparedBatch();
					}
				}
				insert_preparedDBUtil.executePreparedBatch();
				tm.commit();
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} finally {
				insert_preparedDBUtil.resetPrepare();
			}
		}

		// DBUtil db = new DBUtil();
		// try {
		// StringBuffer sql = new StringBuffer();
		// for (int i = 0; i < roleIds.length; i++) {
		// // String roleId = roleIds[i];
		// // String sql = "insert into
		// td_sm_userrole(user_id,role_id,resop_origin_userid) (select "
		// // + userId
		// // + " as user_id ,'"
		// // + roleId
		// // + "' as role_id, '"
		// // + currentUserId
		// // + "' as resop_origin_userid from dual where "
		// // + " not exists (select * from td_sm_userrole where user_id= "
		// // + userId + " and " + " role_id = '" + roleId + "'))";
		// //update 20080722 gao.tang
		// sql.append("insert all when totalsize <= 0 then into
		// td_sm_userrole(user_id,role_id,resop_origin_userid) ")
		// .append(" values('")
		// .append(userId).append("','").append(roleIds[i]).append("','")
		// .append(currentUserId).append("') ")
		// .append("select count(1) as totalsize from td_sm_userrole ")
		// .append("where user_id='").append(userId).append("' ")
		// .append(" and role_id='").append(roleIds[i]).append("'");
		// db.addBatch(sql.toString());
		// sql.setLength(0);
		// }
		// db.executeBatch();
		// Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
		// super.change(event);
		// } catch (Exception e) {
		// e.printStackTrace();
		// throw new ManagerException(e.getMessage());
		// }finally{
		// db.resetBatch();
		// }

	}

	/**
	 * 保存用户 角色
	 * 
	 * @param userId
	 *            用户ID
	 * @param roleIds
	 *            角色IDs
	 * @param currentUserId
	 *            授予角色的用户ID
	 * @param orgId
	 *            机构ID
	 * @throws ManagerException
	 *             UserManager.java
	 * @author: 彭盛 2011-3-11
	 */
	public void addUserrole(String userId, String[] roleIds,
			String currentUserId, String orgId) throws ManagerException {
		if (null != userId && !userId.trim().equals("") && null != roleIds
				&& null != currentUserId && !currentUserId.trim().equals("")
				&& null != orgId && !orgId.trim().equals("")) {
			PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

			StringBuffer selete_sql = new StringBuffer();
			selete_sql
					.append("select count(1) as totalsize from td_sm_userrole where user_id=? and role_id=? and org_id=?");
			StringBuffer insert_sql = new StringBuffer();
			insert_sql
					.append("insert into td_sm_userrole(user_id,role_id,resop_origin_userid,org_id) values(?,?,?,?)");

			TransactionManager tm = new TransactionManager();

			try {
				tm.begin();
				for (int i = 0; i < roleIds.length; i++) {
					selete_preparedDBUtil.preparedSelect(selete_sql.toString());
					selete_preparedDBUtil.setString(1, userId);
					selete_preparedDBUtil.setString(2, roleIds[i]);
					selete_preparedDBUtil.setString(3, orgId);
					selete_preparedDBUtil.executePrepared();

					if (null != selete_preparedDBUtil
							&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
						insert_preparedDBUtil.preparedInsert(insert_sql
								.toString());
						insert_preparedDBUtil.setString(1, userId);
						insert_preparedDBUtil.setString(2, roleIds[i]);
						insert_preparedDBUtil.setString(3, currentUserId);
						insert_preparedDBUtil.setString(4, orgId);
						insert_preparedDBUtil.addPreparedBatch();
					}
				}
				insert_preparedDBUtil.executePreparedBatch();
				tm.commit();
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			} finally {
				insert_preparedDBUtil.resetPrepare();
			}
		} else {
			throw new ManagerException("新增用户角色错误！参数为空！");
		}
	}

	/**
	 * 删除用户 角色
	 * 
	 * @param userId
	 * @param roleIds
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 */
	public void deleteUserrole(String userId, String[] roleIds)
			throws ManagerException {

		DBUtil db = new DBUtil();
		try {
			StringBuffer sql = new StringBuffer(
					"delete td_sm_userrole where user_id = ").append(userId)
					.append(" and role_id in(");
			for (int i = 0; i < roleIds.length; i++) {
				if (i == 0)
					sql.append(roleIds[i]);
				else
					sql.append(",").append(roleIds[i]);
			}
			sql.append(")");
			db.executeDelete(sql.toString());
			sql.setLength(0);
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}

	}

	/**
	 * 删除用户 角色
	 * 
	 * @param userId
	 * @param roleIds
	 * @param roleTypes
	 * @throws ManagerException
	 *             UserManagerImpl.java
	 * @author: ge.tao
	 */
	public void deleteUserrole(String userId, String[] roleIds, String roleTypes)
			throws ManagerException {
		DBUtil db = new DBUtil();
		try {
			StringBuffer sql = new StringBuffer(
					"delete from td_sm_userrole where user_id = ").append(
					userId).append(" and role_id in(");
			for (int i = 0; i < roleIds.length; i++) {
				if (i == 0)
					sql.append("'").append(roleIds[i]).append("'");
				else
					sql.append(",'").append(roleIds[i]).append("'");
			}
			sql.append(")");
			db.executeDelete(sql.toString());
			sql.setLength(0);
			// 递归回收
			// ResManager resManager = new ResManagerImpl();
			// for(int i=0;i<roleIds.length;i++){
			// String roleId = roleIds[i];
			// resManager.reclaimUserRole(roleId, userId, roleTypes);
			// }
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}
	}

	/**
	 * 删除用户 角色
	 * 
	 * @param userId
	 *            用户ID
	 * @param roleIds
	 *            角色ID
	 * @param orgId
	 *            机构ID
	 * @return true:成功 false:失败
	 * @throws ManagerException
	 * @author 彭盛 2011-3-14
	 */
	public boolean deleteUserrole(String userId, String[] roleIds,
			String orgId, String roleTypes) throws ManagerException {
		if (null != userId && !userId.trim().equals("") && null != roleIds
				&& roleIds.length > 0 && null != orgId
				&& !orgId.trim().equals("") && null != roleTypes
				&& !roleTypes.trim().equals("")) {
			DBUtil db = new DBUtil();
			try {
				StringBuffer sql = new StringBuffer(
						"delete from td_sm_userrole where user_id = ").append(
						userId).append(" and org_id='").append(orgId).append(
						"' and role_id in(");
				for (int i = 0; i < roleIds.length; i++) {
					if (i == 0)
						sql.append("'").append(roleIds[i]).append("'");
					else
						sql.append(",'").append(roleIds[i]).append("'");
				}
				sql.append(")");
				db.executeDelete(sql.toString());
				sql.setLength(0);
				Event event = new EventImpl("",
						ACLEventType.USER_ROLE_INFO_CHANGE);
				super.change(event);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				throw new ManagerException(e.getMessage());
			}
		} else {
			throw new ManagerException("删除用户角色失败！参数为空！");
		}
	}

	public void creatorUser(User user, String orgId, String jobId)
			throws ManagerException {
		TransactionManager tm = new TransactionManager();
		StringBuffer sql1=new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		if (user != null) {
			/**
			 * 把主机构set到user对象里面 ge.tao 2007-09-10
			 */
			user.setMainOrg(orgId);
			// 得到平台数据源
			String egpdbname = EgpManager.getEgpDBName();
			int samesn = 1;
			try {
				tm.begin();
				// 检查当前用户实例是否来自LDAP，因为LDAP中的用户ID(UID)是采用用户名标识其唯一性
				// if (user.getUserId() != null
				// && user.getUserId().intValue() == -1) {
				// User oldUser = getUser("userName", user.getUserName());
				// if (oldUser == null)
				// user.setUserId(null);
				// else {
				//
				// user.setUserId(oldUser.getUserId());
				// String oldpassword = StringUtil.replaceNull(oldUser
				// .getUserPassword());
				// String newpassword = StringUtil.replaceNull(user
				// .getUserPassword());
				// if (!oldpassword.equals(EncrpyPwd
				// .encodePassword(newpassword)))
				// user.setUserPassword(EncrpyPwd
				// .encodePassword(newpassword));
				//
				// }
				//
				// } else {
				String password = StringUtil
						.replaceNull(user.getUserPassword());
				user.setUserPassword(EncrpyPwd.encodePassword(password));
				// }

				// （1）保存到用户表
				String userId = null;
				// 判断user是否是新增的用户
				// if (user.getUserId() == null) {
				userId = SecurityDatabase.getUserManager().addUser(user, false);
				// }
				// else {
				// // 修改用户直接跳出
				// SecurityDatabase.getUserManager().updateUser(user);
				// return;
				// }
				// （2）增加用户主要所属单位到td_sm_orguser表
				OrgManager orgmanager = SecurityDatabase.getOrgManager();
				// String userId = user.getUserId().toString();

				orgmanager.addMainOrgnazitionOfUser(userId, orgId,egpdbname);
				// （3）往td_sm_userjoborg表中插入记录
				String sqlsn = "select max(same_job_user_sn) as sn from  td_sm_userjoborg"
						+ " where  org_id ='" + orgId + "'";
				DBUtil dbutil = new DBUtil();
				dbutil.executeSelect(egpdbname,sqlsn);
				DBUtil db = new DBUtil();
				if (dbutil != null && dbutil.getInt(0, 0) > 0) {
					samesn = dbutil.getInt(0, "sn") + 1;
					String sql = "insert into td_sm_userjoborg"
							+ " (user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)"
							+ " values(" + userId + ",'" + jobId + "','"
							+ orgId + "'," + 999 + "," + samesn + ",sysdate,1)";
					db.executeInsert(egpdbname,sql);
				} else {
					samesn = 1;
					String sql = "insert into td_sm_userjoborg"
							+ "(user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)"
							+ " values(" + userId + ",'" + jobId + "','"
							+ orgId + "'," + 999 + "," + samesn + ",sysdate,1)";
					db.executeInsert(egpdbname,sql);
				}
				/**
				 * 把排序号set到user对象里面 ge.tao 2007-09-10
				 */
				user.setUserSn(new Integer(samesn));
				user.setUserId(new Integer(userId));
				AccessControl control = AccessControl.getAccessControl();
				String operContent = "";
				String operSource = control.getMachinedID();// control.getRemoteAddr();
				String openModle = "用户管理";
				String userName = control.getUserName();
				LogManager logManager = SecurityDatabase.getLogManager();
				operContent = userName + " 新增了用户: " + user.getUserName() + "["
						+ user.getUserRealname() + "]";
				// logManager.log(control.getUserAccount(),operContent,openModle,operSource,"");
				// String operUser,String operOrg,String logModule, String
				// visitorial,
				// String oper ,String remark1, int operType

				tm.commit();
				/*sql1.append(" insert into ta_oa_userandsn");
				sql1.append("  (id, userid, mobile_sn)");
				sql1.append(" values ");
				sql1.append(" (seq_oa_userandsn.nextval, ?, ?)");
				pdb.preparedInsert(sql1.toString());
				pdb.setString(1, userId);
				pdb.setString(2, user.getMobileSn());
				pdb.executePrepared();*/  
				
				logManager.log(control.getUserAccount(), control
						.getChargeOrgId(), openModle, operSource, operContent,
						"", Log.INSERT_OPER_TYPE);
				Event event = new EventImpl("", ACLEventType.USER_INFO_ADD);
				super.change(event);

			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				throw new ManagerException(e.getMessage());
			}

		}

	}

	/**
	 * 保存用户的排序
	 * 
	 * @param orgId
	 * @param jobId
	 * @param jobSn
	 * @param userId
	 * @return
	 * @throws Exception
	 *             UserManager.java
	 * @author: ge.tao
	 */
	public String storeAllUserSnJobOrg(String orgId, String jobId,
			String jobSn, String[] userId) throws Exception {
		DBUtil db = new DBUtil();
		try {
			UserManager userManager = SecurityDatabase.getUserManager();

			// 吴卫雄修改：需要完整用户对象信息
			// Organization org = new Organization();
			// org.setOrgId(orgId);
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			// Organization org = orgMgr.getOrg("org_id", orgId);
			// 吴卫雄修改结束
			Job job = new Job();
			job.setJobId(jobId);
			// 吴卫雄修改：需要完成用户对象信息
			// User user = new User();
			// user.setUserId(Integer.valueOf(userList[i]));

			// 在保存之前先删除该机构下改岗位的所有用户.然后再添加
			// userManager.deleteUserjoborg(job, org);

			// String str = "delete from td_sm_userjoborg where " + " org_id ='"
			// + orgId + "' and job_id='" + jobId + "'";
			// db.executeDelete(str);

			for (int i = 0; userId != null && i < userId.length; i++) {
				String sql = "update TD_SM_USERJOBORG set SAME_JOB_USER_SN='"
						+ (i + 1) + "',JOB_SN='"
						+ (Integer.parseInt(jobSn) + 1) + "',JOB_STARTTIME="
						+ DBUtil.getDBDate(new Date())
						+ ",JOB_FETTLE=1 where USER_ID=" + userId[i]
						+ "and JOB_ID='" + jobId + "' and ORG_ID='" + orgId
						+ "'";
				db.addBatch(sql);
				// storeUserjoborg(userId[i],jobId,orgId,(i + 1) +
				// "",(Integer.parseInt(jobSn) + 1) + "",false);
			}
			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);

		} catch (Exception e) {
			return "fail";
		} finally {
			db.resetBatch();
		}

		return "success";
	}

	/**
	 * 保存机构下的用户排序
	 * 
	 * @param orgId
	 * @param userId
	 * @throws Exception
	 *             OrgJobAction.java
	 * @author: ge.tao
	 */
	public void storeOrgUserOrder(String orgId, String[] userId)
			throws Exception {
		if (userId == null || userId.length <= 0)
			return;
		DBUtil db = new DBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			for (int i = 0; i < userId.length; i++) {
				sql.append("update td_sm_userjoborg t set t.same_job_user_sn=");
				sql.append(i + "");
				sql.append(" where t.user_id=");
				sql.append(userId[i]);
				sql.append(" and org_id='").append(orgId).append("'");
				db.addBatch(sql.toString());
				sql.setLength(0);
			}
			db.executeBatch();
			// Event event = new EventImpl("",
			// ACLEventType.USER_ROLE_INFO_CHANGE);
			// super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}

	}

	/**
	 * 删除人员岗位和机构的关系，用户管理隶属机构中的调入 修改人:gao.tang,biaoping.yin
	 */
	public String deleteUJOAjax(String uid, String[] jobIds, String orgId)
			throws Exception {
		if (uid == null || uid.trim().length() <= 0)
			return "fail";
		DBUtil batchUtil = new DBUtil();
		TransactionManager tm = new TransactionManager();
		try {

			tm.begin();
			for (int i = 0; (jobIds != null) && (i < jobIds.length); i++) {
				// UserManager userManager = SecurityDatabase.getUserManager();
				DBUtil dbutile = new DBUtil();
				DBUtil db = new DBUtil();
				String sql1 = "select * from TD_SM_USERJOBORG where job_id ='"
						+ jobIds[i] + "' and" + " org_id ='" + orgId
						+ "' and user_id =" + uid + "";
				db.executeSelect(sql1);
				// -----如果该用户的主要单位为该机构，删除用户和该机构关系
				OrgManager orgManager = SecurityDatabase.getOrgManager();
				String strsql = "select count(*) from td_sm_orguser where org_id ='"
						+ orgId + "' and user_id =" + uid + "";
				dbutile.executeSelect(strsql);
				if (dbutile.getInt(0, 0) > 0) {
					orgManager.deleteMainOrgnazitionOfUser(uid);
				}
				// ------------------------------------------------------

				// 存数据到历史表TD_SM_USERJOBORG_HISTORY

				int userid = db.getInt(0, "user_id");
				String jid = db.getString(0, "JOB_ID");
				String oid = db.getString(0, "ORG_ID");
				Date starttime = db.getDate(0, "JOB_STARTTIME");
				String sql2 = "insert into TD_SM_USERJOBORG_HISTORY values("
						+ userid + ",'" + jid + "'," + "'" + oid + "',"
						+ DBUtil.getDBDate(starttime) + "," + ""
						+ DBUtil.getDBDate(new Date()) + ",0)";

				// db.executeInsert(sql2);
				batchUtil.addBatch(sql2);
				String sql = "delete from TD_SM_USERJOBORG where job_id ='"
						+ jobIds[i] + "' and" + " org_id ='" + orgId
						+ "' and user_id =" + uid + "";
				batchUtil.addBatch(sql);
				// userManager.deleteUserjoborg(uid, jobIds[i], orgId);

			}
			batchUtil.executeBatch();
			tm.commit();
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			tm.rollback();
			e.printStackTrace();
			return "fail";
		} finally {
			batchUtil.resetBatch();
		}

		return "success";
	}

	public void storeUJOAjax_batch(String[] ids, String[] jobid, String orgid) {

		try {
			DBUtil db = new DBUtil();
			DBUtil dbl = new DBUtil();
			OrgManager orgManager = SecurityDatabase.getOrgManager();

			if (ids != null && jobid != null) {
				for (int i = 0; i < ids.length; i++) {

					String userid = ids[i];
					// 获得same_job_user_sn和JOB_SN,weida
					String org_id = orgid;
					String sjus = String.valueOf(getUserSN(org_id, userid));
					for (int j = 0; j < jobid.length; j++) {
						int id = Integer.parseInt(ids[i]);
						String job_id = jobid[j];
						String js = "";

						String jsSql = "select JOB_SN from TD_SM_ORGJOB where job_id ='"
								+ job_id
								+ "' and"
								+ " org_id ='"
								+ org_id
								+ "'";
						DBUtil jsDb = new DBUtil();
						jsDb.executeSelect(jsSql);
						if (jsDb != null && jsDb.size() > 0) {
							js = String.valueOf(jsDb.getInt(0, "JOB_SN"));
						}

						String sql = "select * from td_sm_userjoborg where "
								+ "user_id = " + id + " and job_id = '"
								+ jobid[j] + "' and org_id ='" + orgid + "'";
						dbl.executeSelect(sql);
						if (dbl.size() == 0) {

							// 插入same_job_user_sn和JOB_SN
							String sqlins = "insert into td_sm_userjoborg(user_id,job_id,org_id,SAME_JOB_USER_SN,JOB_SN,JOB_STARTTIME,JOB_FETTLE) "
									+ "values("
									+ id
									+ ",'"
									+ jobid[j]
									+ "','"
									+ orgid
									+ "','"
									+ sjus
									+ "','"
									+ js
									+ "',"
									+ DBUtil.getDBDate(new Date()) + ",1)";
							// String sqlins ="insert into
							// td_sm_userjoborg(user_id,job_id,org_id,JOB_STARTTIME,JOB_FETTLE)
							// " +
							// "values("+ id +",'"+ jobid[j] +"','"+ orgid
							// +"',"+ DBUtil.getDBDate(new Date())+",1)";

							db.executeInsert(sqlins);
							// 批量用户加入机构，设置主机构
							DBUtil db1 = new DBUtil();
							String str = "select count(*)  from TD_SM_ORGUSER where "
									+ " user_id ="
									+ id
									+ " and org_id ='"
									+ orgid + "'";
							db1.executeSelect(str);
							if (db1.getInt(0, 0) == 0) {
								orgManager.addMainOrgnazitionOfUser(userid,
										orgid);
							}

						}
					}
				}

			}
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void deleteUJOAjax_batch(String[] ids, String[] jobid, String orgId)
			throws ManagerException {

		DBUtil dbl = new DBUtil();
		DBUtil db2 = new DBUtil();
		TransactionManager tm = new TransactionManager();
		try {
			if (ids != null && jobid != null) {
				tm.begin();
				for (int i = 0; i < ids.length; i++)
					for (int j = 0; j < jobid.length; j++) {
						int id = Integer.parseInt(ids[i]);
						String sqlselect = "select * from TD_SM_USERJOBORG where job_id ='"
								+ jobid[j]
								+ "' and"
								+ " org_id ='"
								+ orgId
								+ "' and user_id =" + id + "";
						String sql = "delete from td_sm_userjoborg where user_id = "
								+ id
								+ " and job_id = '"
								+ jobid[j]
								+ "' and org_id ='" + orgId + "'";
						db2.executeSelect(sqlselect);
						for (int k = 0; k < db2.size(); k++) {
							int userid = db2.getInt(k, "user_id");
							String jid = db2.getString(k, "JOB_ID");
							String oid = db2.getString(k, "ORG_ID");
							Date starttime = db2.getDate(k, "JOB_STARTTIME");
							String sql2 = "insert into TD_SM_USERJOBORG_HISTORY values("
									+ userid
									+ ",'"
									+ jid
									+ "',"
									+ "'"
									+ oid
									+ "',"
									+ DBUtil.getDBDate(starttime)
									+ ","
									+ "" + DBUtil.getDBDate(new Date()) + ",0)";

							db2.executeInsert(sql2);
						}

						dbl.executeDelete(sql);
					}
				tm.commit();

			}
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

	}

	public String deleteUserOrgJob(Integer uid, String orgId, String[] jobid) {

		// System.out.println("uid..........."+uid);
		// System.out.println("orgId............"+orgId);
		TransactionManager tm = new TransactionManager();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		DBUtil db = new DBUtil();
		DBUtil insert_db = new DBUtil();
		try {

			tm.begin();
			for (int i = 0; (jobid != null) && (i < jobid.length); i++) {

				UserManager userManager = SecurityDatabase.getUserManager();
				// String sql = "delete from TD_SM_USERJOBORG where job_id ='"
				// + jobid[i] + "' and" + " org_id ='" + orgId
				// + "' and user_id =" + uid + "";
				// String sql1 = "select * from TD_SM_USERJOBORG where job_id
				// ='"
				// + jobid[i] + "' and" + " org_id ='" + orgId
				// + "' and user_id =" + uid + "";
				sql1
						.append(
								"SELECT a.*, b.job_name as jobname, o.remark5 as remark5 ")
						.append(
								"FROM td_sm_userjoborg a LEFT JOIN td_sm_job b ON a.job_id = b.job_id ")
						.append(
								"LEFT JOIN td_sm_organization o ON a.org_id = o.org_id where a.job_id <> '1' and a.job_id = '")
						.append(jobid[i]).append("' and a.org_id = '").append(
								orgId).append("' and a.user_id =").append(uid);
				db.executeSelect(sql1.toString());
				// db.executeDelete(sql);
				String userId = uid.toString();
				userManager.deleteUserjoborg(userId, jobid[i], orgId, false);
				sql1.setLength(0);
				// 存数据到历史表TD_SM_USERJOBORG_HISTORY
				for (int j = 0; j < db.size(); j++) {
					int userid = db.getInt(j, "user_id");
					String jid = db.getString(j, "JOB_ID");
					String oid = db.getString(j, "ORG_ID");
					Date starttime = db.getDate(j, "JOB_STARTTIME");
					// SimpleDateFormat time = new SimpleDateFormat(
					// "yyyy-MM-dd HH:mm:ss");
					// String starttimestr = time.format(starttime).toString();
					String jobName = db.getString(j, "jobname");
					String orgName = db.getString(j, "remark5");

					sql2
							.append(
									"insert into TD_SM_USERJOBORG_HISTORY(USER_ID,JOB_ID,job_name,org_id,")
							.append(
									"org_name,JOB_STARTTIME,JOB_QUASHTIME,JOB_FETTLE) values(")
							.append(userid).append(",'").append(jid).append(
									"','").append(jobName).append("','")
							.append(oid).append("','").append(orgName).append(
									"',to_date('").append(starttime).append(
									"','yyyy-MM-dd HH24:mi:ss'),sysdate,0)");
					// System.out.println(sql2);
					insert_db.executeInsert(sql2.toString());
					sql2.setLength(0);
				}
			}
			tm.commit();
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			return "fail";
		} finally {
			sql1 = null;
			sql2 = null;
		}
		return "success";
	}

	/**
	 * 存储人员岗位和机构的关系，用户管理隶属机构中的调入,如果用户没有设置主机构， 同时设置主机构
	 */
	public String storeUJOAjax(String uid, String[] jobIds, String orgId) {
		if (uid == null || uid.trim().length() <= 0)
			return "fail";
		UserManager userManager;
		try {
			userManager = SecurityDatabase.getUserManager();
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			try {
				userManager.storeUserjoborg(uid, jobIds, orgId);

				DBUtil db1 = new DBUtil();
				String str = "select count(*)  from TD_SM_ORGUSER where "
						+ " user_id =" + uid;
				// +" and org_id ='"+ orgId +"'";

				db1.executeSelect(str);

				if (db1.getInt(0, 0) == 0) {
					orgManager.addMainOrgnazitionOfUser(uid, orgId);
				}
				// 执行userManager.storeUserjoborg(uid, jobIds,
				// orgId);方法时已经发出用户角色变化的事件,此处不需要再发
				// Event event = new EventImpl("",
				// ACLEventType.USER_INFO_CHANGE);
				// super.change(event);
			} catch (ManagerException e) {

				e.printStackTrace();
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

		return "success";
	}

	/**
	 * 隶属岗位－－保存用户岗位机构的关系 store and delete userOrgJob by ajax the reference page
	 * is refresh auto (hongyu.deng)
	 * 
	 * @param uid
	 * @param orgId
	 * @param jobid
	 * @return
	 */
	public String storeUserOrgJob(Integer uid, String orgId, String[] jobid) {

		// System.out.println("uid..........."+uid);
		// System.out.println("orgId............"+orgId);

		try {

			for (int i = 0; (jobid != null) && (i < jobid.length); i++) {
				DBUtil db = new DBUtil();
				String sql = "select *  from TD_SM_USERJOBORG where job_id ='"
						+ jobid[i] + "' and" + " org_id ='" + orgId
						+ "' and user_id =" + uid + "";
				db.executeSelect(sql);
				// 如果记录已有，不进行操作
				if (db.size() > 0) {
					continue;
				} else {
					String userId = uid.toString();
					UserManager userManager = SecurityDatabase.getUserManager();
					userManager.storeUserjoborg(userId, jobid[i], orgId, false);
					// String sql1 ="insert into TD_SM_USERJOBORG values ("+ uid
					// +"," +
					// "'"+ jobid[i] +"','"+ orgId +"',0,0," +
					// DBUtil.getDBDate(new Date())+ ",1)";
					//
					// //System.out.println(sql1);
					// db.executeInsert(sql1);
				}
			}
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}

		return "success";

	}

	/**
	 * 批量用户加入机构
	 * 
	 * @param ids
	 * @param jobid
	 * @param orgid
	 * @throws ManagerException
	 * @throws SPIException
	 */
	public void storeAlotUserOrg(String[] ids, String[] jobids, String orgid)
			throws ManagerException, SPIException {
		// System.out.println("...................."+orgid);

		DBUtil db = new DBUtil();
		DBUtil dbl = new DBUtil();

		try {
			if (ids != null && jobids != null) {
				for (int i = 0; i < ids.length; i++) {
					String userid = String.valueOf(ids[i]);
					String org_id = orgid;
					String sjus = String.valueOf(getUserSN(org_id, userid));
					for (int j = 0; j < jobids.length; j++) {
						int id = Integer.parseInt(ids[i]);

						// 获得same_job_user_sn和JOB_SN,weida

						String job_id = jobids[j];

						String js = "";
						String jsSql = "select JOB_SN from TD_SM_ORGJOB where job_id ='"
								+ job_id
								+ "' and"
								+ " org_id ='"
								+ org_id
								+ "'";
						DBUtil jsDb = new DBUtil();
						jsDb.executeSelect(jsSql);
						if (jsDb != null && jsDb.size() > 0) {
							js = String.valueOf(jsDb.getInt(0, "JOB_SN"));
						}

						String sql = "select * from td_sm_userjoborg where "
								+ "user_id = " + id + " and job_id = '"
								+ jobids[j] + "' and org_id ='" + orgid + "'";
						dbl.executeSelect(sql);
						if (dbl.size() == 0) {

							String sqlins = "insert into td_sm_userjoborg(user_id,job_id,org_id,SAME_JOB_USER_SN,JOB_SN,JOB_STARTTIME,JOB_FETTLE) "
									+ "values("
									+ id
									+ ",'"
									+ jobids[j]
									+ "','"
									+ orgid
									+ "','"
									+ sjus
									+ "','"
									+ js
									+ "',"
									+ DBUtil.getDBDate(new Date()) + ",1)";

							db.executeInsert(sqlins);
						}
					}

				}
			}
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 批量用户移出机构
	 * 
	 * @param ids
	 * @param jobid
	 * @param orgId
	 * @throws ManagerException
	 */
	public void delAlotUserOrg(String[] ids, String[] jobids, String orgId)
			throws ManagerException {

		DBUtil dbl = new DBUtil();
		DBUtil db2 = new DBUtil();
		TransactionManager tm = new TransactionManager();
		try {
			if (ids != null && jobids != null) {
				tm.begin();
				for (int i = 0; i < ids.length; i++)
					for (int j = 0; j < jobids.length; j++) {
						int id = Integer.parseInt(ids[i]);
						String sqlselect = "select * from TD_SM_USERJOBORG where job_id ='"
								+ jobids[j]
								+ "' and"
								+ " org_id ='"
								+ orgId
								+ "' and user_id =" + id + "";
						String sql = "delete from td_sm_userjoborg where user_id = "
								+ id
								+ " and job_id = '"
								+ jobids[j]
								+ "' and org_id ='" + orgId + "'";
						db2.executeSelect(sqlselect);
						for (int k = 0; k < db2.size(); k++) {
							int userid = db2.getInt(k, "user_id");
							String jid = db2.getString(k, "JOB_ID");
							String oid = db2.getString(k, "ORG_ID");
							Date starttime = db2.getDate(k, "JOB_STARTTIME");
							String sql2 = "insert into TD_SM_USERJOBORG_HISTORY values("
									+ userid
									+ ",'"
									+ jid
									+ "',"
									+ "'"
									+ oid
									+ "',"
									+ DBUtil.getDBDate(starttime)
									+ ","
									+ "" + DBUtil.getDBDate(new Date()) + ",0)";

							db2.executeInsert(sql2);
						}

						dbl.executeDelete(sql);
					}
				tm.commit();

			}

			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);

		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

	}

	public String addUser(User user) throws ManagerException {
		return addUser(user, true);
	}

	public String addUser(User user, boolean isEvent) throws ManagerException {
		// DBUtil db = new DBUtil();
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		TransactionManager tm = new TransactionManager();
		String userId = null;
		if (user != null) {
			StringBuffer hsql = new StringBuffer();
			try {
				tm.begin();
				userId = String.valueOf(preparedDBUtil
						.getNextPrimaryKey(EgpManager.getEgpDBName(),"td_sm_user"));
				hsql
						.append(
								"insert into TD_SM_USER(USER_ID,USER_SN, USER_NAME, USER_PASSWORD, ")
						.append(
								"USER_REALNAME, USER_PINYIN, USER_SEX, USER_HOMETEL, USER_WORKTEL, ")
						.append(
								"USER_WORKNUMBER, USER_MOBILETEL1, USER_MOBILETEL2, USER_FAX, ")
						.append(
								"USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS, USER_POSTALCODE, ")
						.append(
								"USER_IDCARD, USER_ISVALID, USER_REGDATE, USER_LOGINCOUNT, USER_TYPE, ")
						.append(
								"REMARK1, REMARK2, REMARK3, REMARK4, REMARK5, PAST_TIME, DREDGE_TIME, ISTAXMANAGER, WORKLENGTH, POLITICS,CERT_SN) ")
						.append(" values(?,?,?,?,").append("?,?,?,?,?,")
						.append("?,?,?,?,").append("?,?,?,?,?,").append(
								"?,?,?,?,?,").append("?,?,?,?,?,?,?,?,?,?,?)");
				preparedDBUtil.preparedInsert(EgpManager.getEgpDBName(),hsql.toString());

				preparedDBUtil.setString(1, userId);
				preparedDBUtil.setInt(2, user.getUserSn().intValue());
				preparedDBUtil.setString(3, user.getUserName());
				preparedDBUtil.setString(4, user.getUserPassword());
				preparedDBUtil.setString(5, user.getUserRealname());
				preparedDBUtil.setString(6, user.getUserPinyin() == null ? ""
						: user.getUserPinyin());
				preparedDBUtil.setString(7, user.getUserSex());
				preparedDBUtil.setString(8, user.getUserHometel() == null ? ""
						: user.getUserHometel());
				preparedDBUtil.setString(9, user.getUserWorktel() == null ? ""
						: user.getUserWorktel());
				preparedDBUtil.setString(10,
						user.getUserWorknumber() == null ? "" : user
								.getUserWorknumber());
				preparedDBUtil.setString(11,
						user.getUserMobiletel1() == null ? "" : user
								.getUserMobiletel1());
				preparedDBUtil.setString(12,
						user.getUserMobiletel2() == null ? "" : user
								.getUserMobiletel2());
				preparedDBUtil.setString(13, user.getUserFax() == null ? ""
						: user.getUserFax());
				preparedDBUtil.setString(14, user.getUserOicq() == null ? ""
						: user.getUserOicq());
				if (user.getUserBirthday() != null) {
					preparedDBUtil.setTimestamp(15, new Timestamp(user
							.getUserBirthday().getTime()));
				} else {
					preparedDBUtil.setNull(15, java.sql.Types.TIMESTAMP);
				}
				preparedDBUtil.setString(16, user.getUserEmail() == null ? ""
						: user.getUserEmail());
				preparedDBUtil.setString(17, user.getUserAddress() == null ? ""
						: user.getUserAddress());
				preparedDBUtil.setString(18,
						user.getUserPostalcode() == null ? "" : user
								.getUserPostalcode());
				preparedDBUtil.setString(19, user.getUserIdcard() == null ? ""
						: user.getUserIdcard());
				preparedDBUtil.setInt(20, user.getUserIsvalid().intValue());
				if (user.getUserRegdate() != null) {
					preparedDBUtil.setTimestamp(21, new Timestamp(user
							.getUserRegdate().getTime()));
				} else {
					preparedDBUtil.setNull(21, java.sql.Types.TIMESTAMP);
				}
				preparedDBUtil.setInt(22, user.getUserLogincount().intValue());
				preparedDBUtil.setString(23, user.getUserType() == null ? ""
						: user.getUserType());
				preparedDBUtil.setString(24, user.getRemark1() == null ? ""
						: user.getRemark1());
				preparedDBUtil.setString(25, user.getRemark2() == null ? ""
						: user.getRemark2());
				preparedDBUtil.setString(26, user.getRemark3() == null ? ""
						: user.getRemark3());
				preparedDBUtil.setString(27, user.getRemark4() == null ? ""
						: user.getRemark4());
				preparedDBUtil.setString(28, user.getRemark5() == null ? ""
						: user.getRemark5());
				// preparedDBUtil.setString(29, user.getPast_Time() == null ? ""
				// : user.getPast_Time());
				preparedDBUtil.setNull(29, java.sql.Types.TIMESTAMP);
				preparedDBUtil.setString(30, user.getDredgeTime() == null ? ""
						: user.getDredgeTime());
				preparedDBUtil.setInt(31, user.getIstaxmanager());
				preparedDBUtil.setString(32, user.getWorklength() == null ? ""
						: user.getWorklength());
				preparedDBUtil.setString(33, user.getPolitics() == null ? ""
						: user.getPolitics());
				preparedDBUtil.setString(34, user.getCretSn()==null ? "" : user.getCretSn());
				preparedDBUtil.executePrepared();

				// hsql.append("insert into TD_SM_USER(USER_SN, USER_NAME,
				// USER_PASSWORD, ")
				// .append("USER_REALNAME, USER_PINYIN, USER_SEX, USER_HOMETEL,
				// USER_WORKTEL, ")
				// .append("USER_WORKNUMBER, USER_MOBILETEL1, USER_MOBILETEL2,
				// USER_FAX, ")
				// .append("USER_OICQ, USER_BIRTHDAY, USER_EMAIL, USER_ADDRESS,
				// USER_POSTALCODE, ")
				// .append("USER_IDCARD, USER_ISVALID, USER_REGDATE,
				// USER_LOGINCOUNT, USER_TYPE, ")
				// .append("REMARK1, REMARK2, REMARK3, REMARK4, REMARK5,
				// PAST_TIME, DREDGE_TIME, ISTAXMANAGER, WORKLENGTH, POLITICS)
				// ")
				// .append("values('")
				// .append(user.getUserSn())
				// .append("', '")
				// .append(user.getUserName())
				// .append("', '")
				// .append(user.getUserPassword())
				// .append("', '")
				// .append(user.getUserRealname())
				// .append("', '")
				// .append(user.getUserPinyin() == null ? "" :
				// user.getUserPinyin())
				// .append("', '")
				// .append(user.getUserSex())
				// .append("', '")
				// .append(user.getUserHometel() == null ? "" :
				// user.getUserHometel())
				// .append("', '")
				// .append(user.getUserWorktel() == null ? "" :
				// user.getUserWorktel())
				// .append("', '")
				// .append(user.getUserWorknumber() == null ? "" :
				// user.getUserWorknumber())
				// .append("', '")
				// .append(user.getUserMobiletel1() == null ? "" :
				// user.getUserMobiletel1())
				// .append("', '")
				// .append(user.getUserMobiletel2() == null ? "" :
				// user.getUserMobiletel2())
				// .append("', '")
				// .append(user.getUserFax() == null ? "" : user.getUserFax())
				// .append("', '")
				// .append(user.getUserOicq() == null ? "" : user.getUserOicq())
				// .append("', ")
				// .append(String.valueOf(user.getUserBirthday()) == "null" ?
				// "''"
				// : DBUtil.getDBDate(user.getUserBirthday().toString()))
				// .append(", '")
				// .append(user.getUserEmail() == null ? "" :
				// user.getUserEmail())
				// .append("', '")
				// .append(user.getUserAddress() == null ? "" : user
				// .getUserAddress())
				// .append("', '")
				// .append(user.getUserPostalcode() == null ? "" :
				// user.getUserPostalcode())
				// .append("', '")
				// .append(user.getUserIdcard() == null ? "" :
				// user.getUserIdcard())
				// .append("', '")
				// .append(user.getUserIsvalid())
				// .append("', ")
				// .append(String.valueOf(user.getUserRegdate()) == "null" ?
				// "''": DBUtil.getDBDate(user.getUserRegdate().toString()))
				// .append(", '").append(user.getUserLogincount()).append("',
				// '")
				// .append(user.getUserType() == null ? "" :
				// user.getUserType()).append("', '")
				// .append(user.getRemark1() == null ? "" :
				// user.getRemark1()).append("', '")
				// .append(user.getRemark2() == null ? "" :
				// user.getRemark2()).append("', '")
				// .append(user.getRemark3() == null ? "" :
				// user.getRemark3()).append("', '")
				// .append(user.getRemark4() == null ? "" :
				// user.getRemark4()).append("', '")
				// .append(user.getRemark5() == null ? "" :
				// user.getRemark5()).append("', '")
				// .append(user.getPast_Time() == null ? "" :
				// user.getPast_Time()).append("', '")
				// .append(user.getDredgeTime() == null ? "" :
				// user.getDredgeTime()).append("', '")
				// .append(user.getIstaxmanager()).append("', '")
				// .append(user.getWorklength() == null ? "" :
				// user.getWorklength()).append("', '")
				// .append(user.getPolitics() == null ? "" :
				// user.getPolitics()).append("')");
				// Object ob = db.executeInsert(hsql.toString());
				// 得到主键
				// userId = String.valueOf(ob);
				
				//添加 人员sn关联表信息 	TransactionManager tm = new TransactionManager();
				UserAndSn userAndSn = user.getUserAndSn();
				if(null != userAndSn) {
				userAndSn.setUserid(userId);
				userAndSn.setMobile_sn(user.getMobileSn());
				UserAndSnImpl userAndSnImpl = new  UserAndSnImpl();
				userAndSnImpl.addUserAndSn(userAndSn); 
				}
				
				tm.commit();
				if (isEvent) {
					Event event = new EventImpl(userId,
							ACLEventType.USER_INFO_ADD);
					super.change(event);
				}
			} catch (SQLException e1) {
				try {
					tm.rollback();
				} catch (RollbackException e) {
					e.printStackTrace();
				}
				e1.printStackTrace();
				throw new ManagerException(e1.getMessage());
			} catch (RollbackException e) {
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			} catch (TransactionException e) {
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			}

		}
		return userId;
	}

	public boolean updateUser(User user) throws ManagerException {
		boolean state = false;
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();
		String riqi = formatter.format(currentTime);
		StringBuffer sql=new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		
		TransactionManager tm = new TransactionManager();
		if (user != null) {
			try {
					tm.begin();
				// 检查当前用户实例是否来自LDAP，因为LDAP中的用户ID(UID)是采用用户名标识其唯一性
				// if (user.getUserId() != null
				// && user.getUserId().intValue() == -1) {
				// User oldUser = getUser("userName", user.getUserName());
				// if (oldUser == null)
				// user.setUserId(null);
				// else {
				//
				// user.setUserId(oldUser.getUserId());
				// String oldpassword = StringUtil.replaceNull(oldUser
				// .getUserPassword());
				// String newpassword = StringUtil.replaceNull(user
				// .getUserPassword());
				// if (!oldpassword.equals(EncrpyPwd
				// .encodePassword(newpassword)))
				// user.setUserPassword(EncrpyPwd
				// .encodePassword(newpassword));
				//
				// }
				//
				// } else {
				// String password = StringUtil.replaceNull(user
				// .getUserPassword());
				// user.setUserPassword(EncrpyPwd.encodePassword(password));
				// }
				String userBirthday = null;
				try {
					if (null != user.getUserBirthday()) {
						userBirthday = "to_date('"
								+ formatter.format(user.getUserBirthday())
										.toString()
								+ "','yyyy-mm-dd hh24:mi:ss')";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				String userRegdate = null;
				try {
					if (null != user.getUserRegdate()) {
						userRegdate = "to_date('"// modify by wen.zhu
						// //userBirthday = "'"
								+ formatter.format(user.getUserRegdate())
										.toString()
								+ "','yyyy-mm-dd hh24:mi:ss')";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				StringBuffer hsql = new StringBuffer();
				hsql
						.append("update TD_SM_USER set USER_REALNAME='")
						.append(user.getUserRealname())
						.append("', ")
						// .append("USER_PASSWORD='").append(user.getUserPassword()).append("',
						// ")
						.append("USER_IDCARD='").append(
								user.getUserIdcard() == null ? "" : user
										.getUserIdcard()).append("', ").append(
								"USER_WORKTEL='").append(
								user.getUserWorktel() == null ? "" : user
										.getUserWorktel()).append("', ")
										
						.append("USER_SEX='").append(user.getUserSex()).append(
								"', ").append("USER_HOMETEL='").append(
								user.getUserHometel() == null ? "" : user
										.getUserHometel()).append("', ")
						.append("USER_EMAIL='").append(
								user.getUserEmail() == null ? "" : user
										.getUserEmail()).append("', ").append(
								"USER_MOBILETEL1='").append(
								user.getUserMobiletel1() == null ? "" : user
										.getUserMobiletel1()).append("', ")
						.append("USER_MOBILETEL2='").append(
								user.getUserMobiletel2() == null ? "" : user
										.getUserMobiletel2()).append("', ")
						.append("REMARK4='").append(
								user.getRemark4() == null ? "" : user
										.getRemark4()).append("', ").append(
								"REMARK5='").append(
								user.getRemark5() == null ? "" : user
										.getRemark5()).append("', ").append(
								"USER_PINYIN='").append(
								user.getUserPinyin() == null ? "" : user
										.getUserPinyin()).append("', ").append(
								"USER_TYPE='").append(user.getUserType())
						.append("', ").append("USER_POSTALCODE='").append(
								user.getUserPostalcode() == null ? "" : user
										.getUserPostalcode()).append("', ")
						.append("USER_FAX='").append(
								user.getUserFax() == null ? "" : user
										.getUserFax()).append("', ").append(
								"USER_OICQ='").append(
								user.getUserOicq() == null ? "" : user
										.getUserOicq()).append("', ").append(
								"USER_BIRTHDAY=").append(userBirthday).append(
								", ").append("USER_ADDRESS='").append(
								user.getUserAddress() == null ? "" : user
										.getUserAddress()).append("', ")
						.append("USER_ISVALID=").append(user.getUserIsvalid())
						.append(", ").append("DREDGE_TIME='").append(
								user.getUserIsvalid().intValue() == 2 ? riqi
										: "尚未开通").append("', ").append(
								"USER_REGDATE=").append(userRegdate).append(
								", ").append("USER_SN=").append(
								user.getUserSn()).append(", ").append(
								"REMARK3='").append(
								user.getRemark3() == null ? "" : user.getRemark3()).append("', ")
								.append("REMARK2='").append(user.getRemark2() == null ? "" : user.getRemark2()).append("', ")
								.append("ISTAXMANAGER=").append(user.getIstaxmanager())
								.append(", CERT_SN='").append(user.getCretSn() == null ? "" : user.getCretSn()).append("'")
								.append(" ").append("where USER_ID=").append(
								user.getUserId()).append("");
				DBUtil db = new DBUtil();
				db.executeUpdate(EgpManager.getEgpDBName(), hsql.toString());

				// 同步所有应用的数据 add by minghua.guo 2010-6-22
				// String appid = AppIdThreadLocal.get();
				// if ("module".equals(appid)) {
				OrgUserManager.appUserUpdSynchronizer(user);
				// }
				StringBuffer sql1=new StringBuffer();
				sql1.append("");
				sql1.append(" select * from ta_oa_userandsn  t ");
				sql1.append(" where t.userid= ? ");
				pdb.preparedSelect(sql1.toString());
				pdb.setString(1, user.getUserId().toString());
				pdb.executePrepared();
				/*if(pdb.size()>0){
        				//更新手机sn和用户表
        				sql.append(" update ta_oa_userandsn t set t.mobile_sn= ? ");
        				sql.append(" where t.userid= ? ");
        				pdb.preparedUpdate(sql.toString());
        				pdb.setString(1, user.getMobileSn());
        				pdb.setString(2, user.getUserId().toString());
        				pdb.executePrepared();
				}else{
				    	StringBuffer sql2=new StringBuffer();
				    	sql2.append(" insert into ta_oa_userandsn ");
					sql2.append("  (id, userid, mobile_sn) ");
					sql2.append(" values ");
					sql2.append(" (seq_oa_userandsn.nextval, ?, ?)");
					pdb.preparedInsert(sql2.toString());
					pdb.setString(1, user.getUserId().toString());
					pdb.setString(2, user.getMobileSn());
					pdb.executePrepared();
				}*/  
				if(pdb.size()>0){
				//修改 人员sn关联表信息 	
				UserAndSn userAndSn = user.getUserAndSn();
				userAndSn.setUserid(user.getUserId().toString());
				userAndSn.setMobile_sn(user.getMobileSn());
				UserAndSnImpl userAndSnImpl = new  UserAndSnImpl();
				userAndSnImpl.updateUserAndSn(userAndSn);
				}else{
					//添加 人员sn关联表信息 	TransactionManager tm = new TransactionManager();
					UserAndSn userAndSn = user.getUserAndSn();
					if(null != userAndSn) {
					userAndSn.setUserid(user.getUserId().toString());
					userAndSn.setMobile_sn(user.getMobileSn());
					UserAndSnImpl userAndSnImpl = new  UserAndSnImpl();
					userAndSnImpl.addUserAndSn(userAndSn);
					}
				}
				
				
				state = true;
				Event event = new EventImpl(user.getUserId().toString(),
						ACLEventType.USER_INFO_CHANGE);
				try {
					tm.commit();
				} catch (RollbackException e) {
					
					e.printStackTrace();
				}
				super.change(event);
			}catch (TransactionException e1) {
				try {
					tm.rollback();
				} catch (RollbackException e) {
					
					e.printStackTrace();
				}
				e1.printStackTrace();
			} catch (SQLException e) {
			    	state =false;
				e.printStackTrace();
			} 

		}
		return state;
	}

	public boolean updateUserPassword(User user) throws ManagerException {
		boolean state = false;
		if (user != null) {
			StringBuffer hsql = new StringBuffer();
			hsql.append("update TD_SM_USER set USER_PASSWORD='").append(
					EncrpyPwd.encodePassword(user.getUserPassword())).append(
					"' where ").append("USER_ID=").append(user.getUserId())
					.append("");
			DBUtil db = new DBUtil();
			try {
				db.executeUpdate(EgpManager.getEgpDBName(),hsql.toString());
				OrgUserManager.appUserPwdUpdSynchronizer(user);
				state = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return state;
	}

	public boolean addUserOrg(String[] userIds, String orgId, String classType)
			throws ManagerException {
		boolean state = false;
		DBUtil db = new DBUtil();
		int samesn = 1;
		if ("lisan".equals(classType)) {
			try {
				// 如果是离散用户，当前机构设为它的主机构
				OrgManager orgmanager = SecurityDatabase.getOrgManager();

				for (int i = 0; i < userIds.length; i++) {
					DBUtil dbUtil = new DBUtil();
					String mainsql = "select * from td_sm_orguser where org_Id='"
							+ orgId + "' and user_id=" + userIds[i];
					dbUtil.executeSelect(mainsql);
					if (dbUtil.size() > 0) {
						continue;
					} else {
						orgmanager.addMainOrgnazitionOfUser(userIds[i], orgId);
					}
				}
			} catch (SPIException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		// 往td_sm_userjoborg表中插入记录
		try {
			for (int j = 0; j < userIds.length; j++) {
				String sqlsn = "select max(same_job_user_sn) as sn from  td_sm_userjoborg"
						+ " where  org_id ='" + orgId + "'";
				String sql2 = "select * from td_sm_userjoborg where user_id="
						+ userIds[j] + " and org_id='" + orgId
						+ "' and job_id='1'";
				db.executeSelect(sql2);
				DBUtil dbutil = new DBUtil();
				dbutil.executeSelect(sqlsn);
				if (db.size() > 0) {
					continue;
				} else {
					if (dbutil != null && dbutil.getInt(0, 0) > 0) {
						samesn = dbutil.getInt(0, "sn") + 1;
						String sql = "insert into td_sm_userjoborg"
								+ " (user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)"
								+ " values(" + userIds[j] + ",'" + 1 + "','"
								+ orgId + "'," + 999 + "," + samesn
								+ ",SYSDATE,1)";
						db.executeInsert(sql);
					} else {
						samesn = 1;
						String sql = "insert into td_sm_userjoborg"
								+ "(user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)"
								+ " values(" + userIds[j] + ",'" + 1 + "','"
								+ orgId + "'," + 999 + "," + samesn
								+ ",SYSDATE,1)";
						db.executeInsert(sql);
					}
				}
			}
			Event event = new EventImpl("", ACLEventType.USER_INFO_CHANGE);
			
			super.change(event);
			state = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/**
	 * 批量插入用户主管机构与用户机构岗位
	 * 
	 * @param userIds
	 * @param orgIds
	 * @param isInsert
	 *            为true时插入主机构关系
	 * @return
	 * @throws ManagerException
	 */
	public boolean storeBatchUserOrg(String[] userIds, String[] orgIds,
			boolean isInsert) throws ManagerException {
		boolean state = false;
		StringBuffer sql;
		StringBuffer sql2;
		DBUtil dbUtil = new DBUtil();
		DBUtil db = new DBUtil();
		TransactionManager tm = new TransactionManager();
		PreparedDBUtil selete_preparedDBUtil = new PreparedDBUtil();
		PreparedDBUtil insert_preparedDBUtil = new PreparedDBUtil();

		StringBuffer selete_sql = new StringBuffer();
		selete_sql
				.append("select count(ORG_ID) as totalsize from TD_SM_ORGUSER where USER_ID=?");
		StringBuffer insert_sql = new StringBuffer();
		insert_sql
				.append("insert into TD_SM_ORGUSER(USER_ID, ORG_ID) values (?,?)");

		try {
			tm.begin();
			if (isInsert) {
				for (int j = 0; j < userIds.length; j++) {
					selete_preparedDBUtil.preparedSelect(selete_sql.toString());
					selete_preparedDBUtil.setString(1, userIds[j]);
					selete_preparedDBUtil.executePrepared();

					if (null != selete_preparedDBUtil
							&& selete_preparedDBUtil.getInt(0, 0) <= 0) {
						insert_preparedDBUtil.preparedInsert(insert_sql
								.toString());
						insert_preparedDBUtil.setString(1, userIds[j]);
						insert_preparedDBUtil.setString(2, orgIds[0]);
						insert_preparedDBUtil.addPreparedBatch();
						insert_preparedDBUtil.executePreparedBatch();
					}

					// sql = new StringBuffer();
					// sql
					// .append(
					// "insert all when totalsize <= 0 then into TD_SM_ORGUSER(USER_ID, ORG_ID) values('")
					// .append(userIds[j]).append("', '")
					// .append(orgIds[0]).append(
					// "') select count(ORG_ID) totalsize ")
					// .append(" from TD_SM_ORGUSER where USER_ID = '")
					// .append(userIds[j]).append("' ");
					// dbUtil.addBatch(sql.toString());

				}
			}

			for (int i = 0; i < orgIds.length; i++) {
				for (int j = 0; j < userIds.length; j++) {
					sql2 = new StringBuffer();
					String sql3 = "select * from td_sm_userjoborg where user_id='"
							+ userIds[j] + "' and org_id='" + orgIds[i] + "'";
					db.executeSelect(sql3);
					if (db.size() > 0) {
						continue;
					}
					sql2
							.append("insert into td_sm_userjoborg")
							.append(
									"(user_id,job_id,org_id,JOB_SN,SAME_JOB_USER_SN,JOB_STARTTIME,JOB_FETTLE)")
							.append(" values(").append(userIds[j]).append(",'")
							.append(1).append("','").append(orgIds[i]).append(
									"',").append(999).append(",").append(1)
							.append(",").append(DBUtil.getDBDate(new Date()))
							.append(",1)");

					dbUtil.addBatch(sql2.toString());
				}
			}
			dbUtil.executeBatch();
			tm.commit();
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
			state = true;
		} catch (SQLException e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			dbUtil.resetBatch();
		}
		return state;
	}

	/**
	 * 删除离散用户的主机构关系td_sm_orguser。。。。。。。。
	 * 
	 * @return
	 */
	public boolean deleteDisperseOrguser() {
		boolean state = false;
		DBUtil db = new DBUtil();
		String sql = "delete td_sm_orguser where user_id not in(select user_id from td_sm_userjoborg)";
		try {
			db.executeDelete(sql);
			state = true;
			Event event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/**
	 * 根据用户id判断是否为税管员
	 * 
	 * @param userId
	 * @return
	 */
	public boolean isTaxmanager(String userId) throws ManagerException {
		boolean state = false;
		DBUtil dbUtil = new DBUtil();
		String sql = "select t.istaxmanager from td_sm_user t where t.user_id='"
				+ userId + "'";
		try {
			dbUtil.executeSelect(sql);
			int i = dbUtil.getInt(0, "istaxmanager");
			if (i == 1) {
				state = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/**
	 * 判断机构下是否有用户
	 * 
	 * @param org
	 * @return
	 * @throws ManagerException
	 */
	public boolean isContainUser(Organization org) throws ManagerException {
		boolean state = false;
		String sql = "select count(*) from td_sm_orguser where org_id='"
				+ org.getOrgId() + "'";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.getInt(0, 0) > 0) {
				state = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.UserManager#userOrgInfo(java.lang
	 * .String) 删除 和 调动 用户的时候, 判断用户的机构信息, 决定是否能执行 删除和调动操作. 如果返回为空, 可以删除 和 调动 用户,
	 * 否则不允许删除.
	 */
	public String userOrgInfo(AccessControl control, String userId) {
		// 如果是超级管理员或者时部门管理员， 都不允许删除。
		String checkMessage = "";
		List list = PurviewManagerImpl.getBussinessCheck().userDeleteCheck(
				control, userId);
		if (list == null || list.size() == 0) {
			return "";
		}
		for (int i = 0; i < list.size(); i++) {
			if ("".equals(checkMessage)) {
				checkMessage = (String) list.get(i);
			} else {
				checkMessage += "," + (String) list.get(i);
			}
		}
		// OrgManagerImpl orgImpl = new OrgManagerImpl();
		//		
		// //判断是否部门管理员
		// List managerOrgs = orgImpl.getUserManageOrgs(userId);
		// if(control.isAdminByUserid(userId)){//是超级管理员
		// return "超级管理员" ;
		// }else if( managerOrgs != null && managerOrgs.size() > 0){//是部门管理员
		// return "部门管理员";
		// }else{
		// String userInfos = "";
		// StringBuffer sql = new StringBuffer();
		// sql.append("select * from
		// table(f_getTaskByUser(").append(userId).append("))");
		// DBUtil db = new DBUtil();
		// try {
		// db.executeSelect(sql.toString());
		// for(int i=0; i<db.size(); i++){
		// if("".equalsIgnoreCase(userInfos)){
		// userInfos += db.getString(i,0);
		// }else{
		// userInfos += "," + db.getString(i,0);
		// }
		// }
		// } catch (SQLException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		return checkMessage;
	}

	public String getUserMainOrgId(String userId) {
		String sql = " select * from td_sm_orguser where user_id='" + userId
				+ "'";
		DBUtil db = new DBUtil();
		String orgId = "";
		try {
			db.executeSelect(sql);
			orgId = db.getString(0, "org_id");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orgId;
	}

	public String[] getCuruserAdministrableDeleteUser(String curUserId,
			String[] selectUserNames) {
		String[] userNames = null;
		if (selectUserNames == null)
			return null;
		// 得到用户管理员管理表
		StringBuffer selectUserName = new StringBuffer();
		boolean flag = false;
		for (int count = 0; count < selectUserNames.length; count++) {
			if (!flag) {
				selectUserName.append("'").append(selectUserNames[count])
						.append("'");
				flag = true;
			} else {
				selectUserName.append(",'").append(selectUserNames[count])
						.append("'");
			}
		}
		String orgmanager_sql = "select org_id from td_sm_orgmanager where user_id='"
				+ curUserId + "'";
		StringBuffer user_sql = new StringBuffer().append(
				"select u.USER_NAME from td_sm_orguser ou,td_sm_user u ")
				.append("where u.user_id = ou.user_id and u.user_name in (")
				.append(selectUserName.toString()).append(
						") and ou.ORG_ID in (").append(
						"SELECT DISTINCT org_id ").append(
						"FROM td_sm_organization START WITH org_id IN (")
				.append(orgmanager_sql).append(
						") CONNECT BY PRIOR org_id = parent_id)");
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(user_sql.toString());
			if (db.size() > 0) {
				userNames = new String[db.size()];
				for (int i = 0; i < db.size(); i++) {
					userNames[i] = db.getString(i, "user_name");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userNames;
	}

	public String newUserLoginSn(String orgId) {
		String newUserLoginSn = "";
		String sql = "select substr(o.org_xzqm,0,6) as  org_xzqm from td_sm_organization o where o.org_id = '" + orgId + "'";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.size() > 0) {
				newUserLoginSn = db.getString(0, "org_xzqm");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return newUserLoginSn;
	}
	public static void main(String[] args) {
		UserManagerImpl userImpl = new UserManagerImpl();
		// User user;
		// try {
		// user = userImpl.getUserById("1277");
		// user.setUserSn(Integer.valueOf("110"));
		// user.setUserName("yubianyi");
		// user.setUserRealname("预编译");
		// user.setUserSex("F");
		// user.setUserPassword("123456");
		// userImpl.addUser(user);
		// System.out.println("添加用户成功！ " + user.getUserRealname());
		// } catch (ManagerException e) {
		// e.printStackTrace();
		// }
		String[] groupid = { "41", "42" };
		try {
			userImpl.addUsergroup(new Integer(2659), groupid);
		} catch (ManagerException e) {
			e.printStackTrace();
		}

	}
}

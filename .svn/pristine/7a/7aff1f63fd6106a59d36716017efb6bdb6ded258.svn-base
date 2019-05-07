package com.chinacreator.sysmgrcore.manager.db;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.RollbackException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.frameworkset.event.Event;
import org.frameworkset.event.EventHandle;
import org.frameworkset.event.EventImpl;
import org.frameworkset.spi.SPIException;
import org.python.modules.newmodule;
import org.safehaus.uuid.UUIDGenerator;

import sun.java2d.opengl.OGLDrawImage;

import com.chinacreator.config.ConfigManager;
import com.chinacreator.epp.applymanager.dbmanager.OrgUserManager;
import com.chinacreator.epp.util.AppIdThreadLocal;
import com.chinacreator.epp.util.EgpManager;
import com.chinacreator.epp.util.orgusertb.OrgNameThreadLocal;
import com.chinacreator.security.AccessControl;
import com.chinacreator.security.authorization.AuthPrincipal;
import com.chinacreator.security.event.ACLEventType;
import com.chinacreator.sqltransition.api.factorys.RecursiveQueryFactory;
import com.chinacreator.sqltransition.api.interfaces.IRecursiveQuery;
import com.chinacreator.sysmgrcore.control.DataControl;
import com.chinacreator.sysmgrcore.control.PageConfig;
import com.chinacreator.sysmgrcore.entity.ChargeOrg;
import com.chinacreator.sysmgrcore.entity.Group;
import com.chinacreator.sysmgrcore.entity.Job;
import com.chinacreator.sysmgrcore.entity.Organization;
import com.chinacreator.sysmgrcore.entity.Orggroup;
import com.chinacreator.sysmgrcore.entity.Orgjob;
import com.chinacreator.sysmgrcore.entity.Orgrole;
import com.chinacreator.sysmgrcore.entity.Role;
import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.sysmgrcore.exception.ManagerException;
import com.chinacreator.sysmgrcore.manager.JobManager;
import com.chinacreator.sysmgrcore.manager.OrgManager;
import com.chinacreator.sysmgrcore.manager.SecurityDatabase;
import com.chinacreator.sysmgrcore.manager.UserManager;
import com.chinacreator.sysmgrcore.manager.entity.OrgAndTypeBean;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.common.poolman.SQLParams;
import com.frameworkset.common.tag.pager.ListInfo;
import com.frameworkset.orm.transaction.TransactionException;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * 项目：SysMgrCore <br>
 * 描述：机构管理实现类 <br>
 * 版本：1.0 <br>
 * 
 * @author 吴卫雄
 */
public class OrgManagerImpl extends EventHandle implements OrgManager {

	private DataControl cb = DataControl
			.getInstance(DataControl.CONTROL_INSTANCE_DB);

	private static Logger logger = Logger.getLogger(OrgManagerImpl.class
			.getName());

	public boolean deleteOrg(Organization org) throws ManagerException {
		deleteOrgAndType(org.getOrgId());
		return deleteOrg(org.getOrgId());
	}

	public boolean deleteOrg(String orgId) throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		deleteOrgAndType(orgId);
		/**
		 * 获取迭代查询 彭盛 2010-4-27
		 */
		IRecursiveQuery iRecursiveQuery = RecursiveQueryFactory
				.getIRecursiveQueryInstance();
		List list = new ArrayList();
		list = iRecursiveQuery.query("TD_SM_ORGANIZATION",
				new String[] { "org_id" }, "org_id", "=", "'" + orgId + "'",
				"PARENT_ID", "", IRecursiveQuery.DOWN);

		// 删除机构表的基本数据
		StringBuffer sql = new StringBuffer()
				.append("delete from TD_SM_ORGANIZATION where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH ")
		// .append("t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 删除机构岗位用户表的基本数据
		StringBuffer sql1 = new StringBuffer()
				.append("delete from TD_SM_USERJOBORG where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 删除机构岗位表的基本数据
		StringBuffer sql2 = new StringBuffer()
				.append("delete from TD_SM_ORGJOB where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 删除机构用户表的基本数据
		StringBuffer sql3 = new StringBuffer()
				.append("delete from TD_SM_ORGUSER where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 删除机构角色表的基本数据
		StringBuffer sql4 = new StringBuffer()
				.append("delete from TD_SM_ORGROLE where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 递归删除机构自身资源操作的基本数据
		StringBuffer sql5 = new StringBuffer()
				.append("delete from TD_SM_ROLERESOP  where res_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append("t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID) and
		// restype_id='orgunit'");

		// 删除机构岗位角色表中的外键 gao.tang 2007.10.26
		// 删除了机构岗位角色表数据
		StringBuffer sql6 = new StringBuffer()
				.append("delete from TD_SM_ORGJOBROLE where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 删除机构与用户的部门管理员对应关系
		StringBuffer sql7 = new StringBuffer()
				.append("delete from td_sm_orgmanager where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");

		// 地税特有表TD_SM_TAXCODE_ORGANIZATION
		StringBuffer sql8 = new StringBuffer()
				.append("delete from TD_SM_TAXCODE_ORGANIZATION where org_id in (");
		// .append("(SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH")
		// .append(" t.org_id='").append(orgId)
		// .append("' CONNECT BY PRIOR t.org_id=t.PARENT_ID)");
		
		// 删除用户调动信息 彭盛 2011-4-15
		StringBuffer sql9 = new StringBuffer()
				.append("delete from td_sm_userchangeorg_data where  org_id in (");

		Map map = new HashMap();
		String orgid = "";
		for (int i = 0; i < list.size(); i++) {
			map = (Map) list.get(i);
			if (null != map) {
				orgid = (String) map.get("org_id");
				if (null != orgid && !orgid.trim().equals("")) {
					sql.append("'");
					sql1.append("'");
					sql2.append("'");
					sql3.append("'");
					sql4.append("'");
					sql5.append("'");
					sql6.append("'");
					sql7.append("'");
					sql8.append("'");
					sql9.append("'");

					sql.append(orgid);
					sql1.append(orgid);
					sql2.append(orgid);
					sql3.append(orgid);
					sql4.append(orgid);
					sql5.append(orgid);
					sql6.append(orgid);
					sql7.append(orgid);
					sql8.append(orgid);
					sql9.append(orgid);

					sql.append("',");
					sql1.append("',");
					sql2.append("',");
					sql3.append("',");
					sql4.append("',");
					sql5.append("',");
					sql6.append("',");
					sql7.append("',");
					sql8.append("',");
					sql9.append("',");
				}
			}
		}

		sql.append("'')");
		sql1.append("'')");
		sql2.append("'')");
		sql3.append("'')");
		sql4.append("'')");
		sql5.append("'') and restype_id='orgunit'");
		sql6.append("'')");
		sql7.append("'')");
		sql8.append("'')");
		sql9.append("'')");

		// 递归获取当前机构下的所有用户的ID
		// StringBuffer sql_user = new StringBuffer()
		// .append(
		// " select distinct b.USER_ID from TD_SM_USERJOBORG b where b.ORG_ID in
		// ( ")
		// .append(
		// "select distinct a.ORG_ID from TD_SM_ORGANIZATION a start with
		// a.ORG_ID = '")
		// .append(orgId).append(
		// "' connect by prior a.ORG_ID = a.PARENT_ID)");
		TransactionManager tm = new TransactionManager();
		try {
			// modify by wen.zhu
			Organization org = SecurityDatabase.getOrgManager().getOrgById(
					orgId);
			OrgNameThreadLocal.add(org.getOrgName());

			tm.begin();
			db.addBatch(sql1.toString());
			db.addBatch(sql2.toString());
			db.addBatch(sql3.toString());
			db.addBatch(sql4.toString());
			db.addBatch(sql5.toString());
			db.addBatch(sql6.toString());
			db.addBatch(sql8.toString());
			db.addBatch(sql9.toString());
			db.addBatch(sql7.toString());
			db.addBatch(sql.toString());
			db.executeBatch();
			// 同步所有应用的数据 add by minghua.guo 2010-6-22
			String appid = AppIdThreadLocal.get();
			if ("module".equals(appid)) {
				OrgUserManager.appOrgDelSynchronizer(orgId);
			}

			tm.commit();

			r = true;

			// 触发用户角色变化事件
			Event event = new EventImpl(orgId,
					ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event, true);
			// 触发用户角色变化事件
			Event event1 = new EventImpl(orgId,
					ACLEventType.ORGUNIT_INFO_DELETE);
			super.change(event1, true);

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
		return r;
	}

	/**
	 * 没有被使用的方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已注释掉
	 */
	public boolean deleteOrggroup(Orggroup orggroup) throws ManagerException {
		boolean r = false;

		// if (orggroup != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		// p.setObject(orggroup);
		//
		// if (cb.execute(p) != null)
		// r = true;
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		// Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		// super.change(event,true);
		return r;
	}

	public boolean deleteOrgjob(Orgjob orgjob) throws ManagerException {
		return deleteOrgjob(orgjob.getOrganization().getOrgId(),
				new String[] { orgjob.getJob().getJobId() });
	}

	/**
	 * 删除机构下的岗位 同时删除 机构的岗位的角色 机构的岗位的用户 job_id = 1 的在岗的岗位 不能删除
	 * 
	 * @param orgid
	 * @return
	 * @throws ManagerException
	 *             OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean deleteOrgjob(String orgid, String[] jobids)
			throws ManagerException {

		return deleteOrgjob(orgid, jobids, true);
	}

	public boolean deleteOrgjob(String orgid, String[] jobids, boolean sendEvent)
			throws ManagerException {
		boolean r = false;
		TransactionManager tm = new TransactionManager();
		DBUtil db = new DBUtil();
		try {

			if (jobids != null) {
				tm.begin();
				for (int i = 0; i < jobids.length; i++) {
					String jobid = jobids[i];
					if ("1".equalsIgnoreCase(jobid))
						continue;
					// 删除机构的岗位 td_sm_orgjob
					String orgjob_sql = "delete from td_sm_orgjob where org_id='"
							+ orgid + "' and job_id ='" + jobid + "'";
					// 删除机构的岗位的角色 TD_SM_ORGJOBROLE(机构-岗位-角色)
					String orgjobrole_sql = "delete from TD_SM_orgjobrole where org_id='"
							+ orgid + "' and job_id ='" + jobid + "'";
					// 删除机构的岗位的用户 TD_SM_USERJOBORG(机构-岗位-用户)
					String userjoborg_sql = "delete from TD_SM_userjoborg where org_id='"
							+ orgid + "' and job_id ='" + jobid + "'";

					db.addBatch(orgjob_sql);
					db.addBatch(orgjobrole_sql);
					db.addBatch(userjoborg_sql);

				}
				db.executeBatch();
				tm.commit();
				if (sendEvent) {
					Event event = new EventImpl("",
							ACLEventType.ORGUNIT_ROLE_CHANGE);
					super.change(event, true);
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}

		return r;
	}

	/**
	 * 递归删除机构下的岗位 同时递归删除 机构的岗位的角色 机构的岗位的用户 job_id = 1 的在岗的岗位 不能删除
	 * 
	 * @param orgid
	 * @return
	 * @throws ManagerException
	 *             OrgManagerImpl.java
	 * @author: da.wei
	 */
	public boolean deleteSubOrgjob(String orgid, String[] jobids)
			throws ManagerException {
		boolean r = false;
		if (jobids != null) {
			List subOrgList = this.getSubOrgList(orgid);
			if (subOrgList != null || subOrgList.size() > 0) {
				for (int i = 0; i < subOrgList.size(); i++) {
					this.deleteOrgjob(((Organization) subOrgList.get(i))
							.getOrgId(), jobids, false);
				}
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_ROLE_CHANGE);
				super.change(event, true);
			}
			r = true;
		}

		return r;
	}

	public List getSubOrgList(String orgId) throws ManagerException {
		List subOrgList = new ArrayList();
		try {
			String sql = "SELECT * FROM TD_SM_ORGANIZATION t "
					+ "START WITH t.org_id = '" + orgId + "' "
					+ "CONNECT BY PRIOR t.org_id = t.PARENT_ID";
			DBUtil db = new DBUtil();
			db.executeSelect(sql);
			subOrgList = this.dbutilToOrganziationList(db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return subOrgList;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteOrgjob(Organization org) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		//
		// // // 先删除用户岗位机构关系表中与指定机构对应的记录
		// // p.setObject("from Userjoborg ujo where ujo.id.orgId = '"
		// // + org.getOrgId() + "'");
		// // cb.execute(p);
		//
		// // 删除所关联的机构岗位
		// p.setObject("from Orgjob oj where oj.id.orgId = '" + org.getOrgId()
		// + "'");
		// cb.execute(p);
		//
		// r = true;
		//
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "delete td_sm_orgjob where org_id='" + org.getOrgId()
				+ "'";
		DBUtil db = new DBUtil();
		try {
			db.executeDelete(sql);
			r = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return r;
	}

	/**
	 * 根据字段名获得机构
	 */
	public Organization getOrg(String propName, String value)
			throws ManagerException {
		try {
			/*
			 * 危达 200711091121 修改数据连接
			 */
			if (propName == null || propName.equals("")) {
				return null;
			}
			if (propName.equalsIgnoreCase("orgid")) {
				propName = "org_id";
			}
			if (propName.equalsIgnoreCase("orgname")) {
				propName = "org_name";
			}
			String sql = "select * from td_sm_organization where " + propName
					+ "='" + value + "'";
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			return dbutilToOrganziation(dBUtil);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new ManagerException(e.getMessage());
		}
	}

	public Organization getOrgById(String orgId) throws ManagerException {
		try {
			String sql = "select * from td_sm_organization where ORG_ID='"
					+ orgId + "'";
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			return dbutilToOrganziation(dBUtil);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new ManagerException(e.getMessage());
		}
	}

	public Organization getOrgByName(String orgName) throws ManagerException {
		try {
			String sql = "select * from td_sm_organization where ORG_NAME='"
					+ orgName + "'";
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			return dbutilToOrganziation(dBUtil);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new ManagerException(e.getMessage());
		}
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public List getOrgList(String hql) throws ManagerException {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject(hql);
		//
		// List list = null;
		//
		// try {
		//
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		List list = null;
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(hql);
			list = dbutilToOrganziationList(db);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public List getOrgListBySql(String sql) throws ManagerException {
		DBUtil dbUtil = new DBUtil();
		try {
			dbUtil.executeSelect(sql);
			return this.dbutilToOrganziationList(dbUtil);
		} catch (SQLException e) {

			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}

		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject(hql);
		//
		// List list = null;
		//
		// try {
		//
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }

	}

	public List getOrgList() throws ManagerException {
		List list = null;
		try {
			String sql = "select * from td_sm_organization o where o.parent_id='0' order by o.org_sn asc";
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			list = this.dbutilToOrganziationList(dBUtil);
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 得到所有机构包括子机构
	 * 
	 * @return
	 * @throws ManagerException
	 */
	public List getAllOrgList(String orgId) throws ManagerException {
		List list = null;
		try {
			String sql = null;
			if (orgId == "" || orgId == null) {
				sql = "select * from td_sm_organization o order by o.org_sn asc";
			} else {
				sql = "select * from td_sm_organization o where o.org_id<>'"
						+ orgId + "' order by o.org_sn asc";
			}
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			list = this.dbutilToOrganziationList(dBUtil);
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		return list;
	}

	public List getRecursionAllOrgList(String orgId) throws ManagerException {
		List list = null;
		String orderColumn = ConfigManager.getInstance().getConfigValue(
				"sys.orgOrder.column") == null ? "org_sn" : ConfigManager
				.getInstance().getConfigValue("sys.orgOrder.column");
		try {
			String sql = null;
			if (orgId == "" || orgId == null) {
				sql = "select * from td_sm_organization org start with org.parent_id = '0' "
						+ " connect by prior org.org_id = org.parent_id order siblings by org."
						+ orderColumn;
			} else {
				sql = "select * from td_sm_organization org start with org.parent_id = ' "
						+ orgId
						+ "'"
						+ " connect by prior org.org_id = org.parent_id order siblings by org."
						+ orderColumn;
			}

			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			list = this.dbutilToOrganziationList(dBUtil);
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 没有被使用的方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
	 */
	public List getOrgList(Group group) throws ManagerException {
		List list = new ArrayList();

		// if (group != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from Organization org where org.orgId in ("
		// + "select og.id.orgId from Orggroup og where og.id.groupId = '"
		// + group.getGroupId()
		// + "') order by org.orgSn asc");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return list;
	}

	public List getOrgList(Job job) throws ManagerException {
		List list = null;

		// if (job != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from Organization org where org.orgId in ("
		// + "select oj.id.orgId from Orgjob oj where oj.id.jobId = '"
		// + job.getJobId() + "') order by org.orgSn asc");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		DBUtil db = new DBUtil();
		StringBuffer sql = new StringBuffer()
				.append(
						"select * from td_sm_organization where org_id in(select org_id from ")
				.append("td_sm_orgjob where job_id='").append(job.getJobId())
				.append("')").append(" order by ORG_SN asc");
		try {
			db.executeSelect(sql.toString());
			list = this.dbutilToOrganziationList(db);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public List getOrgList(User user) throws ManagerException {
		List list = null;

		// if (user != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from Organization org where org.orgId in ("
		// + "select ujo.id.orgId from Userjoborg ujo where ujo.id.userId = '"
		// + user.getUserId()
		// + "') order by org.orgSn asc");
		// list = (List) cb.execute(p);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (user != null) {
			StringBuffer sql = new StringBuffer()
					.append("select * from td_sm_organization where org_id in(")
					.append(
							"select org_id from td_sm_userjoborg where user_id=")
					.append(user.getUserId()).append(") order by ORG_SN asc ");
			DBUtil db = new DBUtil();
			try {
				db.executeSelect(sql.toString());
				list = dbutilToOrganziationList(db);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	/**
	 * 根据用户id获取用户的机构列表
	 * 
	 * @param userid
	 * @return
	 * @throws ManagerException
	 */
	public List getOrgListOfUser(String userid) throws ManagerException {
		List list = new ArrayList();

		if (userid != null) {
			try {

				String sql = "select * from td_sm_organization t "
						+ "where t.org_id in "
						+ "(select b.org_id from td_sm_userjoborg b where b.user_id = "
						+ userid + ") order by org_sn desc";
				DBUtil dBUtil = new DBUtil();
				// modify by minghua.guo
				dBUtil.executeSelect(EgpManager.getEgpDBName(), sql);
				return dbutilToOrganziationList(dBUtil);

			} catch (SQLException e) {

				throw new ManagerException(e.getMessage());
			} catch (Exception e) {

				throw new ManagerException(e.getMessage());
			}
		}

		return list;
	}

	/**
	 * 将dbutil中的数据封装成
	 * 
	 * @param dbUtil
	 * @return
	 * @throws SQLException
	 */
	private Organization dbutilToOrganziation(DBUtil dBUtil)
			throws SQLException {
		if (dBUtil.size() > 0) {

			Organization org = new Organization();
			org.setOrgId(dBUtil.getString(0, "ORG_ID"));
			org.setOrgSn(dBUtil.getString(0, "ORG_SN"));
			org.setOrgName(dBUtil.getString(0, "ORG_NAME"));
			org.setParentId(dBUtil.getString(0, "PARENT_ID"));
			org.setPath(dBUtil.getString(0, "PATH"));
			org.setLayer(dBUtil.getString(0, "LAYER"));
			org.setChildren(dBUtil.getString(0, "CHILDREN"));
			org.setCode(dBUtil.getString(0, "CODE"));
			org.setJp(dBUtil.getString(0, "JP"));
			org.setQp(dBUtil.getString(0, "QP"));
			// new Timestamp(doc.getOrdertime().getTime())
			if (dBUtil.getDate(0, "CREATINGTIME") != null) {
				org.setCreatingtime(new java.sql.Date(dBUtil.getDate(0,
						"CREATINGTIME").getTime()));
			}
			org.setCreator(dBUtil.getString(0, "CREATOR"));
			org.setOrgnumber(dBUtil.getString(0, "ORGNUMBER"));
			org.setOrgdesc(dBUtil.getString(0, "ORGDESC"));
			org.setRemark1(dBUtil.getString(0, "REMARK1"));
			org.setRemark2(dBUtil.getString(0, "REMARK2"));
			org.setRemark3(dBUtil.getString(0, "REMARK3"));
			org.setRemark4(dBUtil.getString(0, "REMARK4"));
			org.setRemark5(dBUtil.getString(0, "REMARK5"));

			org.setChargeOrgId(dBUtil.getString(0, "CHARGEORGID"));
			org.setSatrapJobId(dBUtil.getString(0, "SATRAPJOBID"));

			org.setIspartybussiness(dBUtil.getString(0, "ISPARTYBUSSINESS"));

			org.setOrg_level(dBUtil.getString(0, "org_level"));
			org.setOrg_xzqm(dBUtil.getString(0, "org_xzqm"));

			org.setIsdirectlyparty(dBUtil.getString(0, "isdirectlyparty"));
			org.setIsforeignparty(dBUtil.getString(0, "isforeignparty"));
			org.setIsjichaparty(dBUtil.getString(0, "isjichaparty"));
			org.setIsdirectguanhu(dBUtil.getString(0, "isdirectguanhu"));

			return org;

		}
		return null;
	}

	/**
	 * 将dbutil中的数据封装成
	 * 
	 * @param dbUtil
	 * @return
	 * @throws SQLException
	 */
	public List dbutilToOrganziationList(DBUtil dBUtil) throws SQLException {
		List list = new ArrayList();

		for (int k = 0; k < dBUtil.size(); k++) {
			Organization org = new Organization();
			org.setOrgId(dBUtil.getString(k, "ORG_ID"));
			org.setOrgSn(dBUtil.getString(k, "ORG_SN"));
			org.setOrgName(dBUtil.getString(k, "ORG_NAME"));
			org.setParentId(dBUtil.getString(k, "PARENT_ID"));
			org.setPath(dBUtil.getString(k, "PATH"));
			org.setLayer(dBUtil.getString(k, "LAYER"));
			org.setChildren(dBUtil.getString(k, "CHILDREN"));
			org.setCode(dBUtil.getString(k, "CODE"));
			org.setJp(dBUtil.getString(k, "JP"));
			org.setQp(dBUtil.getString(k, "QP"));
			// new Timestamp(doc.getOrdertime().getTime())
			if (dBUtil.getDate(k, "CREATINGTIME") != null) {
				org.setCreatingtime(new java.sql.Date(dBUtil.getDate(k,
						"CREATINGTIME").getTime()));
			}
			org.setCreator(dBUtil.getString(k, "CREATOR"));
			org.setOrgnumber(dBUtil.getString(k, "ORGNUMBER"));
			org.setOrgdesc(dBUtil.getString(k, "ORGDESC"));
			org.setRemark1(dBUtil.getString(k, "REMARK1"));
			org.setRemark2(dBUtil.getString(k, "REMARK2"));
			org.setRemark3(dBUtil.getString(k, "REMARK3"));
			org.setRemark4(dBUtil.getString(k, "REMARK4"));
			org.setRemark5(dBUtil.getString(k, "REMARK5"));

			org.setChargeOrgId(dBUtil.getString(k, "CHARGEORGID"));
			org.setSatrapJobId(dBUtil.getString(k, "SATRAPJOBID"));

			org.setIspartybussiness(dBUtil.getString(k, "ISPARTYBUSSINESS"));

			org.setOrg_level(dBUtil.getString(k, "org_level"));
			org.setOrg_xzqm(dBUtil.getString(k, "org_xzqm"));

			org.setIsdirectlyparty(dBUtil.getString(k, "isdirectlyparty"));
			org.setIsforeignparty(dBUtil.getString(k, "isforeignparty"));
			org.setIsjichaparty(dBUtil.getString(k, "isjichaparty"));
			org.setIsdirectguanhu(dBUtil.getString(k, "isdirectguanhu"));

			list.add(org);
		}
		return list;
	}
	
	/**
	 * 机构UUID生成方式
	 * @return
	 */
	public String getUUID() {
		return UUIDGenerator.getInstance().generateRandomBasedUUID().toString();
	}
	/**
	 * 危达 200711091005 此函数用来处理新增机构的情况
	 */
	public boolean insertOrg(Organization org,String orgType,String orgSortType,String isOffline,String is_leadorg,String is_office,String five_major_org,HashMap<String,String> sendSmsMap) throws ManagerException {
		boolean r = false;
		TransactionManager tm = new TransactionManager();
		OrgAndTypeBean orgAndTypeBean=new OrgAndTypeBean();
		if (org != null) {
			try {
				tm.begin();
				String parentId = org.getParentId();
				if ((parentId == null) || (parentId == "")
						|| ("".equals(parentId)))// 机构的根结点id必须保证是0
				{
					parentId = "0";
				}
				String sqlMaxSn = "select max(org_sn) from td_sm_organization where parent_id='"
						+ parentId + "'";
				DBUtil db = new DBUtil();
				db.executeSelect(sqlMaxSn);
				// String orgSn = String.valueOf(db.getInt(0, 0) + 1);
				int orgSn = db.getInt(0, 0) + 1;
				PreparedDBUtil conn = new PreparedDBUtil();
//				String orgId = conn
//						.getNextStringPrimaryKey("td_sm_organization");
				//add jian.liu 添加 机构码生成规则
				org=this.getOrgGeneratingRules(org);
				String orgId=getUUID();
				orgAndTypeBean.setOrgid(orgId);
				orgAndTypeBean.setOrgtype(orgType);
				orgAndTypeBean.setOrgsortid(orgSortType);
				orgAndTypeBean.setIs_offline(isOffline);
				orgAndTypeBean.setIs_leadorg(is_leadorg);
				orgAndTypeBean.setIs_office(is_office);
				orgAndTypeBean.setFive_major_org(five_major_org);
				//怀化发送短信 start 追加
				orgAndTypeBean.setSendAccount(sendSmsMap.get("sendAccount"));
				orgAndTypeBean.setSendPassword(sendSmsMap.get("sendPassword"));
				orgAndTypeBean.setSendOrgCode(sendSmsMap.get("sendOrgCode"));
				//怀化发送短信 end 追加
				//插入扩展信息
				insertOrgAndType(orgAndTypeBean);
				String sql = "insert into td_sm_organization"
						+ "("
						+ "ORG_SN,ORG_NAME,"
						+ "PARENT_ID,PATH,LAYER,"
						+ "CHILDREN,CODE,JP,"
						+ "QP,CREATINGTIME,CREATOR,"
						+ "ORGNUMBER,ORGDESC,REMARK1,"
						+ "REMARK2,REMARK3,REMARK4,"
						+ "REMARK5,CHARGEORGID,SATRAPJOBID,"
						+ "ISPARTYBUSSINESS,org_level,org_xzqm,"
						+ "isdirectlyparty,isforeignparty,isjichaparty,isdirectguanhu,ORG_ID"
						+ ")"
						+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				conn.preparedInsert(sql);
				// conn.setString(1,org.getOrgSn());
				conn.setInt(1, orgSn);
				conn.setString(2, org.getOrgName());
				conn.setString(3, parentId);
				conn.setString(4, org.getPath());
				conn.setString(5, org.getLayer());
				conn.setString(6, org.getChildren());
				conn.setString(7, org.getCode());
				conn.setString(8, org.getJp());
				conn.setString(9, org.getQp());
				conn.setDate(10, org.getCreatingtime());
				conn.setString(11, org.getCreator());
				conn.setString(12, org.getOrgnumber());
				conn.setString(13, org.getOrgdesc());
				conn.setString(14, org.getRemark1());
				conn.setString(15, org.getRemark2());
				conn.setString(16, org.getRemark3());
				conn.setString(17, org.getRemark4());
				conn.setString(18, org.getRemark5());
				conn.setString(19, org.getChargeOrgId());
				conn.setString(20, org.getSatrapJobId());

				String ispartybussiness = org.getIspartybussiness();
				if (null != ispartybussiness
						&& !ispartybussiness.trim().equals("")) {
					conn.setInt(21, Integer.parseInt(ispartybussiness));
				} else {
					conn.setInt(21, 1);
				}

				conn.setString(22, org.getOrg_level());
				conn.setString(23, org.getOrg_xzqm());

				String isdirectlyparty = org.getIsdirectlyparty();
				if (null != isdirectlyparty
						&& !isdirectlyparty.trim().equals("")) {
					conn.setInt(24, Integer.parseInt(isdirectlyparty));
				} else {
					conn.setInt(24, 0);
				}

				String isforeignparty = org.getIsforeignparty();
				if (null != isforeignparty && !isforeignparty.trim().equals("")) {
					conn.setInt(25, Integer.parseInt(isforeignparty));
				} else {
					conn.setInt(25, 0);
				}

				String isjichaparty = org.getIsjichaparty();
				if (null != isjichaparty && !isjichaparty.trim().equals("")) {
					conn.setInt(26, Integer.parseInt(isjichaparty));
				} else {
					conn.setInt(26, 0);
				}

				String isdirectguanhu = org.getIsdirectguanhu();
				if (null != isdirectguanhu && !isdirectguanhu.trim().equals("")) {
					conn.setInt(27, Integer.parseInt(isdirectguanhu));
				} else {
					conn.setInt(27, 0);
				}
				conn.setString(28, orgId);
				r = true;
				org.setOrgId(orgId);
				conn.executePrepared();

				String insertSql = "insert into td_sm_orgjob (org_id, job_id, job_sn) values ('"
						+ orgId + "', '1', 999)";
				DBUtil db_insertjob = new DBUtil();
				db_insertjob.executeInsert(insertSql);

				tm.commit();

				Event event = new EventImpl(orgId,
						ACLEventType.ORGUNIT_INFO_ADD);
				super.change(event, true);

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
	 * 危达 200711091006 此函数用来处理更新机构的情况
	 * 
	 */
	public boolean storeOrg(Organization org) throws ManagerException {
		boolean r = false;
		if (org != null) {
			try {
				// // 检查当前机构实例是否来自LDAP，因为LDAP中的机构ID(CN)是采用机构名标识其唯一性
				// if (org.getOrgId() != null &&
				// org.getOrgId().equals(org.getOrgName()))
				// {
				// Organization oldOrg = getOrgByName(org.getOrgName());
				// if (oldOrg == null)
				// org.setOrgId(null);
				// else
				// org.setOrgId(oldOrg.getOrgId());
				// }
				PreparedDBUtil conn = new PreparedDBUtil();
				// 有四个字段没有更新(暂时不需要)：ORG_ID CREATINGTIME CREATOR REMARK2
				// REMARK4，危达200711151437
				String parentId = org.getParentId();
				if ((parentId == null) || (parentId == "")
						|| ("".equals(parentId)))// 机构的根结点id必须保证是0
				{
					parentId = "0";
				}
				String org_level = "1";// 数据库默认为1
				if (org.getOrg_level() != null
						&& !org.getOrg_level().equals("")) {
					org_level = org.getOrg_level();
				}
				String org_xzqm = "";
				if (org.getOrg_xzqm() != null && !org.getOrg_xzqm().equals("")) {
					org_xzqm = org.getOrg_xzqm();
				}
				String orgsn = org.getOrgSn() != null
						&& !org.getOrgSn().equals("") ? org.getOrgSn() : "0";
				String ispartybussiness = org.getIspartybussiness() != null
						&& !org.getIspartybussiness().equals("") ? org
						.getIspartybussiness() : "0";
				String isdirectlyparty = org.getIsdirectlyparty() != null
						&& !org.getIsdirectlyparty().equals("") ? org
						.getIsdirectlyparty() : "0";
				String isforeignparty = org.getIsforeignparty() != null
						&& !org.getIsforeignparty().equals("") ? org
						.getIsforeignparty() : "0";
				String isjichaparty = org.getIsjichaparty() != null
						&& !org.getIsjichaparty().equals("") ? org
						.getIsjichaparty() : "0";
				String isdirectguanhu = org.getIsdirectguanhu() != null
						&& !org.getIsdirectguanhu().equals("") ? org
						.getIsdirectguanhu() : "0";
                 
				String sql = "update td_sm_organization " + "set " + "ORG_SN="
						+ orgsn + ",ORG_NAME='" + org.getOrgName() + "',"
						+ "JP='" + org.getJp() + "'," + "QP='" + org.getQp()
						+ "'," + "ORGNUMBER='" + org.getOrgnumber()
						+ "',ORGDESC='" + org.getOrgdesc() + "',REMARK1='"
						+ org.getRemark1() + "'," + "REMARK2='"
						+ org.getRemark2() + "'," + "REMARK3='"   //add jian.liu
						+ org.getRemark3() + "'," + "REMARK5='"
						+ org.getRemark5() + "',CHARGEORGID='"
						+ org.getChargeOrgId() + "',SATRAPJOBID='"
						+ org.getSatrapJobId() + "'," + "ISPARTYBUSSINESS="
						+ ispartybussiness + "," + "PATH='" + org.getPath()
						+ "'," + "LAYER='" + org.getLayer() + "',"
						+ "CHILDREN='" + org.getChildren() + "'," + "CODE='"
						+ org.getCode() + "'," + "org_level='" + org_level
						+ "'," + "org_xzqm='" + org_xzqm + "'," + "PARENT_ID='"
						+ parentId + "'," + "isdirectlyparty="
						+ isdirectlyparty + "," + "isforeignparty="
						+ isforeignparty + "," + "isjichaparty=" + isjichaparty
						+ "," + "isdirectguanhu=" + isdirectguanhu + ""
						+ " where ORG_ID='" + org.getOrgId() + "'";
				conn.preparedUpdate(sql);
				conn.executePrepared();

				// 同步所有应用的数据 add by minghua.guo 2010-6-22
				String appid = AppIdThreadLocal.get();
				if ("module".equals(appid)) {
					OrgUserManager.appOrgUpdSynchronizer(org);
				}

				r = true;
				Event event = new EventImpl(org.getOrgId(),
						ACLEventType.ORGUNIT_INFO_UPDATE);
				super.change(event, true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return r;
	}

	/**
	 * 没有被使用的方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
	 */
	public boolean storeOrg(Organization org, String propName, String value)
			throws ManagerException {
		boolean r = false;

		// if (org != null) {
		// try {
		// // 检查数据库中是否存在与属性以及属性值相同的记录，有则用 org 对象实例中的值
		// // 更新该记录否则插入新的记录
		// Organization oldOrg = getOrg(propName, value);
		// if (oldOrg == null)
		// org.setOrgId(null);
		// else
		// org.setOrgId(oldOrg.getOrgId());
		//
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(org);
		//
		// if (cb.execute(p) != null) {
		// r = true;
		//
		// }
		// Event event = new EventImpl("",
		// ACLEventType.ORGUNIT_INFO_CHANGE);
		// super.change(event,true);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	/**
	 * 没有被使用的方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
	 */
	public boolean storeOrggroup(Orggroup orggroup) throws ManagerException {
		boolean r = false;

		// if (orggroup != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(orggroup);
		//
		// if (cb.execute(p) != null)
		// r = true;
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }

		return r;
	}

	public boolean storeOrgjob(Orgjob orgjob) throws ManagerException {
		boolean r = false;

		if (orgjob != null) {

			// 如果存在则更新,如果不存在则插入
			String org_id = orgjob.getOrganization().getOrgId();
			String job_id = orgjob.getJob().getJobId();
			String job_sn = orgjob.getJobSn().toString();
			String sql = "select count(*) from td_sm_orgjob where org_id='"
					+ org_id + "' and job_id='" + job_id + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeSelect(sql);
				if (db.getInt(0, 0) > 0) {
					String updateSql = "update td_sm_orgjob set job_sn="
							+ job_sn + " where org_id='" + org_id
							+ "' and job_id='" + job_id + "'";
					DBUtil updateDb = new DBUtil();
					updateDb.executeUpdate(updateSql);
				} else {
					String insertSql = "insert into td_sm_orgjob (org_id, job_id, job_sn) values ('"
							+ org_id + "', '" + job_id + "', " + job_sn + ")";
					DBUtil insertDb = new DBUtil();
					insertDb.executeUpdate(insertSql);
				}
				r = true;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return r;
	}

	/**
	 * 保存机构岗位
	 * 
	 * @param org_id
	 * @param job_ids
	 * @param job_sn
	 * @return
	 * @throws ManagerException
	 *             OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean addOrgjob(String org_id, String[] job_ids, String job_sn)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		try {
			String maxSn = "select max(job_sn) from td_sm_orgjob where org_id='"
					+ org_id + "' and job_id <> '1'";
			DBUtil db_sn = new DBUtil();
			db_sn.executeSelect(maxSn);
			if (db_sn.size() > 0) {
				job_sn = String.valueOf(db_sn.getInt(0, 0) + 1);
			}
			for (int i = 0; i < job_ids.length; i++) {
				String job_id = job_ids[i];
				String sql = "select count(*) from td_sm_orgjob where org_id='"
						+ org_id + "' and job_id='" + job_id + "'";
				String sqlstr = "";
				db.executeSelect(sql);
				if (db.getInt(0, 0) <= 0) {
					// sqlstr = "update td_sm_orgjob set job_sn='" + job_sn + "'
					// where org_id='"
					// + org_id + "' and job_id='" + job_id + "'";
					// }else{
					// sqlstr =
					// "insert all when totalsize <= 0 then into td_sm_orgjob (org_id, job_id, job_sn) values ('"
					// + org_id
					// + "', '"
					// + job_id
					// + "', '"
					// + (Integer.parseInt(job_sn) + i)
					// + "') select count(1) as totalsize from "
					// + "td_sm_orgjob where org_id='"
					// + org_id
					// + "' and job_id='" + job_id + "'";

					sqlstr = "insert into td_sm_orgjob(org_id, job_id, job_sn) values('"
							+ org_id
							+ "', '"
							+ job_id
							+ "', "
							+ (Integer.parseInt(job_sn) + i) + ")";
				}
				db.addBatch(sqlstr);
				r = true;
			}
			db.executeBatch();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return r;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#addSubOrgjob(java.lang
	 * .String, java.lang.String[], java.lang.String[])
	 */
	public boolean addSubOrgjob(String orgid, String[] jobids)
			throws ManagerException {
		boolean flag = false;
		DBUtil db = new DBUtil();
		DBUtil db1 = new DBUtil();
		String sqlsuborg = "SELECT t.org_id FROM TD_SM_ORGANIZATION t where t.org_id != '"
				+ orgid
				+ "' START WITH "
				+ " t.org_id = '"
				+ orgid
				+ "' CONNECT BY PRIOR t.org_id = t.PARENT_ID ";
		try {

			db.executeSelect(sqlsuborg);
			if (db.size() > 0) {
				StringBuffer sql = new StringBuffer(
						"insert into td_sm_orgjob  select '");
				int length = sql.length();
				for (int i = 0; i < db.size(); i++) {
					// sql = "delete td_sm_orgjob t where t.org_id = '" +
					// db.getString(i,0) + "'";
					// db1.addBatch(sql);
					// 此处为jobid集合，like（25，26）

					sql.append(db.getString(i, 0)).append(
							"' as org_id,job_id,job_sn ").append(
							"from td_sm_orgjob where org_id = '").append(orgid)
							.append("' and job_id in (");
					for (int j = 0; j < jobids.length; j++) {
						if (j != 0)
							sql.append(",'").append(jobids[j]).append("'");
						else
							sql.append("'").append(jobids[j]).append("'");
					}
					sql.append(") and job_id not in(").append(
							"select job_id from td_sm_orgjob where org_id = '")
							.append(db.getString(i, 0)).append("') ");
					db1.addBatch(sql.toString());
					sql.setLength(length);
				}
			}
			db1.executeBatch();
			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db1.resetBatch();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return flag;
	}

	public boolean storeSubOrgjob(Orgjob orgjob) throws ManagerException {
		boolean flag = false;
		DBUtil db = new DBUtil();
		DBUtil db1 = new DBUtil();
		String sql = "";
		String sqlsuborg = "SELECT t.org_id FROM TD_SM_ORGANIZATION t where t.org_id != '"
				+ orgjob.getOrganization().getOrgId()
				+ "' START WITH "
				+ " t.org_id = '"
				+ orgjob.getOrganization().getOrgId()
				+ "' CONNECT BY PRIOR t.org_id = t.PARENT_ID ";
		try {
			db.executeSelect(sqlsuborg);
			if (db.size() > 0) {
				for (int i = 0; i < db.size(); i++) {
					// sql = "delete td_sm_orgjob t where t.org_id = '" +
					// db.getString(i,0) + "'";
					// db1.addBatch(sql);
					// 此处为jobid集合，like（25，26）
					sql = "insert into td_sm_orgjob t select "
							+ db.getString(i, 0)
							+ " as org_id,job_id,job_sn "
							+ "from td_sm_orgjob where org_id = '"
							+ orgjob.getOrganization().getOrgId()
							+ "' and job_id in ("
							+ orgjob.getJob().getJobId()
							+ ") and job_id not in("
							+ "select job_id from td_sm_orgjob where org_id = '"
							+ db.getString(i, 0) + "' " + "and job_id in ("
							+ orgjob.getJob().getJobId() + "))";
					db1.addBatch(sql);
				}
			}
			db1.executeBatch();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db1.resetBatch();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return flag;
	}

	/**
	 * 没有被使用的hibernate方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
	 */
	public Organization loadAssociatedSet(String orgId, String associated)
			throws ManagerException {
		Organization orgRel = new Organization();

		// try {
		// DataControl cb = DataControl
		// .getInstance(DataControl.CONTROL_INSTANCE_DB);
		// Parameter par = new Parameter();
		// par.setCommand(Parameter.COMMAND_GET);
		// par.setObject("from Organization o left join fetch o." + associated
		// + " where o.orgId = '" + orgId + "'");
		//
		// List list = (List) cb.execute(par);
		// if (list != null && !list.isEmpty()) {
		// orgRel = (Organization) list.get(0);
		// }
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }

		return orgRel;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean isContainChildOrg(Organization org) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("select count(*) from Organization o where o.parentId = '"
		// + org.getOrgId() + "'");
		// List list = (List) cb.execute(p);
		// if (list != null) {
		// if (!list.isEmpty()) {
		// int count = ((Integer) list.get(0)).intValue();
		// if (count > 0)
		// r = true;
		// }
		// } else
		// throw new ManagerException("由于意外错误，暂时无法计算出机构“" + org.getOrgId()
		// + "”是否包含子机构");
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "select count(1) from td_sm_organization where parent_id='"
				+ org.getOrgId() + "'";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.getInt(0, 0) > 0) {
				r = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean isContainUser(Organization org) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p.setObject("select count(*) from User user where user.userId in ("
		// + "select ujo.id.userId from Userjoborg ujo where ujo.id.orgId = '"
		// + org.getOrgId() + "')");
		// List list = (List) cb.execute(p);
		// if (list != null) {
		// if (!list.isEmpty()) {
		// int count = ((Integer) list.get(0)).intValue();
		// if (count > 0)
		// r = true;
		// }
		// } else
		// throw new ManagerException("由于意外错误，暂时无法计算出机构“" + org.getOrgId()
		// + "”是否包含子机构");
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		String sql = "select count(1) from td_sm_user where user_id in (select user_id from td_sm_userjoborg where "
				+ "org_id='" + org.getOrgId() + "')";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.getInt(0, 0) > 0) {
				r = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return r;
	}

	public List getChildOrgList(Organization org) throws ManagerException {
		return getChildOrgList(org, false);
	}

	public List getChildOrgList(Organization parentOrg, boolean isRecursion)
			throws ManagerException {
		List list = new ArrayList();
		String orderColumn = ConfigManager.getInstance().getConfigValue(
				"sys.orgOrder.column") == null ? "org_sn" : ConfigManager
				.getInstance().getConfigValue("sys.orgOrder.column");
		try {
			String sql = "";
			if (isRecursion) {
				// 以递归的方式取 parentOrg 的子机构（包括子机构的子机构）
				sql = "select * from td_sm_organization q "
						+ "start with q.org_id='" + parentOrg.getOrgId() + "' "
						+ "connect by prior q.org_id = q.parent_id "
						+ "order siblings by q." + orderColumn + " asc";
			} else {
				// 仅取 parentOrg 的所有子机构（不用递归）
				sql = "select * from td_sm_organization t "
						+ "where t.parent_id='" + parentOrg.getOrgId() + "' "
						+ "order by t." + orderColumn + " asc";
			}
			DBUtil dBUtil = new DBUtil();
			dBUtil.executeSelect(sql);
			list = this.dbutilToOrganziationList(dBUtil);
		} catch (Exception e) {
			logger.error(e);
			throw new ManagerException(e.getMessage());
		}

		return list;
	}

	/**
	 * 无效方法
	 * 
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
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

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean isOrgExist(String orgName) throws ManagerException {
		boolean r = false;

		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_GET);
		// p
		// .setObject("from Organization o where o.orgName='"
		// + orgName + "'");
		// List list = (List) cb.execute(p);
		//
		// if (list != null && list.size() > 0)
		// r = true;
		// } catch (ControlException e) {
		// logger.error(e);
		// }
		String sql = "select count(1) from td_sm_organization where org_name='"
				+ orgName + "'";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.getInt(0, 0) > 0) {
				r = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return r;
	}

	public List getOrgList(Role role) throws ManagerException {
		if (role != null) {
			return this.getOrgListOfRole(role.getRoleId());
		} else {
			return null;
		}
	}

	public List getOrgListOfRole(String roleid) throws ManagerException {
		List list = null;

		if (roleid != null && !roleid.equals("")) {
			try {
				String sql = "select t.* from td_sm_organization t "
						+ "inner join td_sm_orgrole r on t.org_id=r.org_id where r.role_id='"
						+ roleid + "' order by t.org_sn asc";
				DBUtil dbUtil = new DBUtil();
				dbUtil.executeSelect(sql);
				return this.dbutilToOrganziationList(dbUtil);

			} catch (Exception e) {
				logger.error(e);
				throw new ManagerException(e.getMessage());
			}
		}

		return list;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean storeOrgrole(Orgrole orgrole) throws ManagerException {
		boolean r = false;

		// if (orgrole != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_STORE);
		// p.setObject(orgrole);
		//
		// if (cb.execute(p) != null) {
		// r = true;
		//
		// }
		// Event event = new EventImpl("",
		// ACLEventType.ORGUNIT_ROLE_CHANGE);
		// super.change(event,true);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (orgrole != null) {
			String sql = "insert into td_sm_orgrole(org_id,role_id) values('"
					+ orgrole.getOrganization().getOrgId() + "','"
					+ orgrole.getRole().getRoleId() + "')";
			DBUtil db = new DBUtil();
			try {
				db.executeInsert(sql);
				r = true;
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_ROLE_CHANGE);
				super.change(event, true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteOrgrole(Orgrole orgrole) throws ManagerException {
		boolean r = false;

		// if (orgrole != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		//
		// // 删除机构与角色的关系
		// p.setObject(orgrole);
		// if (cb.execute(p) != null) {
		// r = true;
		//
		// }
		// Event event = new EventImpl("",
		// ACLEventType.ORGUNIT_ROLE_CHANGE);
		// super.change(event,true);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (orgrole != null) {
			String sql = "delete td_sm_orgrole where org_id='"
					+ orgrole.getOrganization().getOrgId() + "' and role_id='"
					+ orgrole.getRole().getRoleId() + "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(sql);
				r = true;
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_ROLE_CHANGE);
				super.change(event, true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * 
	 * @param orgId
	 * @param roleIds
	 * @param flag
	 *            0=不递归删除子机构角色; 1=递归删除子机构角色
	 * @return
	 * @throws ManagerException
	 *             OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean deleteOrgrole(String orgId, String[] roleIds, String flag)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		try {
			if (flag.equals("0")) {// 不递归删除子机构角色
				for (int i = 0; i < roleIds.length; i++) {
					String sql = "delete from td_sm_orgrole where role_id='"
							+ roleIds[i] + "' and org_id ='" + orgId + "'";
					db.addBatch(sql);
				}
			} else {// 递归删除子机构角色
				String orgs = "SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH"
						+ " t.org_id='"
						+ orgId
						+ "' CONNECT BY PRIOR t.org_id=t.PARENT_ID";
				for (int i = 0; i < roleIds.length; i++) {
					String sql = "delete from td_sm_orgrole where role_id='"
							+ roleIds[i] + "' and org_id in (" + orgs + ")";
					db.addBatch(sql);
				}
			}
			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.ORGUNIT_ROLE_CHANGE);
			super.change(event, true);

			event = new EventImpl("", ACLEventType.USER_ROLE_INFO_CHANGE);
			super.change(event, true);

			r = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}

		return r;
	}

	/**
	 * 
	 * @param orgId
	 * @param roleIds
	 * @param flag
	 *            0=不递归删除子机构角色; 1=递归删除子机构角色
	 * @return
	 * @throws ManagerException
	 *             OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean deleteOrgrole(String orgIds[], String[] roleIds)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		try {
			for (int j = 0; j < orgIds.length; j++) {
				for (int i = 0; i < roleIds.length; i++) {
					String sql = "delete from td_sm_orgrole where role_id='"
							+ roleIds[i] + "' and org_id ='" + orgIds[j] + "'";
					db.addBatch(sql);
				}
			}

			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.ORGUNIT_ROLE_CHANGE);
			super.change(event, true);
			r = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}

		return r;
	}

	/**
	 * 去掉hibernate后的方法
	 */
	public boolean deleteOrgrole(Organization org) throws ManagerException {
		boolean r = false;

		// if (org != null) {
		// try {
		// Parameter p = new Parameter();
		// p.setCommand(Parameter.COMMAND_DELETE);
		//
		// // 删除机构与角色的关系
		// p.setObject("from Orgrole or where or.id.orgId = '"
		// + org.getOrgId() + "'");
		// if (cb.execute(p) != null) {
		// r = true;
		//
		// }
		// Event event = new EventImpl("",
		// ACLEventType.ORGUNIT_ROLE_CHANGE);
		// super.change(event,true);
		// } catch (ControlException e) {
		// logger.error(e);
		// throw new ManagerException(e.getMessage());
		// }
		// }
		if (org != null) {
			String sql = "delete td_sm_orgrole where org_id='" + org.getOrgId()
					+ "'";
			DBUtil db = new DBUtil();
			try {
				db.executeDelete(sql);
				r = true;
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_ROLE_CHANGE);
				super.change(event, true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return r;
	}

	/**
	 * add by hongyu.deng 为了提高系统性能提供一条sql语句从数据库中取出用户能看见的所有机构树资源
	 * 
	 * @param userId
	 * @return
	 * @throws ManagerException
	 */
	public ListInfo getUserCanWriteAndReadOrgList(String userId,
			String userAccount, int offSet, int pageItemsize, String condition)
			throws ManagerException {
		// TODO Auto-generated method stub
		String sql = "";
		// add by ge.tao
		// 猥琐做法:
		// condition = " o.PARENT_ID='"+orgId +"'"
		// 提取机构ID
		String orgId = condition.substring(condition.indexOf("=") + 1);// orgId
		// =
		// 'orgId'
		orgId = orgId.replaceAll("'", "");
		// 超级管理员 或者当前部门管理员
		// end --
		if (AccessControl.isAdmin(userAccount)
				|| AccessControl.isOrganizationManager(userId, orgId)) {
			sql = "select * from td_sm_organization o";
			if (condition != null && !condition.equals(""))
				sql += " where " + condition;
		} else {
			// sql="select o.* from td_sm_organization o,(select ur.role_id as
			// role_id from td_sm_userrole ur " +
			// " where ur.user_id='"+ userId +"' union "+
			// " select gr.role_id as role_id from td_sm_usergroup
			// ug,td_sm_grouprole gr " +
			// " where ug.user_id='"+ userId +"' and ug.group_id=gr.group_id
			// union"+
			// " select orgr.role_id from td_sm_userjoborg uo,td_sm_orgrole orgr
			// " +
			// " where uo.user_id='"+ userId +"' and uo.org_id=orgr.org_id)
			// userrole where userrole.role_id in "+
			// " (select rro.role_id from td_sm_roleresop rro where
			// rro.restype_id='orgunit' and " +
			// " o.org_id=rro.res_id )";
			sql = "select o.* from  td_sm_organization o where o.org_id in (select rro.res_id from td_sm_roleresop rro where rro.restype_id='orgunit' and rro.op_id in ('"
					+ AccessControl.READ_PERMISSION
					+ "','"
					+ AccessControl.WRITE_PERMISSION
					+ "') and "
					+ "rro.role_id in (select ur.role_id as role_id from td_sm_userrole ur "
					+ " where ur.user_id='"
					+ userId
					+ "' union "
					+ " select gr.role_id as role_id from td_sm_usergroup ug,td_sm_grouprole gr "
					+ " where ug.user_id='"
					+ userId
					+ "' and ug.group_id=gr.group_id union"
					+ " select orgr.role_id  as role_id from td_sm_userjoborg uo,td_sm_orgrole orgr "
					+ " where uo.user_id='"
					+ userId
					+ "' and uo.org_id=orgr.org_id))";
			if (condition != null && !condition.equals(""))
				sql += " and " + condition;

		}
		sql += " order by o.org_sn ";
		DBUtil dbUtil = new DBUtil();
		List list = new ArrayList();

		try {
			dbUtil.executeSelect(sql, offSet, pageItemsize);
			logger.warn(sql);
			if (dbUtil.size() > 0) {
				list = this.dbutilToOrganziationList(dbUtil);
				// for (int i = 0; i < dbUtil.size(); i++) {
				// Organization org = new Organization();
				// org.setOrgId(dbUtil.getString(i, "ORG_ID"));
				// //org.setOrgSn(new Integer(dbUtil.getInt(i, "ORG_SN")));
				// org.setOrgSn(dbUtil.getString(i, "ORG_SN"));
				// org.setOrgName(dbUtil.getString(i, "ORG_NAME"));
				// org.setParentId(dbUtil.getString(i, "PARENT_ID"));
				// org.setPath(dbUtil.getString(i, "PATH"));
				// org.setLayer(dbUtil.getString(i, "LAYER"));
				// org.setChildren(dbUtil.getString(i, "CHILDREN"));
				// org.setCode(dbUtil.getString(i, "CODE"));
				// org.setJp(dbUtil.getString(i, "JP"));
				// org.setQp(dbUtil.getString(i, "QP"));
				// org.setCreator(dbUtil.getString(i, "CREATOR"));
				// org.setOrgnumber(dbUtil.getString(i, "ORGNUMBER"));
				// org.setOrgdesc(dbUtil.getString(i, "ORGDESC"));
				// org.setRemark1(dbUtil.getString(i, "REMARK1"));
				// org.setRemark2(dbUtil.getString(i, "REMARK2"));
				// org.setRemark3(dbUtil.getString(i, "REMARK3"));
				// org.setRemark4(dbUtil.getString(i, "REMARK4"));
				// org.setRemark5(dbUtil.getString(i, "REMARK5"));
				// org.setChargeOrgId(dbUtil.getString(i, "CHARGEORGID"));
				// org.setSatrapJobId(dbUtil.getString(i, "SATRAPJOBID"));
				//					
				// list.add(org);
				// }
				ListInfo ret = new ListInfo();
				ret.setDatas(list);
				ret.setItems(dbUtil.getTotalSize());
				return ret;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @deprecated 不推荐使用该方法，方法实现已被注释掉
	 */
	public ChargeOrg getSatrapListByUserAccount(String userAccount)
			throws ManagerException {
		// TODO Auto-generated method stub
		return null;
	}

	public ChargeOrg getSatrapListByUserID(String userID)
			throws ManagerException {
		ChargeOrg chargeorg = null;
		String orgId = "";
		String orgName = "";
		String ChargeOrgId = "";
		String ChargeOrgName = "";
		String SatrapName = "";
		String layer = "";
		String uid = "";
		String SatrapJobId = "";
		String SatrapJobName = "";
		String SatrapRealName = "";
		DBUtil dbutil = new DBUtil();
		DBUtil dbUtil = new DBUtil();
		DBUtil dbUtil2 = new DBUtil();

		// 获得用户所在的主要单位ID
		String sql = "select ORG_ID from TD_SM_ORGUSER where USER_ID=" + userID
				+ "";
		try {
			dbutil.executeSelect(sql);
			if (dbutil.size() == 0) {
				return chargeorg;
			}
			if (dbutil != null && dbutil.size() > 0) {
				orgId = dbutil.getString(0, "ORG_ID");// 得所在机构id

			}
			// 获得该单位的名称，主管处室，主管岗位，级次
			String sql1 = "select ORG_NAME,CHARGEORGID,SATRAPJOBID,LAYER from TD_SM_ORGANIZATION where ORG_ID='"
					+ orgId + "'";

			dbUtil.executeSelect(sql1);
			if (dbUtil != null && dbUtil.size() > 0) {
				// 所在单位名称
				orgName = dbUtil.getString(0, "ORG_NAME");

				// 主管处室id
				ChargeOrgId = dbUtil.getString(0, "CHARGEORGID");

				// 主管岗位id
				SatrapJobId = dbUtil.getString(0, "SATRAPJOBID");
				if (SatrapJobId.equals(""))
					return null;

			}
			OrgManager orgManager;
			JobManager jobManager;
			try {
				orgManager = SecurityDatabase.getOrgManager();
				Organization org = orgManager.getOrgById(ChargeOrgId);
				jobManager = SecurityDatabase.getJobManager();
				// Job job = jobManager.getJob("jobId", SatrapJobId);
				Job job = jobManager.getJobById(SatrapJobId);
				// 主管岗位名称
				SatrapJobName = job.getJobName();
				// 主管处室名称
				ChargeOrgName = org.getOrgName();
				// 主管处室所在级次
				layer = org.getLayer();
			} catch (SPIException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 获得主管处室下主管人(id,name)
			String sql2 = "select a.user_id,a.USER_REALNAME,a.USER_NAME  from td_sm_user a,TD_SM_USERJOBORG b where "
					+ "a.user_id = b.user_id and b.org_id ='"
					+ ChargeOrgId
					+ "' and b.job_id ='" + SatrapJobId + "'";

			dbUtil2.executeSelect(sql2);

			boolean flag = false;
			for (int i = 0; i < dbUtil2.size(); i++) {
				if (!flag) {
					uid = String.valueOf(dbUtil2.getInt(i, "user_id"));
					SatrapName = dbUtil2.getString(i, "USER_NAME");
					SatrapRealName = dbUtil2.getString(i, "USER_REALNAME");
					flag = true;
				} else {
					uid += "," + String.valueOf(dbUtil2.getInt(i, "user_id"));
					SatrapName += "," + dbUtil2.getString(i, "USER_NAME");
					SatrapRealName += ","
							+ dbUtil2.getString(i, "USER_REALNAME");

				}
			}
			chargeorg = new ChargeOrg();
			chargeorg.setUserId(userID);
			chargeorg.setOrgName(orgName);
			chargeorg.setChargeOrgId(ChargeOrgId);
			chargeorg.setChargeOrgName(ChargeOrgName);
			chargeorg.setSatrapJobId(SatrapJobId);
			chargeorg.setSatrapJobName(SatrapJobName);
			chargeorg.setSatrapId(uid);
			chargeorg.setSatrapName(SatrapName);
			chargeorg.setSatrapRealName(SatrapRealName);
			chargeorg.setLayer(layer);
			return chargeorg;
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return chargeorg;
	}

	public Organization getMainOrganizationOfUser(String userAccount)
			throws ManagerException {
		// 取登陆用户的主要所属单位
		UserManager userManager;
		String orgId = "";
		String orgName = "";
		String remark5 = "";
		Organization org = null;

		DBUtil db = new DBUtil();

		String sql = "select * from td_sm_organization where org_id in (select ORG_ID from TD_SM_ORGUSER where USER_ID in (select user_id from td_sm_user where user_name='"
				+ userAccount + "'))";
		try {
			db.executeSelect(sql);
			if (db.size() > 0) {
				org = this.dbutilToOrganziation(db);

				return org;

			}

		} catch (SQLException e) {
			System.out.println("//////////没有主管处室！");
			e.printStackTrace();
		}

		return org;
	}

	public List getSecondOrganizationsOfUser(String userAccount)
			throws ManagerException {
		// 取登陆用户所在兼职单位列表
		UserManager userManager;
		String orgId = "";
		List list = null;
		try {
			userManager = SecurityDatabase.getUserManager();
			User user = userManager.getUserByName(userAccount);
			String userId = user.getUserId().toString();

			DBUtil db = new DBUtil();
			DBUtil db1 = new DBUtil();
			String sql = "select ORG_ID from TD_SM_ORGUSER where USER_ID="
					+ userId + "";
			try {
				db.executeSelect(sql);
				if (db != null && db.size() > 0) {
					orgId = db.getString(0, "ORG_ID");// 得所在机构id

				}
				String strsql = "select a.ORG_ID,b.JOB_Name,c.org_name from "
						+ "TD_SM_USERJOBORG a,td_sm_job b,TD_SM_ORGANIZATION c where a.ORG_ID = c.ORG_ID and "
						+ " a.job_id = b.job_id and a.USER_ID=" + userId
						+ " and a.ORG_ID <> '" + orgId + "'";
				db1.executeSelect(strsql);
				list = new ArrayList();
				for (int i = 0; i < db1.size(); i++) {
					ChargeOrg chargeorg = new ChargeOrg();
					chargeorg.setOrgId(db1.getString(i, "ORG_ID"));
					chargeorg.setJobName(db1.getString(i, "JOB_NAME"));
					chargeorg.setOrgName(db1.getString(i, "ORG_NAME"));
					list.add(chargeorg);
				}
				return list;

			} catch (SQLException e) {
				e.printStackTrace();
				throw new ManagerException(e.getMessage());
			}

		} catch (SPIException e) {

			e.printStackTrace();
		}
		return list;

	}

	// public void addMainOrgnazitionOfUser(String userID, String orgID)
	// throws ManagerException {
	// if(orgID==null || orgID.equals("null"))
	// return;
	// DBUtil db = new DBUtil();
	// StringBuffer sql = new StringBuffer();
	// sql.append("MERGE INTO td_sm_orguser D ")
	// .append("USING (SELECT count(*) counts,user_id FROM td_sm_orguser ")
	// .append("WHERE user_id = '").append(userID).append("' group by user_id )
	// S ")
	// .append("ON (s.counts > 0 and D.user_id = S.user_id ) ")
	// .append("WHEN MATCHED THEN UPDATE SET D.org_id =
	// '").append(orgID).append("' ")
	// .append("WHEN NOT MATCHED THEN INSERT (D.org_id, D.User_Id) ")
	// .append("VALUES ('").append(orgID).append("',
	// '").append(userID).append("')");
	//
	// System.out.println("存储主机构SQL----------------------"+sql.toString());
	//		
	// // String sql = "insert first when ( num_user <= 0 ) then into
	// TD_SM_ORGUSER(org_id,user_id) values('" + orgID + "',"
	// // + userID + ") when (num_user > 0 and t_org_id <> '" + orgID + "') then
	// update TD_SM_ORGUSER set org_Id = '"
	// // + orgID + "' where user_id='" + userID + "' select count(user_id)
	// num_user,org_id t_org_id from TD_SM_ORGUSER where user_id='" + userID +
	// "'";
	//		
	// try {
	// db.executeInsert(sql.toString());
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// }

	public void addMainOrgnazitionOfUser(String userID, String orgID)
			throws ManagerException {
		/*
		 * if (orgID == null || orgID.equals("null")) return; DBUtil db = new
		 * DBUtil(); DBUtil exe = new DBUtil(); StringBuffer isexist = new
		 * StringBuffer(); StringBuffer executesql = new StringBuffer();
		 * isexist.append("SELECT count(*) counts FROM td_sm_orguser ");
		 * isexist.append("WHERE user_id = ").append(userID); try {
		 * db.executeSelect(isexist.toString()); if (db.size() > 0) { if
		 * (db.getInt(0, "counts") > 0) {// update
		 * executesql.append("update td_sm_orguser set org_id='")
		 * .append(orgID).append("' ").append(
		 * " where user_id=").append(userID);
		 * exe.execute(executesql.toString()); } else {// insert
		 * executesql.append( "INSERT into td_sm_orguser (org_id, user_id)")
		 * .append("VALUES ('").append(orgID).append("', ")
		 * .append(userID).append(") "); exe.execute(executesql.toString()); } }
		 * 
		 * } catch (SQLException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
		// 彭盛 2011-3-24
		if (null != userID && !userID.trim().equals("") && null != orgID
				&& !orgID.trim().equals("")) {
			// 定义预编组件实例
			PreparedDBUtil select_preDBUtil = new PreparedDBUtil();
			PreparedDBUtil update_preDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preDBUtil = new PreparedDBUtil();

			TransactionManager tm = new TransactionManager();

			// 创建SQL语句
			String select_sql = "select * from td_sm_orguser where user_id=?";
			String update_orguser_sql = "update td_sm_orguser set org_id=? where user_id=?";
			String update_userchangeorg_sql = "update td_sm_userchangeorg_data set org_id=? where user_id=? and org_id=?";
			String insert_orguser_sql = "insert into td_sm_orguser(org_id, user_id) values(?,?)";
			try {
				tm.begin();
				select_preDBUtil.preparedSelect(select_sql);
				select_preDBUtil.setString(1, userID);
				select_preDBUtil.executePrepared();

				if (null != select_preDBUtil && select_preDBUtil.size() > 0) {
					String currOrgId = select_preDBUtil.getString(0, "org_id");
					if (null != currOrgId && !currOrgId.trim().equals("")) {
						update_preDBUtil.preparedUpdate(update_orguser_sql);
						update_preDBUtil.setString(1, orgID);
						update_preDBUtil.setString(2, userID);
						update_preDBUtil.addPreparedBatch();

						update_preDBUtil
								.preparedUpdate(update_userchangeorg_sql);
						update_preDBUtil.setString(1, currOrgId);
						update_preDBUtil.setString(2, userID);
						update_preDBUtil.setString(3, orgID);
						update_preDBUtil.addPreparedBatch();
						
						update_preDBUtil.executePreparedBatch();
					}
				} else {
					insert_preDBUtil.preparedInsert(insert_orguser_sql);
					insert_preDBUtil.setString(1, orgID);
					insert_preDBUtil.setString(2, userID);
					insert_preDBUtil.executePrepared();
				}
				tm.commit();
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_INFO_CHANGE);
				super.change(event, true);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			}
		}
	}
	
	public void addMainOrgnazitionOfUser(String userID, String orgID,
			String dbname) throws ManagerException {
		if (null != userID && !userID.trim().equals("") && null != orgID
				&& !orgID.trim().equals("") && null!=dbname && !dbname.trim().equals("")) {
			// 定义预编组件实例
			PreparedDBUtil select_preDBUtil = new PreparedDBUtil();
			PreparedDBUtil update_preDBUtil = new PreparedDBUtil();
			PreparedDBUtil insert_preDBUtil = new PreparedDBUtil();

			TransactionManager tm = new TransactionManager();

			// 创建SQL语句
			String select_sql = "select * from td_sm_orguser where user_id=?";
			String update_orguser_sql = "update td_sm_orguser set org_id=? where user_id=?";
			String update_userchangeorg_sql = "update td_sm_userchangeorg_data set org_id=? where user_id=? and org_id=?";
			String insert_orguser_sql = "insert into td_sm_orguser(org_id, user_id) values(?,?)";
			try {
				tm.begin();
				select_preDBUtil.preparedSelect(dbname,select_sql);
				select_preDBUtil.setString(1, userID);
				select_preDBUtil.executePrepared();

				if (null != select_preDBUtil && select_preDBUtil.size() > 0) {
					String currOrgId = select_preDBUtil.getString(0, "org_id");
					if (null != currOrgId && !currOrgId.trim().equals("")) {
						update_preDBUtil.preparedUpdate(dbname,update_orguser_sql);
						update_preDBUtil.setString(1, orgID);
						update_preDBUtil.setString(2, userID);
						update_preDBUtil.addPreparedBatch();

						update_preDBUtil
								.preparedUpdate(dbname,update_userchangeorg_sql);
						update_preDBUtil.setString(1, currOrgId);
						update_preDBUtil.setString(2, userID);
						update_preDBUtil.setString(3, orgID);
						update_preDBUtil.addPreparedBatch();
						
						update_preDBUtil.executePreparedBatch();
					}
				} else {
					insert_preDBUtil.preparedInsert(dbname,insert_orguser_sql);
					insert_preDBUtil.setString(1, orgID);
					insert_preDBUtil.setString(2, userID);
					insert_preDBUtil.executePrepared();
				}
				tm.commit();
				Event event = new EventImpl("",
						ACLEventType.ORGUNIT_INFO_CHANGE);
				super.change(event, true);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (RollbackException e1) {
					e1.printStackTrace();
				}
			}
		}
	}

	/**
	 * 删除用户的主管机构
	 */
	public void deleteMainOrgnazitionOfUser(String userID)
			throws ManagerException {
		DBUtil db = new DBUtil();
		String sql = "delete from  TD_SM_ORGUSER where USER_ID=" + userID + "";
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);

	}

	public ChargeOrg getSatrapUpByOrgID(String orgId) throws ManagerException {

		ChargeOrg chargeorg = null;
		String orgName = "";
		String ChargeOrgId = "";
		String ChargeOrgName = "";
		String SatrapName = "";
		String layer = "";
		String uid = "";
		String SatrapJobId = "";
		String SatrapJobName = "";
		String SatrapRealName = "";

		DBUtil dbUtil = new DBUtil();
		DBUtil dbUtil2 = new DBUtil();

		try {

			// 获得该单位的名称，主管处室，主管岗位，级次
			String sql1 = "select ORG_NAME,CHARGEORGID,SATRAPJOBID,LAYER from TD_SM_ORGANIZATION where ORG_ID='"
					+ orgId + "'";

			dbUtil.executeSelect(sql1);
			if (dbUtil != null && dbUtil.size() > 0) {
				// 所在单位名称
				orgName = dbUtil.getString(0, "ORG_NAME");
				// 主管处室id
				ChargeOrgId = dbUtil.getString(0, "CHARGEORGID");

				// 主管岗位id
				SatrapJobId = dbUtil.getString(0, "SATRAPJOBID");

			}
			OrgManager orgManager;
			JobManager jobManager;
			try {
				orgManager = SecurityDatabase.getOrgManager();
				Organization org = orgManager.getOrgById(ChargeOrgId);
				jobManager = SecurityDatabase.getJobManager();
				// Job job = jobManager.getJob("jobId", SatrapJobId);
				Job job = jobManager.getJobById(SatrapJobId);
				// 主管岗位名称
				SatrapJobName = job.getJobName();
				// 主管处室名称
				ChargeOrgName = org.getOrgName();
				// 主管处室所在级次
				layer = org.getLayer();
			} catch (SPIException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 获得主管处室下主管人(id,name)
			String sql2 = "select a.user_id,a.USER_REALNAME,a.USER_NAME  from td_sm_user a,TD_SM_USERJOBORG b where "
					+ "a.user_id = b.user_id and b.org_id ='"
					+ ChargeOrgId
					+ "' and b.job_id ='" + SatrapJobId + "'";

			dbUtil2.executeSelect(sql2);

			boolean flag = false;
			for (int i = 0; i < dbUtil2.size(); i++) {
				if (!flag) {
					uid = String.valueOf(dbUtil2.getInt(i, "user_id"));
					SatrapName = dbUtil2.getString(i, "USER_NAME");
					SatrapRealName = dbUtil2.getString(i, "USER_REALNAME");
					flag = true;
				} else {
					uid += "," + String.valueOf(dbUtil2.getInt(i, "user_id"));
					SatrapName += "," + dbUtil2.getString(i, "USER_NAME");
					SatrapRealName += ","
							+ dbUtil2.getString(i, "USER_REALNAME");

				}
			}
			chargeorg = new ChargeOrg();
			chargeorg.setOrgName(orgName);
			chargeorg.setChargeOrgId(ChargeOrgId);
			chargeorg.setChargeOrgName(ChargeOrgName);
			chargeorg.setSatrapJobId(SatrapJobId);
			chargeorg.setSatrapJobName(SatrapJobName);
			chargeorg.setSatrapId(uid);
			chargeorg.setSatrapName(SatrapName);
			chargeorg.setSatrapRealName(SatrapRealName);
			chargeorg.setLayer(layer);
			return chargeorg;
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return chargeorg;
	}

	public ChargeOrg getSatrapByUser(String layer, String orgId)
			throws ManagerException {
		ChargeOrg chargeorg = null;
		String Layer = "";
		String ChargeOrgId = "";
		String SatrapName = "";
		String uid = "";
		String SatrapRealName = "";
		String chargeOrgName = "";
		DBUtil dbutil = new DBUtil();
		DBUtil dbUtil = new DBUtil();

		boolean flag = false;
		// 获得预算单位的上级单位
		String sql = "SELECT t.org_id,t.layer FROM TD_SM_ORGANIZATION t START WITH "
				+ "t.org_id='"
				+ orgId
				+ "' CONNECT BY PRIOR t.PARENT_ID=t.org_id";
		// System.out.println(sql);
		try {
			dbutil.executeSelect(sql);

			for (int i = 0; i < dbutil.size(); i++) {
				Layer = dbutil.getString(i, "LAYER");
				ChargeOrgId = dbutil.getString(i, "org_id");

				if (Layer.equals(layer)) {
					// 通过级次找到上级单位，得上级单位下的所有人
					String sql1 = "select distinct a.user_id,b.user_name,b.USER_REALNAME from "
							+ "TD_SM_USERJOBORG a,TD_SM_USER b "
							+ "where a.user_id = b.user_id and a.ORG_ID='"
							+ ChargeOrgId + "'";

					// System.out.println(sql1);
					dbUtil.executeSelect(sql1);
					OrgManager orgManager;
					try {
						orgManager = SecurityDatabase.getOrgManager();
						Organization org = orgManager.getOrgById(ChargeOrgId);
						chargeOrgName = org.getOrgName();
					} catch (SPIException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					for (int j = 0; j < dbUtil.size(); j++) {
						if (!flag) {
							uid = String.valueOf(dbUtil.getInt(j, "user_id"));
							SatrapName = dbUtil.getString(j, "USER_NAME");
							SatrapRealName = dbUtil.getString(j,
									"USER_REALNAME");
							flag = true;
						} else {
							uid += ","
									+ String.valueOf(dbUtil
											.getInt(j, "user_id"));
							SatrapName += ","
									+ dbUtil.getString(j, "USER_NAME");
							SatrapRealName += ","
									+ dbUtil.getString(j, "USER_REALNAME");

						}
					}
				}
			}

			chargeorg = new ChargeOrg();
			chargeorg.setSatrapId(uid);
			chargeorg.setSatrapName(SatrapName);
			chargeorg.setSatrapRealName(SatrapRealName);
			chargeorg.setChargeOrgName(chargeOrgName);
			Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
			super.change(event, true);
			return chargeorg;
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return chargeorg;
	}

	public List getHasPemissionOfUsers(String orgid, String opID, String resType)
			throws ManagerException {

		DBUtil db = new DBUtil();
		AccessControl control = AccessControl.getInstance();
		// 取预算单位主管处室主管岗位下的人
		String sql = "select a.user_id,a.USER_REALNAME,a.USER_NAME  from td_sm_user a,TD_SM_USERJOBORG b,TD_SM_ORGANIZATION c where "
				+ "a.user_id = b.user_id and b.org_id=c.CHARGEORGID "
				+ "and c.ORG_ID='"
				+ orgid
				+ "'"
				+ " and b.job_id=c.SATRAPJOBID";
		List retUsers = new ArrayList();

		try {
			db.executeSelect(sql);
			// System.out.println(db.size());
			for (int i = 0; i < db.size(); i++) {

				String userName = db.getString(i, "USER_NAME");

				if (control.checkPermission(new AuthPrincipal(userName, null,
						null), orgid, opID, resType)) {
					User user = new User();
					int userid = db.getInt(i, "user_id");
					user.setUserId(new Integer(userid));
					user.setUserName(db.getString(i, "USER_NAME"));
					user.setUserRealname(db.getString(i, "USER_REALNAME"));
					retUsers.add(user);
				}
			}
			return retUsers;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return retUsers;

	}

	public List getOrgByUser(String orgId, String jobName)
			throws ManagerException {
		DBUtil db = new DBUtil();
		JobManager jobManager;
		List Users = new ArrayList();
		try {
			jobManager = SecurityDatabase.getJobManager();
			// Job job = jobManager.getJob("jobName",jobName);
			Job job = jobManager.getJobByName(jobName);

			String sql = "select * from td_sm_user where user_id in"
					+ " (select user_id from td_sm_userjoborg where "
					+ " org_id ='" + orgId + "' and job_id ='" + job.getJobId()
					+ "')";
			db.executeSelect(sql);

			for (int i = 0; i < db.size(); i++) {
				User user = new User();
				int userid = db.getInt(i, "user_id");
				user.setUserId(new Integer(userid));
				user.setUserName(db.getString(i, "USER_NAME"));
				user.setUserRealname(db.getString(i, "USER_REALNAME"));
				user.setUserPassword(db.getString(i, "USER_PASSWORD"));
				Users.add(user);
			}
			return Users;
		} catch (SPIException e) {

			e.printStackTrace();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return Users;

	}

	public boolean orgHasJob(String orgid, String jobid)
			throws ManagerException {
		DBUtil dbUtil = new DBUtil();

		String sql = "select 1 from td_sm_orgjob a where a.org_id = '" + orgid
				+ "' and a.job_id= '" + jobid + "'";
		try {
			if (dbUtil.execute(sql).size() > 0)
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean addStatrapUser(String orgId, int userId)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		String sql = "insert into TD_SM_SATRAPUSER(user_id,org_id) values("
				+ userId + ",'" + orgId + "')";
		try {
			db.executeInsert(sql);
			r = true;
		} catch (SQLException e) {
			System.out.println("增加主管用户sql语句异常" + sql);
			e.printStackTrace();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return r;
	}

	public boolean deleteStatrapUser(String orgId, int userId)
			throws ManagerException {
		boolean r = false;
		DBUtil db = new DBUtil();
		String sql = "delete from TD_SM_SATRAPUSER where user_id = " + userId
				+ " + and org_id = '" + orgId + "'";
		try {
			db.executeDelete(sql);
			r = true;
		} catch (SQLException e) {
			System.out.println("删除主管用户sql语句异常" + sql);
			e.printStackTrace();
		}
		Event event = new EventImpl("", ACLEventType.ORGUNIT_INFO_CHANGE);
		super.change(event, true);
		return r;
	}

	public String getSecondOrganizations(String userAccount)
			throws ManagerException {
		// 取登陆用户所在兼职单位列表
		UserManager userManager;
		String orgId = "";
		String orgName = "";
		boolean flag = false;
		try {
			userManager = SecurityDatabase.getUserManager();
			User user = userManager.getUserByName(userAccount);
			String userId = user.getUserId().toString();

			DBUtil db = new DBUtil();
			DBUtil db1 = new DBUtil();
			String sql = "select ORG_ID from TD_SM_ORGUSER where USER_ID="
					+ userId + "";
			try {
				db.executeSelect(sql);
				if (db != null && db.size() > 0) {
					orgId = db.getString(0, "ORG_ID");// 得用户所在主机构的id
				}
				// 去重，危达200711211022
				String strsql = "select distinct c.org_name from "
						+ "TD_SM_USERJOBORG a,td_sm_job b,TD_SM_ORGANIZATION c where a.ORG_ID = c.ORG_ID and "
						+ " a.job_id = b.job_id and a.USER_ID=" + userId
						+ " and a.ORG_ID <> '" + orgId + "'";
				db1.executeSelect(strsql);
				for (int j = 0; j < db1.size(); j++) {
					if (!flag) {
						orgName = db1.getString(j, "org_name");
						flag = true;
					} else {
						orgName += "," + db1.getString(j, "org_name");
					}
				}
				return orgName;
			} catch (SQLException e) {
				e.printStackTrace();
				throw new ManagerException(e.getMessage());
			}

		} catch (SPIException e) {

			e.printStackTrace();
		}
		return orgName;

	}

	/**
	 * 根据当前机构id和页面传来的子机构ids进行机构的排序
	 * 
	 * @param String
	 *            orgId 父机构id
	 * @param String
	 *            [] orggroup 子机构ids
	 */
	public boolean sortOrg(String orgId, String[] sonOrgIds)
			throws ManagerException {
		boolean flag = false;
		DBUtil db = new DBUtil();
		try {
			String sql = null;
			String orderColumn = ConfigManager.getInstance().getConfigValue(
					"sys.orgOrder.column") == null ? "org_sn" : ConfigManager
					.getInstance().getConfigValue("sys.orgOrder.column");
			for (int i = 0; i < sonOrgIds.length; i++) {
				sql = "update td_sm_organization " + "set " + orderColumn
						+ " = " + (i + 1) + " where org_id = '" + sonOrgIds[i]
						+ "'";
				db.addBatch(sql);
			}
			if (sonOrgIds.length > 0)
				db.executeBatch();
			flag = true;

			Event event = new EventImpl(new Object[] { orgId, sonOrgIds },
					ACLEventType.ORGUNIT_INFO_SORT);
			super.change(event, true);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		} finally {
			db.resetBatch();
		}
		return flag;
	}

	/**
	 * 保存机构角色 insert into table (select value1 as col1, value2 as col2 from dual
	 * where not exist ( select * from table whre col1=value1 and col2=value2 ))
	 * 
	 * @param orgId
	 * @param roleIds
	 * @param flag
	 *            0=不递归保存到子机构;1=递归保存到子机构
	 * @return OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean storeOrgRole(String orgId, String[] roleIds, String flag) {
		boolean f = false;
		DBUtil db = new DBUtil();
		try {
			if (flag.equals("0")) {// 不递归保存到子机构
				for (int i = 0; i < roleIds.length; i++) {
					String sql = "insert into td_sm_orgrole(role_id,org_id)  (select '"
							+ roleIds[i]
							+ "' as role_id,'"
							+ orgId
							+ "' as org_id from dual where not exists ("
							+ "select * from td_sm_orgrole where role_id='"
							+ roleIds[i] + "' and org_id= '" + orgId + "') )";
					// logger.warn(sql);
					db.addBatch(sql);
				}
			} else {// 递归保存到子机构
				String orgs = "SELECT t.org_id FROM TD_SM_ORGANIZATION t START WITH"
						+ " t.org_id='"
						+ orgId
						+ "' CONNECT BY PRIOR t.org_id=t.PARENT_ID";
				DBUtil dbs = new DBUtil();
				dbs.executeSelect(orgs);
				for (int j = 0; j < dbs.size(); j++) {
					String orgId_ = dbs.getString(j, "org_id");
					for (int i = 0; i < roleIds.length; i++) {
						String sql = "insert into td_sm_orgrole(role_id,org_id) (select '"
								+ roleIds[i]
								+ "' as role_id ,'"
								+ orgId_
								+ "' as org_id from dual where not exists ("
								+ "select * from td_sm_orgrole where role_id='"
								+ roleIds[i]
								+ "' and org_id= '"
								+ orgId_
								+ "') )";
						logger.warn(sql);
						db.addBatch(sql);
					}
				}
			}
			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.ORGUNIT_ROLE_CHANGE);
			super.change(event, true);

			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}
		return f;
	}

	/**
	 * 保存机构角色 insert into table (select value1 as col1, value2 as col2 from dual
	 * where not exist ( select * from table whre col1=value1 and col2=value2 ))
	 * 
	 * @param orgId
	 * @param roleIds
	 * @param flag
	 *            0=不递归保存到子机构;1=递归保存到子机构
	 * @return OrgManagerImpl.java
	 * @author: ge.tao
	 */
	public boolean storeOrgRole(String orgIds[], String[] roleIds) {
		boolean f = false;
		DBUtil db = new DBUtil();
		try {

			for (int j = 0; j < orgIds.length; j++) {
				for (int i = 0; i < roleIds.length; i++) {
					String sql = "insert into td_sm_orgrole(role_id,org_id)  (select '"
							+ roleIds[i]
							+ "' as role_id,'"
							+ orgIds[j]
							+ "' as org_id from dual where not exists ("
							+ "select * from td_sm_orgrole where role_id='"
							+ roleIds[i]
							+ "' and org_id= '"
							+ orgIds[j]
							+ "') )";
					// logger.warn(sql);
					db.addBatch(sql);
				}
			}

			db.executeBatch();
			Event event = new EventImpl("", ACLEventType.ORGUNIT_ROLE_CHANGE);
			super.change(event, true);

			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.resetBatch();
		}
		return f;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#isBussinessDepartment(
	 * java.lang.String) 根据机构ID,判断该机构是否业务部门
	 */
	public boolean isBussinessDepartment(String orgId) {
		boolean result = false;
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			if (ISBUSINESSDEPARTMENT
					.equalsIgnoreCase(org.getIspartybussiness())) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#userBelongsCountyDepartment
	 * (java.lang.String) 机构类型的数据字典, 字典数据是保存在 TD_SM_DICTDATA 中 而且,字典的数据如下 省局 市州局
	 * 县区局 科所
	 */
	public Organization userBelongsCountyDepartment(String userId) {
		Organization org = null;
		String orgId = "";
		StringBuffer sql = new StringBuffer()
				.append("select org.ORG_LEVEL, ")
				.append("org.ORG_ID ")
				.append(
						"from td_sm_orguser ou join td_sm_organization org on org.org_id=ou.org_id ")
				.append("where ou.user_id=").append(userId);
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				if (db.getString(0, "ORG_LEVEL") != null) {
					String org_level = db.getString(0, "ORG_LEVEL");
					if (PROVINCEDEPARTMENT.equals(org_level)
							|| CITYDEPARTMENT.equals(org_level)) {
						// 用户在'省局'或者'市州局', 那么他所在的县区局 不存在
					} else if (COUNTYDEPARTMENT.equals(org_level)) {
						// 用户就在'县区局',则直接返回当前的机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org;
							}
						}
					} else {
						// 用户就在'科所',那么他属于所在的'县区局'是他的父机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg();
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return org;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#userBelongsCityDepartment
	 * (java.lang.String) 机构类型的数据字典, 字典数据是保存在 TD_SM_DICTDATA 中 而且,字典的数据如下 省局 市州局
	 * 县区局 科所
	 */
	public Organization userBelongsCityDepartment(String userId) {
		Organization org = null;
		String orgId = "";
		StringBuffer sql = new StringBuffer()
				.append("select org.ORG_LEVEL, ")
				.append("org.ORG_ID ")
				.append(
						"from td_sm_orguser ou join td_sm_organization org on org.org_id=ou.org_id ")
				.append("where ou.user_id=").append(userId);
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				if (db.getString(0, "ORG_LEVEL") != null) {
					String org_level = db.getString(0, "dictdata_name");
					if (PROVINCEDEPARTMENT.equals(org_level)) {
						// 用户在'省局', 那么他所在的市州局 不存在
					} else if (CITYDEPARTMENT.equals(org_level)) {
						// 用户就在'市州局',则直接返回当前的机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org;
							}
						}
					} else if (COUNTYDEPARTMENT.equals(org_level)) {
						// 用户就在'县区局',那么他属于所在的'市州局'是他的父机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg();
							}
						}
					} else {
						// 用户就在'科所',那么他属于所在的'市州局'是他的父机构的父机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg().getParentOrg();
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return org;
	}

	/**
	 * 根据用户ID,获取用户的省局
	 */
	public Organization userBelongsProvinceDepartment(String userId) {
		Organization org = null;
		String orgId = "";
		StringBuffer sql = new StringBuffer()
				.append("select org.ORG_LEVEL, ")
				.append("org.ORG_ID ")
				.append(
						"from td_sm_orguser ou join td_sm_organization org on org.org_id=ou.org_id ")
				.append("where ou.user_id=").append(userId);
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				if (db.getString(0, "ORG_LEVEL") != null) {
					String org_level = db.getString(0, "dictdata_name");
					if (PROVINCEDEPARTMENT.equals(org_level)) {
						if (db.getString(0, "org_id") != null) {
							org = OrgCacheManager.getInstance()
									.getOrganization(db.getString(0, "org_id"));
						}
						return org;
					} else if (CITYDEPARTMENT.equals(org_level)) {
						// 用户就在'市州局',则直接返回当前的机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg();
							}
						}
					} else if (COUNTYDEPARTMENT.equals(org_level)) {
						// 用户就在'县区局',那么他属于所在的'市州局'是他的父机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg().getParentOrg();
							}
						}
					} else {
						// 用户就在'科所',那么他属于所在的'市州局'是他的父机构的父机构
						if (db.getString(0, "org_id") != null) {
							orgId = db.getString(0, "org_id");
							if (orgId != null && !"".equals(orgId)) {
								org = OrgCacheManager.getInstance()
										.getOrganization(orgId);
								return org.getParentOrg().getParentOrg()
										.getParentOrg();
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return org;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#userBelongsBussinessDepartment
	 * (java.lang.String) 根据用户ID,获取用户所属的业务部门列表 List<Organization>
	 */
	public List userBelongsBussinessDepartment(String userId) {
		List orgs = new ArrayList();
		Organization org = null;
		String orgId = "";
		StringBuffer sql = new StringBuffer()
				.append("select org.org_id  ")
				.append(
						"from td_sm_orguser ou join td_sm_organization org on org.org_id=ou.org_id ")
				.append("where ou.user_id=").append(userId);
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				if (db.getString(0, "org_id") != null) {
					orgId = db.getString(0, "org_id");
					org = OrgCacheManager.getInstance().getOrganization(orgId);
					while (org.getParentOrg() != null) {
						if (ISBUSINESSDEPARTMENT.equalsIgnoreCase(org
								.getIspartybussiness())) {
							orgs.add(org);
						}
						org = org.getParentOrg();
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orgs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinacreator.sysmgrcore.manager.OrgManager#getUserManageOrgs(java
	 * .lang.String) 根据用户ID,获取用户管理机构列表 @return List<Organization> add by ge.tao
	 * date 2008-01-25
	 */
	public List getUserManageOrgs(String userId) {
		List orgs = null;
		if (userId == null || "".equalsIgnoreCase(userId)
				|| userId.trim().length() == 0)
			return orgs;
		orgs = new ArrayList();
		StringBuffer sql = new StringBuffer().append(
				"select t.org_id from td_sm_orgmanager t ").append(
				"where t.user_id=").append(userId);
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql.toString());
			for (int i = 0; i < db.size(); i++) {
				orgs.add(db.getString(i, "org_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orgs;
	}

	/**
	 * 根据机构ID递归得到机构的所有父节点，包括机构本身
	 * 
	 * @param orgId
	 * @return 返回机构ID数组
	 */
	public String[] getFatherOrg(String orgId, boolean isFather)
			throws ManagerException {
		String[] orgs = null;
		DBUtil db = new DBUtil();
		String sql = null;
		if (isFather) {
			sql = "select t.org_id from td_sm_organization t start with t.org_id='"
					+ orgId + "' connect by prior t.parent_id=t.org_id";
		} else {
			sql = "select t.org_id from td_sm_organization t start with t.org_id='"
					+ orgId + "' connect by prior t.org_id=t.parent_id";
		}
		try {
			db.executeSelect(sql);
			orgs = new String[db.size()];
			for (int i = 0; i < db.size(); i++) {
				orgs[i] = db.getString(i, "org_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ManagerException(e.getMessage());
		}
		return orgs;
	}

	/**
	 * 获取机构所属的科所机构
	 * 
	 * @param orgId
	 * @return Organization
	 * @author 危达
	 */
	public Organization orgBelongsMiniDepartment(String orgId) {
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			while (org.getParentOrg() != null) {
				if (MINIDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return org;
				} else if (PROVINCEDEPARTMENT.equalsIgnoreCase(org
						.getOrg_level())
						|| CITYDEPARTMENT.equalsIgnoreCase(org.getOrg_level())
						|| COUNTYDEPARTMENT
								.equalsIgnoreCase(org.getOrg_level())) {
					return null;
				}
				org = org.getParentOrg();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取机构所属的科室机构
	 * 
	 * @param orgId
	 * @return Organization
	 * @author 危达
	 */
	public Organization orgBelongsOfficeDepartment(String orgId) {
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			while (org.getParentOrg() != null) {
				if (OFFICEDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return org;
				} else if (PROVINCEDEPARTMENT.equalsIgnoreCase(org
						.getOrg_level())
						|| CITYDEPARTMENT.equalsIgnoreCase(org.getOrg_level())
						|| COUNTYDEPARTMENT
								.equalsIgnoreCase(org.getOrg_level())
						|| MINIDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return null;
				}
				org = org.getParentOrg();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取机构所属的县区机构
	 * 
	 * @param orgId
	 * @return Organization
	 * @author 危达
	 */
	public Organization orgBelongsCountryDepartment(String orgId) {
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			while (org.getParentOrg() != null) {
				if (COUNTYDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return org;
				} else if (PROVINCEDEPARTMENT.equalsIgnoreCase(org
						.getOrg_level())
						|| CITYDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return null;
				}
				org = org.getParentOrg();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取机构所属的市州机构
	 * 
	 * @param orgId
	 * @return Organization
	 * @author 危达
	 */
	public Organization orgBelongsCityDepartment(String orgId) {
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			while (org.getParentOrg() != null) {
				if (CITYDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return org;
				} else if (PROVINCEDEPARTMENT.equalsIgnoreCase(org
						.getOrg_level())) {
					return null;
				}
				org = org.getParentOrg();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取机构所属的省局机构
	 * 
	 * @param orgId
	 * @return Organization
	 * @author 危达
	 */
	public Organization orgBelongsProvinceDepartment(String orgId) {
		try {
			Organization org = OrgCacheManager.getInstance().getOrganization(
					orgId);
			while (org.getParentOrg() != null) {
				if (PROVINCEDEPARTMENT.equalsIgnoreCase(org.getOrg_level())) {
					return org;
				}
				org = org.getParentOrg();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 将用户调离机构，调入到其他机构时，删除用户关联的td_sm_orguser与td_sm_userjoborg表
	 * 该方法与UserManager中的addUserOrg(String[] userIds, String orgId, String
	 * classType) || storeBatchUserOrg(String[] userIds, String[] orgIds)连接执行，
	 * 注意此方法没有发事件!!!!! (1) boolean state2 =
	 * orgManager.deleteOrg_UserJob(CurorgId, userIds); if(state2){ state =
	 * userManager.storeBatchUserOrg(userId, orgId); }
	 * 
	 * (2) boolean state2 = orgManager.deleteOrg_UserJob(CurorgId, userIds);
	 * if(state2){ userManager.addUserOrg(userIds, orgId, "lisan"); }
	 * 
	 * @param orgId
	 * @param userIds
	 * @return
	 * @throws ManagerException
	 */
	public boolean deleteOrg_UserJob(String orgId, String userIds[])
			throws ManagerException {
		boolean state = false;
		DBUtil dbUtil = new DBUtil();
		DBUtil db = new DBUtil();
		StringBuffer delete_orgmanager = new StringBuffer();
		StringBuffer delete_orguser = new StringBuffer();
		StringBuffer delete_userjoborg = new StringBuffer();
		TransactionManager tm = new TransactionManager();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		try {
			tm.begin();
			for (int i = 0; i < userIds.length; i++) {
				// 删除用户主管机构
				if (!"all".equals(ConfigManager.getInstance().getConfigValue(
						"enableorgadminall"))) {
					delete_orgmanager.append(
							"delete td_sm_orgmanager where org_id='").append(
							orgId).append("' ").append("and user_id='").append(
							userIds[i]).append("' ");
					dbUtil.addBatch(delete_orgmanager.toString());
					delete_orgmanager.setLength(0);
				}

				// 删除用户主机构
				delete_orguser.append("delete td_sm_orguser where org_id='")
						.append(orgId).append("' ").append("and user_id='")
						.append(userIds[i]).append("'");
				dbUtil.addBatch(delete_orguser.toString());
				delete_orguser.setLength(0);

				// 删除用户机构岗位
				delete_userjoborg.append(
						"delete td_sm_userjoborg where org_id='").append(orgId)
						.append("' ").append("and user_id='")
						.append(userIds[i]).append("'");
				dbUtil.addBatch(delete_userjoborg.toString());
				delete_userjoborg.setLength(0);

				// 记录用户所在机构时的职位记录
				sql1
						.append(
								"SELECT a.*, b.job_name as jobname, o.remark5 as remark5 ")
						.append(
								"FROM td_sm_userjoborg a LEFT JOIN td_sm_job b ON a.job_id = b.job_id ")
						.append(
								"LEFT JOIN td_sm_organization o ON a.org_id = o.org_id where a.org_id = '")
						.append(orgId).append("' and a.user_id =").append(
								userIds[i]);
				db.executeSelect(sql1.toString());
				sql1.setLength(0);
				// 存数据到历史表TD_SM_USERJOBORG_HISTORY
				for (int j = 0; j < db.size(); j++) {
					int userid = db.getInt(j, "user_id");
					String jid = db.getString(j, "JOB_ID");
					String oid = db.getString(j, "ORG_ID");
					Date starttime = db.getDate(j, "JOB_STARTTIME");
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
									"',").append(DBUtil.getDBDate(starttime))
							.append(",").append(DBUtil.getDBDate(new Date()))
							.append(",0)");
					dbUtil.addBatch(sql2.toString());
					sql2.setLength(0);
				}
				// 删除用户的机构管理员信息
				// delete_userjoborg.append("delete td_sm_orgmanager where
				// org_id='").append(orgId).append("' ")
				// .append("and user_id='").append(userIds[i]).append("'");
				// dbUtil.addBatch(delete_userjoborg.toString());
				// delete_userjoborg.setLength(0);

			}
			dbUtil.executeBatch();
			tm.commit();
			state = true;
		} catch (SQLException e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			dbUtil.resetBatch();
			delete_orgmanager = null;
			delete_orguser = null;
			delete_userjoborg = null;
		}
		return state;
	}

	/**
	 * 得到用户可管理的所有机构
	 * 
	 * @param userId
	 * @return
	 * @throws ManagerException
	 */
	public List getUserAllManagerOrg(String userId) throws ManagerException {
		List list = new ArrayList();

		String orderColumn = ConfigManager.getInstance().getConfigValue(
				"sys.orgOrder.column") == null ? "org_sn" : ConfigManager
				.getInstance().getConfigValue("sys.orgOrder.column");
		/*
		 * StringBuffer all_orgs = new StringBuffer() .append("select distinct
		 * org.org_id,org."+orderColumn+" from td_sm_organization org start with
		 * org.org_id in(") //add by ge.tao //在union的地方distinct 防止破坏order by
		 * .append("select distinct abc.org_id from (") .append("select o.org_id
		 * from td_sm_organization o, td_sm_orgmanager om where ")
		 * .append("o.org_id = om.org_id and
		 * om.user_id='").append(userId).append("' union ") .append("select
		 * v.org_id from v_tb_res_org_user_write v where
		 * v.user_id='").append(userId).append("')") //add by ge.tao
		 * //在union的地方distinct 防止破坏order by .append(" abc ) ") .append(" connect
		 * by prior org.org_id = org.parent_id order siblings by
		 * org."+orderColumn+" ");
		 */
		StringBuffer all_orgs = new StringBuffer()
				.append(
						"select org.org_id,org."
								+ orderColumn
								+ " from td_sm_organization org start with org.org_id in(")
				.append(
						"select o.org_id from td_sm_organization o, td_sm_orgmanager om where ")
				.append("o.org_id = om.org_id and om.user_id='").append(userId)
				.append("'").append(") ").append(
						" connect by prior org.org_id = org.parent_id order siblings by org."
								+ orderColumn + "  ");
		DBUtil dBUtil = new DBUtil();
		try {
			dBUtil.executeSelect(all_orgs.toString());
			if (dBUtil.size() > 0) {
				for (int i = 0; i < dBUtil.size(); i++) {
					Organization organization = OrgCacheManager.getInstance()
							.getOrganization(dBUtil.getString(i, "org_id"));
					if (organization != null) {
						list.add(organization);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ManagerException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 判断用户是否是机构下的管理员
	 * 
	 * @param userId
	 * @param orgId
	 * @return
	 * @throws ManagerException
	 */
	public boolean userIsOrgManager(String userId, String orgId)
			throws ManagerException {
		String sql = " select * from td_sm_orgmanager om where om.user_id = '"
				+ userId + "' and om.org_id='" + orgId + "' ";
		DBUtil db = new DBUtil();
		try {
			db.executeSelect(sql);
			if (db.size() > 0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Map getSubOrgId(String userId, boolean isRoleAdmin) {
		DBUtil db = new DBUtil();
		Map map = null;
		StringBuffer sql = new StringBuffer();
		if (isRoleAdmin) {
			sql.append("select * from td_sm_organization");
		} else {
			sql
					.append(
							"select distinct * from td_sm_organization start with org_id in(")
					.append(
							"select org_id from td_sm_orgmanager where user_id='")
					.append(userId).append(
							"') connect by prior org_id=parent_id");
		}
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				map = new HashMap();
				for (int i = 0; i < db.size(); i++) {
					map.put(db.getString(i, "org_id"), db
							.getString(i, "org_id"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	public Map getParentOrgId(String userId) {
		DBUtil db = new DBUtil();
		Map map = null;
		StringBuffer sql = new StringBuffer()
				.append(
						"select distinct t.* from (select * from td_sm_organization ")
				.append(
						"start with org_id in(select org_id from td_sm_orgmanager where user_id='")
				.append(userId)
				.append("') connect by prior parent_id = org_id")
				.append(
						") t where t.org_id not in(select org_id from td_sm_orgmanager where user_id='")
				.append(userId).append("')");
		try {
			db.executeSelect(sql.toString());
			if (db.size() > 0) {
				map = new HashMap();
				for (int i = 0; i < db.size(); i++) {
					map.put(db.getString(i, "org_id"), db
							.getString(i, "org_id"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	public boolean isCurOrgManager(String curOrgId, String userId) {
		boolean state = false;
		DBUtil db = new DBUtil();
		String sql = "select * from td_sm_orgmanager where user_id=" + userId
				+ " and org_id='" + curOrgId + "'";
		try {
			db.executeSelect(sql);
			if (db.size() > 0) {
				state = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/**
	 * 机构基本信息拷贝
	 * 
	 * @param from
	 * @param to
	 */
	public static void orgcopy(Organization from, Organization to) {

		to.setOrgId(from.getOrgId());
		to.setOrgSn(from.getOrgSn());
		to.setOrgName(from.getOrgName());
		to.setParentId(from.getParentId());
		to.setPath(from.getPath());
		to.setLayer(from.getLayer());
		to.setChildren(from.getChildren());
		to.setCode(from.getCode());
		to.setJp(from.getJp());
		to.setQp(from.getQp());

		to.setCreatingtime(from.getCreatingtime());

		to.setCreator(from.getCreator());
		to.setOrgnumber(from.getOrgnumber());
		to.setOrgdesc(from.getOrgdesc());
		to.setRemark1(from.getRemark1());
		to.setRemark2(from.getRemark2());
		to.setRemark3(from.getRemark3());
		to.setRemark4(from.getRemark4());
		to.setRemark5(from.getRemark5());

		to.setChargeOrgId(from.getChargeOrgId());
		to.setSatrapJobId(from.getSatrapJobId());

		to.setIspartybussiness(from.getIspartybussiness());

		to.setOrg_level(from.getOrg_level());
		to.setOrg_xzqm(from.getOrg_xzqm());

		to.setIsdirectlyparty(from.getIsdirectlyparty());
		to.setIsforeignparty(from.getIsforeignparty());
		to.setIsjichaparty(from.getIsjichaparty());
		to.setIsdirectguanhu(from.getIsdirectguanhu());
	}

	/**
	 * 机构转移
	 * 
	 * @param orgId
	 *            需要转移的机构ID
	 * @param tranToOrgId
	 *            要转移到的机构ID
	 * @return
	 */
	public boolean tranOrg(String orgId, String tranToOrgId) {
		boolean state = false;
		DBUtil db = new DBUtil();
		StringBuffer sql = new StringBuffer().append(
				"update td_sm_organization set parent_id='")
				.append(tranToOrgId).append("' where org_id='").append(orgId)
				.append("'");
		try {
			db.executeUpdate(sql.toString());
			state = true;
			Event event = new EventImpl(new String[] { orgId, tranToOrgId },
					ACLEventType.ORGUNIT_INFO_TRAN);
			super.change(event, true);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return state;
	}

	/**
	 * 通过用户ID和岗位名称获取该用户所属机构列表 彭盛 2010-9-1
	 * 
	 * @param userId
	 *            用户ID
	 * @param jobName
	 *            岗位名称（兼职、借调...）
	 * @return 该用户所属机构列表
	 */
	public List getLoanOrgFromUserJob(String userId, String jobName) {
		List list = null;
		if (null != userId && null != jobName) {
			// 定义预编组件实例
			PreparedDBUtil preDBUtil = new PreparedDBUtil();
			// 创建SQL语句
			String sql = "select o.* from td_sm_organization o, td_sm_job a, td_sm_userjoborg b	where o.org_id = b.org_id and b.job_id = a.job_id 	and a.job_name = ?	and b.user_id = ?";
			try {
				// 预编sql语句
				preDBUtil.preparedSelect(sql);

				// 填充参数
				preDBUtil.setString(1, jobName.trim());
				preDBUtil.setString(2, userId);

				// 执行填充了参数的预编译语句
				preDBUtil.executePrepared();
				list = this.dbutilToOrganziationList(preDBUtil);
			} catch (SQLException e) {
				logger.error(e);
				e.printStackTrace();
				return null;
			}
		}
		return list;
	}

	// public static void main(String[] arg){
	// Organization org = new Organization();
	// Orgrole orgrole = new Orgrole();
	// Role role = new Role();
	// role.setRoleId("144");
	// orgrole.setOrganization(org);
	// orgrole.setRole(role);
	// org.setOrgId("73");//43
	// try {
	// boolean state = new OrgManagerImpl().deleteOrgrole(org);
	// System.out.println("state = " + state);
	//			
	// } catch (ManagerException e) {
	// e.printStackTrace();
	// }
	// }
	/**
	 * 生成机构码
	 * @author jian.liu
	 * @throws SQLException 
	 */
	public Organization getOrgGeneratingRules(Organization org) throws SQLException{
		String newOrgCode="";
		String parentOrgCode="";
		String str="000";
		if(!org.getOrg_level().equals("1")){
		      String sql="select max(remark1) as childOrgCode from  TD_SM_ORGANIZATION o where o.org_xzqm=? and o.orgnumber=? and o.remark4=?";
		      PreparedDBUtil pdb=new PreparedDBUtil();
		      pdb.preparedSelect(sql);
		      pdb.setString(1, org.getOrg_xzqm());
		      pdb.setString(2, org.getOrgnumber());
		      pdb.setString(3, org.getRemark4());
		      pdb.executePrepared();
		     if(pdb.size()>0){
		    	String childOrgCode=pdb.getString(0,"childOrgCode");
		    	if(!StringUtils.isEmpty(childOrgCode)){
		    	   str=getsecondOrgGeneratRules(childOrgCode.substring(childOrgCode.length()-3,childOrgCode.length()));
		    	}
			    	newOrgCode=org.getOrg_xzqm()+org.getOrgnumber()+org.getRemark4()+str;
	                org.setRemark1(newOrgCode);
		     }
		}
		return org;
	}
	/**
	 * 二级处室处理规则
	 * @author jian.liu
	 * @param str
	 * @return
	 */
	public  String getsecondOrgGeneratRules(String str) {
		str=String.valueOf(Integer.valueOf(str).intValue()+1);
		if(str.length()==1){
			str="00"+str;
		}else if(str.length()==2){
			str="0"+str;
		}
	    return str;
	}

	/**
	 * 查询机构类型
	 */
	public List<OrgAndTypeBean> queryOrgType() {
		List<OrgAndTypeBean> list=new ArrayList<OrgAndTypeBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t.org_typeid, t.org_typename from ta_oa_orgtype t");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i <pdb.size(); i++) {
				OrgAndTypeBean orgAndTypeBean= new OrgAndTypeBean();
				orgAndTypeBean.setOrgtype(pdb.getString(i, "org_typeid"));
				orgAndTypeBean.setOrgtypename(pdb.getString(i, "org_typename"));
				list.add(orgAndTypeBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	public boolean insertOrgAndType(OrgAndTypeBean orgAndTypeBean) {
		boolean flag=true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql.append("insert into ta_oa_organdtype");
		sql.append(" (id, org_typeid, org_id, orgsort_id, is_offline, is_leadorg ,is_office,five_major_org,sendaccount,sendpassword,sendorgcode)");
		sql.append("values");
		sql.append("  (seq_ta_oa_organdtype.nextval, ?, ?, ?, ?, ?,?,?,?,?,?)");
		sql1.append(" delete  ta_oa_organdtype t ");
		sql1.append(" where  t.org_id= ? ");
		
		try {
			pdb.preparedDelete(sql1.toString());
			pdb.setString(1, orgAndTypeBean.getOrgid());
			pdb.executePrepared();
			pdb.preparedInsert(sql.toString());
			pdb.setString(1,orgAndTypeBean.getOrgtype());
			pdb.setString(2, orgAndTypeBean.getOrgid());
			pdb.setString(3, orgAndTypeBean.getOrgsortid());
			pdb.setString(4, orgAndTypeBean.getIs_offline());
			pdb.setString(5, orgAndTypeBean.getIs_leadorg());
			pdb.setString(6, orgAndTypeBean.getIs_office());
			pdb.setString(7, orgAndTypeBean.getFive_major_org());
			//怀化发送短信 start 追加
			pdb.setString(8, orgAndTypeBean.getSendAccount());
			pdb.setString(9, orgAndTypeBean.getSendPassword());
			pdb.setString(10, orgAndTypeBean.getSendOrgCode());
			//怀化发送短信 end 追加
			pdb.executePrepared();
		} catch (SQLException e) {
			flag=false;
			e.printStackTrace();
		}
		return flag;
	}

	
	public boolean deleteOrgAndType(String orgId) {
		boolean flag=true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql.append(" delete  ta_oa_organdtype t ");
		sql.append(" where  t.org_id= ? ");
		try {
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, orgId);
			pdb.executePrepared();
		} catch (SQLException e) {
			flag=false;
			e.printStackTrace();
		}
		return flag;
	}

	
	public List<OrgAndTypeBean> queryTypeList(String orgId) {
		List<OrgAndTypeBean> list=new ArrayList<OrgAndTypeBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql.append(" select  t.org_typeid,t.org_typename,ot.sendaccount,ot.sendpassword,ot.sendorgcode from ta_oa_organdtype ot left join ta_oa_orgtype t");
		sql.append(" on ot.org_typeid=t.org_typeid");
		sql.append(" where ot.org_id='"+ orgId+"'");
		sql1.append(" select t.org_typeid, t.org_typename");
		sql1.append(" from ta_oa_orgtype t");
		sql1.append(" where t.org_typeid !=");
		sql1.append("  (select ot.org_typeid");
		sql1.append(" from ta_oa_organdtype ot ");
		sql1.append(" where ot.org_id = '"+orgId+"')");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				OrgAndTypeBean orgAndTypeBean=new OrgAndTypeBean();
				orgAndTypeBean.setOrgtype(pdb.getString(i, "org_typeid"));
				orgAndTypeBean.setOrgtypename(pdb.getString(i, "org_typename"));
				//怀化发送短信 start 追加
				orgAndTypeBean.setSendAccount(pdb.getString(i, "sendAccount"));
				orgAndTypeBean.setSendPassword(pdb.getString(i, "sendPassword"));
				orgAndTypeBean.setSendOrgCode(pdb.getString(i, "sendorgcode"));
				//怀化发送短信 end 追加
				list.add(orgAndTypeBean);
			}
			pdb1.preparedSelect(sql1.toString());
			pdb1.executePrepared();
			for (int i = 0; i < pdb1.size(); i++) {
				OrgAndTypeBean orgAndTypeBean=new OrgAndTypeBean();
				orgAndTypeBean.setOrgtype(pdb1.getString(i, "org_typeid"));
				orgAndTypeBean.setOrgtypename(pdb1.getString(i, "org_typename"));
				list.add(orgAndTypeBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	public boolean updateOrgType(OrgAndTypeBean orgAndTypeBean) {
		boolean flag=true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil pdb1 = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql.append(" update ta_oa_organdtype t set t.org_typeid= ?,t.orgsort_id= ?,t.is_offline= ? , t.is_leadorg= ? , t.is_office= ? ,t.five_major_org = ? " );
		sql.append(",t.sendaccount = ?,t.sendpassword = ?,t.sendorgcode = ?");
		sql.append(" where t.org_id= ? " );
		sql1.append(" select * from ta_oa_organdtype oat " );
		sql1.append(" where oat.org_id= ? " );
		try {
			pdb1.preparedSelect(sql1.toString());
			pdb1.setString(1, orgAndTypeBean.getOrgid());
			pdb1.executePrepared();
			if(pdb1.size()!=0) {
				pdb.preparedUpdate(sql.toString());
				pdb.setString(1, orgAndTypeBean.getOrgtype());
				pdb.setString(2, orgAndTypeBean.getOrgsortid());
				pdb.setString(3, orgAndTypeBean.getIs_offline());
				pdb.setString(4, orgAndTypeBean.getIs_leadorg());
				pdb.setString(5, orgAndTypeBean.getIs_office());
				pdb.setString(6, orgAndTypeBean.getFive_major_org());
				//怀化发送短信 start 追加
				pdb.setString(7, orgAndTypeBean.getSendAccount());
				pdb.setString(8, orgAndTypeBean.getSendPassword());
				pdb.setString(9, orgAndTypeBean.getSendOrgCode());
				//怀化发送短信 end 追加
				pdb.setString(10, orgAndTypeBean.getOrgid());
				pdb.executePrepared();
			}else {
				insertOrgAndType(orgAndTypeBean);
			}
			
		} catch (SQLException e) {
			flag=false;
			e.printStackTrace();
		}
		return flag;
	}

	/* (non-Javadoc)
	 * @see com.chinacreator.sysmgrcore.manager.OrgManager#queryLookType(java.lang.String)
	 */

	public List<OrgAndTypeBean> queryLookType(String orgId) {
		List<OrgAndTypeBean> list=new ArrayList<OrgAndTypeBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();

		sql.append("select t.org_typeid, t.org_typename, o.orgsort_name, decode(ot.is_offline,'Y','是','N','否') is_offline , ");
		sql.append("  decode(ot.is_leadorg,'Y','是','N','否') is_leadorg ,");
		sql.append("  decode(ot.is_office,'Y','是','N','否') is_office, ");
		sql.append("  decode(ot.five_major_org,'Y','是','N','否') five_major_org ");
		sql.append("   from ta_oa_organdtype ot ");
		sql.append("   left join ta_oa_orgtype t on ot.org_typeid = t.org_typeid ");
		sql.append("   left join ta_oa_orgsort o on o.orgsort_id = ot.orgsort_id ");
		sql.append("  where ot.org_id = '"+ orgId+"' ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				OrgAndTypeBean orgAndTypeBean=new OrgAndTypeBean();
				orgAndTypeBean.setOrgtype(pdb.getString(i, "org_typeid"));
				orgAndTypeBean.setOrgtypename(pdb.getString(i, "org_typename"));
				orgAndTypeBean.setOrgsortname(pdb.getString(i, "orgsort_name"));
				orgAndTypeBean.setIs_offline(pdb.getString(i, "is_offline"));
				orgAndTypeBean.setIs_leadorg(pdb.getString(i, "is_leadorg"));
				orgAndTypeBean.setIs_office(pdb.getString(i, "is_office"));
				orgAndTypeBean.setFive_major_org(pdb.getString(i, "five_major_org"));
				list.add(orgAndTypeBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 queryTypeBean
	  * @param orgId
	  * @return 
	  * @see com.chinacreator.sysmgrcore.manager.OrgManager#queryTypeBean(java.lang.String)
	 */
	public OrgAndTypeBean queryTypeBean(String orgId) {
		OrgAndTypeBean orgAndTypeBean=new OrgAndTypeBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select ot.sendaccount,ot.sendpassword,ot.sendorgcode from ta_oa_organdtype ot ");
		sql.append(" where ot.org_id='"+ orgId+"'");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				orgAndTypeBean.setSendAccount(pdb.getString(i, "sendAccount"));
				orgAndTypeBean.setSendPassword(pdb.getString(i, "sendPassword"));
				orgAndTypeBean.setSendOrgCode(pdb.getString(i, "sendorgcode"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orgAndTypeBean;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateOrg_UserRole
	  * @param orgIds
	  * @param userIds
	  * @return
	  * @throws ManagerException 
	  * @see com.chinacreator.sysmgrcore.manager.OrgManager#updateOrg_UserRole(java.lang.String, java.lang.String[]) 
	  */
	@Override
	public boolean updateOrg_UserRole(String orgIds[], String[] userIds){
		boolean r = false;
		TransactionManager tm = new TransactionManager();
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
	
			if (userIds != null) {
				tm.begin();
				for (int i = 0; i < userIds.length; i++) {
					String userId = userIds[i];
					String orgId = orgIds[0];
					if ("1".equalsIgnoreCase(userId))
						continue;
					
					
					StringBuffer buffer = new  StringBuffer("update td_sm_userrole set org_id = '"+orgId+"' where USER_ID='"
							+ userId + "'");
					pdb.executeUpdate(buffer.toString());
	
				}
				tm.commit();
				r = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
		} 
		return r;
	}
	
}
package com.chinacreator.xtbg.core.process.processconfig.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.enhydra.shark.SharkUtilities;
import org.enhydra.shark.xpdl.elements.Activity;
import org.enhydra.shark.xpdl.elements.WorkflowProcess;

import com.chinacreator.spi.api.WorkflowManager;
import com.chinacreator.spi.bean.ActivityBean;
import com.chinacreator.spi.impl.local.WorkflowManagerImpl;
import com.chinacreator.workflow.shark.SharkEngine;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.cache.dao.UserCacheDao;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.tree.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.DictDropDownList;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActColStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.ActTextStatusBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowFormBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.core.process.processconfig.entity.OaWordTemplate;
import com.frameworkset.common.poolman.CallableDBUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:FlowInfoDaoImpl.java
 * </p>
 *<p>
 * Description:流程配置Dao实现类
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 黄艺平
 *@version 1.0 2013-4-22
 */
public class FlowInfoDaoImpl extends XtDbBaseDao implements FlowInfoDao {

	private static final Logger LOG = Logger.getLogger(FlowInfoDaoImpl.class);
	private String MGRNAME_SPLIT_TOKEN = "#";

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowBaseInfoList
	 * 
	 * @param flowInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowBaseInfoList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowBaseInfoList(FlowInfoBean flowInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<FlowInfoBean> list = new ArrayList<FlowInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		f.flow_id,");
		sql.append(" 		f.flow_name,");
		sql.append(" 		f.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		f.org_id,");
		sql.append(" 		o.org_name,");
		sql.append(" 		f.is_indivi,");
		sql.append(" 		f.is_valid,");
		sql.append("        f.create_time,");
		sql.append("        f.flow_limit,");
		sql.append("        f.limit_unit");
		sql.append(" from OA_FLOW_BASEINFO f ");
		sql.append(" left join td_sm_organization o ");
		sql.append(" on o.org_id=f.org_id ");
		sql.append(" left join oa_flow_busitype t  ");
		sql.append(" on f.busitype_code=t.busitype_code ");
		sql.append(" where 1=1");
		if (!StringUtil.nullOrBlank(flowInfoBean.getFlow_name())) {
			sql.append(" and f.flow_name like '%").append(
					flowInfoBean.getFlow_name()).append("%'");
		}
		if (!StringUtil.nullOrBlank(flowInfoBean.getOrg_name())) {
			String[] name=flowInfoBean.getOrg_name().split(",");
			sql.append(" and o.org_name in (");
			for (String orgname : name) {
				sql.append(" '"+orgname+"',");
			}
			sql.append("'' )");
		}
		if (!StringUtil.nullOrBlank(flowInfoBean.getFlow_id())) {
			sql.append(" and f.flow_id <> '").append(
					flowInfoBean.getFlow_id()).append("'");
		}
		sql.append(" order by " + sortName+" " +sortOrder+ ",rownum ");

		db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			FlowInfoBean fib = new FlowInfoBean();
			fib.setFlow_id(db.getString(i, "flow_id"));
			fib.setFlow_name(db.getString(i, "flow_name"));
			fib.setBusitype_code(db.getString(i, "busitype_code"));
			fib.setBusitype_name(db.getString(i, "busitype_name"));
			fib.setOrg_id(db.getString(i, "org_id"));
			fib.setOrg_name(db.getString(i, "org_name"));
			fib.setIs_indivi(changeString(db.getString(i, "is_indivi")));
			fib.setIs_valid(db.getString(i, "is_valid"));
			fib.setCreate_time(DateUtil.getTimeString(db.getTimestamp(i,
					"create_time")));
			fib.setFlow_limit(StringUtil.deNull(db.getString(i, "flow_limit")
					+ changeString(db.getString(i, "limit_unit"))));
			fib.setLimit_unit(db.getString(i, "limit_unit"));
			list.add(fib);
		}

		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * 
	 *<b>Summary: 字符转换</b> changeString(请用一句话描述这个方法的作用)
	 * 
	 * @param unit
	 * @return
	 */
	public String changeString(String unit) {
		String u = null;
		if (unit.equals("D")) {
			u = "天";
		} else if (unit.equals("H")) {
			u = "小时";
		} else if (unit.equals("Y")) {
			u = "是";
		} else if (unit.equals("N")) {
			u = "否";
		}
		return u;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowDefInfoList
	 * 
	 * @param flowDefInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowDefInfoList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowDefInfoList(FlowDefInfoBean flowDefInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<FlowDefInfoBean> list = new ArrayList<FlowDefInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		def_id,");
		sql.append(" 		flow_defid,");
		sql.append(" 		flow_id,");
		sql.append(" 		flow_version,");
		sql.append(" 		package_id,");
		sql.append(" 		is_valid,flow_desc,");
		sql.append("        create_time");
		sql.append(" from oa_flow_definfo where flow_id = ?");
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, flowDefInfoBean.getFlow_id());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				FlowDefInfoBean fdib = new FlowDefInfoBean();
				fdib.setDef_id(db.getString(i, "def_id"));
				fdib.setFlow_defid(db.getString(i, "flow_defid"));
				fdib.setFlow_id(db.getString(i, "flow_id"));
				fdib.setFlow_version(db.getString(i, "flow_version"));
				fdib.setPackage_id(db.getString(i, "package_id"));
				fdib.setIs_valid("Y".equals(db.getString(i, "is_valid")) ? "是"
						: "否");
				fdib.setFlow_desc(db.getString(i, "flow_desc"));
				fdib.setCreate_time(DateUtil.getTimeString(db.getTimestamp(0,
						"create_time")));
				list.add(fdib);
			}
		} catch (SQLException e) {
			LOG.error("执行流程定义列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionInfoList
	 * 
	 * @param flowWfactionInfoBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowWfactionInfoList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowWfactionInfoList(
			FlowWfactionInfoBean flowWfactionInfoBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<FlowWfactionInfoBean> list = new ArrayList<FlowWfactionInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		a.action_id,");
		sql.append(" 		a.def_id,");
		sql.append(" 		a.action_name,");
		sql.append(" 		a.action_alias,");
		sql.append(" 		a.limit_unit,");
		sql.append(" 		a.action_limit,");
		sql.append(" 		a.remark,");
		sql.append("        a.create_time");
		sql.append(" from oa_flow_wfaction a ");
		sql.append(" inner join oa_flow_definfo b on b.def_id = a.def_id ");
		sql.append(" where b.flow_id = ? and b.is_valid = 'Y'"
				+ " order by length(a.action_defid),a.action_defid");
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, flowWfactionInfoBean.getFlow_id());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
				fwib.setAction_id(db.getString(i, "action_id"));
				fwib.setDef_id(db.getString(i, "def_id"));
				fwib.setAction_name(db.getString(i, "action_name"));
				fwib.setAction_alias(db.getString(i, "action_alias"));
				fwib.setAction_limit(db.getString(i, "action_limit"));
				fwib.setLimit_unit(changeString(db.getString(i, "limit_unit")));
				fwib.setRemark(db.getString(i, "remark"));
				fwib.setCreate_time(DateUtil.getTimeString(db.getTimestamp(i,
						"create_time")));
				list.add(fwib);
			}
		} catch (SQLException e) {
			LOG.error("执行流程活动定义列表查询报错：" + e.getMessage(), e);
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionUserInfoList
	 * 
	 * @param flowWfactUser
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowWfactionUserInfoList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findFlowWfactionUserInfoList(FlowWfactUser flowWfactUser,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<FlowWfactUser> list = new ArrayList<FlowWfactUser>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		f.wfactuser_id,");
		sql.append(" 		f.action_id,");
		sql.append(" 		f.user_id,");
		sql.append(" 		f.user_name,");
		sql.append(" 		u.user_realname,");
		sql
				.append(" 		decode(actuser_type,'1','用户','2','角色','3','用户组','other') actuser_type,");
		sql.append("        create_time");
		sql.append(" from OA_FLOW_WFACTUSER f ,td_sm_user u");
		sql.append("  where action_id = ? and f.user_id= u.user_id");

		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, flowWfactUser.getAction_id());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				FlowWfactUser fwu = new FlowWfactUser();
				fwu.setAction_id(db.getString(i, "action_id"));
				fwu.setWfactuser_id(db.getString(i, "wfactuser_id"));
				fwu.setUser_id(db.getString(i, "user_id"));
				fwu.setUser_name(db.getString(i, "user_realname"));
				fwu.setActuser_type(db.getString(i, "actuser_type"));
				fwu.setCreate_time(DateUtil.getTimeString(db.getTimestamp(0,
						"create_time")));

				list.add(fwu);
			}
		} catch (SQLException e) {
			LOG.error("执行活动用户列表查询报错：" + e.getMessage(), e);
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowBaseInfo
	 * 
	 * @param flowInfoBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowBaseInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean)
	 */
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean, Connection conn)
			throws Exception {

		// PreparedDBUtil pdb = new PreparedDBUtil();
		// StringBuffer sql = new StringBuffer();
		// StringBuffer sql2 = new StringBuffer();
		// String new_flow_id = "";
		// sql
		// .append("select seq_flow_flowbaseinfo.nextval new_flow_id from dual");
		// sql2
		// .append(
		// "insert into OA_FLOW_BASEINFO (flow_id,flow_name,busitype_code,org_id,is_indivi,is_valid,flow_limit,limit_unit,create_time)")
		// .append(" values (?,?,?,?,?,?,?,?,?)");
		// pdb.preparedSelect(sql.toString());
		// pdb.executePrepared();
		// new_flow_id = pdb.getString(0, "new_flow_id");
		//
		// pdb.preparedInsert(sql2.toString());
		// pdb.setString(1, new_flow_id);
		// pdb.setString(2, StringUtil.deNull(flowInfoBean.getFlow_name()));
		// pdb.setString(3, StringUtil.deNull(flowInfoBean.getBusitype_code()));
		// pdb.setString(4, StringUtil.deNull(flowInfoBean.getOrg_id()));
		// pdb.setString(5, "N");
		// pdb.setString(6, StringUtil.deNull(flowInfoBean.getIs_valid()));
		// pdb.setString(7, StringUtil.deNull(flowInfoBean.getFlow_limit()));
		// pdb.setString(8, StringUtil.deNull(flowInfoBean.getLimit_unit()));
		// pdb.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
		// pdb.executePrepared();
		/**
		 * 屏蔽掉原来的插入方法，重新定义插入方法
		 * 
		 * @author 戴连春 2013-06-04
		 */
		if (null == flowInfoBean) {
			return "";
		}
		// 新的流程id
		String newFlowId = StringUtil.getUUID();
		flowInfoBean.setFlow_id(newFlowId);// 设置主键
		flowInfoBean.setIs_indivi("N");// 是否个性化流程设置为否
		// 设置创建时间
		flowInfoBean.setCreate_time(new Timestamp(System.currentTimeMillis()));
		// 调用父类方法，插入数据
		super.insert(flowInfoBean, conn);
		return newFlowId;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowDefInfo
	 * 
	 * @param flowDefInfoBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowDefInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean)
	 */
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			return addFlowDefInfo(flowDefInfoBean, conn);
		} finally {
			DbManager.closeConnection(conn);
		}

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowWfactionInfo
	 * 
	 * @param flowWfactionInfoBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowWfactionInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean)
	 */
	public String addFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql2 = new StringBuffer();
		String new_action_id = StringUtil.getUUID();
		sql2
				.append(
						"insert into OA_FLOW_WFACTION (action_id,def_id,action_name,action_alias,limit_unit,action_limit,remark,create_time)")
				.append(" values (?,?,?,?,?,?,?,?)");

		pdb.preparedInsert(sql2.toString());
		pdb.setString(1, new_action_id);
		pdb.setString(2, flowWfactionInfoBean.getDef_id());
		pdb.setString(3, flowWfactionInfoBean.getAction_name());
		pdb.setString(4, flowWfactionInfoBean.getAction_alias());
		pdb.setString(5, flowWfactionInfoBean.getLimit_unit());
		pdb.setString(6, flowWfactionInfoBean.getAction_limit());
		pdb.setString(7, flowWfactionInfoBean.getRemark());
		pdb.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
		pdb.executePrepared();
		return null;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryInstance
	 * 
	 * @param flowid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#queryInstance(java.lang.String)
	 */
	public boolean queryInstance(String flowid) throws SQLException {
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ta_oa_ins_instance i");
		sql.append("where  i.flow_id= '" + flowid + "'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if (pdb.size() > 0) {
			flag = true;
		}
		return flag;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowBaseInfoById
	 * 
	 * @param flowids
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowBaseInfoById(java.lang.String)
	 */
	public String deleteFlowBaseInfoById(String flowids, Connection conn)
			throws SQLException {
		
		CallableDBUtil cdb = new CallableDBUtil();
		String flag="false";
		if (!StringUtil.nullOrBlank(flowids)) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call deleteFlowInfo(?)}");
			cdb.setString(1, flowids);
			cdb.executeCallable(conn);	
			flag="true";
		}
		return flag;
	}

	/**
	 * 
	 *<b>Summary: 业务数据元关系表的数据</b> deleteBusinessMappingByFlowId(请用一句话描述这个方法的作用)
	 * 
	 * @param flowids
	 *            流程id
	 * @param conn
	 *            数据库连接
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public void deleteBusinessMappingByFlowId(String flowids, Connection conn)
			throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from oa_md_table_business_mapping m");
		sql.append(" where exists (select f.busitype_code");
		sql.append("          from oa_flow_baseinfo f");
		sql
				.append("         where trim(m.busitype_code) = trim(f.busitype_code)");
		sql.append("           and instr ('," + flowids.replaceAll("'", "")
				+ ",',','||flow_id||',')>0 )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		if (null != conn) {
			pdb.executePrepared(conn);
		} else {
			pdb.executePrepared();
		}

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowDefInfoById
	 * 
	 * @param flowdefid
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowDefInfoById(java.lang.String)
	 */
	public void deleteFlowDefInfoById(String flowdefid) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			deleteFlowDefInfoById(flowdefid, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowWfactionInfoById
	 * 
	 * @param actionid
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowWfactionInfoById(java.lang.String)
	 */
	public void deleteFlowWfactionInfoById(String actionid) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			deleteFlowWfactionInfoById(actionid, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowBaseInfoById
	 * 
	 * @param flowid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowBaseInfoById(java.lang.String)
	 */
	public FlowInfoBean findFlowBaseInfoById(String flowid) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		t.flow_id,");
		sql.append(" 		t.flow_name,");
		sql.append(" 		t.busitype_code,");
		sql.append(" 		t.org_id,");
		sql.append(" 		o.org_name,");
		sql.append(" 		t.limit_unit,");
		sql.append(" 		t.flow_limit,");
		sql.append(" 		t.is_valid,t.insname_rule,");
		sql.append("        t.create_time,t.from_path,m.table_id,t.flow_tyle,t.template_id, t.form_image_id,t.attach_id,next_flow_id ");
		sql.append(" from oa_flow_baseinfo t ");
		sql.append(" left join td_sm_organization o on o.org_id = t.org_id ");
		sql.append(" left join oa_md_table_business_mapping m "
				+ "on trim(m.busitype_code) = trim(t.busitype_code) ");
		sql.append(" where t.flow_id = ?  ");
		FlowInfoBean fib = new FlowInfoBean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, flowid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fib.setFlow_id(StringUtil.deNull(pdb.getString(0, "flow_id")));
			fib.setFlow_name(StringUtil.deNull(pdb.getString(0, "flow_name")));
			fib.setBusitype_code(StringUtil.deNull(pdb.getString(0,
					"busitype_code")));
			fib.setOrg_name(StringUtil.deNull(pdb.getString(0, "org_name")));
			fib.setOrg_id(StringUtil.deNull(pdb.getString(0, "org_id")));
			fib.setLimit_unit(StringUtil.deNull(pdb.getString(0,"limit_unit")));
			fib.setFlow_limit(StringUtil.deNull(pdb.getString(0,"flow_limit")));
			fib.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
			fib.setCreate_time(DateUtil.getTimeString(pdb.getTimestamp(0,"create_time")));
			fib.setFrom_path(pdb.getString(0, "from_path"));
			fib.setTable_id(pdb.getString(0, "table_id"));
			fib.setInsname_rule(pdb.getString(0, "insname_rule"));
			fib.setFlow_tyle(pdb.getString(0, "flow_tyle"));
			fib.setTemplate_id(pdb.getString(0, "template_id"));
			fib.setForm_image_id(pdb.getString(0, "form_image_id"));
			fib.setAttach_id(pdb.getString(0, "attach_id"));
			fib.setNext_flow_id(pdb.getString(0, "next_flow_id"));
		}
		return fib;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowDefInfoByFlowId
	 * 
	 * @param flowid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowDefInfoByFlowId(java.lang.String)
	 */
	public FlowDefInfoBean findFlowDefInfoByFlowId(String flowid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		def_id,");
		sql.append(" 		flow_defid,");
		sql.append(" 		flow_id,");
		sql.append(" 		flow_version,");
		sql.append(" 		package_id,");
		sql.append(" 		is_valid,flow_desc,");
		sql.append("        create_time");
		sql.append(" from oa_flow_definfo where flow_id = ? and is_valid ='Y'");
		FlowDefInfoBean fdib = new FlowDefInfoBean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, flowid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fdib.setDef_id(StringUtil.deNull(pdb.getString(0, "def_id")));
			fdib.setFlow_defid(StringUtil
					.deNull(pdb.getString(0, "flow_defid")));
			fdib.setFlow_id(StringUtil.deNull(pdb.getString(0, "flow_id")));
			fdib.setFlow_version(StringUtil.deNull(pdb.getString(0,
					"flow_version")));
			fdib.setPackage_id(StringUtil
					.deNull(pdb.getString(0, "package_id")));
			fdib.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
			fdib.setFlow_desc(StringUtil.deNull(pdb.getString(0, "flow_desc")));
			fdib.setCreate_time(DateUtil.getTimeString(pdb.getTimestamp(0,
					"create_time")));
		}
		return fdib;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionInfoById
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowWfactionInfoById(java.lang.String)
	 */
	public FlowWfactionInfoBean findFlowWfactionInfoById(String actionid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		action_id,");
		sql.append(" 		def_id,");
		sql.append(" 		action_name,");
		sql.append(" 		action_alias,");
		sql.append(" 		limit_unit,");
		sql.append(" 		action_limit,");
		sql.append(" 		remark,");
		sql.append("        create_time");
		sql.append(" from OA_FLOW_WFACTION where action_id = ?");
		FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, actionid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fwib.setAction_id(StringUtil.deNull(pdb.getString(0, "action_id")));
			fwib.setDef_id(StringUtil.deNull(pdb.getString(0, "def_id")));
			fwib.setAction_name(StringUtil.deNull(pdb.getString(0,
					"action_name")));
			fwib.setAction_alias(StringUtil.deNull(pdb.getString(0,
					"action_alias")));
			fwib.setAction_limit(StringUtil.deNull(pdb.getString(0,
					"action_limit")));
			fwib.setLimit_unit(StringUtil
					.deNull(pdb.getString(0, "limit_unit")));
			fwib.setRemark(StringUtil.deNull(pdb.getString(0, "remark")));
			fwib.setCreate_time(DateUtil.getTimeString(pdb.getTimestamp(0,
					"create_time")));
		}
		return fwib;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateFlowBaseInfo
	 * 
	 * @param flowInfoBean
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#updateFlowBaseInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean)
	 */
	public void updateFlowBaseInfo(FlowInfoBean flowInfoBean)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_BASEINFO set ");
		sql.append("flow_name = ?,");
		sql.append("org_id = ?,");
		sql.append("is_valid = ?,");
		sql.append("flow_limit = ?,");
		sql.append("limit_unit = ?,");
		sql.append("busitype_code = ?,");
		sql.append("from_path=?,");
		sql.append("insname_rule=?,");
		sql.append("flow_tyle=?,");
		sql.append("template_id=?,");
		sql.append("form_image_id=?,");
		sql.append("attach_id=?,next_flow_id=?");		
		sql.append(" where flow_id = ?");

		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowInfoBean.getFlow_name());
		pdb.setString(2, flowInfoBean.getOrg_id());
		pdb.setString(3, flowInfoBean.getIs_valid());
		pdb.setString(4, flowInfoBean.getFlow_limit());
		pdb.setString(5, flowInfoBean.getLimit_unit());
		pdb.setString(6, flowInfoBean.getBusitype_code().trim());
		pdb.setString(7, flowInfoBean.getFrom_path());
		pdb.setString(8, flowInfoBean.getInsname_rule());
		pdb.setString(9, flowInfoBean.getFlow_tyle());
		pdb.setString(10, flowInfoBean.getTemplate_id());
		pdb.setString(11, flowInfoBean.getForm_image_id());
		pdb.setString(12, flowInfoBean.getAttach_id());
		pdb.setString(13, flowInfoBean.getNext_flow_id());
		pdb.setString(14, flowInfoBean.getFlow_id());
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateFlowDefInfo
	 * 
	 * @param flowDefInfoBean
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#updateFlowDefInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean)
	 */
	public void updateFlowDefInfo(FlowDefInfoBean flowDefInfoBean)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_definfo set flow_defid = ?,");
		sql.append("flow_id = ?,");
		sql.append("flow_version = ?,");
		sql.append("package_id = ?,");
		sql.append("is_valid = ?,");
		sql.append(" where def_id = ?");

		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowDefInfoBean.getFlow_defid());
		pdb.setString(2, flowDefInfoBean.getFlow_id());
		pdb.setString(3, flowDefInfoBean.getFlow_version());
		pdb.setString(4, flowDefInfoBean.getPackage_id());
		pdb.setString(5, flowDefInfoBean.getIs_valid());
		pdb.setString(6, flowDefInfoBean.getDef_id());
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateFlowWfactionInfo
	 * 
	 * @param flowWfactionInfoBean
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#updateFlowWfactionInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionInfoBean)
	 */
	public void updateFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_WFACTION set ");
		sql.append("action_name = ?,");
		sql.append("action_alias = ?,");
		sql.append("limit_unit = ?,");
		sql.append("action_limit = ?,");
		sql.append("remark = ?");
		sql.append(" where action_id = ?");

		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowWfactionInfoBean.getAction_name());
		pdb.setString(2, flowWfactionInfoBean.getAction_alias());
		pdb.setString(3, flowWfactionInfoBean.getLimit_unit());
		pdb.setString(4, flowWfactionInfoBean.getAction_limit());
		pdb.setString(5, flowWfactionInfoBean.getRemark());
		pdb.setString(6, flowWfactionInfoBean.getAction_id());
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowWfactionExtInfo
	 * 
	 * @param flowWfactionExtBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowWfactionExtInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionExtBean)
	 */
	public String addFlowWfactionExtInfo(FlowWfactionExtBean flowWfactionExtBean)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql2 = new StringBuffer();
		String new_wfactionext_id = StringUtil.getUUID();
		sql2.append(
				"insert into OA_FLOW_WFACTIONEXT (actionext_id,action_id,"
						+ "isshowuser,isshowreject,isshowback,create_time,"
						+ " autoassignment, issignjoinbyorder,isdispense,is_auto_complete)").append(
				" values (?,?,?,?,?,?,?,?,?,?)");

		pdb.preparedInsert(sql2.toString());
		pdb.setString(1, new_wfactionext_id);
		pdb.setString(2, flowWfactionExtBean.getAction_id());
		pdb.setString(3, flowWfactionExtBean.getIsshowuser());
		pdb.setString(4, flowWfactionExtBean.getIsshowreject());
		pdb.setString(5, flowWfactionExtBean.getIsshowback());
		pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
		pdb.setString(7, flowWfactionExtBean.getAutoassignment());
		pdb.setString(8, flowWfactionExtBean.getIssignjoinbyorder());
		pdb.setString(9, flowWfactionExtBean.getIsdispense());
		pdb.setString(10, flowWfactionExtBean.getIs_auto_complete());
		pdb.executePrepared();
		return new_wfactionext_id;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowWfactionFormDef
	 * 
	 * @param flowWfactionFormDefBean
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowWfactionFormDef(com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef)
	 */
	public String addFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String new_wfactionformdef_id = "";
		sql
				.append("select seq_flow_action_fromdefid.nextval new_wfactionformdef_id from dual");
		sql2
				.append(
						"insert into OA_FLOW_ACTIONFROMDEFID (form_id,action_id,action_form)")
				.append(" values (?,?,?)");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		new_wfactionformdef_id = pdb.getString(0, "new_wfactionformdef_id");

		pdb.preparedInsert(sql2.toString());
		pdb.setString(1, new_wfactionformdef_id);
		pdb.setString(2, flowWfactionFormDefBean.getAction_id());
		pdb.setString(3, flowWfactionFormDefBean.getAction_form());
		pdb.executePrepared();
		return new_wfactionformdef_id;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowWfactionUserInfo
	 * 
	 * @param flowWfactUser
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowWfactionUserInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactUser)
	 */
	public String addFlowWfactionUserInfo(FlowWfactUser flowWfactUser)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		String[] userids = flowWfactUser.getUser_id().split(",");
		String[] usernames = flowWfactUser.getUser_name().split(",");
		sql2
				.append(
						"insert into OA_FLOW_WFACTUSER (wfactuser_id,action_id,user_id,user_name,actuser_type,create_time)")
				.append(" values (?,?,?,?,?,?)");
		sql3
				.append("select * from OA_FLOW_WFACTUSER where user_id=? and action_id=?");
		for (int i = 0; i < userids.length; i++) {
			pdb.preparedSelect(sql3.toString());
			pdb.setString(1, userids[i]);
			pdb.setString(2, flowWfactUser.getAction_id());
			pdb.executePrepared();
			if (pdb.size() == 0) {
				pdb.preparedInsert(sql2.toString());
				pdb.setString(1, StringUtil.getUUID());
				pdb.setString(2, flowWfactUser.getAction_id());
				pdb.setString(3, userids[i]);
				pdb.setString(4, usernames[i]);
				pdb.setString(5, flowWfactUser.getActuser_type());
				pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
				pdb.executePrepared();

			}
		}

		return "";
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowWfactionFormDefById
	 * 
	 * @param actionid
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowWfactionFormDefById(java.lang.String)
	 */
	public void deleteFlowWfactionFormDefById(String actionid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from OA_FLOW_ACTIONFROMDEFID where action_id = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, actionid);
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowWfactionUserInfoById
	 * 
	 * @param userids
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowWfactionUserInfoById(java.lang.String)
	 */
	public void deleteFlowWfactionUserInfoById(String userids)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql
				.append("delete from OA_FLOW_WFACTUSER where  instr (',"
						+ userids.replaceAll("'", "")
						+ ",',','||wfactuser_id||',')>0 ");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared();

	}

	public Map<String, String> findFlowWfactionExtInfoById(String actionid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFWE.ACTIONEXT_ID,");
		sql.append("       OFWE.ACTION_ID,");
		sql.append("       NVL(OFWE.ISSHOWUSER, 'N') ISSHOWUSER,");
		sql.append("       NVL(OFWE.ISSHOWREJECT, 'N') ISSHOWREJECT,");
		sql.append("       NVL(OFWE.ISSHOWBACK, 'N') ISSHOWBACK,");
		sql.append("       NVL(OFWE.ISDISPENSE, 'N') ISDISPENSE,");
		sql.append("       OFWE.AUTOASSIGNMENT,");
		sql.append("       OFWE.ISSIGNJOINBYORDER,");
		sql.append("       OFWE.CREATE_TIME,");
		sql.append("       NVL(OFWE.IS_AUTO_COMPLETE, 'N') IS_AUTO_COMPLETE,");
		sql.append("       OFW.ACTIONTYPE_CODE");
		sql.append("  FROM OA_FLOW_WFACTIONEXT OFWE,OA_FLOW_WFACTION OFW");
		sql.append(" WHERE OFWE.ACTION_ID = OFW.ACTION_ID");
		sql.append("   AND OFWE.ACTION_ID = ?");
		return queryToSingleMap(sql.toString(), actionid);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionFormDefById
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowWfactionFormDefById(java.lang.String)
	 */
	public FlowActionFormDef findFlowWfactionFormDefById(String actionid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		form_id,");
		sql.append(" 		action_id,");
		sql.append(" 		action_form");
		sql.append(" from OA_FLOW_ACTIONFROMDEFID where action_id = ?");
		FlowActionFormDef fafd = new FlowActionFormDef();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, actionid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fafd.setForm_id(StringUtil.deNull(pdb.getString(0, "form_id")));
			fafd.setAction_id(StringUtil.deNull(pdb.getString(0, "action_id")));
			fafd.setAction_form(StringUtil.deNull(pdb.getString(0,
					"action_form")));
		}
		return fafd;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateFlowWfactionExtInfo
	 * 
	 * @param flowWfactionExtBean
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#updateFlowWfactionExtInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowWfactionExtBean)
	 */
	public void updateFlowWfactionExtInfo(
			FlowWfactionExtBean flowWfactionExtBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_WFACTIONEXT set ");
		sql.append("isshowuser = ?,");
		sql.append("isshowreject = ?,");
		sql.append("isshowback = ?,");
		sql.append("autoassignment = ?,");
		sql.append("issignjoinbyorder = ?,");
		sql.append("isdispense = ?,");
		sql.append("is_auto_complete = ?");
		sql.append(" where action_id = ?");

		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowWfactionExtBean.getIsshowuser());
		pdb.setString(2, flowWfactionExtBean.getIsshowreject());
		pdb.setString(3, flowWfactionExtBean.getIsshowback());
		pdb.setString(4, flowWfactionExtBean.getAutoassignment());
		pdb.setString(5, flowWfactionExtBean.getIssignjoinbyorder());
		pdb.setString(6, flowWfactionExtBean.getIsdispense());
		pdb.setString(7, flowWfactionExtBean.getIs_auto_complete());
		pdb.setString(8, flowWfactionExtBean.getAction_id());
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateFlowWfactionFormDef
	 * 
	 * @param flowWfactionFormDefBean
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#updateFlowWfactionFormDef(com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef)
	 */
	public void updateFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_ACTIONFROMDEFID set ");
		sql.append("action_form = ?");
		sql.append(" where action_id = ?");

		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, flowWfactionFormDefBean.getAction_form());
		pdb.setString(2, flowWfactionFormDefBean.getAction_id());
		pdb.executePrepared();

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExsitFlowFormDefInfo
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isExsitFlowFormDefInfo(java.lang.String)
	 */
	public boolean isExsitFlowFormDefInfo(String actionid) throws SQLException {
		boolean isexsit = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from OA_FLOW_ACTIONFROMDEFID where form_id = ? ");

		pdb.preparedSelect(sql.toString());
		pdb.setString(1, actionid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			isexsit = true;
		}
		return isexsit;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExsitFlowWfactionExtInfo
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isExsitFlowWfactionExtInfo(java.lang.String)
	 */
	public boolean isExsitFlowWfactionExtInfo(String actionid)
			throws SQLException {
		boolean isexsit = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql
				.append("select action_id from OA_FLOW_WFACTIONEXT where action_id = ?");

		pdb.preparedSelect(sql.toString());
		pdb.setString(1, actionid);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			isexsit = true;
		}
		return isexsit;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 stopFlowInfo
	 * 
	 * @param flow_id
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#stopFlowInfo(java.lang.String)
	 */
	public void stopFlowInfo(String flow_id) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			stopFlowInfo(flow_id, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExistFlow
	 * 
	 * @param packageId
	 * @param processId
	 * @param flowId
	 * @param flowVersion
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isExistFlow(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean isExistFlow(String packageId, String processId,
			String flowId, String flowVersion) throws Exception {
		String sql = "select count(*) from oa_flow_definfo t where t.flow_id= ? and t.flow_version=? "
				+ " and t.package_id = ? and t.flow_defid = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, flowId);
		pdb.setString(2, flowVersion);
		pdb.setString(3, packageId);
		pdb.setString(4, processId);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			if (Integer.parseInt(pdb.getString(0, 0)) > 0) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 startupFlowInfo
	 * 
	 * @param flowDefId
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#startupFlowInfo(java.lang.String)
	 */
	public void startupFlowInfo(String flowDefId) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			startupFlowInfo(flowDefId, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 insertWFAction
	 * 
	 * @param defID
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#insertWFAction(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String)
	 */
	public void insertWFAction(String defID, String packageId,
			String processId, String flowVersion) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			insertWFAction(defID, packageId, processId, flowVersion, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getActionCode
	 * 
	 * @param mgrName
	 * @param actionDefid
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getActionCode(java.lang.String,
	 *      java.lang.String)
	 */
	public String getActionCode(String mgrName, String actionDefid)
			throws Exception {

		boolean isFirstAct = isFirstAct(mgrName, actionDefid);
		boolean isLastAct = isLastAct(mgrName, actionDefid);
		if (isFirstAct) {// 表示是第一环节
			return "01";
		} else if (isLastAct) {// 表示是最后环节
			return "03";
		} else {
			return "02";// 表示是中间环节
		}

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 hasAct
	 * 
	 * @param flowId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#hasAct(java.lang.String)
	 */
	public boolean hasAct(String flowId) throws Exception {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			return hasAct(flowId, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getOldFlowId
	 * 
	 * @param packageId
	 * @param flowDefId
	 * @param flowId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getOldFlowId(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	public String getOldFlowId(String packageId, String flowDefId, String flowId)
			throws Exception {
		String sql = "select def_id from(select * from oa_flow_definfo t where t.flow_id= ?"
				+ " and t.package_id = ? and t.flow_defid= ? order by flow_version desc) where rownum=1";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, flowId);
		pdb.setString(2, packageId);
		pdb.setString(3, flowDefId);

		pdb.executePrepared();
		if (pdb.size() > 0) {
			return pdb.getString(0, 0);
		}
		return "";
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFlowAct
	 * 
	 * @param def_id
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getFlowAct(java.lang.String)
	 */
	public List<String> getFlowAct(String def_id) throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			return getFlowAct(def_id, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isFirstAct
	 * 
	 * @param mgrName
	 * @param actDefId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isFirstAct(java.lang.String,
	 *      java.lang.String)
	 */
	public boolean isFirstAct(String mgrName, String actDefId) throws Exception {
		// SharkEngine.getInstance().getFirstActivityByMgrName(String mgrName);
		if (getFirstActivityByMgrName(mgrName).getId().equals(actDefId)) {
			return true;
		}
		return false;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isLastAct
	 * 
	 * @param mgrName
	 * @param actDefId
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isLastAct(java.lang.String,
	 *      java.lang.String)
	 */
	public boolean isLastAct(String mgrName, String actDefId) throws Exception {
		List<Activity> ends = getLastActivityByMgrName(mgrName);
		for (int i = 0; i < ends.size(); i++) {
			Activity activity = ends.get(i);
			if (activity.getId().equals(actDefId)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFirstActivityByMgrName
	 * 
	 * @param mgrName
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getFirstActivityByMgrName(java.lang.String)
	 */
	public Activity getFirstActivityByMgrName(String mgrName) {
		String pkgId = mgrName.split(MGRNAME_SPLIT_TOKEN)[0];
		String version = mgrName.split(MGRNAME_SPLIT_TOKEN)[1];
		String procDefId = mgrName.split(MGRNAME_SPLIT_TOKEN)[2];
		WorkflowProcess pDef = SharkUtilities.getpackagedef(pkgId, version)
				.getWorkflowProcess(procDefId);
		List<?> starts = pDef.getStartingActivities();
		Activity actDef = (Activity) starts.get(0);
		return actDef;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getLastActivityByMgrName
	 * 
	 * @param mgrName
	 * @return
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getLastActivityByMgrName(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<Activity> getLastActivityByMgrName(String mgrName) {
		String pkgId = mgrName.split(MGRNAME_SPLIT_TOKEN)[0];
		String version = mgrName.split(MGRNAME_SPLIT_TOKEN)[1];
		String procDefId = mgrName.split(MGRNAME_SPLIT_TOKEN)[2];
		WorkflowProcess pDef = SharkUtilities.getpackagedef(pkgId, version)
				.getWorkflowProcess(procDefId);
		List<Activity> ends = pDef.getEndingActivities();
		// Activity actDef = (Activity) starts.get(0);
		return ends;
	}

	/**
	 * <b>Summary: </b> 复写方法 findActColStatusList
	 * 
	 * @param businessType
	 * @param actionId
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findActColStatusList(java.lang.String,
	 *      java.lang.String)
	 */
	public List<ActColStatusBean> findActColStatusList(String businessType,
			String actionId) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		List<ActColStatusBean> list = new ArrayList<ActColStatusBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		t.id,");
		sql.append(" 		t.action_id,");
		sql.append(" 		c.table_id,");
		sql.append(" 		c.table_code,");
		sql.append(" 		c.column_id,");
		sql.append(" 		c.column_code,");
		sql.append(" 		c.column_name,");
		sql.append(" 		t.readonly,");
		sql.append("        t.hidden,");
		sql.append("        t.disable,");
		sql.append("        t.required,");
		sql.append("        decode(t.readonly,'1','checked','') ckd1,");// chk1字段用于是否选中选择框
		sql.append("        decode(t.hidden  ,'1','checked','') ckd2,");
		sql.append("        decode(t.disable ,'1','checked','') ckd3,");
		sql.append("        decode(t.required ,'1','checked','') ckd4");
		sql
				.append(" from (select c.*,b.table_code from oa_md_table b,oa_md_columns c,oa_md_table_business_mapping m where m.busitype_code = ? and b.table_id = m.table_id and c.table_id = b.table_id ) c ");
		sql
				.append(" left join oa_act_col_stauts t on c.table_id=t.table_id and c.column_id=t.column_id  and t.action_id = ? ");
		sql.append(" where 1=1 order by c.column_id");
		db.preparedSelect(sql.toString());
		db.setString(1, businessType);
		db.setString(2, actionId);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			ActColStatusBean model = new ActColStatusBean();
			model.setId(db.getString(i, "id"));
			model.setAction_id(db.getString(i, "action_id"));
			model.setTable_id(db.getString(i, "table_id"));
			model.setTable_code(db.getString(i, "table_code"));
			model.setColumn_id(db.getString(i, "column_id"));
			model.setColumn_code(db.getString(i, "column_code"));
			model.setColumn_name(db.getString(i, "column_name"));
			model.setReadonly(db.getString(i, "readonly"));
			model.setHidden(db.getString(i, "hidden"));
			model.setDisable(db.getString(i, "disable"));
			model.setRequired(db.getString(i, "required"));
			model.setCkd1(db.getString(i, "ckd1"));
			model.setCkd2(db.getString(i, "ckd2"));
			model.setCkd3(db.getString(i, "ckd3"));
			model.setCkd4(db.getString(i, "ckd4"));
			list.add(model);
		}
		return list;
	}

	/**
	 * <b>Summary: </b> 复写方法 findActColStatusList
	 * 
	 * @param actColStatusBean
	 * @throws SQLException
	 */
	public void updateActColStatusForm(ActColStatusBean actColStatusBean)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE oa_act_col_stauts t SET ");
		sql.append(" t.readonly = ?, ");
		sql.append(" t.hidden   = ?, ");
		sql.append(" t.disable  = ?, ");
		sql.append(" t.required = ?  ");
		sql.append(" WHERE t.id = ? ");
		db.preparedUpdate(sql.toString());
		db.setString(1, actColStatusBean.getReadonly());
		db.setString(2, actColStatusBean.getHidden());
		db.setString(3, actColStatusBean.getDisable());
		db.setString(4, actColStatusBean.getRequired());
		db.setString(5, actColStatusBean.getId());
		db.executePrepared();
	}

	/**
	 * <b>Summary: </b> 复写方法insertActColStatusForm
	 * 
	 * @param actColStatusBean
	 * @throws SQLException
	 */
	public void insertActColStatusForm(ActColStatusBean actColStatusBean)
			throws SQLException {

		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"insert into oa_act_col_stauts (id,action_id,table_id,table_code,column_id,column_code,readonly,hidden,disable,required)")
				.append(" values (?,?,?,?,?,?,?,?,?,?)");
		db.preparedInsert(sql.toString());
		db.setString(1, StringUtil.getUUID());
		db.setString(2, actColStatusBean.getAction_id());
		db.setString(3, actColStatusBean.getTable_id());
		db.setString(4, actColStatusBean.getTable_code());
		db.setString(5, actColStatusBean.getColumn_id());
		db.setString(6, actColStatusBean.getColumn_code());
		db.setString(7, actColStatusBean.getReadonly());
		db.setString(8, actColStatusBean.getHidden());
		db.setString(9, actColStatusBean.getDisable());
		db.setString(10, actColStatusBean.getRequired());
		db.executePrepared();
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findActTextStatusBeanById
	 * 
	 * @param actionId
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findActTextStatusBeanById(java.lang.String)
	 */
	public ActTextStatusBean findActTextStatusBeanById(String actionId)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		id,");
		sql.append(" 		action_id,");
		sql.append(" 		is_trace,");
		sql.append(" 		is_red,");
		sql.append(" 		is_readonly,");
		sql.append(" 		extend_attribute,");
		sql.append("        extend_methods,");
		sql.append("        is_msg,");
		sql.append("        msg_txt,");
		sql.append("        is_sign,");
		sql.append("        is_keeptrace,");
		sql.append("        is_attachment,");
		sql.append("        is_gwzl,");
		sql.append("        is_ckcg,");
		sql.append("        is_ckzw,");
		sql.append("        is_ckmq,");
		sql.append("        is_singname,");
		sql.append("        is_affix,");
		sql.append("        remark1,");
		sql.append("        is_serialnumber, ");
		sql.append("        is_xd, ");
		sql.append("        is_gwff, ");
		sql.append("        is_cd, ");
		sql.append("        is_cklc, ");
		sql.append("        is_newflow, ");
		sql.append("        is_print, ");
		sql.append("        is_split, ");
		sql.append("        is_infotype, ");
		sql.append("        is_nbfs, ");
		sql.append("        is_doback, ");
		sql.append("        is_chief, ");
		sql.append("        is_ckls, ");
		sql.append("        is_gk, ");
		sql.append("        is_sm ");
		sql.append(" from oa_act_text_stauts where action_id = ? ");
		ActTextStatusBean model = new ActTextStatusBean();
		db.preparedSelect(sql.toString());
		db.setString(1, actionId);
		db.executePrepared();
		if (db.size() == 1) {
			model.setId(db.getString(0, "id"));
			model.setAction_id(db.getString(0, "action_id"));
			model.setIs_readonly(db.getString(0, "is_readonly"));
			model.setIs_red(db.getString(0, "is_red"));
			model.setIs_trace(db.getString(0, "is_trace"));
			model.setExtend_attribute(StringUtil.deNull(db.getString(0,"extend_attribute")));
			model.setExtend_methods(StringUtil.deNull(db.getString(0,"extend_methods")));
			model.setMsg_txt(StringUtil.deNull(db.getString(0,"msg_txt")));
			model.setIs_msg(db.getString(0, "is_msg"));
			model.setIs_sign(db.getString(0, "is_sign"));
			model.setIs_keeptrace(db.getString(0, "is_keeptrace"));
			model.setIs_attachment(db.getString(0, "is_attachment"));
			model.setIs_gwzl(db.getString(0, "is_gwzl"));
			model.setIs_ckcg(db.getString(0, "is_ckcg"));
			model.setIs_ckzw(db.getString(0, "is_ckzw"));
			model.setIs_ckmq(db.getString(0, "is_ckmq"));
			model.setIs_singname(db.getString(0, "is_singname"));
			model.setIs_affix(db.getString(0, "is_affix"));
			model.setRemark1(db.getString(0, "remark1"));
			model.setIs_serialnumber(db.getString(0, "is_serialnumber"));
			model.setIs_xd(db.getString(0, "is_xd"));
			model.setIs_gwff(db.getString(0, "is_gwff"));
			model.setIs_cd(db.getString(0, "is_cd"));
			model.setIs_cklc(db.getString(0, "is_cklc"));
			model.setIs_newflow(db.getString(0, "is_newflow"));
			model.setIs_print(db.getString(0, "is_print"));
			model.setIs_split(db.getString(0, "is_split"));
			model.setIs_infotype(db.getString(0, "is_infotype"));
			model.setIs_nbfs(db.getString(0, "is_nbfs"));
			model.setIs_doback(db.getString(0, "is_doback"));
			model.setIs_chief(db.getString(0, "is_chief"));
			model.setIs_ckls(db.getString(0, "is_ckls"));
			model.setIs_gk(db.getString(0, "is_gk"));
			model.setIs_sm(db.getString(0, "is_sm"));
		}
		return model;
	}

	/**
	 * <b>Summary: </b> 复写方法 updateActTextStatusForm
	 * 
	 * @param model
	 * @throws SQLException
	 */
	public void updateActTextStatusForm(ActTextStatusBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE oa_act_text_stauts  SET ");
		sql.append(" is_trace = ?, ");
		sql.append(" is_red   = ?, ");
		sql.append(" is_readonly  = ?, ");
		sql.append(" extend_attribute = ?,  ");
		sql.append(" extend_methods = ?,  ");
		sql.append(" is_msg = ?,");
		sql.append(" msg_txt = ?,");
		sql.append(" is_sign = ?,");
		sql.append(" is_keeptrace = ?,");
		sql.append(" is_attachment = ?,");
		sql.append(" is_gwzl = ?, ");
		sql.append(" is_ckcg = ?, ");
		sql.append(" is_ckzw = ?, ");
		sql.append(" is_ckmq = ?, ");
		sql.append(" is_singname = ?, ");
		sql.append(" is_affix = ?, ");
		sql.append(" remark1 = ?, ");
		sql.append(" is_serialnumber = ?, ");
		sql.append(" is_xd = ?, ");
		sql.append(" is_gwff = ?, ");
		sql.append(" is_cd = ?, ");
		sql.append(" is_cklc = ?, ");
		sql.append(" is_newflow = ?, ");
		sql.append(" is_gk = ?, ");
		sql.append(" is_print = ?, ");
		sql.append(" is_split = ?, ");
		sql.append(" is_infotype = ?, ");
		sql.append(" is_doback = ?, ");
		sql.append(" is_chief = ?, ");
		sql.append(" is_ckls = ?, ");
		sql.append(" is_nbfs = ?, ");
		sql.append(" is_sm = ? ");
		sql.append(" WHERE id = ? ");
		db.preparedUpdate(sql.toString());
		int i=1;
		db.setString(i++, model.getIs_trace());
		db.setString(i++, model.getIs_red());
		db.setString(i++, model.getIs_readonly());
		db.setString(i++, model.getExtend_attribute());
		db.setString(i++, model.getExtend_methods());
		db.setString(i++, model.getIs_msg());
		db.setString(i++, model.getMsg_txt());
		db.setString(i++, model.getIs_sign());
		db.setString(i++, model.getIs_keeptrace());
		db.setString(i++, model.getIs_attachment());
		db.setString(i++, model.getIs_gwzl());
		db.setString(i++, model.getIs_ckcg());
		db.setString(i++, model.getIs_ckzw());
		db.setString(i++, model.getIs_ckmq());
		db.setString(i++, model.getIs_singname());
		db.setString(i++, model.getIs_affix());
		db.setString(i++, model.getRemark1());
		db.setString(i++, model.getIs_serialnumber());
		db.setString(i++, model.getIs_xd());
		db.setString(i++, model.getIs_gwff());
		db.setString(i++, model.getIs_cd());
		db.setString(i++, model.getIs_cklc());
		db.setString(i++, model.getIs_newflow());
		db.setString(i++, model.getIs_gk());
		db.setString(i++, model.getIs_print());
		db.setString(i++, model.getIs_split());
		db.setString(i++, model.getIs_infotype());
		db.setString(i++, model.getIs_doback());
		db.setString(i++, model.getIs_chief());
		db.setString(i++, model.getIs_ckls());
		db.setString(i++, model.getIs_nbfs());
		db.setString(i++, model.getIs_sm());
		db.setString(i++, model.getId());
		db.executePrepared();
	}

	/**
	 * <b>Summary: </b> 复写方法insertActTextStatusForm
	 * 
	 * @param actTextStatusBean
	 * @throws SQLException
	 */
	public void insertActTextStatusForm(ActTextStatusBean model)
			throws SQLException {

		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_act_text_stauts (id,action_id,is_trace,is_red,is_readonly,extend_attribute,extend_methods,is_msg,msg_txt,is_sign,is_keeptrace,is_attachment,is_serialnumber,is_gwzl,is_ckcg,is_ckzw,is_ckmq,is_singname,is_affix,remark1,is_xd,is_gwff,is_cd,is_cklc,is_newflow,is_gk,is_print,is_split,is_infotype,is_nbfs,is_doback,is_chief,is_ckls,is_sm)")
		   .append(" values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		db.preparedInsert(sql.toString());
		db.setString(1, StringUtil.getUUID());
		db.setString(2, model.getAction_id());
		db.setString(3, model.getIs_trace());
		db.setString(4, model.getIs_red());
		db.setString(5, model.getIs_readonly());
		db.setString(6, model.getExtend_attribute());
		db.setString(7, model.getExtend_methods());
		db.setString(8, model.getIs_msg());
		db.setString(9, model.getMsg_txt());
		db.setString(10, model.getIs_sign());
		db.setString(11, model.getIs_keeptrace());
		db.setString(12, model.getIs_attachment());
		db.setString(13, model.getIs_serialnumber());
		db.setString(14, model.getIs_gwzl());
		db.setString(15, model.getIs_ckcg());
		db.setString(16, model.getIs_ckzw());
		db.setString(17, model.getIs_ckmq());
		db.setString(18, model.getIs_singname());
		db.setString(19, model.getIs_affix());
		db.setString(20, model.getRemark1());
		db.setString(21, model.getIs_xd());
		db.setString(22, model.getIs_gwff());
		db.setString(23, model.getIs_cd());
		db.setString(24, model.getIs_cklc());
		db.setString(25, model.getIs_newflow());
		db.setString(26, model.getIs_gk());
		db.setString(27, model.getIs_print());
		db.setString(28, model.getIs_split());
		db.setString(29, model.getIs_infotype());
		db.setString(30, model.getIs_nbfs());
		db.setString(31, model.getIs_doback());
		db.setString(32, model.getIs_chief());
		db.setString(33, model.getIs_ckls());
		db.setString(34, model.getIs_sm());
		db.executePrepared();
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getWfactionExtAutoassignmentDictDropDownList
	 * 
	 * @param action_id
	 * @param autoassignment
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#getWfactionExtAutoassignmentDictDropDownList(java.lang.String,
	 *      java.lang.String)
	 */
	public String getWfactionExtAutoassignmentDictDropDownList(
			String action_id) throws Exception {
		 String sql =
		 "select action_defid,w.action_name from OA_FLOW_WFACTION w where w.def_id = (select wf.def_id from OA_FLOW_WFACTION wf where wf.action_id = '"
		 + action_id + "')";
		/**
		 * 是否使用前置活动执行人的需求更改为要么 是：配置为当前环节id，否：为空
		 * 
		 * @author 戴连春 2013-06-05
		 */
		//String sql = "select action_defid,action_name from OA_FLOW_WFACTION  where action_id = '"
				//+ action_id + "'";

		return DictDropDownList.buildSelect(sql, "autoassignment",
				"autoassignment", "", true, "", "width:130px;margin-left:5px;");
	
		/**
		 * 修改为直接查询出当前步骤的actionId，再在前台拼接html。
		 * @alter by 戴连春
		 * @alter date 2013-7-15
		 */
		/*
		String sql = "select action_defid from OA_FLOW_WFACTION  where action_id = '"
			+ action_id + "'";*/
		//return DaoUtil.sqlToField(sql);
	}

	/**
	 * <b>Summary: </b> 复写方法 insertActTableBusinessMapping
	 * 
	 * @param table_id
	 * @param busitype_code
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#insertActTableBusinessMapping(java.lang.String,
	 *      java.lang.String)
	 */
	public void insertTableBusinessMapping(String table_id, String busitype_code)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();

		// sql2
		// .append("delete from oa_md_table_business_mapping t where t.table_id=? and t.busitype_code = ?");
		/**
		 * 一个业务类型只能绑定一个流程，将多对多的对应关系更改为一对多。每个业务类型只能存在一个对应的表单 ps:此处表设计有点问题
		 * 
		 * @author 戴连春 2013-06-06
		 */
		sql2
				.append("delete from oa_md_table_business_mapping t where t.busitype_code = ?");

		db.preparedDelete(sql2.toString());
		db.setString(1, busitype_code);
		db.executePrepared();

		sql
				.append("insert into oa_md_table_business_mapping select ?,?,? from dual");
		db.preparedInsert(sql.toString());
		db.setString(1, StringUtil.getUUID());
		db.setString(2, table_id);
		db.setString(3, busitype_code);
		db.executePrepared();
	}

	/**
	 * 
	 * <b>Summary:</b> 复写方法 addFlowBaseInfo
	 * 
	 * @param flowInfoBean
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowBaseInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean)
	 */
	@Override
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean) throws Exception {
		return this.addFlowBaseInfo(flowInfoBean, null);
	}

	/**
	 * 
	 *<b>Summary: 查询所有的表单信息</b> queryListFlowForm(请用一句话描述这个方法的作用)
	 * 
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<FlowFormBean> queryListFlowForm(Connection conn)
			throws SQLException {

		StringBuffer sql = new StringBuffer(
				" select form_path, form_name, form_desc,"
						+ " to_char(creator_time,'YYYY-mm-dd') as creator_time "
						+ " from oa_flow_form ");

		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		// 执行sql语句，并将结果集转换成List<FlowFormBean>的形式
		return pdb.executePreparedForList(conn, FlowFormBean.class);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionInfoList
	 * 
	 * @param flowId
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowWfactionInfoList(java.lang.String)
	 */
	public List<String> findFlowWfactionInfoList(String flowId)
			throws SQLException {
		Connection conn = DbManager.getInstance().getConnection();
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select	a.action_id ").append(
					" from oa_flow_wfaction a ").append(
					" inner join oa_flow_definfo b on b.def_id = a.def_id ");
			sql.append(" where b.flow_id = ? and b.is_valid = 'Y' "
					+ "order by length(a.action_defid),a.action_defid");
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, flowId);
			pdb.executePrepared();

			// 将结果集封装为List
			List<String> list = new ArrayList<String>();
			for (int i = 0; i < pdb.size(); i++) {
				list.add(pdb.getString(i, "action_id"));
			}
			return list;

		} finally {
			conn.close();
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findFlowWfactionTreeConfigById
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#findFlowWfactionTreeConfigById(java.lang.String)
	 */
	public FlowActionTreeConfigBean findFlowWfactionTreeConfigById(
			String actionid) throws Exception {
		FlowActionTreeConfigBean flowActionTreeConfigBean = new FlowActionTreeConfigBean();
		flowActionTreeConfigBean.clearPKey().setPKey("action_id");
		flowActionTreeConfigBean.setAction_id(actionid);
		flowActionTreeConfigBean = (FlowActionTreeConfigBean) queryToBean(flowActionTreeConfigBean);
		return flowActionTreeConfigBean;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 isExsitFlowActTreeConfig
	 * 
	 * @param actionid
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#isExsitFlowActTreeConfig(java.lang.String)
	 */
	public boolean isExsitFlowActTreeConfig(String actionid) throws Exception {
		FlowActionTreeConfigBean flowActionTreeConfigBean = findFlowWfactionTreeConfigById(actionid);
		if (flowActionTreeConfigBean==null || StringUtil.nullOrBlank(flowActionTreeConfigBean.getConfig_id()))
			return false;
		return true;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 addFlowDefInfo
	 * 
	 * @param flowDefInfoBean
	 * @param conn
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#addFlowDefInfo(com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean,
	 *      java.sql.Connection)
	 */

	@Override
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean,
			Connection conn) throws SQLException {

		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql2 = new StringBuffer();
		String new_flow_defid = StringUtil.getUUID();
		sql2
				.append(
						"insert into oa_flow_definfo (def_id,flow_defid,flow_id,flow_version,package_id,is_valid,create_time,flow_desc)")
				.append(" values (?,?,?,?,?,?,?,?)");

		pdb.preparedInsert(sql2.toString());
		pdb.setString(1, new_flow_defid);
		pdb.setString(2, flowDefInfoBean.getFlow_defid());
		pdb.setString(3, flowDefInfoBean.getFlow_id());
		pdb.setString(4, flowDefInfoBean.getFlow_version());
		pdb.setString(5, flowDefInfoBean.getPackage_id());
		pdb.setString(6, flowDefInfoBean.getIs_valid());
		pdb.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
		pdb.setString(8, flowDefInfoBean.getFlow_desc());
		pdb.executePrepared(conn);
		return new_flow_defid;

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowDefInfoById
	 * 
	 * @param flowdefid
	 * @param conn
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowDefInfoById(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public void deleteFlowDefInfoById(String flowdefid, Connection conn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from oa_flow_definfo where def_id = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, flowdefid);
		pdb.executePrepared(conn);

	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFlowDefInfo
	  * @param def_id
	  * @param conn
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowDefInfo(java.lang.String, java.sql.Connection)
	 */
	public void deleteFlowDefInfo(String def_id, Connection conn)
	throws SQLException {
		CallableDBUtil cdb = new CallableDBUtil();
		if (!StringUtil.nullOrBlank(def_id)) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call deleteFlowDefInfo(?)}");
			cdb.setString(1, def_id);
			cdb.executeCallable(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteFlowWfactionInfoById
	 * 
	 * @param flowdefid
	 * @param conn
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#deleteFlowWfactionInfoById(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public void deleteFlowWfactionInfoById(String flowdefid, Connection conn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from OA_FLOW_WFACTION where action_id = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, flowdefid);
		pdb.executePrepared(conn);

	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getFlowAct
	 * 
	 * @param flowdefId
	 * @param conn
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getFlowAct(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public List<String> getFlowAct(String flowdefId, Connection conn)
			throws SQLException {
		List<String> list = new ArrayList<String>();
		StringBuffer buf = new StringBuffer();
		buf.append("select w.action_id from OA_FLOW_WFACTION w where w.def_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.setString(1, flowdefId);
		db.executePrepared(conn);
		for (int i = 0; i < db.size(); i++) {
			list.add(db.getString(i, "action_id"));
		}

		return list;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 hasAct
	 * 
	 * @param flowId
	 * @param conn
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#hasAct(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public boolean hasAct(String flowId, Connection conn) throws Exception {
		String sql = "select count(*) from OA_FLOW_WFACTION where def_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, flowId);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			if (Integer.parseInt(pdb.getString(0, 0)) > 0) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 startupFlowInfo
	 * 
	 * @param flowId
	 * @param conn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#startupFlowInfo(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public void startupFlowInfo(String flowDefId, Connection conn)
			throws Exception {
		String sql = "update oa_flow_definfo set IS_VALID = 'Y'  where def_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, flowDefId);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 stopFlowInfo
	 * 
	 * @param ecId
	 * @param conn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#stopFlowInfo(java.lang.String,
	 *      java.sql.Connection)
	 */

	@Override
	public void stopFlowInfo(String flow_id, Connection conn) throws Exception {
		String sql = "update oa_flow_definfo set IS_VALID = 'N'  where flow_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, flow_id);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 insertWFAction
	 * 
	 * @param flowId
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @param conn
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#insertWFAction(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String,
	 *      java.sql.Connection)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void insertWFAction(String defID, String packageId,
			String processId, String flowVersion, Connection conn)
			throws Exception {

		WorkflowManager workflowManager = new WorkflowManagerImpl();
		SharkEngine shark = SharkEngine.getInstance();
		DBUtil dbUtil = new DBUtil();
		shark.loginWorkflowServer("admin", "");
		List<ActivityBean> actList = workflowManager.getActionListByProcessId(
				packageId, flowVersion, processId);
		shark.logoutWorkflowServer();
		if (actList != null && actList.size() > 0)
			for (int i = 0; i < actList.size(); i++) {
				//TODO 这里插入每个环节的默认配置信息
				StringBuffer sql = new StringBuffer();
				ActivityBean actBean = actList.get(i);
				String mgrName = packageId + "#" + flowVersion + "#"+ processId;
				String actionCodeid = getActionCode(mgrName, actBean.getActDefId());
				sql.append("insert into ");
				sql.append("oa_flow_wfaction(action_id,def_id,action_defid,action_name,action_alias,action_limit,actiontype_code) values( '");
				sql.append(StringUtil.getUUID()).append("','");
				sql.append(defID).append("','");
				sql.append(actBean.getActDefId()).append("','");
				sql.append(actBean.getActName()).append("','");
				sql.append(actBean.getActName()).append("','");
				sql.append(actBean.getLimit()).append("','");
				sql.append(actionCodeid).append("')");
				dbUtil.addBatch(sql.toString());
				//活动扩展表 OA_FLOW_WFACTIONEXT
				
				
			}
		dbUtil.executeBatch(conn);
	}

	/**
	 * 
	 *<b>Summary: 流程继承老版本信息</b> copyConfigInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param oldDefId
	 *            老的流程定义id
	 * @param newDefId
	 *            新的流程定义id
	 * @param oldTableId
	 *            老的业务表id
	 * @return
	 * @throws SQLException 
	 */
	public void copyConfigInfo(String newDefId, String oldDefId,
			String oldTableId, Connection conn) throws SQLException {
		CallableDBUtil cdb = new CallableDBUtil();
		if (!StringUtil.nullOrBlank(newDefId) && !StringUtil.nullOrBlank(oldDefId)
				) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call copyFlowInfo(?,?,?)}");
			cdb.setString(1, newDefId);
			cdb.setString(2, oldDefId);
			cdb.setString(3, oldTableId);
			cdb.executeCallable(conn);			
		}
	}

	public static void main(String[] args) {
		// FlowInfoDaoImpl dao = new FlowInfoDaoImpl();
		// try {
		// System.out
		// .println(dao
		// .findFlowWfactionInfoList("6fcba079-5843-40d7-b2a0-8d73529c6e89"));
		//
		// System.out
		// .println(com.alibaba.fastjson.JSONArray
		// .toJSON(dao
		// .findFlowWfactionInfoList("6fcba079-5843-40d7-b2a0-8d73529c6e89")));
		//
		// } catch (SQLException e) {
		//
		// e.printStackTrace();
		// }

	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListWordTemp
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#queryListWordTemp(java.sql.Connection)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<OaWordTemplate> queryListWordTemp(Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer("select template_id,template_name,template_creatortime,template_userid,template_username,org_id,org_name,template_remark,is_common,lastmodifytime,template_sn from  oa_word_template");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		// 执行sql语句，并将结果集转换成List<FlowFormBean>的形式
		return pdb.executePreparedForList(conn, OaWordTemplate.class);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowBaseInfoList
	  * @param flowInfoBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#getFlowBaseInfoList(com.chinacreator.xtbg.core.process.processconfig.entity.FlowInfoBean)
	 */
	@Override
	public List<FlowInfoBean> getFlowBaseInfoList(FlowInfoBean flowInfoBean,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		List<FlowInfoBean> list = new ArrayList<FlowInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		f.flow_id,");
		sql.append(" 		f.flow_name,");
		sql.append(" 		f.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		f.org_id,");
		sql.append(" 		f.is_indivi,");
		sql.append(" 		f.is_valid,");
		sql.append("        f.create_time,");
		sql.append("        f.flow_limit,");
		sql.append("        f.limit_unit,");
		sql.append("        f.from_path,");
		sql.append("        f.form_image_id,");
		sql.append("        f.flow_tyle,");
		sql.append("        f.template_id,");
		sql.append("        f.attach_id,f.next_flow_id ");
		sql.append(" from OA_FLOW_BASEINFO f ");
		sql.append(" left join oa_flow_busitype t  ");
		sql.append(" on f.busitype_code=t.busitype_code ");
		sql.append(" left join oa_flow_busitype_type tt");
		sql.append(" on t.busitype_type_code = tt.busitype_type_code");
		String type =OASystemCache.getContextProperty("createWorkListOrder");
		if("count".equals(type)){
			sql.append(" left join (select tii.busitype_code ,count(1) count from oa_flow_instance tii where tii.accepter = '"+flowInfoBean.getFlow_name()+"' group by tii.busitype_code) c");
			sql.append(" on  t.busitype_code=c.busitype_code ");
		}
		//特检院OA 修改公文分类查询 start 
		//sql.append("  where f.is_valid = 'Y' and tt.busitype_type_code = ?");
		sql.append("  where f.is_valid = 'Y' ");
		if(!StringUtil.isBlank(flowInfoBean.getBusitype_type_code())){
			sql.append(" and tt.busitype_type_code in( '"+flowInfoBean.getBusitype_type_code()+"') ");
		}
		if(!StringUtil.isBlank(flowInfoBean.getBusitype_code())){
			if(flowInfoBean.getBusitype_code().indexOf(",") != -1){
				sql.append(" and f.busitype_code in (").append(flowInfoBean.getBusitype_code()).append(")");
			}else{
				sql.append(" and f.busitype_code like '%").append(flowInfoBean.getBusitype_code()).append("%'");
			}
		}
		//特检院OA 修改公文分类查询 end 
		if(flowInfoBean!=null){
			if(!StringUtil.isBlank(flowInfoBean.getOrg_id())){
				//sql.append("  and f.org_id= '"+flowInfoBean.getOrg_id()+"'");
				sql.append(" and instr('"+flowInfoBean.getOrg_id()+"',f.org_id) >0");
			}
		}
		
		if("count".equals(type)){
			sql.append(" order by c.count desc nulls last,t.busitype_order,f.create_time ");
		}else{
			sql.append(" order by t.busitype_order,f.create_time ");
		}
		
		db.preparedSelect(sql.toString());
		//db.setString(1, flowInfoBean.getBusitype_type_code());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			FlowInfoBean fib = new FlowInfoBean();
			fib.setFlow_id(db.getString(i, "flow_id"));
			fib.setFlow_name(db.getString(i, "flow_name"));
			fib.setBusitype_code(db.getString(i, "busitype_code"));
			fib.setBusitype_name(db.getString(i, "busitype_name"));
			fib.setOrg_id(db.getString(i, "org_id"));
			fib.setOrg_name(db.getString(i, "org_name"));
			fib.setIs_indivi(changeString(db.getString(i, "is_indivi")));
			fib.setIs_valid(db.getString(i, "is_valid"));
			fib.setCreate_time(DateUtil.getTimeString(db.getTimestamp(i,"create_time")));
			fib.setFlow_limit(StringUtil.deNull(db.getString(i, "flow_limit")+ changeString(db.getString(i, "limit_unit"))));
			fib.setLimit_unit(db.getString(i, "limit_unit"));
			fib.setForm_image_id(db.getString(i, "form_image_id"));
			fib.setFrom_path(db.getString(i, "from_path"));
			fib.setAttach_id(db.getString(i, "attach_id"));
			fib.setFlow_tyle(db.getString(i, "flow_tyle"));
			fib.setTemplate_id(db.getString(i, "template_id"));
			fib.setNext_flow_id(db.getString(i, "next_flow_id"));
			list.add(fib);
		}
		return list;
	}

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 querySingnConfig
	  * @param temp_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#querySingnConfig(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public String querySingnConfig(String temp_id, Connection conn) throws Exception  {
		StringBuffer singnConfig = new StringBuffer("");
		StringBuffer sql = new StringBuffer();
		sql.append("select singn_config from oa_word_template where template_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, temp_id);
		db.executePrepared(conn);
		if( db.size()>0){
			singnConfig.append(db.getString(0,"singn_config"));
		}
		return singnConfig.toString();
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertActionInit
	  * @param new_def_id
	  * @param conn 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#insertActionInit(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public void insertActionInit(String new_def_id, Connection conn) throws Exception {
		CallableDBUtil cdb = new CallableDBUtil();
		if (!StringUtil.nullOrBlank(new_def_id)) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call flow_action_init(?)}");
			cdb.setString(1, new_def_id);
			cdb.executeCallable(conn);			
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isFlowInstance
	  * @param busitype_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#isFlowInstance(java.lang.String, java.sql.Connection)
	 */
	public boolean isFlowInstance(String busitype_code, Connection conn)
			throws Exception {
		boolean flag=false;
		String sql=" select *  from OA_FLOW_INSTANCE  where busitype_code=? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, busitype_code);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			flag=true;
		}
		
		return flag;
	}
	/**
	 * 复制流程(包括基本信息)
	 */
	@Override
	public String copyFlowInfo(Map<Integer, String> procMap, Connection conn)
			throws Exception {
		CallableDBUtil cdb = new CallableDBUtil();
		cdb.prepareCallable("{call p_oa_flow_baseinfo_copy(?,?)}");
		for (Integer key : procMap.keySet()) {
			cdb.setString(key, procMap.get(key));
		}
		cdb.registerOutParameter(2, java.sql.Types.VARCHAR);
		cdb.executeCallable(conn);
		String id = cdb.getString(2);
		return id;
	}
	/**
	 * 复制流程(不包括基本信息)
	 */
	@Override
	public Map<String, String> copyFlowDefInfo(Map<Integer, String> procMap,
			Connection conn) throws Exception {
		CallableDBUtil cdb = new CallableDBUtil();
		cdb.prepareCallable("{call p_oa_flow_definfo_copy(?,?,?,?,?,?)}");
		for (Integer key : procMap.keySet()) {
			cdb.setString(key, procMap.get(key));
		}
		cdb.registerOutParameter(3, java.sql.Types.VARCHAR);
		cdb.registerOutParameter(4, java.sql.Types.VARCHAR);
		cdb.registerOutParameter(5, java.sql.Types.VARCHAR);
		cdb.registerOutParameter(6, java.sql.Types.VARCHAR);
		cdb.executeCallable(conn);
		Map<String, String> data = new HashMap<String, String>();
		data.put("flow_defid", cdb.getString(3));
		data.put("flow_version", cdb.getString(4));
		data.put("package_id", cdb.getString(5));
		data.put("flag", cdb.getString(6));
		return data;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFlowBaseInfoByCode
	  * @param code
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao#findFlowBaseInfoByCode(java.lang.String)
	 */
	public Map<String, String> findFlowBaseInfoByCode(String code)
			throws SQLException {
		String sql="select * from OA_FLOW_BASEINFO where BUSITYPE_CODE=?";
		Map<String, String> map=new HashMap<String, String>();
		try {
			map=queryToSingleMap(sql, code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	@Override
	public boolean isExistFlowIns(String def_id) throws Exception {
		boolean flag = false;
		String sql="select 1  from OA_FLOW_INSTANCE where DEF_ID = ?";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, def_id);
		pdb.executePrepared();
		if(pdb.size()>0){
			flag = true;
		}
		return flag;
	
	}

	@Override
	public Integer selectFlowByActionId(String action_id) throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql = "select count(id) coun from oa_act_text_stauts where action_id = ?";
		pdb.preparedSelect(sql);
		pdb.setString(1, action_id);
		pdb.executePrepared();
		Integer count = pdb.getInt(0, "coun");
		return count;
	}

	@Override
	public void updateTextEdite(String action_id, String is_readOnly,Connection conn)
			throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql = "update oa_act_text_stauts s set s.is_readonly = ? where s.action_id = ?";
		pdb.preparedUpdate(sql);
		pdb.setString(1, is_readOnly);
		pdb.setString(2, action_id);
		pdb.executePrepared(conn);
	}
}

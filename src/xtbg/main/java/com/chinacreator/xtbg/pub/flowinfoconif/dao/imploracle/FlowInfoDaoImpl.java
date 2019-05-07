package com.chinacreator.xtbg.pub.flowinfoconif.dao.imploracle;

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
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionFormDef;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowActionTreeConfigBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowDefInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowInfoBean;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactUser;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionInfoBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.DictDropDownList;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionExtBean;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class FlowInfoDaoImpl extends XtDbBaseDao implements FlowInfoDao {

	private static final Logger LOG = Logger.getLogger(FlowInfoDaoImpl.class);
	private String MGRNAME_SPLIT_TOKEN = "#";
	
	@Override
	public PagingBean findFlowBaseInfoList(FlowInfoBean flowInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		boolean flag=false;
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
		sql.append(" from ta_oa_flow_flowbaseinfo f ");
		sql.append(" left join td_sm_organization o ");
		sql.append(" on o.org_id=f.org_id ");
		sql.append(" left join ta_oa_busi_type t  ");
		sql.append(" on f.busitype_code=t.busitype_code ");
		if(!StringUtil.nullOrBlank(flowInfoBean.getFlow_name())){
			sql.append(" where f.flow_name like '%").append(flowInfoBean.getFlow_name()).append("%'");
			flag=true;
		}
		if(!StringUtil.nullOrBlank(flowInfoBean.getOrg_name())){
			if(flag){
				sql.append(" and o.org_name = '").append(flowInfoBean.getOrg_name()).append("'");
			}else{
				sql.append(" where o.org_name = '").append(flowInfoBean.getOrg_name()).append("'");
			}
		}
		sql.append(" order by " + sortName + ",rownum " + sortOrder);
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	FlowInfoBean fib = new FlowInfoBean();
		    	fib.setFlow_id(db.getString(i, "flow_id"));
		    	fib.setFlow_name(db.getString(i, "flow_name"));
		    	fib.setBusitype_code(db.getString(i, "busitype_code"));
		    	fib.setBusitype_name(db.getString(i, "busitype_name"));
		    	fib.setOrg_id(db.getString(i, "org_id"));
		    	fib.setOrg_name(db.getString(i, "org_name"));
		    	fib.setIs_indivi(changeString(db.getString(i, "is_indivi")));
		    	fib.setIs_valid(db.getString(i, "is_valid"));
		    	fib.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(i, "create_time")));
		    	fib.setFlow_limit(StringUtil.deNull(db.getString(i, "flow_limit")+changeString(db.getString(i, "limit_unit"))));
		    	fib.setLimit_unit(db.getString(i, "limit_unit"));
		    	list.add(fib);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	 *  @Description  字符转换
	 */
	public String changeString(String unit){
		String u=null;
		if(unit.equals("D")){
			u="天";
		}else if(unit.equals("H")){
			u="小时";
		}else if(unit.equals("Y")){
			u="是";
		}else if(unit.equals("N")){
			u="否";
		}
		return u;
	}
	@Override
	public PagingBean findFlowDefInfoList(FlowDefInfoBean flowDefInfoBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<FlowDefInfoBean> list = new ArrayList<FlowDefInfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		def_id,");
		sql.append(" 		flow_defid,");
		sql.append(" 		flow_id,");
		sql.append(" 		flow_version,");
		sql.append(" 		package_id,");
		sql.append(" 		is_valid,");
		sql.append("        create_time");
		sql.append(" from ta_oa_flow_flowdefinfo where flow_id = ?");
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, flowDefInfoBean.getFlow_id());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	FlowDefInfoBean fdib = new FlowDefInfoBean();
		    	fdib.setDef_id(db.getString(i, "def_id"));
		    	fdib.setFlow_defid(db.getString(i, "flow_defid"));
		    	fdib.setFlow_id(db.getString(i, "flow_id"));
		    	fdib.setFlow_version(db.getString(i, "flow_version"));
		    	fdib.setPackage_id(db.getString(i, "package_id"));
		    	fdib.setIs_valid("Y".equals(db.getString(i, "is_valid"))?"是":"否");
		    	fdib.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(0, "create_time")));
		    	list.add(fdib);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程定义列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findFlowWfactionInfoList(
			FlowWfactionInfoBean flowWfactionInfoBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
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
		sql.append(" from ta_oa_flow_wfaction a ");
		sql.append(" inner join ta_oa_flow_flowdefinfo b on b.def_id = a.def_id ");
		sql.append(" where b.flow_id = ? and b.is_valid = 'Y' order by a.action_id");
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, flowWfactionInfoBean.getFlow_id());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
		    	fwib.setAction_id(db.getString(i, "action_id"));
		    	fwib.setDef_id(db.getString(i, "def_id"));
		    	fwib.setAction_name(db.getString(i, "action_name"));
		    	fwib.setAction_alias(db.getString(i, "action_alias"));
		    	fwib.setAction_limit(db.getString(i, "action_limit"));
		    	fwib.setLimit_unit(changeString(db.getString(i, "limit_unit")));
		    	fwib.setRemark(db.getString(i, "remark"));
		    	fwib.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(i, "create_time")));
		    	list.add(fwib);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程活动定义列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	

	@Override
	public PagingBean findFlowWfactionUserInfoList(FlowWfactUser flowWfactUser,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<FlowWfactUser> list = new ArrayList<FlowWfactUser>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		f.wfactuser_id,");
		sql.append(" 		f.action_id,");
		sql.append(" 		f.user_id,");
		sql.append(" 		f.user_name,");
		sql.append(" 		u.user_realname,");
		sql.append(" 		decode(actuser_type,'1','用户','2','角色','3','用户组','other') actuser_type,");
		sql.append("        create_time");
		sql.append(" from TA_OA_FLOW_WFACTUSER f ,td_sm_user u");
		sql.append("  where action_id = ? and f.user_id= u.user_id");
		
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, flowWfactUser.getAction_id());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	FlowWfactUser fwu = new FlowWfactUser();
		    	fwu.setAction_id(db.getString(i, "action_id"));
		    	fwu.setWfactuser_id(db.getString(i, "wfactuser_id"));
		    	fwu.setUser_id(db.getString(i, "user_id"));
		    	fwu.setUser_name(db.getString(i, "user_realname"));
		    	fwu.setActuser_type(db.getString(i, "actuser_type"));
		    	fwu.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(0, "create_time")));
		    	
		    	list.add(fwu);
		    }
	    } catch (SQLException e) {
			LOG.error("执行活动用户列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public String addFlowBaseInfo(FlowInfoBean flowInfoBean)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String new_flow_id = "";
		sql.append("select seq_flow_flowbaseinfo.nextval new_flow_id from dual");
		sql2.append("insert into ta_oa_flow_flowbaseinfo (flow_id,flow_name,busitype_code,org_id,is_indivi,is_valid,flow_limit,limit_unit,create_time,is_public)")
		   .append(" values (?,?,?,?,?,?,?,?,?,?)");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			new_flow_id = pdb.getString(0, "new_flow_id");
			
			pdb.preparedInsert(sql2.toString());
			pdb.setString(1, new_flow_id);
			pdb.setString(2, StringUtil.deNull(flowInfoBean.getFlow_name()));
			pdb.setString(3, StringUtil.deNull(flowInfoBean.getBusitype_code()));
			pdb.setString(4, StringUtil.deNull(flowInfoBean.getOrg_id()));
			pdb.setString(5, "N");
			pdb.setString(6, StringUtil.deNull(flowInfoBean.getIs_valid()));
			pdb.setString(7, StringUtil.deNull(flowInfoBean.getFlow_limit()));
			pdb.setString(8, StringUtil.deNull(flowInfoBean.getLimit_unit()));
			pdb.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			pdb.setString(10,StringUtil.deNull(flowInfoBean.getIs_public()));
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
		
		return new_flow_id;
	}

	@Override
	public String addFlowDefInfo(FlowDefInfoBean flowDefInfoBean)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String new_flow_defid = "";
		sql.append("select seq_flow_flowdefinfo.nextval new_flow_defid from dual");
		sql2.append("insert into ta_oa_flow_flowdefinfo (def_id,flow_defid,flow_id,flow_version,package_id,is_valid,create_time)")
		   .append(" values (?,?,?,?,?,?,?)");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			new_flow_defid = pdb.getString(0, "new_flow_defid");
			
			pdb.preparedInsert(sql2.toString());
			pdb.setString(1, new_flow_defid);
			pdb.setString(2, flowDefInfoBean.getFlow_defid());
			pdb.setString(3, flowDefInfoBean.getFlow_id());
			pdb.setString(4, flowDefInfoBean.getFlow_version());
			pdb.setString(5, flowDefInfoBean.getPackage_id());
			pdb.setString(6, flowDefInfoBean.getIs_valid());
			pdb.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		return new_flow_defid;
	}

	@Override
	public String addFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String new_action_id = "";
		sql.append("select seq_flow_wfaction.nextval new_action_id from dual");
		sql2.append("insert into ta_oa_flow_wfaction (action_id,def_id,action_name,action_alias,limit_unit,action_limit,remark,create_time)")
		   .append(" values (?,?,?,?,?,?,?,?)");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			new_action_id = pdb.getString(0, "new_action_id");
			
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
		}catch(SQLException e){
			throw e;
		}
		return null;
	}
	
	/**
	 * 查询流程实例是否存在
	 */
	public boolean queryInstance(String flowid) {
		boolean flag=false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ta_oa_ins_instance i");
		sql.append("where  i.flow_id= '"+ flowid +"'");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			if(pdb.size()>0) {
				flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	
	
	/**
	 * 删除未绑定流程信息
	 */
	@Override
	public String deleteFlowBaseInfoById(String flowids)  throws SQLException{
		String flag = "true";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql1.append("select * from ta_oa_ins_instance i");
		sql1.append(" where  i.flow_id ='121' ");
		sql.append("delete from ta_oa_flow_flowbaseinfo where flow_id in (").append(flowids).append(")");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.executePrepared();
		}catch(SQLException e){
			flag = "false";
			throw e;
		}
		return flag;
	}

	@Override
	public void deleteFlowDefInfoById(String flowdefid)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from ta_oa_flow_flowdefinfo where def_id = ?");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, flowdefid);
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
	}

	@Override
	public void deleteFlowWfactionInfoById(String actionid)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from ta_oa_flow_wfaction where action_id = ?");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
	}

	@Override
	public FlowInfoBean findFlowBaseInfoById(String flowid)  throws SQLException{
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
		sql.append(" 		t.is_valid,");
		sql.append("        t.create_time,");
		sql.append("        t.is_public");
		sql.append(" from ta_oa_flow_flowbaseinfo t ");
		sql.append(" left join td_sm_organization o on o.org_id = t.org_id ");
		sql.append(" where t.flow_id = ?  ");
		FlowInfoBean fib = new FlowInfoBean();
		try{
			
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, flowid);
			pdb.executePrepared();
			if(pdb.size() > 0){
		    	fib.setFlow_id(StringUtil.deNull(pdb.getString(0, "flow_id")));
		    	fib.setFlow_name(StringUtil.deNull(pdb.getString(0, "flow_name")));
		    	fib.setBusitype_code(StringUtil.deNull(pdb.getString(0, "busitype_code")));
		    	fib.setOrg_name(StringUtil.deNull(pdb.getString(0, "org_name")));
		    	fib.setOrg_id(StringUtil.deNull(pdb.getString(0, "org_id")));
		    	fib.setLimit_unit(StringUtil.deNull(pdb.getString(0, "limit_unit")));
		    	fib.setFlow_limit(StringUtil.deNull(pdb.getString(0, "flow_limit")));
		    	fib.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
		    	fib.setIs_public(StringUtil.deNull(pdb.getString(0, "is_public")));
		    	fib.setCreate_time(DateUtil.GetTimeString(pdb.getTimestamp(0, "create_time")));
			}
		}catch(SQLException e){
			throw e;
		}
		return fib;
	}

	@Override
	public FlowDefInfoBean findFlowDefInfoByFlowId(String flowid) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		def_id,");
		sql.append(" 		flow_defid,");
		sql.append(" 		flow_id,");
		sql.append(" 		flow_version,");
		sql.append(" 		package_id,");
		sql.append(" 		is_valid,");
		sql.append("        create_time");
		sql.append(" from ta_oa_flow_flowdefinfo where flow_id = ? and is_valid ='Y'");
		FlowDefInfoBean fdib = new FlowDefInfoBean();
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, flowid);
			pdb.executePrepared();
			if(pdb.size() > 0){
		    	fdib.setDef_id(StringUtil.deNull(pdb.getString(0, "def_id")));
		    	fdib.setFlow_defid(StringUtil.deNull(pdb.getString(0, "flow_defid")));
		    	fdib.setFlow_id(StringUtil.deNull(pdb.getString(0, "flow_id")));
		    	fdib.setFlow_version(StringUtil.deNull(pdb.getString(0, "flow_version")));
		    	fdib.setPackage_id(StringUtil.deNull(pdb.getString(0, "package_id")));
		    	fdib.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
		    	fdib.setCreate_time(DateUtil.GetTimeString(pdb.getTimestamp(0, "create_time")));
			}
		}catch(SQLException e){
			throw e;
		}
		return fdib;
	}

	@Override
	public FlowWfactionInfoBean findFlowWfactionInfoById(String actionid)  throws SQLException{
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
		sql.append(" from ta_oa_flow_wfaction where action_id = ?");
		FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
			if(pdb.size() > 0){
				fwib.setAction_id(StringUtil.deNull(pdb.getString(0, "action_id")));
		    	fwib.setDef_id(StringUtil.deNull(pdb.getString(0, "def_id")));
		    	fwib.setAction_name(StringUtil.deNull(pdb.getString(0, "action_name")));
		    	fwib.setAction_alias(StringUtil.deNull(pdb.getString(0, "action_alias")));
		    	fwib.setAction_limit(StringUtil.deNull(pdb.getString(0, "action_limit")));
		    	fwib.setLimit_unit(StringUtil.deNull(pdb.getString(0, "limit_unit")));
		    	fwib.setRemark(StringUtil.deNull(pdb.getString(0, "remark")));
		    	fwib.setCreate_time(DateUtil.GetTimeString(pdb.getTimestamp(0, "create_time")));
			}
	    	
			
		}catch(SQLException e){
			throw e;
		}
		return fwib;
	}

	@Override
	public void updateFlowBaseInfo(FlowInfoBean flowInfoBean)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_flow_flowbaseinfo set ");
		sql.append("flow_name = ?,");
		sql.append("org_id = ?,");
		sql.append("is_valid = ?,");
		sql.append("flow_limit = ?,");
		sql.append("limit_unit = ?,");
		sql.append("busitype_code = ?,");
		sql.append("is_public = ?");
		sql.append(" where flow_id = ?");

		try{
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, flowInfoBean.getFlow_name());
			pdb.setString(2, flowInfoBean.getOrg_id());
			pdb.setString(3, flowInfoBean.getIs_valid());
			pdb.setString(4, flowInfoBean.getFlow_limit());
			pdb.setString(5, flowInfoBean.getLimit_unit());
			pdb.setString(6, flowInfoBean.getBusitype_code());
			pdb.setString(7, flowInfoBean.getIs_public());
			pdb.setString(8, flowInfoBean.getFlow_id());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}

	@Override
	public void updateFlowDefInfo(FlowDefInfoBean flowDefInfoBean) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_flow_flowdefinfo set flow_defid = ?,");
		sql.append("flow_id = ?,");
		sql.append("flow_version = ?,");
		sql.append("package_id = ?,");
		sql.append("is_valid = ?,");
		sql.append(" where def_id = ?");
	
		try{
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, flowDefInfoBean.getFlow_defid());
			pdb.setString(2, flowDefInfoBean.getFlow_id());
			pdb.setString(3, flowDefInfoBean.getFlow_version());
			pdb.setString(4, flowDefInfoBean.getPackage_id());
			pdb.setString(5, flowDefInfoBean.getIs_valid());
			pdb.setString(6, flowDefInfoBean.getDef_id());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}

	@Override
	public void updateFlowWfactionInfo(FlowWfactionInfoBean flowWfactionInfoBean)  throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_flow_wfaction set ");
		sql.append("action_name = ?,");
		sql.append("action_alias = ?,");
		sql.append("limit_unit = ?,");
		sql.append("action_limit = ?,");
		sql.append("remark = ?");
		sql.append(" where action_id = ?");

		try{
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, flowWfactionInfoBean.getAction_name());
			pdb.setString(2, flowWfactionInfoBean.getAction_alias());
			pdb.setString(3, flowWfactionInfoBean.getLimit_unit());
			pdb.setString(4, flowWfactionInfoBean.getAction_limit());
			pdb.setString(5, flowWfactionInfoBean.getRemark());
			pdb.setString(6, flowWfactionInfoBean.getAction_id());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}
	
	@Override
	public String addFlowWfactionExtInfo(FlowWfactionExtBean flowWfactionExtBean)
			throws Exception {
		String new_wfactionext_id = DaoUtil.findBySequencsName("seq_flow_wfaction_ext");
		flowWfactionExtBean.setActionext_id(new_wfactionext_id);
		flowWfactionExtBean.setCreate_time(new Timestamp(System.currentTimeMillis()));
		flowWfactionExtBean.setAutoassignment(getFlowWfactionExtAutoassignment(flowWfactionExtBean.getAutoassignment(),flowWfactionExtBean.getAction_id()));
		insert(flowWfactionExtBean);
		return new_wfactionext_id;
	}
	
	/**
	 * 
	*<b>Summary: 获取流程扩展属性：是否使用前置活动执行人</b></br>
	* 如果传入的值是Y，则使用当前环节定义id，如果是N，则把当前值设置成空
	* @param autoassignment
	* @param action_id
	* @return
	* @throws SQLException
	 */
	private String getFlowWfactionExtAutoassignment(String autoassignment,String action_id) throws SQLException{
		return StringUtil.nullOrBlank(autoassignment)?"N":autoassignment;
	}

	@Override
	public String addFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String new_wfactionformdef_id = "";
		sql.append("select seq_flow_action_fromdefid.nextval new_wfactionformdef_id from dual");
		sql2.append("insert into TA_OA_FLOW_ACTION_FROMDEFID (form_id,action_id,action_form)")
		   .append(" values (?,?,?)");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			new_wfactionformdef_id = pdb.getString(0, "new_wfactionformdef_id");
			
			pdb.preparedInsert(sql2.toString());
			pdb.setString(1, new_wfactionformdef_id);
			pdb.setString(2, flowWfactionFormDefBean.getAction_id());
			pdb.setString(3, flowWfactionFormDefBean.getAction_form());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		return new_wfactionformdef_id;
	}

	@Override
	public String addFlowWfactionUserInfo(FlowWfactUser flowWfactUser)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		//人员ID不能为空
		if(!StringUtil.isBlank(flowWfactUser.getUser_id())){
			String[] userids = flowWfactUser.getUser_id().split(",");
			String[] usernames = flowWfactUser.getUser_name().split(",");
			String new_wfactionuser_id = "";
			sql.append("select seq_flow_wfactuser.nextval new_wfactionuser_id from dual");
			sql2.append("insert into TA_OA_FLOW_WFACTUSER (wfactuser_id,action_id,user_id,user_name,actuser_type,create_time)")
			   .append(" values (?,?,?,?,?,?)");
			sql3.append("select * from TA_OA_FLOW_WFACTUSER where user_id=? and action_id=?");
			try{
				for(int i = 0; i < userids.length ; i ++){
					pdb.preparedSelect(sql3.toString());
					pdb.setString(1, flowWfactUser.getUser_id());
					pdb.setString(2, flowWfactUser.getAction_id());
					pdb.executePrepared();
					if(pdb.size() == 0){
						pdb.preparedSelect(sql.toString());
						pdb.executePrepared();
						new_wfactionuser_id = pdb.getString(0, "new_wfactionuser_id");
						pdb.preparedInsert(sql2.toString());
						pdb.setString(1, new_wfactionuser_id);
						pdb.setString(2, flowWfactUser.getAction_id());
						pdb.setString(3, userids[i]);
						pdb.setString(4, usernames[i]);
						pdb.setString(5, flowWfactUser.getActuser_type());
						pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
						pdb.executePrepared();
					}
					
				}
				
			}catch(SQLException e){
				throw e;
			}
		}
		return "";
		
	}

	@Override
	public void deleteFlowWfactionFormDefById(String actionid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from TA_OA_FLOW_ACTION_FROMDEFID where action_id = ?");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}

	@Override
	public void deleteFlowWfactionUserInfoById(String userids)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from TA_OA_FLOW_WFACTUSER where wfactuser_id in (").append(userids).append(")");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}
	@Override
	public void deleteFlowWfactionUserInfoByActionId(String actionId)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from TA_OA_FLOW_WFACTUSER where action_id = ?");
		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, actionId);
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}

	@Override
	public Map<String,String> findFlowWfactionExtInfoById(String actionid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		actionext_id,");
		sql.append(" 		action_id,");
		sql.append(" 		nvl(isshowuser,'N') isshowuser,");
		sql.append(" 		nvl(isshowreject,'N') isshowreject,");
		sql.append(" 		nvl(isshowback,'N') isshowback,");
		sql.append(" 		decode(autoassignment,null,'N','N','N',autoassignment) autoassignment,");
		sql.append(" 		nvl(issignjoinbyorder,'N') issignjoinbyorder,");
		sql.append("        create_time");
		sql.append(" from TA_OA_FLOW_WFACTION_EXT where action_id = ?");
		return queryToSingleMap(sql.toString(), actionid);
	}

	@Override
	public FlowActionFormDef findFlowWfactionFormDefById(String actionid)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		form_id,");
		sql.append(" 		action_id,");
		sql.append(" 		action_form");
		sql.append(" from TA_OA_FLOW_ACTION_FROMDEFID where action_id = ?");
		FlowActionFormDef fafd = new FlowActionFormDef();
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
			if(pdb.size() > 0){
				fafd.setForm_id(StringUtil.deNull(pdb.getString(0, "form_id")));
				fafd.setAction_id(StringUtil.deNull(pdb.getString(0, "action_id")));
				fafd.setAction_form(StringUtil.deNull(pdb.getString(0, "action_form")));
			}
		}catch(SQLException e){
			throw e;
		}
		return fafd;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFlowWfactionTreeConfigById
	  * @param actionid
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#findFlowWfactionTreeConfigById(java.lang.String)
	 */
	public FlowActionTreeConfigBean findFlowWfactionTreeConfigById(
			String actionid) throws Exception {
		FlowActionTreeConfigBean flowActionTreeConfigBean = new FlowActionTreeConfigBean(); ;
		flowActionTreeConfigBean.clearPKey().setPKey("action_id");
		flowActionTreeConfigBean.setAction_id(actionid);
		flowActionTreeConfigBean = (FlowActionTreeConfigBean)queryToBean(flowActionTreeConfigBean);
		if(null == flowActionTreeConfigBean){
			flowActionTreeConfigBean = new FlowActionTreeConfigBean(); 
		}
		return flowActionTreeConfigBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isExsitFlowActTreeConfig
	  * @param actionid
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#isExsitFlowActTreeConfig(java.lang.String)
	 */
	public boolean isExsitFlowActTreeConfig(String actionid)
			throws Exception {
		if(StringUtil.nullOrBlank(findFlowWfactionTreeConfigById(actionid).getConfig_id()))
			return false;
		return true;
	}

	@Override
	public void updateFlowWfactionExtInfo(
			FlowWfactionExtBean flowWfactionExtBean) throws Exception {
		flowWfactionExtBean.setAutoassignment(getFlowWfactionExtAutoassignment(flowWfactionExtBean.getAutoassignment(),flowWfactionExtBean.getAction_id()));
		update(flowWfactionExtBean);
	}

	@Override
	public void updateFlowWfactionFormDef(
			FlowActionFormDef flowWfactionFormDefBean) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update TA_OA_FLOW_ACTION_FROMDEFID set ");
		sql.append("action_form = ?");
		sql.append(" where action_id = ?");

		try{
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, flowWfactionFormDefBean.getAction_form());
			pdb.setString(2, flowWfactionFormDefBean.getAction_id());
			pdb.executePrepared();
		}catch(SQLException e){
			throw e;
		}
		
	}
	
	

	@Override
	public boolean isExsitFlowFormDefInfo(String actionid) throws SQLException {
		boolean isexsit = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from TA_OA_FLOW_ACTION_FROMDEFID where form_id = ? ");

		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
			if(pdb.size() > 0){
				isexsit = true;
			}
		}catch(SQLException e){
			throw e;
		}
		return isexsit;
	}

	@Override
	public boolean isExsitFlowWfactionExtInfo(String actionid)
			throws SQLException {
		boolean isexsit = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from TA_OA_FLOW_WFACTION_EXT where action_id = ?");

		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, actionid);
			pdb.executePrepared();
			if(pdb.size() > 0){
				isexsit = true;
			}
		}catch(SQLException e){
			throw e;
		}
		return isexsit;
	}

	/**
	 * @Description:流程设置为无效
	 * @param ecId
	 * @throws Exception
	 */
	public void stopFlowInfo(String flow_id) throws Exception {
		String sql = "update ta_oa_flow_flowdefinfo set IS_VALID = 'N'  where flow_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedUpdate(sql);
			pdb.setString(1, flow_id);
			pdb.executePrepared();
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	/**
	 * 是否存在流程
	 */
	public boolean isExistFlow(String packageId, String processId, String flowId,
			String flowVersion) throws Exception {
		String sql = "select count(*) from ta_oa_flow_flowdefinfo t where t.flow_id= ? and t.flow_version=? "
				+ " and t.package_id = ? and t.flow_defid = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
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
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	/**
	 * @Description:启用流程
	 * @param ecId
	 * @param flowId
	 * @throws Exception
	 */
	public void startupFlowInfo(String flowDefId) throws Exception {
		String sql = "update ta_oa_flow_flowdefinfo set IS_VALID = 'Y'  where def_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedUpdate(sql);
			pdb.setString(1, flowDefId);
			pdb.executePrepared();
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	/**
	 * @Description:新增环节信息
	 * @param defID
	 * @param packageId
	 * @param processId
	 * @param flowVersion
	 * @throws Exception
	 */
	public void insertWFAction(String defID, String packageId,
			String processId, String flowVersion) throws Exception {
		WorkflowManager workflowManager = new WorkflowManagerImpl();
		SharkEngine shark = SharkEngine.getInstance();
		DBUtil dbUtil = new DBUtil();
		try {
			shark.loginWorkflowServer("admin", "");
			List<ActivityBean> actList = workflowManager
					.getActionListByProcessId(packageId, flowVersion, processId);
			shark.logoutWorkflowServer();
			if (actList != null && actList.size() > 0)
				for (int i = 0; i < actList.size(); i++) {
					StringBuffer sql = new StringBuffer();
					ActivityBean actBean = actList.get(i);
					String mgrName = packageId + "#" + flowVersion + "#"
							+ processId;
					String actionCodeid = getActionCode(mgrName, actBean
							.getActDefId());
					sql.append("insert into ");
					sql.append("ta_oa_flow_wfaction(ACTION_ID,def_id,action_defid,action_name,action_alias,action_limit,actiontype_code) values( ");
					sql.append(" seq_flow_wfaction.nextval,'");
					sql.append(defID).append("','");
					sql.append(actBean.getActDefId()).append("','");
					sql.append(actBean.getActName()).append("','");
					sql.append(actBean.getActName()).append("','");
					sql.append(actBean.getLimit()).append("','");
					sql.append(actionCodeid).append("')");
					dbUtil.addBatch(sql.toString());
				}
			dbUtil.executeBatch();
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	public String getActionCode(String mgrName, String actionDefid) {
		try {
			boolean isFirstAct = isFirstAct(mgrName, actionDefid);
			boolean isLastAct = isLastAct(mgrName, actionDefid);
			if (isFirstAct) {
				return "01";
			} else if (isLastAct) {
				return "03";
			} else {
				return "02";
			}
		} catch (Exception e) {
			LOG.error(e.toString());
			return "02";
		}
	}

	/**
	 * @Description:是否存在环节
	 * @param flowId
	 * @return
	 * @throws Exception
	 */
	public boolean hasAct(String flowId) throws Exception {
		String sql = "select count(*) from ta_oa_flow_wfaction where def_id=?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(sql);
			pdb.setString(1, flowId);
			pdb.executePrepared();
			if (pdb.size() > 0) {
				if (Integer.parseInt(pdb.getString(0, 0)) > 0) {
					return true;
				} else {
					return false;
				}
			}
			return false;
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	/**
	 * @Description:得到老版本流程id
	 * @param packageId
	 * @param processId
	 * @param ecId
	 * @return
	 * @throws Exception
	 */
	public String getOldFlowId(String packageId, String flowDefId, String flowId)
			throws Exception {
		String sql = "select t.def_id from ta_oa_flow_flowdefinfo t where t.flow_id= ?"
				+ " and t.package_id = ? and t.flow_defid= ? and t.is_valid = 'Y' and rownum = 1";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(sql);
			pdb.setString(1, flowId);
			pdb.setString(2, packageId);
			pdb.setString(3, flowDefId);

			pdb.executePrepared();
			if (pdb.size() > 0) {
				return pdb.getString(0, 0);
			}
			return "";
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}
	
	/**
	 * 获得流程定义id
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<String> getFlowAct(String def_id) throws SQLException {
		List<String> list = new ArrayList<String>();
		StringBuffer buf = new StringBuffer();
		buf.append("select w.action_id from ta_oa_flow_wfaction w where w.def_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.setString(1, def_id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			list.add(db.getString(i, "action_id"));
		}

		return list;
	}

	/**
	 * @Description:是否流程的第一个环节
	 * @param mgrName
	 * @return
	 * @throws Exception
	 */
	public boolean isFirstAct(String mgrName, String actDefId) throws Exception {
		//SharkEngine.getInstance().getFirstActivityByMgrName(String mgrName);
		if(getFirstActivityByMgrName(mgrName).getId().equals(actDefId)){
			return true;
		}
		return false;
	}

	/**
	 * @Description:是否流程的最后一个环节
	 * @param mgrName
	 * @param actDef
	 * @return
	 * @throws Exception
	 */
	public boolean isLastAct(String mgrName, String actDefId) throws Exception {
		List<Activity> ends = getLastActivityByMgrName(mgrName);
		for(int i = 0 ; i < ends.size() ; i++){
			Activity activity = ends.get(i);
			if(activity.getId().equals(actDefId)){
				return true;
			}
		}
		return false;
	}
	
	public Activity getFirstActivityByMgrName(String mgrName) {
		String pkgId = mgrName.split(MGRNAME_SPLIT_TOKEN)[0];
		String version = mgrName.split(MGRNAME_SPLIT_TOKEN)[1];
		String procDefId = mgrName.split(MGRNAME_SPLIT_TOKEN)[2];
		WorkflowProcess pDef = SharkUtilities.getpackagedef(pkgId, version)
				.getWorkflowProcess(procDefId);
		List starts = pDef.getStartingActivities();
		Activity actDef = (Activity) starts.get(0);
		return actDef;
	}
	
	public List<Activity> getLastActivityByMgrName(String mgrName) {
		String pkgId = mgrName.split(MGRNAME_SPLIT_TOKEN)[0];
		String version = mgrName.split(MGRNAME_SPLIT_TOKEN)[1];
		String procDefId = mgrName.split(MGRNAME_SPLIT_TOKEN)[2];
		WorkflowProcess pDef = SharkUtilities.getpackagedef(pkgId, version)
				.getWorkflowProcess(procDefId);
		List<Activity> ends = pDef.getEndingActivities();
//		Activity actDef = (Activity) starts.get(0);
		return ends;
	}
	
		@Override
	public List<FlowWfactionInfoBean> getWfActionListByFlowId(String flowDefId) {
		PreparedDBUtil  db = new PreparedDBUtil ();
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
		sql.append(" 		a.action_defid, ");
		sql.append("        a.create_time");
		sql.append(" from ta_oa_flow_wfaction a ");
		sql.append(" where a.def_id = ? order by a.actiontype_code");
		try {
	    	db.preparedSelect(sql.toString());
	    	db.setString(1, flowDefId);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
		    	fwib.setAction_id(db.getString(i, "action_id"));
		    	fwib.setDef_id(db.getString(i, "def_id"));
		    	fwib.setAction_name(db.getString(i, "action_name"));
		    	fwib.setAction_alias(db.getString(i, "action_alias"));
		    	fwib.setAction_limit(db.getString(i, "action_limit"));
		    	fwib.setLimit_unit(db.getString(i, "limit_unit"));
		    	fwib.setRemark(db.getString(i, "remark"));
		    	fwib.setAction_defid(db.getString(i, "action_defid"));
		    	fwib.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(0, "create_time")));
		    	list.add(fwib);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程活动定义列表查询报错："+e.getMessage());
		}
	    
		return list;
	}
		
		@Override
		public Map<String,FlowWfactionInfoBean> getWfActionMapByFlowId(String flow_def_id){
			PreparedDBUtil  db = new PreparedDBUtil ();
			Map<String,FlowWfactionInfoBean> resultMap = new HashMap<String,FlowWfactionInfoBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		a.action_id,");
			sql.append(" 		a.def_id,");
			sql.append(" 		a.action_name,");
			sql.append(" 		a.action_alias,");
			sql.append(" 		a.limit_unit,");
			sql.append(" 		a.action_limit,");
			sql.append(" 		a.remark,");
			sql.append(" 		a.action_defid, ");
			sql.append("        a.create_time");
			sql.append(" from ta_oa_flow_wfaction a ");
			sql.append(" where a.def_id = ? order by a.actiontype_code");
			try {
		    	db.preparedSelect(sql.toString());
		    	db.setString(1, flow_def_id);
		    	db.executePrepared();
			    for(int i = 0;i < db.size();i++){
			    	FlowWfactionInfoBean fwib = new FlowWfactionInfoBean();
			    	fwib.setAction_id(db.getString(i, "action_id"));
			    	fwib.setDef_id(db.getString(i, "def_id"));
			    	fwib.setAction_name(db.getString(i, "action_name"));
			    	fwib.setAction_alias(db.getString(i, "action_alias"));
			    	fwib.setAction_limit(db.getString(i, "action_limit"));
			    	fwib.setLimit_unit(db.getString(i, "limit_unit"));
			    	fwib.setRemark(db.getString(i, "remark"));
			    	fwib.setAction_defid(db.getString(i, "action_defid"));
			    	fwib.setCreate_time(DateUtil.GetTimeString(db.getTimestamp(0, "create_time")));
			    	resultMap.put(db.getString(i, "action_defid"), fwib);
			    }
		    } catch (SQLException e) {
				LOG.error("执行流程活动定义列表查询报错："+e.getMessage());
			}
		    
			return resultMap;
		}
		
		

	@Override
	public String getActionId(String FlowId, String actionDefId) throws Exception{
		String sql = "select * from ta_oa_flow_wfaction t where t.def_id= ?"
			+ " and t.action_defid = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(sql);
			pdb.setString(1, FlowId);
			pdb.setString(2, actionDefId);
		
	
			pdb.executePrepared();
			if (pdb.size() > 0) {
				return pdb.getString(0, 0);
			}
			return "";
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}

	@Override
	public void addActUsersInfo(String oldActionId, String newActionId)
			throws Exception {
		StringBuffer sql = new StringBuffer();

		
		sql.append("insert into ta_oa_flow_wfactuser ");
		sql.append("  (wfactuser_id, action_id, user_id, user_name, actuser_type, create_time) ");
		sql.append("select SEQ_FLOW_WFACTUSER.nextval, ");
		sql.append("          '"+newActionId+"', ");
		sql.append("          t.user_id, ");
		sql.append("          t.user_name, ");
		sql.append("          t.actuser_type, ");
		sql.append("          sysdate ");
		sql.append("     from ta_oa_flow_wfactuser t ");
		sql.append("    where action_id = '"+oldActionId+"' ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedInsert(sql.toString());

		
			pdb.executePrepared();
			
		} catch (Exception e) {
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getWfactionExtAutoassignmentDictDropDownList
	  * @param action_id
	  * @param autoassignment
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao#getWfactionExtAutoassignmentDictDropDownList(java.lang.String, java.lang.String)
	 */
	public String getWfactionExtAutoassignmentDictDropDownList(String action_id,
			String autoassignment) throws Exception {
		String sql = "select action_defid,w.action_name from ta_oa_flow_wfaction w where w.def_id = (select wf.def_id from ta_oa_flow_wfaction wf where wf.action_id = '"+action_id+"')";
		return DictDropDownList.buildSelect(sql, "AUTOASSIGNMENT", "autoassignment", "", true, "", "width:130px;margin-left:5px;");
	}


	
	
	
}

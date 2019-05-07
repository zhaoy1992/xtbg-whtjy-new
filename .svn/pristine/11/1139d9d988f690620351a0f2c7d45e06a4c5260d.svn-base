package com.chinacreator.xtbg.core.process.flowprocessing.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InsViewListBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *  公文管理->意见dao
 *   将针对意见的存取都转移到该类中来,
 *   不包括 与 手机端对接的 PCWorkFlowDaoImpl.saveActionView 中处理意见的方法没有迁移过来 
 *<p>Title:FlowViewDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-6-13
 */
public class FlowViewDaoImpl extends XtDbBaseDao{
	
	private static final Logger LOG = Logger.getLogger(FlowViewDaoImpl.class);
	/**
	 * 写意见,从FlowInstanceDataSaveDaoImpl.java把方法 剪切过来
	 *<b>Summary: </b>
	 * saveActionView
	 * @param request
	 * @param response
	 * @param viewListBeanList
	 * @param con
	 * @return
	 * @throws Exception
	 */
	public boolean saveActionView(HttpServletRequest request, HttpServletResponse response, List<ViewListBean> viewListBeanList, Connection con) throws Exception{
		if(viewListBeanList!=null){
			ViewListBean sameMessBean = new ViewListBean();
			//1.1取参数:从AccessControl取
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request, response);
			
			sameMessBean.setUser_id(control.getUserID());
			sameMessBean.setUser_name(control.getUserName());
			sameMessBean.setOrg_id(control.getChargeOrgId());
			sameMessBean.setOrg_name(control.getChargeOrgName());
			
			//1.2取参数:从request取
			String flowDataJson = request.getParameter("flowData");//流程信息
			flowDataJson = DataControlUtil.replaceStr(flowDataJson);
			Map<String, String> flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
			String action_ins_id = flowData.get("actInsId");
			if(StringUtil.nullOrBlank(action_ins_id)){
				action_ins_id = ViewListBean.FIRST_ACTION_INS_ID;
				con=null;
			}
			sameMessBean.setIns_id(StringUtil.deNull(request.getAttribute("ins_id")));
			sameMessBean.setAction_id(flowData.get("action_id"));
			sameMessBean.setAction_name(flowData.get("action_name"));
			sameMessBean.setAction_ins_id(action_ins_id);
			
			
			PreparedDBUtil pdb = new PreparedDBUtil();
			
			
			//3
			StringBuffer sql = new StringBuffer();
			sql.append("insert into oa_flow_insviewlist ");
			sql.append("  (viewlist_id, ");
			sql.append("   ins_id, ");
			sql.append("   action_id, ");
			sql.append("   action_name, ");
			sql.append("   action_handeridea, ");
			sql.append("   hander_time, ");
			sql.append("   is_valid, ");
			sql.append("   org_id, ");
			sql.append("   org_name, ");
			sql.append("   user_id, ");
			sql.append("   user_name,");
			sql.append("   table_name,");
			sql.append("   column_name, ");
			sql.append("   ACTION_INS_ID) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, sysdate, 'Y', ?, ?, ?, ?, ?, ?, ?) ");
			for (ViewListBean tmp : viewListBeanList) {
				//2如果不是第一个环节,考虑删除重复意见
				if(!action_ins_id.equals(ViewListBean.FIRST_ACTION_INS_ID)){
					sameMessBean.setTable_name(tmp.getTable_name());
					sameMessBean.setColumn_name(tmp.getColumn_name());
					this.delOldView(sameMessBean,pdb);
				}
				
				String viewlist_id = StringUtil.getUUID();
				
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, viewlist_id);
				pdb.setString(2, sameMessBean.getIns_id());
				pdb.setString(3, sameMessBean.getAction_id());
				pdb.setString(4, sameMessBean.getAction_name());
				pdb.setString(5, tmp.getAction_handeridea());
				pdb.setString(6, sameMessBean.getOrg_id());
				pdb.setString(7, sameMessBean.getOrg_name());
				pdb.setString(8, sameMessBean.getUser_id());
				pdb.setString(9, sameMessBean.getUser_name());
				pdb.setString(10, tmp.getTable_name());
				pdb.setString(11, tmp.getColumn_name());
				pdb.setString(12, sameMessBean.getAction_ins_id());
				pdb.executePrepared(con);
			}
			
			
		}
		
		return true;
	}
	private void delOldView(ViewListBean sameMessBean,
			PreparedDBUtil pdb) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from oa_flow_insviewlist");
		sql.append(" where ins_id = '"+sameMessBean.getIns_id()+"'");
		sql.append("   and action_id = '"+sameMessBean.getAction_id()+"'");
		sql.append("   and action_ins_id = '"+sameMessBean.getAction_ins_id()+"'");
		sql.append("   and table_name = '"+sameMessBean.getTable_name()+"'");
		sql.append("   and column_name = '"+sameMessBean.getColumn_name()+"'");
		sql.append("   and user_id = '"+sameMessBean.getUser_id()+"'");
		
		try {
			pdb.executeDelete(sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
			LOG.debug(e.getClass().getName()+";insId:"+sameMessBean.getIns_id());
		}
	}
	/**
	 * 不全数据
	 *<b>Summary: </b>
	 * callBackForFullData(请用一句话描述这个方法的作用)
	 * @param insId
	 */
	public void callBackForFullData(String...data){
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_flow_insviewlist ofi");
		sql.append(" set ofi.action_ins_id='"+data[1]+"'");
		sql.append(" where ofi.action_ins_id = '"+ViewListBean.FIRST_ACTION_INS_ID+"'");
		sql.append("   and ofi.ins_id = '"+data[0]+"'");
		try {
			PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
			preparedDBUtil.executeUpdate(sql.toString());
		} catch (Exception e) {
			LOG.debug(e.getClass().getName()+";insId:"+data[0]);
		}
	}
	
	
	/**
	 * 查意见
	 *<b>Summary: </b>
	 * getFlowviewlist(从FlowUtilDaoImpl中把该方法迁移过来,不修改FlowUtilDaoImpl原来的接口结构)
	 * @param ins_id
	 * @return
	 * @throws SQLException
	 */
	public List<InsViewListBean> getFlowviewlist(String ins_id) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select v.viewlist_id, ");
		sql.append("   v.ins_id, ");
		sql.append("   v.action_id, ");
		sql.append("   v.action_name, ");
		sql.append("   v.action_handeridea, ");
		sql.append("   v.hander_time, ");
		sql.append("   v.org_name, ");
		sql.append("   w.action_defid, ");
		sql.append("   v.user_id, ");
		sql.append("   v.user_name ");
		sql.append("from oa_flow_insviewlist v, oa_flow_wfaction w ");
		sql.append("where v.action_id = w.action_id ");
		sql.append("and v.ins_id = ? ");
		sql.append(" order by v.hander_time desc ");
		db.preparedSelect(sql.toString());
		db.setString(1, ins_id);
		db.executePrepared();

		List<InsViewListBean> insViewListBeanList = new

		ArrayList<InsViewListBean>();
		for (int i = 0; i < db.size(); i++) {
			InsViewListBean insViewListBean = new

			InsViewListBean();
			insViewListBean.setViewlist_id(db.getString(i,"viewlist_id"));
			insViewListBean.setIns_id(db.getString(i,"ins_id"));
			insViewListBean.setAction_id(db.getString(i,"action_id"));
			insViewListBean.setAction_name(db.getString(i,"action_name"));
			insViewListBean.setAction_handeridea(db.getString(i, "action_handeridea"));
			insViewListBean.setHander_time(db.getString(i,"hander_time"));
			insViewListBean.setOrg_name(db.getString(i,"org_name"));
			insViewListBean.setAction_defid(db.getString(i,"action_defid"));
			insViewListBean.setUser_id(db.getString(i,"user_id"));
			insViewListBean.setUser_name(db.getString(i,"user_name"));
			insViewListBeanList.add(insViewListBean);
		}
		return insViewListBeanList;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getViewListForShow(获得所有意见)
	 * @param flowInsId
	 * @param actionInsId
	 * @return
	 * @throws SQLException 
	 */
	public List<ViewListBean> getViewListForShow(String flowInsId) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append("select ofi.viewlist_id,");
		sql.append("       ofi.ins_id,");
		sql.append("       ofi.action_id,");
		sql.append("       ofi.action_name,");
		sql.append("       ofi.action_handeridea,");
		sql.append("       ofi.hander_time,");
		sql.append("       ofi.is_valid,");
		sql.append("       ofi.remark1,");
		sql.append("       ofi.remark2,");
		sql.append("       ofi.org_id,");
		sql.append("       ofi.org_name,");
		sql.append("       ofi.user_id,");
		sql.append("       ofi.user_name,");
		sql.append("       ofi.table_name,");
		sql.append("       ofi.column_name,");
		sql.append("       ofi.action_ins_id");
		sql.append("  from oa_flow_insviewlist ofi");
		sql.append(" where ofi.ins_id = ?");
		sql.append(" order by ofi.hander_time asc");
		
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, flowInsId);
		db.executePrepared();
		List<ViewListBean> list = new ArrayList<ViewListBean>();
		for(int i=0;i<db.size();i++){
			ViewListBean bean = new ViewListBean();
			bean.setViewlist_id(db.getString(i,"viewlist_id"));
			bean.setIns_id(db.getString(i,"ins_id"));
			bean.setAction_id(db.getString(i,"action_id"));
			bean.setAction_name(db.getString(i,"action_name"));
			bean.setAction_handeridea(db.getString(i,"action_handeridea"));
			bean.setHander_time(db.getString(i,"hander_time"));
			bean.setIs_valid(db.getString(i,"is_valid"));
			bean.setRemark1(db.getString(i,"remark1"));
			bean.setRemark2(db.getString(i,"remark2"));
			bean.setOrg_id(db.getString(i,"org_id"));
			bean.setOrg_name(db.getString(i,"org_name"));
			bean.setUser_id(db.getString(i,"user_id"));
			bean.setUser_name(db.getString(i,"user_name"));
			bean.setTable_name(db.getString(i,"table_name"));
			bean.setColumn_name(db.getString(i,"column_name"));
			bean.setAction_ins_id(db.getString(i, "action_ins_id"));
			list.add(bean);
		}
		return list;
	}
	
	public List<ViewListBean> getViewListForShow(HttpServletRequest request) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append("select ofi.viewlist_id,");
		sql.append("       ofi.ins_id,");
		sql.append("       ofi.action_id,");
		sql.append("       ofi.action_name,");
		sql.append("       ofi.action_handeridea,");
		sql.append("       ofi.hander_time,");
		sql.append("       ofi.is_valid,");
		sql.append("       ofi.remark1,");
		sql.append("       ofi.remark2,");
		sql.append("       ofi.org_id,");
		sql.append("       ofi.org_name,");
		sql.append("       ofi.user_id,");
		sql.append("       ofi.user_name,");
		sql.append("       ofi.table_name,");
		sql.append("       ofi.column_name,");
		sql.append("       ofi.action_ins_id");
		sql.append("  from oa_flow_insviewlist ofi");
		sql.append(" where ofi.ins_id = ?");
		sql.append("   and ofi.table_name = ?");
		sql.append("   and ofi.column_name = ?");
		sql.append(" order by ofi.hander_time desc");
		
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, request.getParameter("insid"));
		db.setString(2, request.getParameter("table"));
		db.setString(3, request.getParameter("column"));
		db.executePrepared();
		List<ViewListBean> list = new ArrayList<ViewListBean>();
		for(int i=0;i<db.size();i++){
			ViewListBean bean = new ViewListBean();
			bean.setViewlist_id(db.getString(i,"viewlist_id"));
			bean.setIns_id(db.getString(i,"ins_id"));
			bean.setAction_id(db.getString(i,"action_id"));
			bean.setAction_name(db.getString(i,"action_name"));
			bean.setAction_handeridea(db.getString(i,"action_handeridea"));
			bean.setHander_time(db.getString(i,"hander_time"));
			bean.setIs_valid(db.getString(i,"is_valid"));
			bean.setRemark1(db.getString(i,"remark1"));
			bean.setRemark2(db.getString(i,"remark2"));
			bean.setOrg_id(db.getString(i,"org_id"));
			bean.setOrg_name(db.getString(i,"org_name"));
			bean.setUser_id(db.getString(i,"user_id"));
			bean.setUser_name(db.getString(i,"user_name"));
			bean.setTable_name(db.getString(i,"table_name"));
			bean.setColumn_name(db.getString(i,"column_name"));
			bean.setAction_ins_id(db.getString(i, "action_ins_id"));
			list.add(bean);
		}
		return list;
	}
	public PagingBean queryViewList(ViewListBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofi.viewlist_id,");
			sql.append("       ofi.ins_id,");
			sql.append("       ofi.action_id,");
			sql.append("       ofi.action_name,");
			sql.append("       ofi.action_handeridea,");
			sql.append("       ofi.hander_time,");
			sql.append("       ofi.is_valid,");
			sql.append("       ofi.remark1,");
			sql.append("       ofi.remark2,");
			sql.append("       ofi.org_id,");
			sql.append("       ofi.org_name,");
			sql.append("       ofi.user_id,");
			sql.append("       ofi.user_name,");
			sql.append("       ofi.table_name,");
			sql.append("       ofi.column_name,");
			sql.append("       ofi.action_ins_id");
			sql.append("  from oa_flow_insviewlist ofi");
			sql.append(" where 1 =1");
			if (!StringUtil.nullOrBlank(model.getIns_id())){
				sql.append("   and ofi.ins_id = '"+model.getIns_id()+"'");
			}
			
			if (!StringUtil.nullOrBlank(model.getTable_name())){
				sql.append("   and ofi.table_name = '"+model.getTable_name()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getColumn_name())){
				sql.append("   and ofi.column_name = '"+model.getColumn_name()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getUser_name())){
				sql.append("   and ofi.user_name = '"+model.getUser_name()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getAction_name())){
				sql.append("   and ofi.action_name = '"+model.getAction_name()+"'");
			}
			sql.append(" order by ofi.hander_time desc");
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}

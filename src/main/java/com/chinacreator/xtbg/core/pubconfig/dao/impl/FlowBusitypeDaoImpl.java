package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypebean;
import com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FlowBusitypeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-16
 */
public class FlowBusitypeDaoImpl extends XtDbBaseDao implements FlowBusitypeDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFlowBusitypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao#selFormBusitypeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getFlowBusitypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		FormBusitypebean formBusitypebean= new FormBusitypebean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				formBusitypebean = (FormBusitypebean) JSONObject.parseObject(parmjson, FormBusitypebean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select * ");
			sql.append("  from oa_flow_busitype b");
			sql.append("  where 1=1");
			
			if(formBusitypebean!=null){
				if (!StringUtil.nullOrBlank(formBusitypebean.getBusitype_name())) {
					sql.append(" and b.busitype_name like '%'||?||'%'");
					condition.add(formBusitypebean.getBusitype_name());
				}
				if (!StringUtil.nullOrBlank(formBusitypebean.getBusitype_type_code())) {
					sql.append(" and b.busitype_type_code = ? ");
					condition.add(formBusitypebean.getBusitype_type_code());
				}
				sql.append(" order by b.busitype_order, " + sortName + " " + sortOrder);
				}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findFormBusitypeInfoById
	  * @param busitype_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao#findFormBusitypeInfoById(java.lang.String) 
	  */
	@Override
	public FlowBusitypebean findFormBusitypeInfoById(String busitype_code)throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		t.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		t.type_desc,");
		sql.append(" 		t.busitype_type_code,");
		sql.append(" 		t.is_valid, t.busitype_order ");
		sql.append(" from oa_flow_busitype t ");
		sql.append(" where t.busitype_code = ?  order by t.busitype_order ");
		FlowBusitypebean fbb = new FlowBusitypebean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, busitype_code);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fbb.setBusitype_code(StringUtil.deNull(pdb.getString(0, "busitype_code")));
			fbb.setBusitype_name(StringUtil.deNull(pdb.getString(0, "busitype_name")));
			fbb.setType_desc(StringUtil.deNull(pdb.getString(0, "type_desc")));
			fbb.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
			fbb.setBusitype_type_code(StringUtil.deNull(pdb.getString(0, "busitype_type_code")));
			fbb.setBusitype_order(StringUtil.deNull(pdb.getString(0, "busitype_order")));
		}
		return fbb;
	}


	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findFormBusitypeTypeInfoById
	  * @param busitype_type_code
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao#findFormBusitypeTypeInfoById(java.lang.String) 
	  */
	@Override
	public FlowBusitypeTypeBean findFormBusitypeTypeInfoById(String busitype_type_code) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		busitype_type_code,");
		sql.append(" 		busitype_type_name,");
		sql.append(" 		is_valid,");
		sql.append(" 		is_flow, ");
		sql.append(" 		order_no, ");
		sql.append(" 		count_type, ");
		sql.append(" 		type_desc ");
		sql.append(" from oa_flow_busitype_type t ");
		sql.append(" where busitype_type_code = ?  ");
		FlowBusitypeTypeBean fbb = new FlowBusitypeTypeBean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, busitype_type_code);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fbb.setBusitype_type_code(busitype_type_code);
			fbb.setBusitype_type_name(StringUtil.deNull(pdb.getString(0, "busitype_type_name")));
			fbb.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
			fbb.setIs_flow(StringUtil.deNull(pdb.getString(0, "is_flow")));
			fbb.setOrder_no(StringUtil.deNull(pdb.getString(0, "order_no")));
			fbb.setCount_type(StringUtil.deNull(pdb.getString(0, "count_type")));
			fbb.setType_desc(StringUtil.deNull(pdb.getString(0, "type_desc")));
		}
		return fbb;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getBusitype_type
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao#getBusitype_type() 
	  */
	@Override
	public List<FlowBusitypeTypeBean> getBusitype_type() throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		busitype_type_code,");
		sql.append(" 		busitype_type_name,");
		sql.append(" 		is_valid,");
		sql.append(" 		is_flow, ");
		sql.append(" 		order_no, ");
		sql.append(" 		type_desc ");
		sql.append(" from oa_flow_busitype_type t ");
		sql.append(" where 1=1 ");
		List<FlowBusitypeTypeBean> fbbList = new ArrayList<FlowBusitypeTypeBean>();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for(int i=0; i<pdb.size(); i++){ 
			FlowBusitypeTypeBean fbb = new FlowBusitypeTypeBean();
			fbb.setBusitype_type_code(StringUtil.deNull(pdb.getString(i, "busitype_type_code")));
			fbb.setBusitype_type_name(StringUtil.deNull(pdb.getString(i, "busitype_type_name")));
			fbb.setIs_valid(StringUtil.deNull(pdb.getString(i, "is_valid")));
			fbb.setIs_flow(StringUtil.deNull(pdb.getString(i, "is_flow")));
			fbb.setOrder_no(StringUtil.deNull(pdb.getString(i, "order_no")));
			fbb.setType_desc(StringUtil.deNull(pdb.getString(i, "type_desc")));
			fbbList.add(fbb);
		}
		return fbbList;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isBusiType_code
	  * @param busitype_code
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao#isBusiType_code(java.lang.String)
	 */
	public boolean isBusiType_code(String busitype_code) throws Exception {
		String sql="select count(*) count from OA_FLOW_BUSITYPE  where busitype_code=? ";
		String count=queryToSingleMap(sql, busitype_code).get("count");
		if(!"0".equals(count)){
			return true;
		}
		return false;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isBusiType_name
	  * @param busitype_name
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao#isBusiType_name(java.lang.String)
	 */
	public boolean isBusiType_name(String busitype_name,String busitype_code) throws Exception {
		String sql="select count(*) count from OA_FLOW_BUSITYPE  where busitype_name=? and busitype_code <> ? ";
		String count=queryToSingleMap(sql, busitype_name,busitype_code).get("count");
		if(!"0".equals(count)){
			return true;
		}
		return false;
	}

}

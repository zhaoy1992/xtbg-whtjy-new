
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     FlowBusitypeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-19   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.pubconfig.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypebean;
import com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc;

/**
 *<p>Title:FlowBusitypeServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-19
 */
public class FlowBusitypeServiceImpl implements FlowBusitypeServiceIfc {
	private Log LOG=LogFactory.getLog(FlowBusitypeServiceImpl.class);
	/** 
	 * <b>Summary: </b>
	 *     复写方法 findFlowBusitypeInfoById
	 * @param busitype_code
	 * @return
	 * @throws SQLException 
	 * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#findFlowBusitypeInfoById(java.lang.String) 
	 */
	@Override
	public FlowBusitypebean findFlowBusitypeInfoById(String busitype_code){
		FlowBusitypebean fbb = new FlowBusitypebean();
		try {
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			fbb = flowBusitypeDao.findFormBusitypeInfoById(busitype_code);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return fbb;
	}

	/** 
	 * <b>Summary: </b>
	 *     复写方法 saveFlowBusitypeInfo
	 * @param paramjosn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#saveFlowBusitypeInfo(java.lang.String) 
	 */
	@Override
	public boolean saveFlowBusitypeInfo(String paramjosn){
		FlowBusitypebean flowBusitypebean = new FlowBusitypebean();
		boolean resultStr =true;
		Connection conn = null;
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowBusitypebean = (FlowBusitypebean) JSONObject.parseObject(paramjosn,FlowBusitypebean.class);
		}
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
		
			((BaseDao)flowBusitypeDao).insert(flowBusitypebean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);			
		}
		return resultStr;
	}

	/** 
	 * <b>Summary: </b>
	 *     复写方法 deleteFlowBusitype
	 * @param busitype_codes
	 * @return 
	 * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#deleteFlowBusitype(java.lang.String) 
	 */
	@Override
	public Boolean deleteFlowBusitype(String busitype_codes) {
		Connection conn=null;
		Boolean flag=true;
		String id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			if(!StringUtil.isBlank(busitype_codes)){
				id_list=busitype_codes.split(",");
				for (int i = 0; i < id_list.length; i++) {
					FlowBusitypebean flowBusitypebean=new FlowBusitypebean();
					flowBusitypebean.setBusitype_code(id_list[i]);
					//删除业务类型表
					((BaseDao)flowBusitypeDao).deleteListById(flowBusitypebean, conn, id_list[i]);
				}
			}
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateFlowBusitypeInfo
	  * @param paramjosn
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#updateFlowBusitypeInfo(java.lang.String) 
	  */
	@Override
	public boolean updateFlowBusitypeInfo(String paramjosn) {
		FlowBusitypebean flowBusitypebean = new FlowBusitypebean();
		boolean resultStr =true;
		Connection conn = null;
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			flowBusitypebean = (FlowBusitypebean) JSONObject.parseObject(paramjosn,FlowBusitypebean.class);
		}
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
		
			((BaseDao)flowBusitypeDao).update(flowBusitypebean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);			
		}
		return resultStr;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 addBusitypeType
	  * @param flowBusitypeTypeBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#addBusitypeType(com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean) 
	  */
	@Override
	public boolean addBusitypeType(FlowBusitypeTypeBean flowBusitypeTypeBean) {
		boolean resultStr = true;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			((BaseDao)flowBusitypeDao).insert(flowBusitypeTypeBean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);			
		}
		return resultStr;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateBusitypeType
	  * @param flowBusitypeTypeBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#updateBusitypeType(com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean) 
	  */
	@Override
	public boolean updateBusitypeType(FlowBusitypeTypeBean flowBusitypeTypeBean) {
		boolean resultStr = true;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
		
			((BaseDao)flowBusitypeDao).update(flowBusitypeTypeBean, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);			
		}
		return resultStr;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delBusitypeType
	  * @param busitype_type_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#delBusitypeType(java.lang.String) 
	  */
	@Override
	public boolean delBusitypeType(String busitype_type_code) {
		Connection conn=null;
		boolean flag= true;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			
			FlowBusitypeTypeBean flowBusitypeTypeBean = new FlowBusitypeTypeBean();
			flowBusitypeTypeBean.setBusitype_type_code(busitype_type_code);
			//删除业务类型分类表
			((BaseDao)flowBusitypeDao).deleteListById(flowBusitypeTypeBean, conn, busitype_type_code);
		
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findFlowBusitypeTypeInfoById
	  * @param busitype_type_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#findFlowBusitypeTypeInfoById(java.lang.String) 
	  */
	@Override
	public FlowBusitypeTypeBean findFlowBusitypeTypeInfoById(String busitype_type_code) {
		FlowBusitypeTypeBean fbb = new FlowBusitypeTypeBean();
		try {
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			fbb = flowBusitypeDao.findFormBusitypeTypeInfoById(busitype_type_code);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return fbb;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getBusitype_type
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#getBusitype_type() 
	  */
	@Override
	public List<FlowBusitypeTypeBean> getBusitype_type() {
		 List<FlowBusitypeTypeBean> fbb = new ArrayList<FlowBusitypeTypeBean>();
		try {
			FlowBusitypeDao flowBusitypeDao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			fbb = flowBusitypeDao.getBusitype_type();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return fbb;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getBusitypeByTypeId
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#getBusitypeByTypeId() 
	  */
	@Override
	public List<FlowBusitypebean> getBusitypeByTypeId(String busitype_type_code) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isBusitypecodeandname
	  * @param busitype_code
	  * @param busitype_name
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc#isBusitypecodeandname(java.lang.String, java.lang.String)
	 */
	public String isBusitypecodeandname(String busitype_code,
			String busitype_name,String type) {
		try {
			FlowBusitypeDao dao=(FlowBusitypeDao)LoadSpringContext.getApplicationContext().getBean("flowBusitypeDaoImpl");
			if("save".equals(type)){
				if(dao.isBusiType_code(busitype_code)){
					return "code";
				}
				if(dao.isBusiType_name(busitype_name," ")){
					return "name";
				}
			}else{
				if(dao.isBusiType_name(busitype_name,busitype_code)){
					return "name";
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return "";
	}

}

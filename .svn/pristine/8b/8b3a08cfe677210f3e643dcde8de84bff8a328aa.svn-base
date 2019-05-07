package com.chinacreator.xtbg.core.process.dbmanager.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;


import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.dssave.entity.MdColumnBean;
import com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao;
import com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:MdServiceImpl.java</p>
 *<p>Description:数据元服务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-6
 */
public class MdServiceImpl implements MdServiceIfc {
	
	
	public static final Logger logger = Logger.getLogger(MdServiceImpl.class
			.getName());
	
	 /** 
	  * dao:注入bean 
	  */
	private MdDao dao = (MdDao) LoadSpringContext.getApplicationContext().getBean("mdDaoImpl");
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 createMdTables
	  * @param mdtablejson
	  * @param mdcolumnlistjson
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#createMdTables(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public boolean createMdTables(String mdtablejson,String mdcolumnlistjson) {
		Connection conn = null ;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String json1 = Escape.unescape(DataControlUtil.replaceStr(mdtablejson));
			MdTableBean mdTableBean = (MdTableBean) JSONObject.parseObject(json1, MdTableBean.class);
			String json2 = Escape.unescape(DataControlUtil.replaceStr(mdcolumnlistjson));
			List<MdColumnBean> list = (List<MdColumnBean>) JSONObject
					.parseArray(json2, MdColumnBean.class);
			
			String table_id = dao.insertMdTable(conn, mdTableBean);
			if (StringUtil.nullOrBlank(table_id)){
				return false;
			}else{
				for(MdColumnBean mdColumnBean : list){
					mdColumnBean.setTable_id(table_id);
					dao.insertMdColumn(conn, mdColumnBean);
				}
				dao.createMdTable(conn, list, mdTableBean);
			}
			conn.commit();
		} catch (Exception e) {
			logger.info("新建数据元字段表或新建业务表时出现异常"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveMdColumnsForm
	  * @param jsonparam
	  * @param updatetype
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#saveMdColumnsForm(java.lang.String, java.lang.String) 
	  */
	public String saveMdColumnsForm(String jsonparam,String updatetype){
		Connection conn = null ;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String json = Escape.unescape(DataControlUtil.replaceStr(jsonparam));
			MdColumnBean model = (MdColumnBean) JSONObject.parseObject(json, MdColumnBean.class);
			if("add".equalsIgnoreCase(updatetype)){
				dao.addMdColumn(conn, model);
				dao.insertMdColumn(conn, model);
			}else if ("edit".equalsIgnoreCase(updatetype)){
				dao.modifyMdColumn(conn, model);
				dao.updateMdColumn(conn, model);
			}else{
				return "false";
			}
			conn.commit();
		} catch (Exception e) {
			logger.info("更新数据元字段表记录或更新业务表字段时异常"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return e.getMessage();
		}finally{
			DbManager.closeConnection(conn);
		}
		return "true";
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMdColumnsById
	  * @param column_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#findMdColumnsById(java.lang.String) 
	  */
	public MdColumnBean findMdColumnsById(String column_id){
		MdColumnBean model = new MdColumnBean();
		try {
			model = dao.findMdColumnById(column_id);
		} catch (SQLException e) {
			logger.info("根据主键id查询数据元字段表异常"+e.getMessage(), e);
		}
		return model;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMdTable
	  * @param table_id
	  * @param table_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#deleteMdTable(java.lang.String, java.lang.String) 
	  */
	public boolean deleteMdTables(String table_id,String table_code){
		Connection conn = null ;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			dao.deleteMdColumnByTableId(conn, table_id);
			dao.deleteMdTable(conn, table_id);
			dao.dropMdTable(conn, table_code);
			conn.commit();
		} catch (Exception e) {
			logger.info("删除数据元字段表记录和字段时异常"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	};

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMdColumns
	  * @param mdColunmListData
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#deleteMdColumns(java.lang.String) 
	  */
	public boolean deleteMdColumns(String mdColunmListData){
		Connection conn = null ;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String json = Escape.unescape(DataControlUtil.replaceStr(mdColunmListData));
			//由于drop 不能回滚，故删除列时每次只能处理一条，并且要先执行delete脚本（可以回滚）
			MdColumnBean model = (MdColumnBean) JSONObject.parseObject(json, MdColumnBean.class);
			dao.deleteMdColumn(conn,model.getColumn_id());
			dao.dropTableColumn(conn, model);
			conn.commit();
		} catch (Exception e) {
			logger.info("删除数据元字段表记录和字段时异常"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMdTableList
	  * @param mdTableBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#findMdTableList(com.chinacreator.xtbg.core.dssave.entity.MdTableBean) 
	  */
	public List<MdTableBean> findMdTableList(MdTableBean mdTableBean) throws Exception{
		List<MdTableBean> list = null;
		try {
			list= dao.findMdTableList(mdTableBean);
		} catch (Exception e) {
			logger.info("查询数据元表异常"+e.getMessage(), e);
		}
		return list;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findPkNameList
	  * @param mdTableBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc#findPkNameList(com.chinacreator.xtbg.core.dssave.entity.MdTableBean)
	 */
	public List<Map<String, String>> findPkNameList(MdTableBean mdTableBean) throws Exception{
		List<Map<String, String>> list = null;
		try {
			list= dao.findPkNameList(mdTableBean);
		} catch (Exception e) {
			logger.info("查询数据元表异常"+e.getMessage(), e);
		}
		return list;
	}


	
}

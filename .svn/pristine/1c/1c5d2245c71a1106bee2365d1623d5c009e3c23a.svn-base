package com.chinacreator.xtbg.core.pubconfig.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.ColStautsContorlDao;
import com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao;
import com.chinacreator.xtbg.core.pubconfig.dao.MdColumnsDao;
import com.chinacreator.xtbg.core.pubconfig.dao.MdTableDao;
import com.chinacreator.xtbg.core.pubconfig.entity.ColStautsContorlBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean;
import com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc;
/**
 * 
 *<p>Title:FormActionServiceImpl.java</p>
 *<p>Description:表单环节定义服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public class FormActionServiceImpl implements FormActionServiceIfc {

	private static Log LOG=LogFactory.getLog(FormActionServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormActionBean
	  * @param action_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc#getFormActionBean(java.lang.String)
	 */
	public Map<String, String> getFormActionBean(String action_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			viewMap = formActionDao.getFormAciton(action_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFormAction
	  * @param action_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc#deleteFormAction(java.lang.String)
	 */
	public Boolean deleteFormAction(String action_id) {
		Connection conn=null;
		Boolean flag=false;
		String id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			if(!StringUtil.isBlank(action_id)){
				id_list=action_id.split(",");
				for (int i = 0; i < id_list.length; i++) {
					//删除表单环节
					FormActionBean formActionBean=new FormActionBean();
					formActionBean.setAction_id(id_list[i]);
					//删除表单环节下的表单元素状态
					ColStautsContorlBean colStautsContorlBean=new ColStautsContorlBean();
					colStautsContorlBean.setDeleteKey("action_id");
					colStautsContorlBean.setAction_id(id_list[i]);
					((BaseDao)formActionDao).deleteListById(colStautsContorlBean, conn, id_list[i]);
					
					((BaseDao)formActionDao).deleteListById(formActionBean, conn, id_list[i]);
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
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addFormAction
	  * @param formActionBean
	  * @param table_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc#addFormAction(com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean, java.lang.String)
	 */
	public boolean addFormAction(FormActionBean formActionBean, String table_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			formActionBean.setAction_id(StringUtil.getUUID());
			if(StringUtil.isBlank((String)formActionBean.getCreate_time())) {
				formActionBean.setCreate_time(null);
			} else {
				formActionBean.setCreate_time(StringUtil.convertStringToTimestamp(formActionBean.getCreate_time().toString()));
			}
			((BaseDao)formActionDao).insert(formActionBean, conn);
			
			//添加相应表单元素状态表
			ColStautsContorlDao colStautsContorlDao=(ColStautsContorlDao)LoadSpringContext.getApplicationContext().getBean("colStautsContorlDaoImpl");
			MdTableDao mdTableDao=(MdTableDao)LoadSpringContext.getApplicationContext().getBean("mdTableDaoImpl");
			MdColumnsDao mdColumnsDao=(MdColumnsDao)LoadSpringContext.getApplicationContext().getBean("mdColumnsDaoImpl");
			List<Map<String, String>> tablelist=new ArrayList<Map<String,String>>();
			
			//根据table_id得到表以及子表
			tablelist=mdTableDao.getMdTable(table_id);
			for (int i = 0; i < tablelist.size(); i++) {
				Map<String, String> tablemap=new HashMap<String, String>();
				tablemap=tablelist.get(i);
				//根据table_id得到字段信息
				List<Map<String, String>> collist=new ArrayList<Map<String,String>>();
				collist=mdColumnsDao.getMdColumns(tablemap.get("table_id"));
				for (int j = 0; j < collist.size(); j++) {
					Map<String, String> colmap=new HashMap<String, String>();
					colmap=collist.get(j);
					//设置表单元素状态
					ColStautsContorlBean  cscb=new ColStautsContorlBean();
					cscb.setId(StringUtil.getUUID());
					cscb.setAction_id(formActionBean.getAction_id());
					cscb.setTable_id(tablemap.get("table_id"));
					cscb.setTable_code(tablemap.get("table_code"));
					cscb.setColumn_id(colmap.get("column_id"));
					cscb.setColumn_code(colmap.get("column_code"));
					cscb.setReadonly("0");
					cscb.setHidden("0");
					cscb.setDisable("0");
					cscb.setRequired("0");
					
					//添加表单元素状态信息
					((BaseDao)colStautsContorlDao).insert(cscb, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);			
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFormAction
	  * @param formActionBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc#updateFormAction(com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean)
	 */
	public boolean updateFormAction(FormActionBean formActionBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			if(StringUtil.isBlank((String)formActionBean.getCreate_time())) {
				formActionBean.setCreate_time(null);
			} else {
				formActionBean.setCreate_time(StringUtil.convertStringToTimestamp(formActionBean.getCreate_time().toString()));
			}
			((BaseDao)formActionDao).update(formActionBean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);			
		}
		return flag;
	}

}

package com.chinacreator.xtbg.core.pubconfig.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.FormActionDao;
import com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao;
import com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean;
import com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc;
import com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc;
/**
 * 
 *<p>Title:FormBusitypeServiceImpl.java</p>
 *<p>Description:表单业务类型服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-29
 */
public class FormBusitypeServiceImpl implements FormBusitypeServiceIfc {

	private Log LOG=LogFactory.getLog(FormBusitypeServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFormBusitypeInfoById
	  * @param busitype_code
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc#findFormBusitypeInfoById(java.lang.String)
	 */
	public FormBusitypebean findFormBusitypeInfoById(String busitype_code) {
		FormBusitypebean fbb=new FormBusitypebean();
		try {
			FormBusitypeDao formBusitypeDao=(FormBusitypeDao)LoadSpringContext.getApplicationContext().getBean("formBusitypeDaoImpl");
			fbb = formBusitypeDao.findFormBusitypeInfoById(busitype_code);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return fbb;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveFormBusitypeInfo
	  * @param paramjosn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc#saveFormBusitypeInfo(java.lang.String)
	 */
	public boolean saveFormBusitypeInfo(String paramjosn){
		FormBusitypebean formBusitypebean = new FormBusitypebean();
		boolean resultStr =false;
		Connection conn = null;
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			formBusitypebean = (FormBusitypebean) JSONObject.parseObject(paramjosn,FormBusitypebean.class);
		}
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormBusitypeDao formBusitypeDao=(FormBusitypeDao)LoadSpringContext.getApplicationContext().getBean("formBusitypeDaoImpl");
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			if (StringUtil.nullOrBlank(formBusitypebean.getBusitype_code())) {
				formBusitypebean.setBusitype_code(StringUtil.getUUID());
				((BaseDao)formBusitypeDao).insert(formBusitypebean, conn);
				conn.commit();
				resultStr=true;
			} else {
				//根据id得原有的业务类型信息
				FormBusitypebean fbb=formBusitypeDao.findFormBusitypeInfoById(formBusitypebean.getBusitype_code());
				if(!fbb.getTable_id().equals(formBusitypebean.getTable_id())){
					//表换了就删除相应环节
					List<Map<String, String>> list = new ArrayList<Map<String,String>>();
					list=formActionDao.getFormAcitons(formBusitypebean.getBusitype_code());
					String action_ids="";
					for (int j = 0; j < list.size(); j++) {
						Map<String, String> map=new HashMap<String, String>();
						map=list.get(j);
						action_ids+=map.get("action_id")+",";
					}
					if(!StringUtil.isBlank(action_ids)){
						action_ids=action_ids.substring(0, action_ids.length()-1);
						FormActionServiceIfc fasi=new FormActionServiceImpl();
						fasi.deleteFormAction(action_ids);
					}
				}else{
					if(!fbb.getBusitype_name().equals(formBusitypebean.getBusitype_name())){
						List<Map<String, String>> list = new ArrayList<Map<String,String>>();
						list=formActionDao.getFormAcitons(formBusitypebean.getBusitype_code());
						for (int j = 0; j < list.size(); j++) {
							Map<String, String> map=new HashMap<String, String>();
							FormActionBean fab=new FormActionBean();
							map=list.get(j);
							fab.setAction_id(map.get("action_id"));
							fab.setBusitype_name(formBusitypebean.getBusitype_name());
							((BaseDao)formActionDao).update(fab, conn);
						}
					}
				}
				
				((BaseDao)formBusitypeDao).update(formBusitypebean, conn);
				conn.commit();
				resultStr=true;
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);			
		}
		return resultStr;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFormBusitype
	  * @param busitype_codes
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc#deleteFormBusitype(java.lang.String)
	 */
	public Boolean deleteFormBusitype(String busitype_codes) {
		Connection conn=null;
		Boolean flag=false;
		String id_list[]=null;
		String action_ids="";
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			FormBusitypeDao formBusitypeDao=(FormBusitypeDao)LoadSpringContext.getApplicationContext().getBean("formBusitypeDaoImpl");
			FormActionDao formActionDao=(FormActionDao)LoadSpringContext.getApplicationContext().getBean("formActionDaoImpl");
			List<Map<String, String>> list = new ArrayList<Map<String,String>>();
			if(!StringUtil.isBlank(busitype_codes)){
				id_list=busitype_codes.split(",");
				for (int i = 0; i < id_list.length; i++) {
					FormBusitypebean formBusitypebean=new FormBusitypebean();
					formBusitypebean.setBusitype_code(id_list[i]);
					//删除相应表单环节信息
					list=formActionDao.getFormAcitons(id_list[i]);
					for (int j = 0; j < list.size(); j++) {
						Map<String, String> map=new HashMap<String, String>();
						map=list.get(j);
						action_ids+=map.get("action_id")+",";
					}
					if(!StringUtil.isBlank(action_ids)){
						action_ids=action_ids.substring(0, action_ids.length()-1);
						FormActionServiceIfc fasi=new FormActionServiceImpl();
						fasi.deleteFormAction(action_ids);
					}
					//删除业务类型表
					((BaseDao)formBusitypeDao).deleteListById(formBusitypebean, conn, id_list[i]);
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
}

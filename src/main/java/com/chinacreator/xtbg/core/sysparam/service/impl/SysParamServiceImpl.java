package com.chinacreator.xtbg.core.sysparam.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.sysparam.dao.SysParamDao;
import com.chinacreator.xtbg.core.sysparam.entity.SysParamBean;
import com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean;
import com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc;
/**
 * 
 *<p>Title:SysParamServiceImpl.java</p>
 *<p>Description:系统参数设置服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-18
 */
public class SysParamServiceImpl implements SysParamServiceIfc {
	
	private static final Log LOG=LogFactory.getLog(SysParamServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteSysParam
	  * @param p_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#deleteSysParam(java.lang.String)
	 */
	public Boolean deleteSysParam(String p_id) {
		Connection conn=null;
		Boolean flag=false;
		String p_id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			if(!StringUtil.isBlank(p_id)){
				p_id_list=p_id.split(",");
				for (int i = 0; i < p_id_list.length; i++) {
					SysParamBean sysParamBean=new SysParamBean();
					sysParamBean.setP_id(p_id_list[i]);
					//删除相应的值表
					Map<String, String> viewMap = null;
					SysParamvalueBean sysParamvalueBean=new SysParamvalueBean();
					viewMap=getSysParamBean(p_id_list[i]);
					String p_code=StringUtil.deNull(viewMap.get("p_code"));
					if(!StringUtil.isBlank(p_code)){
						sysParamvalueBean.setDeleteKey("p_code");
						sysParamvalueBean.setP_code(p_code);
						((BaseDao)sysParamDao).deleteListById(sysParamBean, conn, p_id_list[i]);
					}
					((BaseDao)sysParamDao).deleteListById(sysParamBean, conn, p_id_list[i]);
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
	  *     复写方法 addSysParam
	  * @param sysParamBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#addSysParam(com.chinacreator.xtbg.core.sysparam.entity.SysParamBean)
	 */
	public boolean addSysParam(SysParamBean sysParamBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			sysParamBean.setP_id(StringUtil.getUUID());
			if(StringUtil.isBlank((String)sysParamBean.getP_creator_time())) {
				sysParamBean.setP_creator_time(null);
			} else {
				sysParamBean.setP_creator_time(StringUtil.convertStringToTimestamp(sysParamBean.getP_creator_time().toString()));
			}
			((BaseDao)sysParamDao).insert(sysParamBean, conn);
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
	  *     复写方法 updateSysParam
	  * @param sysParamBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#updateSysParam(com.chinacreator.xtbg.core.sysparam.entity.SysParamBean)
	 */
	public boolean updateSysParam(SysParamBean sysParamBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			Map<String, String>  mapvalue=sysParamDao.getSysParamBean(sysParamBean.getP_id(), conn);
			if(StringUtil.isBlank((String)sysParamBean.getP_creator_time())) {
				sysParamBean.setP_creator_time(null);
			} else {
				sysParamBean.setP_creator_time(StringUtil.convertStringToTimestamp(sysParamBean.getP_creator_time().toString()));
			}
			((BaseDao)sysParamDao).update(sysParamBean, conn);
			//更新参数表下的值表的参数编码
			
			String p_code=sysParamBean.getP_code();
			if(!StringUtil.isBlank(p_code)){
				List<Map<String, String>> list=sysParamDao.getSysParamvalueByPcode(mapvalue.get("p_code"));
				if(list.size()>0){
					for (int i = 0; i < list.size(); i++) {
						Map<String, String> map=list.get(i);
						SysParamvalueBean sysParamvalueBean=new SysParamvalueBean();
						sysParamvalueBean.setP_value_id(map.get("p_value_id"));
						sysParamvalueBean.setP_code(p_code);
						((BaseDao)sysParamDao).update(sysParamvalueBean, conn);
					}
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
	  *     复写方法 getSysParamBean
	  * @param p_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#getSysParamBean(java.lang.String)
	 */
	public Map<String, String> getSysParamBean(String p_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			viewMap = sysParamDao.getSysParamBean(p_id, conn);
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
	  *     复写方法 getSysParamByPcode
	  * @param p_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#getSysParamByPcode(java.lang.String)
	 */
	public Map<String, String> getSysParamByPcode(String p_code) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			viewMap = sysParamDao.getSysParamByPcode(p_code, conn);
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
	  *     复写方法 deleteSysParamvalue
	  * @param p_value_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#deleteSysParamvalue(java.lang.String)
	 */
	public Boolean deleteSysParamvalue(String p_value_id) {
		Connection conn=null;
		Boolean flag=false;
		String p_id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			if(!StringUtil.isBlank(p_value_id)){
				p_id_list=p_value_id.split(",");
				for (int i = 0; i < p_id_list.length; i++) {
					SysParamvalueBean sysParamvalueBean=new SysParamvalueBean();
					sysParamvalueBean.setP_value_id(p_id_list[i]);
					((BaseDao)sysParamDao).deleteListById(sysParamvalueBean, conn, p_id_list[i]);
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
	  *     复写方法 addSysParamvalue
	  * @param sysParamvalueBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#addSysParamvalue(com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean)
	 */
	public boolean addSysParamvalue(SysParamvalueBean sysParamvalueBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			sysParamvalueBean.setP_value_id(StringUtil.getUUID());
			if(StringUtil.isBlank((String)sysParamvalueBean.getP_creator_time())) {
				sysParamvalueBean.setP_creator_time(null);
			} else {
				sysParamvalueBean.setP_creator_time(StringUtil.convertStringToTimestamp(sysParamvalueBean.getP_creator_time().toString()));
			}
			((BaseDao)sysParamDao).insert(sysParamvalueBean, conn);
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
	  *     复写方法 updateSysParamvalue
	  * @param sysParamvalueBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#updateSysParamvalue(com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean)
	 */
	public boolean updateSysParamvalue(SysParamvalueBean sysParamvalueBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			if(StringUtil.isBlank((String)sysParamvalueBean.getP_creator_time())) {
				sysParamvalueBean.setP_creator_time(null);
			} else {
				sysParamvalueBean.setP_creator_time(StringUtil.convertStringToTimestamp(sysParamvalueBean.getP_creator_time().toString()));
			}
			((BaseDao)sysParamDao).update(sysParamvalueBean, conn);
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
	  *     复写方法 getSysParamvalueBean
	  * @param p_value_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#getSysParamvalueBean(java.lang.String)
	 */
	public Map<String, String> getSysParamvalueBean(String p_value_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			viewMap = sysParamDao.getSysParamvalueBean(p_value_id, conn);
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
	  *     复写方法 getSysParamvalueByPcode
	  * @param p_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#getSysParamvalueByPcode(java.lang.String)
	 */
	public List<Map<String, String>> getSysParamvalueByPcode(String p_code) {
		Connection conn = null;
		List<Map<String, String>> list = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			list = sysParamDao.getSysParamvalueByPcode(p_code);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return list;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamvalueByPvcode
	  * @param p_value_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc#getSysParamvalueByPvcode(java.lang.String)
	 */
	public Map<String, String> getSysParamvalueByPvcode(
			String p_value_code,String p_code) {
		Connection conn = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			SysParamDao sysParamDao=(SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			map = sysParamDao.getSysParamvalueByPvcode(p_value_code,p_code);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return map;
	}
}

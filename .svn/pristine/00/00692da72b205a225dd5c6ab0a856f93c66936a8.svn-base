package com.chinacreator.xtbg.core.dict.service.impl;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dict.dao.DictDao;
import com.chinacreator.xtbg.core.dict.entity.DictDataBean;
import com.chinacreator.xtbg.core.dict.entity.DictTypeBean;
import com.chinacreator.xtbg.core.dict.service.DictServiceIfc;
/**
 * 
 *<p>Title:DictServiceImpl.java</p>
 *<p>Description:数据字典服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-22
 */
public class DictServiceImpl implements DictServiceIfc {

	private static final Log LOG=LogFactory.getLog(DictServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDictDataBean
	  * @param dictdata_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#getDictDataBean(java.lang.String)
	 */
	public Map<String, String> getDictDataBean(String dictdata_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			viewMap = dictDao.getDictDataBean(dictdata_id, conn);
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
	  *     复写方法 deleteDictData
	  * @param dictdata_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#deleteDictData(java.lang.String)
	 */
	public String deleteDictData(String dictdata_id) {
		Connection conn=null;
		String flag="";
		String id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			if(!StringUtil.isBlank(dictdata_id)){
				id_list=dictdata_id.split(",");
				for (int i = 0; i < id_list.length; i++) {
					DictDataBean dictDataBean=new DictDataBean();
					dictDataBean.setDictdata_id(id_list[i]);
					if(dictDao.isSonData(id_list[i], conn)){
						flag="parent";
					}else{
						((BaseDao)dictDao).deleteListById(dictDataBean, conn, id_list[i]);
					}
				}
			}
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
	  *     复写方法 addDictData
	  * @param dictDataBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#addDictData(com.chinacreator.xtbg.core.dict.entity.DictDataBean)
	 */
	public boolean addDictData(DictDataBean dictDataBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			dictDataBean.setDictdata_id(StringUtil.getUUID());
			if(StringUtil.isBlank(dictDataBean.getDictdata_parent_id())){
				dictDataBean.setDictdata_parent_id("0");
			}
			((BaseDao)dictDao).insert(dictDataBean, conn);
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
	  *     复写方法 updateDictData
	  * @param dictDataBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#updateDictData(com.chinacreator.xtbg.core.dict.entity.DictDataBean)
	 */
	public boolean updateDictData(DictDataBean dictDataBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			((BaseDao)dictDao).update(dictDataBean, conn);
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
	  *     复写方法 getDictTypeBean
	  * @param dict_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#getDictTypeBean(java.lang.String)
	 */
	public Map<String, String> getDictTypeBean(String dict_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			viewMap = dictDao.getDictTypeBean(dict_id, conn);
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
	  *     复写方法 deleteDictType
	  * @param dict_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#deleteDictType(java.lang.String)
	 */
	public String deleteDictType(String dict_id) {
		Connection conn=null;
		String flag="";
		String id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			if(!StringUtil.isBlank(dict_id)){
				id_list=dict_id.split(",");
				for (int i = 0; i < id_list.length; i++) {
					DictTypeBean dictTypeBean=new DictTypeBean();
					dictTypeBean.setDict_id(id_list[i]);
					if(dictDao.isSonDictType(id_list[i], conn)){
						return "parent";
					}
					if(dictDao.isDictData(id_list[i], conn)){
						return "data";
					}
					((BaseDao)dictDao).deleteListById(dictTypeBean, conn, id_list[i]);
				}
			}
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
	  *     复写方法 addDictType
	  * @param dictTypeBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#addDictType(com.chinacreator.xtbg.core.dict.entity.DictTypeBean)
	 */
	public boolean addDictType(DictTypeBean dictTypeBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			dictTypeBean.setDict_id(StringUtil.getUUID());
			if(StringUtil.isBlank(dictTypeBean.getDict_parent_id())){
				dictTypeBean.setDict_parent_id("0");
			}
			((BaseDao)dictDao).insert(dictTypeBean, conn);
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
	  *     复写方法 updateDictType
	  * @param dictTypeBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#updateDictType(com.chinacreator.xtbg.core.dict.entity.DictTypeBean)
	 */
	public boolean updateDictType(DictTypeBean dictTypeBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			((BaseDao)dictDao).update(dictTypeBean, conn);
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
	  *     复写方法 getDictDataBydvalue
	  * @param dictdata_value
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#getDictDataBydvalue(java.lang.String)
	 */
	public Map<String, String> getDictDataBydvalue(String dictdata_value,String dict_id) {
		Connection conn = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			map = dictDao.getDictDataBydvalue(dictdata_value,conn,dict_id);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDictTypeBydcode
	  * @param dict_code
	  * @return 
	  * @see com.chinacreator.xtbg.core.dict.service.DictServiceIfc#getDictTypeBydcode(java.lang.String)
	 */
	public Map<String, String> getDictTypeBydcode(String dict_code) {
		Connection conn = null;
		Map<String, String> map = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DictDao dictDao=(DictDao)LoadSpringContext.getApplicationContext().getBean("dictDaoImpl");
			map = dictDao.getDictTypeBydcode(dict_code,conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return map;
	}

}

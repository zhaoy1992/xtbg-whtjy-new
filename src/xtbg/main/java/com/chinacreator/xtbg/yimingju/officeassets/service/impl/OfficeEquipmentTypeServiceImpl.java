package com.chinacreator.xtbg.yimingju.officeassets.service.impl;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeEquipmentTypeDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean;
import com.chinacreator.xtbg.yimingju.officeassets.service.OfficeEquipmentTypeServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:OfficeEquipmentServiceImpl.java</p>
 *<p>Description:办公设备管理服务实现类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-3-1
 */
public class OfficeEquipmentTypeServiceImpl implements OfficeEquipmentTypeServiceIfc {

	public static final Logger logger = Logger.getLogger(OfficeEquipmentTypeServiceImpl.class.getName());
	
	/**
	 * @Description  保存办公设备管理信息
	 * 
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean saveOe(String paramjosn) {
		OfficeEquipmentTypeBean OeBean  = new OfficeEquipmentTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			OeBean = (OfficeEquipmentTypeBean) JSONObject.parseObject(paramjosn, OfficeEquipmentTypeBean.class);
		} 
		
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao) DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			dao.addOe(OeBean);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * @Description  根据办公设备管理ID获得办公设备管理对象
	 * 
	 * @param id  办公设备管理ID
	 * @return  TypeBean 办公设备管理对象
	 * @exception 
	 */
	public OfficeEquipmentTypeBean getOeBeanById(String id) {
		OfficeEquipmentTypeBean TypeBean = null;
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao)DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			TypeBean = dao.getTypeBeanById(id);
		} catch (Exception e) {
			logger.info(e.getMessage());
		}
		return TypeBean;
	}

	/**
	 * @Description  修改办公设备管理信息
	 * 
	 * @param paramjosn  要修改的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateOe(String paramjosn) {
		OfficeEquipmentTypeBean TypeBean  = new OfficeEquipmentTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			TypeBean = (OfficeEquipmentTypeBean) JSONObject.parseObject(paramjosn, OfficeEquipmentTypeBean.class);
		} 
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao)DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			dao.updateType(TypeBean);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * @Description  删除办公设备管理信息
	 * 
	 * @param ids  //要删除的办公设备管理ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean delOe(String ids) {
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao)DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			dao.delType(ids);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  根据类型ID查询办公室设备
	 * 
	 * @param ids  //类型id
	 * @return  boolean
	 * @exception 
	 */
	public boolean findOfficeByTypeid(String ids){
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao)DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			return  dao.findEqStockByTypeId(ids);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
	}
	
	/**
	 * @Description  根据类型名称查询办公室设备
	 * 
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean queryOfficeByTypeName(String paramjosn){
		OfficeEquipmentTypeBean TypeBean  = new OfficeEquipmentTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			TypeBean = (OfficeEquipmentTypeBean) JSONObject.parseObject(paramjosn, OfficeEquipmentTypeBean.class);
		} 
		try {
			OfficeEquipmentTypeDao dao = (OfficeEquipmentTypeDao)DaoImplClassUtil.getDaoImplClass("officeEquipmentTypeDaoImpl");
			return  dao.findEquipmentTypeByName(TypeBean);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
	}
	
}

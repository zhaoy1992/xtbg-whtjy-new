package com.chinacreator.xtbg.yimingju.officeassets.service.impl;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeConsumeTypeDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean;
import com.chinacreator.xtbg.yimingju.officeassets.service.OfficeConsumeServiceIfc;
/**
 *<p>Title:OfficeEquipmentServiceImpl.java</p>
 *<p>Description:易耗品管理服务实现类</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public class OfficeConsumeServiceImpl implements OfficeConsumeServiceIfc{
	
	public static final Logger logger = Logger.getLogger(OfficeConsumeServiceImpl.class.getName());
	/**
	 * @Description  保存易耗品管理信息
	 * 
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean saveOe(String paramjosn){
		OfficeConsumeTypeBean OeBean  = new OfficeConsumeTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			OeBean = (OfficeConsumeTypeBean) JSONObject.parseObject(paramjosn, OfficeConsumeTypeBean.class);
		} 
		
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao) DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			dao.addOe(OeBean);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  查询易耗品信息
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean queryConByTypeName(String paramjosn){
		OfficeConsumeTypeBean OeBean  = new OfficeConsumeTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			OeBean = (OfficeConsumeTypeBean) JSONObject.parseObject(paramjosn, OfficeConsumeTypeBean.class);
		} 
		
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao) DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			return dao.findTypeBeanByName(OeBean);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
	}
	
	/**
	 * @Description  根据易耗品管理ID获得易耗品管理对象
	 * 
	 * @param id  易耗品管理ID
	 * @return  ContentBean 办易耗品管理对象
	 * @exception 
	 */
	public OfficeConsumeTypeBean getOeBeanById(String id){
		OfficeConsumeTypeBean TypeBean = null;
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao)DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			TypeBean = dao.getTypeBeanById(id);
		} catch (Exception e) {
			logger.info(e.getMessage());
		}
		return TypeBean;
	}
	
	/**
	 * @Description  修改易耗品管理信息
	 * 
	 * @param paramjosn  要修改的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateOe(String paramjosn){
		OfficeConsumeTypeBean TypeBean  = new OfficeConsumeTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			TypeBean = (OfficeConsumeTypeBean) JSONObject.parseObject(paramjosn, OfficeConsumeTypeBean.class);
		} 
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao)DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			dao.updateType(TypeBean);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  删除易耗品管理信息
	 * 
	 * @param ids  要删除的易耗品管理ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean delOe(String ids){
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao)DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			dao.delType(ids);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  查询易耗品信息
	 * 
	 * @param ids  根据类型ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean findConByTypeId(String ids){
		try {
			OfficeConsumeTypeDao dao = (OfficeConsumeTypeDao)DaoImplClassUtil.getDaoImplClass("officeConsumeTypeDaoImpl");
			return dao.findConByTypeId(ids);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
	}
}

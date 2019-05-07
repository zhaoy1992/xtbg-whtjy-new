package com.chinacreator.xtbg.pub.core.service.impl;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.core.dao.OrgTypeDao;
import com.chinacreator.xtbg.pub.core.entity.OrgTypeBean;
import com.chinacreator.xtbg.pub.core.service.OrgTypeServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:OrgTypeDaoImpl.java</p>
 *<p>Description:机构类型业务接口</p> 
 *<p>Company:湖南科创</p>
 *@author 李义
 *@version 1.0
 *2012-1-31
 */
public class OrgTypeServiceImpl implements OrgTypeServiceIfc {
	
	private static final Logger LOG = Logger.getLogger(OrgTypeServiceImpl.class);
	
	@Override
	public OrgTypeBean getOrgTypeBeanById(String id) {
		OrgTypeBean entity = new OrgTypeBean();
		try {
			OrgTypeDao dao = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			entity = dao.getOrgTypeBeanById(id);
			if(!StringUtil.isBlank(entity.getCreateAt())&&entity.getCreateAt().length()>10){
				entity.setCreateAt(entity.getCreateAt().substring(0, 10));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行机构类型查询报错："+e.getMessage());
			return entity;
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("读取配置文件出错："+e.getMessage());
			return entity;
		}
		return entity;
	}

	@Override
	public Boolean saveOrgType(String paramJson) {
		OrgTypeBean entity  = new OrgTypeBean();
		if (!StringUtil.isBlank(paramJson)) {
			paramJson = DataControlUtil.replaceStr(paramJson);
			entity = (OrgTypeBean) JSONObject.parseObject(paramJson, OrgTypeBean.class);
		} 
		try {
			OrgTypeDao dao = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			dao.addOrgType(entity);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("读取配置文件出错："+e.getMessage());
			return false;
		}
		return true;
	}

	@Override
	public Boolean updateOrgType(String paramJson) {
		OrgTypeBean entity  = new OrgTypeBean();
		if (!StringUtil.isBlank(paramJson)) {
			paramJson = DataControlUtil.replaceStr(paramJson);
			entity = (OrgTypeBean) JSONObject.parseObject(paramJson, OrgTypeBean.class);
		} 
		try {
			OrgTypeDao dao = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			dao.updateOrgType(entity);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("读取配置文件出错："+e.getMessage());
			return false;
		}
		return true;
	}

	@Override
	public Boolean delOrgType(String delIds) {
		try {
			OrgTypeDao dao = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			dao.delOrgType(delIds);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("读取配置文件出错："+e.getMessage());
			return false;
		}
		return true;
	}

	@Override
	public Boolean changeOrgTypeState(String ids,String state) {
		try {
			OrgTypeDao dao = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			ids = DataControlUtil.replaceStr(ids);
			ids = ids.replaceAll("\\\\", "");
			dao.changeOrgTypeState(ids,state);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("读取配置文件出错："+e.getMessage());
			return false;
		}
		return true;
	}

}

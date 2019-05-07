package com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppStoreDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle.AppStoreDaoImpl;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppStoreServiceIfc;


/**
 * description 应用商店管理service实现层
 * author yin.liu
 * date 2012-1-31
 */
public class AppStoreServiceImpl implements AppStoreServiceIfc {

	public static final Logger logger = Logger.getLogger(AppStoreServiceImpl.class);

	/**
	 * 保存
	 */
	public boolean saveAppStore(String paramjosn) {
		AppStoreBean bean = new AppStoreBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			bean = (AppStoreBean) JSONObject.parseObject(paramjosn,AppStoreBean.class);
		}
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			dao.addAppStore(bean);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * 获取一个应用对象 
	 */
	public AppStoreBean getAppStoreBeanById(String id) {
		AppStoreBean bean = null;
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			bean = dao.getAppStoreBeanById(id);
		}catch (Exception e) {
			logger.info(e.getMessage());
		}
		return bean;
	}

	/**
	 * 更新
	 */
	public boolean updateAppStore(String paramjosn) {
		AppStoreBean bean = new AppStoreBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			bean = (AppStoreBean) JSONObject.parseObject(paramjosn,AppStoreBean.class);
		}
		try {
			AppStoreDao dao =  new AppStoreDaoImpl();
			dao.updateAppStore(bean);
		}catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * 删除
	 */
	public boolean delAppStore(String ids) {
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			return dao.delAppStore(ids);
		}catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
	}
	

	/**
	 * 获取图标集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppIconMap(){
		HashMap<String,String> map = new HashMap<String,String>();
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			map = dao.getAppIconMap();
		}catch (Exception e) {
			logger.info(e.getMessage());
			return null;
		}
		return map;
	}

	/**
	 * 获取应用类别集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppTypeMap(){
		HashMap<String,String> map = new HashMap<String,String>();
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			map = dao.getAppTypeMap();
		}catch (Exception e) {
			logger.info(e.getMessage());
			return null;
		}
		return map;
	}
	
	/**
	 * 获取应用class类集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getClassNameMap(){
		HashMap<String,String> map = new HashMap<String,String>();
		try {
			AppStoreDao dao = new AppStoreDaoImpl();
			map = dao.getClassNameMap();
		}catch (Exception e) {
			logger.info(e.getMessage());
			return null;
		}
		return map;
	}
}

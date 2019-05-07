package com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppPermissionDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle.AppPermissionDaoImpl;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppPermissionBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppPermissionServiceIfc;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppStoreServiceIfc;


/**
 * description 应用注册
 * author yin.liu
 * date 2012-2-2
 */
public class AppPermissionServiceImpl implements AppPermissionServiceIfc {

	public static final Logger logger = Logger.getLogger(AppPermissionServiceImpl.class);
	
	/**
	 * @Description 添加应用注册信息
	 * @param appPermission 应用注册Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean saveAppPermission(String appids,String orgid,String orgname){
		AppStoreServiceIfc  storeservice = new AppStoreServiceImpl();
		String[] appArr = appids.split(",");
		for(String appid : appArr){
			appid = appid.replaceAll("'", "");
			AppStoreBean storeBean = storeservice.getAppStoreBeanById(appid);
			AppPermissionBean appBean = new AppPermissionBean();
			appBean.setAppid(storeBean.getAppid());
			appBean.setAppname(storeBean.getName());
			appBean.setAppimg(storeBean.getImg());
			appBean.setAppclassname(storeBean.getClassname());
			appBean.setApptype(storeBean.getApptype());
			appBean.setOrgid(orgid);
			appBean.setOrgname(orgname);
			try {
				AppPermissionDao dao = new AppPermissionDaoImpl();
				dao.addAppPermission(appBean);
			}catch (Exception e) {
				logger.info(e.getMessage());
				return false;
			}
		}
		AppPermissionDao adao = new AppPermissionDaoImpl();
		try {
			adao.insertAppToWait(orgid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	/**
	 * @Description  删除应用注册信息
	 * @param pids
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppPermission(String pids,String orgid){
		try {
			AppPermissionDao dao = new AppPermissionDaoImpl();
			dao.delAppPermission(pids);
			dao.insertAppToWait(orgid);
		}catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
}

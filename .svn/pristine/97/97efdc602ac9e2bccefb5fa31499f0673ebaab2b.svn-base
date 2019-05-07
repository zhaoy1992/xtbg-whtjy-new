/**
 * 
 */
package com.chinacreator.xtbg.pub.tree.service.impl;

import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.tree.service.ModuleTreeServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao;
/**
 * @author weiwei.liu
 *
 */
public class ModuleTreeServiceImpl implements ModuleTreeServiceIfc{
	public static final Logger logger = Logger.getLogger(ModuleTreeServiceImpl.class.getName());

	/**
	 * 资源树
	 */
	public String getModuleInfo() {
		String moduleTreeInfo="";
		try {
			ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
			moduleTreeInfo=moduleTreeDao.getModuleTreeMessage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return moduleTreeInfo;
	}
	/**
	 * 人员树
	 */
	public String getUserTreeInfo() {
		String UserTreeInfo="";
		try {
			ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
			UserTreeInfo=moduleTreeDao.getOrgUserTreeMessage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return UserTreeInfo;
	}
	/**
	 * 机构树
	 */
	public String getOrgTreeInfo() {
		String orgInfo="";
		try {
			ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
			orgInfo=moduleTreeDao.getOrgTreeMessage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orgInfo;
	}
	
	
	/**
	 * 机构树
	 */
	public String getOrgTreeMessageByUserInfo(Map<String,Object> userInfos) {
		String orgInfo="";
		try {
			ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
			orgInfo=moduleTreeDao.getOrgTreeMessageByUserInfo(userInfos);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orgInfo;
	}
}

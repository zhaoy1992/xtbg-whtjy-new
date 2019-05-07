package com.chinacreator.xtbg.core.personwork.service.impl;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.personwork.dao.impl.PriManageDaoImpl;
import com.chinacreator.xtbg.core.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc;

/**
 * 
 *<p>
 * Title:PGroupServiceImpl.java
 * </p>
 *<p>
 * Description:通讯录分组管理
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-17
 */
public class PGroupServiceImpl implements PGroupServiceIfc {
	private static final Logger LOG = Logger.getLogger(PGroupServiceImpl.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryExist
	 * 
	 * @param paramjosn
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc#queryExist(java.lang.String)
	 */
	@Override
	public boolean queryExist(String paramjosn) {
		boolean eflag = false;
		PGroupBean pGroupBean = null;
		pGroupBean = JSONObject.parseObject(paramjosn, PGroupBean.class);
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			eflag = primdao.queryExist(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return eflag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryExist
	  * @param PGroupBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc#queryExist(java.lang.String)
	 */
	public boolean queryExist(PGroupBean pGroupBean) {
		boolean eflag = false;
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			eflag = primdao.queryExist(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return eflag;
	}
	/**
	 * 
	 * <b>Summary: 权限配置增加条目</b> 复写方法 pGroupAdd
	 * 
	 * @param paramjosn
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc#pGroupAdd(java.lang.String)
	 */
	public boolean pGroupAdd(String paramjosn) {
		boolean flag = true;
		PGroupBean pGroupBean = null;
		pGroupBean = JSONObject.parseObject(paramjosn, PGroupBean.class);
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			flag = primdao.insertGroup(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return flag;
	}

	/**
	 * 
	*<b>Summary:保存分组信息 </b>
	* pGroupAdd()
	* @param pGroupBean
	* @return
	 */
	public boolean pGroupAdd(PGroupBean pGroupBean) {
		boolean flag = true;
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			flag = primdao.insertGroup(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b> 复写方法 pGroupUpdate
	 * 
	 * @param paramjosn
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc#pGroupUpdate(java.lang.String)
	 */
	@Override
	public boolean pGroupUpdate(String paramjosn) {
		boolean flag = true;
		PGroupBean pGroupBean = null;
		pGroupBean = JSONObject.parseObject(paramjosn, PGroupBean.class);
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			flag = primdao.updateGroup(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return flag;
	}

	/**
	 * 
	 * <b>Summary: 删除分组</b> 复写方法 pGroupDelete
	 * 
	 * @param groupId
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc#pGroupDelete(java.lang.String)
	 */
	public boolean pGroupDelete(String groupId) {
		boolean flag = true;
		try {
			PGroupBean pGroupBean = new PGroupBean();
			if (!StringUtil.isBlank(groupId)) {
				groupId = DataControlUtil.replaceStr(groupId);
				groupId = Escape.unescape(groupId);
			}
			pGroupBean.setGroupID(groupId);

			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			flag = primdao.deleteGroup(pGroupBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return flag;
		
	}
}

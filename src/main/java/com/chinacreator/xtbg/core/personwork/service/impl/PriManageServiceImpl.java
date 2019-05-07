package com.chinacreator.xtbg.core.personwork.service.impl;

import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.personwork.dao.impl.PriManageDaoImpl;
import com.chinacreator.xtbg.core.personwork.entity.PriManageBean;
import com.chinacreator.xtbg.core.personwork.service.PriManageServiceIfc;

/**
 * 
 *<p>Title:PriManageServiceImpl.java</p>
 *<p>Description:通讯录权限配置</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-17
 */
public class PriManageServiceImpl implements PriManageServiceIfc {

	private static final Logger LOG = Logger
			.getLogger(PriManageServiceImpl.class);

	/**
	 * 
	  * <b>Summary: 权限配置增加条目</b>
	  *     复写方法 priManageAdd
	  * @param paramjosn
	  * @return 
	  * @see com.chinacreator.xtbg.core.personwork.service.PriManageServiceIfc#priManageAdd(java.lang.String)
	 */
	public boolean priManageAdd(String paramjosn) {
		boolean flag = false;
		PriManageBean pBean = null;
		pBean = JSONObject.parseObject(paramjosn, PriManageBean.class);
		String strName[] = pBean.getLeadName().split("[\\,,\\，]");
		String strID[] = pBean.getLeadsID().split("[\\,,\\，]");
		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			for (int i = 0; i < strName.length; i++) {
				pBean.setLeadID(strID[i]);
				List list = primdao.queryUserID(pBean);
				if (list.size() != 0) {
					for (int j = 0; j < list.size(); j++) {
						PriManageBean priManageBean = (PriManageBean) list
								.get(j);
						String oldPersons = priManageBean.getReLeaders();
						String newPersons = pBean.getPersons();
						String oldPersonsID = priManageBean.getRepersonsID();
						String newPersonsID = pBean.getPersonsID();
						newPersons = deleteRe(oldPersons, newPersons);
						newPersonsID = deleteRe(oldPersonsID, newPersonsID);
						pBean.setPersons(newPersons);
						pBean.setPersonsID(newPersonsID);
						flag = primdao.updatePriInfo(pBean);
					}
				} else {
					flag = primdao.insertPrivilege(pBean);
				}

			}

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary:  查询单调记录</b>
	  *     复写方法 querySingle
	  * @param pBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.personwork.service.PriManageServiceIfc#querySingle(com.chinacreator.xtbg.core.personwork.entity.PriManageBean)
	 */
	public PriManageBean querySingle(PriManageBean pBean) {

		try {
			PriManageDaoImpl primdao = (PriManageDaoImpl) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");
			pBean = primdao.querySingle(pBean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		return pBean;
	}

	/**
	 * 
	*<b>Summary: 去掉重复字符</b>
	* deleteRe(请用一句话描述这个方法的作用)
	* @param oldstr
	* @param newstr
	* @return
	 */
	@SuppressWarnings("unchecked")
	public String deleteRe(String oldstr, String newstr) {
		StringBuffer stringBuffer = new StringBuffer();
		newstr = oldstr + "," + newstr;
		String[] strs = newstr.split("[\\,,\\，]");
		Set set = new TreeSet();
		for (int i = 0; i < strs.length; i++) {
			set.add(strs[i]);
		}
		strs = (String[]) set.toArray(new String[0]);
		for (int i = 0; i < strs.length; i++) {
			if (i != strs.length - 1) {
				stringBuffer.append(strs[i] + ",");
			} else {
				stringBuffer.append(strs[i]);
			}
		}
		newstr = stringBuffer.toString();
		return newstr;
	}
}

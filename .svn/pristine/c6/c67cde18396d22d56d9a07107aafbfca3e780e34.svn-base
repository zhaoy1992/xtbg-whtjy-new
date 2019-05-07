package com.chinacreator.xtbg.core.agency.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.agency.dao.AgencyDao;
import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
import com.chinacreator.xtbg.core.agency.service.AgencyService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.eform.util.Escape;
/**
 * 
 *<p>Title:AgencyServiceImpl.java</p>
 *<p>Description:委托待办服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-26
 */
public class AgencyServiceImpl implements AgencyService {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delAgencyById
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.service.impl.AgencyService#delAgencyById(java.lang.String)
	 */
	public String delAgencyById(String id) throws Exception {
		String flag = "";
		AgencyDao dao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
		flag= dao.delAgencyById(id);
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 setAgencyByName
	  * @param paramjosn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.service.impl.AgencyService#setAgencyByName(java.lang.String)
	 */
	public String setAgencyByName(String paramjosn) throws Exception {
		String flag = "";
		AgencyBean agencyBean = null;
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			agencyBean = (AgencyBean) JSONObject.parseObject(paramjosn, AgencyBean.class);
		} 
		AgencyDao dao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
		flag = dao.setAgencyByName(agencyBean);
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAgencyBeanById
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.service.impl.AgencyService#findAgencyBeanById(java.lang.String)
	 */
	public AgencyBean findAgencyBeanById(String id) throws Exception {
		AgencyBean agencyBean = null;
		AgencyDao dao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
		agencyBean= dao.findAgencyBeanById(id);
		return agencyBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateAgencyBeanById
	  * @param paramjosn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.service.impl.AgencyService#updateAgencyBeanById(java.lang.String)
	 */
	public String updateAgencyBeanById(String paramjosn) throws Exception {
		String flag = "";
		AgencyBean agencyBean = null;
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			agencyBean = (AgencyBean) JSONObject.parseObject(paramjosn, AgencyBean.class);
		} 
		AgencyDao dao = (AgencyDao)LoadSpringContext.getApplicationContext().getBean("agencyDaoImpl");
		flag = dao.updateAgencyBeanById(agencyBean);
		return flag;
	}

}

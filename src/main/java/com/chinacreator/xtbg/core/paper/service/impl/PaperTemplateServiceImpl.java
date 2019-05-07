
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PaperTemplateServiceImp.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-9-13   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.paper.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao;
import com.chinacreator.xtbg.core.paper.entity.PaperTemplateBean;
import com.chinacreator.xtbg.core.paper.service.PaperTemplateService;

/**
 *<p>Title:PaperTemplateServiceImpl.java</p>
 *<p>Description:信息报送模版管理Service接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public class PaperTemplateServiceImpl implements PaperTemplateService{

	private static final Log LOG=LogFactory.getLog(PaperTemplateServiceImpl.class);	
	/** 
	  * <b>Summary: </b>
	  *     复写方法 getPaperTemplateBean
	  * @param p_template_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperTemplateService#getPaperTemplateBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getPaperTemplateBean(String p_template_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PaperTemplateDao paperTemplateDao=(PaperTemplateDao)LoadSpringContext.getApplicationContext().getBean("paperTemplateDaoImpl");
			viewMap = paperTemplateDao.getPaperTemplate(p_template_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateTemplateBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperTemplateService#insertOrUpdateTemplateBean(com.chinacreator.xtbg.core.paper.entity.PaperTemplateBean) 
	  */
	@Override
	public String insertOrUpdateTemplateBean(PaperTemplateBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperTemplateDao dao=(PaperTemplateDao)LoadSpringContext.getApplicationContext().getBean("paperTemplateDaoImpl");
			//1:设置时间creator_time
			bean.setCreate_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCreate_time()), "yyyy-MM-dd HH24:mi:ss"));
			if(StringUtil.nullOrBlank(bean.getP_template_id())){//insert
				bean.setP_template_id(StringUtil.getUUID());
				beanId = bean.getP_template_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getP_template_id();
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePaperTemplateByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperTemplateService#deletePaperTemplateByIds(java.lang.String[]) 
	  */
	@Override
	public String deletePaperTemplateByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperTemplateDao dao= (PaperTemplateDao)LoadSpringContext.getApplicationContext().getBean("paperTemplateDaoImpl");
			for (String beanId : ids) {
				dao.deletePaperTemplateById(conn, beanId);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
}

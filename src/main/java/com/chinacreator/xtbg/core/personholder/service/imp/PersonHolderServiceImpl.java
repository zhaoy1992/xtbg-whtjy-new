
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonHolderServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.service.imp;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;
import com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc;

/**
 *<p>Title:PersonHolderServiceImpl.java</p>
 *<p>Description:人员持证管理业务层</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public class PersonHolderServiceImpl implements PersonHolderServiceIfc {

	private static final Log LOG=LogFactory.getLog(PersonHolderServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPersonHolderBean
	  * @param hold_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc#getPersonHolderBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getPersonHolderBean(String hold_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PersonHolderDao personholderdao=(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			viewMap = personholderdao.getPersonHolder(hold_id, conn);
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
	  *     复写方法 insertOrUpdatePersonHolder
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc#insertOrUpdatePersonHolder(com.chinacreator.xtbg.core.personholder.entity.PersonHolder) 
	  */
	@Override
	public boolean insertOrUpdatePersonHolder(PersonHolder bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonHolderDao dao =(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			Integer count = dao.getCountById(bean.getHold_usesnid(), bean.getHold_name());
			if(count>0){
				dao.updateHolder(bean, conn);
			}else{
				if(StringUtil.isBlank(bean.getHold_id())){
					bean.setHold_id(StringUtil.getUUID());
					dao.insertHolder(bean, conn);
				}else{
					dao.updateHolder2(bean, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePersonHolderByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc#deletePersonHolderByIds(java.lang.String[]) 
	  */
	@Override
	public String deletePersonHolderByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonHolderDao dao =(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			for (String beanId : ids) {
				dao.deletePersonHolderById(conn, beanId);
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

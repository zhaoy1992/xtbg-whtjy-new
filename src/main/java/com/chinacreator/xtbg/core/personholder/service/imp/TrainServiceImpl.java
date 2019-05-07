
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     TrainServiceImpl.java
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
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;
import com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc;

/**
 *<p>Title:TrainServiceImpl.java</p>
 *<p>Description:培训记录管理业务层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public class TrainServiceImpl implements TrainServiceIfc{

	private static final Log LOG=LogFactory.getLog(TrainServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getTrainBean
	  * @param hold_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc#getTrainBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getTrainBean(String tr_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PersonHolderDao personholderdao=(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			viewMap = personholderdao.getTrainBean(tr_id, conn);
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
	  *     复写方法 insertOrUpdateTrain
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc#insertOrUpdateTrain(com.chinacreator.xtbg.core.personholder.entity.TrainBean) 
	  */
	@Override
	public String insertOrUpdateTrain(TrainBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//1:设置时间tr_time
			bean.setTr_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getTr_time()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			PersonHolderDao dao =(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			if(StringUtil.nullOrBlank(bean.getTr_id())){//insert
				bean.setTr_id(StringUtil.getUUID());
				beanId = bean.getTr_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getTr_id();
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
	  *     复写方法 deleteTrainByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc#deleteTrainByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteTrainByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonHolderDao dao =(PersonHolderDao)LoadSpringContext.getApplicationContext().getBean("personholderDaoImpl");
			for (String beanId : ids) {
				dao.deleteTrainBeanById(conn, beanId);
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

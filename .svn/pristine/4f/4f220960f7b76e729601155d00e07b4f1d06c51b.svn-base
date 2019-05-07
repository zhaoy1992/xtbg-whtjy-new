
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataBaseServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-14   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.persondata.dao.PsdataBaseDao;
import com.chinacreator.xtbg.core.persondata.entity.PsdataBaseBean;
import com.chinacreator.xtbg.core.persondata.service.PsdataBaseService;


/**
 *<p>Title:PsdataBaseServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-14
 */
public class PsdataBaseServiceImpl implements PsdataBaseService{
	private static final Log LOG=LogFactory.getLog(PsdataBaseServiceImpl.class);
	/**
	*<b>Summary: </b>
	* getPsdataBaseBean(根据资料Id查询资料信息)
	* @param p_data_id
	* @return
	 */
	public Map<String, String> getPsdataBaseBean(String p_data_id){
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PsdataBaseDao psdataBaseDao=(PsdataBaseDao)LoadSpringContext.getApplicationContext().getBean("psdatabaseDaoImp");
			viewMap = psdataBaseDao.getPsdataBaseById(p_data_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* insertOrUpdatePsdataBaseBean(增加和修改资料基本信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdatePsdataBaseBean(PsdataBaseBean bean){
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PsdataBaseDao dao=(PsdataBaseDao)LoadSpringContext.getApplicationContext().getBean("psdatabaseDaoImp");
			//1:设置时间F_creator_time
			bean.setP_creater_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getP_creater_time()), "yyyy-MM-dd HH24:mi:ss"));
			//文件形成时间
			bean.setP_file_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getP_file_time()), "yyyy-MM-dd"));
			
			if(StringUtil.nullOrBlank(bean.getP_data_id())){//insert
				beanId = StringUtil.getUUID();
				bean.setP_data_id(beanId);
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getP_data_id();
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
	*<b>Summary: </b>
	* deletePsdatabaseByIds(根据IDs 删除资料基本信息)
	* @param ids
	* @return
	 */
	public String  deletePsdatabaseByIds(String[] ids){
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PsdataBaseDao dao=(PsdataBaseDao)LoadSpringContext.getApplicationContext().getBean("psdatabaseDaoImp");
			for (String beanId : ids) {
				dao.deletePsdataBaseBeansById(conn, beanId);
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

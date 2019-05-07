
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OfficeDetailServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsofficeAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsofficeAccountDaoImpl;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsofficeAccountBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OfficeDetailService;

/**
 *<p>Title:OfficeDetailServiceImpl.java</p>
 *<p>Description:固定资产详细台帐业务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public class OfficeDetailServiceImpl implements OfficeDetailService{
	
	private static final Log LOG=LogFactory.getLog(OfficeDetailServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOfficeDetailBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OfficeDetailService#getOfficeDetailBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getOfficeDetailBean(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			OsofficeAccountDao daojson = new OsofficeAccountDaoImpl();
			viewMap = daojson.getOfficeDetailBean(id, conn);
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
	  *     复写方法 insertOrUpdateOfficeDetail
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OfficeDetailService#insertOrUpdateOfficeDetail(com.chinacreator.xtbg.tjy.officesupplies.entity.OsofficeAccountBean) 
	  */
	@Override
	public String insertOrUpdateOfficeDetail(OsofficeAccountBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//2.设置领用时间 r_reviewtime
			bean.setReceive_day(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getReceive_day()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			OsofficeAccountDao dao = new OsofficeAccountDaoImpl();
			if(StringUtil.nullOrBlank(bean.getId())){//insert
				bean.setId(StringUtil.getUUID());
				beanId = bean.getId();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getId();
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
	  *     复写方法 deleteOfficeDetailByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OfficeDetailService#deleteOfficeDetailByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteOfficeDetailByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OsofficeAccountDao dao = new OsofficeAccountDaoImpl();
			for (String beanId : ids) {
				dao.deleteOfficeDetailByIds(conn, beanId);
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

package com.chinacreator.xtbg.core.archive.gwcs.services.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:ReceiveGwServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-12-30
 */
public class ReceiveGwServiceImpl implements ReceiveGwService {
	private static final Log LOG=LogFactory.getLog(ReceiveGwServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAttachid
	  * @param attach_id
	  * @param filename
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService#findAttachid(java.lang.String, java.lang.String)
	 */
	public String findAttachid(String attach_id, String filename) {
		Connection conn = null;
		String id="";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
			id=dao.findAttachid(attach_id,filename,conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return id;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findReceiveGw
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService#findReceiveGw(java.lang.String)
	 */
	public Map<String, String> findReceiveGw(String id) {
		Connection conn = null;
		Map<String, String> bean=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
			bean=dao.findReceiveGw(id,conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return bean;
	}
	/**
	 * 
	 */
	@Override
	public boolean deleteGwreceiveBeanByIds(String[] deleteArr) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
			for (String beanId : deleteArr) {
				dao.deleteGwreceiveBeansById(conn, beanId);
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
	 * 
	 */
	@Override
	public String insertOrUpdateGwreceiveBean(GwreceiveBean bean) {
		Connection conn = null;
		String beanId = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
			bean.setCreator_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getCreator_time()), "yyyy-MM-dd"));
			//历史原因 将文号年份 文号改成数据库的格式，与数据保持统一
			//获取编号规则
			String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
			if(serialnumberchar==null || serialnumberchar.length!= 2){
				serialnumberchar[0] = "〔";
				serialnumberchar[1] = "〕";
			}
			bean.setSymbol(serialnumberchar[0]+bean.getSymbol()+serialnumberchar[1]);
			bean.setSerial_number(bean.getSerial_number()+"号");
			bean.setPss_number(bean.getPrefix()+bean.getSymbol()+bean.getSerial_number());
			if(StringUtil.nullOrBlank(bean.getGwreceive_id())){
				bean.setGwreceive_id(StringUtil.getUUID());
				((BaseDao)dao).insert(bean, conn);
			}else{
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
			beanId = bean.getGwreceive_id();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

}

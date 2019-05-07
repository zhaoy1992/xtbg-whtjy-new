package com.chinacreator.xtbg.core.data.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.data.dao.DataDataDao;
import com.chinacreator.xtbg.core.data.entity.DataDataBean;
import com.chinacreator.xtbg.core.data.service.DataDataService;
/**
 * 
 *<p>Title:DataDataServiceImpl.java</p>
 *<p>Description:资料信息服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-21
 */
public class DataDataServiceImpl implements DataDataService {

	private static final Log LOG =LogFactory.getLog(DataDataServiceImpl.class);
	/**
	 * 
	  * <b>Summary:根据Ids删除资料信息 </b>
	  *     复写方法 deleteDataBaseInfoByIds
	  * @param beanIdArr
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataDataService#deleteDataBaseInfoByIds(java.lang.String[])
	 */
	public String deleteDataBaseInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataDataDao dao=(DataDataDao)LoadSpringContext.getApplicationContext().getBean("dataDataDaoImpl");
			for (String beanId : beanIdArr) {
				DataDataBean bean=new DataDataBean();
				bean.setD_data_id(beanId);
				((BaseDao)dao).deleteListById(bean, conn, beanId);
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
	/**
	 * 
	  * <b>Summary:添加和修改资料信息 </b>
	  *     复写方法 insertOrUpdateDataBaseBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataDataService#insertOrUpdateDataBaseBean(com.chinacreator.xtbg.core.data.entity.DataDataBean)
	 */
	public String insertOrUpdateDataBaseBean(DataDataBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataDataDao dao=(DataDataDao)LoadSpringContext.getApplicationContext().getBean("dataDataDaoImpl");
			//1:设置登记时间
			bean.setD_data_create_time((StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getD_data_create_time()), "yyyy-MM-dd HH24:mi:ss")));
			//文件形成时间
			bean.setD_data_put_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getD_data_put_time()), "yyyy-MM-dd"));
			if(StringUtil.nullOrBlank(bean.getD_data_id())){//insert
				bean.setD_data_id(StringUtil.getUUID());
				beanId = bean.getD_data_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getD_data_id();
				
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
	 * 
	  * <b>Summary: 根据Id查询资料信息</b>
	  *     复写方法 getDataBaseBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataDataService#getDataBaseBean(java.lang.String)
	 */
	public Map<String, String> getDataBaseBean(String id) {
		Connection conn=null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataDataDao dao=(DataDataDao)LoadSpringContext.getApplicationContext().getBean("dataDataDaoImpl");
			map = dao.getDataBaseBean(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary: 根据分类Id查询资料信息</b>
	  *     复写方法 getDataBaseBeanList
	  * @param typeid
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataDataService#getDataBaseBeanList(java.lang.String)
	 */
	public List<Map<String, String>> getDataBaseBeanList(String typeid) {
		Connection conn=null;
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataDataDao dao=(DataDataDao)LoadSpringContext.getApplicationContext().getBean("dataDataDaoImpl");
			list = dao.getDataBaseBeanList(typeid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}

}

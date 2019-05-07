
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     SubSystemWebServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-26   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.subsystemmanage.service;

import java.sql.Connection;
import java.util.Map;

import javax.jws.WebService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemUseInfoDao;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUseInfoBean;

/**
 *<p>Title:SubSystemWebServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-26
 */
@WebService(endpointInterface = "com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemWebService",
        serviceName = "SubSystemWebService")
public class SubSystemWebServiceImpl implements SubSystemWebService{
	
	public String ret_success = "0";//成功
	public String ret_failed = "1";//失败
	
	private static final Log LOG = LogFactory.getLog(SubSystemWebServiceImpl.class);
	
	private SubSystemUseInfoDao subSystemUseInfoDao = null;//oa对于子系统的处理接口

	public SubSystemUseInfoDao getSubSystemUseInfoDao() {
		return subSystemUseInfoDao;
	}

	public void setSubSystemUseInfoDao(SubSystemUseInfoDao subSystemUseInfoDao) {
		this.subSystemUseInfoDao = subSystemUseInfoDao;
	}


	/**
	  * <b>Summary: </b>
	  *     复写方法 modUserPasss
	  * @param uuid
	  * @param user_id
	  * @param user_name
	  * @param password
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemWebService#modUserPasss(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public String modUserPasss(String uuid, String user_id, String user_name,
			String password){
		
		Connection con = null;
		LOG.info("--OA系统中单点登录 用户密码 !start--");
		String resultCode = ret_success;
		
		 try {
			 SubsysUseInfoBean subsysUseInfoBean = new SubsysUseInfoBean();
			 LOG.info("--sys_id--"+uuid);
			 LOG.info("--user_id--"+user_id);
			 LOG.info("--user_name--"+user_name);
			 LOG.info("--password--"+password);
			 subsysUseInfoBean.setSys_id(uuid);//子系统ID
			 subsysUseInfoBean.setUser_id(user_id);//用户ID
			 subsysUseInfoBean.setSys_user_id(user_name);//用户名称
			 subsysUseInfoBean.setSys_user_password(password);//用户密码
			 con = DbManager.getInstance().getTransactionConnection();
			 //判断子系统 用户ID是否存在
			 boolean isExit = subSystemUseInfoDao.isFindUserInSysid(user_name,uuid);
			 if(isExit){
				 //查询子系统信息
				 Map<String,String> map = subSystemUseInfoDao.FindUserInSysid(user_name,uuid);
				 //主键ID
				 subsysUseInfoBean.setInfo_id((String)map.get("info_id"));
				 ((BaseDao)subSystemUseInfoDao).update(subsysUseInfoBean);
			 } else {
				 subsysUseInfoBean.setInfo_id(DaoUtil.getUUID());//主键ID
				 ((BaseDao)subSystemUseInfoDao).insert(subsysUseInfoBean);
			 }
			 
		} catch (Exception e) {
			resultCode = ret_failed;
			DbManager.rollBackNoThrow(con);
			LOG.error(e.getMessage(), e);
		} finally{
			if(con != null){
				DbManager.closeConnection(con);
			}
		}
		LOG.info("--OA系统中单点登录 用户密码 !end--"+("0".equals(resultCode)?"成功！":"失败！"));
		return resultCode;
	}

}

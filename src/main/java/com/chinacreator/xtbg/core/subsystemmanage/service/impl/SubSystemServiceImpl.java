package com.chinacreator.xtbg.core.subsystemmanage.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao;
import com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ParseExcelUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemManageDao;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemUseInfoDao;
import com.chinacreator.xtbg.core.subsystemmanage.entity.GwcsOrgMappingBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysManageBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUseInfoBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUserImportBean;
import com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemServiceIfc;
import com.frameworkset.orm.transaction.TransactionManager;

public class SubSystemServiceImpl implements SubSystemServiceIfc {
	private static final Logger logger = Logger.getLogger(SubSystemServiceImpl.class.getName());
	private SubSystemManageDao subSystemManageDao = null;
	private SubSystemUseInfoDao subSystemUseInfoDao = null;
	private SubSystemOrgConfigDao subSystemOrgConfigDao = null;
	
	private String outStr="";
	private int cgdrNumber=0;
	private int cggxNumber=0;
	private int drsbNumber=0;
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 SubSystemServiceImpl  
	   * <b>Remarks: </b>
	  *     构造类 SubSystemServiceImpl 的构造函数 SubSystemServiceImpl
	 */
	public SubSystemServiceImpl() {
		super();
		try{
			subSystemManageDao = (SubSystemManageDao)LoadSpringContext.getApplicationContext().getBean("subSystemManageDaoImpl");;
			subSystemUseInfoDao = (SubSystemUseInfoDao)LoadSpringContext.getApplicationContext().getBean("subSystemUseInfoDaoImpl");
			subSystemOrgConfigDao = (SubSystemOrgConfigDao)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteSubSystemManage
	  * @param sysids
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc#deleteSubSystemManage(java.lang.String)
	 */
	public boolean deleteSubSystemManage(String sysids) {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			SubsysManageBean subsysManageBean = new SubsysManageBean();
			((BaseDao)subSystemManageDao).deleteListById(subsysManageBean, sysids);
			tm.commit();
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteSubSystemUseInfo
	  * @param infos
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc#deleteSubSystemUseInfo(java.lang.String)
	 */
	public boolean deleteSubSystemUseInfo(String infos) {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			SubsysUseInfoBean subsysUseInfoBean = new SubsysUseInfoBean();
			((BaseDao)subSystemUseInfoDao).deleteListById(subsysUseInfoBean, infos);
			tm.commit();
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveSubSystemManage
	  * @param subsysManageBean
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc#saveSubSystemManage(com.chinacreator.xtbg.pub.subSystemManage.entity.SubsysManageBean)
	 */
	public boolean saveSubSystemManage(SubsysManageBean subsysManageBean) {
		TransactionManager tm = new TransactionManager();
		boolean isSucess = true;
		String sysId = subsysManageBean.getSys_id();
		try {
			tm.begin();
			if(StringUtil.nullOrBlank(sysId)){
				subsysManageBean.setSys_id(DaoUtil.getUUID());
				((BaseDao)subSystemManageDao).insert(subsysManageBean);
			}else{
				((BaseDao)subSystemManageDao).update(subsysManageBean);
			}
			tm.commit();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			isSucess = false;
		}
		return isSucess;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveSubSystemUseInfo
	  * @param subsysUseInfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc#saveSubSystemUseInfo(com.chinacreator.xtbg.pub.subSystemManage.entity.SubsysUseInfoBean)
	 */
	public Map<String,Object> saveSubSystemUseInfo(SubsysUseInfoBean subsysUseInfoBean) {
		TransactionManager tm = new TransactionManager();
		Map<String,Object> resultMap = new HashMap<String, Object>();
		boolean isSucess = true;
		String resultStr = "true";
		String infoId = subsysUseInfoBean.getInfo_id();
		try {
			tm.begin();
			boolean isExsit = subSystemUseInfoDao.isExsitUserInSysid(subsysUseInfoBean.getInfo_id(),subsysUseInfoBean.getUser_id(), subsysUseInfoBean.getSys_id());
			if(isExsit){
				resultStr = "保存失败，用户在当前系统中已存在记录！";
				resultMap.put("isSucess", false);
				resultMap.put("resultStr", resultStr);
				return resultMap;
			}
				
			if(StringUtil.nullOrBlank(infoId)){
				subsysUseInfoBean.setInfo_id(DaoUtil.getUUID());
				((BaseDao)subSystemUseInfoDao).insert(subsysUseInfoBean);
			}else{
				((BaseDao)subSystemUseInfoDao).update(subsysUseInfoBean);
			}
			tm.commit();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			isSucess = false;
		}
		resultMap.put("isSucess", isSucess);
		resultMap.put("resultStr", resultStr);
		return resultMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveSubSystemOrgMappingInfo
	  * @param gwcsOrgMappingBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemServiceIfc#saveSubSystemOrgMappingInfo(com.chinacreator.xtbg.core.subsystemmanage.entity.GwcsOrgMappingBean)
	 */
	public Map<String,Object> saveSubSystemOrgMappingInfo(
			GwcsOrgMappingBean gwcsOrgMappingBean) {
		TransactionManager tm = new TransactionManager();
		Map<String,Object> resultMap = new HashMap<String, Object>();
		boolean isSucess = true;
		String resultStr = "true";
		GwcsOrgMappingBean gwcsOrgMappingBeanTemp = null;
		
		GwcsOrgMappingBean bean=new GwcsOrgMappingBean();
		bean.setGwcs_org_id(gwcsOrgMappingBean.getGwcs_org_id());
		bean.setOa_org_id(gwcsOrgMappingBean.getOa_org_id());
		try {
			tm.begin();
			gwcsOrgMappingBeanTemp = (GwcsOrgMappingBean)((BaseDao)subSystemOrgConfigDao).queryToBean(gwcsOrgMappingBean);
			if(null == gwcsOrgMappingBeanTemp){
				((BaseDao)subSystemOrgConfigDao).insert(gwcsOrgMappingBean);
			}else{
				((BaseDao)subSystemOrgConfigDao).update(bean);
			}
			tm.commit();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			isSucess = false;
		}
		resultMap.put("isSucess", isSucess);
		resultMap.put("resultStr", resultStr);
		return resultMap;
	}
	
	/**
	*<b>Summary: </b>
	* importUserInfoExcel2DB(把导入的用户信息插入到指定的子系统表中)
	* @param subsysUserImportBean
	* @return
	 */
	public String importUserInfoExcel2DB(SubsysUserImportBean subsysUserImportBean){
		TransactionManager tm = new TransactionManager();
		try {
			//开始事务
			tm.begin();
			ParseExcelUtil parseExcelUtil = new ParseExcelUtil(subsysUserImportBean.getImport_file());
			for(int i = 0 ; i < parseExcelUtil.sheet.getRows() ;i ++){
				
				 String[] ssTemp = parseExcelUtil.readLine(i);
				 int j = 1;
				 SubsysUseInfoBean subsysUseInfoBean = new SubsysUseInfoBean();
		    	  if(!StringUtil.nullOrBlank(ssTemp[0]) && StringUtil.isValidNumber(ssTemp[0]) && !StringUtil.nullOrBlank(ssTemp[1])){
		    		  subsysUseInfoBean.setInfo_id(DaoUtil.getUUID());
		    		  subsysUseInfoBean.setSys_id(subsysUserImportBean.getSys_id());
		    		  subsysUseInfoBean.setUser_id(ssTemp[j++]);
		    		  subsysUseInfoBean.setSys_user_id(ssTemp[j++]);
		    		  subsysUseInfoBean.setSys_user_password(ssTemp[j++]);
		    		  //查询子系统和用户名是否已经存在了
		    		  boolean userFlag = subSystemUseInfoDao.isFindUserInSysid(subsysUseInfoBean.getSys_user_id(), subsysUseInfoBean.getSys_id());
		    		  if(userFlag){
		    			  ((BaseDao)subSystemUseInfoDao).update(subsysUseInfoBean);
				    		  outStr=outStr+"<font >["+subsysUseInfoBean.getSys_user_id()+"]的用户已更新</font></br>";
				    		  cggxNumber=cggxNumber+1;
		    		  } else {
		    			  ((BaseDao)subSystemUseInfoDao).insert(subsysUseInfoBean);
		    			  outStr=outStr+"<font >["+subsysUseInfoBean.getSys_user_id()+"]的用户已导入</font></br>";
			    		  cgdrNumber=cgdrNumber+1;
		    		  }
		    	  }
			}
			//提交事务
			tm.commit();
		} catch (Exception e) {
			try {
				//回滚事务
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			logger.info(e.getMessage());
			outStr="解析文件失败,请检查文件</br>";
			outStr=outStr+"成功导入"+cgdrNumber+"条记录<br>";
			outStr=outStr+"成功更新"+cggxNumber+"条记录<br>";
			outStr=outStr+"导入/更新失败"+drsbNumber+"条记录<br>";
			return outStr;
		}
		outStr=outStr+"成功导入"+cgdrNumber+"条记录<br>";
		outStr=outStr+"成功更新"+cggxNumber+"条记录<br>";
		outStr=outStr+"导入/更新失败"+drsbNumber+"条记录<br>";
		return outStr;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveOaGwcsConfigInfo
	  * @param oaGwcsConfigBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemServiceIfc#saveOaGwcsConfigInfo(com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean)
	 */
	@Override
	public Map<String, Object> saveOaGwcsConfigInfo(OaGwcsConfigBean oaGwcsConfigBean) {

		TransactionManager tm = new TransactionManager();
		Map<String,Object> resultMap = new HashMap<String, Object>();
		boolean isSucess = true;
		String resultStr = "true";
		OaGwcsConfigBean oaGwcsConfigBeanTemp = null;
		
		OaGwcsConfigBean bean=new OaGwcsConfigBean();
		bean.setId(oaGwcsConfigBean.getId());
		try {
			tm.begin();
			oaGwcsConfigBeanTemp = (OaGwcsConfigBean)((BaseDao)subSystemOrgConfigDao).queryToBean(bean,null);
			if(null == oaGwcsConfigBeanTemp){
				((BaseDao)subSystemOrgConfigDao).insert(oaGwcsConfigBean,null);
			}else{
				((BaseDao)subSystemOrgConfigDao).update(oaGwcsConfigBean,null);
			}
			tm.commit();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(), e);
			}
			isSucess = false;
		}
		resultMap.put("isSucess", isSucess);
		resultMap.put("resultStr", resultStr);
		return resultMap;
	}

	@Override
	public boolean delOrgConfig(String ids) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OaGwcsConfigBean oaGwcsConfigBean=new OaGwcsConfigBean();
			oaGwcsConfigBean.setDeleteKey("id");
			((BaseDao)subSystemOrgConfigDao).deleteListById(oaGwcsConfigBean, conn, ids);
			flag=true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			logger.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
}

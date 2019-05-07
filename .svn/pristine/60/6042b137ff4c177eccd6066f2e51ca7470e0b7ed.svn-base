package com.chinacreator.xtbg.core.paper.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.creatormaker.util.ChangeToPDF;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperDao;
import com.chinacreator.xtbg.core.paper.entity.PaperBean;
import com.chinacreator.xtbg.core.paper.service.PaperService;
import com.chinacreator.xtbg.core.paper.util.PaperConstants;

/**
 *<p>Title:PaperServiceImpl.java</p>
 *<p>Description:信息报送管理Service接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public class PaperServiceImpl implements PaperService{

	private static final Log LOG=LogFactory.getLog(PaperServiceImpl.class);	
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 savePaperSendAdd 补发
	  * @param map
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#savePaperSendAdd(java.util.Map) 
	  */
	public boolean savePaperSendAdd(Map<String, String> map){
		Connection conn = null;
		boolean flag=false;
        try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao paperDao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			String[] arr = map.get("p_manage_ids").split(",");
			for(int i=0;i<arr.length;i++){
		  		map.put("p_manage_id", arr[i]);
		  		map.put("p_title", this.getPaperBeanById(arr[i]).get("p_acc_title"));
	        	paperDao.savePaperSendAddByUnit(conn, map);
	        	paperDao.savePaperSendAddByUser(conn, map);
	        	flag=true;
			}
			
        } catch (Exception e) {
            DbManager. rollBackNoThrow(conn);
             LOG.error(e.getMessage(), e);
        } finally{
             if(conn != null ){
                 DbManager. closeConnection(conn);
            }
        }
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 savePaperReceiveInfo 保存信息发送的接收方明细
	  * @param map
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#savePaperReceiveInfo(java.util.Map) 
	  */
	public boolean savePaperReceiveInfo(Map<String, String> map){
		Connection conn = null;
		boolean flag=false;
        try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao paperDao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			String[] arr = map.get("p_manage_ids").split(",");
			for(int i=0;i<arr.length;i++){
				if("1".equals(map.get("sendType"))){//单位的
					//先删除已发送的相同单位的接收表
					paperDao.deletePaperReceiveInfoBean4UnitByParams(conn,arr[i]);
			  		map.put("p_manage_id", arr[i]);
			  		map.put("p_title", this.getPaperBeanById(arr[i]).get("p_acc_title"));
		        	paperDao.savePaperReceiveInfoByUnit(conn,map);
		        	flag=true;
				}else if("2".equals(map.get("sendType"))){//个人的
					paperDao.deletePaperReceiveInfoBean4UserByParams(conn,arr[i]);
			  		map.put("p_manage_id", arr[i]);
			  		map.put("p_title", this.getPaperBeanById(arr[i]).get("p_acc_title"));
		        	paperDao.savePaperReceiveInfoByUser(conn,map);
		        	flag=true;
				}
			}
			
        } catch (Exception e) {
            DbManager. rollBackNoThrow(conn);
             LOG.error(e.getMessage(), e);
        } finally{
             if(conn != null ){
                 DbManager. closeConnection(conn);
            }
        }
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPaperBeanById
	  * @param p_manage_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#getPaperBeanById(java.lang.String) 
	  */
	@Override
	public Map<String, String> getPaperBeanById(String p_manage_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PaperDao paperDao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			viewMap = paperDao.getPaperById(p_manage_id, conn);
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
	  *     复写方法 insertOrUpdateBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#insertOrUpdateBean(com.chinacreator.xtbg.core.paper.entity.PaperBean) 
	  */
	@Override
	public String insertOrUpdateBean(PaperBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao dao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			
			if(bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_WAIT_PUBLISH)//送审
					||bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_ACCEPT)
					||bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_TMP)){
				Timestamp currtime= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
				bean.setP_acc_time(currtime);
				if(bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_WAIT_PUBLISH)){//送审时写入送审时间
					bean.setP_sub_time(currtime);
				}
				//送审 或 存采编草稿
				if(StringUtil.nullOrBlank(bean.getP_manage_id())){//insert
					bean.setP_manage_id(StringUtil.getUUID());
					bean.setP_rep_time(currtime);
					bean.setP_acc_unit_ids(bean.getP_rep_unit_id());
					bean.setP_acc_unit_names(bean.getP_rep_unit_name());
					beanId = bean.getP_manage_id();
					((BaseDao)dao).insert(bean, conn);
				}else{//update
					beanId = bean.getP_manage_id();
					((BaseDao)dao).update(bean, conn);
				}
			}else if (bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_REVISE)){//新增发布草稿
				if(StringUtil.nullOrBlank(bean.getP_manage_id())){//insert 
					Timestamp currtime= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
					bean.setP_manage_id(StringUtil.getUUID());
					bean.setP_acc_time(currtime);
					bean.setP_acc_unit_ids(bean.getP_pub_unit_id());
					bean.setP_acc_unit_names(bean.getP_pub_unit_name());
					beanId = bean.getP_manage_id();
					((BaseDao)dao).insert(bean, conn);
				}else{//update
					beanId = bean.getP_manage_id();
					((BaseDao)dao).update(bean, conn);
				}
			}else if (bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_PUBLISHED)){
				Timestamp currtime= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
				bean.setP_pub_time(currtime);
				if(StringUtil.nullOrBlank(bean.getP_manage_id())){//insert
					bean.setP_manage_id(StringUtil.getUUID());
					bean.setP_acc_time(currtime);
					bean.setP_acc_unit_ids(bean.getP_pub_unit_id());
					bean.setP_acc_unit_names(bean.getP_pub_unit_name());
					beanId = bean.getP_manage_id();
					((BaseDao)dao).insert(bean, conn);
				}else{//update
					beanId = bean.getP_manage_id();
					((BaseDao)dao).update(bean, conn);
				}
			}else{
				Timestamp currtime= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
				if(bean.getP_flag_id().equalsIgnoreCase(PaperConstants.STATUS_WAIT_PUBLISH)){//送审时写入送审时间
					bean.setP_sub_time(currtime);
				}
				if(StringUtil.nullOrBlank(bean.getP_manage_id())){//insert
					bean.setP_rep_time(currtime);
					bean.setP_manage_id(StringUtil.getUUID());
					beanId = bean.getP_manage_id();
					((BaseDao)dao).insert(bean, conn);
				}else{//update
					beanId = bean.getP_manage_id();
					((BaseDao)dao).update(bean, conn);
				}
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
	  *     复写方法 deletePaperByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#deletePaperByIds(java.lang.String[]) 
	  */
	@Override
	public String deletePaperByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao dao= (PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			for (String beanId : ids) {
				dao.deletePaperById(conn, beanId);
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
	  * <b>Summary: </b>
	  *     复写方法 accPaper4PendingByIds 根据ids信息采编设置
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#accPaper4PendingByIds(java.lang.String[]) 
	  */
	public boolean updatePaper2AccByIds(String[] ids,String flagId,String userId){
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao dao= (PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			for (String beanId : ids) {
				dao.updatePaper2AccByIds(conn, beanId,flagId,userId);
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
	  *     复写方法 copydoc2pdf
	  * @param p_manage_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#copydoc2pdf(java.lang.String) 
	  */
	public boolean copydoc2pdf(String p_manage_id,String path){
		boolean flag = false;
		path=path+ "\\uploadDocument\\";
		String docFilePath = path+p_manage_id+".doc";
		String pdfFilePath = path+p_manage_id+".pdf";
		try {
			ChangeToPDF.convertWordToPDF(docFilePath, pdfFilePath);
			flag = true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return flag;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateLeaderRemark
	  * @param p_manage_id
	  * @param p_leader_remark
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#updateLeaderRemark(java.lang.String, java.lang.String) 
	  */
	public boolean updateLeaderRemark(String p_manage_id,String p_leader_remark){
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao paperdao= (PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			PaperBean paperBean = new PaperBean();
			paperBean.setP_manage_id(p_manage_id);
			paperBean.setP_leader_remark(p_leader_remark);
			((BaseDao)paperdao).update(paperBean, conn);
			
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
	  *     复写方法 updateUnAccInfo 退稿并记录退稿原因信息等
	  * @param p_manage_id
	  * @param p_unacc_user_id
	  * @param p_unacc_user_name
	  * @param p_unacc_remark
	  * @return 
	  * @see com.chinacreator.xtbg.core.paper.service.PaperService#updateUnAccInfo(java.lang.String, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public boolean updateUnAccInfo(String p_manage_id,String p_unacc_user_id,String p_unacc_user_name,String p_unacc_remark){
		Connection conn = null;
		boolean flag = false;
		PaperBean paperBean = null;
		try {
			Timestamp p_unacc_time= StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss");
			paperBean = new PaperBean();
			paperBean.setP_manage_id(p_manage_id);
			paperBean.setP_unacc_user_id(p_unacc_user_id);
			paperBean.setP_unacc_user_name(p_unacc_user_name);
			paperBean.setP_unacc_time(p_unacc_time);
			paperBean.setP_unacc_remark(p_unacc_remark);
			paperBean.setP_flag_id(PaperConstants.STATUS_UNACCEPT);
			paperBean.setP_rep_flag_id(PaperConstants.STATUS_UNACCEPT);
			paperBean.setP_flag_name("退稿");
			paperBean.setP_rep_flag_name("退稿");

			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao dao= (PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			((BaseDao)dao).update(paperBean, conn);//修改会议基本信息
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	
}

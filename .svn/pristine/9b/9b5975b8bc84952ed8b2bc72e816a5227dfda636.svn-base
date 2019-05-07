
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewInfoServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-19   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.review.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao;
import com.chinacreator.xtbg.tjy.review.entity.ReviewInfoBean;
import com.chinacreator.xtbg.tjy.review.service.ReviewInfoService;

/**
 *<p>Title:ReviewInfoServiceImpl.java</p>
 *<p>Description:评审记录管理业务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public class ReviewInfoServiceImpl implements ReviewInfoService{
	
	private static final Log LOG=LogFactory.getLog(ReviewInfoServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getReviewInfoBean
	  * @param it_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewInfoService#getReviewInfoBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getReviewInfoBean(String it_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			ReviewInfoDao daojson = (ReviewInfoDao)DaoImplClassUtil.getDaoImplClass("reviewInfoDaoImpl");
			viewMap = daojson.getReviewInfo(it_id, conn);
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
	  *     复写方法 insertOrUpdateReviewInfo
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewInfoService#insertOrUpdateReviewInfo(com.chinacreator.xtbg.tjy.review.entity.ReviewUserBean) 
	  */
	@Override
	public String insertOrUpdateReviewInfo(ReviewInfoBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//1:设置添加时间 r_creator_time
			bean.setR_creatortime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getR_creatortime()), "yyyy-MM-dd HH24:mi:ss"));
			//2.设置评审时间 r_reviewtime
			bean.setR_reviewtime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getR_reviewtime()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			ReviewInfoDao dao = (ReviewInfoDao)DaoImplClassUtil.getDaoImplClass("reviewInfoDaoImpl");
			if(StringUtil.nullOrBlank(bean.getR_id())){//insert
				bean.setR_id(StringUtil.getUUID());
				beanId = bean.getR_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getR_id();
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
	  *     复写方法 deleteReviewInfoByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewInfoService#deleteReviewInfoByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteReviewInfoByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
//		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReviewInfoDao dao = (ReviewInfoDao)DaoImplClassUtil.getDaoImplClass("reviewInfoDaoImpl");
			for (String beanId : ids) {
//				//判断该类型是否被引用
//				count = dao.isOsupplieTypeBean(conn, beanId);
//				if(count>0){
//					return "number";
//				}
				//删除该节点以及子节点
				dao.deleteReviewInfoById(conn, beanId);
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

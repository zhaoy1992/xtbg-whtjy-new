
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewUserServiceImpl.java
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
import com.chinacreator.xtbg.tjy.review.dao.ReviewUserDao;
import com.chinacreator.xtbg.tjy.review.entity.ReviewUserBean;
import com.chinacreator.xtbg.tjy.review.service.ReviewUserService;

/**
 *<p>Title:ReviewUserServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public class ReviewUserServiceImpl implements ReviewUserService{

	private static final Log LOG=LogFactory.getLog(ReviewUserServiceImpl.class);
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getReviewUserBean
	  * @param it_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewUserService#getReviewUserBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getReviewUserBean(String it_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			ReviewUserDao daojson = (ReviewUserDao)DaoImplClassUtil.getDaoImplClass("reviewUserDaoImpl");
			viewMap = daojson.getReviewUser(it_id, conn);
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
	  *     复写方法 insertOrUpdateReviewUser
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewUserService#insertOrUpdateReviewUser(com.chinacreator.xtbg.tjy.review.entity.ReviewUserBean) 
	  */
	@Override
	public String insertOrUpdateReviewUser(ReviewUserBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//1:设置时间F_creator_time
			bean.setRu_creatortime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getRu_creatortime()), "yyyy-MM-dd HH24:mi:ss"));
			conn = DbManager.getInstance().getTransactionConnection();
			ReviewUserDao dao = (ReviewUserDao)DaoImplClassUtil.getDaoImplClass("reviewUserDaoImpl");
			if(StringUtil.nullOrBlank(bean.getRu_id())){//insert
				bean.setRu_id(StringUtil.getUUID());
				beanId = bean.getRu_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getRu_id();
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
	  *     复写方法 deleteReviewUserByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.review.service.ReviewUserService#deleteReviewUserByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteReviewUserByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
//		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			ReviewUserDao dao = (ReviewUserDao)DaoImplClassUtil.getDaoImplClass("reviewUserDaoImpl");
			for (String beanId : ids) {
//				//判断该类型是否被引用
//				count = dao.isOsupplieTypeBean(conn, beanId);
//				if(count>0){
//					return "number";
//				}
				//删除该节点以及子节点
				dao.deleteReviewUserById(conn, beanId);
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

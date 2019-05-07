
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewInfoDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-19   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.review.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao;
import com.chinacreator.xtbg.tjy.review.entity.ReviewInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ReviewInfoDaoImpl.java</p>
 *<p>Description:评审记录管理dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public class ReviewInfoDaoImpl extends XtDbBaseDao implements ReviewInfoDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selReviewInfoList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao#selReviewInfoList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selReviewInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		ReviewInfoBean reviewinfobean= new ReviewInfoBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				reviewinfobean = (ReviewInfoBean) JSONObject.parseObject(parmjson, ReviewInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select  r_id,");
			sql.append("        r_creatortime, ");
			sql.append("        to_char(r_reviewtime,'yyyy-mm-dd') as r_reviewtime ,");
			sql.append("        r_orgname, ");
			sql.append("        r_content, ");
			sql.append("        r_userid, ");
			sql.append("        r_username ");
			sql.append("  from ta_oa_reviewinfo ");
			sql.append("  where 1=1");
			if(reviewinfobean!=null){
				//添加开始时间
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_creatorStime())) {
					sql.append(" and r_creatortime >= ").append(" to_date('").append(reviewinfobean.getR_creatorStime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//添加结束时间
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_creatorEtime())) { 
					sql.append(" and r_creatortime <= ").append(" to_date('").append(reviewinfobean.getR_creatorEtime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//评审开始时间
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_reviewStime())) {
					sql.append(" and r_reviewtime >= ").append(" to_date('").append(reviewinfobean.getR_reviewStime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//评审结束时间
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_reviewEtime())) { 
					sql.append(" and r_reviewtime <= ").append(" to_date('").append(reviewinfobean.getR_reviewEtime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//评审单位
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_orgname())) {
					sql.append(" and r_orgname like '%'||?||'%'");
					condition.add(reviewinfobean.getR_orgname());
				}
				//专家名称
				if (!StringUtil.nullOrBlank(reviewinfobean.getR_username())) {
					sql.append(" and r_username like '%'||?||'%'");
					condition.add(reviewinfobean.getR_username());
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getReviewInfo
	  * @param oftype_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao#getReviewInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getReviewInfo(String oftype_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select  r_id,");
		sql.append("        r_creatortime, ");
		sql.append("        to_char(r_reviewtime,'yyyy-mm-dd') as r_reviewtime ,");
		sql.append("        r_orgname, ");
		sql.append("        r_content, ");
		sql.append("        r_userid, ");
		sql.append("        r_username ");
		sql.append("  from ta_oa_reviewinfo ");
		sql.append(" where r_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), oftype_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteReviewInfoById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewInfoDao#deleteReviewInfoById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteReviewInfoById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_reviewinfo ");
		sql.append(" where r_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}

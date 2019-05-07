
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewUserDaoImpl.java
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
import com.chinacreator.xtbg.tjy.review.dao.ReviewUserDao;
import com.chinacreator.xtbg.tjy.review.entity.ReviewUserBean;
import com.frameworkset.common.poolman.PreparedDBUtil;


/**
 *<p>Title:ReviewUserDaoImpl.java</p>
 *<p>Description:专家库数Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public class ReviewUserDaoImpl extends XtDbBaseDao implements ReviewUserDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selReviewUserList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewUserDao#selReviewUserList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selReviewUserList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		ReviewUserBean reviewuserbean= new ReviewUserBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				reviewuserbean = (ReviewUserBean) JSONObject.parseObject(parmjson, ReviewUserBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select  ru_id,");
			sql.append("        ru_name, ");
			sql.append("        ru_type, ");
			sql.append("        ru_profess ");
			sql.append("  from ta_oa_review_user");
			sql.append("  where 1=1");
			if(reviewuserbean!=null){
				if (!StringUtil.nullOrBlank(reviewuserbean.getRu_name())) {
					sql.append(" and ru_name like '%'||?||'%'");
					condition.add(reviewuserbean.getRu_name());
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
	  *     复写方法 getReviewUser
	  * @param oftype_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewUserDao#getReviewUser(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getReviewUser(String oftype_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_review_user ");
		sql.append(" where ru_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), oftype_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteReviewUserById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.review.dao.ReviewUserDao#deleteReviewUserById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteReviewUserById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_review_user ");
		sql.append(" where ru_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}

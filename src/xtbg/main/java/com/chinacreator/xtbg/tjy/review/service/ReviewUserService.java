
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewUserService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-19   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.review.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.review.entity.ReviewUserBean;


/**
 *<p>Title:ReviewUserService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public interface ReviewUserService {
	/**
	*<b>Summary: </b>
	* getReviewUserBean(根据类型Id查询专家库信息)
	* @param ofus_id
	* @return
	 */
	public Map<String, String> getReviewUserBean(String it_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateReviewUser(增加和修改专家库信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateReviewUser(ReviewUserBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteReviewUserByIds(根据IDs 删除专家库信息)
	* @param ids
	* @return
	 */
	public String  deleteReviewUserByIds(String[] ids);
}

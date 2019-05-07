
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     KbmDocReceivedAO.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.kbm.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import java.sql.Connection;

/**
 *<p>Title:KbmDocReceiveDao.java</p>
 *<p>Description:体系文件接收人操作数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-1
 */
public interface KbmDocReceiveDao {
	
	/**
	*<b>Summary: </b>
	* queryKbmDocReceiveList(查询体系文件接收人浏览列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocReceiveList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* queryKbmDocNoReadList(查询体系文件未阅读列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocNoReadList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* queryKbmDocReadList(查询体系文件已阅读列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocReadList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	*<b>Summary: </b>
	* getTXWJManager(获取拥有体系文件管理员角色的用户)
	 */
	public String getTXWJManager();
	/**
	*<b>Summary: </b>
	* deleteNotice(根据id删除通知公告)
	 */
	public void deleteNotice(String k_doc_id,Connection conn) throws Exception;
}

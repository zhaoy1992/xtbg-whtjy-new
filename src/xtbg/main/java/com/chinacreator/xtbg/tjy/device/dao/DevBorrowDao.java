
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevborrowDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.device.entity.DevBorrowBean;
import com.chinacreator.xtbg.tjy.device.entity.DevChuzuBean;

/**
 *<p>Title:DevBorrowDao.java</p>
 *<p>Description:设备借用、归还数据库dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public interface DevBorrowDao {
	
	/**
	*<b>Summary: </b>
	* getDevBorrowInfo(根据id查询设备借用、归还信息)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevBorrowInfo(String t_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* selDevBorrowInfoList(查询设备借用、归还列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevBorrowInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 借用
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public void saveDevBorrowInfo(DevBorrowBean bean) throws Exception;
	/**
	 * 调拨
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public void updateDevDiaobo(String user_orgid,String user_orgname,String custos_userid,String custos_username,String id) throws Exception;
	/**
	 * 归还
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public void updateDevBorrowInfo(DevBorrowBean bean) throws Exception;

	/**
	*<b>Summary: </b>
	* getDevBorrowInfo(根据id查询设备借用、归还信息)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevTransferInfo(String t_id, Connection conn) throws Exception;
}

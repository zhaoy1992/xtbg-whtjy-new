
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevBorrowService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevBorrowBean;
import com.chinacreator.xtbg.tjy.device.entity.DevChuzuBean;


/**
 *<p>Title:DevBorrowService.java</p>
 *<p>Description:设备借用、归还业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public interface DevBorrowService {
	
	/**
	*<b>Summary: </b>
	* getDevBorrowInfo(根据id查询政府设备借用、归还信息)
	* @param t_id
	* @return Map
	 */
	public Map<String, String> getDevBorrowInfo(String t_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevTransferInfo(根据id查询政府设备出租、调拨信息)
	* @param t_id
	* @return
	 */
	public Map<String, String> getDevTransferInfo(String t_id);
	
	/**
	 * 借用,出租
	 * @return
	 * @throws Exception
	 */
	public boolean saveDevBorrowInfo(DevBorrowBean bean) throws Exception;
	/**
	 * 调拨
	 * @return
	 * @throws Exception
	 */
	public boolean updateDevDiaobo(String user_orgid,String user_orgname,String custos_userid,String custos_username,String id) throws Exception;
	/**
	 * 归还
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public boolean updateDevBorrowInfo(DevBorrowBean bean) throws Exception;

}

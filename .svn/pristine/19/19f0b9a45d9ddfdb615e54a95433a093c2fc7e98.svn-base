
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonHolderDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;

/**
 *<p>Title:PersonHolderDao.java</p>
 *<p>Description:人员持证管理Dao层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public interface PersonHolderDao {

	/**
	*<b>Summary: </b>
	* selPersonHolderList(查询人员信息列表)
	* @param directorybean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selPersonList(DirectoryBean directorybean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * getMsgCount(查询持证预警消息)
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getMsgCount(String userid) throws Exception;

	/**
	*<b>Summary: </b>
	* findPersonHolderList(查询人员持证管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findPersonHolderList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* findPersonHolderYujingList(查询人员持证管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findPersonHolderYujingList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getPersonHolder(根据id查询人员持证信息)
	* @param hold_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPersonHolder(String hold_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePersonHolderById(根据id删除人员持证信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePersonHolderById(Connection conn,String beanId)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* findTrainList(查询培训记录管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findTrainList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getTrainBean(根据id查询培训记录信息)
	* @param hold_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getTrainBean(String tr_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePersonHolderById(根据id删除培训记录信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteTrainBeanById(Connection conn,String beanId)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* selPersonHolderData(根据用户id查询该人员所有的持证信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonHolderData(String user_Id) throws Exception;
	
	/**
	*<b>Summary: </b>
	* selPersonTrainData(根据用户id查询该人员所有的持证培训记录信息)
	* @param conn
	* @param trainbean
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonTrainData(TrainBean trainbean) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* selPersonHolderYjToData(查询人员持证预警信息    用户导出人员预警信息)
	* @param personholder
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> selPersonHolderYjToData(PersonHolder personholder) throws Exception;
	/**
	*<b>Summary: </b>
	* selPersonTrainData(根据id查询该人员的持证信息数量)
	* @param hold_id
	* @return
	* @throws Exception
	 */
	public Integer getCountById(String hold_usesnid,String hold_name) throws Exception;
	/**
	*<b>Summary: </b>
	* selPersonTrainData(新增)
	* @param bean
	* @throws Exception
	 */
	public void insertHolder(PersonHolder bean,Connection conn) throws Exception;
	/**
	*<b>Summary: </b>
	* selPersonTrainData(修改)根据用户和持证项目更新
	* @param bean
	* @throws Exception
	 */
	public void updateHolder(PersonHolder bean,Connection conn) throws Exception;
	/**
	 * 根据主键id 修改
	 * @param bean
	 * @param conn
	 * @throws Exception
	 */
	public void updateHolder2(PersonHolder bean,Connection conn) throws Exception;
}

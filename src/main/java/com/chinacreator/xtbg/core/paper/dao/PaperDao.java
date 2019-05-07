package com.chinacreator.xtbg.core.paper.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.paper.entity.PaperBean;

/**
 *<p>Title:PaperDao.java</p>
 *<p>Description:信息报送dao层接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-11
 */
public interface PaperDao {
	

	
	/**
	*<b>Summary: </b>
	* updateReadStatusByUser(更新阅读状态--个人)
	* @param p_manage_id
	* @param userId
	* @return 
	*/
	public void updateReadStatusByUser(Connection conn,String p_manage_id,String userId) throws Exception;

	
	/**
	*<b>Summary: </b>
	* updateReadStatusByUnit(更新阅读状态--单位)
	* @param p_manage_id
	* @param unitId
	* @return 
	*/
	public void updateReadStatusByUnit(Connection conn,String p_manage_id,String unitId) throws Exception;
	/**
	*<b>Summary: </b>
	* savePaperSendAddByUnit(补发单位列表)
	* @param conn
	* @param map
	* @return
	* @throws Exception 
	*/
	public boolean savePaperSendAddByUnit(Connection conn,Map<String, String> map) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* savePaperSendAddByUser(补发个人列表)
	* @param conn
	* @param map
	* @return
	* @throws Exception 
	*/
	public boolean savePaperSendAddByUser(Connection conn,Map<String, String> map) throws Exception;
	

	/**
	*<b>Summary: </b>
	* deletePaperReceiveInfoBean4UnitByParams(删除单位接收信息)
	* @param conn
	* @param p_manage_id
	* @return
	* @throws Exception 
	*/
	public boolean deletePaperReceiveInfoBean4UnitByParams(Connection conn,String p_manage_id) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* deletePaperReceiveInfoBean4UserByParams(删除个人接收信息)
	* @param conn
	* @param p_manage_id
	* @return
	* @throws Exception 
	*/
	public boolean deletePaperReceiveInfoBean4UserByParams(Connection conn,String p_manage_id) throws Exception;
	/**
	*<b>Summary: </b>
	* savePaperReceiveInfoByUnit(保存信息发送的接收方明细--单位)
	* @param conn
	* @param map
	* @return
	* @throws Exception 
	*/
	public boolean savePaperReceiveInfoByUnit(Connection conn,Map<String, String> map) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* savePaperReceiveInfoByUser(保存信息发送的接收方明细--个人)
	* @param conn
	* @param map
	* @return
	* @throws Exception 
	*/
	public boolean savePaperReceiveInfoByUser(Connection conn,Map<String, String> map) throws Exception;

	
	/**
	*<b>Summary: </b>
	* queryPaperList(查询信息)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryPaperList(PaperBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selCountPaperList(查询信息报送统计)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selCountPaperList(PaperBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getPaperById(根据id查询信息报送表)
	* @param p_manage_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPaperById(String p_manage_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePaperById(根据id删除信息报送表)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePaperById(Connection conn,String beanId)throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* updatePaper2AccById(根据id批量设置为已采编)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception 
	*/
	public boolean updatePaper2AccByIds(Connection conn,String beanId,String flagId,String userId)throws Exception;

	
}

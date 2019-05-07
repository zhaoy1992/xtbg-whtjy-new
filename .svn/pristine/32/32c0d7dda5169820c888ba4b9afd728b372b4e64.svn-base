package com.chinacreator.xtbg.core.inspect.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:InspectManageDao.java</p>
 *<p>Description:督察督办管理数据库操作接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public interface InspectManageDao {
	/**
	 * 
	*<b>Summary: 根据条件查询督查督办任务信息</b>
	* @param bean 基本信息实例
	* @param page 分页信息实例
	* @param conn 数据库连接
	* @return  分页数据
	* @throws Exception 数据库操作异常
	 */
	public PagingBean findBaseInfoPageBean(Map<String,String> bean,
			PageInfoBean page, Connection conn) throws Exception;

	/**
	 * 
	*<b>Summary:查询所有分类信息 </b>
	* queryAllType()
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryAllType(Connection conn)
			throws Exception ;
	
	/**
	 * 
	*<b>Summary: 根据资源id，查询资源配置信息</b>
	* queryResourceConfig()
	* @param resourceId 资源id
	* @param conn
	* @return
	 * @throws Exception 
	 */
	public List<Map<String, String>> queryResourceConfig(String resourceId,
			Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary:插入督察督办单位接收人信息 </b>
	* @param infoId    任务id
	* @param receptId  接收id
	* @param userIds   用户id拼接字符串
	* @param conn      数据库连接对象
	* @throws Exception
	 */
	public void insertReceptUser(String infoId,String receptId, String userIds,
			Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary:根据任务id，查询各个单位的反馈状况 </b>
	* queryRecept()
	* @param map  查询条件
	* @param conn 数据库连接
	* @return
	* @throws Exception
	*/
	public List<Map<String, String>> queryRecept(String infoId,
			Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: 根据接收id查询接收人信息</b>
	* queryReceptUser()
	* @param receptIds 任务接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryReceptUser(String receptIds,
			Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: “任务通知查看”查询任务数据。根据任务接收人来查看数据</b>
	* findBaseInfoPageBean4recept()
	* @param bean
	* @param page
	* @param conn
	* @return
	* @throws Exception
	 */
	public PagingBean findBaseInfoPageBean4recept(Map<String,String> bean,
			PageInfoBean page, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: 查询回复信息</b>
	* queryListResponse()
	* @param receptId 接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListResponse(String receptId,
			Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selInspectCountList(督查事项统计查询)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selInspectCountList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 
	*<b>Summary:查询发牌的数据列表 </b>
	* @return 发牌数据列表
	 * @throws Exception 
	 */
	public PagingBean queryCardList(
			Map<String, String> condition, PageInfoBean page, Connection conn) throws Exception;
}

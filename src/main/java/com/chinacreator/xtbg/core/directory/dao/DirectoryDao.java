package com.chinacreator.xtbg.core.directory.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;

/**
 *<p>
 * Title:DirectoryDao.java
 * </p>
 *<p>
 * Description:名录管理dao层接口
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2012-2-16
 */
public interface DirectoryDao {

	/**
	 * 
	 *<b>Summary: 根据条件查询名录管理</b> findTypeList(请用一句话描述这个方法的作用)
	 * 
	 * @param typeBeanJson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findTypeList(DirectoryBean typeBeanJson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findTypeXCList( 根据条件查询薪酬管理)
	* @param typeBeanJson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findTypeXCList(DirectoryBean typeBeanJson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: 根据条件查询合同预警的列表</b>
	* findHetongList(请用一句话描述这个方法的作用)
	* @param typeBeanJson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findHetongList(DirectoryBean typeBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

	/**
	 * 
	 *<b>Summary: 根据用户ID获得名录管理</b> getTypeBeanById(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 * @param listtype
	 * @return
	 * @throws SQLException
	 */
	public DirectoryBean getTypeBeanById(String id, String listtype)
			throws SQLException;
	
	/**
	 * 
	*<b>Summary: 根据用户ID获得合同信息</b>
	* getHeTongBeanById(请用一句话描述这个方法的作用)
	* @param id
	* @return
	* @throws SQLException
	 */
	public HeTongBean getHeTongBeanById(String id) throws SQLException;

	/**
	 * 
	 *<b>Summary: 获取公共通讯录首字母查询相关信息</b> getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param orgoruserid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 管理员修改用户信息</b> updateUserinfo(请用一句话描述这个方法的作用)
	 * 
	 * @param userinfoBean
	 * @throws Exception
	 */
	public void updateUserinfo(UserinfoBean userinfoBean, HeTongBean heTongBean, Connection conn)
			throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateUserXCinfo(管理员修改用户薪酬信息)
	* @param userinfoBean
	* @param conn
	* @throws Exception
	 */
	public void updateUserXCinfo(UserinfoBean userinfoBean, Connection conn)
			throws Exception;

	/**
	 * 查询查询用户是否在ta_oa_userandsn表中就记录 <b>Summary: </b> queryuser(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @return 存在返回true,否则返回false
	 * @throws Exception
	 */
	boolean queryuser(String userid) throws Exception;

	/**
	 * 
	 *<b>Summary:往oa_userandsn中插入一条扩展记录 </b> insertuser(请用一句话描述这个方法的作用)
	 * 
	 * @param usreid
	 * @throws Exception
	 */
	void insertuser(String usreid) throws Exception;
	
	/**
	 * 查询查询用户是否在oa_hetong表中就记录 <b>Summary: </b> queryHetong(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @return 存在返回true,否则返回false
	 * @throws Exception
	 */
	boolean queryHetong(String userid) throws Exception;
	
	/**
	 * 
	 *<b>Summary:往oa_hetong中插入一条扩展记录 </b> insertHetong(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @throws Exception
	 */
	void insertHetong(String userid) throws Exception;
	
	/**
	 * 
	*<b>Summary: 根据人员id查询其配置的可查看的薪酬人员id</b>
	* queryPeizhiUserId(请用一句话描述这个方法的作
	* 用)
	* @param id
	* @return
	 */
	public String queryPeizhiUserId(String id) throws SQLException ;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateTopUserInfo(管理员修改首页顶部右上角【人员】用户信息)
	* @param userinfoBean
	* @param conn
	* @throws Exception
	 */
	public void updateTopUserInfo(UserinfoBean userinfoBean, Connection conn)
			throws Exception;
	/**
	 * 得到生日提醒列表
	 * @param typeBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getBirthdayList(DirectoryBean typeBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

}

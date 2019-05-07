package com.chinacreator.xtbg.core.personwork.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean;

/**
 * 
 *<p>
 * Title:PersonInfoDao.java
 * </p>
 *<p>
 * Description:通讯录管理dao接口
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-13
 */
public interface PersonInfoDao {
	/**
	 * 
	 *<b>Summary: 根据条件查询个人通讯录信息 </b>
	 * findPersonalAddressBookList(请用一句话描述这个方法的作用)
	 * 
	 * @param personSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findPersonalAddressBookList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException;

	
	/**
	 * 
	 *<b>Summary: 根据条件查询公共通讯录(有权限用户)信息</b>
	 * findPublicAddressBook4RoleuserList(请用一句话描述这个方法的作用)
	 * 
	 * @param personSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findPublicAddressBook4RoleuserList(
			PersonSearchBean personSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

	/**
	 * 
	 *<b>Summary: 查询人员基本信息</b> findPersonBaseInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param person_id
	 * @return
	 */
	public PersonInfoBean findPersonBaseInfo(String person_id)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:查询人员扩展信息集合 </b> findPersonExtraInfoList(请用一句话描述这个方法的作用)
	 * 
	 * @param personId
	 * @param type
	 * @return
	 */
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,
			String type) throws Exception;

	/**
	 * 
	 *<b>Summary: 保存人员基本信息</b> savePersonBaseInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param personInfoBean
	 * @param con
	 * @return
	 * @throws Exception
	 */
	public String savePersonBaseInfo(PersonInfoBean personInfoBean,
			Connection con) throws Exception;
	
	/**
	 * 
	 *<b>Summary: 保存人员扩展信息</b> savePersonExtraInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param person_id
	 * @param type
	 * @param personExtraInfoList
	 * @param con
	 * @throws Exception
	 */
	public void savePersonExtraInfo(String person_id, String type,
			List<PersonExtraInfoBean> personExtraInfoList, Connection con)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 删除人员信息</b> deletePersonInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param personids
	 * @param con
	 * @throws Exception
	 */
	public void deletePersonInfo(String personids, Connection con)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 保存人员分组信息</b> savePersonGroupInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param personids
	 * @param groupids
	 * @param con
	 * @throws Exception
	 */
	public void savePersonGroupInfo(String personids, String groupids,
			Connection con) throws Exception;

	/**
	 * 
	 *<b>Summary: 获得用户分组下拉框的数据</b> getGroupSelectHtml(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public String getGroupSelectHtml(String userid, String is_public) throws Exception;

	/**
	 * 
	 *<b>Summary: 获得orgid</b> getOrgNameByOrgId(请用一句话描述这个方法的作用)
	 * 
	 * @param orgid
	 * @return
	 * @throws Exception
	 */
	public String getOrgNameByOrgId(String orgid) throws Exception;

	/**
	 * 
	 *<b>Summary: 获取首字母查询相关信息</b> getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param orgoruserid
	 * @param infoType
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,
			String infoType) throws Exception;

	/**
	 * 
	 *<b>Summary: 获取公共通讯录首字母查询相关信息</b>
	 * getFirstCodeShowInfo4PublicAddress(请用一句话描述这个方法的作用)
	 * 
	 * @param orgoruserid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(
			String orgoruserid) throws Exception;

	/**
	 * 
	 *<b>Summary: 设置个人通讯录与名录的引用关系</b>
	 * setPersonalDirectoryRelationship(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @param directoryids
	 * @throws Exception
	 */
	public void setPersonalDirectoryRelationship(String userid,
			String directoryids, Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: 取消个人通讯录与名录的引用关系</b>
	 * cancelPersonalDirectoryRelationship(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @param directoryids
	 * @param con
	 * @throws Exception
	 */
	public void cancelPersonalDirectoryRelationship(String userid,
			String directoryids, Connection con) throws Exception;

	/**
	 * 
	 *<b>Summary: 获取当前用户已经设置的个人通讯录与名录的引用关系</b>
	 * getHasSetDirecttoryRelationship(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public String getHasSetDirecttoryRelationship(String userid)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 递归查询所有的机构ID</b> findOrgidList(请用一句话描述这个方法的作用)
	 * 
	 * @param orgid
	 * @return
	 */
	public List<PersonSearchBean> findOrgidList(String orgid)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 查询用户id是否存在</b> queryUser(请用一句话描述这个方法的作用)
	 * 
	 * @param username
	 * @return
	 */
	public int queryUser(String username) throws SQLException;

	/**
	 * 
	 *<b>Summary: 根据用户id查询用户</b> queryUser(请用一句话描述这个方法的作用)
	 * 
	 * @param username
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	public int queryUser(String username, Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary: 通过orgname查orgid</b> queryOrgId(请用一句话描述这个方法的作用)
	 * 
	 * @param orgname
	 * @return
	 */
	public String queryOrgId(String orgname) throws SQLException;

	/**
	 * 
	 *<b>Summary: 通过orgname查orgid</b> queryOrgId(请用一句话描述这个方法的作用)
	 * 
	 * @param orgname
	 * @return
	 */
	public String queryOrgId(String orgname, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 根据用户id判断用户是否添加了通讯录分组</b> isGroupExists(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @return 是否存在分组的标志 true：存在，false:不存在
	 * @throws Exception
	 */
	public boolean isGroupExists(String userId,String isPublic) throws Exception;

	/**
	 * 
	 *<b>Summary:查询顶级机构id </b> queryRootOrg(请用一句话描述这个方法的作用)
	 * 
	 * @return
	 * @throws SQLException
	 */
	public String queryRootOrg() throws SQLException;
	
	
	/**
	*<b>Summary: </b>
	* getPersonInfoBeanList(得到外部人员联系信息)
	* @param person_ids
	* @param conn
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getPersonInfoBeanList(String person_ids,
			Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary:获取存在数据的首字母 </b>
	* getFirstCodeShowInfo()
	* @param orgoruserid
	* @param infoType
	* @param isPublic
	* @return
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,
			String infoType,String isPublic) throws Exception ;
	
	/**
	 * 
	 *<b>Summary: 保存人员扩展信息,插入一条信息</b> 
	 * savePersonExtraInfo
	 * @param person_id
	 * @param type
	 * @param personExtraInfoList
	 * @param con
	 * @throws Exception
	 */
	public void savePersonExtraInfo(PersonExtraInfoBean personExtraInfoList, Connection con) throws Exception;
}

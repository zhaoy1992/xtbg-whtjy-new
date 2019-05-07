package com.chinacreator.xtbg.pub.personwork.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonSearchBean;

public interface PersonInfoDao {
	/**
	 * @Description 根据条件查询个人通讯录信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPersonalAddressBookList(PersonSearchBean personSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询公共通讯录(管理者)信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPublicAddressBook4ManagerInfoList(PersonSearchBean personSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询公共通讯录(有权限用户)信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPublicAddressBook4RoleuserList(PersonSearchBean personSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * 查询人员基本信息
	 * @param person_id
	 * @return
	 */
	public PersonInfoBean findPersonBaseInfo(String person_id);
	
	/**
	 * 查询人员扩展信息集合
	 * @param personId
	 * @param type 
	 * @return
	 */
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,String type);
	
	
	/**
	 * 保存人员基本信息
	 * @param personInfoBean
	 * @throws Exception
	 */
	public String savePersonBaseInfo(PersonInfoBean personInfoBean,Connection con) throws Exception;
	
	/**
	 * 保存人员扩展信息
	 * @param personExtraInfoList
	 * @throws Exception
	 */
	public void savePersonExtraInfo(String person_id,String type,List<PersonExtraInfoBean> personExtraInfoList,Connection con) throws Exception;
	
	/**
	 * 删除人员信息
	 * @param personids
	 */
	public void deletePersonInfo(String personids,Connection con) throws Exception;
	
	/**
	 * 保存人员分组信息
	 * @param personids
	 * @param groupids
	 * @throws Exception
	 */
	public void savePersonGroupInfo(String personids,String groupids,Connection con) throws Exception;
	
	/**
	 * 获得用户分组下拉框的数据
	 * @param userid
	 * @return
	 */
	public String getGroupSelectHtml(String userid)throws Exception ;
	
	/**
	 * 获得orgid
	 * @param orgid
	 * @return
	 * @throws Exception
	 */
	public String getOrgNameByOrgId(String orgid)throws Exception;
	
	/**
	 * 获取首字母查询相关信息
	 * @param orgid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid,String infoType) throws Exception;
	
	/**
	 * 获取公共通讯录首字母查询相关信息
	 * @param orgid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(String orgoruserid) throws Exception;
	
	/**
	 * 设置个人通讯录与名录的引用关系
	 * @param userid
	 * @param directoryids
	 * @throws Exception
	 */
	public void setPersonalDirectoryRelationship(String userid,String directoryids) throws Exception;
	
	
	
	/**
	 * 取消个人通讯录与名录的引用关系
	 * @param userid
	 * @param directoryids
	 * @throws Exception
	 */
	public void cancelPersonalDirectoryRelationship(String userid,String directoryids,Connection con) throws Exception;
	
	
	/**
	 * 获取当前用户已经设置的个人通讯录与名录的引用关系
	 * @param userid
	 * @return
	 * @throws Excetpion
	 */
	public String getHasSetDirecttoryRelationship(String userid) throws Exception;
	
	/**
	 * 递归查询所有的机构ID
	 * @param orgid
	 * @return List<PersonSearchBean>
	 */
	public List<PersonSearchBean> findOrgidList(String orgid);
	/**
	 * 查询用户id是否存在
	 * @param userid
	 * @return
	 */
	public int queryUser(String username);
	/**
	 * 通过orgname查orgid
	 * @param orgname
	 * @return
	 */
	public String queryOrgId(String orgname);
}

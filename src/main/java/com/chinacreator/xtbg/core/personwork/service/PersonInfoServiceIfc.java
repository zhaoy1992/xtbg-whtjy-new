package com.chinacreator.xtbg.core.personwork.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean;

/**
 * 
 *<p>Title:PersonInfoServiceIfc.java</p>
 *<p>Description:通讯录处理service</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-7
 */
public interface PersonInfoServiceIfc {
	
	/**
	 * 
	*<b>Summary: 保存人员信息</b>
	* savePersonInfo(请用一句话描述这个方法的作用)
	* @param baseinfoJson 基本信息json字符串
	* @param phoneVOList  电话
	* @param foxVOList    传真
	* @param emailVOList  邮件
	* @param qqVOList     QQ
	* @param birthVOList
	* @param companyVOList
	* @param positionVOList
	* @param addressVOList
	* @param websiteVOList
	* @return 人员主键
	* @throws Exception
	 */
	public String savePersonInfo(String baseinfoJson,String phoneVOList,
			String foxVOList,String emailVOList,String qqVOList,String birthVOList,
			String companyVOList,String positionVOList,String addressVOList,String websiteVOList);
	
	/**
	 * 
	*<b>Summary: 删除人员信息</b>
	* deletePersonInfo(请用一句话描述这个方法的作用)
	* @param personids
	* @param userid
	* @param directoryids
	* @throws Exception
	 */
	public boolean deletePersonInfo(String personids,String userid,String directoryids);
	
	/**
	 * 
	*<b>Summary: 保存人员分组信息</b>
	* savePersonGroupInfo(请用一句话描述这个方法的作用)
	* @param personids
	* @param groupids
	* @throws Exception
	 */
	public boolean savePersonGroupInfo(String personids,String groupids);
	
	/**
	 * 
	*<b>Summary: 根据用户id判断用户是否添加了通讯录分组</b> 
	* isGroupExists(请用一句话描述这个方法的作用)
	* @param userId  用户id
	* @return        是否存在分组的标志  true：存在，false:不存在
	 * @throws Exception 
	 */
	public boolean isGroupExist(String userId,String isPublic) ;
	/**
	 * 
	*<b>Summary: 根据id查询出当前用户所有的分组</b>
	* isGroupExists(请用一句话描述这个方法的作用)
	* @param userId  用户id
	* @param is_public  是否公共通讯录
	* @return  分组信息bean集合
	 * @throws Exception 
	 */
	public List<PGroupBean> queryGroup(String userId, String is_public);
	/**
	 * 
	*<b>Summary: 根据id查询存在数据的首字母信息</b>
	* getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	* @param userId 用户id
	* @return List<ListShowUtilBean>数据集合
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String userId);
	/**
	 * 
	*<b>Summary: 根据id查询存在数据的首字母信息</b>
	* getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	* @param userId 用户id
	* @return List<ListShowUtilBean>数据集合
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String userId,String isPublic);
	
	/**
	 * 
	*<b>Summary: 获得用户的扩展信息</b>
	* findPersonExtraInfoList(请用一句话描述这个方法的作用)
	* @param personId 用户id
	* @param type     类型
	* @return
	 */
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,
			String type);
	
	/**
	 * 
	*<b>Summary: 获得用户分组下拉框的数据</b>
	* getGroupSelectHtml(请用一句话描述这个方法的作用)
	* @param userid
	* @return
	* @throws Exception
	 */
	public String getGroupSelectHtml(String userId, String is_public);
	
	/**
	 * 
	*<b>Summary: 查询人员基本信息</b>
	* findPersonBaseInfo(请用一句话描述这个方法的作用)
	* @param person_id
	* @return
	 */
	public PersonInfoBean findPersonBaseInfo(String personId);
	
	/**
	 * 
	*<b>Summary: 根据分组id查询分组信息</b>
	* queryGroup(请用一句话描述这个方法的作用)
	* @param groupId  通讯录分组的id
	* @return  分组对象
	* @throws SQLException
	 */
	public PGroupBean queryGroupByGroupId(String groupId);
	/**
	 * 
	 *<b>Summary:查询顶级机构id </b> queryRootOrg(请用一句话描述这个方法的作用)
	 * 
	 * @return
	 * @throws SQLException
	 */
	public String queryRootOrg();
	/**
	 * 
	 *<b>Summary: </b> queryRootOrg(请用一句话描述这个方法的作用)
	 * 
	 * @param orgId
	 * @return
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(String orgId);
	/**
	 * 
	*<b>Summary: 设置个人通讯录与名录的引用关系</b>
	* setPersonalDirectoryRelationship(请用一句话描述这个方法的作用)
	* @param userid
	* @param directoryids
	* @throws Exception
	 */
	public boolean setPersonalDirectoryRelationship(String userid,String directoryids);
	
	
	/**
	*<b>Summary: </b>
	* getPersonInfoBeanList(得到外部人员联系信息)
	* @param person_ids
	* @return 
	*/
	public List<Map<String, String>> getPersonInfoBeanList(String person_ids);
}

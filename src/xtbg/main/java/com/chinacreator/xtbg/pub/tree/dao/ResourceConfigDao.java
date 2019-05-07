package com.chinacreator.xtbg.pub.tree.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.tree.entity.AreaBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceConfigBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceRoleResultInfoBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean;

public interface ResourceConfigDao {
	/**
	 * delResourceConfig 删除资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 */
	public void delResourceConfig(ResourceConfigBean resourceConfigBean) throws Exception;
	
	/**
	 * insertResourceConfig 插入资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 * configContent 配置的内容
	 * configType 配置类型   1：单位,2:人员,3..
	 */
	public void insertResourceConfig(ResourceConfigBean rscBean, String configContent, String configType) throws Exception;
	
	
	/**
	 * 查询机构对应的人
	 * @param orgid
	 * @param resourceid
	 * @return List类型
	 */
	List<ResourceRoleUserBean> queryOrginUserList (String orgid, String resourceType ,String userid)throws Exception;
	/**
	 * 查询机构对应的人
	 * @param orgid
	 * @param resourceid
	 * @return List类型
	 */
	List<ResourceRoleUserBean> queryOrginUserList1 (String orgid, String resourceid ,String userid)throws Exception;

	/**
	 *	查询所有资源
	 * @return list
	 */
	List<ResourceConfigBean> queryResource();
	
	/**
	 *  查询每个机构下人员
	 * @return list
	 */
	List<ResourceConfigBean> queryOrgUser(String orgId);
	
	/**
	 * 查询人对应的机构
	 * 
	 */
	ResourceRoleUserBean queryUserMatchOrg(String userId);
	
	
	/**
	 * 机构配置回选查询
	 */
	List<String> querybackchoose(String rescourceId,String orgId);
	
	
	/**
	 * 获取权限资源完整信息bean
	 *  根据资源标示  例：信息报送大模块为0001
	 * 资源类型标示  例：信息上报小模块为0001
	 * 资源配置类型  例：单位1，用户2，参看ResourceConfigType
	 * 资源配置类型id  例：单位id 或  用户id （这里是需要配置权限的单位或用户）
	 * 配置详细类型  例：单位id 或 用户id（这里是给上面指定的单位或用户配置的资源,可选项 ,没有则查两者的合集）
	 * @param resourceRoleBaseBean
	 * @return ResourceRoleResultInfoBean
	 * @throws Exception
	 */
	public ResourceRoleResultInfoBean getResourceResultInfoByRoleConfig(String resouresid,String userid) throws Exception;
	
	
	/**
	 * 查询父机构
	 * 
	 */
	ResourceRoleUserBean queryParentOrg(String orgId);
	
	/**
	 * 查询用户密码是否正确
	 * @param username
	 * @return
	 */
	boolean isPwdTrue(String username,String pwd)throws Exception;
	

	/**
	 * 是否为待审核用户
	 * @return
	 * @throws Exception
	 */
	boolean unaudited(String username) throws Exception;
}

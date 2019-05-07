package com.chinacreator.xtbg.pub.core.dao;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.core.entity.OrgTypeBean;

/**
 *<p>Title:OrgTypeDaoImpl.java</p>
 *<p>Description:机构类型事务接口</p> 
 *<p>Company:湖南科创</p>
 *@author 李义
 *@version 1.0
 *2012-1-31
 */
public interface OrgTypeDao {

	/**
	 * 获得所有机构类型
	 * @return
	 */
	public List<OrgTypeBean> getOrgType() throws SQLException;
	
	/**
	 * @Description 根据条件查询机构类型信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findOrgTypeList(OrgTypeBean beanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加机构类型信息
	 * @param entity 机构类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOrgType(OrgTypeBean entity) throws SQLException;
	
	/**
	 * @Description  删除机构类型信息
	 * @param delIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delOrgType(String delIds) throws SQLException;
	
	/**
	 * @Description 修改机构类型信息
	 * @param entity 机构类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateOrgType(OrgTypeBean entity) throws SQLException;
	
	/**
	 * @Description 根据ID获得机构类型信息
	 */
	public OrgTypeBean getOrgTypeBeanById(String id) throws SQLException;

	/**
	 * 根据ID串修改机构类型状态
	 * @param ids
	 * @return
	 * @throws SQLException 
	 */
	public void changeOrgTypeState(String ids,String state) throws SQLException;

}

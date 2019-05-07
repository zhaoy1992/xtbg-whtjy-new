package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.sql.SQLException;


import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean;

/**
 *<p>Title:OfficeEquipmentTypeDao.java</p>
 *<p>Description:办公设备类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-3-7
 */
public interface OfficeEquipmentTypeDao {

	/**
	 * @Description 根据条件查询公告信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(OfficeEquipmentTypeBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加办公设备类型
	 * @param typeBean 办公设备类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(OfficeEquipmentTypeBean oeBean) throws SQLException;
	
	/**
	 * @Description  删除办公设备类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException;
	
	/**
	 * @Description 修改办公设备类型
	 * @param typeBean 办公设备类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(OfficeEquipmentTypeBean typeBean) throws SQLException;
	
	/**
	 * @Description 根据用户ID获得办公设备类型
	 * @param typeBean 办公设备类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public OfficeEquipmentTypeBean getTypeBeanById(String id) throws SQLException;
	/**
	 * 查询办公室设备库存  根据类型ID
	 * @param typeId
	 * @return
	 */
	public boolean findEqStockByTypeId(String typeId) throws Exception;
	/**
	 * @Description 根据名称获得办公室设备类型
	 * @param typeBean 办公室设备Bean
	 * @return OfficeEquipmentTypeBean
	 * @throws SQLException 
	 */
	public boolean findEquipmentTypeByName(OfficeEquipmentTypeBean typeBean) throws SQLException;
	

}

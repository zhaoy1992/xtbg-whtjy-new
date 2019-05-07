package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.sql.SQLException;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean;

/**
 *<p>Title:OfficeConsumeTypeDao.java</p>
 *<p>Description:易耗品类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public interface OfficeConsumeTypeDao {

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
	public PagingBean findTypeList(OfficeConsumeTypeBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加易耗品类型
	 * @param typeBean 易耗品类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(OfficeConsumeTypeBean oeBean) throws SQLException;
	
	/**
	 * @Description  删除易耗品类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException;
	
	/**
	 * @Description 修改易耗品类型
	 * @param typeBean 消耗品类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(OfficeConsumeTypeBean typeBean) throws SQLException;
	/**
	 * @Description 根据用户ID获得易耗品类型
	 * @param typeBean 易耗品类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public OfficeConsumeTypeBean getTypeBeanById(String id) throws SQLException;
	
	/**
	 * @Description 根据名称获得易耗品类型
	 * @param typeBean 易耗品类型Bean
	 * @return OfficeConsumeTypeBean
	 * @throws SQLException 
	 */
	public boolean findTypeBeanByName(OfficeConsumeTypeBean typeBean) throws SQLException;
	
	/**
	 * @Description 根据类型ID查询易耗品库信息
	 * @param id  类型ID
	 * @return boolean
	 * @throws Exception 
	 */
	public boolean findConByTypeId(String id) throws Exception;

}

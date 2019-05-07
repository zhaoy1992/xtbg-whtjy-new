package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean;

/**
 *<p>Title:OfficeStockDao.java</p>
 *<p>Description:办公室库存类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-3-7
 */
public interface OfficeStockDao {
	/**
	 * @Description 根据条件查询设备库存信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(OfficeStock officeStock, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加办公品设备库存信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(List<OfficeStock> officeStocks) throws Exception ;
	
	/**
	 * @Description 根据用户ID获得设备办公品库存信息
	 * @param typeBean 设备库存信息Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public OfficeStock getTypeBeanById(String id) throws SQLException;
	
	/**
	 * @Description 查找办公品库存明细信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAllEqList(OfficeStocklistBean officeStocklistBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description  删除办公设备库存信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delEqStock(String userIds) throws SQLException;
	
	
}

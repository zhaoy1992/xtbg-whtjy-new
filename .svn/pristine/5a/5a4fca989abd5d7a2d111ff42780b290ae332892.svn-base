package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.ConSumeStockListBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock;

/**
 *<p>Title:ConsumeStockDao.java</p>
 *<p>Description:易耗品类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-3-7
 */
public interface ConsumeStockDao {
	/**
	 * @Description 添加易耗品信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addConSumOe(List<OfficeConsumStock> officeConsumStock) throws Exception ;
	
	/**
	 * @Description 查找易耗品信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findSnmEqList(OfficeConsumStock officeConsumStock, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * @Description 查找易耗品库存明细信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAllList(ConSumeStockListBean officeConsumStock, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description  删除易耗品库存信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delSumEqStock(String userIds) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryEqueryOfficeconstock(查询相同的OfficeConsumStock，除了数量、备注和说明不同之外,如果存在返回OfficeConsumStock，否则返回null)
	* @param bean
	* @return
	 */
	public OfficeConsumStock  queryEqueryOfficeconstock(OfficeConsumStock bean) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateOfficeconstocks(批量更新易耗品库存信息)
	* @param officeConsumStock
	* @return
	* @throws Exception
	 */
	public boolean updateOfficeconstocks(List<OfficeConsumStock> officeConsumStock,Connection conn) throws Exception ;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOfficeconstocks(批量插入易耗品库存信息)
	* @param officeConsumStock
	* @return
	* @throws Exception
	 */
	public boolean insertOfficeconstocks(List<OfficeConsumStock> officeConsumStock,Connection conn) throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* insertConstocklist(批量插入易耗品库存明细)
	* @param officeConsumStock
	* @return
	* @throws Exception
	 */
	public boolean insertConstocklist(List<OfficeConsumStock> officeConsumStock,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOfficeConsumStockById(根据id查询易耗品信息)
	* @param stock_id
	* @return
	 */
	public OfficeConsumStock queryOfficeConsumStockById(String stock_id);
}

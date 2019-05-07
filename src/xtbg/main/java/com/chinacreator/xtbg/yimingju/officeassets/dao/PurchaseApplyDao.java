package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;

/**
 *<p>Title:OfficeEquipmentTypeDao.java</p>
 *<p>Description:采购申请dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public interface PurchaseApplyDao {

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
	public PagingBean findTypeList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加采购申请类型
	 * @param typeBean 采购申请类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(PurchaseApplyBean oeBean,ArrayList<OrderGoods> orders) throws Exception;
	
	/**
	 * @Description  删除采购申请类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException;
	
	/**
	 * @Description  删除物品信息类型
	 * @param id
	 * @param goodId
	 * @throws SQLException 
	 */
	public void deleteGoods(String id) throws SQLException;
	
	/**
	 * @Description 修改采购申请类型
	 * @param typeBean 采购申请类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(PurchaseApplyBean oeBean,ArrayList<OrderGoods> orders) throws SQLException,Exception;

	/**
	*<b>Summary: </b>
	* setDetailApproval(申请单采购息类型)
	* @param oeBean  申请物品bena
	* @param orders  物品列表bean
	* @throws SQLException
	 */
	public void setDetailApproval(PurchaseApplyBean oeBean,ArrayList<OrderGoods> orders) throws SQLException,Exception;
	
	/**
	 * @Description 根据用户ID获得采购申请类型
	 * @param typeBean 采购申请类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public PurchaseApplyBean getTypeBeanById(String id) throws SQLException;
	
	/**
	 * @Description 根据用户ID获得物品信息类型
	 * @param typeBean 物品信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public ArrayList<OrderGoods> getGoodsBeanById(String id) throws SQLException;
	
	
	/**
	 * @Description 根据物品信息获得类型信息
	 * @param typeBean     类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public OrderGoods getGoodsBeanById(String id, String goodId) throws SQLException;

}

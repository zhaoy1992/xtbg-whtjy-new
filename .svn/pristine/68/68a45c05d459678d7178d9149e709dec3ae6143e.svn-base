package com.chinacreator.xtbg.yimingju.officeassets.service;

import java.sql.SQLException;
import java.util.ArrayList;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;

/**
 *<p>Title:PurchaseApplyServiceIfc.java</p>
 *<p>Description:采购申请单接口类</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-3-7
 */
public interface PurchaseApplyServiceIfc {
	
	/**
	 * @Description  保存采购申请单管理信息
	 * @param paramjosn  采购申请单数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean saveOe(PurchaseApplyBean purchaseApplyBean,ArrayList<OrderGoods> orders);
	
	/**
	 * @Description  修改采购申请单管理信息
	 * @param paramjosn  修改申请单数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateOe(PurchaseApplyBean purchaseApplyBean,ArrayList<OrderGoods> orders);
	
	/**
	 * @Description  删除物品信息管理信息
	 * @param id     申请对象ID
	 * @param goodId 物品管理ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean deleteOe(String id);
	
	/**
	 * @Description  根据采购申请单ID获得采购申请单管理对象
	 * @param id  采购申请单ID
	 * @return  ContentBean 采购申请单对象
	 * @exception 
	 */
	public PurchaseApplyBean getOeBeanById(String id);
	
	/**
	 * @Description 根据用户ID获得物品信息类型
	 * @param typeBean 物品信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public ArrayList<OrderGoods> getGoodsBeanById(String id) throws SQLException;
	
}

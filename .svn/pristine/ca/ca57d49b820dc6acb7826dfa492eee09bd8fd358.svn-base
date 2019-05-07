package com.chinacreator.xtbg.yimingju.officeassets.service.impl;

import java.util.ArrayList;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApplyDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;
import com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc;

/**
 *<p>Title:PurchaseApplyServiceImpl.java</p>
 *<p>Description:采购申请实现类</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-3-1
 */
public class PurchaseApplyServiceImpl implements PurchaseApplyServiceIfc{
	
	public static final Logger logger = Logger.getLogger(PurchaseApplyServiceImpl.class.getName());
	/**
	 * @Description  保存采购申请单管理信息
	 * @param paramjosn  采购申请单数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean saveOe(PurchaseApplyBean purchaseApplyBean,ArrayList<OrderGoods> orders){
		try {
			PurchaseApplyDao dao = (PurchaseApplyDao) DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
			dao.addOe(purchaseApplyBean,orders);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  修改采购申请单管理信息
	 * @param paramjosn  修改申请单数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateOe(PurchaseApplyBean purchaseApplyBean,ArrayList<OrderGoods> orders){
		try {
			PurchaseApplyDao dao = (PurchaseApplyDao) DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
			dao.updateType(purchaseApplyBean,orders);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	/**
	 * @Description  根据采购申请单ID获得采购申请单对象
	 * 
	 * @param id  采购申请单ID
	 * @return  TypeBean 采购申请单对象
	 * @exception 
	 */
	public PurchaseApplyBean getOeBeanById(String id) {
		PurchaseApplyBean TypeBean = null;
		try {
			PurchaseApplyDao dao = (PurchaseApplyDao)DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
			TypeBean = dao.getTypeBeanById(id);
		} catch (Exception e) {
			logger.info(e.getMessage());
		}
		return TypeBean;
	}
	
	/**
	 * @Description  根据采购申请单ID获得物品信息对象
	 * 
	 * @param id  采购申请单ID
	 * @return  TypeBean 采购申请单对象
	 * @exception 
	 */
	public ArrayList<OrderGoods> getGoodsBeanById(String id) {
		ArrayList<OrderGoods> TypeBean = null;
		try {
			PurchaseApplyDao dao = (PurchaseApplyDao)DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
			TypeBean = dao.getGoodsBeanById(id);
		} catch (Exception e) {
			logger.info(e.getMessage());
		}
		return TypeBean;
	}
	
	/**
	 * @Description  根据采购申请单ID和物品ID 
	 * 
	 * @param id  采购申请单ID
	 * @return  TypeBean 采购申请单对象
	 * @exception 
	 */
	public boolean deleteOe(String id) {
		try {
			PurchaseApplyDao dao = (PurchaseApplyDao)DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
			dao.deleteGoods(id);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}
	
	
	
	
	
}

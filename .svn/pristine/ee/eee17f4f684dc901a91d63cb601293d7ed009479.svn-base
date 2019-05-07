package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;

/**
 *<p>Title:PurchaseApprovalRoolDao.java</p>
 *<p>Description:采购申请处室审批dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public interface PurchaseApprovalRoolDao {
	/**
	 * @Description 根据条件查询处室等待审批信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findWaitList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * @Description 根据条件查询处室已审批信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAlreadyList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询已采购的清单
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findDetailAlreadList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	/**
	 * 
	*<b>Summary: </b>
	* queryGoods(请用一句话描述这个方法的作用)
	* @return
	 */
	public List<Map<String, String>> queryGoods() throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* querykc(查询库存是否足够)
	* @return
	 */
	public String querykc(String id,String num) throws Exception;
}

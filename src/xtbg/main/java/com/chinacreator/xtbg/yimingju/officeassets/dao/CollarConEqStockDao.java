package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.CollarConEqBean;
/**
 *<p>Title:CollarConEqStockDao.java</p>
 *<p>Description:易耗品领用类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public interface CollarConEqStockDao {
	/**
	 * @Description 根据条件查询领用信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(CollarConEqBean collarConEqBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 领用信息添加
	 * @param collarBean
	 * @return
	 */
	public void addToBean(List<CollarConEqBean> collarConEqBean) throws Exception;
	
	/**
	 * 修改领用易耗品库存信息
	 * @param collarBean
	 * @return
	 */
	public void updateConEqStockBean(List<CollarConEqBean> collarConEqBean) throws Exception;
	
}

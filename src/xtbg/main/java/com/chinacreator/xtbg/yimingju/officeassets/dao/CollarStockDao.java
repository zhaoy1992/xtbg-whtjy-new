package com.chinacreator.xtbg.yimingju.officeassets.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean;

/**
 *<p>Title:CollarStockDao.java</p>
 *<p>Description:领用类型dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-11-5
 */
public interface CollarStockDao {
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
	public PagingBean findTypeList(CollarBean collarBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 领用办公室设备信息添加
	 * @param collarBean
	 * @return
	 */
	public void addToBean(List<CollarBean> collarBean) throws Exception;
	
	/**
	 * 修改领用办公室库存信息
	 * @param collarBean
	 * @return
	 */
	public void updateStockBean(List<CollarBean> collarBeans) throws Exception;
	
	/**
	 * 查找领用办公室库存信息
	 * @param collarBean
	 * @return
	 */
	public CollarBean findStockBean(CollarBean collarBean) throws Exception;
	
	/**
	 * 删除办公设备领用信息
	 * @param collarBean
	 * @throws Exception
	 */
	public void deleteStockApply(List<CollarBean> collarBean) throws  Exception;
	
	
}

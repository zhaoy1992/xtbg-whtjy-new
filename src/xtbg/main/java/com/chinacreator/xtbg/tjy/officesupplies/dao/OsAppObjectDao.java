package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean;

/**
 * 
 *<p>Title:OsAppObjectDao.java</p>
 *<p>Description:处理添加入计划表的物品数据DAO层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public interface OsAppObjectDao {
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppObject(根据计划表id查询出物品列表)
	* @param t_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsAppObject(根据计划表id删除物品)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteOsAppObject(String t_id,Connection conn) throws Exception;
	/**
	 * 得到申购物品清单列表
	 * @param objectBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getObjectList(OsAppObjectBean objectBean,String sortName, String sortOrder, long offset, int maxPagesize)throws Exception; 
	/**
	 * 得总价总数
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public OsAppObjectBean getCountData(OsAppObjectBean bean,Connection conn)throws Exception;
	/**
	 * 根据申请表Id查物品清单
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getItemByID(String ids,Connection conn)throws Exception; 
	
	public OsAppObjectBean getCount(OsAppObjectBean bean,Connection conn)throws Exception;

}

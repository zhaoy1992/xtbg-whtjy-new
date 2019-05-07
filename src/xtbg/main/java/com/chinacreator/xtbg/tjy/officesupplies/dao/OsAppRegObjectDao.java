package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;

/**
 * 申领物品处理
 * @author 王淑滨
 *
 */
public interface OsAppRegObjectDao {
	/**
	 * 得到物品出库列表清单
	 * @param objectBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getObjectList(OsAppRegObjectBean objectBean,String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 改变申领物品出库状态
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean changeItem(OsAppRegYhpBean bean,Connection conn)throws Exception;
	/**
	 * 得个人申领物品清单
	 * @param objectBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getMyObjectList(OsAppRegObjectBean objectBean,String sortName,String sortOrder,long offset,int maxPagesize)throws Exception;
	/**
	 * 根据部门统计申领物品清单
	 * @param objectBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getListByOrg(OsAppRegObjectBean objectBean,String sortName,String sortOrder,long offset,int maxPagesize)throws Exception;
}

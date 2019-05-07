package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;

/**
 * 申领登记处理
 * @author 王淑滨
 *
 */
public interface OsAppRegYhpDao {
	/**
	 * 得申领表列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAppList(OsAppRegYhpBean bean,String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 根据id得申领信息
	 * @param bean
	 * @return
	 */
	public OsAppRegYhpBean getByID(String id,Connection conn)throws Exception;
	/**
	 * 改变出库状态
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public boolean changeState(OsAppRegYhpBean bean,Connection conn)throws Exception;
}

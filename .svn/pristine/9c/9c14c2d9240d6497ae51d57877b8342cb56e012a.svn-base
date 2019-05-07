package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;

/**
 * 固定资产使用历史dao
 * @author 王淑滨
 *
 */
public interface OsAccountHistoryDao {
	/**
	 * 得到使用历史列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getAccountHistoryList(OsAccountHistoryBean bean, String sortName,String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 新增使用历史记录
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean insertAccountHistory(OsAccountHistoryBean bean,Connection conn)throws Exception;
}

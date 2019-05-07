package com.chinacreator.xtbg.tjy.officesupplies.service;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;

/**
 * 使用记录service接口
 * @author 王淑滨
 *
 */
public interface OsAccountHistoryService {
	/**
	 * 新增使用记录
	 * @param bean
	 * @return
	 */
	public boolean insertHisetory(OsAccountHistoryBean bean);

}

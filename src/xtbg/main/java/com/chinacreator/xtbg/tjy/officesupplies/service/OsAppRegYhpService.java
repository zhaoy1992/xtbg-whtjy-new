package com.chinacreator.xtbg.tjy.officesupplies.service;

import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean;

public interface OsAppRegYhpService {
/**
 * getbyid
 * @param bean
 * @return
 */
	public OsAppRegYhpBean getById(String id);
	/**
	 * 改变出库状态
	 * @param bean
	 * @return
	 */
	public boolean changeState(OsAppRegYhpBean bean);
}

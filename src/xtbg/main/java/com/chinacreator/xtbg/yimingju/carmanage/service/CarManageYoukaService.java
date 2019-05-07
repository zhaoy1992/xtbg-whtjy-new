package com.chinacreator.xtbg.yimingju.carmanage.service;

import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean;


/**
 * 油卡service
 * @author 王淑滨
 *
 */
public interface CarManageYoukaService {
	/**
	 * getByID
	 * @param id
	 * @return
	 */
	public CarManageYoukaBean getByID(String id);
	/**
	 * 登记发放
	 * @param bean
	 * @return
	 */
	public boolean update(CarManageYoukaBean bean);
}

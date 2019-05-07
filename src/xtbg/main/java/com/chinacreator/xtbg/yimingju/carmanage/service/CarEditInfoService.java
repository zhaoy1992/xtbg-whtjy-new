package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.List;

import com.chinacreator.xtbg.yimingju.carmanage.entity.CarEditInfoBean;

public interface CarEditInfoService {
	
	/**
	 * 车辆维修内容
	 * @param bean
	 * @return
	 */
	public List<CarEditInfoBean> list(CarEditInfoBean bean);
	
	/**
	 * 添加维修内容
	 * @param bean
	 * @return
	 */
	public boolean insert(CarEditInfoBean bean);
	
	/**
	 * 删除维修内容
	 * @param bean
	 * @return
	 */
	public boolean delete(CarEditInfoBean bean);
}

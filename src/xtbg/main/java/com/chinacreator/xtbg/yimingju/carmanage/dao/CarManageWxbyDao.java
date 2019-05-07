package com.chinacreator.xtbg.yimingju.carmanage.dao;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageWxbyBean;


public interface CarManageWxbyDao {
	/**
	 * @Description 根据条件查询车辆维修记录 
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findCarManageWxbyInfoList(CarManageWxbyBean carManageWxbyBean, String sortName, String sortOrder, long offset, int maxPagesize);
	/**
	 * @Description 保存车辆维修记录 
	 */
	public boolean saveCarWxInfo(CarManageWxbyBean carManageWxbyBean);
	public CarManageWxbyBean findCarWxInfo(String Id) ;
	public boolean carWxInfoPass(String Id,String passCase,String sp_yj);
	public boolean carWxInfoNoPass(String Id,String passCase,String sp_yj);
	public boolean carWxInfosjfy(String Id,String sjfy);
}

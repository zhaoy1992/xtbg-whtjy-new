package com.chinacreator.xtbg.yimingju.carmanage.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean;

/**
 * 车辆管理车辆申请Dao
 * @author haiyun
 *
 */
public interface CarManageApplyinfoDao {
	/**
	 * @Description 根据条件查询车辆申请记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findCarManageApplyinfoList(CarManageApplyinfoSearchBean carManageApplyinfoSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	/*
	 * 添加时间2013-4-24
	 * 添加人： tl
	 * 获取派车审批中的数据列表信息
	 * */
	public List<CarManageApplyinfoBean> getCarManageApplyinfoBeanInfoList();
	/**
	 * @Description 根据条件查询车辆申请记录 已经派车
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findCarManageApplyinfoYpcList(CarManageApplyinfoSearchBean carManageApplyinfoSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * 保存-车辆管理申请信息
	 * @param baseinfoJson
	 * @return apply_id
	 */
	public String saveCarManageApplyinfo(CarManageApplyinfoBean carManageApplyinfoBean,Connection con);
	
	/**
	 * 根据车辆管理申请信息ID获得基本信息
	 * @param apply_id
	 * @return CarManageApplyinfoBean 车辆申请信息
	 */
	public CarManageApplyinfoBean findCarManageApplyinfoByApplyID(String apply_id);
	
	/**
	 * 根据车辆申请信息ID更新State 
	 * @param apply_id
	 * @return true or false
	 */
	public boolean updateCarManageApplyStateByApplyID(CarManageApplyinfoBean CarManageApplyinfoBean);
	
	/**
	 * 根据车辆申请信息ID更新已派车State 
	 * @param apply_id
	 * @return true or false
	 */
	public boolean updateCarManageApplyYpendStateByApplyID(CarManageApplyinfoBean CarManageApplyinfoBean,Connection con);
	
	
	public boolean addCarInfo(String apply_id,String car_id);
	/**
	 * 
	*<b>Summary: </b>    谭力  添加   2013-4-27
	* delCarCheckChange(做派车判断的提示问题 )
	* @param apply_id   标记 
	* @param selectCar_num   要派的车
	* @param doPCOrHCId   派车列表中还是回车列表中的标示     查派车还是回车  1派车 2回车
	 */
	public String doCheckPC(String apply_id,String selectCar_num,String doPCOrHCId);
	/**
	 * 
	*<b>Summary: </b>   谭力  添加   2013-5-2
	* getAllHCInfo(拿到所有回车登记中的车辆)
	* @return
	 */
	public List<CarManageApplyinfoBean> getAllHCInfo();
}

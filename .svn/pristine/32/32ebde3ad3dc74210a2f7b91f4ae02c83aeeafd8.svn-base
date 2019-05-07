package com.chinacreator.xtbg.yimingju.carmanage.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;

/**
 * 车辆信息interface
 * 
 * @author haiyun
 * 
 */
public interface CarManageCarDao {
	/**
	 * 根据车辆主键CarID 获得车辆基本信息集合
	 * @return CarManageCarBean 车辆信息集合
	 */
	public List<CarManageCarBean> findCarManageCarList(String car_id);
	/**
	 * 
	*<b>Summary: </b>    添加者：tl
	* findCarManageCarListSP(查询数据显示审批分配车辆信息多个)
	* @param car_id       车辆Id
	* @return
	 */
	public List<CarManageCarBean> findCarManageCarListSP(String car_id);
	/**
	 * 根据车辆主键CarID 获得车辆基本信息
	 * @return CarManageCarBean 车辆信息
	 */
	public CarManageCarBean findCarManageCarByCarID(String car_id);
	
	/**
	 * 根据车辆申请信息ID更新派车结束State 
	 * @param apply_id
	 * @return true or false
	 */
	public boolean updateCarManageCarStateByCarID(CarManageCarBean carManageCarBean);
	
	/**
	 * 车辆管理=保存车辆信息
	 * @param carManageCarBean
	 * @return true or false
	 */
	public String saveCarManageCarInfo(CarManageCarBean carManageCarBean);
	
	/**
	 * 车辆管理=更新车辆信息
	 * @param carManageCarBean
	 * @return true or false
	 */
	public String updateCarManageCarInfo(CarManageCarBean carManageCarBean);
	
	/**
	 * 查询车辆信息--分页方法
	 * @param carManageCarBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findCarManageCarInfoList(CarManageApplyinfoSearchBean carManageApplyinfoSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	
	/**
	 * 查询车辆信息--分页方法
	 * @param CarManageApplyinfoSearchBean
	 */
	public List<CarManageApplyinfoSearchBean> findCarYuYueInfoList(String sj);
	
	public List<CarManageCarBean> getAllCarList();
	
	public CarManageCarBean getCarByCarId(String car_id);
	
	public CarManageCarBean getCarId(String car_id,String tableName);
	
	
	/**
	 * @Description  删除车辆管理车辆信息
	 * @param carIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public String delCarInfo(String carIds);
	
	/**
	 * @Description 保存车辆照片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public String Insertimg(String imgsrc,String imgid);
	
	/**
	 * @Description 根据车辆Photoid找到ymj_oa_car_image
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public List<CarImageBeam> getCarImageBeamlist(String imgid) throws SQLException;
	
	/**
	 * @Description 根据车辆Photoid删除关联图片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	
	public void delCarImg(String imgid);
	/**
	 * 
	*<b>Summary: </b>    谭力  添加   2013-4-27
	* delCarCheckChange(删除回车登记中更变车辆时现有的车辆)
	* @param apply_id   标记
	 */
	public void delCarCheckChange(String apply_id);
}

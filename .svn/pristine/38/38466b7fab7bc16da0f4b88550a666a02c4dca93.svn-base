package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.ApplyinfoState;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.frameworkset.common.poolman.PreparedDBUtil;


public class CarManageCarDaoImpl implements CarManageCarDao {

	private static final Logger LOG = Logger.getLogger(CarManageCarDaoImpl.class);
	@Override
	public List<CarManageApplyinfoSearchBean> findCarYuYueInfoList(String userstatrtime){
		List<CarManageApplyinfoSearchBean>cmasList=new ArrayList<CarManageApplyinfoSearchBean>();
 		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select c.car_id,c.car_num,c.DRIVER_ID,c.DRIVER,CAR_BRAND,CAR_TYPE,a.use_starttime,a.use_endtime, a.state from YMJ_OA_CARMANAGE_CAR c left join YMJ_OA_CARMANAGE_APPLYINFO a on c.car_id=a.car_id  and a.state != '3' and a.state !='5' where c.current_state !='0'  ");
	/*	if(!StringUtil.nullOrBlank(userstatrtime))
		{
			sql.append(" and a.use_starttime like to_date('"+userstatrtime+"','yyyy-mm-dd hh24:mi:ss')");
			sql.append(" or substr(a.use_endtime,0,10) >= to_date('"+userstatrtime+"','yyyy-mm-dd')");
		}
	*/
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for(int i=0;i<pdb.size();i++){
				CarManageApplyinfoSearchBean cmas = new CarManageApplyinfoSearchBean();
				cmas.setCar_id(pdb.getString(i,"car_id"));
				cmas.setCar_num(pdb.getString(i,"car_num"));
				cmas.setUse_starttime(pdb.getString(i,"use_starttime"));
				//特检院OA 已通过的没有填写【结束时间】的车辆申请分派后，在【车辆分派】页面的【用车预约状态】相应车辆的使用情况柱状图，显示从【开始时间】开始往后无穷远的柱图
				if(!StringUtil.isBlank(pdb.getString(i,"use_endtime"))){
					cmas.setUse_endtime(pdb.getString(i,"use_endtime"));
				} else {
					cmas.setUse_endtime("4999-12-31 23:23:59");
				}
				
				cmas.setSjid(pdb.getString(i,"DRIVER_ID"));
				cmas.setSjname(pdb.getString(i,"DRIVER"));
				cmas.setCar_brand(pdb.getString(i,"car_brand"));
				cmas.setCar_type(pdb.getString(i,"car_type"));
				cmas.setState(pdb.getString(i,"state"));
				cmasList.add(cmas);
			}
			return cmasList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 
	*<b>Summary: </b>    添加者：tl
	* findCarManageCarListSP(查询数据显示审批分配车辆信息多个)
	* @param car_id       车辆Id
	* @return
	 */
	public List<CarManageCarBean> findCarManageCarListSP(String car_id){
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select *　from (");
		sql.append(" select r.car_id, ");
		sql.append("  r.car_num, ");
		sql.append("  r.driver, ");
		sql.append("  r.driver_id, ");
		sql.append("  r.car_brand, ");
		sql.append("  r.car_type, ");
		sql.append("  r.buy_time, ");
		sql.append("  r.buy_money, ");
		sql.append("  r.color, ");
		sql.append("  r.card, ");
		sql.append("  r.fdj_num, ");
		sql.append("  o.end_time, ");
		sql.append("  r.remark, ");
		sql.append("  o.spyj, ");
		sql.append("  o.sjname, ");
		sql.append("  r.car_photoid,");
		sql.append("  decode(o.state,");
		sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
		sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
		sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
		sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
		sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
		sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')current_state");
		//sql.append("  r.current_state ");
		/*sql.append("  from YMJ_OA_CARMANAGE_CAR r left join YMJ_OA_CARMANAGE_APPLYINFO o on  r.car_id=o.car_id");
		sql.append(" left join ymj_oa_auditcar a on a.apply_id = o.apply_id");*/
		sql.append("  from   ymj_oa_auditcar a");
		sql.append(" left join YMJ_OA_CARMANAGE_APPLYINFO o on a.apply_id = o.apply_id");
		sql.append(" left join YMJ_OA_CARMANAGE_CAR r on r.car_id = o.car_id");
		sql.append("  where  a.apply_id = ? order by r.car_id  desc )  a where  rownum=1 ");
		
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, car_id);
			pdb.executePrepared();
			for(int i = 0; i<pdb.size(); i++){
				CarManageCarBean	carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setDriver(pdb.getString(i,"sjname"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setCurrent_state(pdb.getString(i,"current_state"));
				carManageCarBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setBuy_money(pdb.getString(i,"buy_money"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setCard(pdb.getString(i,"card"));
				carManageCarBean.setSpyj(pdb.getString(i,"spyj"));
				carManageCarBean.setFdj_num(pdb.getString(i,"fdj_num"));
				carManageCarBean.setRemark(pdb.getString(i,"remark"));
				carManageCarBean.setCar_photoid(pdb.getString(i,"car_photoid"));
				list.add(carManageCarBean);
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		return list;
	}
	
	public List<CarManageCarBean> getAllCarList(){
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select r.car_id, ");
		sql.append("  r.car_num, ");
		sql.append("  r.driver, ");
		sql.append("  r.driver_id, ");
		sql.append("  r.car_brand, ");
		sql.append("  r.car_type, ");
		sql.append("  r.buy_time, ");
		sql.append("  r.buy_money, ");
		sql.append("  r.color, ");
		sql.append("  r.card, ");
		sql.append("  r.fdj_num, ");
		sql.append("  r.remark, ");
		sql.append("  r.car_photoid");
		sql.append("  from   YMJ_OA_CARMANAGE_CAR r");
		 
		try {
			pdb.preparedSelect(sql.toString());
//			pdb.setString(1, car_id);
			pdb.executePrepared();
			for(int i = 0; i<pdb.size(); i++){
				CarManageCarBean	carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setCard(pdb.getString(i,"card"));
				carManageCarBean.setFdj_num(pdb.getString(i,"fdj_num"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
				carManageCarBean.setCurrent_state(pdb.getString(i,"current_state"));
				carManageCarBean.setRemark(pdb.getString(i,"remark"));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				list.add(carManageCarBean);
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		return list;
	}
	
	public CarManageCarBean getCarByCarId(String car_id){
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select r.car_id, ");
		sql.append("  r.car_num, ");
		sql.append("  r.driver, ");
		sql.append("  r.driver_id, ");
		sql.append("  r.car_brand, ");
		sql.append("  r.car_type, ");
		sql.append("  r.buy_time, ");
		sql.append("  r.buy_money, ");
		sql.append("  r.color, ");
		sql.append("  r.card, ");
		sql.append("  r.fdj_num, ");
		sql.append("  r.remark, ");
		sql.append("  r.car_photoid");
		sql.append("  from   YMJ_OA_CARMANAGE_CAR r");
		 
		sql.append("  where  r.car_id = ? ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, car_id);
			pdb.executePrepared();
			for(int i = 0; i<pdb.size(); i++){
				CarManageCarBean	carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setCard(pdb.getString(i,"card"));
				carManageCarBean.setFdj_num(pdb.getString(i,"fdj_num"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
				carManageCarBean.setCurrent_state(pdb.getString(i,"current_state"));
				carManageCarBean.setRemark(pdb.getString(i,"remark"));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				list.add(carManageCarBean);
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		return list!=null&&list.size()>0?list.get(0):null;
	}
	
	public CarManageCarBean getCarId(String car_id,String tableName){
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		if(tableName.equals("TA_OA_WHTJY_YONGCHE")){
			sql.append(" select r.assigned_vehicle as car_id");
			sql.append("  from TA_OA_WHTJY_YONGCHE r");
			sql.append("  where  r.T_ID = '"+car_id+"' ");
		}else{
			sql.append(" select r.car_info as car_id");
			sql.append("  from "+tableName+" r");
			sql.append("  where  r.T_ID = '"+car_id+"' ");
		}
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for(int i = 0; i<pdb.size(); i++){
				CarManageCarBean	carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				list.add(carManageCarBean);
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		return list!=null&&list.size()>0?list.get(0):null;
	}
	
	public List<CarManageCarBean> findCarManageCarList(String car_id){
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select r.car_id, ");
		sql.append("  r.car_num, ");
		sql.append("  r.driver, ");
		sql.append("  r.driver_id, ");
		sql.append("  r.car_brand, ");
		sql.append("  r.car_type, ");
		sql.append("  r.buy_time, ");
		sql.append("  r.buy_money, ");
		sql.append("  r.color, ");
		sql.append("  r.card, ");
		sql.append("  r.fdj_num, ");
		sql.append("  o.end_time, ");
		sql.append("  r.remark, ");
		sql.append("  o.spyj, ");
		sql.append("  o.sjname, ");
		sql.append("  r.car_photoid,");
		sql.append("  decode(o.state,");
		sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
		sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
		sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
		sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
		sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
		sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')current_state");
		//sql.append("  r.current_state ");
		/*sql.append("  from YMJ_OA_CARMANAGE_CAR r left join YMJ_OA_CARMANAGE_APPLYINFO o on  r.car_id=o.car_id");
		sql.append(" left join ymj_oa_auditcar a on a.apply_id = o.apply_id");*/
		sql.append("  from   ymj_oa_auditcar a");
		sql.append(" left join YMJ_OA_CARMANAGE_APPLYINFO o on a.apply_id = o.apply_id");
		sql.append(" left join YMJ_OA_CARMANAGE_CAR r on r.car_id = a.car_id");
		 
		sql.append("  where  a.apply_id = ? ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, car_id);
			pdb.executePrepared();
			for(int i = 0; i<pdb.size(); i++){
				CarManageCarBean	carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setDriver(pdb.getString(i,"sjname"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setCurrent_state(pdb.getString(i,"current_state"));
				carManageCarBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setBuy_money(pdb.getString(i,"buy_money"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setCard(pdb.getString(i,"card"));
				carManageCarBean.setSpyj(pdb.getString(i,"spyj"));
				carManageCarBean.setFdj_num(pdb.getString(i,"fdj_num"));
				carManageCarBean.setRemark(pdb.getString(i,"remark"));
				carManageCarBean.setCar_photoid(pdb.getString(i,"car_photoid"));
				list.add(carManageCarBean);
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		return list;
	}
	
	@Override
	public CarManageCarBean findCarManageCarByCarID(String car_id) {
		// TODO Auto-generated method stub
		CarManageCarBean carManageCarBean = null;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select r.car_id, ");
		sql.append("  r.car_num, ");
		sql.append("  r.driver, ");
		sql.append("  r.driver_id, ");
		sql.append("  r.car_brand, ");
		sql.append("  r.car_type, ");
		sql.append("  r.buy_time, ");
		sql.append("  r.buy_money, ");
		sql.append("  r.color, ");
		sql.append("  r.unit_id, ");
		sql.append("  r.unit_name, ");
		sql.append("  r.card, ");
		sql.append("  r.fdj_num, ");
		sql.append("  o.end_time, ");
		sql.append("  r.remark, ");
		sql.append("  o.spyj, ");
		sql.append("  o.sjname, ");
		sql.append("  r.car_photoid,");
		sql.append("  decode(o.state,");
		sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
		sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
		sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
		sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
		sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
		sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')current_state");
		//sql.append("  r.current_state ");
		sql.append("  from YMJ_OA_CARMANAGE_CAR r left join YMJ_OA_CARMANAGE_APPLYINFO o on  r.car_id=o.car_id");
		sql.append("  where  r.car_id = ? ");
		
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, car_id);
			pdb.executePrepared();
			int i = 0;
			if(pdb.size()>0){
				carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setDriver(pdb.getString(i,"sjname"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setCurrent_state(pdb.getString(i,"current_state"));
				carManageCarBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setBuy_money(pdb.getString(i,"buy_money"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setCard(pdb.getString(i,"card"));
				carManageCarBean.setSpyj(pdb.getString(i,"spyj"));
				carManageCarBean.setFdj_num(pdb.getString(i,"fdj_num"));
				carManageCarBean.setRemark(pdb.getString(i,"remark"));
				carManageCarBean.setUnit_id(pdb.getString(i,"unit_id"));
				carManageCarBean.setUnit_name(pdb.getString(i,"unit_name"));
				carManageCarBean.setCar_photoid(pdb.getString(i,"car_photoid"));
			}
		} catch (Exception e) {
			LOG.error("根据车辆主键CarID 获得车辆基本信息出错："+e.getMessage());
		}
		
		return carManageCarBean;
	}
	
	
	
	@Override
	public boolean updateCarManageCarStateByCarID(CarManageCarBean carManageCarBean) {
		// TODO Auto-generated method stub
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update YMJ_OA_CARMANAGE_CAR r ");
		sql.append(" set r.current_state = ? ");
		sql.append(" where r.car_id = ? ");
		 
		try {
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, carManageCarBean.getCurrent_state());
			pdb.setString(2, carManageCarBean.getCar_id());
			pdb.executePrepared();
		} catch (Exception e) {
			LOG.error("根据车辆申请信息ID更新派车结束State：", e);
			return false;
		}
		return true;
	}

	@Override
	public String saveCarManageCarInfo(CarManageCarBean carManageCarBean) {
		String str="保存成功";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into YMJ_OA_CARMANAGE_CAR");
		sql.append(" (car_id,");
		sql.append(" Car_Num,");
		sql.append(" buy_time,"); 
		sql.append(" Car_Brand,"); 
		sql.append(" Car_Type,");  
		sql.append(" color,");
		sql.append(" Buy_Money,");
		sql.append(" Card,");
		sql.append(" Fdj_Num,");
		sql.append(" Driver,");
		sql.append(" driver_id,"); 
		sql.append(" Remark,current_state,car_photoid,unit_id,unit_name) ");  
		sql.append(" values");
		sql.append(" (SEQ_YMJ_OA_CARMANAGE_CAR.Nextval,");
		sql.append(" ?,");
		sql.append(" to_date(?, 'yyyy-mm-dd hh24:mi:ss'),");  
		sql.append(" ?,?,?,?,?,?,?,?,?,'1',?,?,?)");
		   
		int i = 1;
		try {
			pdb.preparedInsert(sql.toString());
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_num()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getBuy_time()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_brand()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_type()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getColor()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getBuy_money()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCard()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getFdj_num()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getDriver()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getDriver_id()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getRemark()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_photoid()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getUnit_id()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getUnit_name()));
			pdb.executePrepared();
		} catch (Exception e) {
			LOG.error("车辆管理=保存车辆信息出错："+e.getMessage());
			return "保存失败";
		}
		return str;
	}

	@Override
	public String updateCarManageCarInfo(CarManageCarBean carManageCarBean) {
		String str="修改成功";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			sql.append(" update YMJ_OA_CARMANAGE_CAR ");
			sql.append(" set Car_Num = ?,");
			sql.append(" buy_time = ?,"); 
			sql.append(" Car_Brand = ?,"); 
			sql.append(" Car_Type = ?,");  
			sql.append(" color = ?,");
			sql.append(" Buy_Money = ?,");
			sql.append(" Card = ?,");
			sql.append(" Fdj_Num = ?,");
			sql.append(" Driver = ?,");
			sql.append(" driver_id = ?,"); 
			sql.append(" Remark = ?, ");  
			sql.append(" car_photoid = ?, ");  
			sql.append(" unit_id = ?, ");  
			sql.append(" unit_name = ? ");  
			sql.append(" where car_id = ?");
			pdb.preparedUpdate(sql.toString());
			int i = 1;
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_num()));
			pdb.setTimestamp(i++, DateUtil.parseTimeString(carManageCarBean.getBuy_time()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_brand()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_type()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getColor()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getBuy_money()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCard()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getFdj_num()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getDriver()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getDriver_id()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getRemark()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_photoid()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getUnit_id()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getUnit_name()));
			pdb.setString(i++, StringUtil.deNull(carManageCarBean.getCar_id()));
			pdb.executePrepared();
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error(e.getMessage());
			return str="修改失败";
		}
		return str;
	}

	@Override
	public PagingBean findCarManageCarInfoList(
			CarManageApplyinfoSearchBean carManageApplyinfoSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		// TODO Auto-generated method stub
		PagingBean pb = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<CarManageCarBean> list = new ArrayList<CarManageCarBean>();
		
		sql.append(" select r.car_num,");
		sql.append(" r.car_id,");
		sql.append(" r.car_brand,");
		sql.append(" r.car_type,");
		sql.append(" r.color,");
		sql.append(" r.buy_time,");
		sql.append(" r.driver,");
		sql.append(" r.driver_id,");
		sql.append(" r.current_state ");
		//sql.append(" f.use_starttime,");
		//sql.append(" f.use_endtime ");
		sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
		//if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_starttime())) {
	    //	sql.append("left join YMJ_OA_CARMANAGE_APPLYINFO f on f.car_id = r.car_id");
		//}
		sql.append(" where 1=1 ");
		
		//所属单位
		if(!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUnit_id())){
			sql.append(" and r.unit_id = '"+carManageApplyinfoSearchBean.getUnit_id()+"' ");
		}
		
		// 用车日期
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_starttime())) {
	    	sql.append("and r.buy_time >=to_date('"+carManageApplyinfoSearchBean.getUse_starttime()+"', 'yyyy-MM-dd HH24:mi:ss')");
		}
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_endtime())) {
	    	sql.append("and r.buy_time <= to_date('"+carManageApplyinfoSearchBean.getUse_endtime()+"', 'yyyy-MM-dd HH24:mi:ss')");
		}
	    // 车辆
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getCar_id())) {
			sql.append(" and r.car_id = '"+carManageApplyinfoSearchBean.getCar_id()+"' ");
		}
	    // 状态
	    //if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getCurrent_state())) {
	    	sql.append(" and r.current_state != '0' ");
		//}
		
		sql.append("  order by r.buy_time desc");
		try {
			pdb.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	pdb.executePrepared();
	    	for (int i = 0; i < pdb.size(); i++) {
				CarManageCarBean carManageCarBean = new CarManageCarBean();
				carManageCarBean.setCar_id(pdb.getString(i,"car_id"));
				carManageCarBean.setCar_num(pdb.getString(i,"car_num"));
				carManageCarBean.setCar_brand(pdb.getString(i,"car_brand"));
				carManageCarBean.setCar_type(pdb.getString(i,"car_type"));
				carManageCarBean.setColor(pdb.getString(i,"color"));
				carManageCarBean.setBuy_time(DateUtil.GetTimeString(pdb.getTimestamp(i, "buy_time")));
				carManageCarBean.setDriver(pdb.getString(i,"driver"));
				carManageCarBean.setDriver_id(pdb.getString(i,"driver_id"));
				list.add(carManageCarBean);
			}
	    	
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			LOG.error(e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)pdb.getTotalSize());
		return pb;
	}
	
	/**
	 * @Description 删除车辆管理车辆信息
	 * @param carIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public String delCarInfo(String carIds){
		//String sql = "delete from YMJ_OA_CARMANAGE_CAR where car_id in ("+ carIds + ")";
		String msg="";
		String sql = "update YMJ_OA_CARMANAGE_CAR set current_state='0' where car_id in ("+ carIds + ")";
		String sql1 = "select f.state from YMJ_OA_CARMANAGE_APPLYINFO f where f.car_id in ("+carIds+") and f.state in('2','4')";
		PreparedDBUtil db = new PreparedDBUtil();
		try {
				db.preparedSelect(sql1.toString());
				db.executePrepared();
				if (db.size()>0){
					msg="车辆正被使用中,不能删除";
					return msg;
				}else{
					msg="删除成功";
					db.executeDelete(sql);
				}
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error(e.getMessage());
			return msg="删除失败";
		}
		return msg;
	}
	/**
	 * @Description 保存车辆照片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public String Insertimg(String imgsrc,String imgid){
		String res = "上传成功";
		String sql ="insert into ymj_oa_car_image(image_id,image_parth,image_yewu_id) " +
				"values(SEQ_YMJ_OA_CAR_IMAGE.Nextval,?,?)";
		PreparedDBUtil db = new PreparedDBUtil();
		try {
			delCarImg(imgid);
			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(imgsrc));
			db.setString(2, StringUtil.deNull(imgid));
			db.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
			return res="上传失败";
		}
		return res;
	}
	/**
	 * @Description 根据车辆Photoid找到ymj_oa_car_image
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public List<CarImageBeam> getCarImageBeamlist(String imgid)
		throws SQLException {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			List<CarImageBeam> list = new ArrayList<CarImageBeam>();
			sql.append("select image_parth,image_yewu_id from YMJ_OA_CAR_IMAGE t where image_yewu_id="+imgid+" order by t.image_id");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				CarImageBeam cb = new CarImageBeam();
				cb.setImage_parth(pdb.getString(i, "image_parth"));
				list.add(cb);
			}
			return list;
	}
	/**
	 * @Description 根据车辆Photoid删除关联图片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	
	public void delCarImg(String imgid)
	{
		String sql="delete ymj_oa_car_image t where t.image_yewu_id in("+imgid+")";
		PreparedDBUtil  db = new PreparedDBUtil ();
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delCarCheckChange
	  * @param apply_id 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao#delCarCheckChange(java.lang.String) 
	  */
	@Override
	public void delCarCheckChange(String apply_id) {
		String sql="delete from( select r.car_id,   r.car_num,   r.driver,   r.driver_id,   r.car_brand,   r.car_type,   r.buy_time,   r.buy_money,   r.color,"
			+"r.card,   r.fdj_num,   o.end_time,   r.remark,   o.spyj,   o.sjname,   r.car_photoid,  decode(o.state, 1,'等待派车', "
			+" 2,'审批通过', 3,'审批未通过', 5,'派车结束', 4,'等待审批', 6,'派车不通过')current_state  from   ymj_oa_auditcar a left join "
			+ "YMJ_OA_CARMANAGE_APPLYINFO o on a.apply_id = o.apply_id left join YMJ_OA_CARMANAGE_CAR r on r.car_id = a.car_id  where " 
			+"a.apply_id = "+apply_id+" ) a";
		
		PreparedDBUtil  db = new PreparedDBUtil ();
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryContent(查询word模板)
	* @return
	 */
	public byte[] queryContent(String id){
		StringBuffer sql=new StringBuffer();
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		BufferedInputStream is = null;
		sql.append(" select f.filebody from oa_octl_template_file f ");
		sql.append(" where f.recordid like '%'||(select t.template_id_th from oa_word_template_th t ");
		sql.append(" where t.template_name_th ='车辆维修送修单' )||'%'");
		byte[] wordcontent=null;
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				Blob blob = pdb.getBlob(i, "filebody");
				is = new BufferedInputStream(blob.getBinaryStream());
				byte[] bytes = new byte[(int) blob.length()];
				int len = bytes.length;
				int offset = 0;
				int read = 0;
				while (offset < len && (read = is.read(bytes, offset, len - offset)) >= 0) {
					offset += read;
				}
				wordcontent= bytes;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wordcontent;
	}
}

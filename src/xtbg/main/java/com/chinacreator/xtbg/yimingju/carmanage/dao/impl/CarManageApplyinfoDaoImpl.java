package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.ApplyinfoState;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionException;
import com.frameworkset.orm.transaction.TransactionManager;

public class CarManageApplyinfoDaoImpl implements CarManageApplyinfoDao {

	private static final Logger LOG = Logger.getLogger(CarManageApplyinfoDaoImpl.class);	
	
	@Override
	public PagingBean findCarManageApplyinfoList(
			CarManageApplyinfoSearchBean carManageApplyinfoSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<CarManageApplyinfoBean> list = new ArrayList<CarManageApplyinfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select f.use_name, ");
		sql.append(" f.use_id, ");
		sql.append(" f.apply_id, ");
	    sql.append(" f.use_starttime, ");
	    sql.append(" f.use_endtime, ");
	    sql.append(" f.sqrq, "); 
	    sql.append(" f.car_id, "); 
	   /* sql.append(" (select r.car_num ");
	    sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
	    sql.append(" where f.car_id = r.car_id) car_num, ");*/
	    sql.append(" ( select WM_CONCAT(c.car_num)  ");
	    sql.append(" from ymj_oa_auditcar a , YMJ_OA_CARMANAGE_CAR c  ");
	    sql.append(" where a.apply_id = f.apply_id and a.car_id = c.car_id ) ");
	    sql.append(" car_num, ");
	    //sql.append(" f.state");
	    sql.append(" decode(f.state,");
	    sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
	    sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
	    sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
	    sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
	    sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
	    sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')state ");
	    sql.append(" from YMJ_OA_CARMANAGE_APPLYINFO f ");
	    // sql.append(" where f.apply_personid = ? ");
	    sql.append(" where 1=1  ");
	    
	    // 用车日期
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_starttime())) {
	    	sql.append("and f.use" +
	    			"_starttime >=to_date('"+carManageApplyinfoSearchBean.getUse_starttime()+"', 'yyyy-MM-dd')");
		}
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_endtime())) {
	    	sql.append("and to_date(to_char(f.use_endtime,'yyyy-mm-dd'),'yyyy-mm-dd') <= to_date('"+carManageApplyinfoSearchBean.getUse_endtime()+"', 'yyyy-MM-dd')");
		}
	    // 车辆
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getCar_id())) {
			sql.append(" and car_id = '"+carManageApplyinfoSearchBean.getCar_id()+"' ");
		}
		// 根据列表的不同，所查询不同状态的数据
	    /***=========车辆分派--等待分配列表 carWaitfp========***/
		if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carWaitfp".equals(carManageApplyinfoSearchBean.getList_type())) {
			sql.append(" and state = '1' ");
		}
		/***=========车辆分派--已分配列表 carWaitfp========***/
		if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carYjfp".equals(carManageApplyinfoSearchBean.getList_type())) {
			//sql.append(" and f.car_id is not null ");
			sql.append(" and (  state = '4' or state = '5' or state = '2'  or state = '3' or state = '6' ");
			if(carManageApplyinfoSearchBean.getState().equals("6"))
			{
				sql.append(" or state ='6' ");
			}
			sql.append(" )");
			if(!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getFpid()))
			{
				sql.append(" and  fpid="+carManageApplyinfoSearchBean.getFpid());
			}
		}
	    
		/***=========派车审批--等待审批列表 carWaitSp========***/
		if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carWaitSp".equals(carManageApplyinfoSearchBean.getList_type())) {
			if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getSp_row()) && carManageApplyinfoSearchBean.getSp_row().equals("yes")){
				sql.append(" and state = '4' ");
			}else{
				sql.append(" and state = '8' ");//随便写的一个。不然会查出所有。
			}
		}
		
		/***=========派车审批--已经审批列表 carYjSp========***/
		if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carYjSp".equals(carManageApplyinfoSearchBean.getList_type())) {
			if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getSp_row()) && carManageApplyinfoSearchBean.getSp_row().equals("yes")){
				sql.append(" and ( state = '2'  or state = '3' or state = '5')  and spid ="+carManageApplyinfoSearchBean.getSpid());
			}else{
				sql.append(" and state = '8' ");//随便写的一个。不然会查出所有。
			}
		}
	    // 状态
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getState())) {
			sql.append(" and state = '"+carManageApplyinfoSearchBean.getState()+"' ");
		}
	    
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getApply_personid())) {
	    	sql.append(" and apply_personid = '"+carManageApplyinfoSearchBean.getApply_personid()+"' ");
	    }
	    sql.append("  order by f.sqrq desc ");
	       
	    try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	//db.setString(j++, carManageApplyinfoSearchBean.getApply_personid());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		    	carManageApplyinfoBean.setApply_id(db.getString(i,"apply_id"));
		    	carManageApplyinfoBean.setUse_name(db.getString(i,"use_name"));
		    	carManageApplyinfoBean.setUse_id(db.getString(i,"use_id"));
		    	carManageApplyinfoBean.setUse_starttime(DateUtil.GetTimeStringNos(db.getTimestamp(i,"use_starttime")));
		    	carManageApplyinfoBean.setUse_endtime(DateUtil.GetTimeStringNos(db.getTimestamp(i,"use_endtime")));
		    	carManageApplyinfoBean.setSqrq(DateUtil.GetTimeStringNos(db.getTimestamp(i, "sqrq")));
		    	carManageApplyinfoBean.setCar_num(db.getString(i,"car_num"));
		    	carManageApplyinfoBean.setCar_id(db.getString(i,"car_id"));
		    	carManageApplyinfoBean.setState(db.getString(i,"state"));
		    	list.add(carManageApplyinfoBean);
		    }
			
		} catch (Exception e) {
			LOG.error("执行车辆申请记录列表查询报错："+e.getMessage());
		}
	         
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());  
		
		return pb;
	}
	/*
	 * 添加时间2013-4-24
	 * 添加人： tl
	 * 获取派车审批中的数据列表信息
	 * */
	public List<CarManageApplyinfoBean> getCarManageApplyinfoBeanInfoList(){
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<CarManageApplyinfoBean> list=new ArrayList<CarManageApplyinfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select f.use_name, ");
		sql.append(" f.use_id, ");
		sql.append(" f.apply_id, ");
	    sql.append(" f.use_starttime, ");
	    sql.append(" f.use_endtime, ");
	    sql.append(" f.sqrq, "); 
	    sql.append(" f.car_id, "); 
	    sql.append(" (select r.car_num ");
	    sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
	    sql.append(" where f.car_id = r.car_id) car_num, ");
	    //sql.append(" f.state");
	    sql.append(" decode(f.state,");
	    sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
	    sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
	    sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
	    sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
	    sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
	    sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')state ");
	    sql.append(" from YMJ_OA_CARMANAGE_APPLYINFO f ");
	   // sql.append(" where f.apply_personid = ? ");
	    sql.append(" where 1=1  and state = '4'");
	    sql.append("  order by f.sqrq desc ");
	    try {
	    	pdb.preparedSelect(sql.toString());
	    	int j = 1;
	    	//db.setString(j++, carManageApplyinfoSearchBean.getApply_personid());
	    	pdb.executePrepared();
		    for(int i = 0;i < pdb.size();i++){
		    	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		    	carManageApplyinfoBean.setApply_id(pdb.getString(i,"apply_id"));
		    	carManageApplyinfoBean.setUse_name(pdb.getString(i,"use_name"));
		    	carManageApplyinfoBean.setUse_id(pdb.getString(i,"use_id"));
		    	carManageApplyinfoBean.setUse_starttime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_starttime")));
		    	carManageApplyinfoBean.setUse_endtime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_endtime")));
		    	carManageApplyinfoBean.setSqrq(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "sqrq")));
		    	carManageApplyinfoBean.setCar_num(pdb.getString(i,"car_num"));
		    	carManageApplyinfoBean.setCar_id(pdb.getString(i,"car_id"));
		    	carManageApplyinfoBean.setState(pdb.getString(i,"state"));
		    	list.add(carManageApplyinfoBean);
		    }
		} catch (Exception e) {
			LOG.error("获取派车审批中的数据列表信息报错："+e.getMessage());
		}
		return list;
	}

	@Override
	public String saveCarManageApplyinfo(
			CarManageApplyinfoBean carManageApplyinfoBean,
			Connection con) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql1 = new StringBuffer();
		String apply_id = carManageApplyinfoBean.getApply_id();
		
		try {
			/*sql.append("delete from YMJ_OA_CARMANAGE_APPLYINFO t where t.apply_id = ? ");
			pdb.preparedDelete(sql1.toString());
			pdb.setString(1, apply_id);
			pdb.executePrepared(con);*/
			
			sql1.append("insert into YMJ_OA_CARMANAGE_APPLYINFO");
			sql1.append("  (APPLY_ID, APPLY_PERSON,APPLY_PERSONID,USE_REASON, USE_STARTTIME, USE_ENDTIME, DESTINATION,USE_NAME,USE_ID,SQRQ,state)");
			sql1.append("values");
			sql1.append("  (SEQ_YMJ_OA_CARMANAGE_APPLYINFO.nextval, ?, ?, ?, to_date(?,'yyyy-mm-dd hh24:mi:ss'), ");
			sql1.append("  to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?,to_date(?,'yyyy-mm-dd hh24:mi:ss'), ?)");
			int i = 1;
			pdb.preparedInsert(sql1.toString());
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getApply_person()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getApply_personid()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getUse_reason()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getUse_starttime()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getUse_endtime()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getDestination()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getUse_name()));
			pdb.setString(i++, StringUtil.deNull(carManageApplyinfoBean.getUse_id()));
			pdb.setString(i++,DateUtil.getCurrentDateTime());
			pdb.setString(i++, StringUtil.deNull(ApplyinfoState.APPLYINFO_WRIT_FP));
			pdb.executePrepared();
		} catch (Exception e) {
			LOG.error("执行车辆申请保存信息报错："+e.getMessage());
		}
		
		return apply_id;
	}

	@Override
	public CarManageApplyinfoBean findCarManageApplyinfoByApplyID(String apply_id) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		CarManageApplyinfoBean carManageApplyinfoBean = null;
		
		sql.append(" select f.use_name, ");
		sql.append(" f.use_id, ");
		sql.append(" f.apply_id, ");
	    sql.append(" f.use_starttime, ");
	    sql.append(" f.use_endtime, ");
	    sql.append(" f.sqrq, "); 
	    sql.append(" f.car_id, "); 
	    sql.append(" f.spyj, ");
	    sql.append(" f.end_time, ");
	    sql.append(" f.use_reason, ");
	    sql.append(" f.spyj_nr, ");
	    sql.append(" f.destination, ");
	    sql.append(" (select r.car_num ");
	    sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
	    sql.append(" where f.car_id = r.car_id) car_num, ");
	    sql.append(" decode(f.state,");
	    sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
	    sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
	    sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
	    sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
	    sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
	    sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')state ,");
	    sql.append(" f.oil ,");
	    sql.append(" f.mileage ");
	    sql.append(" from YMJ_OA_CARMANAGE_APPLYINFO f ");
	    sql.append(" where f.apply_id = ? ");
	    
	    try {
	    	pdb.preparedSelect(sql.toString());
	    	pdb.setString(1, apply_id);
	    	pdb.executePrepared();
	    	int i = 0;
	    	if (pdb.size()>0){
	    		carManageApplyinfoBean = new CarManageApplyinfoBean();
		    	carManageApplyinfoBean.setApply_id(pdb.getString(i,"apply_id"));
		    	carManageApplyinfoBean.setUse_name(pdb.getString(i,"use_name"));
		    	carManageApplyinfoBean.setUse_id(pdb.getString(i,"use_id"));
		    	carManageApplyinfoBean.setUse_starttime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_starttime")));
		    	carManageApplyinfoBean.setUse_endtime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_endtime")));
		    	carManageApplyinfoBean.setSqrq(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "sqrq")));
		    	carManageApplyinfoBean.setCar_num(pdb.getString(i,"car_num"));
		    	carManageApplyinfoBean.setCar_id(pdb.getString(i,"car_id"));
		    	carManageApplyinfoBean.setState(pdb.getString(i,"state"));
		    	carManageApplyinfoBean.setSpyj(pdb.getString(i,"spyj"));
		    	carManageApplyinfoBean.setSpyj_nr(pdb.getString(i,"spyj_nr"));
		    	carManageApplyinfoBean.setDestination(pdb.getString(i,"destination"));
		    	carManageApplyinfoBean.setEnd_time(DateUtil.GetTimeStringNos(pdb.getTimestamp(i, "end_time")));
		    	carManageApplyinfoBean.setUse_reason(pdb.getString(i,"use_reason"));
		    	carManageApplyinfoBean.setDestination(pdb.getString(i,"destination"));
		    	carManageApplyinfoBean.setOil(pdb.getString(i,"oil"));
		    	carManageApplyinfoBean.setMileage(pdb.getString(i,"mileage"));
			}
	    	
		} catch (Exception e) {
			LOG.error("根据车辆管理申请信息ID获得基本信息出错："+e.getMessage());
		}
	    
		return carManageApplyinfoBean;
	}
	public boolean addCarInfo(String apply_id,String car_id) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into ymj_oa_auditcar (id,apply_id,car_id)values(SEQ_YMJ_OA_CARMANAGE_APPLYINFO.nextval,?,?) ");
		try {
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, StringUtil.deNull(apply_id));
			pdb.setString(2, StringUtil.deNull(car_id));
			pdb.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	@Override      
	public boolean updateCarManageApplyStateByApplyID(CarManageApplyinfoBean CarManageApplyinfoBean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update YMJ_OA_CARMANAGE_APPLYINFO f ");
		sql.append(" set f.state = ? ,f.spid = ? ");
		//sql.append(" , f.spyj = ? ");
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSpyj())){
			sql.append(" , f.spyj = ? ");
		}
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSjid())){
			sql.append(" , f.sjid = ? ");
		}
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSjname())){
			sql.append(" , f.sjname = ? ");
		}
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getCar_id())){
			sql.append(" , f.car_id = ? ");
		}
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSpyj_nr())){
			sql.append(" , f.spyj_nr = ? ");
		}
		if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getFpid())){ //分配ID
			sql.append(" , f.fpid = ? ");
		}
		sql.append(" where f.apply_id = ? ");
		try {
			pdb.preparedUpdate(sql.toString());
			int i=1;
			pdb.setString(i++, CarManageApplyinfoBean.getState());
			pdb.setString(i++, CarManageApplyinfoBean.getSpid());
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSpyj())){
				pdb.setString(i++, CarManageApplyinfoBean.getSpyj());
			}
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSjid())){
				pdb.setString(i++, CarManageApplyinfoBean.getSjid());
			}
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSjname())){
				pdb.setString(i++, CarManageApplyinfoBean.getSjname());
			}
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getCar_id())){
				pdb.setString(i++, CarManageApplyinfoBean.getCar_id());
			}
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getSpyj_nr())){
				pdb.setString(i++, CarManageApplyinfoBean.getSpyj_nr());
			}
			if (!StringUtil.nullOrBlank(CarManageApplyinfoBean.getFpid())){
				pdb.setString(i++, CarManageApplyinfoBean.getFpid());
			}
			pdb.setString(i++, CarManageApplyinfoBean.getApply_id());
			pdb.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			LOG.error("根据车辆申请信息ID更新State：", e);
			return false;
		}
		
		return true;
	}
	
	//拿到所有回车登记中的车辆
	public List<CarManageApplyinfoBean> getAllHCInfo(){
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<CarManageApplyinfoBean> list=new ArrayList<CarManageApplyinfoBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select f.use_name,  f.use_id,  f.apply_id,  f.use_starttime,  f.use_endtime,  f.sqrq,  f.car_id,  f.end_time,"  
					+"(select r.car_num  from YMJ_OA_CARMANAGE_CAR r  where f.car_id = r.car_id) car_num,  f.sjname,   decode(f.state, "
					+" 1,'等待派车', 2,'审批通过', 3,'审批未通过', 4,'等待审批', 5,'派车结束', 6,'派车不通过')state  from YMJ_OA_CARMANAGE_APPLYINFO"
					+"  f  where 1=1   and state = '2'   order by f.sqrq desc  ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
		    for(int i = 0;i < pdb.size();i++){
		    	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		    	carManageApplyinfoBean.setApply_id(pdb.getString(i,"apply_id"));
		    	carManageApplyinfoBean.setUse_name(pdb.getString(i,"use_name"));
		    	carManageApplyinfoBean.setUse_starttime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_starttime")));
		    	carManageApplyinfoBean.setUse_endtime(DateUtil.GetTimeStringNos(pdb.getTimestamp(i,"use_endtime")));
		    	list.add(carManageApplyinfoBean);
		    }
		} catch (SQLException e) {
			LOG.error("获取回车登陆中的数据列表信息报错："+e.getMessage());
		}
		return list;
	}
	
	@Override
	public PagingBean findCarManageApplyinfoYpcList(
			CarManageApplyinfoSearchBean carManageApplyinfoSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<CarManageApplyinfoBean> list = new ArrayList<CarManageApplyinfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select f.use_name, ");
		sql.append(" f.use_id, ");
		sql.append(" f.apply_id, ");
	    sql.append(" f.use_starttime, ");
	    sql.append(" f.use_endtime, ");
	    sql.append(" f.sqrq, "); 
	    sql.append(" f.car_id, "); 
	    sql.append(" f.end_time, "); 
	    sql.append(" (select WM_CONCAT(c.car_num) ");// 所用车辆
	    sql.append(" from ymj_oa_auditcar a, YMJ_OA_CARMANAGE_CAR c ");
	    sql.append(" where a.apply_id = f.apply_id and a.car_id = c.car_id ) car_num, ");
	    sql.append(" f.sjname,  "); 
	    //sql.append(" (select r.driver ");// 驾驶员
	    //sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
	    //sql.append(" where f.car_id = r.car_id) driver, ");
//	    sql.append(" (select r.end_time ");// 结束时间                          
//	    sql.append(" from YMJ_OA_CARMANAGE_CAR r ");
//	    sql.append(" where f.car_id = r.car_id) end_time, ");
	    //sql.append(" f.state");
	    sql.append(" decode(f.state,");
	    sql.append(" 1,'"+ApplyinfoState.APPLYINFO_WRIT_FP_NAME +"',");
	    sql.append(" 2,'"+ApplyinfoState.APPLYINFO_WRIT_SP_NAME+"',");
	    sql.append(" 3,'"+ApplyinfoState.APPLYINFO_SP_NOPASS_NAME+"',");
	    sql.append(" 4,'"+ApplyinfoState.APPLYINFO_SP_PASS_NAME+"',");
	    sql.append(" 5,'"+ApplyinfoState.APPLYINFO_PC_END_NAME+"',");
	    sql.append(" 6,'"+ApplyinfoState.APPLYINFO_NO_FP_NAME+"')state "); 
	    sql.append(" from YMJ_OA_CARMANAGE_APPLYINFO f ");
	    sql.append(" where 1=1  ");
	    //特检院OA 拥有该菜单权限的用户即可查看所有【已通过】的申请，并进行回车登记。而不是只有司机可以回车登记。2014-03-25
	    //sql.append(" and f.sjid = ? ");
	    
	    // 状态
	    /***=========回车登记--已结束派车列表 carYjSp========***/
		if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carYjjspc".equals(carManageApplyinfoSearchBean.getList_type())) {
			sql.append(" and state = '5' ");
		}else if(!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getList_type())
				&& "carHistoryList".equals(carManageApplyinfoSearchBean.getList_type())){
			//sql.append(" and (state = '3' or state = '4' or state = '5') ");
		}else{
			sql.append(" and state = '2' "); // 回车登记--已派车列表
		}
	    
	    // 用车日期
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_starttime())) {
	    	sql.append("and f.use_starttime >=to_date('"+carManageApplyinfoSearchBean.getUse_starttime()+"', 'yyyy-MM-dd')");
		}
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUse_endtime())) {
	    	sql.append("and substr(f.use_endtime,0,10) <= to_date('"+carManageApplyinfoSearchBean.getUse_endtime()+"', 'yyyy-MM-dd')");
	    }
	    // 车辆
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getCar_id())) {
			sql.append(" and car_id = '"+carManageApplyinfoSearchBean.getCar_id()+"' ");
		}
	    if (!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getState())) {
			sql.append(" and state = '"+carManageApplyinfoSearchBean.getState()+"' ");
		}
	    
	    String user_id = carManageApplyinfoSearchBean.getUser_id();
	    user_id = StringUtil.splitString(user_id, ",", "'");
	    
	    if(!StringUtil.nullOrBlank(carManageApplyinfoSearchBean.getUser_id())){
	    	sql.append(" and use_id in ("+user_id+") ");
	    }
	    sql.append("  order by f.sqrq desc ");
	       
	    try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	//int j = 1;
	    	//特检院OA 拥有该菜单权限的用户即可查看所有【已通过】的申请，并进行回车登记。而不是只有司机可以回车登记。2014-03-25
	    	//db.setString(j++, carManageApplyinfoSearchBean.getApply_personid());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
		    	carManageApplyinfoBean.setApply_id(db.getString(i,"apply_id"));
		    	carManageApplyinfoBean.setUse_name(db.getString(i,"use_name"));
		    	carManageApplyinfoBean.setUse_id(db.getString(i,"use_id"));
		    	carManageApplyinfoBean.setUse_starttime(DateUtil.GetTimeStringNos(db.getTimestamp(i,"use_starttime")));
		    	carManageApplyinfoBean.setUse_endtime(DateUtil.GetTimeStringNos(db.getTimestamp(i,"use_endtime")));
		    	carManageApplyinfoBean.setSqrq(DateUtil.GetTimeStringNos(db.getTimestamp(i, "sqrq")));
		    	carManageApplyinfoBean.setCar_num(db.getString(i,"car_num"));
		    	carManageApplyinfoBean.setCar_id(db.getString(i,"car_id"));
		    	carManageApplyinfoBean.setState(db.getString(i,"state"));
		    	carManageApplyinfoBean.setSjname(db.getString(i,"sjname"));
		    	carManageApplyinfoBean.setEnd_time(DateUtil.GetTimeStringNos(db.getTimestamp(i, "end_time")));
		    	list.add(carManageApplyinfoBean);
		    }
			
		} catch (Exception e) {
			LOG.error("执行车辆申请记录列表查询报错："+e.getMessage());
		}
	         
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());  
		
		return pb;
	}

	@Override
	public boolean updateCarManageApplyYpendStateByApplyID(
			CarManageApplyinfoBean carManageApplyinfoBean,Connection con) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		try {
			sql.append(" update YMJ_OA_CARMANAGE_APPLYINFO f ");
			sql.append(" set f.state = ? , f.end_time = to_date(?,'yyyy-mm-dd hh24:mi:ss'),");
			sql.append(" f.oil= ?,f.mileage=? ");
			sql.append(" where f.apply_id = ? ");
			pdb.preparedUpdate(sql.toString());
			int j=1;
			pdb.setString(j++, carManageApplyinfoBean.getState());
			pdb.setString(j++, DateUtil.getCurrentDateTime());
			pdb.setString(j++, carManageApplyinfoBean.getOil());
			pdb.setString(j++, carManageApplyinfoBean.getMileage());
			pdb.setString(j++, carManageApplyinfoBean.getApply_id());
			pdb.executePrepared(con);
			
			/*sql1.append(" update YMJ_OA_CARMANAGE_CAR r ");
			sql1.append(" set r.current_state = ? ,");
			sql1.append(" r.end_time =to_date(?,'yyyy-mm-dd hh24:mi:ss') ");
			sql1.append(" where r.car_id = ? ");
			pdb.preparedUpdate(sql1.toString());
			pdb.setString(1, carManageApplyinfoBean.getCurrent_state());
			pdb.setString(2, DateUtil.getCurrentDateTime());
			pdb.setString(3, carManageApplyinfoBean.getCar_id());
			pdb.executePrepared(con);*/
			
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error("根据车辆申请信息ID更新已派车State：", e);
			return false;
		}
		
		return true;
	}
	
	//做派车的提示问题        tl     2013-5-2
	public String doCheckPC(String apply_id,String selectCar_num,String doPCOrHCId){
		String flag="";
		CarManageApplyinfoDao carManageApplyinfoDao = new  CarManageApplyinfoDaoImpl();
		CarManageCarDao carManageCarDao=new CarManageCarDaoImpl();
		TransactionManager tm=new TransactionManager();
		try {
			tm.begin();
			if(doPCOrHCId.equals("1")){
				//获得派车审批中的数据列表信息
				List<CarManageApplyinfoBean> list=getCarManageApplyinfoBeanInfoList();
				CarManageApplyinfoBean carManageApplyinfoBean = carManageApplyinfoDao.findCarManageApplyinfoByApplyID(apply_id);
				flag = doCheckForPC(selectCar_num, flag, list, carManageApplyinfoBean,carManageCarDao,doPCOrHCId);
			}else{
				List<CarManageApplyinfoBean> list=getAllHCInfo();
				CarManageApplyinfoBean carManageApplyinfoBean = carManageApplyinfoDao.findCarManageApplyinfoByApplyID(apply_id);
				flag = doCheckForPC(selectCar_num, flag, list, carManageApplyinfoBean,carManageCarDao,doPCOrHCId);
			}
			tm.commit();
		} catch (TransactionException e) {
			LOG.error("做派车的提示问题报错："+e.getMessage());
		} catch (RollbackException e) {
			LOG.error("做派车的提示问题报错："+e.getMessage());
		}
		return flag;
	}
	//循环判断	做派车的提示问题        tl     2013-5-2
	private String doCheckForPC(String selectCar_num, String flag,
			List<CarManageApplyinfoBean> list,
			CarManageApplyinfoBean carManageApplyinfoBean,
			CarManageCarDao carManageCarDao,String id) {
		String pc_starttime;
		String pc_endtime;
		String pc_usecar;
		String str[] = null;
		//循环做比较carid与时间
		if(!StringUtil.isBlank(selectCar_num)){
			 str = selectCar_num.split("#");
		}
		for(int k = 0; k<str.length ; k++){
		//当前界面的box选中车
		  String num= str[k].split(",")[0];
			for(int i=0;i<list.size();i++){
				String sesCarId="";
				CarManageApplyinfoBean carManageApplyinfo=list.get(i);
					//当前开始时间小于派车结束时间且大于派车开始时间
								//当前页面申请开车时间							     申请时间
					int result=carManageApplyinfoBean.getUse_starttime().compareTo(carManageApplyinfo.getUse_endtime()); 
					int result2=carManageApplyinfoBean.getUse_starttime().compareTo(carManageApplyinfo.getUse_starttime()); 
					//当前结束时间小于派车结束时间且大于派车开始时间
					int result3=carManageApplyinfoBean.getUse_endtime().compareTo(carManageApplyinfo.getUse_endtime()); 
					int result4=carManageApplyinfoBean.getUse_endtime().compareTo(carManageApplyinfo.getUse_starttime());
					//获得对应apply_id中已有的车辆
					List<CarManageCarBean> carManageCarBeanList = carManageCarDao.findCarManageCarList(carManageApplyinfo.getApply_id());
					for(int j=0;j<carManageCarBeanList.size();j++){
						//list中的车
					  	sesCarId=carManageCarBeanList.get(j).getCar_id();
						//当前num"=="list中的车"&&"申请时间在等待审批车的时间之内
						if(num.equals(sesCarId)&&((result<0&&result2>0)||(result3<0&&result4>0))){
							pc_starttime=carManageApplyinfo.getUse_starttime();
							pc_endtime=carManageApplyinfo.getUse_endtime()+"时间内被'"+carManageApplyinfo.getUse_name();
							pc_usecar=carManageCarBeanList.get(j).getCar_num();
							if(id.equals("1")){
								flag=pc_usecar+"已经在'"+pc_starttime+"-"+pc_endtime+"'申请！请更换车辆或等待审批结果！";
								break;
							}else{
								flag=pc_usecar+"已经在'"+pc_starttime+"-"+pc_endtime+"'使用！请更换车辆！";
								break;
							}
						}
					 }
				}
		}
		return flag;
	}
}

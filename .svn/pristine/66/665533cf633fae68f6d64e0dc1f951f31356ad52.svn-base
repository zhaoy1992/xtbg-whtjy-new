package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;


import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageWxbyDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageWxbyBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarManageWxbyDaoImpl implements CarManageWxbyDao {
	private static final Logger LOG = Logger.getLogger(CarManageWxbyDaoImpl.class);
	@Override
	public boolean saveCarWxInfo(CarManageWxbyBean carManageWxbyBean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" insert into YMJ_OA_WXBY_CAR");
		sql.append(" (car_id,");
		sql.append(" car_num,");
		sql.append(" type,"); 
		sql.append(" jbr,"); 
		sql.append(" wxc,");  
		sql.append(" mobile,");
		sql.append(" yjfy,");
		sql.append(" wxbyrq,");
		sql.append(" bz,");
		sql.append(" sp_state,");
		sql.append(" sp_info,"); 
		sql.append(" sjfy,"); 
		sql.append(" jbr_id) ");  
		sql.append(" values");
		sql.append(" (SEQ_YMJ_OA_WXBY_CAR.Nextval,");
		sql.append(" ?,");
		sql.append(" ?,");  
		sql.append(" ?,?,?,to_number(?),to_date(?,'yyyy-MM-dd'),?,?,?,?,?)");
		int i = 1;
		try {
			pdb.preparedInsert(sql.toString());
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getCar_num()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getType()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getJbr()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getWxc()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getMobile()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getYjfy()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getWxbyrq()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getBz()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getSp_state()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getSp_info()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getSjfy()));
			pdb.setString(i++, StringUtil.deNull(carManageWxbyBean.getJbr_id()));
			pdb.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("车辆管理=保存车辆维修失败："+e.getMessage());
			return false;
		}
		return true;
	}
		
		
		@Override
		public PagingBean findCarManageWxbyInfoList(
				CarManageWxbyBean carManageWxbyBean,
				String sortName, String sortOrder, long offset, int maxPagesize) {
			// TODO Auto-generated method stub
			PagingBean pb = new PagingBean();
			PreparedDBUtil  db = new PreparedDBUtil ();
			List<CarManageWxbyBean> list = new ArrayList<CarManageWxbyBean>();
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.car_id,");
			sql.append(" t.car_num,");
			sql.append(" t.wxc,");
			sql.append(" t.wxbyrq,");
			sql.append(" t.mobile,");
			sql.append(" decode(t.type,'1','保养','2','维修','') as type,");
			sql.append(" t.jbr,");
			sql.append(" t.jbr_id,");
			sql.append(" t.yjfy,");
			sql.append(" t.sjfy,");
			sql.append(" decode(t.sp_state,'1','等待审批','2','审批通过','3','审批未通过','') as sp_state ");
			sql.append(" from YMJ_OA_WXBY_CAR t");
			sql.append(" where 1=1");
		    // 维修保养日期
			// 车辆
			if (!StringUtil.nullOrBlank(carManageWxbyBean.getUse_starttime())) {
		    	sql.append("and t.wxbyrq >=to_date('"+carManageWxbyBean.getUse_starttime()+"', 'yyyy-MM-dd HH24:mi')");
			}
		    if (!StringUtil.nullOrBlank(carManageWxbyBean.getUse_endtime())) {
		    	sql.append("and t.wxbyrq <= to_date('"+carManageWxbyBean.getUse_endtime()+"', 'yyyy-MM-dd HH24:mi')");
			}
		    if (!StringUtil.nullOrBlank(carManageWxbyBean.getCar_num())&&!"---请选择---".equals(carManageWxbyBean.getCar_num())) {
				sql.append(" and t.car_num='"+carManageWxbyBean.getCar_num()+"'");
			}
			if (!StringUtil.nullOrBlank(carManageWxbyBean.getType())) {
				sql.append(" and t.type='"+carManageWxbyBean.getType()+"'");
			}
			if (!StringUtil.nullOrBlank(carManageWxbyBean.getSp_state_s())) {
				sql.append(" and t.sp_state!='"+carManageWxbyBean.getSp_state_s()+"'");
			}
			if (!StringUtil.nullOrBlank(carManageWxbyBean.getSp_state())) {
				sql.append(" and t.sp_state='"+carManageWxbyBean.getSp_state()+"'");
			}
			sql.append(" order by t.wxbyrq desc");
			try {
				db.preparedSelect(sql.toString(), offset, maxPagesize);
				db.executePrepared();
				for (int i = 0; i < db.size(); i++) {
					CarManageWxbyBean carWxbyBean = new CarManageWxbyBean();
					carWxbyBean.setCar_id(db.getString(i,"car_id"));
					carWxbyBean.setCar_num(db.getString(i,"car_num"));
					carWxbyBean.setWxc(db.getString(i,"wxc"));
					carWxbyBean.setWxbyrq(DateUtil.GetTimeString(db.getTimestamp(i, "wxbyrq")));
					carWxbyBean.setType(db.getString(i,"type"));
					carWxbyBean.setMobile(db.getString(i,"mobile"));
					carWxbyBean.setJbr(db.getString(i,"jbr"));
					carWxbyBean.setJbr_id(db.getString(i,"jbr_id"));
					carWxbyBean.setYjfy(db.getString(i,"yjfy"));
					carWxbyBean.setSjfy(db.getString(i,"sjfy"));
					carWxbyBean.setSp_state(db.getString(i,"sp_state"));
					list.add(carWxbyBean);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage());
			}
			pb.setList(list);
			pb.setRecords((long)db.getTotalSize());  
				
			return pb;
		}
		
		public CarManageWxbyBean findCarWxInfo(String Id) {
			PreparedDBUtil  db = new PreparedDBUtil ();
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.car_id,");
			sql.append(" t.car_num,");
			sql.append(" t.wxc,");
			sql.append(" t.wxbyrq,");
			sql.append(" decode(t.type,'1','保养','2','维修','') as type,");
			sql.append(" t.jbr,");
			sql.append(" t.mobile,");
			sql.append(" t.jbr_id,");
			sql.append(" t.yjfy,");
			sql.append(" t.bz,");
			sql.append(" t.sp_yj,");
			sql.append(" t.sjfy,");
			sql.append(" t.sp_info,");
			sql.append(" decode(t.sp_state,'1','等待审批','2','审批通过','3','审批未通过','') as sp_state ");
			sql.append(" from YMJ_OA_WXBY_CAR t");
			sql.append(" where 1=1 and car_id='"+Id+"'");
			CarManageWxbyBean carWxbyBean = new CarManageWxbyBean();
		    // 维修保养日期
			// 车辆
			try {
				db.preparedSelect(sql.toString());
				db.executePrepared();
				for (int i = 0; i < db.size(); i++) {
					carWxbyBean.setCar_id(db.getString(i,"car_id"));
					carWxbyBean.setCar_num(db.getString(i,"car_num"));
					carWxbyBean.setWxc(db.getString(i,"wxc"));
					carWxbyBean.setWxbyrq(DateUtil.GetTimeString(db.getTimestamp(i, "wxbyrq")));
					carWxbyBean.setType(db.getString(i,"type"));
					carWxbyBean.setMobile(db.getString(i,"mobile"));
					carWxbyBean.setJbr(db.getString(i,"jbr"));
					carWxbyBean.setJbr_id(db.getString(i,"jbr_id"));
					carWxbyBean.setYjfy(db.getString(i,"yjfy")+"元");
					carWxbyBean.setSp_state(db.getString(i,"sp_state"));
					carWxbyBean.setBz(db.getString(i,"bz"));
					carWxbyBean.setSp_info(db.getString(i,"sp_info"));
					carWxbyBean.setSp_yj(db.getString(i,"sp_yj"));
					carWxbyBean.setSjfy(db.getString(i,"sjfy")+"元");
				}
			} catch (Exception e) {
				e.printStackTrace();
				LOG.error(e.getMessage());
			}
			return carWxbyBean;
		}


		@Override
		public boolean carWxInfoPass(String Id,String passCase,String sp_yj) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			
			sql.append(" update YMJ_OA_WXBY_CAR set  ");
			sql.append(" sp_state=2,");
			sql.append(" sp_info=?,"); 
			sql.append(" sp_yj=?"); 
			sql.append(" where car_id=?"); 
			try {
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, StringUtil.deNull(passCase));
				pdb.setString(2, StringUtil.deNull(sp_yj));
				pdb.setString(3, StringUtil.deNull(Id));
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
				LOG.error("车辆管理=保存车辆维修失败："+e.getMessage());
				return false;
			}
			return true;
		}


		@Override
		public boolean carWxInfoNoPass(String Id,String passCase,String sp_yj) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			
			sql.append(" update YMJ_OA_WXBY_CAR set  ");
			sql.append(" sp_state=3,");
			sql.append(" sp_info=?,"); 
			sql.append(" sp_yj=?"); 
			sql.append(" where car_id=?"); 
			try {
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, StringUtil.deNull(passCase));
				pdb.setString(2, StringUtil.deNull(sp_yj));
				pdb.setString(3, StringUtil.deNull(Id));
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
				LOG.error("车辆管理=保存车辆维修失败："+e.getMessage());
				return false;
			}
			return true;
		}
		@Override
		public boolean carWxInfosjfy(String Id,String sjfy) {
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			
			sql.append(" update YMJ_OA_WXBY_CAR set  ");
			sql.append(" sjfy=?"); 
			sql.append(" where car_id=?"); 
			try {
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, StringUtil.deNull(sjfy));
				pdb.setString(2, StringUtil.deNull(Id));
				pdb.executePrepared();
			} catch (Exception e) {
				e.printStackTrace();
				LOG.error("车辆管理=保存车辆维修失败："+e.getMessage());
				return false;
			}
			return true;
		}
}

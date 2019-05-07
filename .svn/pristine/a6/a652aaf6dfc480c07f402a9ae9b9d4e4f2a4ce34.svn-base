package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.yimingju.carmanage.dao.CarEditInfoDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarEditInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarEditInfoDaoImpl implements CarEditInfoDao {

	@Override
	public List<CarEditInfoBean> list(CarEditInfoBean bean) {
		List<CarEditInfoBean> list = new ArrayList<CarEditInfoBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select e_id,pro_name,pro_num,pro_unit,think_price,price,count_price,remark,car_id from ymj_oa_carmange_car_edit");
		sql.append(" where car_id = '"+bean.getCar_id()+"'");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for(int i=0;i<pdb.size();i++){
				CarEditInfoBean bean1 = new CarEditInfoBean();
				bean1.setE_id(pdb.getString(i,"e_id"));
				bean1.setPro_name(pdb.getString(i,"pro_name"));
				bean1.setPro_num(pdb.getString(i,"pro_num"));
				bean1.setPro_unit(pdb.getString(i,"pro_unit"));
				bean1.setThink_price(pdb.getString(i,"think_price"));
				bean1.setPrice(pdb.getString(i,"price"));
				bean1.setCount_price(pdb.getString(i,"count_price"));
				bean1.setRemark(pdb.getString(i,"remark"));
				bean1.setCar_id(pdb.getString(i,"car_id"));
				list.add(bean1);
			}
			return list;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean insert(CarEditInfoBean bean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ymj_oa_carmange_car_edit (" +
				"e_id," +
				"pro_name," +
				"pro_num," +
				"pro_unit," +
				"think_price," +
				"price," +
				"count_price," +
				"remark," +
				"car_id) values (" +
				"'"+bean.getE_id()+"'," +
				"'"+bean.getPro_name()+"'," +
				"'"+bean.getPro_num()+"'," +
				"'"+bean.getPro_unit()+"'," +
				"'"+bean.getThink_price()+"'," +
				"'"+bean.getPrice()+"'," +
				"'"+bean.getCount_price()+"'," +
				"'"+bean.getRemark()+"'," +
				"'"+bean.getCar_id()+"'" +
				")");
		try {
			pdb.preparedUpdate(sql.toString());
			pdb.executePrepared();
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(CarEditInfoBean bean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from ymj_oa_carmange_car_edit where car_id = '"+bean.getCar_id()+"'");
		try {
			pdb.executeDelete(sql.toString());
		} catch (Exception e) {
			return false;
		}
		return true;
	}


}

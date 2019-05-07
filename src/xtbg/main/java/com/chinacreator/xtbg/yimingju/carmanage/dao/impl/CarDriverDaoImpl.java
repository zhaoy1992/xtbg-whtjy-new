package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarDriverDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:CarDriverDaoImpl.java</p>
 *<p>Description:发改委所用车辆管理司机信息管理固化层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-24
 */
public class CarDriverDaoImpl extends XtDbBaseDao implements CarDriverDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryDriverInfolist
	  * @param driverBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.dao.CarDriverDao#queryDriverInfolist(com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryDriverInfolist(DriverBean driverBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		List<String> values = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.driver_id,");
		sql.append("  t.driver_name,");
		sql.append("  t.driver_sex,");
		sql.append("  t.driver_car_no, ");
		sql.append("  t.driver_org_id, ");
		sql.append("  t.driver_org_name, ");
		sql.append("  to_char(t.driver_ber_date,'yyyy-MM-dd') driver_ber_date, ");
		sql.append("  to_char(Trunc(MONTHS_BETWEEN(SYSDATE,t.driver_ber_date)/12)) age, ");
		sql.append("  decode(t.driver_sort_id,'1', 'A照', '2', 'B照', '3','C照','') driver_sort_id, ");
		sql.append("  t.driver_no, ");
		sql.append("  to_char(t.driver_car_date,'yyyy-MM-dd') driver_car_date, ");
		sql.append("  t.driver_photo, ");
		sql.append("  t.driver_tel, ");
		sql.append("  to_char(t.driver_in_date,'yyyy-MM-dd') driver_in_date, ");
		sql.append("  to_char(t.driver_out_date,'yyyy-MM-dd') driver_out_date, ");
		sql.append("  t.driver_fj_id, ");
		sql.append("  t.driver_bz ");
		sql.append("  from  ta_oa_driver t");
		sql.append("              where  1=1  ");
		if(!StringUtil.isBlank(driverBean.getDriver_name())){
			sql.append("     and t.driver_name like '%"+driverBean.getDriver_name()+"%'");
		}
		if(!StringUtil.isBlank(driverBean.getDriver_sex())){
			sql.append("     and t.driver_sex = '"+driverBean.getDriver_sex()+"'");
		}
		if(!StringUtil.isBlank(driverBean.getDriver_sort_id())){
			sql.append("     and t.driver_sort_id = '"+driverBean.getDriver_sort_id()+"'");
		}
		
		
		sql.append("  order by "+ sortName+"   "+sortOrder);
		pdb.preparedSelect(sql.toString(),offset, maxPagesize);
		pdb.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, values);
		pb.setList(list);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryDriverInfoById
	  * @param driver_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.dao.CarDriverDao#queryDriverInfoById(java.lang.String)
	 */
	public List<DriverBean> queryDriverInfoById(String driver_id)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<DriverBean> list = new ArrayList<DriverBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.driver_id,");
		sql.append("  t.driver_name,");
		sql.append("  t.driver_sex,");
		sql.append("  t.driver_car_no, ");
		sql.append("  t.driver_org_id, ");
		sql.append("  t.driver_org_name, ");
		sql.append("  to_char(t.driver_ber_date,'yyyy-MM-dd') driver_ber_date, ");
		sql.append("  t.driver_sort_id, ");
		sql.append("  t.driver_no, ");
		sql.append("  to_char(t.driver_car_date,'yyyy-MM-dd') driver_car_date, ");
		sql.append("  t.driver_photo, ");
		sql.append("  t.driver_tel, ");
		sql.append("  to_char(t.driver_in_date,'yyyy-MM-dd') driver_in_date, ");
		sql.append("  to_char(t.driver_out_date,'yyyy-MM-dd') driver_out_date, ");
		sql.append("  t.driver_fj_id, ");
		sql.append("  t.driver_bz ");
		sql.append("  from  ta_oa_driver t");
		sql.append("              where  1=1  ");
		sql.append("  and  t.driver_id in ('"+driver_id+"') ");
		
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			DriverBean driverBean = new DriverBean();
			driverBean.setDriver_id(pdb.getString(i, "driver_id"));
			driverBean.setDriver_name(pdb.getString(i, "driver_name"));
			driverBean.setDriver_sex(pdb.getString(i, "driver_sex"));
			driverBean.setDriver_car_no(pdb.getString(i, "driver_car_no"));
			driverBean.setDriver_org_id(pdb.getString(i, "driver_org_id"));
			driverBean.setDriver_org_name(pdb.getString(i, "driver_org_name"));
			driverBean.setDriver_ber_time(pdb.getString(i, "driver_ber_date"));
			driverBean.setDriver_sort_id(pdb.getString(i, "driver_sort_id"));
			driverBean.setDriver_no(pdb.getString(i, "driver_no"));
			driverBean.setDriver_car_time(pdb.getString(i, "driver_car_date"));
			driverBean.setDriver_photo(pdb.getString(i, "driver_photo"));
			driverBean.setDriver_tel(pdb.getString(i, "driver_tel"));
			driverBean.setDriver_in_time(pdb.getString(i, "driver_in_date"));
			driverBean.setDriver_out_time(pdb.getString(i, "driver_out_date"));
			driverBean.setDriver_fj_id(pdb.getString(i, "driver_fj_id"));
			driverBean.setDriver_bz(pdb.getString(i, "driver_bz"));
			list.add(driverBean);
		}
		
		return list;
	}

}

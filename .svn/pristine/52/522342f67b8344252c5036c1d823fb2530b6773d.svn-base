package com.chinacreator.xtbg.yimingju.carmanage.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageYoukaDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class CarManageYoukadaoImpl extends XtDbBaseDao implements CarManageYoukaDao{

	@Override
	public PagingBean getYoukaList(CarManageYoukaBean youkaBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		List<String> values = new ArrayList<String>();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select a.t_id,");
		sql.append("       a.shenqingshiyou,");
		sql.append("       b.car_num as car_info,");
		sql.append("       a.org_name,");
		sql.append("       a.application,");
		sql.append("       a.money,");
		sql.append("       a.view_ykgly,");
		sql.append("       a.is_fafang");
		sql.append("  from TA_OA_WHTJY_YOUKA a");
		sql.append("  left join YMJ_OA_CARMANAGE_CAR  b on a.car_info = b.car_id");
		sql.append("  where a.view_ykgly = '0'");
		sql.append("  and a.is_fafang is null");
		sql.append("  order by "+ sortName+"   "+sortOrder);
		db.preparedSelect(sql.toString(),offset, maxPagesize);
		db.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, values);
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	@Override
	public CarManageYoukaBean getById(String id, Connection conn)throws Exception {
		CarManageYoukaBean bean = new CarManageYoukaBean();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select a.t_id,a.shenqingshiyou,");
		sql.append("       b.car_num as car_info,a.org_name,a.org_id,a.application,a.money,");
		sql.append("       to_char(a.application_date, 'yyyy-MM-dd') as application_date,a.creater_user_id,");
		sql.append("       a.creater_user_name,a.creater_unit_id,a.creater_unit_name,");
		sql.append("       a.creater_date,a.is_fafang,a.view_ykgly");
		sql.append("  from TA_OA_WHTJY_YOUKA a left join YMJ_OA_CARMANAGE_CAR b on a.car_info = b.car_id where a.t_id = '"+id+"'");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		if(db.size()>0){
			bean.setT_id(StringUtil.deNull(db.getString(0, "t_id")));
			bean.setShenqingshiyou(StringUtil.deNull(db.getString(0, "shenqingshiyou")));
			bean.setCar_info(StringUtil.deNull(db.getString(0, "car_info")));
			bean.setOrg_name(StringUtil.deNull(db.getString(0, "org_name")));
			bean.setOrg_id(StringUtil.deNull(db.getString(0, "org_id")));
			bean.setApplication(StringUtil.deNull(db.getString(0, "application")));
			bean.setMoney(StringUtil.deNull(db.getString(0, "money")));
			bean.setApplication_date(StringUtil.deNull(db.getString(0, "application_date")));
			bean.setCreater_user_id(StringUtil.deNull(db.getString(0, "creater_user_id")));
			bean.setCreater_user_name(StringUtil.deNull(db.getString(0, "creater_user_name")));
			bean.setCreater_unit_id(StringUtil.deNull(db.getString(0, "creater_unit_id")));
			bean.setCreater_unit_name(StringUtil.deNull(db.getString(0, "creater_unit_name")));
			bean.setCreater_date(StringUtil.deNull(db.getString(0, "creater_date")));
			bean.setIs_fafang(StringUtil.deNull(db.getString(0, "is_fafang")));
			bean.setView_ykgly(StringUtil.deNull(db.getString(0, "view_ykgly")));
		}
		return bean;
	}

	@Override
	public boolean Update(CarManageYoukaBean bean,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_whtjy_youka a");
		sql.append("   set a.is_fafang      = '1',");
		sql.append("       a.youka_no       = ?,");
		sql.append("       a.yu_e           = ?,");
		sql.append("       a.fafang_user    = ?,");
		sql.append("       a.fafang_user_id = ?,");
		sql.append("       a.fafang_date    = to_date(?, 'yyyy-MM-dd')");
		sql.append(" where a.t_id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getYouka_no());
		db.setString(2, bean.getYu_e());
		db.setString(3, bean.getFafang_user());
		db.setString(4, bean.getFafang_user_id());
		db.setString(5, bean.getFafang_date());
		db.setString(6, bean.getT_id());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public PagingBean getFafangList(CarManageYoukaBean youkaBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		List<String> value = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select a.t_id,");
		sql.append("       a.shenqingshiyou,");
		sql.append("       c.car_num as car_info, ");
		sql.append("       a.org_name,");
		sql.append("       a.org_id,");
		sql.append("       a.application,");
		sql.append("       a.money,");
		sql.append("       to_char(a.application_date, 'yyyy-MM-dd') as application_date,");
		sql.append("       a.is_fafang,");
		sql.append("       a.youka_no,");
		sql.append("       a.yu_e,");
		sql.append("       a.fafang_user,");
		sql.append("       a.fafang_user_id,");
		sql.append("       to_char(a.fafang_date, 'yyyy-MM-dd') as fafang_date,");
		sql.append("       b.ACTION_FORM as action_form,");
		sql.append("       b.INS_ID as ins_id,");
		sql.append("       b.BUSI_ID as busi_id,");
		sql.append("       b.ACTION_NAME as act_name,");
		sql.append("       b.Template_Id as template_id,");
		sql.append("       b.BUSITYPE_CODE as busitype_code");
		sql.append("  from ta_oa_whtjy_youka a");
		sql.append("  left join view_oa_instance b on a.t_id = b.BUSI_ID");
		sql.append("  left join YMJ_OA_CARMANAGE_CAR c on a.car_info = c.car_id");
		sql.append(" where a.is_fafang = '1'  and b.ACT_DEFID in ('ybbyk_wp1_act3','syzxyk_wp1_act5')");
		if(!StringUtil.nullOrBlank(youkaBean.getCar_info())){
			sql.append(" and car_info like '%"+youkaBean.getCar_info()+"%'");
		}
		if(!StringUtil.nullOrBlank(youkaBean.getOrg_name())){
			sql.append("and org_name like '%"+youkaBean.getOrg_name()+"%'");
		}
		if(!StringUtil.nullOrBlank(youkaBean.getApplication())){
			sql.append("and application like '%"+youkaBean.getApplication()+"%'");
		}
		if(!StringUtil.nullOrBlank(youkaBean.getStart_time())){
			sql.append(" and to_date('"+youkaBean.getStart_time()+"','yyyy-MM-dd') <= fafang_date");
		}
		if(!StringUtil.nullOrBlank(youkaBean.getEnd_time())){
			sql.append(" and to_date('"+youkaBean.getEnd_time()+"','yyyy-MM-dd') >= fafang_date");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
		db.preparedSelect(sql.toString(),offset, maxPagesize);
		db.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, value);
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

}

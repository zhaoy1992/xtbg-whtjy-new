package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsAccountDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 固定资产dao实现
 * @author 王淑滨
 *
 */
public class OsAccountDaoImpl extends XtDbBaseDao implements OsAccountDao{

	@Override
	public PagingBean getAccountList(OsAccountBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		List<String> value = new ArrayList<String>();
		sql.append("select org.org_id org_id,");
		sql.append("       org.org_name org_name,");
		sql.append("       to_char(officeaccounts.receive_day, 'yyyy-mm-dd') as receive_day,");
		sql.append("       officeaccounts.zccount as zccount");
		sql.append("  from td_sm_organization org");
		sql.append("  left join (select t.location_org_id, t.location_org, receive_day, zccount");
		sql.append("               from (select gdzc.location_org_id,");
		sql.append("                            gdzc.location_org,");
		sql.append("                            (select max(t.use_date)");
		sql.append("                               from ta_oa_whtjy_gdzc t");
		sql.append("                              where t.location_org_id = gdzc.location_org_id");
		if(!StringUtil.nullOrBlank(bean.getClassify())){
			sql.append("        and t.classify = '"+bean.getClassify()+"'");
		}
		sql.append("            and t.dealt is null) as receive_day,");
		sql.append("                            (select count(t.id)");
		sql.append("                               from ta_oa_whtjy_gdzc t");
		sql.append("                              where t.location_org_id = gdzc.location_org_id");
		if(!StringUtil.nullOrBlank(bean.getClassify())){
			sql.append("        and t.classify = '"+bean.getClassify()+"'");
		}
		sql.append("            and t.dealt is null) as zccount");
		sql.append("                       from ta_oa_whtjy_gdzc gdzc");
		sql.append("                      where 1 = 1");
		sql.append("                      group by gdzc.location_org_id, gdzc.location_org) t) officeaccounts");
		sql.append("    on org.org_id = officeaccounts.location_org_id");
		sql.append(" where 1 = 1");
		sql.append("   and org.parent_id <> '0'");
		if(bean.getIs_fenyuan().equals("1")){
			sql.append("   and org.org_level = '3'");
		}else{
			sql.append("   and org.org_id = '"+bean.getOrg_id()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getOrg_name())){
			sql.append("	and org.org_name like '%"+bean.getOrg_name()+"%'");
		}
		sql.append("  order by "+ sortName+"   "+sortOrder);
		db.preparedSelect(sql.toString(),offset, maxPagesize);
		db.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, value);
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean getAccountDetailList(OsAccountBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		List<String> value = new ArrayList<String>();
		sql.append("select a.id,");
		sql.append("       a.num,");
		sql.append("       a.name,");
		sql.append("       a.type_id,");
		sql.append("       a.type_name,");
		sql.append("       a.it,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.user_id,");
		sql.append("       a.user_name,");
		sql.append("       to_char(a.use_date,'yyyy-MM-dd') as use_date,");
		sql.append("       a.original_value,");
		sql.append("       a.finance_no,");
		sql.append("       a.state,");
		sql.append("       a.dealt,");
		sql.append("	   a.internal_no,");
		sql.append("	   a.bar_code,");
		sql.append("	   a.body_no,");
		sql.append("	   a.manufacturer,");
		sql.append("	   to_char(a.buy_time,'yyyy') - TO_CHAR(SYSDATE,'yyyy') as t_trsynx,");
		sql.append("	   to_char(a.this_calibration_time,'yyyy-MM-dd') as this_calibration_time,");
		sql.append("       decode(a.location_name,'','院本部',a.location_name) as location_name");
		sql.append("  from ta_oa_whtjy_gdzc a");
		sql.append("  where 1=1");
		if(!StringUtil.nullOrBlank(bean.getOrg_id())){
			sql.append("  and a.location_org_id = '"+bean.getOrg_id()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getClassify())){
			if(bean.getClassify().equals("8")){//維修保養去掉車輛處理
				sql.append(" and a.classify <> '7'");
			}else{
				sql.append("  and a.classify = '"+bean.getClassify()+"'");
			}
		}
		if(bean.getShow_baofei().equals("1")){
			sql.append("   and a.dealt is null");
		}
		if(!StringUtil.nullOrBlank(bean.getName())){
			sql.append("   and a.name like '%"+bean.getName()+"%'");
		}
		if(!StringUtil.nullOrBlank(bean.getNum())){
			sql.append("	and a.num like '%"+bean.getNum()+"%'");
		}
		if(!StringUtil.nullOrBlank(bean.getIt())){
			sql.append("	and a.it like '%"+bean.getIt()+"%'");
		}
		if(!StringUtil.nullOrBlank(bean.getOriginal_value())){
			sql.append("	and a.original_value = '"+bean.getOriginal_value()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getStart_time())){
			sql.append("	and a.use_date >= to_date('"+bean.getStart_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(bean.getEnd_time())){
			sql.append("	and a.use_date <= to_date('"+bean.getEnd_time()+"','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(bean.getState())){
			sql.append("	and a.state = '"+bean.getState()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getType_id())){
			sql.append("	and a.type_id = '"+bean.getType_id()+"'");
		}
		if(!StringUtil.nullOrBlank(bean.getLocation_org_id())){
			sql.append("	and a.location_org_id = '"+bean.getLocation_org_id()+"'");
		}
		db.preparedSelect(sql.toString(),offset, maxPagesize);
		db.executePrepared();
		list = queryToListMap(sql.toString(), offset, maxPagesize, value);
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	@Override
	public boolean insertAccount(OsAccountBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_whtjy_gdzc a(a.id,a.internal_no,a.num,a.name,a.type_id,");
		sql.append("  a.type_name,a.address,a.area,a.ownership_no,a.fazheng_date,a.it,a.manufacturer,");
		sql.append("  a.body_no,a.bar_code,a.finance_no,a.buy_time,a.original_value,a.user_id,a.user_name,");
		sql.append("  a.org_id,a.org_name,a.location_place,a.state,a.location_id,a.location_name,");
		sql.append("  a.location_org_id,a.location_org,a.classify, a.state_id,a.color,a.vin_number,a.engine_number,");
		sql.append("  a.car_number,a.displacement)values(?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'),?,?,?,?,?,");
		sql.append("  to_date(?,'yyyy-MM-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		
		db.preparedInsert(sql.toString());
		db.setString(1, bean.getId());
		db.setString(2, bean.getInternal_no());
		db.setString(3, bean.getNum());
		db.setString(4, bean.getName());
		db.setString(5,bean.getType_id());
		db.setString(6, bean.getType_name());
		db.setString(7, bean.getAddress());
		db.setString(8, bean.getArea());
		db.setString(9, bean.getOwnership_no());
		db.setString(10, bean.getFazheng_date());
		db.setString(11, bean.getIt());
		db.setString(12, bean.getManufacturer());
		db.setString(13, bean.getBody_no());
		db.setString(14, bean.getBar_code());
		db.setString(15, bean.getFinance_no());
		db.setString(16, bean.getBuy_time());
		db.setString(17, bean.getOriginal_value());
		db.setString(18, bean.getUser_id());
		db.setString(19, bean.getUser_name());
		db.setString(20, bean.getOrg_id());
		db.setString(21, bean.getOrg_name());
		db.setString(22, bean.getLocation_place());
		db.setString(23, bean.getState());
		db.setString(24, bean.getLocation_id());
		db.setString(25, bean.getLocation_name());
		db.setString(26, bean.getLocation_org_id());
		db.setString(27, bean.getLocation_org());
		db.setString(28, bean.getClassify());
		db.setString(29, bean.getState_id());
		db.setString(30, bean.getColor());
		db.setString(31, bean.getVin_number());
		db.setString(32, bean.getEngine_number());
		db.setString(33,bean.getCar_number());
		db.setString(34, bean.getDisplacement());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean updateAccount(OsAccountBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_whtjy_gdzc a set a.id = ?,");
		sql.append("       a.internal_no = ?,a.num = ?,a.name = ?,a.type_id = ?,");
		sql.append("       a.type_name = ?,a.address = ?,a.area = ?,a.ownership_no = ?,");
		sql.append("       a.fazheng_date = to_date(?, 'yyyy-MM-dd'),a.it = ?,a.manufacturer = ?,");
		sql.append("       a.body_no = ?,a.bar_code = ?,a.finance_no = ?,");
		sql.append("       a.original_value = ?,a.buy_time = to_date(?, 'yyyy-MM-dd'),");
		sql.append("       a.user_id = ?,a.user_name = ?,a.org_id = ?,");
		sql.append("       a.org_name = ?,a.location_place = ?,a.state = ?,a.dealt = ?,");
		sql.append("       a.dealt_date = to_date(?, 'yyyy-MM-dd'),a.location_id = ?,a.location_name = ?,");
		sql.append("       a.location_org_id = ?,a.location_org = ?,a.classify = ?,");
		sql.append("       a.state_id = ?,a.color = ?,a.vin_number = ?,");
		sql.append("       a.engine_number = ?,a.car_number = ?,a.displacement = ?");
		sql.append(" where a.id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getId());
		db.setString(2, bean.getInternal_no());
		db.setString(3, bean.getNum());
		db.setString(4, bean.getName());
		db.setString(5, bean.getType_id());
		db.setString(6, bean.getType_name());
		db.setString(7, bean.getAddress());
		db.setString(8, bean.getArea());
		db.setString(9, bean.getOwnership_no());
		db.setString(10, bean.getFazheng_date());
		db.setString(11, bean.getIt());
		db.setString(12, bean.getManufacturer());
		db.setString(13, bean.getBody_no());
		db.setString(14, bean.getBar_code());
		db.setString(15, bean.getFinance_no());
		db.setString(16, bean.getOriginal_value());
		db.setString(17, bean.getBuy_time());
		db.setString(18, bean.getUser_id());
		db.setString(19, bean.getUser_name());
		db.setString(20, bean.getOrg_id());
		db.setString(21, bean.getOrg_name());
		db.setString(22, bean.getLocation_place());
		db.setString(23, bean.getState());
		db.setString(24, bean.getDealt());
		db.setString(25, bean.getDealt_date());
		db.setString(26, bean.getLocation_id());
		db.setString(27, bean.getLocation_name());
		db.setString(28, bean.getLocation_org_id());
		db.setString(29, bean.getLocation_org());
		db.setString(30, bean.getClassify());
		db.setString(31, bean.getState_id());
		db.setString(32, bean.getColor());
		db.setString(33, bean.getVin_number());
		db.setString(34, bean.getEngine_number());
		db.setString(35, bean.getCar_number());
		db.setString(36, bean.getDisplacement());
		db.setString(37, bean.getId());
		db.executePrepared(conn);
		return true;
	}

	@Override
	public OsAccountBean getByID(String id, Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		OsAccountBean bean = new OsAccountBean();
		sql.append("select a.id,a.name,a.internal_no,a.num,a.type_id,a.type_name,a.address,");
		sql.append("       a.area,a.ownership_no,to_char(a.fazheng_date, 'yyyy-MM-dd') as fazheng_date,");
		sql.append("       a.it,a.manufacturer,a.body_no,a.bar_code,a.finance_no,a.original_value,");
		sql.append("       to_char(a.buy_time, 'yyyy-MM-dd') as buy_time,a.user_id,a.user_name,a.org_id,a.org_name,");
		sql.append("       to_char(a.use_date, 'yyyy-MM-dd') as use_date,a.location_place,a.state,a.location_id,");
		sql.append("       a.location_name,a.location_org_id,a.location_org,a.classify,a.state_id,");
		sql.append("       a.color,a.vin_number,a.engine_number,a.car_number,a.displacement");
		sql.append("  from ta_oa_whtjy_gdzc a");
		sql.append(" where a.id = '"+id+"'");
		db.preparedSelect(sql.toString());
		db.executePrepared(conn);
		if(db.size()>0){
			bean.setId(db.getString(0, "id"));
			bean.setName(db.getString(0, "name"));
			bean.setInternal_no(db.getString(0, "internal_no"));
			bean.setNum(db.getString(0, "num"));
			bean.setType_id(db.getString(0, "type_id"));
			bean.setType_name(db.getString(0, "type_name"));
			bean.setAddress(db.getString(0, "address"));
			bean.setArea(db.getString(0, "area"));
			bean.setOwnership_no(db.getString(0, "ownership_no"));
			bean.setFazheng_date(db.getString(0, "fazheng_date"));
			bean.setIt(db.getString(0, "it"));
			bean.setManufacturer(db.getString(0, "manufacturer"));
			bean.setBody_no(db.getString(0, "body_no"));
			bean.setBar_code(db.getString(0, "bar_code"));
			bean.setFinance_no(db.getString(0, "finance_no"));
			bean.setOriginal_value(db.getString(0, "original_value"));
			bean.setBuy_time(db.getString(0, "buy_time"));
			bean.setUser_id(db.getString(0, "user_id"));
			bean.setUser_name(db.getString(0, "user_name"));
			bean.setOrg_id(db.getString(0, "org_id"));
			bean.setOrg_name(db.getString(0, "org_name"));
			bean.setUse_date(db.getString(0, "use_date"));
			bean.setLocation_place(db.getString(0, "location_place"));
			bean.setState(db.getString(0, "state"));
			bean.setLocation_id(db.getString(0, "location_id"));
			bean.setLocation_name(db.getString(0, "location_name"));
			bean.setLocation_org_id(db.getString(0, "location_org_id"));
			bean.setLocation_org(db.getString(0, "location_org"));
			bean.setClassify(db.getString(0, "classify"));
			bean.setState_id(db.getString(0, "state_id"));
			bean.setColor(db.getString(0, "color"));
			bean.setVin_number(db.getString(0, "vin_number"));
			bean.setEngine_number(db.getString(0, "engine_number"));
			bean.setCar_number(db.getString(0, "car_number"));
			bean.setDisplacement(db.getString(0, "displacement"));
		}
		return bean;
	}

	@Override
	public boolean deleteAccount(String ids, Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete from  ta_oa_whtjy_gdzc a where a.id in (?)");
		db.preparedDelete(sql.toString());
		db.setString(1,ids);
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean changeState(OsAccountBean bean, Connection conn)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		//借用领用
		sql.append("update ta_oa_whtjy_gdzc a");
		sql.append("   set a.user_id          = ?,");
		sql.append("       a.user_name        = ?,");
		sql.append("       a.org_id           = ?,");
		sql.append("       a.org_name         = ?,");
		sql.append("       a.use_date         = to_date(?, 'yyyy-MM-dd'),");
		//调拨
		sql.append("       a.is_allocation    = ?,");
		sql.append("       a.allocation_place = ?,");
		sql.append("       a.allocation_date  = to_date(?, 'yyyy-MM-dd'),");
		//出租
		sql.append("       a.is_lease         = ?,");
		sql.append("       a.lease_place      = ?,");
		sql.append("       a.lease_date       = to_date(?, 'yyyy-MM-dd'),");
		//处置报废
		sql.append("       a.dealt       = ?,");
		sql.append("       a.dealt_date  = to_date(?, 'yyyy-MM-dd'),");

		//调拨需要更改所在地所在部门/为空则为调往院本部
		if(!StringUtil.nullOrBlank(bean.getLocation_id())){
			//状态
			sql.append("       a.state       = ?,");
			sql.append("       a.location_id     = ?,");
			sql.append("       a.location_name   = ?,");
			sql.append("       a.location_org_id = ?,");
			sql.append("       a.location_org    = ?");
			sql.append(" where a.id = ?");
		}else{
			//状态
			sql.append("       a.state       = ?");
			sql.append(" where a.id = ?");
		}
		
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getUser_id());
		db.setString(2, bean.getUser_name());
		db.setString(3, bean.getOrg_id());
		db.setString(4, bean.getOrg_name());
		db.setString(5, bean.getUse_date());
		db.setString(6, bean.getIs_allocation());
		db.setString(7, bean.getAllocation_place());
		db.setString(8, bean.getAllocation_date());
		db.setString(9, bean.getIs_lease());
		db.setString(10, bean.getLease_place());
		db.setString(11, bean.getLease_date());
		db.setString(12, bean.getDealt());
		db.setString(13, bean.getDealt_date());
		if(!StringUtil.nullOrBlank(bean.getIs_allocation())){
			db.setString(14, bean.getState());
			db.setString(15, bean.getLocation_id());
			db.setString(16, bean.getLocation_name());
			db.setString(17, bean.getLocation_org_id());
			db.setString(18, bean.getLocation_org());
			db.setString(19, bean.getId());
		}else{
			db.setString(14, bean.getState());
			db.setString(15, bean.getId());
		}
		db.executePrepared(conn);
		return true;
	}

	@Override
	public boolean updateCalibrationTime(OsAccountBean bean, Connection conn)
			throws Exception {
		
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_whtjy_gdzc a");
		sql.append("   set a.this_calibration_time = to_date(?, 'yyyy-MM-dd'),");
		sql.append("       a.next_calibration_time = add_months(to_date(?, 'yyyy-MM-dd'), 12)");
		sql.append(" where a.id = ?");
		db.preparedUpdate(sql.toString());
		db.setString(1, bean.getThis_calibration_time());
		db.setString(2, bean.getThis_calibration_time());
		db.setString(3, bean.getId());
		db.executePrepared(conn);
		return true;
	}
	
	

}


 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAccountDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevAccountInfoDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:DevAccountDaoImpl.java</p>
 *<p>Description:设备台帐dao层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevAccountInfoDaoImpl extends XtDbBaseDao implements DevAccountInfoDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevAccountList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAccountDao#selDevAccountList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevAccountList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		
		DevAccountInfo devaccount = new DevAccountInfo();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devaccount = (DevAccountInfo) JSONObject.parseObject(parmjson, DevAccountInfo.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select distinct id,");
            sql.append("      t2.t_lyorg_mc as jieyong_orgmc,");
			sql.append("       t2.t_jre_mc as jieyonguser,");
			sql.append("		t2.t_lydate,");
			sql.append("		t2.t_id as guihid,");
			sql.append("       dev_code,");
			sql.append("       dev_name,");
			sql.append("       type,");
			sql.append("       make_users,");
			sql.append("       factory_no,");
			sql.append("       to_char(creat_date,'yyyy-mm-dd') as creat_date, ");
			sql.append("       product_no,");
			sql.append("       quality_no,");
			sql.append("       user_orgid,");
			sql.append("       user_orgname,");
			sql.append("       custos_userid,");
			sql.append("       custos_username,");
			sql.append("       decode(dev_stockflag，'1','在库','2','借出','3','出租','4','调拨') as dev_stockflag,");
			sql.append("       decode(dev_state，'1','完好','2','在修','3','报废','4','损耗') as dev_state,");
			sql.append("       technical_parameters,");
			sql.append("       creater_userid,");
			sql.append("       creater_username,");
			sql.append("       to_char(creat_time,'yyyy-mm-dd') as creat_time, ");
			sql.append("       car_photo,");
			sql.append("       price,");
			sql.append("       to_char(arrive_time,'yyyy-mm-dd') as arrive_time,");
			sql.append("       remark,	");
			sql.append("       supplier.devsup_mc as devsup_mc, ");//供应商名称
			sql.append(" (select sum(total) from "); //同时检定报警增加显示或者校准记录有效期离当前日期相差小于一个月的设备。
			sql.append("    (select count(distinct dera.t_sb_id) as total ");
			sql.append("     from ta_oa_devappraisal dera ");
			sql.append("     where  sysdate + 30 > dera.appr_valitime  and dera.appr_valitime > sysdate  ");
			sql.append("     and dera.t_sb_id in(select c.id from ta_oa_devaccount c)   ");//检定
			sql.append("      union   ");
			sql.append("     select count(distinct cail.t_sb_id) as total  ");
			sql.append("     from ta_oa_devcalibraterecode cail   ");
			sql.append("     where  sysdate + 30 > cail.calib_valitime  and cail.calib_valitime > sysdate "); //校准
			sql.append("     and cail.t_sb_id in(select c.id from ta_oa_devaccount c))) as seecount ");//查看预警数字");
			sql.append("  from ta_oa_devaccount t");
			
			sql.append(" left join ta_oa_devsupplier supplier on t.devsup_id = supplier.devsup_id ");
			sql.append("   left join (select tt.t_sb_id,min(tt.t_id) as t_id,max(tt.t_lydate) as t_lydate,min(tt.t_jre_mc) as t_jre_mc ,min(tt.t_lyorg_mc)as t_lyorg_mc from TA_OA_DEVBORROW tt group by tt.t_sb_id) t2  on t.id = t2.t_sb_id ");
			sql.append("  where 1=1" );
			if(devaccount!=null){
				//查看预警 条件过滤  当前日期后面 7天的
				if (!StringUtil.nullOrBlank(devaccount.getIsseeflag())) {
					sql.append(" and ( t.id in(select sal.t_sb_id from ta_oa_devappraisal sal where sysdate+30 > sal.appr_valitime and sal.appr_valitime > sysdate ");
					sql.append("  and sal.t_sb_id in(select c.id from ta_oa_devaccount c)) ");//检定

					sql.append(" or t.id in(select cal.t_sb_id from ta_oa_devcalibraterecode cal where sysdate+30 > cal.calib_valitime and cal.calib_valitime > sysdate ");
					sql.append("  and cal.t_sb_id in(select c.id from ta_oa_devaccount c)) ) ");//校准
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devaccount.getDev_name())) {
					sql.append(" and dev_name like '%'||?||'%'");
					condition.add(devaccount.getDev_name());
				}
				//设备编号
				if (!StringUtil.nullOrBlank(devaccount.getDev_code())) {
					sql.append(" and dev_code like '%'||?||'%'");
					condition.add(devaccount.getDev_code());
				}
				//规格型号
				if (!StringUtil.nullOrBlank(devaccount.getType())) { 
					sql.append(" and type like '%'||?||'%'");
					condition.add(devaccount.getType());
				}
				//使用部门
				if (!StringUtil.nullOrBlank(devaccount.getUser_orgname())) { 
					sql.append(" and user_orgname like '%'||?||'%'");
					condition.add(devaccount.getUser_orgname());
				}
				//设备使用状态
				if (!StringUtil.nullOrBlank(devaccount.getDev_state())) { 
					if(devaccount.getDev_state().indexOf(",") != -1){
						sql.append(" and dev_state in (").append(StringUtil.splitString(devaccount.getDev_state(), ",", "'")).append(")");
					} else {
						sql.append(" and dev_state =?");
						condition.add(devaccount.getDev_state());
					}
				}
				//设备库存状态
				if (!StringUtil.nullOrBlank(devaccount.getDev_stockflag())) { 
					sql.append(" and dev_stockflag in('"+devaccount.getDev_stockflag().replace(",", "','")+"') ");
					//condition.add(devaccount.getDev_stockflag());
				}
				//保管部门单位ID
				if (!StringUtil.nullOrBlank(devaccount.getUser_unit())) { 
					sql.append(" and user_unit =?");
					condition.add(devaccount.getUser_unit());
				}
				//制造厂家
				if (!StringUtil.nullOrBlank(devaccount.getMake_users())) {
					sql.append(" and make_users like '%'||?||'%'");
					condition.add(devaccount.getMake_users());
				}
				//保管人
				if (!StringUtil.nullOrBlank(devaccount.getCustos_username())) { 
					sql.append(" and custos_username like '%'||?||'%'");
					condition.add(devaccount.getCustos_username());
				}
				//供应商
				if (!StringUtil.nullOrBlank(devaccount.getDevsup_mc())) { 
					sql.append(" and supplier.devsup_mc like '%'||?||'%'");
					condition.add(devaccount.getDevsup_mc());
				}
				//登记人
				if (!StringUtil.nullOrBlank(devaccount.getCreater_username())) { 
					sql.append(" and creater_username like '%'||?||'%'");
					condition.add(devaccount.getCreater_username());
				}
				//生产开始日期
				if (!StringUtil.nullOrBlank(devaccount.getCreat_StartDate())) { 
					sql.append(" and creat_date >= ").append(" to_date('").append(devaccount.getCreat_StartDate()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//生产结束日期
				if (!StringUtil.nullOrBlank(devaccount.getCreat_EndDate())) { 
					sql.append(" and creat_date <= ").append(" to_date('").append(devaccount.getCreat_EndDate()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//到货开始日期
				if (!StringUtil.nullOrBlank(devaccount.getArrive_StartTime())) { 
					sql.append(" and arrive_time >= ").append(" to_date('").append(devaccount.getArrive_StartTime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//到货结束日期
				if (!StringUtil.nullOrBlank(devaccount.getArrive_EndTime())) { 
					sql.append(" and arrive_time <= ").append(" to_date('").append(devaccount.getArrive_EndTime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//登记开始日期
				if (!StringUtil.nullOrBlank(devaccount.getCreat_StartTime())) { 
					sql.append(" and creat_time >= ").append(" to_date('").append(devaccount.getCreat_StartTime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
				}
				//登记结束日期
				if (!StringUtil.nullOrBlank(devaccount.getCreat_EndTime())) { 
					sql.append(" and creat_time <= ").append(" to_date('").append(devaccount.getCreat_EndTime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevAccount
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAccountDao#getDevAccount(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevAccount(String id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select id,");
		sql.append("       dev_code,");
		sql.append("       dev_name,");
		sql.append("       type,");
		sql.append("       make_users,");
		sql.append("       factory_no,");
		sql.append("       to_char(creat_date,'yyyy-mm-dd') creat_date,");
		sql.append("       product_no,");
		sql.append("       quality_no,");
		sql.append("       user_orgid,");
		sql.append("       user_orgname,");
		sql.append("       custos_userid,");
		sql.append("       custos_username,");
		sql.append("       dev_stockflag,");
		sql.append("       dev_state,");
		sql.append("       technical_parameters,");
		sql.append("       creater_userid,");
		sql.append("       creater_username,");
		sql.append("       to_char(creat_time,'yyyy-mm-dd') as creat_time,");
		sql.append("       car_photo,");
		sql.append("       price,");
		sql.append("       dev_photoid,");
		sql.append("       to_char(arrive_time,'yyyy-mm-dd') as arrive_time,");
		sql.append("       remark, ");
		sql.append("       devsup_id, ");
		sql.append("       dev_attach_id ");
		sql.append("  from ta_oa_devaccount");
		sql.append(" where id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* getDevAccountByDevCode(根据设备编号查询设备台帐)
	* @param dev_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevAccountByDevCode(String dev_code,Connection conn) throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select id,");
		sql.append("       dev_code,");
		sql.append("       dev_name,");
		sql.append("       type,");
		sql.append("       make_users,");
		sql.append("       factory_no,");
		sql.append("       to_char(creat_date,'yyyy-mm-dd') creat_date,");
		sql.append("       product_no,");
		sql.append("       quality_no,");
		sql.append("       user_orgid,");
		sql.append("       user_orgname,");
		sql.append("       custos_userid,");
		sql.append("       custos_username,");
		sql.append("       dev_stockflag,");
		sql.append("       dev_state,");
		sql.append("       technical_parameters,");
		sql.append("       creater_userid,");
		sql.append("       creater_username,");
		sql.append("       to_char(creat_time,'yyyy-mm-dd') as creat_time,");
		sql.append("       car_photo,");
		sql.append("       price,");
		sql.append("       dev_photoid,");
		sql.append("       to_char(arrive_time,'yyyy-mm-dd') as arrive_time,");
		sql.append("       remark, ");
		sql.append("       devsup_id, ");
		sql.append("       dev_attach_id ");
		sql.append("  from ta_oa_devaccount");
		sql.append(" where dev_code = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), dev_code);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* deleteDevAccount(根据id删除设备台帐)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevAccount(Connection conn,String beanId)throws Exception{
		
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devaccount ");
		sql.append(" where id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	
	
	/**
	*<b>Summary: </b>
	* getDevEquipmentacc(根据id查询政府采购设备验证信息)
	* @param t_sb_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevEquipmentacc(String t_sb_id,Connection conn) throws Exception{
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_title,");
		sql.append("       t_sbname,");
		sql.append("       t_ggno,");
		sql.append("       t_factory,");
		sql.append("       t_ccno,");
		sql.append("       to_char(t_dhdate,'yyyy-mm-dd') as t_dhdate,");
		sql.append("       t_wg,");
		sql.append("       t_hgzorzzs,");
		sql.append("       t_sbqd,");
		sql.append("       t_sbsysms,");
		sql.append("       t_sbazsms,");
		sql.append("       t_cphgz,");
		sql.append("       t_zlsms,");
		sql.append("       t_jdcsba,");
		sql.append("       t_pzorfj,");
		sql.append("       t_yhtyq,");
		sql.append("       t_other,");
		sql.append("       t_aztsqk,");
		sql.append("       t_ysjl,");
		sql.append("       t_gfysr,");
		sql.append("       to_char(t_gfysr_date,'yyyy-mm-dd') as t_gfysr_date,");
		sql.append("       t_byysr_yj,");
		sql.append("       t_sbzrgcs_yj,");
		sql.append("       t_fyjsfzr_yj,");
		sql.append("       t_sb_id,");
		sql.append("       item_id");
		sql.append("  from ta_oa_devequipmentacc ");
		sql.append(" where t_sb_id = ? ");
		viewMap = queryToSingleMap(sql.toString(), t_sb_id);
		return viewMap;
	}
	
	
	/**
	*<b>Summary: </b>
	* getDevEqAppInfo(根据id查询政府采购单信息)
	* @param id  采购明细表ID
	* @return Map
	 */
	public Map<String, String> getDevEqAppInfo(String id,Connection conn)throws Exception{
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from TA_OA_DEVAPPITEM t, TA_OA_DEVAPPLICATION info");
		sql.append(" where t.item_plainid = info.t_id");
		sql.append("   and t.item_id = ? ");
		viewMap = queryToSingleMap(sql.toString(), id);
		return viewMap;
	}


	/**
	 * 
	  * <b>Summary: 根据设备编号查询设备id</b>
	  *     复写方法 getgetDevAccountByDevCode
	  * @param dev_code
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAccountInfoDao#getgetDevAccountByDevCode(java.lang.String)
	 */
	public String getgetDevAccountByDevCode(String dev_code) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String id = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select id");
		sql.append("  from TA_OA_DEVACCOUNT t");
		sql.append("   where  t.dev_code = '"+dev_code+"'");
		
		pdb.preparedSelect(sql.toString());
		
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			id = pdb.getString(i, "id");
		}
		if (StringUtil.isBlank(id)) {
			id = "false";
		}
		return id;
	}

}

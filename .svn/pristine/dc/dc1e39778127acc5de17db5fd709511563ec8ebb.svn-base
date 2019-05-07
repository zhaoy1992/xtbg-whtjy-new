package com.chinacreator.xtbg.tjy.officesupplies.dao.impl;

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
import com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:OsHavaObjectDaoImpl.java</p>
 *<p>Description:库存数据处理dao层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-10
 */
public class OsHavaObjectDaoImpl extends XtDbBaseDao implements OsHavaObjectDao {

	/**
	 * 
	  * <b>Summary: 更新已入库的审批表的入库状态</b>
	  *     复写方法 updateOsExaState
	  * @param osExaIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateOsExaState(java.lang.String)
	 */
	public boolean updateOsExaState(String osExaIds) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		osExaIds = StringUtil.splitString(osExaIds, ",", "'");
		sql.append(" update  TA_OA_OSEXAMINATION t set t.t_osexa_isrk = '1' ");
		sql.append(" where t.t_osexa_id in ("+osExaIds+")");
		
		db.preparedUpdate(sql.toString());
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据规格ID查询库存信息</b>
	  *     复写方法 queryHavaIdByItId
	  * @param it_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryHavaIdByItId(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaIdByItId(String it_id)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
		sql.append(" select t.*,nvl(t.t_ha_no,0) as t_ha_nos from TA_OA_HAVA_OBJECT t ");
		sql.append(" where t.it_id = ?");
		
		havaValueList = queryToListMap(sql.toString(), it_id);
		return havaValueList;
	}

	/**
	 * 
	  * <b>Summary: 插入库存信息</b>
	  *     复写方法 insertOsHavaInfo
	  * @param osHavaObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#insertOsHavaInfo(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean insertOsHavaInfo(OsHavaObjectBean osHavaObjectBean)
			throws Exception {
		
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into ta_oa_hava_object( ");
		sql.append(" oftype_id,oftype_name,ofustype_id,ofustype_name,it_id,it_name, ");
		sql.append(" t_ha_buydate,t_ha_no,t_ha_dj,t_ha_bz,t_ha_id,t_ha_sbno,t_ha_ghman,t_ha_overtel,t_ha_sbstate,t_ha_ghuser,t_ha_rkuser_id,t_ha_rkuser_name,t_ha_org_id,t_ha_org_name,unit_id,unit_name) ");
		sql.append(" values (?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		db.preparedInsert(sql.toString());
		int i = 1;
		db.setString(i++, osHavaObjectBean.getOftype_id());
		db.setString(i++, osHavaObjectBean.getOftype_name());
		db.setString(i++, osHavaObjectBean.getOfustype_id());
		db.setString(i++, osHavaObjectBean.getOfustype_name());
		db.setString(i++, osHavaObjectBean.getIt_id());
		db.setString(i++, osHavaObjectBean.getIt_name());
		db.setString(i++, osHavaObjectBean.getT_ha_buydate());
		db.setString(i++, osHavaObjectBean.getT_ha_no());
		db.setString(i++, osHavaObjectBean.getT_ha_dj());
		db.setString(i++, osHavaObjectBean.getT_ha_bz());
		db.setString(i++, osHavaObjectBean.getT_ha_id());
		db.setString(i++, osHavaObjectBean.getT_ha_sbno());
		db.setString(i++, osHavaObjectBean.getT_ha_ghman());
		db.setString(i++, osHavaObjectBean.getT_ha_overtel());
		db.setString(i++, osHavaObjectBean.getT_ha_sbstate());
		db.setString(i++, osHavaObjectBean.getT_ha_ghuser());
		db.setString(i++, osHavaObjectBean.getT_ha_rkuser_id());
		db.setString(i++, osHavaObjectBean.getT_ha_rkuser_name());
		db.setString(i++, osHavaObjectBean.getT_ha_org_id());
		db.setString(i++, osHavaObjectBean.getT_ha_org_name());
		db.setString(i++, osHavaObjectBean.getUnit_id());
		db.setString(i++, osHavaObjectBean.getUnit_name());
		db.executePrepared();
		return true;
	}

	/**
	*<b>Summary: </b>
	* deleteOsHavaById(根据id删除库存基本信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsHavaById(Connection conn,String beanId)throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_hava_object ");
		sql.append(" where t_ha_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: 更新库存信息</b>
	  *     复写方法 updateOsHavaInfo
	  * @param osHavaObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateOsHavaInfo(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean updateOsHavaInfo(OsHavaObjectBean osHavaObjectBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update  TA_OA_HAVA_OBJECT t set t.oftype_id = ?, t.oftype_name = ?, t.ofustype_id = ?, t.ofustype_name = ?, ");
		sql.append("  t.it_id = ?, t.it_name = ?, t.t_ha_buydate = to_date(?,'yyyy-MM-dd'), t.t_ha_no = ?, ");
		sql.append("  t.t_ha_dj = ?,t.t_ha_bz = ?, t_ha_sbno = ?, t_ha_ghman = ?, t_ha_overtel = ?, t_ha_sbstate = ?,");
		sql.append("  t_ha_ghuser = ?, t_ha_rkuser_id = ?, t_ha_rkuser_name = ?, t_ha_org_id=?, t_ha_org_name=? ,unit_id = ?, unit_name = ? ");
		sql.append("  where t.t_ha_id = ?");
		db.preparedUpdate(sql.toString());
		int i = 1;
		db.setString(i++, osHavaObjectBean.getOftype_id());
		db.setString(i++, osHavaObjectBean.getOftype_name());
		db.setString(i++, osHavaObjectBean.getOfustype_id());
		db.setString(i++, osHavaObjectBean.getOfustype_name());
		db.setString(i++, osHavaObjectBean.getIt_id());
		db.setString(i++, osHavaObjectBean.getIt_name());
		db.setString(i++, osHavaObjectBean.getT_ha_buydate());
		db.setString(i++, osHavaObjectBean.getT_ha_no());
		db.setString(i++, osHavaObjectBean.getT_ha_dj());
		db.setString(i++, osHavaObjectBean.getT_ha_bz());
		db.setString(i++, osHavaObjectBean.getT_ha_sbno());
		db.setString(i++, osHavaObjectBean.getT_ha_ghman());
		db.setString(i++, osHavaObjectBean.getT_ha_overtel());
		db.setString(i++, osHavaObjectBean.getT_ha_sbstate());
		db.setString(i++, osHavaObjectBean.getT_ha_ghuser());
		db.setString(i++, osHavaObjectBean.getT_ha_rkuser_id());
		db.setString(i++, osHavaObjectBean.getT_ha_rkuser_name());
		db.setString(i++, osHavaObjectBean.getT_ha_org_id());
		db.setString(i++, osHavaObjectBean.getT_ha_org_name());
		db.setString(i++, osHavaObjectBean.getUnit_id());
		db.setString(i++, osHavaObjectBean.getUnit_name());
		db.setString(i++, osHavaObjectBean.getT_ha_id());
		db.executePrepared();
		return true;
	}

	/**
	 * 
	  * <b>Summary: 查询固定资产类型</b>
	  *     复写方法 queryNoMoveTypeSelect
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryNoMoveTypeSelect()
	 */
	public List<Map<String, String>> queryNoMoveTypeSelect() throws Exception {
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
		sql.append(" select * from TA_OA_OSUPPLIETYPE t ");
		sql.append(" where 1=? and t.oftype_flag = '1' ");
		
		havaValueList = queryToListMap(sql.toString(), "1");
		return havaValueList;
	}

	/**
	 * 
	  * <b>Summary: 查询库存物品列表</b>
	  *     复写方法 findOsHavaObjectList
	  * @param osHavaObjectBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#findOsHavaObjectList(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsHavaObjectList(OsHavaObjectBean osHavaObjectBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsHavaObjectBean> list = new ArrayList<OsHavaObjectBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.t_ha_id,b.oftype_id,b.oftype_name,b.ofustype_id,");
		sql.append(" b.ofustype_name,b.it_id,item.it_name,b.t_ha_dj,b.t_ha_no,");
		sql.append(" decode(b.t_ha_sbstate,'1','在库','2','领用 ','3','在修','4','报废')t_ha_sbstate,");
		sql.append(" b.t_ha_bz,b.t_ha_rkuser_id,b.t_ha_rkuser_name,");
		sql.append(" to_char(b.t_ha_rkuser_date,'yyyy-MM-dd')as t_ha_rkuser_date,");
		sql.append(" b.t_ha_org_id,b.t_ha_org_name,b.unit_id,b.unit_name");
		sql.append(" from TA_OA_HAVA_OBJECT b  left join ta_oa_osusertypeitem item on b.it_id = item.it_id where 1=1");
		if(!StringUtil.isBlank(osHavaObjectBean.getOfustype_name())){
			sql.append(" and b.ofustype_name like '%"+osHavaObjectBean.getOfustype_name()+"%'");
		}
		if(!StringUtil.isBlank(osHavaObjectBean.getOftype_id())){
			sql.append(" and b.oftype_id = '"+osHavaObjectBean.getOftype_id()+"'");
		}
		if(!StringUtil.isBlank(osHavaObjectBean.getUnit_id())){
			sql.append(" and b.unit_id = '"+osHavaObjectBean.getUnit_id()+"'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsHavaObjectBean bean = new OsHavaObjectBean();
			bean.setT_ha_id(db.getString(i, "t_ha_id"));
			bean.setOftype_id(db.getString(i, "oftype_id"));
			bean.setOftype_name(db.getString(i, "oftype_name"));
			bean.setOfustype_id(db.getString(i, "ofustype_id"));
			bean.setOfustype_name(db.getString(i, "ofustype_name"));
			bean.setIt_id(db.getString(i, "it_id"));
			bean.setIt_name(db.getString(i, "it_name"));
			bean.setT_ha_dj(db.getString(i, "t_ha_dj"));
			bean.setT_ha_no(db.getString(i, "t_ha_no"));
			bean.setT_ha_sbstate(db.getString(i, "t_ha_sbstate"));
			bean.setT_ha_bz(db.getString(i, "t_ha_bz"));
			bean.setT_ha_rkuser_id(db.getString(i, "t_ha_rkuser_id"));
			bean.setT_ha_rkuser_name(db.getString(i, "t_ha_rkuser_name"));
			bean.setT_ha_rkuser_date(db.getString(i, "t_ha_rkuser_date"));
			bean.setT_ha_org_id(db.getString(i, "t_ha_org_id"));
			bean.setT_ha_org_name(db.getString(i, "t_ha_org_name"));
			bean.setUnit_id(db.getString(i, "unit_id"));
			bean.setUnit_name(db.getString(i, "unit_name"));
			list.add(bean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: 查询固定资产库存状态列表</b>
	  *     复写方法 findOsHavaNoMoveObjectList
	  * @param osHavaObjectBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#findOsHavaNoMoveObjectList(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsHavaNoMoveObjectList(
			OsHavaObjectBean osHavaObjectBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsHavaObjectBean> list = new ArrayList<OsHavaObjectBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select t.oftype_name,");
		sql.append("   count(t.t_ha_id) zs, ");
		sql.append("   count(t1.t_ha_id) zk, ");
		sql.append("   count(t2.t_ha_id) ly, ");
		sql.append("   count(t3.t_ha_id) zx, ");
		sql.append("   count(t4.t_ha_id) bf ");
		sql.append("    from TA_OA_HAVA_OBJECT t ");
		sql.append("       left join TA_OA_OSUPPLIETYPE os");
		sql.append("       on t.oftype_id = os.oftype_id");
		sql.append("       left join (select t.t_ha_id");
		sql.append("       from TA_OA_HAVA_OBJECT t");
		sql.append("       where t.t_ha_sbstate = '1') t1");
		sql.append("       on t.t_ha_id = t1.t_ha_id");
		sql.append("       left join (select t.t_ha_id");
		sql.append("       from TA_OA_HAVA_OBJECT t");
		sql.append("       where t.t_ha_sbstate = '2') t2");
		sql.append("       on t.t_ha_id = t2.t_ha_id");
		sql.append("       left join (select t.t_ha_id");
		sql.append("       from TA_OA_HAVA_OBJECT t");
		sql.append("       where t.t_ha_sbstate = '3') t3");
		sql.append("       on t.t_ha_id = t3.t_ha_id");
		sql.append("       left join (select t.t_ha_id");
		sql.append("        from TA_OA_HAVA_OBJECT t");
		sql.append("        where t.t_ha_sbstate = '4') t4");
		sql.append("       on t.t_ha_id = t4.t_ha_id");
		sql.append("       where 1 = 1");
		
		
	
		if (!StringUtil.isBlank(osHavaObjectBean.getT_ha_iswhat())) {
			sql.append("   and os.oftype_flag = ? ");
		}
		if (!StringUtil.isBlank(osHavaObjectBean.getStartSlTime())) {
			sql.append("   and t.t_ha_buydate >= to_date(?,'yyyy-MM-dd') ");
		}
		if (!StringUtil.isBlank(osHavaObjectBean.getEndSlTime())) {
			sql.append("    and t.t_ha_buydate <= to_date(?,'yyyy-MM-dd') ");
		}
		if (!StringUtil.isBlank(osHavaObjectBean.getOfustype_name())) {
			sql.append("    and t.ofustype_name like '%"+osHavaObjectBean.getOfustype_name()+"%'");
		}
		
		
		sql.append("       group by t.oftype_id,t.oftype_name");
		//sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	
    	int k = 1;
    	if (!StringUtil.isBlank(osHavaObjectBean.getT_ha_iswhat())) {
    		db.setString(k++, osHavaObjectBean.getT_ha_iswhat());
		}
    	if (!StringUtil.isBlank(osHavaObjectBean.getStartSlTime())) {
    		db.setString(k++, osHavaObjectBean.getStartSlTime());
		}
    	if (!StringUtil.isBlank(osHavaObjectBean.getEndSlTime())) {
    		db.setString(k++, osHavaObjectBean.getEndSlTime());
		}
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsHavaObjectBean osHavaObjectBeanDb = new OsHavaObjectBean();
			
			osHavaObjectBeanDb.setOftype_id(db.getString(i, "oftype_id"));
			osHavaObjectBeanDb.setOftype_name(db.getString(i, "oftype_name")); 
			osHavaObjectBeanDb.setZs(db.getString(i, "zs"));        //设备总数
			osHavaObjectBeanDb.setBf(db.getString(i, "bf"));      //报废数
			osHavaObjectBeanDb.setZk(db.getString(i, "zk"));       //在库数
			osHavaObjectBeanDb.setZx(db.getString(i, "zx"));            //在修数
			osHavaObjectBeanDb.setLy(db.getString(i, "ly"));            //领用数
			
			list.add(osHavaObjectBeanDb);
			
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: 查询已审核过的未入库的计划表列表</b>
	  *     复写方法 findOsAppList
	  * @param osApplanBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#findOsAppList(com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsAppList(OsApplanBean osApplanBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsApplanBean> list = new ArrayList<OsApplanBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_id)t_id ,t.t_org_id,t.t_org_name,");
		sql.append("   to_char(t.t_creator_time,'yyyy-MM-dd')t_creator_time,t.t_title,t.t_user_name ");
		sql.append("   from TA_OA_OSAPPLAN t, view_oa_instance v ");
		sql.append("       where t.t_id = v.BUSI_ID");
		sql.append("       and v.STATUS_CODE = '02'");  //已办结数据
		sql.append("       and t.t_state = '1' ");      //已审核过得数据
		sql.append("       and t.T_IS_LQ is null  ");   //未领用
		//展示当前用户发起的已办结的计划表。
		if(!StringUtil.isBlank(osApplanBean.getT_user_id())){
			sql.append("   and t.t_user_id ='"+osApplanBean.getT_user_id()+"'");   //当前申请人ID
		}
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsApplanBean osApplanBeanDb = new OsApplanBean();
			osApplanBeanDb.setT_id(db.getString(i, "t_id"));
			osApplanBeanDb.setT_org_id(db.getString(i, "t_org_id"));
			osApplanBeanDb.setT_org_name(db.getString(i, "t_org_name"));
			osApplanBeanDb.setT_creator_time(db.getString(i, "t_creator_time"));
			osApplanBeanDb.setT_title(db.getString(i, "t_title"));
			osApplanBeanDb.setT_user_name(db.getString(i, "t_user_name"));
			list.add(osApplanBeanDb);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: 根据计划表IDS查询出相应的物品列表</b>
	  *     复写方法 selectOsAppObjectByIds
	  * @param osAppIds
	  * @param bus_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#selectOsAppObjectByIds(java.lang.String, java.lang.String)
	 */
	public List<Map<String, String>> selectOsAppObjectByIds(String osAppIds,
			String bus_id) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		String staute_code = "";
		
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" select v.STATUS_CODE from view_oa_instance v,TA_OA_OSAPPREGYHP t");
		sql2.append(" where t.T_APPREGYHP_ID = v.BUSI_ID");
		sql2.append(" and t.T_APPREGYHP_ID = ?");
		
		pdb.preparedSelect(sql2.toString());
		pdb.setString(1, bus_id);
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			staute_code = pdb.getString(i,"STATUS_CODE");
		}
		
		List<Map<String, String>> osAppItemObjectList = new ArrayList<Map<String,String>>();
		osAppIds = StringUtil.splitString(osAppIds, ",", "'");
		
		sql.append("   select t.t_os_ob_id ,t.t_id,t.t_org_id,t.t_org_name,os.oftype_id,os.oftype_name,");
		sql.append("   t.ofustype_id,t.ofustype_name,t.it_id,t.it_name,t.t_os_ob_no,t.t_os_ob_bz ");
		sql.append("   from TA_OA_OSAPP_OBJECT t left join TA_OA_OSAPPLAN o on t.t_id=o.t_id");
		sql.append("   left join  TA_OA_OSUPPLIEUSETYPE op on t.ofustype_id=op.ofustype_id");
		sql.append("   left join  TA_OA_OSUPPLIETYPE os on op.oftype_id=os.oftype_id");
		if (staute_code.equals("02")) {  //已经审核完的数据
			sql.append("   where 1=1  and o.t_state ='1' and t.t_id in (" +osAppIds+") ");
		}else{
			sql.append("   where 1=1 and o.t_state ='1' and o.T_IS_LQ is null and t.t_id in (" +osAppIds+") ");
		}
		
		
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for (int i = 0; i < pdb.size(); i++) {
			Map<String,String> osAppItemObjectMap = new HashMap<String, String>();
			osAppItemObjectMap.put("t_os_ob_id", pdb.getString(i, "t_os_ob_id"));
			osAppItemObjectMap.put("t_id", pdb.getString(i, "t_id"));
			osAppItemObjectMap.put("t_org_id", pdb.getString(i, "t_org_id"));
			osAppItemObjectMap.put("t_org_name", pdb.getString(i, "t_org_name"));
			osAppItemObjectMap.put("ofustype_id", pdb.getString(i, "ofustype_id"));
			osAppItemObjectMap.put("ofustype_name", pdb.getString(i, "ofustype_name"));
			osAppItemObjectMap.put("it_id", pdb.getString(i, "it_id"));
			osAppItemObjectMap.put("it_name", pdb.getString(i, "it_name"));
			osAppItemObjectMap.put("t_os_ob_no", pdb.getString(i, "t_os_ob_no"));
			osAppItemObjectMap.put("t_os_ob_bz", pdb.getString(i, "t_os_ob_bz"));
			osAppItemObjectMap.put("oftype_id", pdb.getString(i, "oftype_id"));
			osAppItemObjectMap.put("oftype_name", pdb.getString(i, "oftype_name"));
			osAppItemObjectList.add(osAppItemObjectMap);
		}
		
		return osAppItemObjectList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsAppRegObject
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#deleteOsAppRegObject(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteOsAppRegObject(String t_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_OSAPPREG_OBJECT ");
		sql.append(" where T_APPREGYHP_ID in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, t_id);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新相关计划表申领状态</b>
	  *     复写方法 updateOsApplanState
	  * @param ids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateOsApplanState(java.lang.String, java.sql.Connection)
	 */
	public boolean updateOsApplanState(String ids, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		String appIds = StringUtil.splitString(ids, ",", "'");
		sql.append(" update TA_OA_OSAPPLAN t set t.T_IS_LQ='1' ");
		sql.append(" where t.T_ID in ");
		sql.append("  ("+appIds+")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据易耗品申领登记表ID查询对应的计划表ids</b>
	  *     复写方法 queryAppIdsForAppRegId
	  * @param appRegid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryAppIdsForAppRegId(java.lang.String)
	 */
	public String queryAppIdsForAppRegId(String appRegid) throws Exception {
		StringBuffer sql = new StringBuffer();
		String appIds = "";
		sql.append(" select t.T_APPREGYHP_APPIDS  ");
		sql.append(" from TA_OA_OSAPPREGYHP t ");
		sql.append(" where t.T_APPREGYHP_ID = '"+appRegid+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for (int i = 0; i < pdb.size(); i++) {
			appIds = pdb.getString(i,"T_APPREGYHP_APPIDS");
		}
		return appIds;
	}

	/**
	 * 
	  * <b>Summary: 根据易耗品申领登记表ID查询对应的物品列表</b>
	  *     复写方法 selectOsAppRegObjectByregId
	  * @param appRegId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#selectOsAppRegObjectByregId(java.lang.String)
	 */
	public List<Map<String, String>> selectOsAppRegObjectByregId(String appRegId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> appRegObjectList = new ArrayList<Map<String,String>>();
		
		sql.append("select t_osappreg_ob_id,");
		sql.append("       t_appregyhp_id,");
		sql.append("       t.oftype_id as oftype_id,");
		sql.append("       ostype.oftype_name as oftype_name,");
		sql.append("       t.ofustype_id,");
		sql.append("       t.ofustype_name as ofustype_name,");
		sql.append("       t.it_id as it_id,");
		sql.append("       item.it_name as it_name,");
		sql.append("       t_osappreg_ob_no,");
		sql.append("       t_osappreg_ob_bz,");
		sql.append("       add_state,");
		sql.append("       t.p_type_id,");
		sql.append("       t.p_type_name,");
		sql.append("	   t.org_name");
		sql.append("  from TA_OA_OSAPPREG_OBJECT t");
		sql.append("  left join ta_oa_osusertypeitem item on t.it_id=item.it_id");
		sql.append("  left join ta_oa_osupplieusetype usertype on t.ofustype_id = usertype.ofustype_id");
		sql.append("  left join ta_oa_osupplietype ostype on t.oftype_id = ostype.oftype_id");
		sql.append(" where t.t_appregyhp_id = ?  ");
		sql.append(" order by add_state desc");

		appRegObjectList = queryToListMap(sql.toString(), appRegId);
		
		return appRegObjectList;
	}

	/**
	 * 
	  * <b>Summary: 易耗品领用后更新数量</b>
	  *     复写方法 updateOsHavaObjectAfterLY
	  * @param osHavaObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateOsHavaObjectAfterLY(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean updateOsHavaObjectAfterLY(OsHavaObjectBean osHavaObjectBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update  TA_OA_HAVA_OBJECT t set ");
		sql.append("  t.t_ha_no = ? ");
		sql.append("  where t.t_ha_id = ?");
		
		db.preparedUpdate(sql.toString());
		
		int i = 1;
		db.setString(i++, osHavaObjectBean.getT_ha_no());
		
		db.setString(i++, osHavaObjectBean.getT_ha_id());
		
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据库存ids查询出物品信息</b>
	  *     复写方法 queryHavaObjectByHaIds
	  * @param haIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryHavaObjectByHaIds(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaObjectByHaIds(String haIds,String bus_id)
			throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		
		String staute_code = "";
		
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" select v.STATUS_CODE from view_oa_instance v,TA_OA_OSNOMOVE t");
		sql2.append(" where t.T_OSNOM_ID = v.BUSI_ID");
		sql2.append(" and t.T_OSNOM_ID = ?");
		
		db.preparedSelect(sql2.toString());
		db.setString(1, bus_id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			staute_code = db.getString(i,"STATUS_CODE");
		}
		
		haIds = StringUtil.splitString(haIds, ",", "'");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_ha_id)t_ha_id ,t.oftype_id,t.oftype_name,");
		sql.append("   to_char(t.t_ha_buydate,'yyyy-MM-dd')t_ha_buydate,t.ofustype_id,t.ofustype_name, ");
		sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
		sql.append("   t.t_ha_ghman,t.t_ha_overtel,t.t_ha_dj, ");
		sql.append("   t.t_ha_no,t.t_ha_sbstate,t.t_ha_ghuser, ");
		sql.append("   t.t_ha_bz,t.t_ha_rkuser_id,t.t_ha_rkuser_name ");
		sql.append("   from TA_OA_HAVA_OBJECT t, TA_OA_OSUPPLIETYPE os ");
		sql.append("       where t.oftype_id = os.oftype_id");
		sql.append("       and os.oftype_flag = '1'");  //固定资产
		sql.append("       and t.t_ha_id in ("+haIds+")");
		
		if (staute_code.equals("02")) {  //已经审核完的数据
			
		}else{
			sql.append("       and t.t_ha_sbstate in ('1','2') ");
		}
		//排序 
		sql.append(" order by t.oftype_name,t.ofustype_name,t.it_name   ");
    	db.preparedSelect(sql.toString());
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			Map<String, String>  map = new HashMap<String, String>();
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("it_id", db.getString(i, "it_id"));
			map.put("it_name", db.getString(i, "it_name"));
			map.put("oftype_id", db.getString(i, "oftype_id"));
			map.put("oftype_name", db.getString(i, "oftype_name"));
			map.put("ofustype_id", db.getString(i, "ofustype_id"));
			map.put("ofustype_name", db.getString(i, "ofustype_name"));
			map.put("t_ha_buydate", db.getString(i, "t_ha_buydate"));
			map.put("t_ha_no", db.getString(i, "t_ha_no"));
			map.put("t_ha_dj", db.getString(i, "t_ha_dj"));
			map.put("t_ha_bz", db.getString(i, "t_ha_bz"));
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("t_ha_rkuser_id", db.getString(i, "t_ha_rkuser_id"));
			map.put("t_ha_rkuser_name", db.getString(i, "t_ha_rkuser_name"));
			map.put("t_ha_sbno", db.getString(i, "t_ha_sbno"));
			map.put("t_ha_ghman", db.getString(i, "t_ha_ghman"));
			map.put("t_ha_overtel", db.getString(i, "t_ha_overtel"));
			map.put("t_ha_sbstate", db.getString(i, "t_ha_sbstate"));//状态  1在库  2领用   3在修  4报废
			map.put("t_ha_ghuser", db.getString(i, "t_ha_ghuser"));
			
			list.add(map);
			
	    }
	   return list;
	}

	/**
	 * 
	  * <b>Summary: 插入物品领用表</b>
	  *     复写方法 insertHavaLYObject
	  * @param osHavaLYObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#insertHavaLYObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean)
	 */
	public boolean insertHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into ta_oa_lingyong_object( ");
		sql.append(" t_ly_id,oftype_id,oftype_name,ofustype_id,ofustype_name,it_id,it_name,t_ha_sbno,t_ly_date,t_ly_no,t_ly_org_id, ");
		sql.append(" t_ly_org_name,t_ly_user_id,t_ly_user_name,t_lydj_id,t_ha_id) ");
		sql.append(" values (?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd'),?,?,?,?,?,?,?)");
		
		db.preparedInsert(sql.toString());
		
		int i = 1;
		db.setString(i++, osHavaLYObjectBean.getT_ly_id());
		db.setString(i++, osHavaLYObjectBean.getOftype_id());
		db.setString(i++, osHavaLYObjectBean.getOftype_name());
		db.setString(i++, osHavaLYObjectBean.getOfustype_id());
		db.setString(i++, osHavaLYObjectBean.getOfustype_name());
		db.setString(i++, osHavaLYObjectBean.getIt_id());
		db.setString(i++, osHavaLYObjectBean.getIt_name());
		db.setString(i++, osHavaLYObjectBean.getT_ha_sbno());
		db.setString(i++, osHavaLYObjectBean.getT_ly_date());
		db.setString(i++, osHavaLYObjectBean.getT_ly_no());
		db.setString(i++, osHavaLYObjectBean.getT_ly_org_id());
		db.setString(i++, osHavaLYObjectBean.getT_ly_org_name());
		
		db.setString(i++, osHavaLYObjectBean.getT_ly_user_id());
		db.setString(i++, osHavaLYObjectBean.getT_ly_user_name());
		db.setString(i++, osHavaLYObjectBean.getT_lydj_id());
		
		db.setString(i++, osHavaLYObjectBean.getT_ha_id());
		
		
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新物品领用表</b>
	  *     复写方法 updateHavaLYObject
	  * @param osHavaLYObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateHavaLYObject(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean)
	 */
	public boolean updateHavaLYObject(OsHavaLYObjectBean osHavaLYObjectBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ta_oa_lingyong_object t set t_ly_id = ?, oftype_id = ?, oftype_name = ?, ofustype_id = ?, ofustype_name = ?, ");
		sql.append("  it_id = ?, it_name = ?, t_ha_sbno = ?, t_ly_date = ?, t_ly_no = ?, t_ly_org_id = ?, ");
		sql.append("  t_ly_org_name = ?, t_ly_user_id = ?, t_ly_user_name = ?, t_lydj_id = ?, t_ha_id = ? ");
		sql.append("  where t.t_ly_id = ?");
		
		db.preparedUpdate(sql.toString());
		
		int i = 1;
		db.setString(i++, osHavaLYObjectBean.getT_ly_id());
		db.setString(i++, osHavaLYObjectBean.getOftype_id());
		db.setString(i++, osHavaLYObjectBean.getOftype_name());
		db.setString(i++, osHavaLYObjectBean.getOfustype_id());
		db.setString(i++, osHavaLYObjectBean.getOfustype_name());
		db.setString(i++, osHavaLYObjectBean.getIt_id());
		db.setString(i++, osHavaLYObjectBean.getIt_name());
		db.setString(i++, osHavaLYObjectBean.getT_ha_sbno());
		db.setString(i++, osHavaLYObjectBean.getT_ly_date());
		db.setString(i++, osHavaLYObjectBean.getT_ly_no());
		db.setString(i++, osHavaLYObjectBean.getT_ly_org_id());
		db.setString(i++, osHavaLYObjectBean.getT_ly_org_name());
		
		db.setString(i++, osHavaLYObjectBean.getT_ly_user_id());
		db.setString(i++, osHavaLYObjectBean.getT_ly_user_name());
		db.setString(i++, osHavaLYObjectBean.getT_lydj_id());
		
		db.setString(i++, osHavaLYObjectBean.getT_ha_id());
		db.setString(i++, osHavaLYObjectBean.getT_ly_id());
		
		
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据固定资产领用登记表id删除物品</b>
	  *     复写方法 deleteOsNoMoveObject
	  * @param busi_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#deleteOsNoMoveObject(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteOsNoMoveObject(String busi_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_NOMOVE_OBJECT ");
		sql.append(" where T_OSNOM_ID in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, busi_id);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据ids更新库存设备状态</b>
	  *     复写方法 updateHavaObjectForIds
	  * @param havaIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateHavaObjectForIds(java.lang.String)
	 */
	public boolean updateHavaObjectForIds(String havaIds) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		havaIds = StringUtil.splitString(havaIds, ",", "'");
		sql.append(" update  TA_OA_HAVA_OBJECT t set t.t_ha_sbstate = '2' ");
		sql.append(" where t.t_ha_id in ("+havaIds+")");
		
		db.preparedUpdate(sql.toString());
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 固定资产ID查询物品信息</b>
	  *     复写方法 queryNoMoveObjectForRegId
	  * @param bus_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryNoMoveObjectForRegId(java.lang.String)
	 */
	public List<Map<String, String>> queryNoMoveObjectForRegId(String bus_id)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> noMoveObjectList = new ArrayList<Map<String,String>>();
		
		sql.append("  select t.*,t1.t_ha_sbno from TA_OA_NOMOVE_OBJECT t");
		sql.append("  left join ta_oa_hava_object t1 on t.t_ha_id = t1.t_ha_id");
		sql.append("  where t.T_OSNOM_ID = ? ");
		
		noMoveObjectList = queryToListMap(sql.toString(), bus_id);
		
		return noMoveObjectList;
	}

	/**
	 * 
	  * <b>Summary: 固定资产申领表ID查询相关库存物品IDs</b>
	  *     复写方法 queryHavaIdsForRegId
	  * @param bus_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryHavaIdsForRegId(java.lang.String)
	 */
	public String queryHavaIdsForRegId(String bus_id) throws Exception {
		StringBuffer sql = new StringBuffer();
		String appIds = "";
		sql.append(" select t.T_HAVA_IDS  ");
		sql.append(" from TA_OA_OSNOMOVE t ");
		sql.append(" where t.T_OSNOM_ID = '"+bus_id+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for (int i = 0; i < pdb.size(); i++) {
			appIds = pdb.getString(i,"T_HAVA_IDS");
		}
		return appIds;
	}

	/**
	 * 
	  * <b>Summary: 物品领用列表</b>
	  *     复写方法 findOsHavaLYObjectList
	  * @param osHavaLYObjectBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#findOsHavaLYObjectList(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsHavaLYObjectList(
			OsHavaLYObjectBean osHavaLYObjectBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		//查询易耗品 数量总和
		OsHavaLYObjectBean osHavaLYObjectBeanSum = findOsHavaLYSumSL(osHavaLYObjectBean);
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsHavaLYObjectBean> list = new ArrayList<OsHavaLYObjectBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_ly_id)t_ly_id ,t.oftype_id,t.oftype_name,");
		sql.append("   to_char(t.t_ly_date,'yyyy-MM-dd')t_ly_date,t.ofustype_id,t.ofustype_name, ");
		sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
		sql.append("   t.t_ly_no,t.t_ly_org_id, ");
		sql.append("   t.t_ly_org_name,t.t_ly_user_id,t.t_ly_user_name, ");
		sql.append("   t.t_lydj_id,t.t_ha_id ");
		sql.append("   from TA_OA_LINGYONG_OBJECT t, TA_OA_OSUPPLIETYPE os ");
		sql.append("       where t.oftype_id = os.oftype_id");
	
		if (!StringUtil.isBlank(osHavaLYObjectBean.getUnit_id())) {
			sql.append("   and os.unit_id = ? ");
		}
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_iswhat())) {
			sql.append("   and os.oftype_flag = ? ");
		}
		//设备名称
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOfustype_name())) {
			sql.append("   and t.ofustype_name like '%"+osHavaLYObjectBean.getOfustype_name()+"%' ");
		}
		//设备类别
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_id())) {
			sql.append("   and t.oftype_id = '"+osHavaLYObjectBean.getOftype_id()+"' ");
		}
		//设备类别名称  易耗品
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_name())) {
			sql.append("   and t.oftype_name like '%"+osHavaLYObjectBean.getOftype_name()+"%' ");
		}
		//设备规格名称  易耗品
		if (!StringUtil.isBlank(osHavaLYObjectBean.getIt_name())) {
			sql.append("   and t.it_name like '%"+osHavaLYObjectBean.getIt_name()+"%' ");
		}
		//设备编号
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_sbno())) {
			sql.append("   and t.t_ha_sbno like '%"+osHavaLYObjectBean.getT_ha_sbno()+"%' ");
		}
		//领用人
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_name())) {
			sql.append("   and t.t_ly_user_name like '%"+osHavaLYObjectBean.getT_ly_user_name()+"%' ");
		}
		//领用科室
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_org_name())) {
			sql.append("   and t.t_ly_org_name like '%"+osHavaLYObjectBean.getT_ly_org_name()+"%' ");
		}
		//领用时间
		if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getStart_time())) {
			sql.append(" and t.t_ly_date >=to_date('"+osHavaLYObjectBean.getStart_time()+"','yyyy-mm-dd ')");

		}
		if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getEnd_time())) {
			sql.append(" and t.t_ly_date <=to_date('").append(osHavaLYObjectBean.getEnd_time() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");

		}
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_id())) {
			sql.append("   and t.t_ly_user_id = ? ");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	
    	int k = 1;
    	if (!StringUtil.isBlank(osHavaLYObjectBean.getUnit_id())) {
    		db.setString(k++, osHavaLYObjectBean.getUnit_id());
		}
    	if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_iswhat())) {
    		db.setString(k++, osHavaLYObjectBean.getT_ha_iswhat());
		}
    	if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_id())) {
    		db.setString(k++, osHavaLYObjectBean.getT_ly_user_id());
		}
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsHavaLYObjectBean osHavaLYObjectBeanDb = new OsHavaLYObjectBean();
			
			osHavaLYObjectBeanDb.setIt_id(db.getString(i, "it_id"));
			osHavaLYObjectBeanDb.setIt_name(db.getString(i, "it_name"));
			osHavaLYObjectBeanDb.setOftype_id(db.getString(i, "oftype_id"));
			osHavaLYObjectBeanDb.setOftype_name(db.getString(i, "oftype_name"));
			osHavaLYObjectBeanDb.setOfustype_id(db.getString(i, "ofustype_id"));
			osHavaLYObjectBeanDb.setOfustype_name(db.getString(i, "ofustype_name"));
			osHavaLYObjectBeanDb.setT_ly_date(db.getString(i, "t_ly_date"));
			osHavaLYObjectBeanDb.setT_ly_no(db.getString(i, "t_ly_no"));
			osHavaLYObjectBeanDb.setT_ly_org_id(db.getString(i, "t_ly_org_id"));
			osHavaLYObjectBeanDb.setT_ly_org_name(db.getString(i, "t_ly_org_name"));
			osHavaLYObjectBeanDb.setT_ha_id(db.getString(i, "t_ha_id"));
			osHavaLYObjectBeanDb.setT_ly_user_id(db.getString(i, "t_ly_user_id"));
			osHavaLYObjectBeanDb.setT_ly_user_name(db.getString(i, "t_ly_user_name"));
			osHavaLYObjectBeanDb.setT_ha_sbno(db.getString(i, "t_ha_sbno"));
			osHavaLYObjectBeanDb.setT_lydj_id(db.getString(i, "t_lydj_id"));
			osHavaLYObjectBeanDb.setT_ly_id(db.getString(i, "t_ly_id"));
			//设置查询易耗品数量总和
			osHavaLYObjectBeanDb.setSumNo(osHavaLYObjectBeanSum.getSumNo());
			
			list.add(osHavaLYObjectBeanDb);
			
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	  * <b>Summary: 物品领用列表</b>
	  *     复写方法 findOsHavaLYObjectList
	  * @param osHavaLYObjectBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#findOsHavaLYObjectList(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaLYObjectBean, java.lang.String, java.lang.String, long, int)
	 */
	public OsHavaLYObjectBean findOsHavaLYSumSL(
			OsHavaLYObjectBean osHavaLYObjectBean) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select sum(t.t_ly_no) as sumNo ");
		sql.append("   from TA_OA_LINGYONG_OBJECT t, TA_OA_OSUPPLIETYPE os ");
		sql.append("       where t.oftype_id = os.oftype_id");
	
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_iswhat())) {
			sql.append("   and os.oftype_flag = ? ");
		}
		//设备名称
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOfustype_name())) {
			sql.append("   and t.ofustype_name like '%"+osHavaLYObjectBean.getOfustype_name()+"%' ");
		}
		//设备类别
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_id())) {
			sql.append("   and t.oftype_id = '"+osHavaLYObjectBean.getOftype_id()+"' ");
		}
		//设备类别名称  易耗品
		if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_name())) {
			sql.append("   and t.oftype_name like '%"+osHavaLYObjectBean.getOftype_name()+"%' ");
		}
		//设备规格名称  易耗品
		if (!StringUtil.isBlank(osHavaLYObjectBean.getIt_name())) {
			sql.append("   and t.it_name like '%"+osHavaLYObjectBean.getIt_name()+"%' ");
		}
		//设备编号
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_sbno())) {
			sql.append("   and t.t_ha_sbno like '%"+osHavaLYObjectBean.getT_ha_sbno()+"%' ");
		}
		//领用人
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_name())) {
			sql.append("   and t.t_ly_user_name like '%"+osHavaLYObjectBean.getT_ly_user_name()+"%' ");
		}
		//领用科室
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_org_name())) {
			sql.append("   and t.t_ly_org_name like '%"+osHavaLYObjectBean.getT_ly_org_name()+"%' ");
		}
		//领用时间
		if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getStart_time())) {
			sql.append(" and t.t_ly_date >=to_date('"+osHavaLYObjectBean.getStart_time()+"','yyyy-mm-dd ')");

		}
		if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getEnd_time())) {
			sql.append(" and t.t_ly_date <=to_date('").append(osHavaLYObjectBean.getEnd_time() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");

		}
		if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_id())) {
			sql.append("   and t.t_ly_user_id = ? ");
		}
		
    	db.preparedSelect(sql.toString());
    	
    	int k = 1;
    	if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_iswhat())) {
    		db.setString(k++, osHavaLYObjectBean.getT_ha_iswhat());
		}
    	if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_id())) {
    		db.setString(k++, osHavaLYObjectBean.getT_ly_user_id());
		}
    	
    	db.executePrepared();
    	OsHavaLYObjectBean osHavaLYObjectBeanDb = new OsHavaLYObjectBean();
    	if(db.size()>=1){
			osHavaLYObjectBeanDb.setSumNo(db.getString(0, "sumNo"));
	    }
		return osHavaLYObjectBeanDb;
	}
	/**
	 * 
	  * <b>Summary: 根据主键查询库存物品信息</b>
	  *     复写方法 queryHavaObjectByHaId
	  * @param haId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryHavaObjectByHaId(java.lang.String)
	 */
	public List<Map<String, String>> queryHavaObjectByHaId(String haId)
			throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		haId = StringUtil.splitString(haId, ",", "'");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_ha_id)t_ha_id ,t.oftype_id,t.oftype_name,");
		sql.append("   to_char(t.t_ha_buydate,'yyyy-MM-dd')t_ha_buydate,t.ofustype_id,t.ofustype_name, ");
		sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
		sql.append("   t.t_ha_ghman,t.t_ha_overtel,t.t_ha_dj, ");
		sql.append("   t.t_ha_no,t.t_ha_sbstate,t.t_ha_ghuser, ");
		sql.append("   t.t_ha_bz,t.t_ha_rkuser_id,t.t_ha_rkuser_name, ");
		sql.append("   t_ha_org_id,t_ha_org_name ");
		sql.append("   from TA_OA_HAVA_OBJECT t, TA_OA_OSUPPLIETYPE os ");
		sql.append("       where t.oftype_id = os.oftype_id");
		sql.append("       and os.oftype_flag = '1'");  //固定资产
		sql.append("       and t.t_ha_id in ("+haId+")");
	
    	db.preparedSelect(sql.toString());
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			Map<String, String>  map = new HashMap<String, String>();
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("it_id", db.getString(i, "it_id"));
			map.put("it_name", db.getString(i, "it_name"));
			map.put("oftype_id", db.getString(i, "oftype_id"));
			map.put("oftype_name", db.getString(i, "oftype_name"));
			map.put("ofustype_id", db.getString(i, "ofustype_id"));
			map.put("ofustype_name", db.getString(i, "ofustype_name"));
			map.put("t_ha_buydate", db.getString(i, "t_ha_buydate"));
			map.put("t_ha_no", db.getString(i, "t_ha_no"));
			map.put("t_ha_dj", db.getString(i, "t_ha_dj"));
			map.put("t_ha_bz", db.getString(i, "t_ha_bz"));
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("t_ha_rkuser_id", db.getString(i, "t_ha_rkuser_id"));
			map.put("t_ha_rkuser_name", db.getString(i, "t_ha_rkuser_name"));
			map.put("t_ha_sbno", db.getString(i, "t_ha_sbno"));
			map.put("t_ha_ghman", db.getString(i, "t_ha_ghman"));
			map.put("t_ha_overtel", db.getString(i, "t_ha_overtel"));
			map.put("t_ha_sbstate", db.getString(i, "t_ha_sbstate"));//状态  1在库  2领用   3在修  4报废
			map.put("t_ha_ghuser", db.getString(i, "t_ha_ghuser"));
			map.put("t_ha_org_id", db.getString(i, "t_ha_org_id"));//所属部门ID
			map.put("t_ha_org_name", db.getString(i, "t_ha_org_name"));//所属部门名称
			
			
			list.add(map);
			
	    }
	   return list;
	}

	/**
	 * 
	  * <b>Summary: 修改固定资产设备状态</b>
	  *     复写方法 updateHavaObjectStateByHaIds
	  * @param havaIds
	  * @param state
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateHavaObjectStateByHaIds(java.lang.String, java.lang.String)
	 */
	public boolean updateHavaObjectStateByHaIds(String havaIds, String state)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		havaIds = StringUtil.splitString(havaIds, ",", "'");
		sql.append(" update  TA_OA_HAVA_OBJECT t set t.t_ha_sbstate = '"+state+"'");
		sql.append(" where t.t_ha_id in ("+havaIds+")");
		
		db.preparedUpdate(sql.toString());
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据主键查询领用物品信息</b>
	  *     复写方法 queryMyObjectByLyId
	  * @param lyId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#queryMyObjectByLyId(java.lang.String)
	 */
	public List<Map<String, String>> queryMyObjectByLyId(String lyId)
			throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		lyId = StringUtil.splitString(lyId, ",", "'");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_ly_id)t_ly_id ,t.oftype_id,t.oftype_name,");
		sql.append("   to_char(t.t_ly_date,'yyyy-MM-dd')t_ly_date,t.ofustype_id,t.ofustype_name, ");
		sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
		sql.append("   t.t_ly_no,t.t_ly_org_id, ");
		sql.append("   t.t_ly_org_name,t.t_ly_user_id,t.t_ly_user_name, ");
		sql.append("   t.t_lydj_id,t.t_ha_id ");
		sql.append("   from TA_OA_LINGYONG_OBJECT t, TA_OA_OSUPPLIETYPE os ");
		sql.append("       where t.oftype_id = os.oftype_id");
		//sql.append("       and os.oftype_flag = '1'");  //固定资产
		sql.append("       and t.t_ly_id in ("+lyId+")");
	
    	db.preparedSelect(sql.toString());
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			Map<String, String>  map = new HashMap<String, String>();
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("it_id", db.getString(i, "it_id"));
			map.put("it_name", db.getString(i, "it_name"));
			map.put("oftype_id", db.getString(i, "oftype_id"));
			map.put("oftype_name", db.getString(i, "oftype_name"));
			map.put("ofustype_id", db.getString(i, "ofustype_id"));
			map.put("ofustype_name", db.getString(i, "ofustype_name"));
			map.put("t_ly_date", db.getString(i, "t_ly_date"));
			map.put("t_ly_no", db.getString(i, "t_ly_no"));
			map.put("t_ly_org_id", db.getString(i, "t_ly_org_id"));
			map.put("t_ly_org_name", db.getString(i, "t_ly_org_name"));
			map.put("t_ly_user_id", db.getString(i, "t_ly_user_id"));
			map.put("t_ly_user_name", db.getString(i, "t_ly_user_name"));
			map.put("t_lydj_id", db.getString(i, "t_lydj_id"));
			map.put("t_ha_sbno", db.getString(i, "t_ha_sbno"));
			map.put("t_ly_id", db.getString(i, "t_ly_id"));
			
			list.add(map);
			
	    }
	   return list;
	}

	/**
	 * 
	  * <b>Summary: 更新物品审批表已入库物品数量</b>
	  *     复写方法 updateOsexaObjectRKNO
	  * @param osexa_id
	  * @param t_osexa_obrk_no
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateOsexaObjectRKNO(java.lang.String, java.lang.String)
	 */
	public boolean updateOsexaObjectRKNO(String osexa_id, String t_osexa_obrk_no)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update  TA_OA_OSEXA_OBJECT t set t.t_osexa_obrk_no = '"+t_osexa_obrk_no+"'");
		sql.append(" where t.t_osexa_ob_id = '"+osexa_id+"'");
		
		db.preparedUpdate(sql.toString());
		db.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新库存物品所属部门</b>
	  *     复写方法 updateHavaObjectOrg
	  * @param osHavaObjectBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao#updateHavaObjectOrg(com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean)
	 */
	public boolean updateHavaObjectOrg(OsHavaObjectBean osHavaObjectBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update  TA_OA_HAVA_OBJECT t set t.t_ha_org_id = ?, t.t_ha_org_name = ?,t.t_ha_sbno=? ");
		sql.append(" where t.t_ha_id = ?");
		
		db.preparedUpdate(sql.toString());
		int i = 1 ;
		db.setString(i++, osHavaObjectBean.getT_ha_org_id());
		db.setString(i++, osHavaObjectBean.getT_ha_org_name());
		db.setString(i++, osHavaObjectBean.getT_ha_sbno());
		db.setString(i++, osHavaObjectBean.getT_ha_id());
		db.executePrepared();
		
		return true;
	}
	
	
	/**
	*<b>Summary: </b>
	* queryHavaObjectBySbCode(根据设备编号 查询库存物品信息)
	* @param t_ha_sbno
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryHavaObjectBySbCode(String t_ha_sbno) throws Exception{
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t_ha_id,");
		sql.append("       oftype_id,");
		sql.append("       oftype_name,");
		sql.append("       ofustype_id,");
		sql.append("       ofustype_name,");
		sql.append("       it_id,");
		sql.append("       it_name,");
		sql.append("       t_ha_sbno,");
		sql.append("       t_ha_buydate,");
		sql.append("       t_ha_ghman,");
		sql.append("       t_ha_overtel,");
		sql.append("       t_ha_dj,");
		sql.append("       t_ha_no,");
		sql.append("       t_ha_sbstate,");
		sql.append("       t_ha_ghuser,");
		sql.append("       t_ha_bz,");
		sql.append("       t_ha_rkuser_id,");
		sql.append("       t_ha_rkuser_name,");
		sql.append("       t_ha_org_id,");
		sql.append("       t_ha_org_name ");
		sql.append("  from TA_OA_HAVA_OBJECT ");
		sql.append("  where t_ha_sbno ='"+t_ha_sbno+"'");
    	db.preparedSelect(sql.toString());
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			Map<String, String>  map = new HashMap<String, String>();
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("it_id", db.getString(i, "it_id"));
			map.put("it_name", db.getString(i, "it_name"));
			map.put("oftype_id", db.getString(i, "oftype_id"));
			map.put("oftype_name", db.getString(i, "oftype_name"));
			map.put("ofustype_id", db.getString(i, "ofustype_id"));
			map.put("ofustype_name", db.getString(i, "ofustype_name"));
			map.put("t_ha_buydate", db.getString(i, "t_ha_buydate"));
			map.put("t_ha_no", db.getString(i, "t_ha_no"));
			map.put("t_ha_dj", db.getString(i, "t_ha_dj"));
			map.put("t_ha_bz", db.getString(i, "t_ha_bz"));
			map.put("t_ha_id", db.getString(i, "t_ha_id"));
			map.put("t_ha_rkuser_id", db.getString(i, "t_ha_rkuser_id"));
			map.put("t_ha_rkuser_name", db.getString(i, "t_ha_rkuser_name"));
			map.put("t_ha_sbno", db.getString(i, "t_ha_sbno"));
			map.put("t_ha_ghman", db.getString(i, "t_ha_ghman"));
			map.put("t_ha_overtel", db.getString(i, "t_ha_overtel"));
			map.put("t_ha_sbstate", db.getString(i, "t_ha_sbstate"));//状态  1在库  2领用   3在修  4报废
			map.put("t_ha_ghuser", db.getString(i, "t_ha_ghuser"));
			map.put("t_ha_org_id", db.getString(i, "t_ha_org_id"));//所属部门ID
			map.put("t_ha_org_name", db.getString(i, "t_ha_org_name"));//所属部门名称
			list.add(map);
			
	    }
	   return list;
	}

	@Override
	public PagingBean findOsHavaList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		OsHavaObjectBean havaObjectBean = new OsHavaObjectBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				havaObjectBean = (OsHavaObjectBean) JSONObject.parseObject(parmjson, OsHavaObjectBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("   select distinct(t.t_ha_id)t_ha_id ,t.oftype_id,t.oftype_name,");
			sql.append("   to_char(t.t_ha_buydate,'yyyy-MM-dd')t_ha_buydate,t.ofustype_id,t.ofustype_name, ");
			sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
			sql.append("   t.t_ha_ghman,t.t_ha_overtel,t.t_ha_dj,t.t_ha_org_id,t.t_ha_org_name, ");
			sql.append("   t.t_ha_no,decode(t.t_ha_sbstate,'1','在库','2','领用 ','3','在修','4','报废')t_ha_sbstate,t.t_ha_ghuser, ");
			sql.append("   t.t_ha_bz,t.t_ha_rkuser_id,t.t_ha_rkuser_name,  ");
			sql.append("   (select count(*)   ");
			sql.append("                   from TA_OA_HAVA_OBJECT objs, TA_OA_NOMOVE_OBJECT mobjs");
			sql.append("                  where objs.t_ha_id = t.t_ha_id");
			sql.append("                    and objs.t_ha_id = mobjs.t_ha_id) as amidAct");//没有关联任何在办流程的物品
			sql.append("   from TA_OA_HAVA_OBJECT t, TA_OA_OSUPPLIETYPE os ");
			sql.append("       where t.oftype_id = os.oftype_id");
			
			if (!StringUtil.isBlank(havaObjectBean.getUnit_id())) {
				sql.append("   and t.unit_id = ? ");
				condition.add(havaObjectBean.getUnit_id());
			}
			if (!StringUtil.isBlank(havaObjectBean.getT_ha_iswhat())) {
				sql.append("   and os.oftype_flag = ? ");
				condition.add(havaObjectBean.getT_ha_iswhat());
			}
			if (!StringUtil.isBlank(havaObjectBean.getStartSlTime())) {
				//sql.append("   and t.t_ha_buydate >= to_date(?,'yyyy-MM-dd') ");
				sql.append(" and t.t_ha_buydate >= ").append(" to_date('").append(havaObjectBean.getStartSlTime()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
			}
			if (!StringUtil.isBlank(havaObjectBean.getEndSlTime())) {
				//sql.append("    and t.t_ha_buydate <= to_date(?,'yyyy-MM-dd') ");
				sql.append(" and t.t_ha_buydate <= ").append(" to_date('").append(havaObjectBean.getEndSlTime()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
			}
			if (!StringUtil.isBlank(havaObjectBean.getOfustype_name())) {
				sql.append("    and t.ofustype_name like '%"+havaObjectBean.getOfustype_name()+"%'");
			}
			if (!StringUtil.isBlank(havaObjectBean.getT_ha_sbstate())) {
				sql.append("   and t.t_ha_sbstate = ? ");
				condition.add(havaObjectBean.getT_ha_sbstate());
			}
			if (!StringUtil.isBlank(havaObjectBean.getT_ha_org_id())) {
				sql.append("   and t.t_ha_org_id = ? ");
				condition.add(havaObjectBean.getT_ha_org_id());
			}
			if (!StringUtil.isBlank(havaObjectBean.getIt_name())) {
				sql.append("   and t.it_name like '%"+havaObjectBean.getIt_name()+"%' ");
			}
			
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public PagingBean findOsHavaLYObjectList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		OsHavaLYObjectBean osHavaLYObjectBean = new OsHavaLYObjectBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osHavaLYObjectBean = (OsHavaLYObjectBean) JSONObject.parseObject(parmjson, OsHavaLYObjectBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("   select distinct(t.t_ly_id)t_ly_id ,t.oftype_id,t.oftype_name,");
			sql.append("   to_char(t.t_ly_date,'yyyy-MM-dd')t_ly_date,t.ofustype_id,t.ofustype_name, ");
			sql.append("   t.it_id,t.it_name,t.t_ha_sbno, ");
			sql.append("   t.t_ly_no,t.t_ly_org_id, ");
			sql.append("   t.t_ly_org_name,t.t_ly_user_id,t.t_ly_user_name, ");
			sql.append("   t.t_lydj_id,t.t_ha_id ");
			sql.append("   from TA_OA_LINGYONG_OBJECT t, TA_OA_OSUPPLIETYPE os ");
			sql.append("       where t.oftype_id = os.oftype_id");
			if (!StringUtil.isBlank(osHavaLYObjectBean.getUnit_id())) {
				sql.append("   and os.unit_id = ? ");
				condition.add(osHavaLYObjectBean.getUnit_id());
			}
			if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_iswhat())) {
				sql.append("   and os.oftype_flag = ? ");
				condition.add(osHavaLYObjectBean.getT_ha_iswhat());
			}
			//设备名称
			if (!StringUtil.isBlank(osHavaLYObjectBean.getOfustype_name())) {
				sql.append("   and t.ofustype_name like '%"+osHavaLYObjectBean.getOfustype_name()+"%' ");
			}
			//设备类别
			if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_id())) {
				sql.append("   and t.oftype_id = '"+osHavaLYObjectBean.getOftype_id()+"' ");
			}
			//设备类别名称  易耗品
			if (!StringUtil.isBlank(osHavaLYObjectBean.getOftype_name())) {
				sql.append("   and t.oftype_name like '%"+osHavaLYObjectBean.getOftype_name()+"%' ");
			}
			//设备规格名称  易耗品
			if (!StringUtil.isBlank(osHavaLYObjectBean.getIt_name())) {
				sql.append("   and t.it_name like '%"+osHavaLYObjectBean.getIt_name()+"%' ");
			}
			//设备编号
			if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ha_sbno())) {
				sql.append("   and t.t_ha_sbno like '%"+osHavaLYObjectBean.getT_ha_sbno()+"%' ");
			}
			//领用人
			if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_name())) {
				sql.append("   and t.t_ly_user_name like '%"+osHavaLYObjectBean.getT_ly_user_name()+"%' ");
			}
			//领用科室
			if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_org_name())) {
				sql.append("   and t.t_ly_org_name like '%"+osHavaLYObjectBean.getT_ly_org_name()+"%' ");
			}
			//领用时间
			if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getStart_time())) {
				sql.append(" and t.t_ly_date >=to_date('").append(osHavaLYObjectBean.getStart_time() + "00:00:00").append("','yyyy-MM-dd hh24:mi:ss')");
			}
			if (!StringUtil.nullOrBlank(osHavaLYObjectBean.getEnd_time())) {
				sql.append(" and t.t_ly_date <=to_date('").append(osHavaLYObjectBean.getEnd_time() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
			}
			if (!StringUtil.isBlank(osHavaLYObjectBean.getT_ly_user_id())) {
				sql.append("   and t.t_ly_user_id = ? ");
				condition.add(osHavaLYObjectBean.getT_ly_user_id());
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}

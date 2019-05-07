package com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsAppObjectBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsApplanBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsExaBean;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaObjectBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:OsExaminationObjectDaoImpl.java</p>
 *<p>Description:申购审批物品及相关计划表处理dao层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public class OsExaminationObjectDaoImpl extends XtDbBaseDao implements
		OsExaminationObjectDao {

	/**
	 * 
	  * <b>Summary: 根据ids查询出相关计划表数据</b>
	  *     复写方法 selectOsAppByIds
	  * @param osAppIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#selectOsAppByIds(java.lang.String)
	 */
	public List<Map<String, String>> selectOsAppByIds(String osAppIds,String bus_id)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		String staute_code = "";
		
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" select v.STATUS_CODE from view_oa_instance v,TA_OA_DETOSEXAMINATION t");
		sql2.append(" where t.t_osexa_id = v.BUSI_ID");
		sql2.append(" and t.t_osexa_id = ?");
		
		pdb.preparedSelect(sql2.toString());
		pdb.setString(1, bus_id);
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			staute_code = pdb.getString(i,"STATUS_CODE");
		}
		
		List<Map<String, String>> osAppItemList = new ArrayList<Map<String,String>>();
		osAppIds = StringUtil.splitString(osAppIds, ",", "'");
		
		sql.append("   select t.t_id ,t.t_org_id,t.t_org_name,");
		sql.append("   to_char(t.t_creator_time,'yyyy-MM-dd')t_creator_time,t.t_title,t.t_user_name ");
		
		if (staute_code.equals("02")) {  //已经审核完的数据
			sql.append("   from TA_OA_DETOSAPPLAN t where t.t_id in (" +osAppIds+")");
		}else{
			sql.append("   from TA_OA_DETOSAPPLAN t where t.t_id in (" +osAppIds+") and t.t_state is null");
		}
		
		
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for (int i = 0; i < pdb.size(); i++) {
			Map<String,String> osAppItemMap = new HashMap<String, String>();
			osAppItemMap.put("t_id", pdb.getString(i, "t_id"));
			osAppItemMap.put("t_org_id", pdb.getString(i, "t_org_id"));
			osAppItemMap.put("t_org_name", pdb.getString(i, "t_org_name"));
			osAppItemMap.put("t_creator_time", pdb.getString(i, "t_creator_time"));
			osAppItemMap.put("t_title", pdb.getString(i, "t_title"));
			osAppItemMap.put("t_user_name", pdb.getString(i, "t_user_name"));
			osAppItemList.add(osAppItemMap);
		}
		
		return osAppItemList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findOsAppList
	  * @param osExaminationBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#findOsAppList(com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsExaminationBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsAppList(OsApplanBean osApplanBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsApplanBean> list = new ArrayList<OsApplanBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_id)t_id ,t.t_org_id,t.t_org_name,");
		sql.append("   to_char(t.t_creator_time,'yyyy-MM-dd')t_creator_time,t.t_title,t.t_user_name ");
		sql.append("   from TA_OA_DETOSAPPLAN t, view_oa_instance v ");
		sql.append("       where t.t_id = v.BUSI_ID");
		sql.append("       and v.STATUS_CODE = '02'");  //已办结数据
		sql.append("       and t.t_state is null");      //未审核过得数据
		if(!StringUtil.nullOrBlank(osApplanBean.getUnit_id())){
			sql.append("       and t.unit_id = '"+osApplanBean.getUnit_id()+"'");      //所属单位
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
	  * <b>Summary: 根据计划表id查询出相应的物品列表</b>
	  *     复写方法 selectOsAppObjectByIds
	  * @param osAppIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#selectOsAppObjectByIds(java.lang.String)
	 */
	public List<Map<String, String>> selectOsAppObjectByIds(String osAppIds,String bus_id)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String staute_code = "";
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" select v.STATUS_CODE from view_oa_instance v,TA_OA_DETOSEXAMINATION t");
		sql2.append(" where t.t_osexa_id = v.BUSI_ID");
		sql2.append(" and t.t_osexa_id = ?");
		pdb.preparedSelect(sql2.toString());
		pdb.setString(1, bus_id);
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			staute_code = pdb.getString(i,"STATUS_CODE");
		}
		
		List<Map<String, String>> osAppItemObjectList = new ArrayList<Map<String,String>>();
		osAppIds = StringUtil.splitString(osAppIds, ",", "'");
		
		sql.append("   select t.t_os_ob_id ,t.t_id,t.t_org_id,t.t_org_name,");
		sql.append("   t.ofustype_id,t.ofustype_name,t.it_id,t.it_name,t.t_os_ob_no,t.t_os_ob_bz ");
		sql.append("   from TA_OA_DETOSAPP_OBJECT t, TA_OA_DETOSAPPLAN o");
		if (staute_code.equals("02")) {  //已经审核完的数据
			sql.append("   where t.t_id=o.t_id and t.t_id in (" +osAppIds+") ");
		}else{
			sql.append("   where t.t_id=o.t_id and o.t_state is null and t.t_id in (" +osAppIds+") ");
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
			osAppItemObjectList.add(osAppItemObjectMap);
		}
		return osAppItemObjectList;
	}

	/**
	 * 
	  * <b>Summary: 根据计划审批表id查询出物品列表</b>
	  *     复写方法 selectOsExaObject
	  * @param t_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#selectOsExaObject(java.lang.String)
	 */
	public List<Map<String, String>> selectOsExaObject(String t_id)
			throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_osexa_ob_id,");
		sql.append("       t_osexa_id,");
		sql.append("       t_osexa_ob_org_ids,");
		sql.append("       t_osexa_ob_org_names,");
		sql.append("       t.ofustype_id as ofustype_id, ");
		sql.append("       usertype.ofustype_name as ofustype_name,");
		sql.append("       t.it_id as it_id,");
		sql.append("       item.it_name as it_name,");
		sql.append("       t_osexa_ob_no,");
		sql.append("       t_osexa_ob_dj,");
		sql.append("       t_osexa_ob_bz,");
		sql.append("       t_osexa_obrk_no,");
		sql.append("       t_os_ob_ids");
		sql.append("  from TA_OA_DETOSEXA_OBJECT t");
		sql.append("  left join TA_OA_DETOSUSERTYPEITEM item on t.it_id=item.it_id");
		sql.append("  left join TA_OA_DETOSUPPLIEUSETYPE usertype on t.ofustype_id = usertype.ofustype_id");
		sql.append(" where T_OSEXA_ID =  ? ");
		sql.append(" order by to_char(t_osexa_ob_org_ids)");
		viewMap = queryToListMap(sql.toString(), t_id);
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: 根据计划审批表id删除物品</b>
	  *     复写方法 deleteOsExaObject
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#deleteOsExaObject(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteOsExaObject(String t_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_DETOSEXA_OBJECT ");
		sql.append(" where T_OSEXA_ID in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, t_id);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新相关计划表审批状态</b>
	  *     复写方法 updateOsApplanState
	  * @param ids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#updateOsApplanState(java.lang.String, java.sql.Connection)
	 */
	public boolean updateOsApplanState(String ids, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		String appIds = StringUtil.splitString(ids, ",", "'");
		sql.append(" update TA_OA_DETOSAPPLAN t set t.T_STATE='1' ");
		sql.append(" where t.T_ID in ");
		sql.append("  ("+appIds+")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryOsAppIdsForExaId
	  * @param exaId
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#queryOsAppIdsForExaId(java.lang.String)
	 */
	public String queryOsAppIdsForExaId(String exaId) throws Exception {
		StringBuffer sql = new StringBuffer();
		String exaIds = "";
		sql.append(" select t.T_IDS  ");
		sql.append(" from TA_OA_DETOSEXAMINATION t ");
		sql.append(" where t.T_OSEXA_ID = '"+exaId+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			exaIds = pdb.getString(i,"T_IDS");
		}
		return exaIds;
	}

	/**
	 * 
	  * <b>Summary: 根据计划审批表ids查询出物品列表</b>
	  *     复写方法 selectOsExaObjectByIds
	  * @param t_ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#selectOsExaObjectByIds(java.lang.String)
	 */
	public List<Map<String, String>> selectOsExaObjectByIds(String t_ids)
			throws Exception {
		List<Map<String, String>> osExaObjectList = new ArrayList<Map<String, String>>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		t_ids =  StringUtil.splitString(t_ids, ",", "'");
		sql.append("  select t.*,os.oftype_id,ost.oftype_name");
		sql.append("  from TA_OA_DETOSEXA_OBJECT t,TA_OA_DETOSUPPLIEUSETYPE os , TA_OA_DETOSUPPLIETYPE ost");
		sql.append("  where t.ofustype_id = os.ofustype_id and os.oftype_id=ost.oftype_id and  t.T_OSEXA_ID in ("+t_ids+") ");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String>  valueMap = new HashMap<String, String>();
			valueMap.put("t_osexa_ob_id", pdb.getString(i, "t_osexa_ob_id"));
			valueMap.put("t_osexa_ob_org_ids", pdb.getString(i, "t_osexa_ob_org_ids"));
			valueMap.put("t_osexa_ob_org_names", pdb.getString(i, "t_osexa_ob_org_names"));
			valueMap.put("ofustype_id", pdb.getString(i, "ofustype_id"));
			valueMap.put("ofustype_name", pdb.getString(i, "ofustype_name"));
			valueMap.put("it_id", pdb.getString(i, "it_id"));
			valueMap.put("it_name", pdb.getString(i, "it_name"));
			valueMap.put("t_osexa_ob_no", pdb.getString(i, "t_osexa_ob_no"));
			valueMap.put("t_osexa_ob_dj", pdb.getString(i, "t_osexa_ob_dj"));
			valueMap.put("t_osexa_ob_bz", pdb.getString(i, "t_osexa_ob_bz"));
			valueMap.put("oftype_id", pdb.getString(i, "oftype_id"));
			valueMap.put("oftype_name", pdb.getString(i, "oftype_name"));
			valueMap.put("t_osexa_obrk_no", pdb.getString(i, "t_osexa_obrk_no"));
			valueMap.put("t_osexa_id", pdb.getString(i, "t_osexa_id"));
			osExaObjectList.add(valueMap);
		}
		return osExaObjectList;
	}

	/**
	 * 
	  * <b>Summary: 查询计划审批表已办结未入库的列表</b>
	  *     复写方法 findOsExaList
	  * @param osExaBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsExaminationObjectDao#findOsExaList(com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsExaBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findOsExaList(OsExaBean osExaBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OsExaBean> list = new ArrayList<OsExaBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("   select distinct(t.t_osexa_id)t_osexa_id ,t.t_osexa_org_id,t.t_osexa_org_name,");
		sql.append("   to_char(t.t_osexa_date,'yyyy-MM-dd')t_osexa_date,t.t_osexa_title,t.t_osexa_user_name ");
		sql.append("   from TA_OA_DETOSEXAMINATION t, view_oa_instance v ");
		sql.append("       where t.t_osexa_id = v.BUSI_ID");
		sql.append("       and v.STATUS_CODE = '02'");  //已办结数据
		sql.append("       and t.t_osexa_isrk is null");      //未入库的数据
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			OsExaBean osExaBeanDb = new OsExaBean();
			osExaBeanDb.setT_osexa_id(db.getString(i, "t_osexa_id"));
			osExaBeanDb.setT_osexa_org_id(db.getString(i, "t_osexa_org_id"));
			osExaBeanDb.setT_osexa_org_name(db.getString(i, "t_osexa_org_name"));
			osExaBeanDb.setT_osexa_date(db.getString(i, "t_osexa_date"));
			osExaBeanDb.setT_osexa_title(db.getString(i, "t_osexa_title"));
			osExaBeanDb.setT_osexa_user_name(db.getString(i, "t_osexa_user_name"));
			list.add(osExaBeanDb);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	
	/**
	*<b>Summary: </b>
	* findOsShowOrgList(查看已汇总的常用物品的明细)
	* @param osExaBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findOsShowOrgList(OsAppObjectBean osappobjectbean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception{
		Connection conn = null;
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select t.t_org_id as t_org_id,");
			sql.append("       t.t_org_name as t_org_name,");
			sql.append("       (select sum(m.t_os_ob_no)");
			sql.append("          from TA_OA_DETOSAPP_OBJECT m");
			sql.append("         where m.t_org_id = t.t_org_id and m.t_os_ob_id in (");
			if(osappobjectbean!=null){
				//物品ID
				if (!StringUtil.nullOrBlank(osappobjectbean.getT_os_ob_id())) {
					sql.append(StringUtil.splitString(osappobjectbean.getT_os_ob_id(),",","'"));
				}else{
					sql.append(" '' ");
				}
			}
			sql.append("       )) as counts ");
			sql.append("  from TA_OA_DETOSAPP_OBJECTs t");
			sql.append(" where t.t_os_ob_id in (");
			if(osappobjectbean!=null){
				//物品ID
				if (!StringUtil.nullOrBlank(osappobjectbean.getT_os_ob_id())) {
					sql.append(StringUtil.splitString(osappobjectbean.getT_os_ob_id(),",","'"));
				} else{
					sql.append(" '' ");
				}
			}
			sql.append("        )");
			sql.append(" group by t.t_org_id, t.t_org_name");
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public void insertApplanObject(OsApplanBean osApplanBean, Connection conn)
			throws Exception {
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into TA_OA_DETOSAPPLAN ");
		sqlStr.append("  (t_id, ");
		sqlStr.append("   t_org_id, ");
		sqlStr.append("   t_org_name, ");
		sqlStr.append("   t_creator_time, ");
		sqlStr.append("   t_title, ");
		sqlStr.append("   t_user_id, ");
		sqlStr.append("   t_user_name, unit_id, unit_name) ");
		sqlStr.append("values ");
		sqlStr.append("  (?, ?, ?, to_date(?, 'yyyy-mm-dd'), ?, ?, ?, ?, ?)"); 
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sqlStr.toString());
		pdb.setString(1, osApplanBean.getT_id());
		pdb.setString(2, osApplanBean.getT_org_id());
		pdb.setString(3, osApplanBean.getT_org_name());
		pdb.setString(4, osApplanBean.getT_creator_time());
		pdb.setString(5, osApplanBean.getT_title());
		pdb.setString(6, osApplanBean.getT_user_id());
		pdb.setString(7, osApplanBean.getT_user_name());
		pdb.setString(8, osApplanBean.getUnit_id());
		pdb.setString(9, osApplanBean.getUnit_name());
		pdb.executePrepared(conn);
	}

	@Override
	public void insertApplanObject(OsHavaObjectBean osHavaObjectBean,
			Connection conn) throws Exception {
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into TA_OA_DETHAVA_OBJECT ");
		sqlStr.append("  (t_ha_id, ");
		sqlStr.append("   oftype_id, ");
		sqlStr.append("   oftype_name, ");
		sqlStr.append("   ofustype_id, ");
		sqlStr.append("   ofustype_name, ");
		sqlStr.append("   it_id, ");
		sqlStr.append("   it_name, ");
		sqlStr.append("   t_ha_sbno, ");
		sqlStr.append("   t_ha_buydate, ");
		sqlStr.append("   t_ha_ghman, ");
		sqlStr.append("   t_ha_overtel, ");
		sqlStr.append("   t_ha_dj, ");
		sqlStr.append("   t_ha_no, ");
		sqlStr.append("   t_ha_sbstate, ");
		sqlStr.append("   t_ha_ghuser, ");
		sqlStr.append("   t_ha_bz, ");
		sqlStr.append("   t_ha_rkuser_id, ");
		sqlStr.append("   t_ha_rkuser_name, ");
		sqlStr.append("   t_ha_org_id, ");
		sqlStr.append("   t_ha_org_name) ");
		sqlStr.append("values ");
		sqlStr.append("  (?, ?, ?, ?, ?, ?, ?, ?, to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");  
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sqlStr.toString());
		int k = 1 ;
		pdb.setString(k++, StringUtil.getUUID());
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getOftype_id()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getOftype_name()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getOfustype_id()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getOfustype_name()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getIt_id()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getIt_name()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_sbno()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_ghman()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_overtel()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_dj()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_no()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_sbstate()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_ghuser()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_bz()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_rkuser_id()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_rkuser_name()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_org_id()));
		pdb.setString(k++, StringUtil.deNull(osHavaObjectBean.getT_ha_org_name()));
		pdb.executePrepared(conn);
	}

}

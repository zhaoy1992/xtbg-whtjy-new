package com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsupplieRepairDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl.OsupplieRepairDaoImpl;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieRepairBean;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsupplieRepairService;

/**
 * 
 *<p>Title:OsupplieRepairServiceImpl.java</p>
 *<p>Description:办公用品管理-维修登记service实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-7
 */
public class OsupplieRepairServiceImpl implements OsupplieRepairService {
	private static final Log LOG=LogFactory.getLog(OsupplieTypeServiceImpl.class);
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRepairInfo
	  * @param osupplieRepairBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieRepairService
	  * #getRepairInfo(com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieRepairBean)
	 */
	public Map<String, String> getRepairInfo(
			OsupplieRepairBean osupplieRepairBean) {
		OsupplieRepairDao osupplieRepairDao= new OsupplieRepairDaoImpl();
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select t.repair_id,");
			sql.append("   to_char(t.report_time,'yyyy-MM-dd') report_time,");
			sql.append("   to_char(t.repair_time,'yyyy-MM-dd') repair_time,");
			sql.append("   t.place_info,");
			sql.append("   t.repair_unit,");
			sql.append("   t.repair_unitname,");
			sql.append("   t.deal_result,");
			sql.append("   t.replace_partids,");
			sql.append("   t.replace_parts");
			sql.append("  from ta_oa_canosaprepair t ");
			sql.append("  where repair_id = ?");
			return ((XtDbBaseDao)osupplieRepairDao).queryToSingleMap(sql.toString(), osupplieRepairBean.getRepair_id());
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return null;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveOrUpdate
	  * @param osupplieRepairBean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieRepairService
	  * #saveOrUpdate(com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieRepairBean)
	 */
	public String saveOrUpdate(OsupplieRepairBean osupplieRepairBean) {
		OsupplieRepairDao osupplieRepairDao= new OsupplieRepairDaoImpl();
		try {
			osupplieRepairBean.setRepair_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(osupplieRepairBean.getRepair_time()), "yyyy-MM-dd"));
			osupplieRepairBean.setReport_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(osupplieRepairBean.getReport_time()), "yyyy-MM-dd"));
			if(StringUtil.nullOrBlank(osupplieRepairBean.getRepair_id())){
				osupplieRepairBean.setRepair_id(DaoUtil.getUUID());
				((XtDbBaseDao)osupplieRepairDao).insert(osupplieRepairBean);
			}else{
				((XtDbBaseDao)osupplieRepairDao).update(osupplieRepairBean);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
			return null;
		}
		return osupplieRepairBean.getRepair_id();
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delete
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieRepairService#delete(java.lang.String)
	 */
	public String delete(String ids) {
		StringBuffer sql = new StringBuffer();
		OsupplieRepairDao osupplieRepairDao= new OsupplieRepairDaoImpl();
		sql.append("delete ta_oa_canosaprepair where repair_id in ("+ids+")");
		try {
			((XtDbBaseDao)osupplieRepairDao).delete(sql.toString());
		} catch (Exception e) {
			LOG.error(e.getMessage());
			return "false";
		}
		return "true";
	}
}

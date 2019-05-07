package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsupplieRepairDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieRepairBean;

/**
 * 
 *<p>Title:OsupplieRepairDaoImpl.java</p>
 *<p>Description:办公用品管理-维修登记dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-6
 */
public class OsupplieRepairDaoImpl extends XtDbBaseDao implements OsupplieRepairDao {
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selOsupplieTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieTypeDao#selOsupplieTypeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean repairInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		OsupplieRepairBean osupplieRepairBean= new OsupplieRepairBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osupplieRepairBean = (OsupplieRepairBean) JSONObject.parseObject(parmjson, OsupplieRepairBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select  t.repair_id,");
			sql.append("        to_char(t.report_time,'yyyy-MM-dd') report_time, ");
			sql.append("        to_char(t.repair_time,'yyyy-MM-dd') repair_time, ");
			sql.append("        t.place_info, ");
			sql.append("        t.repair_unit,");
			sql.append("        t.repair_unitname,");
			sql.append("        t.deal_result,");
			sql.append("        t.replace_parts,");
			sql.append("        decode(t.deal_status,'done','已办结','已提交') deal_status");
			sql.append("  from ta_oa_canosaprepair t");
			//sql.append("  inner join td_sm_organization o on o.org_id = repair_unit");
			sql.append("  where 1=1");
			if(osupplieRepairBean!=null){
				if (!StringUtil.nullOrBlank(osupplieRepairBean.getPlace_info())) {
					sql.append(" and place_info like '%'||?||'%'");
					condition.add(osupplieRepairBean.getPlace_info());
				}
				if (!StringUtil.nullOrBlank(osupplieRepairBean.getDeal_status())) {
					sql.append(" and deal_status = ?");
					condition.add(osupplieRepairBean.getDeal_status());
				}
				if (!StringUtil.nullOrBlank(osupplieRepairBean.getRepair_type())) {
					sql.append(" and repair_type = ?");
					condition.add(osupplieRepairBean.getRepair_type());
				}
				if (!StringUtil.nullOrBlank(osupplieRepairBean.getUnit_id())) {
					sql.append(" and unit_id = ?");
					condition.add(osupplieRepairBean.getUnit_id());
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
}

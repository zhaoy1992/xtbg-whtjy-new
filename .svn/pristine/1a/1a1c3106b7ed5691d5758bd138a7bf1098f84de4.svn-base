package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.LandHouseInfoDao;
import com.chinacreator.xtbg.tjy.device.entity.LandHouseBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:LandHouseInfoDaoImpl.java</p>
 *<p>Description:土地房屋管理DAO接口实现类</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author 陈郊
 *@version 1.0
 *@CreateDate:2015-11-23
 */
public class LandHouseInfoDaoImpl extends XtDbBaseDao implements LandHouseInfoDao {
	private static final Log LOG=LogFactory.getLog(LandHouseInfoDaoImpl.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		LandHouseBean bean = new LandHouseBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (LandHouseBean) JSONObject.parseObject(parmjson, LandHouseBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("select t.lh_id, ");
			sqlStr.append("       t.lh_number, ");
			sqlStr.append("       t.lh_area, ");
			sqlStr.append("       t.lh_name, ");
			sqlStr.append("       t.lh_location, ");
			sqlStr.append("       t.lh_remarks, ");
			sqlStr.append("       t.lh_identify_code, ");
			sqlStr.append("       to_char(t.lh_date,'yyyy-mm-dd') as lh_date, ");
			sqlStr.append("       t.lh_money 　from TA_OA_LANDHOUSEITEM t where 1 = 1"); 
			if(!StringUtil.nullOrBlank(bean.getUnit_id())){
				sqlStr.append(" and t.unit_id = ? ");
				condition.add(bean.getUnit_id());
			}
			//编号
			if(!StringUtil.nullOrBlank(bean.getLh_number())){
				sqlStr.append(" and t.lh_number like '%'||?||'%' ");
				condition.add(bean.getLh_number());
			}
			//名称
			if(!StringUtil.nullOrBlank(bean.getLh_name())){
				sqlStr.append(" and t.lh_name like '%'||?||'%' ");
				condition.add(bean.getLh_name());
			}
			//面积
			if(!StringUtil.nullOrBlank(bean.getLh_area())){
				sqlStr.append(" and t.lh_area = ? ");
				condition.add(bean.getLh_area());
			}
			//地点
			if(!StringUtil.nullOrBlank(bean.getLh_location())){
				sqlStr.append(" and t.lh_location like '%'||?||'%' ");
				condition.add(bean.getLh_location());
			}
			//证号
			if(!StringUtil.nullOrBlank(bean.getLh_identify_code())){
				sqlStr.append(" and t.lh_identify_code like '%'||?||'%' ");
				condition.add(bean.getLh_identify_code());
			}
			//开始时间
			if(!StringUtil.nullOrBlank(bean.getLh_date_start())){
				sqlStr.append(" and t.lh_date >= ").append(" to_date('")
				.append(bean.getLh_date_start()).append(" 00:00:00','yyyy-MM-dd HH24:mi:ss') ");
			}
			//结束时间
			if(!StringUtil.nullOrBlank(bean.getLh_date_end())){
				sqlStr.append(" and t.lh_date <= ").append(" to_date('")
				.append(bean.getLh_date_end()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
			}
			//金额
			if(!StringUtil.nullOrBlank(bean.getLh_money())){
				sqlStr.append(" and t.lh_money = ? ");
				condition.add(bean.getLh_money());
			}
			//排序
			sqlStr.append(" order by " + sortName + " " + sortOrder);
			LOG.info("土地房屋列表查询SQL：："+sqlStr.toString());
			pb = queryToPagingBean(sqlStr.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	@Override
	public boolean deleteLandHouseItemById(Connection conn, String lh_id)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_LANDHOUSEITEM ");
		sql.append(" where lh_id in ");
		sql.append(" (?) ");
		LOG.info("根据lh_id删除土地房屋项SQL::" + sql.toString());
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, lh_id);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 * 
	  * <b>Summary:  根据lh_id获取土地房屋基本信息</b>
	  *     复写方法 queryLandHouseBean
	  * @param conn
	  * @param lh_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.LandHouseInfoDao
	  * #queryLandHouseBean(java.sql.Connection, java.lang.String)
	 */
	@Override
	public Map<String, String> queryLandHouseBean(Connection conn, String lh_id)
			throws Exception {
		Map<String, String> returnMap = new HashMap<String, String>();
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("select lh_id, ");
		sqlStr.append("       lh_number, ");
		sqlStr.append("       lh_name, ");
		sqlStr.append("       lh_area, ");
		sqlStr.append("       lh_location, ");
		sqlStr.append("       lh_identify_code, ");
		sqlStr.append("       to_char(lh_date, 'yyyy-mm-dd') lh_date, ");
		sqlStr.append("       lh_money, ");
		sqlStr.append("       lh_remarks ");
		sqlStr.append("  from TA_OA_LANDHOUSEITEM ");
		sqlStr.append(" where lh_id = ? "); 
		LOG.info(" 根据lh_id获取土地房屋基本信息SQL::"+sqlStr.toString());
		returnMap = queryToSingleMap(conn, sqlStr.toString(), lh_id);
		return returnMap;
	}
	@Override
	public String getLandHouseByLh_Number(String lh_number) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String id = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select lh_id");
		sql.append("  from TA_OA_LANDHOUSEITEM t");
		sql.append("   where  t.lh_number = '"+lh_number+"'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size() > 0){
			for (int i = 0; i < pdb.size(); i++) {
				id = pdb.getString(i, "lh_id");
			}
		}
		if (StringUtil.isBlank(id)) {
			id = "false";
		}
		return id;
	}

}

package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBeanXt;

public class ElectResetDaoImpl extends XtDbBaseDao implements ElectResetDao {
	/**
	 *<p>Title:ElectResetDaoImpl.java</p>
	 *<p>Description:简报信息实例类</p> 
	 *<p>Company:湖南科创</p>
	 *@author 付程
	 *@version 1.0
	 *2012-2-24
	 */

	private static final Logger LOG = Logger.getLogger(ElectResetDaoImpl.class);
	/**
	 * @Description 添加考勤设置信息
	 
	 * @return boolean
	 * @throws SQLException 
	 */
	@Override
	public void add(ElectResetBeanXt electResetInfoBean) throws Exception {
		insert(electResetInfoBean);
	}
	
	@Override
	public void updateRecord(ElectResetBeanXt electResetInfoBean) throws Exception {
		update(electResetInfoBean);
	}

	
	

//查询获得试用的作息时间数据
	@Override
	public List<Map<String, String>> getContentBean(Map<String, String> map) throws Exception {
		StringBuffer buf = new StringBuffer();
		List<String> values=new ArrayList<String>();
		buf.append(" select t.elect_id,");
		buf.append(" t.isuse,t.start_time,t.end_time,t.REST_TIME");
		buf.append(" from SX_TA_OA_ELECTCHECK t ");
		buf.append( "where ");
		if(!StringUtil.isBlank(map.get("orgid"))){
			buf.append(" t.orgid = ? ");
			values.add(map.get("orgid"));
		}else{
			buf.append(" t.orgid is null  ");
		}
		return queryToListMap(buf.toString(), values);
	}

	@Override
	public PagingBean querylist(Map<String, String> map,String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception { 
		StringBuffer sql=new StringBuffer();
		List<String> values=new ArrayList<String>();
		sql.append(" select * from SX_TA_OA_ELECTCHECK t");
		if(!StringUtil.isBlank(map.get("orgname"))){
			sql.append(" where t.orgname like '%"+map.get("orgname")+"%' ");
		}
		return queryToPagingBean(sql.toString(), offset, maxPagesize, null, values);
	}

	@Override
	public Map<String, String> querydetail(Map<String, String> map)
			throws Exception {
		StringBuffer sql=new StringBuffer();
		String values=map.get("elect_id");
		sql.append(" select * from SX_TA_OA_ELECTCHECK t");
		sql.append(" where t.elect_id= ?");
		return queryToSingleMap(sql.toString(), values);
	}

	@Override
	public void deleteinfo(String ids) throws Exception {
		StringBuffer sql=new StringBuffer();
		String[] values={};
		sql.append(" delete SX_TA_OA_ELECTCHECK s");
		sql.append(" where instr(',"+ids+",',s.elect_id)>0");
		sql.append(" and s.orgid is not null ");
		delete(sql.toString(), values);
	}
	
}




package com.chinacreator.xtbg.core.businessclassmanager.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FormClassDaoImpl.java</p>
 *<p>Description:业务类型接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public class FormClassDaoImpl extends XtDbBaseDao implements FormClassDao {

	/**
	 * 
	  * <b>Summary: 根据应用id和上级id查询业务类型信息</b>
	  *     复写方法 getEformClassList
	  * @param appID
	  * @param upid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#getEformClassList(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getEformClassList(String appID,
			String upid, Connection conn) throws Exception {
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		String sql = "Select * from tb_form_class where EC_UPID='" + upid + "' and app_id='" + appID + "' order by ec_sn";
		list=queryToListMap(sql, conn);
		
		return list;
	}

	/**
	 * 
	  * <b>Summary: 根据ID查询业务类型信息</b>
	  *     复写方法 getFormClassByClassId
	  * @param classId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#getFormClassByClassId(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getFormClassByClassId(String classId,
			Connection conn) throws Exception {
		Map<String, String> map=new HashMap<String, String>();
		String sql = "select * from tb_form_class t where t.ec_id =?";
		map=queryToSingleMap(conn, sql, classId);
		return map;
	}

	/**
	 * 
	  * <b>Summary: 根据应用id查询排序号</b>
	  *     复写方法 getMaxEc_SnByAppId
	  * @param appId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#getMaxEc_SnByAppId(java.lang.String, java.sql.Connection)
	 */
	public int getMaxEc_SnByAppId(String appId, Connection conn)
			throws Exception {
		int ec_sn=0;
		String strsql = "SELECT case when max(ec_sn) is null then 0            else max(ec_sn)       end  ec_sn FROM  tb_form_class t  where t.app_id='"+appId+"' ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(strsql);
		pdb.executePrepared(conn);
		if((pdb != null) && (pdb.size() > 0)){
			ec_sn = pdb.getInt(0, "ec_sn");
		}
		return ec_sn;
	}

	/**
	 * 
	  * <b>Summary:判断该业务类型是否存在 </b>
	  *     复写方法 isExistByUpId
	  * @param ec_name
	  * @param app_id
	  * @param ec_upid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#isExistByUpId(java.lang.String, java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean isExistByUpId(String ec_name, String app_id, String ec_upid,Connection conn) throws Exception {
		String sql="select ec_name from tb_form_class where ec_name='"+ec_name+"' and ec_upid='"+ec_upid+"'  and app_id='"+app_id+"' ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if((pdb != null) && (pdb.size() > 0)){
			return true;
		}
		
		return false;
	}

	/**
	 * 
	  * <b>Summary: 判断该业务类型是否存在</b>
	  *     复写方法 isExistByEc_name
	  * @param ec_name
	  * @param app_id
	  * @param ec_id
	  * @param up_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#isExistByEc_name(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean isExistByEc_name(String ec_name, String app_id,
			String ec_id, String up_id, Connection conn) throws Exception {
		StringBuffer sql= new StringBuffer();
		sql.append("select ec_name from tb_form_class where ec_name='"+ec_name+"'");
		if(!StringUtil.isBlank(up_id)){
			sql.append(" and ec_upid='" + up_id + "' ");
		}
		if(!StringUtil.isBlank(app_id)){
			sql.append(" and app_id='" + app_id + "' ");
		}
		if(!StringUtil.isBlank(ec_id)){
			sql.append(" and ec_id !='" + ec_id + "' ");
		}
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		if((pdb != null) && (pdb.size() > 0)){
			return true;
		}
		
		return false;
	}

	/**
	 * 
	  * <b>Summary:查询是否有子类 </b>
	  *     复写方法 isExistSonByUpId
	  * @param ec_upid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao#isExistSonByUpId(java.lang.String, java.sql.Connection)
	 */
	public boolean isExistSonByUpId(String ec_upid, Connection conn)
			throws Exception {
		String sql="select * from tb_form_class start with ec_upid='"+ec_upid+"'  connect by prior ec_id=ec_upid ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared(conn);
		if((pdb != null) && (pdb.size() > 0)){
			return true;
		}
		
		return false;
	}

}

package com.chinacreator.xtbg.core.subsystemmanage.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.ajax.common.bean.BusinessBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemManageDao;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysManageBean;

/**
 * 
 *<p>Title:SubSystemManageDaoImpl.java</p>
 *<p>Description:子系统使用情况Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public class SubSystemManageDaoImpl extends XtDbBaseDao implements
		SubSystemManageDao {
	private static final Logger log = Logger
	.getLogger(SubSystemManageDaoImpl.class);
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemInfoList
	  * @param SearchConditionMap
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemManageDao#findSubSystemInfoList(java.util.Map, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findSubSystemInfoList(
			Map<String, String> SearchConditionMap, String sortName,
			String sortOrder, long offset, int maxPagesize){
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		List<String> values = new ArrayList<String>();
		sql.append("select sys_id, sys_name, sys_desc, sys_url, sys_img_url, decode(sys_ispublic,'Y','是','N','否','否') sys_ispublic from oa_subsys_manage where 1=1 ");
		if(!StringUtil.nullOrBlank(SearchConditionMap.get("sys_name"))){
			sql.append("and sys_name like ?");
			values.add("%"+SearchConditionMap.get("sys_name")+"%");
		}
		
		PagingBean pagingBean = new PagingBean();
		try{
			conn = DbManager.getInstance().getConnection();
			pagingBean = queryToPagingBean(sql.toString(), offset, maxPagesize,conn,values);
		}catch(Exception e){
			log.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		
		return pagingBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemInfo
	  * @param sysId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemManageDao#findSubSystemInfo(java.lang.String)
	 */
	public Map<String, String> findSubSystemInfo(String sysId){
		SubsysManageBean subsysManageBean = new SubsysManageBean();
		subsysManageBean.setSys_id(sysId);
		Map<String,String> map = new HashMap<String,String>();
		try {
			map =  queryToSingleMap(subsysManageBean);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return map;
	}
	/**
	 * 
	*<b>Summary: 查找所有的子系统数据</b>
	* findSubSystemList(请用一句话描述这个方法的作用)
	* @param bean
	* @return
	 */
	public Object findSubSystemList(BusinessBean bean){
		List<Map<String,String>> resultListMap = new ArrayList<Map<String,String>>();
		try {
			resultListMap = queryToListMap("select * from oa_subsys_manage o where o.sys_ispublic <> 'Y'");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return resultListMap;
	}
	/**
	 * 
	*<b>Summary: 根据用户id查找对应的子系统信息</b>
	* findSubSystemListByUserId(请用一句话描述这个方法的作用)
	* @param bean
	* @return
	 */
	public Object findSubSystemListByUserId(BusinessBean bean){
		List<Map<String,String>> resultListMap = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.*,u.info_id,u.user_id,u.sys_user_id,u.sys_user_password ");
		sql.append("  from oa_subsys_manage t ");
		sql.append(" inner join oa_subsys_useinfo u ");
		sql.append("    on u.sys_id = t.sys_id ");
		sql.append(" where u.user_id = ? ");
		sql.append("union all ");
		sql.append("select t.*,u.info_id,u.user_id,u.sys_user_id,u.sys_user_password ");
		sql.append("  from oa_subsys_manage t ");
		sql.append(" left join oa_subsys_useinfo u ");
		sql.append("    on u.sys_id = t.sys_id ");
		sql.append(" where t.sys_ispublic = 'Y' ");
		sql.append("");
		try {
			resultListMap = queryToListMap(sql.toString(),bean.getUserID());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return resultListMap;
	}
	
}

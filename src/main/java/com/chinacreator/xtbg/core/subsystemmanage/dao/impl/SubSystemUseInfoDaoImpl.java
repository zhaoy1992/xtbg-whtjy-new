package com.chinacreator.xtbg.core.subsystemmanage.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtShowInfoHashMap;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemUseInfoDao;

/**
 * 
 *<p>Title:SubSystemUseInfoDaoImpl.java</p>
 *<p>Description:子系统使用情况Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public class SubSystemUseInfoDaoImpl extends XtDbBaseDao implements
		SubSystemUseInfoDao {
	private static final Logger log = Logger
	.getLogger(SubSystemUseInfoDaoImpl.class);
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemUseInfoList
	  * @param SearchConditionMap
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemUseInfoDao#findSubSystemUseInfoList(java.util.Map, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findSubSystemUseInfoList(
			Map<String, String> SearchConditionMap, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		
		List<String> values = new ArrayList<String>();
		sql.append("select t.info_id as info_id,t.sys_id as sys_id,t.user_id as user_id,t.sys_user_id as sys_user_id, ");
		sql.append(" '******' as sys_user_password, u.user_realname user_name ");
		sql.append(" from oa_subsys_useinfo t left join td_sm_user u on t.user_id = u.user_id where t.sys_id = ? ");
		values.add(SearchConditionMap.get("sys_id"));
		if(!StringUtil.nullOrBlank(SearchConditionMap.get("user_name"))){
			sql.append(" and u.user_realname like ?");
			values.add("%"+SearchConditionMap.get("user_name")+"%");
		}
		PagingBean pagingBean = new PagingBean();
		try{
			conn = DbManager.getInstance().getConnection();
			pagingBean = queryToPagingBean(sql.toString(), offset, maxPagesize,conn,values);
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}finally {
			DbManager.closeConnection(conn);
		}
		
		return pagingBean;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemUseInfo
	  * @param infoId
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemUseInfoDao#findSubSystemUseInfo(java.lang.String)
	 */
	public Map<String, String> findSubSystemUseInfo(String infoId) {
		Map<String, String> map = new XtShowInfoHashMap();
		try{
			map = queryToSingleMap("select t.*,u.user_realname user_name from oa_subsys_useinfo t left join td_sm_user u on t.user_id = u.user_id where t.info_id = ?", infoId);
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isExsitUserInSysid
	  * @param userId
	  * @param sysId
	  * @return 
	  * @see com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemUseInfoDao#isExsitUserInSysid(java.lang.String, java.lang.String)
	 */
	public boolean isExsitUserInSysid(String info_id,String userId, String sysId) throws Exception{
		Map<String, String> map =  queryToSingleMap("select count(*) cnt from oa_subsys_useinfo t where t.user_id = ? and t.sys_id = ? and t.info_id <> ?", userId, sysId,info_id);
		return Integer.parseInt(map.get("cnt")) > 0;
	}
	
	/**
	*<b>Summary: 导入用户 在当前系统id中是否已经存在了此用户</b>
	* isExsitUserInSysid(请用一句话描述这个方法的作用)
	* @param user_name
	* @param sys_id
	* @return
	 */
	public boolean isFindUserInSysid(String user_name,String sys_id) throws Exception{
		Map<String, String> map =  queryToSingleMap("select count(*) cnt from oa_subsys_useinfo t where t.sys_user_id = ? and t.sys_id = ? ", user_name, sys_id);
		return Integer.parseInt(map.get("cnt")) > 0;
	}
	
	/**
	*<b>Summary: 在当前系统id中是否已经存在了此用户</b>
	* isExsitUserInSysid(请用一句话描述这个方法的作用)
	* @param user_name
	* @param sys_id
	* @return
	 */
	public Map<String,String> FindUserInSysid(String user_name,String sys_id) throws Exception{
		Map<String, String> map =  queryToSingleMap("select *  from oa_subsys_useinfo t where t.sys_user_id = ? and t.sys_id = ? ", user_name, sys_id);
		return map;
	}
	
	
}

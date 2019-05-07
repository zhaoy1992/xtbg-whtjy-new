package com.chinacreator.xtbg.core.paper.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperDao;
import com.chinacreator.xtbg.core.paper.entity.PaperBean;
import com.chinacreator.xtbg.core.paper.util.PaperConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:PaperDaoImpl.java</p>
 *<p>Description:信息报送dao层接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-11
 */
public class PaperDaoImpl extends XtDbBaseDao implements PaperDao {
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateReadStatusByUser
	  * @param conn
	  * @param p_manage_id
	  * @param userId
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#updateReadStatusByUser(java.sql.Connection, java.lang.String, java.lang.String) 
	  */
	public void updateReadStatusByUser(Connection conn,String p_manage_id,String userId) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_PAPER_RECEIVE_INFO");
		sql.append("  set p_read_status = '1', ");
		sql.append("  p_read_time = sysdate ");
		sql.append("  where p_receive_user_id = ? and p_manage_id= ? and p_type_id='2' and p_read_status='0' ");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, userId);
		pdb.setString(2, p_manage_id);
		pdb.executePrepared(conn);
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateReadStatusByUnit
	  * @param conn
	  * @param p_manage_id
	  * @param unitId
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#updateReadStatusByUnit(java.sql.Connection, java.lang.String, java.lang.String) 
	  */
	public void updateReadStatusByUnit(Connection conn,String p_manage_id,String unitId) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_PAPER_RECEIVE_INFO");
		sql.append("  set p_read_status = '1', ");
		sql.append("  p_read_time = sysdate ");
		sql.append("  where p_receive_unit_id = ? and p_manage_id= ?  and p_type_id='1' and p_read_status='0' ");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, p_manage_id);
		pdb.setString(2, unitId);
		pdb.executePrepared(conn);
	}

	 /**  
	  * <b>Summary: </b>
	  *     复写方法 savePaperSendAddByUnit 补发单位列表
	  * @param conn
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#savePaperSendAddByUnit(java.sql.Connection, java.util.Map) 
	  */
	public boolean savePaperSendAddByUnit(Connection conn,Map<String, String> map) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_paper_receive_info");
		sql.append("  (p_receive_id,");
		sql.append("   p_manage_id,");
		sql.append("   p_title,");
		sql.append("   p_receive_unit_id,");
		sql.append("   p_receive_unit_name,");
		sql.append("   p_read_status,");
		sql.append("   p_read_time,");
		sql.append("   p_receive_user_id,");
		sql.append("   p_receive_user_name,");
		sql.append("   p_type_id,");
		sql.append("   p_type_name)");
		sql.append("  select get_uuid,");
		sql.append("         ?,");
		sql.append("         ?,");
		sql.append("         t.org_id,");
		sql.append("         t.org_name,");
		sql.append("         '0',");
		sql.append("         sysdate,");
		sql.append("         null,");
		sql.append("         null,");
		sql.append("         '1',");
		sql.append("         '单位'");
		sql.append("    from TD_SM_ORGANIZATION t");
		sql.append("   where InStr(?,t.org_id) > 0  and t.org_id not in (select d.p_receive_unit_id from oa_paper_receive_info d where d.p_manage_id=? )   ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, map.get("p_manage_id"));
		pdb.setString(2, map.get("p_title"));
		pdb.setString(3, map.get("p_paper_unitid"));
		pdb.setString(4, map.get("p_manage_id"));
		pdb.executePrepared(conn);
		return flag;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 savePaperSendAddByUser 补发个人列表
	  * @param conn
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#savePaperSendAddByUser(java.sql.Connection, java.util.Map) 
	  */
	public boolean savePaperSendAddByUser(Connection conn,Map<String, String> map) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_paper_receive_info");
		sql.append("  (p_receive_id,");
		sql.append("   p_manage_id,");
		sql.append("   p_title,");
		sql.append("   p_receive_unit_id,");
		sql.append("   p_receive_unit_name,");
		sql.append("   p_read_status,");
		sql.append("   p_read_time,");
		sql.append("   p_receive_user_id,");
		sql.append("   p_receive_user_name,");
		sql.append("   p_type_id,");
		sql.append("   p_type_name)");
		sql.append("  select get_uuid,");
		sql.append("         ?,");
		sql.append("         ?,");
		sql.append("         t.unitid,");
		sql.append("         t.unitname,");
		sql.append("         '0',");
		sql.append("         sysdate,");
		sql.append("         t.userid,");
		sql.append("         t.username,");
		sql.append("         '2',");
		sql.append("         '个人'");
		sql.append("    from v_user_info t");
		sql.append("   where InStr(?,t.userid) > 0 and t.userid not in (select d.p_receive_user_id from oa_paper_receive_info d where d.p_manage_id=? and d.p_receive_user_id is not null)   ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, map.get("p_manage_id"));
		pdb.setString(2, map.get("p_title"));
		pdb.setString(3, map.get("p_paper_userid"));
		pdb.setString(4, map.get("p_manage_id"));
		pdb.executePrepared(conn);
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPaperById
	  * @param p_template_typeid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#getPaperById(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getPaperById(String p_manage_id,
			Connection conn) throws Exception {
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_paper ");
		sql.append(" where p_manage_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_manage_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updatePaper2AccByIds
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#updatePaper2AccByIds(java.sql.Connection, java.lang.String) 
	  */
	public boolean updatePaper2AccByIds(Connection conn,String beanId,String flagId,String userId) throws Exception{
		StringBuffer sql = new StringBuffer();
		UserCacheBean userBean = UserCache.getUserCacheBean(userId);
		sql.append(" update  oa_paper set ");
		sql.append(" p_flag_id = '"+flagId+"'");
		sql.append(" ,p_flag_name = getDictName('"+flagId+"','infoflag')");
		sql.append(" ,p_rep_flag_id = '"+flagId+"'");
		sql.append(" ,p_rep_flag_name = getDictName('"+flagId+"','infoflag')");
		sql.append(" ,p_acc_user_id='"+userBean.getUser_id()+"'");
		sql.append(" ,p_acc_user_name='"+userBean.getUser_realname()+"'");
		sql.append(" ,p_acc_time=sysdate");
		sql.append(" where p_manage_id = ");
		sql.append("  '"+beanId+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePaperReceiveInfoBean4UnitByParams 删除单位接收信息
	  * @param conn
	  * @param p_manage_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#deletePaperReceiveInfoBean4UnitByParams(java.sql.Connection, java.lang.String) 
	  */
	public boolean deletePaperReceiveInfoBean4UnitByParams(Connection conn,String p_manage_id) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_paper_receive_info t where t.p_type_id='1' and  t.p_manage_id=? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, p_manage_id);
		pdb.executePrepared(conn);
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePaperReceiveInfoBean4UserByParams 删除个人接收信息
	  * @param conn
	  * @param p_manage_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#deletePaperReceiveInfoBean4UserByParams(java.sql.Connection, java.lang.String) 
	  */
	public boolean deletePaperReceiveInfoBean4UserByParams(Connection conn,String p_manage_id) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("delete oa_paper_receive_info t where t.p_type_id='2' and  t.p_manage_id=? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, p_manage_id);
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 savePaperReceiveInfoByUnit 保存信息发送的接收方明细--单位
	  * @param conn
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#savePaperReceiveInfoByUnit(java.sql.Connection, java.util.Map) 
	  */
	public boolean savePaperReceiveInfoByUnit(Connection conn,Map<String, String> map) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_paper_receive_info");
		sql.append("  (p_receive_id,");
		sql.append("   p_manage_id,");
		sql.append("   p_title,");
		sql.append("   p_receive_unit_id,");
		sql.append("   p_receive_unit_name,");
		sql.append("   p_read_status,");
		sql.append("   p_read_time,");
		sql.append("   p_receive_user_id,");
		sql.append("   p_receive_user_name,");
		sql.append("   p_type_id,");
		sql.append("   p_type_name)");
		sql.append("  select get_uuid,");
		sql.append("         ?,");
		sql.append("         ?,");
		sql.append("         t.org_id,");
		sql.append("         t.org_name,");
		sql.append("         '0',");
		sql.append("         sysdate,");
		sql.append("         null,");
		sql.append("         null,");
		sql.append("         '1',");
		sql.append("         '单位'");
		sql.append("    from TD_SM_ORGANIZATION t");
		sql.append("   where InStr(?,t.org_id) > 0");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, map.get("p_manage_id"));
		pdb.setString(2, map.get("p_title"));
		pdb.setString(3, map.get("p_paper_unitid"));
		pdb.executePrepared(conn);
		return flag;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 savePaperReceiveInfoByUser 保存信息发送的接收方明细--个人 
	  * @param conn
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#savePaperReceiveInfoByUser(java.sql.Connection, java.util.Map) 
	  */
	public boolean savePaperReceiveInfoByUser(Connection conn,Map<String, String> map) throws Exception{
		boolean flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_paper_receive_info");
		sql.append("  (p_receive_id,");
		sql.append("   p_manage_id,");
		sql.append("   p_title,");
		sql.append("   p_receive_unit_id,");
		sql.append("   p_receive_unit_name,");
		sql.append("   p_read_status,");
		sql.append("   p_read_time,");
		sql.append("   p_receive_user_id,");
		sql.append("   p_receive_user_name,");
		sql.append("   p_type_id,");
		sql.append("   p_type_name)");
		sql.append("  select get_uuid,");
		sql.append("         ?,");
		sql.append("         ?,");
		sql.append("         t.unitid,");
		sql.append("         t.unitname,");
		sql.append("         '0',");
		sql.append("         sysdate,");
		sql.append("         t.userid,");
		sql.append("         t.username,");
		sql.append("         '2',");
		sql.append("         '个人'");
		sql.append("    from v_user_info t");
		sql.append("   where InStr(?,t.userid) > 0");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, map.get("p_manage_id"));
		pdb.setString(2, map.get("p_title"));
		pdb.setString(3, map.get("p_paper_userid"));
		pdb.executePrepared(conn);
		return flag;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deletePaperById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#deletePaperById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deletePaperById(Connection conn, String beanId) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from oa_paper ");
		sql.append(" where p_manage_id in ");
		sql.append("  ('"+beanId+"')");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryPaperList 查询信息
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#queryPaperList(com.chinacreator.xtbg.core.paper.entity.PaperBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean queryPaperList(PaperBean paperBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			if(!paperBean.getOpentype().equalsIgnoreCase("ok")){
				sql.append(" select '5' readrate, ");
			}else{
				sql.append(" select (select count(*) from OA_PAPER_RECEIVE_INFO d where d.p_read_status='1' and d.p_type_id='2' and d.p_manage_id = t.P_MANAGE_ID) ||'/'||(select count(*) from OA_PAPER_RECEIVE_INFO d where d.p_type_id='2' and d.p_manage_id = t.P_MANAGE_ID) readrate, ");
			}
			sql.append(" t.P_MANAGE_ID,          ");
			sql.append(" t.P_IS_USE  ,           ");
			sql.append(" t.P_LEADER  ,           ");
			sql.append(" t.P_EDITOR  ,           ");
			sql.append(" t.P_REP_TITLE ,         ");
			sql.append(" t.P_REP_TYPE_ID ,       ");
			sql.append(" t.P_REP_TYPE_NAME,      ");
			sql.append(" t.P_REP_KEYWORD   ,     ");
			sql.append(" t.P_REP_CONTENTS  ,     ");
			sql.append(" t.P_REP_ATTACH_ID   ,   ");
			sql.append(" t.P_REP_USER_ID    ,    ");
			sql.append(" t.P_REP_USER_NAME  ,    ");
			sql.append(" p_rep_time     ,   ");
			sql.append(" p_acc_title     ,   ");
			sql.append(" t.P_REP_UNIT_ID    ,    ");
			sql.append(" t.P_REP_UNIT_NAME  ,    ");
			sql.append(" t.P_FLAG_ID        ,    ");
			sql.append(" t.P_FLAG_NAME      ,    ");
			sql.append(" t.P_REP_FLAG_ID    ,    ");
			sql.append(" t.P_REP_FLAG_NAME  ,    ");
			sql.append(" t.P_ACC_UNIT_IDS    ,   ");
			sql.append(" t.P_ACC_UNIT_NAMES  ,   ");
			sql.append(" t.P_ACC_USER_ID     ,   ");
			sql.append(" t.P_ACC_USER_NAME   ,   ");
			sql.append(" t.P_ACC_TIME        ,   ");
			sql.append(" t.P_SUB_USER_IDS    ,   ");
			sql.append(" t.P_SUB_USER_NAMES  ,   ");
			sql.append(" t.P_SUB_TIME        ,   ");
			sql.append(" t.P_CONTENTS        ,   ");
			sql.append(" t.P_PUB_USER_ID     ,   ");
			sql.append(" t.P_PUB_USER_NAME   ,   ");
			sql.append(" t.P_PUB_TIME         ,  ");
			sql.append(" t.P_PUB_UNIT_ID      ,  ");
			sql.append(" t.P_PUB_UNIT_NAME      ");
			sql.append(" from OA_PAPER t where 1=1  and t.p_is_use='1' ");
			
			if(paperBean.getOpentype().equalsIgnoreCase("reported")){//已上报信息-----------
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上报单位过滤
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_flag_id())){//上报信息状态
					sql.append(" and t.p_rep_flag_id = ? ");
					conditionValues.add(paperBean.getP_rep_flag_id());
				}else{
					sql.append(" and (t.p_rep_flag_id='"
							+ PaperConstants.STATUS_ACCEPT
							+ "' or t.p_rep_flag_id='"
							+ PaperConstants.STATUS_PENDING
							+ "' or t.p_rep_flag_id='"
							+ PaperConstants.STATUS_UNACCEPT + "') ");
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("draft")){//草稿箱列表----------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上报单位过滤
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_flag_id())){//信息状态
					sql.append(" and t.p_rep_flag_id = ? ");
					conditionValues.add(paperBean.getP_rep_flag_id());
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("acc")){//接收的信息-----------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//上报单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_flag_id())){//信息状态
					sql.append(" and t.p_rep_flag_id = ? ");
					conditionValues.add(paperBean.getP_rep_flag_id());
				}else{
					sql.append(" and (t.p_rep_flag_id='"
							+ PaperConstants.STATUS_ACCEPT
							+ "' or t.p_rep_flag_id='"
							+ PaperConstants.STATUS_PENDING + "') ");
					/*sql.append(" and (t.p_rep_flag_id='"
							+ PaperConstants.STATUS_ACCEPT
							+ "' or t.p_rep_flag_id='"
							+ PaperConstants.STATUS_PENDING
							+ "' or t.p_rep_flag_id='"
							+ PaperConstants.STATUS_UNACCEPT + "') ");*/
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上传部门
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("pending")){// 已送审信息--------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}else{//待发布，已发布，退回
					sql.append(" and (t.p_flag_id='"
							+ PaperConstants.STATUS_WAIT_PUBLISH
							+ "' or t.p_flag_id='"
							+ PaperConstants.STATUS_PUBLISHED
							+ "' or t.p_flag_id='"
							+ PaperConstants.STATUS_REVISE
							+ "' or t.p_flag_id='"
							+ PaperConstants.STATUS_UNDONE + "') ");
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上传部门
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_user_name())){
					sql.append(" and t.p_acc_user_name like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_acc_user_name());
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("accepted")){// 已采编信息-------------------------
				
				if(paperBean.getUnittype().equalsIgnoreCase("isrep")){
					if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上报单位过滤
						sql.append(" and t.p_rep_unit_id = ? ");
						conditionValues.add(paperBean.getP_rep_unit_id());
					}
				}else{
					if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
						sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
						conditionValues.add(paperBean.getP_acc_unit_ids());
					}
				}
				
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
				
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_flag_id())){//信息状态(上报的)
					sql.append(" and t.p_rep_flag_id = ? ");
					conditionValues.add(paperBean.getP_rep_flag_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("tmp")){// 草稿（采编）-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}	
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("waitpublish")){// 待发布-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上传部门
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("query")){// 已发布-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_pub_unit_id())){//上传部门
					sql.append(" and t.p_pub_unit_id = ? ");
					conditionValues.add(paperBean.getP_pub_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("ok")){// 已发布-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上传部门
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("undone")){// 已退回-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_title())){//标题
					sql.append(" and t.p_rep_title like '%'||?||'%' ");
					conditionValues.add(paperBean.getP_rep_title());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_type_id())){//信息类型
					sql.append(" and t.p_rep_type_id = ? ");
					conditionValues.add(paperBean.getP_rep_type_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_unit_id())){//上传部门
					sql.append(" and t.p_rep_unit_id = ? ");
					conditionValues.add(paperBean.getP_rep_unit_id());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_rep_time())){//上报日期 有两个时
					String str = paperBean.getP_rep_time().toString(); 
					String bt=str.substring(0, str.indexOf(","));
					String et=str.substring(str.indexOf(",")+1);
					if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
					}else if(!StringUtil.nullOrBlank(bt)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')>= '"+bt+"' ");
					}else if(!StringUtil.nullOrBlank(et)){
						sql.append(" and to_char(t.p_rep_time, 'yyyy-mm-dd')<= '"+et+"'");
					}
				}
			}else if(paperBean.getOpentype().equalsIgnoreCase("revise")){// 草稿（发布）-------------------------
				if(!StringUtil.nullOrBlank(paperBean.getP_acc_unit_ids())){//接收单位过滤
					sql.append(" and InStr(t.p_acc_unit_ids, ?)>0   ");
					conditionValues.add(paperBean.getP_acc_unit_ids());
				}
				if(!StringUtil.nullOrBlank(paperBean.getP_flag_id())){//信息状态
					sql.append(" and t.p_flag_id = ? ");
					conditionValues.add(paperBean.getP_flag_id());
				}
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: 查询信息报送统计</b>
	  *     复写方法 selCountPaperList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperDao#selCountPaperList(com.chinacreator.xtbg.core.paper.entity.PaperBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selCountPaperList(PaperBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select d.p_rep_unit_name, ");
			sql.append(" decode(count1, '', 0, count1) count1, ");
			sql.append(" decode(count2, '', 0, count2) count2, ");
			sql.append(" decode(count3, '', 0, count3) count3 ");
			sql.append(" from (select p_rep_unit_name, count(*) count1 ");
			sql.append(" from oa_paper  ");
			sql.append(" where p_rep_flag_id in (0,1,2,3) ");
			if(model!=null){
				
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
					String beginTime = StringUtil.deNull(model.getStart_time())+" 00:00:00";
					sql.append(" and p_rep_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
					String endTime = StringUtil.deNull(model.getEnd_time())+" 23:59:59";
					sql.append(" and p_rep_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			sql.append(" group by p_rep_unit_name) d ");
			sql.append(" left join (select p_rep_unit_name, count(*) count3 ");
			sql.append(" from oa_paper ");
			sql.append(" where p_rep_flag_id = 2 ");
			if(model!=null){
				
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
					String beginTime = StringUtil.deNull(model.getStart_time())+" 00:00:00";
					sql.append(" and p_rep_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
					String endTime = StringUtil.deNull(model.getEnd_time())+" 23:59:59";
					sql.append(" and p_rep_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			sql.append(" group by p_rep_unit_name) d1 ");
			sql.append(" on d.p_rep_unit_name = d1.p_rep_unit_name ");
			sql.append(" left join (select p_rep_unit_name, count(*) count2 ");
			sql.append(" from oa_paper ");
			sql.append(" where p_rep_flag_id in (1) ");
			if(model!=null){
				
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
					String beginTime = StringUtil.deNull(model.getStart_time())+" 00:00:00";
					sql.append(" and p_rep_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
					String endTime = StringUtil.deNull(model.getEnd_time())+" 23:59:59";
					sql.append(" and p_rep_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			sql.append(" group by p_rep_unit_name) d2 ");
			sql.append(" on d.p_rep_unit_name = d2.p_rep_unit_name ");
			sql.append(" where 1=1 ");
			if(model!=null){
				
				if (!StringUtil.nullOrBlank(model.getP_rep_unit_name())) {
					sql.append(" and d.p_rep_unit_name like '%'||?||'%' ");
					condition.add(model.getP_rep_unit_name());
				}
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}

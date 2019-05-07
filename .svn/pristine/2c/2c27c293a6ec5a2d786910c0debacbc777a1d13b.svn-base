package com.chinacreator.xtbg.core.inspect.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.inspect.dao.InspectManageDao;
import com.chinacreator.xtbg.core.inspect.entity.InspectReceptBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:InspectManageDaoImpl.java</p>
 *<p>Description:督查督办任务管理，数据库操作类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectManageDaoImpl extends XtDbBaseDao implements
		InspectManageDao {

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findBaseInfoPageBean
	 * @param bean
	 * @param page
	 * @param conn
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.inspect.dao.InspectManageDao#findBaseInfoPageBean(com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean,
	 *      com.chinacreator.xtbg.core.common.commonlist.PageInfoBean,
	 *      java.sql.Connection)
	 */
	public PagingBean findBaseInfoPageBean(Map<String,String> bean,
			PageInfoBean page, Connection conn) throws Exception {
		if(null == bean || null == page){
			return null;
		}
		//拼接的值
		List<String> conditionValues = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.info_id,");
		sql.append("       a.inspect_name,");
		sql.append("       a.inspect_type,");
		sql.append("       a.inspect_state,");
		sql.append("       decode(a.inspect_state,'0','草稿','1','办理中','2','已完成','3','未完成') inspect_state_name,");
		sql.append("       a.create_time,");
		sql.append("       to_char(a.send_time, 'yyyy-mm-dd hh24:mi') as send_time,");
		sql.append("       to_char(a.plan_endtime, 'yyyy-mm-dd hh24:mi') as plan_endtime,");
		sql.append("       to_char(a.remind_time, 'yyyy-mm-dd hh24:mi') as remind_time,");
		sql.append("       a.remind_content,");
		sql.append("       a.recept_orgids,");
		sql.append("       a.recept_orgnames,");
		sql.append("       a.send_user_id,");
		sql.append("       a.send_user_name,");
		sql.append("       a.user_orgid,");
		sql.append("       a.user_orgname,");
		sql.append("       a.is_sms,a.is_msg,");
		sql.append("       a.is_rtx,a.is_mail,");
		sql.append("       b.type_name");
		sql.append("  from oa_inspect_baseinfo a ");
		sql.append("  left join oa_inspect_type b  ");
		sql.append("  on a.inspect_type=b.type_id   ");
		sql.append(" where a.info_id is not null ");
			
		if(!StringUtil.nullOrBlank(bean.get("inspect_name"))){
			sql.append(" and a.inspect_name like '%'||?||'%'");
			conditionValues.add(bean.get("inspect_name"));
		}
		if(!StringUtil.nullOrBlank(bean.get("inspect_type"))){
			sql.append(" and a.inspect_type = ?");
			conditionValues.add(bean.get("inspect_type"));
		}
		//交办开始时间
		if(!StringUtil.nullOrBlank(bean.get("send_time"))){
			sql.append(" and a.send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			conditionValues.add(bean.get("send_time")+" 00:00:00");
		}
		//交办截止时间
		if(!StringUtil.nullOrBlank(bean.get("plan_endtime"))){
			sql.append(" and a.send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			conditionValues.add(bean.get("plan_endtime")+" 23:59:59");
		}
		
		//状态
		if(!StringUtil.nullOrBlank(bean.get("inspect_state"))){
			sql.append(" and a.inspect_state= ?");
			conditionValues.add(bean.get("inspect_state"));
		}
		//创建人id
		if(!StringUtil.nullOrBlank(bean.get("send_user_id"))){
			sql.append(" and a.send_user_id= ?");
			conditionValues.add(bean.get("send_user_id"));
		}
		
		
        //排序
		if (!StringUtil.nullOrBlank(page.getSortName())
				&& !StringUtil.nullOrBlank(page.getSortOrder())){
            sql.append(" order by "+page.getSortName() +" "+page.getSortOrder());
		}
		// 调父类的方法
		return queryToPagingBean(sql.toString(), page.getOffset(), page
				.getRows(), conn, conditionValues);
	}
	
	/**
	 * 
	*<b>Summary: “任务通知查看”查询任务数据。根据任务接收人来查看数据</b>
	* findBaseInfoPageBean4recept()
	* @param bean
	* @param page
	* @param conn
	* @return
	* @throws Exception
	 */
	public PagingBean findBaseInfoPageBean4recept(Map<String,String> bean,
			PageInfoBean page, Connection conn) throws Exception {
		if(null == bean || null == page){
			return null;
		}
		//拼接的值
		List<String> conditionValues = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.info_id,");
		sql.append("       a.inspect_name,");
		sql.append("       a.inspect_type,");
		sql.append("       a.inspect_state,");
		sql.append("       decode(a.inspect_state,'0','草稿','1','办理中','2','已完成','3','未完成') inspect_state_name,");
		sql.append("       a.create_time,");
		sql.append("       to_char(a.send_time, 'yyyy-mm-dd hh24:mi') as send_time,");
		sql.append("       to_char(a.plan_endtime, 'yyyy-mm-dd hh24:mi') as plan_endtime,");
		sql.append("       to_char(a.remind_time, 'yyyy-mm-dd hh24:mi') as remind_time,");
		sql.append("       a.send_user_id,");
		sql.append("       a.send_user_name,");
		sql.append("       a.user_orgid,");
		sql.append("       a.user_orgname,");
		sql.append("               decode(d.recept_state,'2','退回重办','1','已反馈','未反馈') as recept_state_name,");
		sql.append("               d.recept_state,");
		sql.append("               d.recept_id,");		
		sql.append("               e.type_name");
		sql.append("          from oa_inspect_type e right join ");
		sql.append("     oa_inspect_baseinfo a             ");
		sql.append("  on a.inspect_type=e.type_id ,  ");
		sql.append("                (select b.info_id,b.recept_state,b.recept_id");
		sql.append("                  from oa_inspect_recept b");
		sql.append("                 where exists (select 1");
		sql.append("                          from oa_inspect_receptuser c");
		sql.append("                         where b.recept_id = c.recept_id");
		sql.append("                           and c.recept_userid = ?)");
		sql.append("                ) d");
		sql.append("          where a.info_id=d.info_id and a.inspect_state <>'0'");
		//默认添加接收用户id
		conditionValues.add(StringUtil.deNull(bean.get("recept_userid")));
			
		if(!StringUtil.nullOrBlank(bean.get("inspect_name"))){
			sql.append(" and a.inspect_name like '%'||?||'%'");
			conditionValues.add(bean.get("inspect_name"));
		}
		if(!StringUtil.nullOrBlank(bean.get("inspect_type"))){
			sql.append(" and a.inspect_type = ?");
			conditionValues.add(bean.get("inspect_type"));
		}
		//交办开始时间
		if(!StringUtil.nullOrBlank(bean.get("send_time"))){
			sql.append(" and a.send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			conditionValues.add(bean.get("send_time")+" 00:00:00");
		}
		//交办截止时间
		if(!StringUtil.nullOrBlank(bean.get("plan_endtime"))){
			sql.append(" and a.send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			conditionValues.add(bean.get("plan_endtime")+" 23:59:59");
		}
		
		//反馈状态
		if(!StringUtil.nullOrBlank(bean.get("recept_state"))){
			sql.append(" and d.recept_state= ?");
			conditionValues.add(bean.get("recept_state"));
		}
				
		
        //排序
		if (!StringUtil.nullOrBlank(page.getSortName())
				&& !StringUtil.nullOrBlank(page.getSortOrder())){
            sql.append(" order by "+page.getSortName() +" "+page.getSortOrder());
		}
		// 调父类的方法
		return queryToPagingBean(sql.toString(), page.getOffset(), page
				.getRows(), conn, conditionValues);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryAllType
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.inspect.dao.InspectManageDao#queryAllType(java.sql.Connection)
	 */
	public List<Map<String, String>> queryAllType(Connection conn)
			throws Exception {
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("select type_id, type_name, type_remark, ");
		sql.append(" type_template, type_order");
		sql.append("          from oa_inspect_type");
		sql.append("         order by type_order asc");
		// 调父类的方法
		return super.queryToListMap(sql.toString(), conn);
	}
	/**
	 * 
	*<b>Summary: 根据资源id，查询资源配置信息</b>
	* queryResourceConfig()
	* @param resourceId 资源id
	* @param conn
	* @return
	 * @throws Exception 
	 */
	public List<Map<String, String>> queryResourceConfig(String resourceId,
			Connection conn) throws Exception {
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("select config_id,");
		sql.append("       resources_id,");
		sql.append("       config_typeid,");
		sql.append("       config_ids");
		sql.append("  from oa_dataresources_config ");
		sql.append("  where resources_id = ?");
		// 调父类的方法
		return super.queryToListMap(sql.toString(), conn,resourceId);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertReceptUser
	  * @param infoId
	  * @param receptId
	  * @param userIds
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.inspect.dao.InspectManageDao#insertReceptUser(java.lang.String, java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public void insertReceptUser(String infoId,String receptId, String userIds,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_inspect_receptuser");
		sql.append("     (id, recept_id, recept_userid, recept_username,");
		sql.append("     phone, email, temp,info_id)");
		sql.append("     select sys_guid(),");
		sql.append("            ?,");
		sql.append("            b.user_id,");
		sql.append("            b.user_realname,");
		sql.append("            b.user_mobiletel1,");
		sql.append("            b.user_email,");
		sql.append("            null,");
		sql.append("            ? ");		
		sql.append("       from td_sm_user b");
		sql
				.append("      where instr(',' || ? || ',', ',' || b.user_id || ',') > 0");
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, receptId);
		pdb.setString(2, infoId);
		pdb.setString(3, userIds);
		pdb.executePrepared(conn);        
	}
	
	/**
	 * 
	*<b>Summary:根据任务id，查询各个单位的反馈状况 </b>
	* queryRecept()
	* @param map  查询条件
	* @param conn 数据库连接
	* @return
	* @throws Exception
	*/
	public List<Map<String, String>> queryRecept(String infoId,
			Connection conn) throws Exception {
		if(StringUtil.nullOrBlank(infoId)){
			return null;
		}
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("");
		sql.append("select a.recept_id,");
		sql.append("       a.info_id,");
		sql.append("       decode(a.recept_state, '0', '待反馈', '2', '退回重办', '1', '已反馈') recept_state_name,");
		sql.append("       a.recept_state,");
		sql.append("       a.recept_time,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.card,");
		sql.append("       (select to_char(max(b.response_time), 'yyyy-mm-dd hh24:mi')");
		sql.append("          from oa_inspect_response b");
		sql.append("         where a.recept_id = b.recept_id) response_time");
		sql.append("  from oa_inspect_recept a");
		sql.append(" where a.recept_id is not null");
		sql.append("     and a.info_id = ?");
		// 调父类的方法
		return super.queryToListMap(sql.toString(), conn, infoId);
	}
	
	/**
	 * 
	*<b>Summary: 根据接收id查询接收人信息</b>
	* queryReceptUser()
	* @param receptIds 任务接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryReceptUser(String receptIds,
			Connection conn) throws Exception {
		if(StringUtil.nullOrBlank(receptIds)){
			return null;
		}
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("select a.id,");
		sql.append("       a.recept_id,");
		sql.append("       a.recept_userid,");
		sql.append("       a.recept_username,");
		sql.append("       a.phone,");
		sql.append("       a.email,");
		sql.append("       a.temp,");
		sql.append("       a.info_id");
		sql.append("  from oa_inspect_receptuser a");
		sql.append(" where instr(',' ||");
		sql.append("             ?|| ',',");
		sql.append("             ',' || a.recept_id || ',') > 0");
		// 调父类的方法
		return super.queryToListMap(sql.toString(), conn, receptIds);
	}
	/**
	 * 
	*<b>Summary: 查询回复信息</b>
	* queryListResponse()
	* @param receptId 接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListResponse(String receptId,
			Connection conn) throws Exception {
		if (StringUtil.nullOrBlank(receptId)) {
			return null;
		}
		// 拼接的值
		StringBuffer sql = new StringBuffer();
		sql.append("select response_id,");
		sql.append("       recept_id,");
		sql.append("       response_content,");
		sql.append("       response_userid,");
		sql.append("       response_username,");
		sql.append("       org_id,");
		sql.append("       org_name,");
		sql.append("       response_state,");
		sql.append("       to_char(response_time, 'yyyy-mm-dd hh24:mi') response_time,");
		
		sql.append("       type,");
		sql.append("       info_id,");
		sql.append("       attach_id");
		sql.append("  from oa_inspect_response a");
		sql.append(" where a.recept_id = ?");
		sql.append(" order by response_time asc");
		// 调父类的方法
		return super.queryToListMap(sql.toString(), conn, receptId);
	}
	/**
	 * 
	  * <b>Summary: 督查事项统计查询</b>
	  *     复写方法 selInspectCountList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.inspect.dao.InspectManageDao#selInspectCountList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selInspectCountList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		InspectReceptBean bean=new InspectReceptBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (InspectReceptBean) JSONObject.parseObject(parmjson, InspectReceptBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("  select a.org_id,a.org_name,decode(count1, '', 0, count1) count1, ");
			sql.append("  decode(count2, '', 0, count2) count2, ");
			sql.append("  decode(count3, '', 0, count3) count3, ");
			sql.append("  decode(count4, '', 0, count4) count4, ");
			sql.append("  decode(count5, '', 0, count5) count5 from( ");
			sql.append("  select org_id,org_name,count(org_name) count1  from ( ");
			sql.append("  select r.*,b.* from oa_inspect_recept r,oa_inspect_baseinfo b  where r.info_id=b.info_id ) where 1=1 ");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and recept_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String endTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and recept_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			
			sql.append("  group by org_name,org_id ) a ");
			sql.append("  left join ( select org_name,count(org_name) count2 from oa_inspect_recept r  where recept_state='2' ");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and recept_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String endTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and recept_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			
			sql.append("  group by org_name ) b on a.org_name=b.org_name ");
			sql.append("  left join ( select org_name,count(org_name) count3  from ( ");
			sql.append("  select r.*,b.* from oa_inspect_recept r,oa_inspect_baseinfo b  where r.info_id=b.info_id  ) where inspect_state='2' ");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and recept_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String endTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and recept_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			
			sql.append("  group by org_name ) c on a.org_name=c.org_name ");
			sql.append("  left join ( select org_name,count(org_name) count4  from ( ");
			sql.append("  select r.*,b.* from oa_inspect_recept r,oa_inspect_baseinfo b  where r.info_id=b.info_id  ) where inspect_state='3' ");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and recept_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String endTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and recept_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			
			sql.append("  group by org_name ) d on a.org_name=d.org_name ");
			sql.append("  left join( select org_name,count(org_name) count5  from ( ");
			sql.append("  select r.*,b.* from oa_inspect_recept r,oa_inspect_baseinfo b  where r.info_id=b.info_id  ) where inspect_state='1' ");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStart_time()))){
					String beginTime = StringUtil.deNull(bean.getStart_time())+" 00:00:00";
					sql.append(" and recept_time >= to_date('"+beginTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnd_time()))){
					String endTime = StringUtil.deNull(bean.getEnd_time())+" 23:59:59";
					sql.append(" and recept_time <= to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss') ");
				}	
			}
			
			sql.append("  group by org_name ) f on a.org_name=f.org_name ");
			sql.append("  where 1=1");
			if(bean!=null){
				if(!StringUtil.nullOrBlank(StringUtil.deNull(bean.getOrg_name()))){
					String org_name = StringUtil.deNull(bean.getOrg_name());
					sql.append(" and a.org_name like '%'||'"+org_name+"'||'%' ");
				}
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary:查询发牌的数据列表 </b>
	* @return 发牌数据列表
	 * @throws Exception 
	 */
	public PagingBean queryCardList(
			Map<String, String> condition, PageInfoBean page, Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<String> sCondition = new ArrayList<String>();
		sql.append("select a.recept_id,");
		sql.append("       a.recept_state,");
		sql.append("  decode(a.recept_state,'2','退回重办','1','已反馈','待反馈') recept_state_name ,");
		sql.append("       a.recept_time,");
		sql.append("       a.org_id,");
		sql.append("       a.org_name,");
		sql.append("       a.card,");
		sql.append("  to_char(a.response_time,'yyyymmddhh24mi') response_time,");
		sql.append("       b.info_id,");
		sql.append("       b.inspect_name,");
		sql.append("       b.inspect_type,");
		sql.append("       c.type_name,");
		sql.append("       b.create_time,");
		sql.append("       to_char(b.send_time,'yyyy-mm-dd hh24:mi') send_time,");
		sql.append("       b.inspect_state,");
		sql.append("  decode(b.inspect_state,'2','已完成','3','未完成','1','办理中','草稿') inspect_state_name ,");
		
		sql.append("  to_char(b.plan_endtime,'yyyymmddhh24mi') plan_endtime4card,");
		sql.append("  to_char(b.plan_endtime,'yyyy-mm-dd hh24:mi') plan_endtime,");
		sql.append("  to_char(b.remind_time,'yyyy-mm-dd hh24:mi') remind_time,");
		sql.append("  to_char(b.remind_time,'yyyymmddhh24mi') remind_time4card");
		sql.append("  from oa_inspect_recept a");
		sql.append("  left join oa_inspect_baseinfo b");
		sql.append("    on a.info_id = b.info_id");
		sql.append("  left join oa_inspect_type c");
		sql.append("    on b.inspect_type = c.type_id ");
		sql.append("  where b.inspect_state <>'0' ");
		
		
		//按任务名查询
		if(!StringUtil.nullOrBlank(condition.get("inspect_name"))){
			sql.append(" and b.inspect_name=? ");
			sCondition.add(condition.get("inspect_name"));
		}
		//交办开始时间
		if(!StringUtil.nullOrBlank(condition.get("send_time"))){
			sql.append(" and b.send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			sCondition.add(condition.get("send_time")+" 00:00:00");
		}
		//交办截止时间
		if(!StringUtil.nullOrBlank(condition.get("plan_endtime"))){
			sql.append(" and b.send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
			sCondition.add(condition.get("plan_endtime")+" 23:59:59");
		}
		//任务类型
		if(!StringUtil.nullOrBlank(condition.get("inspect_type"))){
			sql.append(" and b.inspect_type=? ");
			sCondition.add(condition.get("inspect_type"));
		}
		//任务状态
		if(!StringUtil.nullOrBlank(condition.get("inspect_state"))){
			sql.append(" and b.inspect_state=? ");
			sCondition.add(condition.get("inspect_state"));
		}
		// 如果传入了任务信息id，则按id查询
		if (!StringUtil.nullOrBlank(condition.get("info_id"))) {
			sql.append(" and b.info_id=? ");
			sCondition.add(condition.get("info_id"));
		}
		//按办理单位查询
		if(!StringUtil.nullOrBlank(condition.get("org_id"))){
			sql.append(" and a.org_id=? ");
			sCondition.add(condition.get("org_id"));
		}
		if(!StringUtil.nullOrBlank(page.getSortName())&&!StringUtil.nullOrBlank(page.getSortOrder())){
			sql.append(" order by "+page.getSortName() +" "+page.getSortOrder());
		}
		
		// 调父类的方法
		return queryToPagingBean(sql.toString(), page.getOffset(), page
				.getRows(), conn, sCondition);
	}
}

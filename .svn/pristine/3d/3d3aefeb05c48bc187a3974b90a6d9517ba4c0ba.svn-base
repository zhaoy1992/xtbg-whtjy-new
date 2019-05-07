package com.chinacreator.xtbg.core.paper.util;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:PaperUtil.java</p>
 *<p>Description:信息报送工具包</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-22
 */
public class PaperUtil extends XtDbBaseDao {


	/**
	 * 
	  * <b>Summary:根据单位id和角色名称得到单位中人的信息 </b>
	  *     复写方法 getPersonbyOrg
	  * @param con
	  * @param unit_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.paper.dao.PaperMakeNoticeDao#getPersonbyOrg(java.sql.Connection, java.lang.String)
	 */
	public List<Map<String,String>> getPersonbyOrgrole(Connection con, String unit_id,String role_name) throws Exception {
		List<Map<String,String>> map=new ArrayList<Map<String,String>>();
		StringBuffer sql=new StringBuffer();
		List<String> values=new ArrayList<String>();
		sql.append(" select o.*,u.*,r.* from td_sm_organization o left join td_sm_userrole ur on o.org_id=ur.org_id ");
		sql.append(" left join td_sm_user u on u.user_id=ur.user_id  ");
		sql.append(" left join td_sm_role r on r.role_id=ur.role_id ");
		sql.append(" where 1=1");
		if(!StringUtil.isBlank(unit_id)){
			sql.append(" and o.org_id=? ");
			values.add(unit_id);
		}
		if(!StringUtil.isBlank(role_name)){
			sql.append(" and r.role_name=? ");
			values.add(role_name);
		}
		
		map=queryToListMap(sql.toString(), con, values);
		
		return map;
	}
	/**
	*<b>Summary: </b>
	* getOrg4AccUnit(得到可以上报的接收单位)
	* @param con
	* @param userId
	* @param resources_id
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getOrg4AccUnit(Connection con,
			String userId, String resources_id) throws Exception {
		List<Map<String, String>> map = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		List<String> values = new ArrayList<String>();
		sql.append(" select org.org_id unitid, org.org_name unitname");
		sql.append("   from table(split((select c.config_ids");
		sql.append("                      from oa_dataresources_config c");
		sql.append("                     where 1=1 ");
		if (!StringUtil.isBlank(resources_id)) {
			sql.append(" and c.resources_id =? ");
			values.add(resources_id);
		}
		if (!StringUtil.isBlank(userId)) {
			sql.append(" and c.config_typeid=? ");
			values.add(userId);
		}
		sql.append("                       ),");
		sql.append("                    ',')) t,");
		sql.append("        TD_SM_ORGANIZATION org");
		sql.append("  where org.org_level='2' and org.org_id = COLUMN_VALUE");
		map = queryToListMap(sql.toString(), con, values);
		return map;
	}
}

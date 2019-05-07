package com.chinacreator.xtbg.core.purviewmanager.list;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.entity.RoleBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:RoleList.java</p>
 *<p>Description:角色列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-15
 */
public class RoleList extends DataInfoImpl{
	
	private static final Logger LOG = Logger.getLogger(RoleList.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		RoleBean roleParam = null;// 查询参数
		try {
			if (!StringUtil.isBlank(parmjson)) {//查询参数转换为对应的bean
				parmjson = DataControlUtil.replaceStr(parmjson);
				roleParam = (RoleBean) JSONObject.parseObject(parmjson,RoleBean.class);
			}else{
				roleParam = new RoleBean();
			}

			sql.append("select t.role_id,t.role_name,t.role_desc,r.type_name,r.type_id,t.owner_id,e.user_name || '【' || e.user_realname || '】' as owner_user ")
					.append(" from td_sm_role t left join td_sm_roletype r on t.role_type = r.type_id ")
					.append(" left join td_sm_user e on t.owner_id = e.user_id where 1=1 ");

			List<String> paramList = new ArrayList<String>();

			if ((roleParam.getRole_name() != null) && (!"".equals(roleParam.getRole_name()))) {//根据角色名称模糊查询
				sql.append(" and t.role_name like ? ");
				paramList.add("%" + roleParam.getRole_name() + "%");
			}

			if ((roleParam.getRole_type() != null) && (!"".equals(roleParam.getRole_type()))) {//根据角色类型（下拉框）查询
				sql.append(" and r.type_name = ? ");
				paramList.add(roleParam.getRole_type());
			}

			if ((roleParam.getRole_desc() != null) && (!"".equals(roleParam.getRole_desc()))) {//根据角色描述模糊查询
				sql.append(" and t.role_desc like ? ");
				paramList.add("%" + roleParam.getRole_desc() + "%");
			}

			if ((roleParam.getOwner_user() != null) && (!"".equals(roleParam.getOwner_user()))) {//根据角色创建者信息模糊查询
				sql.append(" and e.user_name || '【' || e.user_realname || '】' like  ? ");
				paramList.add("%" + roleParam.getOwner_user() + "%");
			}

			if(sortName != null && !"".equals(sortName)){
				sql.append(" order by ").append(sortName).append(" ").append(sortOrder);
			}else{
				sql.append(" order by r.type_id,t.role_name");
			}
			
			LOG.info("获取系统角色列表sql--->"+sql.toString());
			pdb.preparedSelect(sql.toString(),offset,maxPagesize);
			for (int i = 0; i < paramList.size(); i++) {
				pdb.setString(i+1, paramList.get(i));
			}
			pdb.executePrepared();
			List<RoleBean> list = new ArrayList<RoleBean>();
			for (int j = 0; j < pdb.size(); j++) {
				RoleBean realrole = new RoleBean();
				realrole.setRole_id(pdb.getString(j, "role_id"));
				realrole.setRole_name(pdb.getString(j, "role_name"));
				realrole.setRole_desc(pdb.getString(j, "role_desc"));
				realrole.setRole_type(pdb.getString(j, "type_name"));
				realrole.setRole_type_id(pdb.getString(j, "type_id"));
				realrole.setOwner_id(pdb.getString(j, "owner_id"));
				realrole.setOwner_user(pdb.getString(j,"owner_user"));
				list.add(realrole);
			}
			pagingBean.setList(list);
			pagingBean.setRecords((long)pdb.getTotalSize());
		} catch (Exception e) {
			LOG.error("获取系统角色列表异常",e);
			return null;
		}
		return pagingBean;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}

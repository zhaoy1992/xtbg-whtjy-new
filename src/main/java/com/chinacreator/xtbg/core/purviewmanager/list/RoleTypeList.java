package com.chinacreator.xtbg.core.purviewmanager.list;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.entity.RoleTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:RoleTypeList.java</p>
 *<p>Description:角色类型列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-17
 */
public class RoleTypeList extends DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(RoleTypeList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		RoleTypeBean roleTypeParam = null;// 查询参数
		try {
			if (!StringUtil.isBlank(parmjson)) {//查询参数转换为对应的bean
				parmjson = DataControlUtil.replaceStr(parmjson);
				roleTypeParam = (RoleTypeBean) JSONObject.parseObject(parmjson,RoleTypeBean.class);
			}else{
				roleTypeParam = new RoleTypeBean();
			}

			sql.append("select t.type_name,t.type_desc,t.type_id,t.creator_user_id, ")
					.append(" r.user_name || '【' || r.user_realname || '】' as creator_user from td_sm_roletype t left join  ")
					.append(" td_sm_user r on t.creator_user_id=r.user_id where 1=1 ");

			List<String> paramList = new ArrayList<String>();

			if ((roleTypeParam.getType_name() != null) && (!"".equals(roleTypeParam.getType_name()))) {//根据角色类型名称模糊查询
				sql.append(" and t.type_name like ? ");
				paramList.add("%" + roleTypeParam.getType_name() + "%");
			}

			if ((roleTypeParam.getType_desc() != null) && (!"".equals(roleTypeParam.getType_desc()))) {//根据角色类型描述模糊查询
				sql.append(" and t.type_desc like ? ");
				paramList.add("%" + roleTypeParam.getType_desc() + "%");
			}

			if(sortName != null && !"".equals(sortName)){
				sql.append(" order by ").append(sortName).append(" ").append(sortOrder);
			}else{
				sql.append(" order by t.type_id ");
			}
			
			LOG.info("获取系统角色类型列表sql--->"+sql.toString());
			pdb.preparedSelect(sql.toString(),offset,maxPagesize);
			for (int i = 0; i < paramList.size(); i++) {
				pdb.setString(i+1, paramList.get(i));
			}
			pdb.executePrepared();
			List<RoleTypeBean> list = new ArrayList<RoleTypeBean>();
			for (int j = 0; j < pdb.size(); j++) {
				RoleTypeBean roleTypeBean = new RoleTypeBean();
				roleTypeBean.setCreator_user(pdb.getString(j, "creator_user"));
				roleTypeBean.setCreator_user_id(pdb.getString(j, "creator_user_id"));
				roleTypeBean.setType_desc(pdb.getString(j, "type_desc"));
				roleTypeBean.setType_id(pdb.getString(j, "type_id"));
				roleTypeBean.setType_name(pdb.getString(j, "type_name"));
				list.add(roleTypeBean);
			}
			pagingBean.setList(list);
			pagingBean.setRecords((long)pdb.getTotalSize());
		} catch (Exception e) {
			LOG.error("获取系统角色类型列表异常",e);
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

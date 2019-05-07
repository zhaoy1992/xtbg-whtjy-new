package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.TreeDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.OrgTreeBean;


/**
 *<p>Title:TestZtreeDaoImpl.java</p>
 *<p>Description:测试Ztree的dao实现层类</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-12
 */
public class TreeDaoImpl implements TreeDao {

	private static final Logger LOG = Logger.getLogger(TreeDaoImpl.class);
	private Connection conn;
	/**
	 * @Description  获得机构树的信息
	 * 
	 * @param map 
	 * @return  
	 * @exception 
	 */
	public String getOrgTreeMessage(Map<String, String> map) {
		Statement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		System.out.println("org_id:toporgId==="+map.get("org_id")+":"+map.get("toporgId"));
		if(!StringUtil.nullOrBlank(map.get("org_id"))){
			
			sql.append(" select   ");
			sql.append("       o.org_id,o.parent_id,o.org_name,");
			sql.append(" (select count(i.ORG_ID)  from td_sm_organization i where i.PARENT_ID = o.org_id and ((substr(o.remark4,2,1) < 4 and substr(o.remark4,1,1) = 'A') or (substr(o.remark4,2,1) < 3 and substr(o.remark4,1,1) <> 'A'))) as orgCount");
			sql.append(" from td_sm_organization o ");
			sql.append(" where o.parent_id ='");
			sql.append(map.get("org_id"));
			sql.append("'");
			if(!"false".equals(map.get("isnokeshi"))){
				sql.append(" and ((substr(o.remark4,2,1) < 4 and substr(o.remark4,1,1) = 'A') or (substr(o.remark4,2,1) < 3 and substr(o.remark4,1,1) <> 'A')) ");
			}
			sql.append(" order by o.org_sn");
			
		}
		if(StringUtil.nullOrBlank(map.get("org_id")) && !StringUtil.nullOrBlank(map.get("toporgId"))){
			sql.append(" select o.org_id,o.parent_id,o.org_name,");
			sql.append(" (select count(i.ORG_ID)  from td_sm_organization i where i.PARENT_ID = o.org_id and ((substr(i.remark4,2,1) < 4 and substr(i.remark4,1,1) = 'A') or (substr(i.remark4,2,1) < 3 and substr(i.remark4,1,1) <> 'A'))) as orgCount");
			sql.append(" from td_sm_organization o where o.org_id = '");
			sql.append(map.get("toporgId"));
			sql.append("'");
			if(!"false".equals(map.get("isnokeshi"))){
				sql.append(" and ((substr(o.remark4,2,1) < 4 and substr(o.remark4,1,1) = 'A') or (substr(o.remark4,2,1) < 3 and substr(o.remark4,1,1) <> 'A')) ");
			}
			sql.append(" order by o.org_sn");
		}
		System.out.println("sql.toString()==="+sql.toString());
		String str = "";
		List<OrgTreeBean> orgList = new ArrayList<OrgTreeBean>();
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.createStatement();
			rs = pstmt.executeQuery(sql.toString());
			
			while(rs.next()){
				OrgTreeBean orgTree = new OrgTreeBean();
				orgTree.setOrg_id(rs.getString("org_id"));
				orgTree.setParent_id(rs.getString("parent_id"));
				orgTree.setName(rs.getString("org_name"));
				if(Integer.parseInt(rs.getString("orgCount")) >= 1 ) {
					orgTree.setIsParent("true");
				}
					orgList.add(orgTree);
				}
				str = JSONObject.toJSONString(orgList).toString();
		}catch(Exception e){
			LOG.error("获得机构树的信息报错"+e.getMessage());
			return null;
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		return str;

	}
	
	

	
}

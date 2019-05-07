package com.chinacreator.xtbg.pub.tree.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.countOlinePerson.service.SessionListener;
import com.chinacreator.xtbg.pub.tree.dao.TreeDao;
import com.chinacreator.xtbg.pub.tree.entity.OrgUserTreeBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

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
	/**
	 * 在线人数统计树
	 */
	public String getViewOlineTreeMessage(Map<String, String> map) throws Exception{
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		StringBuffer sql4 = new StringBuffer();
		StringBuffer sql5 = new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		String str="";
		try{
		/**
		 * 查询当前用户的单位
		 */
/*		sql4.append(" select porg.org_id from (select org.org_id,org.remark4 from td_sm_organization org");
		sql4.append("   start with org.org_id ='"+map.get("orgid")+"'");
		sql4.append("    connect by prior org.parent_id=org.org_id) porg");
		sql4.append("     where (substr(porg.remark4,1,1)='A' and substr(porg.remark4,2,1)='3')");
		sql4.append("    or (substr(porg.remark4,1,1)!='A' and substr(porg.remark4,2,1)='2')	");
		pdb.preparedSelect(sql4.toString());
		pdb.executePrepared();
		String porg="";
		for (int i = 0; i < pdb.size(); i++) {
			porg=pdb.getString(i,"org_id");
		}*/
		//将每个在线用户的机构向上递归
		Set<Object> listset=  SessionListener.getSessions();
		sql3.append(" select a.org_id ");
		sql3.append(" from td_sm_organization a");
		sql3.append(" connect by prior a.parent_id = a.org_id");
		sql3.append(" start with a.org_id =");
		sql3.append(" (select o.org_id");
		sql3.append(" from td_sm_user u");
		sql3.append(" left join td_sm_orguser o on u.user_id = o.user_id");
		sql3.append(" where u.user_isvalid != '3' and u.user_name = ? )");
		List<Object> allList=new ArrayList<Object>();
		for (Iterator<Object> iterator = listset.iterator(); iterator.hasNext();) {
			pdb.preparedSelect(sql3.toString());
			pdb.setString(1,(String)iterator.next());
			pdb.executePrepared();
			List<String> orglList=new ArrayList<String>();
			for (int i = 0; i < pdb.size(); i++) {
				orglList.add(pdb.getString(i, "org_id"));
			}
			allList.add(orglList);
		}
		//根据当前用户的orgid向上递归，查询默认展开的
		sql2.append(" select a.org_id,a.parent_id,a.org_name ");
		sql2.append(" from td_sm_organization a ");
		sql2.append(" connect by prior a.parent_id =a.org_id");
		sql2.append(" start with a.org_id= ? ");
		sql2.append(" order by a.org_sn");
		pdb.preparedSelect(sql2.toString());
		pdb.setString(1, map.get("orgid"));
		pdb.executePrepared();
		String openOrgIds=",";
		for (int i = 0; i < pdb.size(); i++) {
			openOrgIds+=pdb.getString(i, "org_id")+",";
		}
		//查询权限配置的科室
/*		String orgids= TreeBusinessDaoImpl.inqueryPersonRule("71", map.get("userid"));
		if(orgids.indexOf(porg)==-1){
			orgids+=","+porg;
		}*/
//		String orgArray[]=orgids.split(",");
		List<OrgUserTreeBean> orgUserList = new ArrayList<OrgUserTreeBean>();
		//查询所有机构A4级别以上机构
		sql.append(" select * from td_sm_organization org ");
		sql.append(" order by org_sn");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			OrgUserTreeBean orgUserTree = new OrgUserTreeBean();
			int countNum=0;
			for (int j = 0; j < allList.size(); j++) {
				List<String> orgList=(List<String>)allList.get(j);
				for (int k = 0; k < orgList.size(); k++) {
					if(orgList.get(k).equals(pdb.getString(i, "org_id"))){
						countNum+=1;
						break;
					}
				}
			}
				orgUserTree.setItem_id(pdb.getString(i, "org_id"));
				orgUserTree.setOrg_id(pdb.getString(i, "org_id"));
				orgUserTree.setParent_id(pdb.getString(i, "parent_id"));
				orgUserTree.setName(pdb.getString(i, "org_name")+"(在线"+countNum+"人)");
				//orgUserTree.setItemtype("1");//
				if(openOrgIds.indexOf(","+pdb.getString(i, "org_id")+",")>-1){
					orgUserTree.setOpen("true");
				}else{
					orgUserTree.setOpen("false");
				}
			
			orgUserList.add(orgUserTree);
		}
		//查询已配置权限的单位中的科室
/*		sql5.append(" select * from td_sm_organization org ");
		sql5.append(" where org.parent_id= ? ");
		List<String> kslList=new ArrayList<String>();
		for (int i = 0; i < orgArray.length; i++) {
			pdb.preparedSelect(sql5.toString());
			pdb.setString(1, orgArray[i]);
			pdb.executePrepared();
			//如果pdb的大小为0则直接认为orgArray[i]等同于科室，加入kslist
			if(pdb.size()>0){
				for (int l = 0; l < pdb.size(); l++) {
					kslList.add(pdb.getString(l, "org_id"));
				}
			}else{
				kslList.add(orgArray[i]);
			}
			
		}*/
		//按配置的机构查询人
		sql1.append(" select  o.org_id,t.user_id,t.user_name,t.user_realname from td_sm_orguser o,td_sm_user t where t.user_isvalid != '3' and t.user_id = o.user_id ");
//		sql1.append(" and exists(select * from td_sm_orguser org where org.user_id=o.user_id and org.org_id= ? )");
		sql1.append(" order by user_sn");
//		for (int i = 0; i < kslList.size(); i++) {
			pdb.preparedSelect(sql1.toString());
//			pdb.setString(1,kslList.get(i));
			pdb.executePrepared();
			for (int j = 0; j < pdb.size(); j++) {
				OrgUserTreeBean orgUserTree = new OrgUserTreeBean();
				orgUserTree.setItem_id(pdb.getString(j, "user_id"));
				orgUserTree.setUser_id(pdb.getString(j, "user_id"));
				orgUserTree.setParent_id(pdb.getString(j, "org_id"));
				orgUserTree.setItem_code(pdb.getString(j, "user_name"));
				orgUserTree.setName(pdb.getString(j, "user_realname"));
				orgUserTree.setIcon("../resources/images/userDown.gif");
				for (Iterator<Object> iterator = listset.iterator(); iterator.hasNext();) {
					String un= (String)iterator.next();
					if(un.equals(pdb.getString(j, "user_name"))){
						orgUserTree.setIcon("../resources/images/user_nonFolder.gif");
					}
				}
				orgUserList.add(orgUserTree);
			}
//		}
		str = JSONObject.toJSONString(orgUserList).toString();
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return str;
	}
	
}

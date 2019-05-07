package com.chinacreator.xtbg.pub.tree.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.PropertiesConfiguration;

import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.security.authentication.EncrpyPwd;
import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.pub.common.LoadConfigurationProperties;
import com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.pub.tree.entity.AreaBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceConfigBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceRoleResultInfoBean;
import com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class ResouceConfigDaoImpl extends LoadConfigurationProperties implements ResourceConfigDao {
	private static final String PATHNAME = "resourcesLogo";//配置文件名称
	private PropertiesConfiguration config;
	
	public ResouceConfigDaoImpl() throws Exception {
		if(null == config){
			LoadConfigurationProperties.setPath(PATHNAME);
			config = LoadConfigurationProperties.getInstance();
		}
	}
	
	public String getResourceLogo(String resourceType) throws Exception {
		
		return config.getString(resourceType).split("#")[0];
	}
	
	public String getResourceConfigType(String resourceType) throws Exception {
		return config.getString(resourceType).split("#")[1];
	}
	
	public String getResourceConfigTypeByResourceLogo(String resourceLogo) throws Exception {
		String resourceConfigType = "";
		Iterator<String> keys = config.getKeys();
		while(keys.hasNext()){
			String resourcesStr = config.getString((String)keys.next());
			if(resourceLogo.equals(resourcesStr.split("#")[0])){
				resourceConfigType = resourcesStr.split("#")[1];
				break;
			}
		}
		return resourceConfigType;
	}
	
	
	/**
	 * @Description  删除资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 * @return  空
	 * @exception 异常说明
	 */
	public void delResourceConfig(ResourceConfigBean resourceConfigBean)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = null;
		
		String resources_configtypeid = resourceConfigBean.getResources_configtypeid();
		String resources_configtypeidArray[] = null;
		String resources_idArray[] = resourceConfigBean.getResources_id().split(",");
		if(!StringUtil.isBlank(resources_configtypeid)) {
			resources_configtypeidArray = resources_configtypeid.split(",");
		    
			for (int i = 0; i < resources_configtypeidArray.length; i++) { 
				for(int j = 0; j < resources_idArray.length ; j ++ ){
					sql = new StringBuffer();
					sql.append("delete  ta_oa_resources_config  r where r.resources_configid in (");
					sql.append(" select c.resources_configid from ta_oa_resources_config c ");
					sql.append(" where c.resources_configtypeid = ? ");
					sql.append(" and c.resources_id =  ? )");
					db.preparedDelete(sql.toString());//删除资源配置表
					db.setString(1, resources_configtypeidArray[i]);
					db.setString(2, resources_idArray[j]);
					db.addPreparedBatch();
				}		
			}
			db.executePreparedBatch();
		}
	}
	
	/**
	 * 查询机构对应的人(包括子机构对应的人员)
	 * @param orgid
	 * @param resourceid
	 * @return List类型
	 */
	public List<ResourceRoleUserBean> queryOrginUserList1(String orgid, String resourceid ,String userid ) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String userIDs = "";
		String ids = "";
		List<ResourceRoleUserBean> resourceRoleUserBeanList = new ArrayList<ResourceRoleUserBean>();
		sql.append("select c.ids ");
		sql.append("  from ta_oa_resources_config c ");
		sql.append(" where c.resources_configtypeid = ? ");
		sql.append("   and c.resources_id = ? ");
		
		String orgidArray[] = null;
		if(!StringUtil.isBlank(orgid)) {
			orgidArray = orgid.split(",");
			for (int k = 0; k < orgidArray.length; k++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, orgidArray[k]);
				pdb.setString(2, resourceid);
				pdb.executePrepared();
				if(pdb.size() > 0) {
					ids = pdb.getString(0, "ids");
					if(!StringUtil.isBlank(ids)) {
						userIDs += ids + ",";
					}
				}
			}
			if(!StringUtil.isBlank(userIDs)) {
				userIDs = userIDs.substring(0, userIDs.length() - 1);
			}
		}

		sql = new StringBuffer();
		sql.append(" select u.user_realname, ou.org_id ,org.org_name ");
		sql.append(" from td_sm_user u");
		sql.append(" left join td_sm_orguser ou on u.user_id = ou.user_id");
		sql.append(" left join td_sm_organization org on  ou.org_id= org.org_id");
		sql.append(" where u.user_id = ?");
		
		String userIDsArray[] = null;
		if(!StringUtil.isBlank(userIDs)) {
			userIDsArray = userIDs.split(",");
			for(int j = 0; j < userIDsArray.length; j++ ) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, userIDsArray[j]);
				pdb.executePrepared();
				if(pdb.size() > 0) {
					ResourceRoleUserBean resUserBean=new ResourceRoleUserBean();
					resUserBean.setUserid(userIDsArray[j]);
					resUserBean.setUsername(pdb.getString(0, "user_realname"));
					resUserBean.setOrgid(pdb.getString(0, "org_id"));	
					resUserBean.setOrgname(pdb.getString(0, "org_name"));	
					resourceRoleUserBeanList.add(resUserBean);
				}
			}
		}
		
		return resourceRoleUserBeanList;
	}

	/**
	 * 查询机构对应的人(包括子机构对应的人员)
	 * @param orgid
	 * @param resourceid
	 * @return List类型
	 */
	public List<ResourceRoleUserBean> queryOrginUserList(String orgid, String resourceType ,String userid ) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String userIDs = "";
		String ids = "";
		String logo = getResourceLogo(resourceType);
		List<ResourceRoleUserBean> resourceRoleUserBeanList = new ArrayList<ResourceRoleUserBean>();
		sql.append("select c.ids ");
		sql.append("  from ta_oa_resources_config c ");
		sql.append(" where c.resources_configtypeid = ? ");
		sql.append("   and c.resources_id = (select r.resources_id ");
		sql.append("                           from ta_oa_resources r ");
		sql.append("                          where r.resources_logo = ?) ");
		
		String orgidArray[] = null;
		if(!StringUtil.isBlank(orgid)) {
			orgidArray = orgid.split(",");
			for (int k = 0; k < orgidArray.length; k++) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, orgidArray[k]);
				pdb.setString(2, logo);
				pdb.executePrepared();
				if(pdb.size() > 0) {
					ids = pdb.getString(0, "ids");
					if(!StringUtil.isBlank(ids)) {
						userIDs += ids + ",";
					}
				}
			}
			if(!StringUtil.isBlank(userIDs)) {
				userIDs = userIDs.substring(0, userIDs.length() - 1);
			}
		}

		sql = new StringBuffer();
		sql.append(" select u.user_realname, ou.org_id ,org.org_name ");
		sql.append(" from td_sm_user u");
		sql.append(" left join td_sm_orguser ou on u.user_id = ou.user_id");
		sql.append(" left join td_sm_organization org on  ou.org_id= org.org_id");
		sql.append(" where u.user_id = ?");
		
		String userIDsArray[] = null;
		if(!StringUtil.isBlank(userIDs)) {
			userIDsArray = userIDs.split(",");
			for(int j = 0; j < userIDsArray.length; j++ ) {
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, userIDsArray[j]);
				pdb.executePrepared();
				if(pdb.size() > 0) {
					ResourceRoleUserBean resUserBean=new ResourceRoleUserBean();
					resUserBean.setUserid(userIDsArray[j]);
					resUserBean.setUsername(pdb.getString(0, "user_realname"));
					resUserBean.setOrgid(pdb.getString(0, "org_id"));	
					resUserBean.setOrgname(pdb.getString(0, "org_name"));	
					resourceRoleUserBeanList.add(resUserBean);
				}
			}
		}
		
		return resourceRoleUserBeanList;
		
//		List<String> idlist=new ArrayList<String>();
//		List<String> userIdList=new ArrayList<String>();
//		List<ResourceRoleUserBean> list=new ArrayList<ResourceRoleUserBean>();
//		Set<String> idSet=new HashSet<String>();
//		PreparedDBUtil pdb = new PreparedDBUtil();
//		String orgids[]={};
//		String userids[]={};
//		if(!StringUtil.nullOrBlank(orgid)){
//			orgids=orgid.split("[//,]");
//		}
//		if(!StringUtil.nullOrBlank(userid)){
//		    	userids=userid.split("[//,]");
//		}
//		String logo="";
//		try {
//			logo= getResourceLogo(resourceType);
//		} catch (Exception e1) {
//			e1.printStackTrace();
//		}
//		//查询所有对应人的id
//		if(!StringUtil.nullOrBlank(orgid)) {
//			for (int i = 0; i < orgids.length; i++) {
//			StringBuffer sql = new StringBuffer();
//			StringBuffer sql2=new StringBuffer();
//			
//			//sql2.append("");
//			sql2.append(" select t.is_leadorg from ta_oa_organdtype t ");
//			sql2.append(" where t.org_id= ? ");
//			try {
//					pdb.preparedSelect(sql2.toString());
//					pdb.setString(1, orgids[i]);
//					pdb.executePrepared();
//					String islead="";
//					for(int j=0;j<pdb.size();j++){
//					   islead=pdb.getString(j, "is_leadorg");
//					}
//
//					sql.append("  select c.ids ");
//					sql.append("  from ta_oa_resources_config c ");
//					//不包括本机构的人员Bug
//					sql.append(" where  (c.resources_configtypeid= '"+orgids[i]+"'" +" or c.resources_configtypeid in ( ");
//					//bug修改
//					if(!"Y".equals(islead)){
//					    //sql.append("  ");
//					    sql.append("   select o.org_id ");
//					    sql.append("   from td_sm_organization o ");
//					    sql.append("   where o.parent_id = '"+orgids[i]+"'");
//					}else {
//					    sql.append("'"+orgids[i]+"'");
//					}
//					sql.append("  )) and c.resources_id = ");
//					sql.append("    (select r.resources_id ");
//					sql.append("      from ta_oa_resources r ");
//					sql.append("     where r.resources_logo =  ? ) ");
//			    		pdb.preparedSelect(sql.toString());
//					//pdb.setString(1, );
//					pdb.setString(1, logo);
//					pdb.executePrepared();
//					for (int j = 0; j < pdb.size(); j++) {
//						String ids=pdb.getString(j, "ids");
//						for(int k = 0 ; k < ids.split(",").length ; k ++){
//							idlist.add(ids.split(",")[k]);
//						}
//					}
//			} catch (SQLException e) {
//					e.printStackTrace();
//			}
//			}
//		}
//		//用户id去重复
//		for (int i = 0; i < idlist.size(); i++) {
//			idSet.add(idlist.get(i));
//		}
//		for (int i = 0; i < userids.length; i++) {
//			idSet.add(userids[i]);
//		}
//		for (String id:idSet) {
//			userIdList.add(id);
//		}
//		//根据用户id查询出用户所属的机构名称
//		for (int i = 0; i < userIdList.size(); i++) {
//			StringBuffer sql1 = new StringBuffer();
//			sql1.append(" select u.user_realname, ou.org_id ,org.org_name ");
//			sql1.append(" from td_sm_user u");
//			sql1.append(" left join td_sm_orguser ou on u.user_id = ou.user_id");
//			sql1.append(" left join td_sm_organization org on  ou.org_id= org.org_id");
//			sql1.append(" where u.user_id = ?");
//			try {
//				pdb.preparedSelect(sql1.toString());
//				pdb.setString(1, userIdList.get(i));
//				pdb.executePrepared();
//				for (int j = 0; j < pdb.size(); j++) {
//					ResourceRoleUserBean resUserBean=new ResourceRoleUserBean();
//					resUserBean.setUserid(userIdList.get(i));
//					resUserBean.setUsername(pdb.getString(j, "user_realname"));
//					resUserBean.setOrgid(pdb.getString(j, "org_id"));	
//					resUserBean.setOrgname(pdb.getString(j, "org_name"));	
//					list.add(resUserBean);
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//		return list;
	}

	
	public ResourceRoleUserBean queryUserMatchOrg(String userId) {
	    PreparedDBUtil pdb = new PreparedDBUtil();
	    //PreparedDBUtil pdb1 = new PreparedDBUtil();
	    StringBuffer sql=new StringBuffer();
	    //StringBuffer sql1=new StringBuffer();
	    ResourceRoleUserBean  rBean=null;
	    
	    sql.append(" select org.remark4,ot.is_leadorg ,ou.org_id,org.org_name,org.remark1,u.user_realname");
	    sql.append(" from td_sm_orguser ou");
	    sql.append(" left join td_sm_organization org on ou.org_id = org.org_id");
	    sql.append(" left join ta_oa_organdtype ot on org.org_id = ot.org_id");
	    sql.append("  left join td_sm_user u on ou.user_id=u.user_id");
	    sql.append(" where ou.user_id = '"+userId+"'");
	    try {
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size()==0){
		    rBean=new ResourceRoleUserBean();	
		}
		for(int i=0;i<pdb.size();i++){
		    rBean=new ResourceRoleUserBean();	
		    rBean.setRemark4(pdb.getString(i, "remark4"));
		    rBean.setIsLeadOrg(pdb.getString(i, "is_leadorg"));
		    rBean.setOrgid(pdb.getString(i, "org_id"));
		    rBean.setOrgname(pdb.getString(i, "org_name"));
		    rBean.setDeptCode(pdb.getString(i, "remark1"));
		    rBean.setUsername(pdb.getString(i, "user_realname"));
//		    if("A4".equals(rBean.getRemark4())||"Y".equals(rBean.getIsLeadOrg())){
//			    
//			    sql1.append(" select org.org_id, org.org_name, org.remark4, org.remark1");
//			    sql1.append("  from td_sm_organization org");
//			    sql1.append(" where org.org_id =");
//			    sql1.append("   (select t.parent_id");
//			    sql1.append("  from td_sm_organization t");
//			    sql1.append(" where t.org_id = '"+rBean.getOrgid()+"')");
//			    
//			    
//			    pdb1.preparedSelect(sql1.toString());
//			    pdb1.executePrepared();
//			    for(int j=0;j<pdb1.size();j++){
//					rBean.setOrgid(pdb1.getString(j, "org_id"));
//					rBean.setOrgname(pdb1.getString(j, "org_name"));
//					rBean.setDeptCode(pdb1.getString(j, "remark1"));
//			    }
//			}
		}
		
		
	    } catch (SQLException e) {
		e.printStackTrace();
	    }
	    
	    return rBean;
	}
	/**
	 * insertResourceConfig 插入资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 * configContent 配置的内容
	 * configType 配置类型   1：单位,2:人员,3..
	 */
	public void insertResourceConfig(ResourceConfigBean resourceConfigBean, String configContent, String configType) throws Exception {
		
		StringBuffer sql = null;
		PreparedDBUtil pdb = new PreparedDBUtil();
		String resources_configtypeid = resourceConfigBean.getResources_configtypeid();
		String resources_configtypeidArray[] = null;
		if(!StringUtil.isBlank(resources_configtypeid) && !StringUtil.isBlank(configContent)) {
			resources_configtypeidArray = resources_configtypeid.split(",");
		
			for (int i = 0; i < resources_configtypeidArray.length; i++) {
			    sql = new StringBuffer();
			    if(!StringUtil.nullOrBlank(configContent)){
			    	 String resources_configid = DaoUtil.findBySequencsName("seq_oa_resources_config");
					    sql.append("insert into ta_oa_resources_config ");
					    sql.append(" (resources_configid,");
					    sql.append(" resources_id,");
					    sql.append(" resources_configtype,");
					    sql.append(" resources_configtypeid,");
					    sql.append(" resources_configrange,");
					    sql.append(" creator_time,");
					    sql.append(" TREE_JSONDATA,");
					    sql.append(" ids)");
					    sql.append(" values");
					    sql.append(" (?,?,'2',?,'2',sysdate,?,?)");
					    
					    pdb.preparedInsert(sql.toString());
					    pdb.setString(1, resources_configid);
					    pdb.setString(2, resourceConfigBean.getResources_id());
					    pdb.setString(3, resources_configtypeidArray[i]);
					    pdb.setString(4, resourceConfigBean.getTreeJson());
					    pdb.setString(5, configContent);
					    pdb.addPreparedBatch();
			    }
			   
			}
		    pdb.executePreparedBatch();
		}
	}
	
	public List<ResourceConfigBean> queryResource() {
		String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		List<ResourceConfigBean> list=new ArrayList<ResourceConfigBean>();
		sql.append(" select t.resources_id, t.resources_name  ");
		sql.append(" from ta_oa_resources t ");
		sql.append(" where t.resources_type = '2' ");
		sql.append(" and (t.is_public = 'Y' or ");
		sql.append(" instr(',' || t.sys_code || ',', "+userArea+") > 0) ");
		sql.append(" order by t.resources_id asc ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				ResourceConfigBean resBean=new ResourceConfigBean();
				resBean.setResources_id(pdb.getString(i, "resources_id"));
				resBean.setResources_name(pdb.getString(i, "resources_name"));
				list.add(resBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}



	/**
	 * 机构配置回选查询
	 */
	public List<String> querybackchoose(String rescourceId, String orgId) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		StringBuffer sql1=new StringBuffer();
		List<String> list=new ArrayList<String>();
		String ids="";
		sql.append(" select c.resources_configid,c.ids from ta_oa_resources_config c ");
		sql.append(" where c.resources_configtypeid = ? ");
		sql.append(" and c.resources_id =  ? ");

		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, orgId);
			pdb.setString(2, rescourceId);
			pdb.executePrepared();
			if(pdb.size() > 0){
				ids = pdb.getString(0, "ids");
			}
			for(int i = 0 ; i < ids.split(",").length; i ++){
				list.add(ids.split(",")[i]);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}



	/**
	 *  查询每个机构下人员
	 * @return list
	 */
	public List<ResourceConfigBean> queryOrgUser(String orgId) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		List<ResourceConfigBean> list=new ArrayList<ResourceConfigBean>();
		sql.append(" select u.user_id, u.user_realname ");
		sql.append(" from td_sm_user u ");
		sql.append(" left join td_sm_orguser ou on u.user_id = ou.user_id ");
		sql.append(" where ou.org_id = ? and u.user_isvalid <> '3' ");
		sql.append(" order by u.user_sn asc ");
		try {
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, orgId);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				ResourceConfigBean resbBean=new ResourceConfigBean();
				resbBean.setUserid(pdb.getString(i, "user_id"));
				resbBean.setUsername(pdb.getString(i, "user_realname"));
				list.add(resbBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public ResourceRoleResultInfoBean getResourceResultInfoByRoleConfig(
			String resources_id,String userId) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		ResourceRoleResultInfoBean resourceRoleResultInfoBean = new ResourceRoleResultInfoBean();

		sql.append(" select rc.resources_id,rc.ids ");
		sql.append("   from ta_oa_resources_config rc");
		sql.append("  where rc.resources_id = ?");
		sql.append(" and rc.resources_configtypeid = ?");

		pdb.preparedSelect(sql.toString());
		pdb.setString(1, resources_id);
		pdb.setString(2, userId);
		pdb.executePrepared();
		
		if(pdb.size() > 0) {
			resourceRoleResultInfoBean.setRole_ids(pdb.getString(0, "ids"));
		}
		
		return resourceRoleResultInfoBean;
	}
	
	
	/**
	 * 查询父机构
	 */
    public ResourceRoleUserBean queryParentOrg(String orgId) {
	PreparedDBUtil pdb = new PreparedDBUtil();
	//PreparedDBUtil pdb1 = new PreparedDBUtil();
	StringBuffer sql = new StringBuffer();
	//StringBuffer sql1 = new StringBuffer();
	ResourceRoleUserBean rBean = null;
	sql.append(" select org.parent_id, org.remark4 ,org.org_name , org.org_id ");
	sql.append("from td_sm_organization org ");
	sql.append(" where org.org_id = ? ");
	try {
	    rBean = new ResourceRoleUserBean();
	    pdb.preparedSelect(sql.toString());
	    pdb.setString(1, orgId);
	    pdb.executePrepared();
	    for (int i = 0; i < pdb.size(); i++) {
		rBean.setOrgid(pdb.getString(i, "org_id"));
		rBean.setRemark4(pdb.getString(i, "remark4"));
		rBean.setOrgname(pdb.getString(i, "org_name"));
		rBean.setParentId(pdb.getString(i, "parent_id"));
	    }
	    char dst[]=null; 
	      dst=  rBean.getRemark4().toCharArray();
	      
	    
	    String tempStr=  String.valueOf(dst[1]);
	    int level= Integer.parseInt(tempStr);
	    if(level > 3) {
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, rBean.getParentId());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
		    rBean.setOrgid(pdb.getString(i, "org_id"));
		    rBean.setRemark4(pdb.getString(i, "remark4"));
		    rBean.setOrgname(pdb.getString(i, "org_name"));
		    rBean.setParentId(pdb.getString(i, "parent_id"));
		}
	    }
	} catch (SQLException e) {
	    e.printStackTrace();
	}

	return rBean;
    }
    
    public boolean isPwdTrue(String username,String pwd) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
	    StringBuffer sql = new StringBuffer();
	    boolean flag=false;
	    sql.append(" select u.user_password from td_sm_user u ");
	    sql.append(" where u.user_name='"+ username+"'");
	    pdb.preparedSelect(sql.toString());
	    pdb.executePrepared();
	    for (int i = 0; i < pdb.size(); i++) {
			String password= pdb.getString(i, "user_password");
			if(password.equals(EncrpyPwd.encodePassword(pwd))){
				flag=true;
			}
		}
		return flag;
	}
    
   

	public boolean unaudited(String username) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		boolean flag=false;
		sql.append(" select i.id from  ta_oa_registerinfo i");
		sql.append(" where i.status=0 and i.username='"+username+"'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size()>0){
			flag=true;
		}
		return flag;
	}
	
	public Object initResourceConfig(BusinessBean bean){
		Map<String, String> result = new HashMap<String, String>();
		String userId = bean.getUserID();
		IOrgManagerExt om = new OrgManagerExtImpl();
		
		List<UserOrgStatusBean> allOrgList = bean.getAllOrgList();//获取公共servlet中塞入的用户全部机构信息
		try{
			if("admin".equals(bean.getUserKey())){
				result.put("isManager", "true");
				return result;
			}
				
			for(UserOrgStatusBean uosbean : allOrgList){
				if(om.isCurOrgManager(uosbean.getOrgID(),userId)){//判断用户在指定的机构中是否为管理员
					result.put("isManager", "true");
					return result;
				}
			}
			result.put("isManager", "false");
		}catch(Exception e){
			e.printStackTrace();
		}

		return result;
	}
	
	public static void main(String[] args) {
		String str = "'1','2','21'";
		String tt = "'1'";
		System.out.println(str.indexOf(tt) > 0);
		
	}
	

}

<%
/**
 * <p>Title: 新增一级机构</p>
 * <p>Description: 新增一级机构提交处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.frameworkset.util.StringUtil
				,com.chinacreator.security.AccessControl
				,com.chinacreator.sysmgrcore.entity.Organization
				,com.frameworkset.common.poolman.DBUtil
				,com.chinacreator.sysmgrcore.manager.OrgManager
				,com.chinacreator.sysmgrcore.manager.JobManager
				,com.chinacreator.sysmgrcore.entity.Orgjob
				,com.chinacreator.sysmgrcore.entity.Job
				,com.chinacreator.sysmgrcore.manager.OrgAdministrator
				,com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl
				,com.chinacreator.sysmgrcore.entity.User
				,com.chinacreator.sysmgrcore.manager.LogManager
				,java.util.List
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.frameworkset.util.StringUtil
				,com.chinacreator.epp.applymanager.dbmanager.OrgUserManager"%>
				
<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);
			
			// 添加同步应用功能
			// 彭盛 2011-7-12
			String sel_appid = StringUtil.replaceNull(request.getParameter("sel_appid"));

			Organization org = new Organization();
			org.setOrgdesc(StringUtil.replaceNull(request.getParameter("orgdesc")));
			org.setChargeOrgId(StringUtil.replaceNull(request.getParameter("chargeOrgId")));
			org.setChildren(StringUtil.replaceNull(request.getParameter("children")));
			org.setCode(StringUtil.replaceNull(request.getParameter("code")));
			org.setCreator(StringUtil.replaceNull(request.getParameter("creator")));
			org.setIsdirectguanhu(StringUtil.replaceNull(request.getParameter("isdirectguanhu")));
			org.setIsforeignparty(StringUtil.replaceNull(request.getParameter("isforeignparty")));
			org.setIsjichaparty(StringUtil.replaceNull(request.getParameter("isjichaparty")));
			org.setIspartybussiness(StringUtil.replaceNull(request.getParameter("ispartybussiness")));
			org.setIsdirectlyparty(StringUtil.replaceNull(request.getParameter("isdirectlyparty")));
			org.setJp(StringUtil.replaceNull(request.getParameter("jp")));
			org.setLayer(StringUtil.replaceNull(request.getParameter("layer")));
			org.setOrg_level(StringUtil.replaceNull(request.getParameter("org_level")));
			org.setOrg_xzqm(StringUtil.replaceNull(request.getParameter("org_xzqm")));			
			org.setOrgId(StringUtil.replaceNull(request.getParameter("orgId")));
			org.setOrgName(StringUtil.replaceNull(request.getParameter("orgName")));
			org.setSatrapJobId(StringUtil.replaceNull(request.getParameter("satrapJobId")));
			org.setRemark5(StringUtil.replaceNull(request.getParameter("remark5")));
			org.setRemark4(StringUtil.replaceNull(request.getParameter("remark4")));
			org.setRemark3(StringUtil.replaceNull(request.getParameter("remark3")));
			org.setRemark2(StringUtil.replaceNull(request.getParameter("remark2")));
			org.setRemark1(StringUtil.replaceNull(request.getParameter("remark1")));
			org.setQp(StringUtil.replaceNull(request.getParameter("qp")));
			org.setPath(StringUtil.replaceNull(request.getParameter("path")));
			org.setParentId(StringUtil.replaceNull(request.getParameter("parentId")));
			org.setOrgSn(StringUtil.replaceNull(request.getParameter("orgSn")));
			org.setOrgnumber(StringUtil.replaceNull(request.getParameter("orgnumber")));
			
			String orgName=org.getOrgName();
			String remark5=org.getRemark5();
			
			boolean tag = true;
			String notice = "添加失败，请联系管理员！";

	         DBUtil db = new DBUtil();
	        //查看机构编号是否存在(全局唯一)
	        //baowen.liu
	        db.executeSelect("select orgnumber from TD_SM_ORGANIZATION where orgnumber='"+ org.getOrgnumber() + "'");
			if (db.size() > 0) {
				tag = false;
				notice = "机构编号已存在！";
			}
			
			//查看机构名称是否存在(全局唯一)
			//baowen.liu
			db.executeSelect("select org_name from TD_SM_ORGANIZATION where org_name='"+ orgName+"'");
			if( db.size()>0){
			    
			    tag = false;
				notice = "机构名称已存在！";
			
			}
			//查看机构显示名称是否存在(同级唯一)
			//baowen.liu
	        db.executeSelect("select remark5 from TD_SM_ORGANIZATION where parent_id='0' and remark5='"+remark5+"'");
			if( db.size()>0){
			    
			    tag = false;
				notice = "一级机构显示名称出现同名！";
		
			}
	         	
			StringBuffer synappmess = new StringBuffer();
			synappmess.append("平台添加成功！");
			boolean isSynApp = false;
			if(tag){
			
				OrgManager orgManager = SecurityDatabase.getOrgManager();
				JobManager jobManager = SecurityDatabase.getJobManager();
				org.setOrgId(null);
	
				// 吴卫雄添加：为了实现与LDAP同步时将当前机构添加到父机构的 member 属性下
				if (org.getParentId() != null && org.getParentId().length() > 0) {
					Organization parentOrg = orgManager.getOrgById(org
							.getParentId());
					org.setParentOrg(parentOrg);
				} else
					org.setParentId("0");
				// 吴卫雄添加结束
	
				boolean r = orgManager.insertOrg(org);
				if (!r) {
					tag = false;
				}
				else
				{
					org = orgManager.getOrgByName(org.getOrgName());
	
					// 王卓添加，添加机构时添加一个待岗岗位		
					Orgjob oj = new Orgjob();
					Job job = new Job();
					job.setJobId("1");
					oj.setJob(job);
					oj.setJobSn(Integer.valueOf("999"));
					Organization org1 = new Organization();
					org1.setOrgId(org.getOrgId());
					request.setAttribute("orgId", org.getOrgId());
					oj.setOrganization(org1);
		
					//保存机构和岗位关系,方法中已经判断机构和岗位的关系是否存在,如果存在就是更新,否则就是新增
					orgManager.storeOrgjob(oj);
		
					//--记日志-----------------
					
					String operContent = "";
					String operSource = accesscontroler.getMachinedID();
					String openModle = "机构管理";
					String userName = accesscontroler.getUserName();
					String description = "";
					LogManager logManager = SecurityDatabase.getLogManager();
					operContent = userName + " 新增了机构 " + org.getOrgName();
					description = "";
					logManager.log(accesscontroler.getUserAccount() ,
							operContent, openModle, operSource, description);
		
					// 添加同步应用功能
					// 彭盛 2011-7-12
					OrgUserManager orgUserManager = new OrgUserManager();
					isSynApp = orgUserManager.synAppInsertOrg(org.getOrgId(),sel_appid,synappmess);				
				}
			}
			if(tag)
			{	
				if(isSynApp){
				%>
				<script>
				    alert("添加成功！");
				</script>
				<%
				}else{
				%>
				<script>
				    alert("<%=synappmess%>");
				</script>
				<%
				}
			}
			else
			{
			%>
				<script>
				    alert("<%=notice%>");
				</script>
			<%
			}
		%>
<script>
    window.onload = function prompt(){
        parent.divProcessing.style.display="none";
        parent.document.getElementById("saveButton").disabled = false;
        parent.document.getElementById("resetButton").disabled = false;
        parent.document.getElementById("backButton").disabled = false;
    }
</script>
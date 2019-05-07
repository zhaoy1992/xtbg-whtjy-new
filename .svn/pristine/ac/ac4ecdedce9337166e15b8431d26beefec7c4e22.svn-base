<%
/**
 * <p>Title: 修改机构信息页面</p>
 * <p>Description: 修改机构信息提交处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
 <%@page import="com.chinacreator.epp.util.orgusertb.OrgNameThreadLocal"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page
	import="com.chinacreator.security.AccessControl
		   ,com.chinacreator.sysmgrcore.entity.Organization
		   ,com.frameworkset.common.poolman.DBUtil
		   ,com.chinacreator.sysmgrcore.manager.OrgManager
		   ,com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl
		   ,com.chinacreator.sysmgrcore.manager.LogManager
		   ,com.chinacreator.sysmgrcore.manager.SecurityDatabase
		   ,com.frameworkset.util.StringUtil"%>
		   
<% 			
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			String orgId = StringUtil.replaceNull(request.getParameter("orgId"));
			
			OrgManager orgManager1 = new OrgManagerImpl();	
			boolean orgs = orgManager1.isCurOrgManager(orgId,control.getUserID());

			Organization org = new Organization();
			org.setOrgdesc(StringUtil.replaceNull(request.getParameter("orgdesc")));
			org.setChargeOrgId(StringUtil.replaceNull(request
					.getParameter("chargeOrgId")));
			org.setChildren(StringUtil.replaceNull(request
					.getParameter("children")));
			org.setCode(StringUtil.replaceNull(request.getParameter("code")));
			org.setCreator(StringUtil.replaceNull(request
					.getParameter("creator")));
			org.setIsdirectguanhu(StringUtil.replaceNull(request
					.getParameter("isdirectguanhu")));
			org.setIsforeignparty(StringUtil.replaceNull(request
					.getParameter("isforeignparty")));
			org.setIsjichaparty(StringUtil.replaceNull(request
					.getParameter("isjichaparty")));
			org.setIspartybussiness(StringUtil.replaceNull(request
					.getParameter("ispartybussiness")));
			org.setIsdirectlyparty(StringUtil.replaceNull(request
					.getParameter("isdirectlyparty")));
			org.setJp(StringUtil.replaceNull(request.getParameter("jp")));
			org.setLayer(StringUtil.replaceNull(request.getParameter("layer")));
			org.setOrg_level(StringUtil.replaceNull(request
					.getParameter("org_level")));
			org.setOrg_xzqm(StringUtil.replaceNull(request
					.getParameter("org_xzqm")));
			org.setOrgId(orgId);
			org.setOrgName(StringUtil.replaceNull(request
					.getParameter("orgName")));
			org.setSatrapJobId(StringUtil.replaceNull(request
					.getParameter("satrapJobId")));
			org.setRemark5(StringUtil.replaceNull(request
					.getParameter("remark5")));
			org.setRemark4(StringUtil.replaceNull(request
					.getParameter("remark4")));
			org.setRemark3(StringUtil.replaceNull(request
					.getParameter("remark3")));
			org.setRemark2(StringUtil.replaceNull(request
					.getParameter("remark2")));
			org.setRemark1(StringUtil.replaceNull(request
					.getParameter("remark1")));
			org.setQp(StringUtil.replaceNull(request.getParameter("qp")));
			org.setPath(StringUtil.replaceNull(request.getParameter("path")));
			org.setParentId(StringUtil.replaceNull(request
					.getParameter("parentId")));
			org.setOrgSn(StringUtil.replaceNull(request.getParameter("orgSn")));
			org.setOrgnumber(StringUtil.replaceNull(request
					.getParameter("orgnumber")));

			boolean tag = true;
			String notice = "修改失败，请联系管理员！";
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			request.setCharacterEncoding("GBK");

			//得到原来机构的编号.显示名称,名称
			String orgnumber = request.getParameter("orgNumber");
           String oldOrgName=request.getParameter("oldOrgname");
           String oldremark5=request.getParameter("oldremark5");
           
			// 吴卫雄增加：为了实现与LDAP同步时将当前机构添加到父机构的 member 属性下
			if (org.getParentId() != null) {
				Organization parentOrg = orgManager.getOrgById(org
						.getParentId());
				org.setParentOrg(parentOrg);
			}
			// 吴卫雄结束
			DBUtil db = new DBUtil();
			String sql = "select orgnumber from TD_SM_ORGANIZATION where"
					+ " orgnumber='" + org.getOrgnumber()
					+ "' and orgnumber<>'" + orgnumber + "'";
			db.executeSelect(sql);
			if (db.size() > 0) {
				tag = false;
				notice = "机构编号已存在！";
			}

         // 判断机构名称是否存在  全局唯一
         //baowen.liu
			db.executeSelect("select org_name from TD_SM_ORGANIZATION where"
					+ " org_name='" + org.getOrgName()+ "' and org_name<>'"+oldOrgName+"'");
			if (db.size() > 0) {
				tag = false;
				notice = "机构名称已存在！";
			}
		 //同级机构显示名称是否相同 同级唯一
  	     //baowen.liu
		db.executeSelect("select remark5 from TD_SM_ORGANIZATION where parent_id='"+org.getParentId()+"' and remark5='"+org.getRemark5()+"' and remark5 <>'"+oldremark5+"'");
		if(db.size() > 0){
			tag=false;
			notice= " 此机构显示名称已存在! ";
		  }	
		  boolean r = false;
			if(tag){
				//同步RTX，修改机构名称
				//朱文 2010-7-30
				OrgNameThreadLocal.add(oldOrgName);		
				r = orgManager.storeOrg(org);
			
				if (!r) {
					tag = false;
				}
				org = orgManager.getOrgByName(org.getOrgName());
	
				//		修改机构重新加载缓冲
				//--记日志--------------------------------
				
				String operContent = "";
				String operSource = control.getMachinedID();
				String openModle = "机构管理";
				String userName = control.getUserName();
				String description = "";
				LogManager logManager = SecurityDatabase.getLogManager();
				operContent = userName + " 修改了机构 " + org.getOrgName();
				description = "";
				logManager.log(control.getUserAccount() ,
						operContent, openModle, operSource, description);
			}
			if (tag) {

			%>
<script>
				    alert("修改成功！");
				    <%
				    	
						if(control.isAdmin()){
						}else if(orgs){
					%>
		  				parent.enable();
					<%}%>
				    
				</script>
<%} else {

				%>
<script>
				    alert("修改失败：<%=notice%>");
				</script>
<%}

		%>
<script>
    window.onload = function prompt(){
        parent.divProcessing.style.display="none";
        parent.document.getElementById("saveButton").disabled = false;
		parent.document.getElementById("resetButton").disabled = false;
		parent.document.getElementById("backButton").disabled = false;
    }
</script>

<%-- 
	描述：新增一级机构提交处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-23
 --%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.frameworkset.util.StringUtil,com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.entity.Organization,com.frameworkset.common.poolman.DBUtil,com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.UserManager,com.chinacreator.sysmgrcore.manager.LogManager,com.chinacreator.sysmgrcore.manager.SecurityDatabase,com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@page
	import="java.util.*,com.chinacreator.sqltransition.api.interfaces.IRecursiveQuery,com.chinacreator.sqltransition.api.factorys.RecursiveQueryFactory"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	boolean tag = true;
	String notice = "删除失败，请联系管理员！";

	OrgManager orgManager = SecurityDatabase.getOrgManager();
	String orgId = StringUtil.replaceNull(request.getParameter("org_id"));
	Organization org = new Organization();
	org.setOrgId(orgId);

	//--记日志-----
	String operContent = "";
	String operSource = control.getMachinedID();
	String openModle = "机构管理";
	String userName = control.getUserName();
	String description = "";
	LogManager logManager = SecurityDatabase.getLogManager();
	operContent = userName + " 删除了机构 " + LogGetNameById.getOrgNameByOrgId(orgId);
	description = "";

	/**
	 * 获取迭代查询 彭盛 2010-4-27
	 */
	IRecursiveQuery iRecursiveQuery = RecursiveQueryFactory.getIRecursiveQueryInstance();
	List list = new ArrayList();
	list = iRecursiveQuery.query("TD_SM_ORGANIZATION", new String[] { "ORG_ID" }, "ORG_ID", "=","'" + orgId + "'", "PARENT_ID", "", IRecursiveQuery.DOWN);

	StringBuffer sql = new StringBuffer();
	sql.append("select distinct b.USER_ID from td_sm_orguser b where b.ORG_ID in ('");
	if (null != list) {
		Map map = new HashMap();
		String temporgid = "";
		for (int i = 0; i < list.size(); i++) {
			map = (Map) list.get(i);
			if (null != map) {
				temporgid = (String) map.get("ORG_ID");
				if (null != temporgid && !temporgid.trim().equals("")) {
					sql.append(temporgid);
					if (i != list.size() - 1) {
						sql.append("','");
					}
				}
			}
		}
	}
	sql.append("')");

	//根据用户ID删除用户所拥有的一切资源(除超级管理员外)
	UserManager userManager = SecurityDatabase.getUserManager();

	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();

	try {
		DBUtil db = new DBUtil();
		db.executeSelect(sql.toString());
		//如果使用了离散用户，删除机构只将机构下的用户的资源和关系删掉，变为离散用户。如果没有离散用户将机构下的用户彻底删除
		boolean islisan = ConfigManager.getInstance().getConfigBooleanValue("enableorgusermove", true);

		//是否可以删除
		boolean isdel = true;
		if (db.size() > 0) {
			String[] userIds = new String[db.size()];
			for (int i = 0; i < db.size(); i++) {
			userIds[i] = String.valueOf(db.getInt(i, "USER_ID"));

			//新增判断逻辑
			//彭盛 2010-9-28
	
			//判断用户是否为超级管理员
			if (control.isAdminByUserid(userIds[i])) {
				notice = "不允许删除！存在用户："+userManager.getUserById(userIds[i]).getUserRealname()+"["+userIds[i]+"]  为超级管理员！";
				isdel = false;
				tag = false;
				break;
			}
	
			//判断用户是否为部门管理员
			if (orgAdministratorImpl.isOrgManager(userIds[i])) {
				notice = "不允许删除！存在用户："+userManager.getUserById(userIds[i]).getUserRealname()+"["+userIds[i]+"]  为部门管理员！";
				isdel = false;
				tag = false;
				break;
			}

			}
			if (isdel) {
				if (userIds.length > 0) {
					if (islisan) {
						userManager.deleteBatchUserRes(userIds);
					} else {
						userManager.deleteBatchUser(userIds);
					}
				}
			}
		}
		if(isdel){
			//递归删除机构
			tag = orgManager.deleteOrg(org);
		}
	} catch (Exception e) {
		tag = false;
		e.printStackTrace();
	}
	if (tag) {
		logManager.log(control.getUserAccount(), operContent,
		openModle, operSource, description);
%>
			<script>
				var bool = true;
				/*
			    alert("删除成功！");
			    if(parent.parent.win){
			    	parent.parent.win.close();
			    }else if(parent.win){
			    	parent.win.close();
			    }
			    parent.parent.location.href = parent.parent.location.href;
			    parent.parent.parent.location.reload();*/
			</script>
<%
	} else {
%>
			<script>
			   // alert("<%=notice%>");
			    /*
			    if(parent.parent.win){
			    	parent.parent.win.close();
			    }else if(parent.win){
			    	parent.win.close();
			    }*/
			</script>
<%
	}
%>
<script>
if(bool) {
	mes = "操作成功";
	/*
	if(mes == "suess") {
		mes = "操作成功";
	} else {
		mes = "操作失败";
		bool = false;
	}*/
	
	var ok=function(){
		window.parent.location.reload();
	}

	if(window.top.removeAlertWindows('',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		} else{
			window.top.alert(mes)
		}
	}
} else {
	alert("<%=notice%>");
}
</script>

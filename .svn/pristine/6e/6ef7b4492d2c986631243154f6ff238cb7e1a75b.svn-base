<%-- 
	描述：新增一级机构提交处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-17
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.Organization"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);
			String type = request.getParameter("type");
			String path = request.getContextPath();
			String curOrgId = "";
			if("add".equals(type)) {
				curOrgId = StringUtil.replaceNull(request.getParameter("parent_id"));
			} else {
				curOrgId = StringUtil.replaceNull(request.getParameter("org_id"));
			}

			Organization org = new Organization();
			org.setOrgnumber(StringUtil.replaceNull(request.getParameter("orgnumber")));
			org.setOrg_name(StringUtil.replaceNull(request.getParameter("org_name")));
			org.setOrg_sn(StringUtil.replaceNull(request.getParameter("org_sn")));
			org.setOrgdesc(StringUtil.replaceNull(request.getParameter("orgdesc")));
			org.setJp(StringUtil.replaceNull(request.getParameter("jp")));
			org.setQp(StringUtil.replaceNull(request.getParameter("qp")));
			org.setRemark1(StringUtil.replaceNull(request.getParameter("remark1")));	//部门描述（财政厅添加  --add by chenjianhua 2014-03-24）
			org.setRemark3(StringUtil.replaceNull(request.getParameter("remark3")));
			org.setRemark5(StringUtil.replaceNull(request.getParameter("remark5")));
			org.setRemark2(StringUtil.replaceNull(request.getParameter("remark2"))); //上级单位ID
			org.setRemark4(StringUtil.replaceNull(request.getParameter("remark4"))); //上级单位名称
			org.setOrg_level(StringUtil.replaceNull(request.getParameter("org_level")));
			org.setOrg_xzqm(StringUtil.replaceNull(request.getParameter("org_xzqm")));
			
			org.setOrg_id(StringUtil.replaceNull(request.getParameter("org_id")));
			org.setParent_id(StringUtil.replaceNull(request.getParameter("parent_id")));
			
			String oldOrgname = StringUtil.replaceNull(request.getParameter("org_name"));
			String oldremark5 = StringUtil.replaceNull(request.getParameter("remark5"));
			
			String orgName = StringUtil.replaceNull(org.getOrg_name());
			String remark5 = StringUtil.replaceNull(org.getRemark5());
			
			boolean tag = true;
			String notice = "error";
			
	         DBUtil db = new DBUtil();
	         if("add".equals(type)) {
		        //查看机构编号是否存在(全局唯一)
		        //baowen.liu
		        db.executeSelect("select orgnumber from TD_SM_ORGANIZATION where orgnumber='"+ org.getOrgnumber() + "'");
				if (db.size() > 0) {
					tag = false;
					notice = "机构编号已存在！";
				}
	         }
			
			//查看机构名称是否存在(全局唯一)
			//baowen.liu
			/*
			db.executeSelect("select org_name from TD_SM_ORGANIZATION where org_name='"+ orgName+"'");
			if( db.size()>0){
			    tag = false;
				notice = "机构名称已存在！";
			
			}*/
			//查看机构显示名称是否存在(同级唯一)
			//baowen.liu
			/*
	        db.executeSelect("select remark5 from TD_SM_ORGANIZATION where parent_id='0' and remark5='"+remark5+"'");
			if( db.size()>0){
			    tag = false;
				notice = "一级机构显示名称出现同名！";
		
			}*/
	         	
			StringBuffer synappmess = new StringBuffer();
			synappmess.append("平台添加成功！");
			OrgManagerServiceIfc orgManagerServiceIfc = new OrgManagerServiceImpl();
			boolean isSynApp = false;
			if(tag) {
				boolean r = false;
				r = orgManagerServiceIfc.addOrUpdateOrg(org);
				isSynApp = true; 
				if (!r) {
					tag = false;
				}
			}
			if(tag) {	
				if(isSynApp) {
%>
					<script>
						mes = "suess";
					</script>
				<%
				} else {
				%>
				<script>
					mes = "<%=synappmess%>";
				</script>
			<%
				}
			} else {
			%>
				<script>
					mes = "<%=notice%>";
				</script>
			<%
			}
			%>
<script>
var bool = true;
if(mes == "error" || mes == "suess") {
	if(mes == "suess") {
		mes = "操作成功";
	} else {
		mes = "操作失败";
		bool = false;
	}
	var ok=function(){
	    window.parent.location.reload();
	}
	if(window.top.removeAlertWindows('',false,bool,mes,true,"<%=path%>/ccapp/oa/purviewmanager/orgusermanager/org/org_tree.jsp?curOrgId='<%=curOrgId%>'")){
		
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		} else{
			window.top.alert(mes)
		}
	}
} else {
	alert(mes);
}
</script>
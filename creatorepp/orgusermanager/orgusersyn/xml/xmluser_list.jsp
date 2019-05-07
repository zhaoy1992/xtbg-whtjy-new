<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.XmlManager"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%!
	String xmlfile = "";
%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);
XmlManager xmlManager = new XmlManager();
String isLoad = StringUtil.replaceNull(request.getParameter("isLoad"),"");
if("true".equals(isLoad)){
	xmlfile = StringUtil.replaceNull(request.getParameter("xmlfile")+"","");
}
String delxmlfile = StringUtil.replaceNull(request.getParameter("delxmlfile"),"");
if("true".equals(delxmlfile)){
	xmlManager.delXmlFile(xmlfile);
}
String userXml = request.getParameter("userXml");
if(userXml==null)userXml = "";
String orgXml = request.getParameter("orgXml");
if(orgXml==null)orgXml = "";
String orgUserXml = request.getParameter("orgUserXml");
if(orgUserXml==null)orgUserXml = "";
String userJobXml = request.getParameter("userJobXml");
if(userJobXml==null)userJobXml = "";
String orgId = request.getParameter("orgId");
if(orgId==null)orgId = "";
String resName = request.getParameter("resName");
if(resName==null)resName = "";
String queryString = (String)request.getParameter("queryString");
	if(queryString==null)queryString = "";
	String queryString1 = (String)request.getParameter("queryString1");
	if(queryString1==null)queryString1 = "";
	String uid = request.getParameter("uid");
	if(uid==null)uid = "";
	String cn = request.getParameter("cn");
	if(cn==null)cn = "";
	String orgName = request.getParameter("orgName");
	if(orgName==null)orgName = "";
	
	//全选处理
	String selectAll = "";
	java.util.List list = xmlManager.getUserByXmlFiles(xmlfile, uid,cn,orgName,queryString);
	if(list!=null){
		int j = 0,lsize = list.size();
		for(j=0;j<lsize;j++){
			com.chinacreator.sysmgrcore.entity.User user =	(com.chinacreator.sysmgrcore.entity.User)list.get(j);
			if(selectAll.equals("")){
				selectAll = user.getUserName();
			}else{
				selectAll += ","+user.getUserName();
			}
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>平台机构用户同步XML文件</title>
<script language="javascript">
	function getXml(){
		//var userFileUrl = parent.top_bar.document.getElementById("userFileUrl").value;
		//var orgFileUrl = parent.top_bar.document.getElementById("orgFileUrl").value;
		//var orgUserFileUrl = parent.top_bar.document.getElementById("orgUserFileUrl").value;
		//var userJobFileUrl = parent.top_bar.document.getElementById("userJobFileUrl").value;
		//alert(userJobFileUrl);
		//document.getElementById("userXml").value=userFileUrl;
		//document.getElementById("orgXml").value=orgFileUrl;
		//document.getElementById("orgUserXml").value=orgUserFileUrl;
		//document.getElementById("userJobXml").value = userJobFileUrl;
	}
  var notin_ids = "";
  var orgId = '<%=orgId%>';
  var arr = parent.org_tree.document.getElementsByName("org_radio");
  
  function rtxtbpt(type){
  	var allDept_User = parent.org_tree.document.getElementById("org_user_obj").value;
  	var userJobUrl = document.getElementById("userJobUrl").value;
  	if(allDept_User==""){
  		alert("请选择你要同步的机构和用户");
  		return false;
  	}
  	
  	if(confirm("确定同步吗？将要删除或修改数据！")){
  		document.getElementById("allDept_User").value=allDept_User;
  		document.getElementById("type").value=type;
  		document.getElementById("divProcessing").style.display="";
  		document.getElementById("dosave").submit();
  		parent.org_tree.document.body.disabled = true;
  		document.body.disabled = true;
  		parent.org_tree.document.getElementById("org_user_obj").value = "";
  		parent.org_tree.document.getElementById("queryString").value = "";
  	}
  }
  function checkAll(checkBoxAll,checkBoxOne){
    var checkBoxAlls = document.getElementById(checkBoxAll);
  	var checkBoxOnes = document.getElementsByName(checkBoxOne);
  	for(i=0;i<checkBoxOnes.length;i++){
  		checkBoxOnes[i].checked=checkBoxAlls.checked;
  	}
  }
  
  function adduser(){
  	//if(orgId==""){
  	//	alert("请先选择需要同步的机构");
  	//	return false;
  	//}
  	var pUsers = parent.org_tree.document.getElementById("org_user_obj").value;//父窗口存储同步机构用户id,页面全局存储
  	var pQueryString = parent.org_tree.document.getElementById("queryString").value;//父窗口存储选择用户id,页面全局存储
  	var checkBoxOnes = document.getElementsByName("checkBoxOne");
  	var flag = false;
  	for(i=0;i<checkBoxOnes.length;i++){
  		if(checkBoxOnes[i].checked){
  			if(notin_ids==""){
  				notin_ids += checkBoxOnes[i].value;
  			}else{
  				notin_ids += ","+checkBoxOnes[i].value;
  			}
  			flag = true;
  		}
  	}
	if(!flag){
	  	alert("请选择你要同步的xml用户");
	  	return;
	}if(document.getElementById("queryString1").value!=""){
  		document.getElementById("queryString1").value += ","+notin_ids;
	}else{
  		document.getElementById("queryString1").value = notin_ids;
  	}
  	if(pQueryString==""){
  		parent.org_tree.document.getElementById("queryString").value = notin_ids;//新加选择用户
  	}else{
  		parent.org_tree.document.getElementById("queryString").value += ","+notin_ids;//累加已选择用户
  	}
  	document.getElementById("queryString").value = parent.org_tree.document.getElementById("queryString").value;
  	if(pUsers==""){
  		parent.org_tree.document.getElementById("org_user_obj").value = orgId+":"+notin_ids+";";//机构用户id组合形式，用于同步时一次提交
  	}else{
  		if(pUsers.indexOf(";"+orgId+":")>0){//判断当前机构是否在存储里有记录，有则修改
  			var index = pUsers.indexOf(";"+orgId+":");
  			var index1 = index+2+orgId.length;
  			var s_str = pUsers.substring(0,index1);
  			var e_str = pUsers.substring(index1);
  			parent.org_tree.document.getElementById("org_user_obj").value = s_str+notin_ids+","+e_str;
  		}else if(pUsers.indexOf(orgId+":")==0){//判断当前机构是否在存储里有记录，有则修改
  			var index = pUsers.indexOf(orgId+":");
  			var index1 = index+1+orgId.length;
  			var s_str = pUsers.substring(0,index1);
  			var e_str = pUsers.substring(index1);
  			parent.org_tree.document.getElementById("org_user_obj").value = s_str+notin_ids+","+e_str;
  		}else{//存储里不存在当前机构
  			parent.org_tree.document.getElementById("org_user_obj").value += orgId+":"+notin_ids+";";
  		}
  	}
  	//alert("org_user_obj="+parent.org_tree.document.getElementById("org_user_obj").value);
  	//alert("ppppqueryString="+parent.org_tree.document.getElementById("queryString").value);
  	document.getElementById("userList").submit();
  }
  
  function addalluser(){
  	//if(orgId==""){
  	//	alert("请先选择需要同步的机构");
  	//	return false;
  	//}
  	parent.org_tree.document.getElementById("org_user_obj").value += orgId+':<%=selectAll%>;';
  	if(parent.org_tree.document.getElementById("queryString").value==""){
  		parent.org_tree.document.getElementById("queryString").value = '<%=selectAll%>';
  	}else{
  		parent.org_tree.document.getElementById("queryString").value += ',<%=selectAll%>';
  	}
  	if(document.getElementById("queryString").value==""){
  		document.getElementById("queryString").value = '<%=selectAll%>';
  	}else{
  		document.getElementById("queryString").value += ',<%=selectAll%>';
  	}
  	if(document.getElementById("queryString1").value==""){
  		document.getElementById("queryString1").value = '<%=selectAll%>';
  	}else{
  		document.getElementById("queryString1").value += ',<%=selectAll%>';
  	}
  	//alert("queryString="+document.getElementById("queryString").value);
  	//alert("queryString1="+document.getElementById("queryString1").value);
  	document.getElementById("userList").submit();
  }
  function deluser(){
  	var pUsers = parent.org_tree.document.getElementById("org_user_obj").value;//父窗口存储同步机构用户id,页面全局存储
  	var pQueryString = parent.org_tree.document.getElementById("queryString").value;//父窗口存储选择用户id,页面全局存储
  	var delQueryString = "";
  	var obj = document.getElementById("select");
  	var e = obj.options;
  	for(i=0;i<e.length;i++){
		if(e[i].selected==true){
			parent.org_tree.document.getElementById("queryString").value = del("queryString",e[i].value);
			parent.org_tree.document.getElementById("org_user_obj").value = delObj("org_user_obj",orgId,e[i].value);
			document.getElementById("queryString1").value = del("queryString1",e[i].value);
   		}
	}
  	document.getElementById("queryString").value = parent.org_tree.document.getElementById("queryString").value;
  	document.getElementById("userList").submit();
  }
  function delalluser(){
  	var pUsers = parent.org_tree.document.getElementById("org_user_obj").value;//父窗口存储同步机构用户id,页面全局存储
  	var pQueryString = parent.org_tree.document.getElementById("queryString").value;//父窗口存储选择用户id,页面全局存储
  	var delQueryString = "";
  	if(document.getElementById("queryString").value=="all_select"){
  		parent.org_tree.document.getElementById("org_user_obj").value = "";
  		parent.org_tree.document.getElementById("queryString").value = "";
  		document.getElementById("queryString").value = "";
  		document.getElementById("queryString1").value = "";
  	}else{
	  	var obj = document.getElementById("select");
	  	var e = obj.options;
	  	for(i=0;i<e.length;i++){
				parent.org_tree.document.getElementById("queryString").value = del("queryString",e[i].value);
				parent.org_tree.document.getElementById("org_user_obj").value = delObj("org_user_obj",orgId,e[i].value);
				document.getElementById("queryString1").value = del("queryString1",e[i].value);
		}
	  	document.getElementById("queryString").value = parent.org_tree.document.getElementById("queryString").value;
  	}
  	document.getElementById("userList").submit();
  }
  function del(obj1,str2){//特殊字符串删除函数
  	var retStr = "";
  	var pStr = "";
  	if(obj1=="queryString1"){
  		pStr = document.getElementById(obj1).value;
  	}else{
  		pStr = parent.org_tree.document.getElementById(obj1).value;
  	}
  	if(pStr==str2){
  		return "";
  	}
  	//var pStrs = pStr.split(",");
  	//var i = 0,len = pStr.length;
  	//for(i=0;i<len;i++){
  	//	if(pStrs[i]==str2){
  	//		pStrs[i] = "";
  	//	}
  	//	if(pStrs[i]!=""){
	//  		if(retStr==""){
	//  			retStr = pStrs[i];
	//  		}else{
	//  			retStr += ","+pStrs[i];
	//  		}
	//  	}
  	//}
  	if(pStr.indexOf(str2+",")==0){
  		return pStr.substring(0,pStr.indexOf(str2+","))+pStr.substring(pStr.indexOf(str2+",")+str2.length+1);
  	}else if(pStr.indexOf(","+str2+",")>0){
  		return pStr.substring(0,pStr.indexOf(","+str2+","))+","+pStr.substring(pStr.indexOf(","+str2+",")+str2.length+2);
  	}else if(pStr.indexOf(","+str2)==pStr.length-str2.length-1){
  		return pStr.substring(0,pStr.indexOf(","+str2))
  	}
  	return pStr;
  }
  function delObj(obj1,orgId,str2){//特殊字符串删除函数???
  	var pStr = parent.org_tree.document.getElementById(obj1).value;
  	var sss = pStr.split(";");
  	var index = pStr.indexOf(orgId+":");
  	if(pStr==str2){
  		return "";
  	}
  	if(pStr.indexOf(orgId+":")==0||pStr.indexOf(";"+orgId+":")>0){
  		for(var i=0;i<sss.length;i++){
  			if(sss[i].indexOf(orgId+":")==0){
  				var pStr_start = pStr.substring(0,pStr.indexOf(sss[i]));
  				var pStr_end = pStr.substring(pStr.indexOf(sss[i])+sss[i].length);
  				var pStr_mid = sss[i];
  				if(pStr_mid.indexOf(","+str2+",")>0){
  					pStr_mid = pStr_mid.substring(0,pStr_mid.indexOf(","+str2+","))+","+pStr_mid.substring((pStr_mid.indexOf(","+str2+",")+str2.length+2));
  				}else if(pStr_mid.indexOf(str2+",")==orgId.length+1){
  					pStr_mid = pStr_mid.substring(0,pStr_mid.indexOf(":"+str2+","))+":"+pStr_mid.substring((pStr_mid.indexOf(":"+str2+",")+str2.length+2));
  				}else if(pStr_mid.indexOf(","+str2)==pStr_mid.length-str2.length-1){
  					pStr_mid = pStr_mid.substring(0,pStr_mid.length-str2.length-1)
  				}else if(pStr_mid==orgId+":"+str2){
  					pStr_mid = "";
  					pStr_end = pStr_end.substring(1);//删除";"
  				}
  				pStr = pStr_start+pStr_mid+pStr_end;
  			}
  		}
  	}
  	return pStr;
  }
	 function jumpPage(){
	 	document.unxmlfileform.submit();
	  	parent.document.location.assign("xmlupload.jsp");
	}
	
	function pageclose(){
		document.unxmlfileform.submit();
		window.close();
	}
	function window.onbeforeunload()
	{
	    if(event.clientX>360&&event.clientY<0||event.altKey)
	    {
	       document.unxmlfileform.submit();
	    }
	}
</script>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
			<form name="dosave" method="post" action="do_xml.jsp" target="xmlhiddenFrame">
				<input name="allDept_User" value="" type="hidden">
				<input name="queryString2" value="<%=queryString %>" type="hidden">
				<input name="type" value="" type="hidden">
				<input name="userUrl" value="<%=userXml %>" type="hidden">
				<input name="orgUrl" value="<%=orgXml %>" type="hidden">
				<input name="orgUserUrl" value="<%=orgUserXml %>" type="hidden">
				<input name="userJobUrl" value="<%=userJobXml %>" type="hidden">
				<input name="xmlfile" value="<%=xmlfile %>" type="hidden">
			</form>
	<form name="userList" method="post" action="xmluser_list.jsp" >
	<table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
				<tr><td align="center">XML导入平台</td></tr>
			</table>
		  		<table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
		  				<tr>
	           				    <td colspan=3>
	           				    	<div align="left">
	           				    		登录名称：
	           				    		<input type="text" name="uid" value="<%=uid %>">
	           				    		用户实名：
	           				    		<input type="text" name="cn" value="<%=cn %>">
	           				    		所属机构：
	           				    		<input type="text" name="orgName" value="<%=orgName %>">
	           				    	</div>
	           				    </td>
	           			</tr>
						<tr>
	           				    <td colspan=3 align="center">
	           				    		<input type="submit" name="bt_cx" class="input" value="查询XML用户">
	           				    </td>
	           			</tr>
			  			<tr>
					  	<td width="70%" valign=top>
					  		<div style="width:100%;height:370;overflow:auto;">
		  					<table cellspacing="0" cellpadding="0" border="0"> 
		         				<pg:listdata dataInfo="com.chinacreator.epp.util.orgusertb.Xml_UserList" keyName="xml_user_list" />
		         				<!--分页显示开始,分页标签初始化-->
								<pg:pager maxPageItems="15" scope="request" data="xml_user_list" isList="false">
									<tr><td align=center nowrap colspan=23><B>XML用户列表</B></td></tr>
									<tr>
										<!--设置分页表头-->
										
										<td height='30' class="headercolor" width="1%">
										<P align="left">
										<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
										</P>
										</td>
										<td height='30' class="headercolor" width="33%" nowrap>登陆名称</td>
										<td height='30' class="headercolor" width="33%" nowrap>用户实名</td>
										<td height='30' class="headercolor" width="33%" nowrap>所属机构</td>
									</tr>
									
									<pg:param name="userName" />
									<pg:param name="userRealname" />
									<pg:param name="queryString" />
									<pg:param name="orgId" />
									<pg:param name="resName" />
									<pg:param name="uid" />
									<pg:param name="cn" />
									<pg:param name="orgName" />
									<pg:param name="remark" />
									<pg:param name="queryString1" />
									<pg:param name="orgXml" />
									<pg:param name="userXml" />
									<pg:param name="orgUserXml" />
									<!--检测当前页面是否有记录-->
									<pg:notify>
										<tr height="18px" class="labeltable_middle_tr_01">
											<td colspan=23 align='center'>
												暂时没有用户或者文件格式不对
											</td>
										</tr>
									</pg:notify>
									<pg:list>
										<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
											<td class="tablecells" nowrap="nowrap">
												<P align="left">
													<font color="#0000FF">
														<INPUT type="checkbox" name="checkBoxOne" onclick="" value='<pg:cell colName="userName" defaultValue=""/>' >
													</font>
												</P>
											</td>
											<td  class="tablecells" nowrap="nowrap">
												<pg:cell colName="userName" defaultValue="" />
											</td>
											<td  class="tablecells" nowrap="nowrap">
												<pg:cell colName="userRealname" defaultValue="" />
											</td>
											<td  class="tablecells" nowrap="nowrap">
												<pg:cell colName="remark4" defaultValue="" />
											</td>
										</tr>
									</pg:list>
										<input name="userXml" value="<%=userXml %>" type="hidden">
										<input name="orgXml" value="<%=orgXml %>" type="hidden">
										<input name="orgUserXml" value="<%=orgUserXml %>" type="hidden">
										<input name="userJobXml" value="<%=userJobXml %>" type="hidden">
										<input name="orgId" value="<%=orgId %>" type="hidden">
										<input name="resName" value="<%=resName %>" type="hidden">
										<input name="queryString" value="<%=queryString %>" type="hidden"/>
		
									</pg:pager>
						  	</table>
						  	</div>
					  	</td>
						<td width="5%" align="center" valign="middle">
								<input name="button1" type="button" class="input" value="&gt;" onclick="adduser();">
								<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addalluser();">
								<br>
								<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="delalluser();">
								<input name="button4" type="button" class="input" value="&lt;" onclick="deluser();">
						</td>
					  	<td align="left" width="25%" valign="top">
					  			<b>平台机构【<%=resName %>】用户</b>
								<pg:listdata dataInfo="com.chinacreator.epp.util.orgusertb.Sel_Xml_UserList" keyName="sel_user_id_list" />
								<pg:pager maxPageItems="10" scope="request" data="sel_user_id_list" isList="false">
								<select name="select" multiple style="width:100%" size=23>
									<pg:list>
										<option value="<pg:cell colName="userName"/>">
											<pg:cell colName="userRealname" defaultValue="" />
										</option>
									</pg:list>
								</select>
								<input name="queryString1" value="<%=queryString1 %>" type="hidden">
								<input name="orgId" value="<%=orgId %>" type="hidden">
								<input name="resName" value="<%=resName %>" type="hidden">
								</pg:pager>
					  	</td>
				  	</tr>
					
				</table>
			</form>
			<div align="right">
			<input type=button name=bt1 value="上一步" class="input" onclick="jumpPage();"/>
			<input type=button name=bt1 value="同步到&gt;平台" class="input" onclick="rtxtbpt('imp')"/>
			<input type="button" value="关闭" class="input"	onclick="pageclose();" />
			</div>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:'none'">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
		<tr>
			<td bgcolor=#3A6EA5>
				<marquee align="middle" behavior="alternate" scrollamount="5">
					<font color=#FFFFFF>...处理中...请等待...</font>
				</marquee>
			</td>
		</tr>
	</table>
</div>
<form name="unxmlfileform" action="xmluser_list.jsp" target="xmluser_list" method="post">
			<input name="delxmlfile" value="true" type="hidden">					
</form>
</body>
<iframe name="xmlhiddenFrame" width=0 height=0></iframe>
</html>
					 	
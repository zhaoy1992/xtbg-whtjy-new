<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>

<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.ResourceAction"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.OperManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.framework.MenuItem"%>
<%@ page import="java.util.List,java.util.ArrayList,com.chinacreator.framework.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%String resId = request.getParameter("resId");
			String resName = request.getParameter("resName");
			String columnID = request.getParameter("columnID");
			String menuPath = request.getParameter("nodePath");
			String resTypeId2 = "column"; //资源类型id
			String resId2 = resId; //资源id
			String title = resName; //资源名称

			//得模块和子栏目
			String mouseupimg = "";
			String mouseoverimg = "";
			String mouseclickimg = "";
			String mouseoutimg = "";
			String headimg = "";
			String WorkspaceContent = "";
			String WorkspaceToolbar = "";
			String Left = "";
			String Top = "";
			boolean used =true;
			String Title = "";
			String Id = "";
			String Name = "";
			String NavigatorToolbar = "";
			String NavigatorContent = "";
			String ParentPath = "";
			String Path = "";
			String StatusContent = "";
			String StatusToolbar = "";

			MenuItem menu = Framework.getInstance().getMenu(menuPath);
			Module module = null;
			Item item = null;
			if (menu instanceof Item) {
				item = (Item) menu;
				mouseupimg = item.getMouseupimg();
				mouseoverimg = item.getMouseoverimg();
				mouseclickimg = item.getMouseclickimg();
				mouseoutimg = item.getMouseoutimg();
				headimg = item.getHeadimg();
				Id = item.getId();
				Name = item.getName();
				WorkspaceContent = item.getWorkspaceContent();
				ParentPath = item.getParentPath();
				Path = item.getPath();
				used = item.isUsed();
				//StatusContent = item.getStatusContent();
				//StatusToolbar = item.getStatusToolbar();

				Left = item.getLeft();
				Top = item.getTop();
				if (item.getWorkspaceToolbar() == null) {
					WorkspaceToolbar = "...................";
				} else {
					WorkspaceToolbar = item.getWorkspaceToolbar();
				}

				if (item.getStatusContent() == null) {
					Title = "...................";
				} else {
					Title = item.getStatusContent();
				}
				if (item.getNavigatorContent() == null) {
					NavigatorContent = "...................";
				} else {
					NavigatorContent = item.getNavigatorContent();
				}
				if (item.getNavigatorToolbar() == null) {
					NavigatorToolbar = "...................";
				} else {
					NavigatorToolbar = item.getNavigatorToolbar();
				}
				if (item.getStatusContent() == null) {
					StatusContent = "...................";
				} else {
					StatusContent = item.getStatusContent();
				}
				if (item.getStatusToolbar() == null) {
					StatusToolbar = "...................";
				} else {
					StatusToolbar = item.getStatusToolbar();
				}

			} else if (menu instanceof Module) {
				module = (Module) menu;
				mouseupimg = module.getMouseupimg();
				mouseoverimg = module.getMouseoverimg();
				mouseclickimg = module.getMouseclickimg();
				mouseoutimg = module.getMouseoutimg();
				headimg = module.getHeadimg();
				Id = module.getId();
				Name = module.getName();
				ParentPath = module.getParentPath();
				Path = module.getPath();
				if (module.getTitle() == null) {
					Title = "...................";
				} else {
					Title = module.getTitle();
				}
			}

			if (resId2 == null) {
				resId2 = (String) request.getAttribute("resId2");
			}
			if (resTypeId2 == null) {
				resTypeId2 = (String) request.getAttribute("resTypeId2");
			}
			OperManager operManager = SecurityDatabase.getOperManager();
			ResourceManager resManager = new ResourceManager();

			List operList = resManager.getOperations(resTypeId2);
			//	List allRole = roleManager.getRoleList();
			if (operList == null) {
				operList = new ArrayList();        
			}
			request.setAttribute("operList", operList);
			//request.setAttribute("allRole",allRole);
			String stored = (String) request.getAttribute("stored");
			if (stored == null) {
				stored = "0";
			}
			String roleId = "";
			String rid = "";

			%>
<html>


	<head>
		<tab:tabConfig />
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="javascript">
	
	var resTypeId2 ="<%=resTypeId2%>";
			var resId2 ="<%=resId2%>";
			var http_request = false;
			//初始化，指定处理的函数，发送请求的函数
			function send_request(url){
				http_request = false;
				//开始初始化XMLHttpRequest对象
				if(window.XMLHttpRequest){//Mozilla
					http_request = new XMLHttpRequest();
					if(http_request.overrideMimeType){//设置MIME类别
						http_request.overrideMimeType("text/xml");
					}
				}
				else if(window.ActiveXObject){//IE
					try{
						http_request = new ActiveXObject("Msxml2.XMLHTTP");
					}catch(e){
						try{
							http_request = new ActiveXObject("Microsoft.XMLHTTP");
						}catch(e){
						}
					}
				}
				if(!http_request){
					alert("不能创建XMLHttpRequest对象");
					return false;
				}
				http_request.onreadystatechange = processRequest;
				http_request.open("GET",url,true);
				http_request.send(null);
			}

			function processRequest(){
				if(http_request.readyState == 4){                  
					if(http_request.status == 200){
						//alert(http_request.responseText);
					}
					else{
						alert("对不起，服务器错误");
					}
				}
			}
			//------------------------------------------------------------------------------------------
			function changebox(currCheck,rid,priority,opid){
				var roleList = document.roleList;
				var isRecursion = 0;
				//是否递归

				if(roleList.isRecursion.length)				
				{
				if(roleList.isRecursion[rid].checked)
						isRecursion = 1;
				}
			   else if(roleList.isRecursion.checked)
			    {
			    	isRecursion = 1;
			    }
			    
				var menuPath="<%=menuPath%>";
				var resid = "<%=resId2%>";
				var restypeid = roleList.resTypeId.value;
				//checked
				if(currCheck.checked){
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
				//not checked
				else{
					send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}

				setCheck(currCheck,rid,priority);
			}
			
			function isRecursionClick(currCheck,rid,priority){
		
				var roleList = document.roleList;
				var isRecursion = 0;
				var opid = 0;
				//是否递归

				if(roleList.isRecursion.length)				
				{
					if(roleList.isRecursion[rid].checked)
						isRecursion = 1;
				}
			    else if(roleList.isRecursion.checked)
			    {
			    	isRecursion = 1;
			    }
			    
				var menuPath="<%=menuPath%>";
				var resid = "<%=resId2%>";
				var restypeid = roleList.resTypeId.value;
					
					
				var opers = roleList.all("opId"+rid);
				//没有复选框
  				if(!opers){  	
  					alert("您没有选择操作");
  					return;
  				}
  				var n=roleList.all("opId"+rid).length;
  				//只有一个复选框
  				if(!n){
	  				opid = roleList.all("opId"+rid).value;
	  			
					if(roleList.all("opId"+rid).checked){
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
					}
					else
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
				//有多个复选框
				for(var i= 0;i<n;i++){
				
					opid = opers[i].value;
					if(opers[i].checked){						
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=1&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
					}
					else
						send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked=0&title=<%=title%>&isRecursion="+isRecursion+"&menuPath="+menuPath);
				}
			}
			
			function changebox2(opid,checked){
				var isRecursion = 0;
				//是否递归
				if(document.forms[0].isRecursion.checked)
					isRecursion = 1;
				var roleList = document.roleList;
				var resid = "<%=resId2%>";
				var menuPath="<%=menuPath%>";
				var restypeid = roleList.resTypeId.value;
				send_request('saveRoleOp.jsp?resId='+resid+'&resTypeId='+restypeid+'&opId='+opid+"&checked="+checked+"&title=<%=title%>&menuPath="+menuPath+"&isRecursion="+isRecursion);
			}

			function setCheck(currCheck,rid,priority)
			{
			   	var o = document.getElementsByName(currCheck.name);
				var prioritylist = document.getElementsByName("priority"+rid);
				if (currCheck.checked==true && priority.length >1 && (priority.match(/[0-9]/))){
					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;

						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1)&& priority.substring(1,2) == v.substring(1,2) )
						{
							o[i].checked=true;
							changebox2(o[i].value,1);
							//alert("3:"+o[i].value);
							//o[i].disabled=true;
						}
					}

					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;
						if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(1,2) != v.substring(1,2) )
						{
							o[i].checked=false;
							changebox2(o[i].value,0);
							//alert("4:"+o[i].value);
							//o[i].disabled=false
						}
					}
				}
				if (currCheck.checked==false  && priority.length >1 && (priority.match(/[0-9]/))){
					for (var i=0;i<prioritylist.length;i++){
						var v = prioritylist[i].value;
						if ( v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1) )
						{
							if ( o[i].checked==true ){
								//currCheck.checked==true;
								//o[i].disabled=false;
							}
						}
					}

				}
			}

	</script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<tab:tabContainer id="foo-menu-container" selectedTabPaneId="foo-menu">
			<tab:tabPane id="foo-menu" tabTitle="菜单信息查看">
				<FORM name="11" method="post">
					<tr>
						<td height="35" align=center colspan=5>
							<P>
								<B>菜单信息明细</B>
							</P>
							<P>
								<STRONG></STRONG>
							</P>
							<P></P>
							<P></P>
						</td>
					</tr>

					<fieldSet id="1" title="333">
						<LEGEND align=left>
							<strong><FONT size=2>菜单基本信息</FONT></strong>
						</LEGEND>
						<table>
							<tr>
								<td width="100" height="28" class="detailtitle" wiidth="50%">
									Id:
								</td>
								<td class="detailcontent">
									<%=Id%>
								</td>
							</tr>
							<tr>
								<td width="100" height="28" class="detailtitle" wiidth="50%">
									used:
								</td>
								<td class="detailcontent">
									<%=used%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Name:
								</td>
								<td class="detailcontent">
									<%=Name%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Title:
								</td>
								<td class="detailcontent">
									<%=Title%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Path:
								</td>
								<td class="detailcontent">
									<%=Path%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									ParentPath:
								</td>
								<td class="detailcontent">
									<%=ParentPath%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									Left:
								</td>
								<td class="detailcontent">
									<%=Left%>
								</td>
							</tr>

							<tr>
								<td width="124" height="28" class="detailtitle">
									Top:
								</td>
								<td class="detailcontent">
									<%=Top%>
								</td>
							</tr>
						</table>
					</fieldSet>
					<fieldSet>
						<LEGEND align=left>
							<strong><FONT size=2>菜单对应文件</FONT></strong>
						</LEGEND>
						<table>
							<tr>
								<td class="detailtitle" height="28" wiidth="40%">
									WorkspaceContent:
								</td>
								<td class="detailcontent">
									<%=WorkspaceContent%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									WorkspaceToolbar:
								</td>
								<td class="detailcontent">
									<%=WorkspaceToolbar%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									NavigatorToolbar:
								</td>
								<td class="detailcontent">
									<%=NavigatorToolbar%>
								</td>
							</tr>

							<tr>
								<td class="detailtitle" height="28">
									NavigatorContent:
								</td>
								<td class="detailcontent">
									<%=NavigatorContent%>
								</td>
							</tr>

							<tr>
								<td class="detailtitle" height="28">
									StatusContent:
								</td>
								<td class="detailcontent">
									<%=StatusContent%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									StatusToolbar:
								</td>
								<td class="detailcontent">
									<%=StatusToolbar%>
								</td>
							</tr>
						</table>
					</fieldSet>
					<fieldSet title="菜单图片信息">
						<LEGEND align=left>
							<strong><FONT size=2>菜单图片信息</FONT></strong>
						</LEGEND>
						<table>
							<tr>
								<td class="detailtitle" height="28" wiidth="40%">
									mouseupimg:
								</td>
								<td class="detailcontent">
									<%=mouseupimg%>
								</td>
							</tr>

							<tr>
								<td class="detailtitle" height="28">
									mouseoverimg:
								</td>
								<td class="detailcontent">
									<%=mouseoverimg%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									mouseclickimg:
								</td>
								<td class="detailcontent">
									<%=mouseclickimg%>
								</td>
							</tr>
							<tr>
								<td class="detailtitle" height="28">
									mouseoutimg:
								</td>
								<td class="detailcontent">
									<%=mouseoutimg%>
								</td>
							</tr>
							<tr>
								<td width="124" height="28" class="detailtitle">
									headimg:
								</td>
								<td class="detailcontent">
									<%=headimg%>
								</td>
							</tr>

						</table>
					</fieldSet>


				</FORM>
			</tab:tabPane>


			
		</tab:tabContainer>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOutOrgDBManager"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOrgDBManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);

	String userID = StringUtil.replaceNull(request
			.getParameter("userID"), "");
	String orgID = StringUtil.replaceNull(
			request.getParameter("orgID"), "");
	UserCheckOrgDBManager userCheckOrgDBManager = new UserCheckOrgDBManager();
	UserCheckOutOrgDBManager userCheckOutOrgDBManager = new UserCheckOutOrgDBManager();
	String orgName = userCheckOutOrgDBManager
			.getOrgNameStrByOrgIDs(orgID);
	StringBuffer userIDs = new StringBuffer();
%>
<html>
	<head>
		<title>��������</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript" src="pagegrey.js" charset="utf-8">
		</script>
		<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- �������� -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/userCheckOrgDWRManager.js'></script>
		<!-- dwr end -->

		<script language="JavaScript" type="text/javascript">
			//�õ�ѡ����û�ID
			function getSelUserOrgID(){
				var checkbox = document.getElementsByName("checkRadioOne");
				var seluserorgid = "";
				for(var i=0;i<checkbox.length;i++){
					if(checkbox[i].checked){
						return checkbox[i].value;						
					}
				}
				return seluserorgid;
			}
			//�õ�ͬ��Ӧ��
			function getSelApp(){
				var checkbox = document.getElementsByName("checkBoxOne");
				var selApp = "";
				for(var i=0;i<checkbox.length;i++){
					if(checkbox[i].checked){
						selApp += checkbox[i].value+",";
					}
				}
				return selApp;
			}
					
			function edit(){
				var userorgid = getSelUserOrgID();
				if(userorgid==""){
					alert("��ѡ����Ҫ�޸ĵ��û���");
					return;
				}
				var url = "editusercheckinorg.jsp?userorgid="+userorgid;
			    var winaddorg = window.showModalDialog(url,window,"dialogWidth:"+(880)+"px;dialogHeight:"+(680)+"px;help:no;scroll:no;status:no;maximize=yes;minimize=0");
				if(winaddorg=="ok")
				{
					window.location=location;
				}
			}
			//ҳ����ת
			function jumpPage(){
				//�ύ��ҳ����
				popSignFlow(1);
				document.location.assign("usercheckorgselect.jsp?userID=<%=userID%>&&orgID=<%=orgID%>");
			}
			function showSecondOperation(obj){
				if(obj=="part"){
					document.getElementById("second_operation").style.display="none";
				}else{
					document.getElementById("second_operation").style.display="block";
				}
			}
			function save() {
				var userorgid = getSelUserOrgID();
				var selapp = getSelApp();
				if(userorgid==""){
					alert("��ѡ����Ҫ���ص��û���");
					return;
				}
				
					//�ύ��ҳ����
					popSignFlow(1);			
					
					userCheckOrgDWRManager.saveUserCheckInOrg(userorgid,selapp,saveResult);
			}
			function saveResult(obj){
				DWREngine.setPreHook(function() {});				
				DWREngine.setPostHook(function() {});
				
				//ҳ���һָ�����
				cancelSign();
				if(obj[0]=="false"){
					alert(obj[1]);
				}else{
					alert("����ɹ���");
					window.returnValue = "ok";
					window.location=location;
				}
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<form name="myform" action="usercheckinorg.jsp" method="post">
			<div id="contentborder" align="center">
				<br />
				<br />
				<fieldset style="width: 90%; height: 500px;">
					<LEGEND align=center>
						<FONT size="2">�û�����ѡ��</FONT>
					</LEGEND>
					<br />
					<table width="85%">						
						<tr>
							<td align="center">
							<div style="border:0px solid ; padding:5px;height:200px;overflow:auto;" > 
								<table width="100%" border="0" cellpadding="0" cellspacing="1"
									class="thin">
									<pg:listdata
										dataInfo="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckInOrgList"
										keyName="userCheckInOrg" />
									<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
									<pg:pager maxPageItems="5" scope="request"
										data="userCheckInOrg" isList="false">
										<pg:param name="userID" value="<%=userID %>" />
										<pg:param name="orgID" value="<%=orgID %>" />
										<tr class="labeltable_middle_td">
											<!--���÷�ҳ��ͷ-->
											<td class="headercolor" width="6%">
												
											</td>
											<td height='20' class="headercolor">
												�����û�
											</td>
											<td height='20' class="headercolor">
												�������
											</td>
											<td height='20' class="headercolor">
												��������
											</td>
											<td height='20' class="headercolor">
												��ʼʱ��
											</td>
											<td height='20' class="headercolor">
												����ʱ��
											</td>
											<td height='20' class="headercolor">
												����ʱ��
											</td>
											<td height='20' class="headercolor">
												����ʱ����
											</td>
										</tr>
										<!--��⵱ǰҳ���Ƿ��м�¼-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													��ʱû�е����û�
												</td>
											</tr>
										</pg:notify>

										<!--list��ǩѭ�����ÿ����¼-->
										<pg:list>
										<%userIDs.append(dataSet.getString("user_id")).append(","); %>
											<tr class="labeltable_middle_tr_01">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="radio" name="checkRadioOne"															
															value='<pg:cell colName="user_id" defaultValue=""/>:<pg:cell colName="org_id" defaultValue=""/>'>
													</P>
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="user_realname" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="org_name" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="change_name" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="start_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="cache_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="end_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:equal colName="end_operation" expressionValue="0">������</pg:equal>
													<pg:equal colName="end_operation" expressionValue="1">�Զ�����</pg:equal>
												</td>
											</tr>
										</pg:list>
										<tr height="30" class="labeltable_middle_tr_01">
											<td colspan=100 align='right'>
												��
												<pg:rowcount />
												����¼
												<pg:index />
											</td>
										</tr>
									</pg:pager>
								</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<hr/>
								ѡ��ͬ��Ӧ��
								<div style="border:0px solid ; padding:5px;height:200px;overflow:auto;" > 
								<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">									
									<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckOutOrgSelAppList" keyName="userCheckOutOrgSelAppList" />
									<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
									<pg:pager maxPageItems="10" scope="request" data="userCheckOutOrgSelAppList" isList="true">
										<tr class="labeltable_middle_td">
											<!--���÷�ҳ��ͷ-->
											<td class="headercolor" width="6%">
												<P align="left">
													<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
												</P>
											</td>
											<td height='20' class="headercolor">
												Ӧ��ID
											</td>
											<input class="text" type="hidden" name="selectId">
											<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
											<td height='20' class="headercolor">
												Ӧ������
											</td>														
											<td height='20' class="headercolor">
												����
											</td>
											<td height='20' class="headercolor">
												״̬
											</td>
										</tr>
										<!--��⵱ǰҳ���Ƿ��м�¼-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													��ʱû��Ӧ��
												</td>
											</tr>
										</pg:notify>
				
										<!--list��ǩѭ�����ÿ����¼-->
										<pg:list>
											<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" id="app_<pg:cell colName="app_id" defaultValue=""/>"
												enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="app_id" defaultValue=""/>'
														<%														
														if(userCheckOrgDBManager.isUserExist(userIDs.toString(),dataSet.getString("app_id"))){
														%>
														checked="checked"
														<%}%>
														>
													</P>
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="app_id" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="app_name" defaultValue="" />
												</td>								
												<td height='20' align=left class="tablecells">
													<pg:cell colName="remark" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:equal colName="enablestatus" expressionValue="0">��ע��</pg:equal>
													<pg:equal colName="enablestatus" expressionValue="1">�Ѽ���</pg:equal>
												</td>
										</pg:list>
										<tr height="30" class="labeltable_middle_tr_01">
											<td colspan=100 align="center">
												��
												<pg:rowcount />
												����¼
												<pg:index />
											</td>
										</tr>
									</pg:pager>
								</table>
								</div>
							</td>
						</tr>
					</table>
				</fieldset>
				<div align="center">
					<table width="35%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<input name="Submit" type="button" class="input" value="��һ��"
										onclick="jumpPage()">
									<input type="button" class="input" value="�޸�" onclick="edit()">
									<input type="button" class="input" value="����" onclick="save()">
									<input type="button" class="input" value="�ر�" onclick="removeAlertWindows('',true);">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</body>
</html>

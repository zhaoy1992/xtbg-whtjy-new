
<%@page import="com.chinacreator.eppissue.menuissue.expmenu.menu.ExpJaweManager"%>
<%@page import="com.chinacreator.eppissue.menuissue.interfaces.IComponentsExpManage"%>
<%@page import="com.chinacreator.eppissue.menuissue.factorys.ComponentsFactory"%>
<%@page import="com.chinacreator.eppissue.menuissue.configutil.ConfigManage"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@include file="expmenuconfigvo.jsp"%>
<%@ page
	import="java.util.List,com.chinacreator.eppissue.menuissue.expmenu.dbmanager.ExpmenuManager"%>

<%
	ExpmenuManager expmenuManager = new ExpmenuManager();
	request.setAttribute("sel_jawe_id_list", expmenuManager
			.getSelJaweList(control.getCurrentSystemID(), sel_jawe_id,
			sort,default_jawe_id));
			
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
		<script language="JavaScript" src="../../include/pager.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>

		<script
			src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
		</script>

		<script language="JavaScript">
	
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getApplyInfo(e,app_id){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = app_id;	
	}	
	
	//ҳ����ת
	function jumpPage(obj){
		document.jawelistform.sel_name.value = "";
		document.jawelistform.creator_person.value = "";
		document.jawelistform.begin_data.value = "";
		document.jawelistform.end_data.value = "";
		document.jawelistform.sort.value = "";

		if(obj=="eformlist"){
			document.jawelistform.action="eformlist.jsp";
		}else if(obj=="jawelist"){
			document.jawelistform.action="jawelist.jsp";
		}else if(obj=="reportlist"){
			document.jawelistform.action="reportlist.jsp";		
		}else if(obj=="back"){	
			document.jawelistform.action="businessclassselect.jsp";
		}else if(obj="filelist"){
			document.jawelistform.action="filelist.jsp";
		}else{
			return;
		}
		//�ύ��ҳ����
		popSignFlow(1);

		document.jawelistform.submit();
	}	

		//�鿴����
		function showJawe(mgrName,pid,ec_id)
		{
			//������֤�Ƿ��Ѿ���
			var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valIsOpen&pid="+pid);
			if(retX=="true")
			{
				alert("���ļ��Ѿ��������û���,���Ժ����ԣ�");
				return false;
			}
			var reg=/#/g;
			mgrName=mgrName.replace(reg,"~");			
			document.getElementById("myFrame").src="<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id="+ec_id+"&op=read&mgrName="+mgrName;
				
		}
		
		function getcheckid(){
			var selid = "<%=sel_jawe_id%>";	
				var obj = document.getElementsByName("checkBoxOne");
				for (var i=0;i<obj.length;i++) {								
					if (obj[i].checked){
			       		selid += obj[i].value + ",";			       					       		
				   } 
				}				
				return selid;				
		}
				
		function addeform(){
			if(getcheckid()==""){
				alert("��ѡ�����̣�");
				return;
			}else{
				//�ύ��ҳ����
				popSignFlow(1);
				document.jawelistform.sel_jawe_id.value=getcheckid();
				document.jawelistform.submit();
			}
		}
		
		function deleform(){
			if(document.all("select").selectedIndex < 0){
			    	alert("û��Ҫɾ�������̣�");
			    	return;
			}							
			//�ύ��ҳ����
			popSignFlow(1);
			var temp = "<%=sel_jawe_id%>";
			for(var i=0;i<document.all("select").options.length;i++){
				if(document.all("select").options[i].selected){								
						temp += document.all("select").options[i].value + ",";
					}
				}										
			var obj = new Array();
			obj = temp.split(",");
			for(var j=0;j<obj.length-1;j++){
				for(var k=j+1;k<obj.length;k++){
					if(obj[k]!=""){
						if(obj[j]==obj[k]){							
							obj[j]=obj[k]="";
						}
					}
				}
			}
			var selid = "";
			for(var z=0;z<obj.length;z++){
				if(obj[z]!=""){
					selid += obj[z] + ",";
				}
			}			
			document.jawelistform.sel_jawe_id.value=selid;
			document.jawelistform.submit();
		}
		
		//ѡ���û�
		function operuserlist(){
			var ww = openWin('userlist.jsp?app_id=<%=control.getCurrentSystemID()%>&&creator_person='+document.jawelistform.creator_person.value,screen.availWidth-520,screen.availHeight-400);
			if(ww)
			{
				document.jawelistform.creator_person.value=ww;				
			}
		}
		
		//��������
		function saveconfig(){
			//�ύ��ҳ����
			popSignFlow(1);
			menuissueChange.saveConfig("<%=moduleID%>","<%=control.getCurrentSystemID()%>","<%=default_eform_id+sel_eform_id%>","<%=default_jawe_id+sel_jawe_id%>","<%=default_report_id+sel_report_id%>","<%=default_filepath+sel_filepath%>",saveconfigresult);
		}
		
		function saveconfigresult(obj){
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			
			//ҳ���һָ�����
			cancelSign();
			if(obj[0]=="false"){
				alert(obj[1]);
			}else{
				alert("����ɹ���");
				window.close();
			}
		}
		
		//����
		function resetclick(){
			document.jawelistform.sel_jawe_id.value="<%=init_sel_jawe_id%>";
		
			//�ύ��ҳ����
			popSignFlow(1);
			
			document.jawelistform.submit();
		}
</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="left">
			<form name="jawelistform" action="jawelist.jsp" method="post">
				<input type="hidden" name="isFill" value="true">
				<input type="hidden" name="moduleID" value="<%=moduleID%>">
				<input type="hidden" name="workclass" value="<%=workclass%>">
				<input type="hidden" name="sel_eform_id" value="<%=sel_eform_id%>">
				<input type="hidden" name="sel_jawe_id" value="<%=sel_jawe_id%>">
				<input type="hidden" name="sel_filepath" value="<%=sel_filepath%>">
				<input type="hidden" name="default_businessclass_id" value="<%=default_businessclass_id%>">
				<input type="hidden" name="default_eform_id" value="<%=default_eform_id%>">
				<input type="hidden" name="default_jawe_id" value="<%=default_jawe_id%>">				
				<input type="hidden" name="default_report_id" value="<%=default_report_id%>">
				<input type="hidden" name="default_filepath" value="<%=default_filepath%>">	
				<input type="hidden" name="sel_report_id" value="<%=sel_report_id%>">
				<input type="hidden" name="init_sel_eform_id" value="<%=init_sel_eform_id%>">
				<input type="hidden" name="init_sel_jawe_id" value="<%=init_sel_jawe_id%>">
				<input type="hidden" name="init_sel_report_id" value="<%=init_sel_report_id%>">
				<input type="hidden" name="init_sel_filepath" value="<%=init_sel_filepath%>">
				<input type="hidden" name="selectId">
				<fieldset style="width: 100%;">
					<LEGEND align="left">
						<table width="200" class="thin">
							<tr>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('filelist')">
									�ļ�
								</td>	
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('eformlist')">
									��
								</td>
								<td height='20' class="headercolor">
									����
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('reportlist')">
									����
								</td>
							</tr>
						</table>
					</LEGEND>
					<hr width="100%">
					<table width="100%" border="0" cellpadding="1" cellspacing="1"
						class="thin">
						<tr>
							<td class="detailtitle" width="20%" align=right>
								���ƣ�
							</td>
							<td class="detailcontent" width="90%">
								<input type="text" name="sel_name" value="<%=sel_name%>"
									style="width:70%" maxlength="70">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="10%" align=right>
								�����ˣ�
							</td>
							<td class="detailcontent" width="90%">
								<input type="text" name="creator_person"
									value="<%=creator_person%>" style="width:70%" maxlength="70">
								<input type="button" value="ѡ��" class="input"
									onclick="operuserlist();">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="10%" align=right>
								�������ڣ�
							</td>
							<td class="detailcontent" width="90%">
								��ʼ���ڣ�
								<input type="text" name="begin_data" value="<%=begin_data%>"
									style="width:26%" onClick="showdate(this)" readonly="readonly">
								�������ڣ�
								<input type="text" name="end_data" value="<%=end_data%>"
									style="width:26%" onClick="showdate(this)" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="15%" align=right>
								����ʽ��
							</td>
							<td class="detailcontent" width="30%" align="center">
								<table width="100%">
									<tr>
										<td align="left" style="border: 0px;">
											<input type="radio" name="sort" value="person">
											��������
											<input type="radio" name="sort" value="data"
												checked="checked">
											����������
										</td>
										<td align="right" style="border: 0px;">
											<input name="Submit4" type="submit" class="input" value="��ѯ">
											<input name="Submit22" type="button" class="input" value="����"
												onClick="sel_name.value=creator_person.value=begin_data.value=end_data.value=''">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table width="100%">
						<tr>
							<td width="100%" align="left" valign="top">
								<table width="100%" border="0" cellpadding="0" cellspacing="1"
									class="thin">
									<tr>
										<td height='30' class="detailtitle" align=center colspan=10>
											<b>�����б�</b>
										</td>
									</tr>
									<pg:listdata
										dataInfo="com.chinacreator.eppissue.menuissue.expmenu.menu.JaweList"
										keyName="selectlist" />
									<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
									<pg:pager maxPageItems="10" form="jawelistform" scope="request"
										data="selectlist" isList="false" commitevent="0">

										<tr class="labeltable_middle_td">
											<!--���÷�ҳ��ͷ-->
											<td class="headercolor" width="6%">
												<P align="left">
													<INPUT type="checkbox" name="checkBoxAll"
														onClick="checkAll('checkBoxAll','checkBoxOne')" value="on">
												</P>
											</td>
											<td height='20' class="headercolor">
												����
											</td>
											<td height='20' class="headercolor">
												��������
											</td>
											<td height='20' class="headercolor">
												������
											</td>
											<td height='20' class="headercolor">
												����
											</td>
											<td height='20' class="headercolor">
												����״̬
											</td>
											<td height='20' class="headercolor">
												����
											</td>
										</tr>
										<!--��⵱ǰҳ���Ƿ��м�¼-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													��ʱû������
												</td>
											</tr>
										</pg:notify>

										<!--list��ǩѭ�����ÿ����¼-->
										<pg:list>
											<tr class="labeltable_middle_tr_01"
												onMouseOver="this.className='mousestyle1'"
												onMouseOut="this.className= 'mousestyle2'"
												onClick="getApplyInfo(this,'<pg:cell colName="app_id" defaultValue=""/>')"
												id="app_<pg:cell colName="app_id" defaultValue=""/>"
												enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="checkbox" name="checkBoxOne"
															onClick="checkOne('checkBoxAll','checkBoxOne')"
															value='<pg:cell colName="expmenu_id" defaultValue=""/>'>
													</P>
												</td>
												<td height='20' align=left class="tablecells">
													<%=dataSet.getString("expmenu_name")
												.split("#")[0]%>
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_creator_data" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_creator_person" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_remark" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:equal colName="expmenu_state" expressionValue="0">δ����</pg:equal>
													<pg:equal colName="expmenu_state" expressionValue="1">�ѷ���</pg:equal>
												</td>
												<td height='20' align=left class="tablecells">
													<input type="button" value="�鿴" class="input"
														onclick="showJawe('<pg:cell colName="expmenu_name" defaultValue=""/>','<pg:cell colName="expmenu_id" defaultValue=""/>','<pg:cell colName="expmenu_workclass" defaultValue=""/>')">
												</td>
										</pg:list>
										<tr height="30" class="labeltable_middle_tr_01">
											<td colspan=100 align='right'>
												��
												<pg:rowcount />
												����¼
												<pg:index sizescope="10"/>
											</td>
										</tr>
									</pg:pager>
								</table>
							</td>
							<td width="50" align="center" valign="middle">
								<input name="button1" type="button" class="input" value="&gt;"
									onclick="addeform();">
								<input name="button4" type="button" class="input" value="&lt;"
									onclick="deleform();">
							</td>
							<td align="left" valign="top">
								<table width="100%" border="0" cellpadding="0" cellspacing="1"
									class="thin">
									<tr>
										<td height='20' class="tablecells" align=center colspan=10>
											<b>��ѡ����</b>
										</td>
									</tr>
									<tr>
										<td>
											<select name="select" multiple style="width:100" size="20">
												<pg:list requestKey="sel_jawe_id_list" needClear="false">
													<option value="<pg:cell colName="expmenu_id"/>">
														<%=dataSet.getString("expmenu_name").split("#")[0]%>
													</option>
												</pg:list>
											</select>
										</td>
									</tr>
								</table>
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
										onClick="jumpPage('back')">
									<input name="Submit" type="button" class="input" value="��������"
										onClick="saveconfig()">
									<input name="Submit" type="button" class="input" value="����" onClick="resetclick()">
									<input name="Submit" type="button" class="input" value="����" onClick="window.close();">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
<iframe id="myFrame" scrolling="no" noresize frameborder="0" />
	<div id="divProcessing" style="display: none;"></div>
	<script type="text/javascript">
<!--	
		var r = document.jawelistform.sort;
		for(var i = 0; i < r.length; i++){			
			if(r[i].value == "<%=sort%>"){
					r[i].checked = true;
					break;
				}
			}
	
//-->
</script>

<jsp:directive.page import="oracle.sql.ROWID" />
<jsp:directive.page
	import="com.frameworkset.common.tag.pager.tags.RowIDTag" />
<jsp:directive.page import="com.chinacreator.sysmgrcore.web.tag.RowTag" />

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.eppissue.menuissue.interfaces.IComponentsExpManage"%>
<%@page import="com.chinacreator.eppissue.menuissue.factorys.ComponentsFactory"%>
<%@page import="com.chinacreator.eppissue.menuissue.configutil.ConfigManage"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@include file="expmenuconfigvo.jsp"%>
<%@ page
	import="java.util.*,com.chinacreator.eppissue.menuissue.expmenu.dbmanager.ExpmenuManager"%>

<%
	//得到流程绑定的表单 
	//ExpJaweManager jaweManager = new ExpJaweManager();
	//jawd_banding_eform_id=jaweManager.getDefaultEfromId(default_jawe_id, sel_jawe_id , control.getCurrentSystemID());
	IComponentsExpManage jaweExpManage = ComponentsFactory.getIComponentsExpManage(ConfigManage.sfs_JAWE);
	String jawe_eform_id = "";
	if(null!=jaweExpManage){
		Map map = jaweExpManage.getEformIDsByJaweID(moduleID,default_jawe_id+sel_jawe_id);
		if(null!=map){
			String eformids = (String)map.get("eformid");
			if(null!=eformids&&!eformids.trim().equals("")){
				jawe_eform_id = eformids;
			}
		}
	}	
	ExpmenuManager expmenuManager = new ExpmenuManager();
	request.setAttribute("sel_eform_id_list", expmenuManager
			.getSelEformList(control.getCurrentSystemID(), sel_eform_id,sort,default_eform_id+jawe_eform_id));
%>
<html>
	<head>
		<title>属性容器</title>

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
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
		</script>

		<script language="JavaScript"> 
	
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getApplyInfo(e,app_id){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = "<%=control.getCurrentSystemID()%>";	
	}	
	
	//页面跳转
	function jumpPage(obj){
		document.eformlistform.sel_name.value = "";
		document.eformlistform.creator_person.value = "";
		document.eformlistform.begin_data.value = "";
		document.eformlistform.end_data.value = "";
		document.eformlistform.sort.value = "";
		if(obj=="eformtablelist"){
			document.eformlistform.action="eformtablelist.jsp";
		}else if(obj=="jawelist"){
			document.eformlistform.action="jawelist.jsp";
		}else if(obj=="reportlist"){
			document.eformlistform.action="reportlist.jsp";		
		}else if(obj=="back"){	
			document.eformlistform.action="businessclassselect.jsp";
		}else if(obj="filelist"){
			document.eformlistform.action="filelist.jsp";
		}else{
			return;
		}
		
		//提交后页面变灰
		popSignFlow(1);
		
		document.eformlistform.submit();
	}	

		//查看表单
		function showForm(e,djid)
		{
			var sUrl="<%=request.getContextPath()%>/eformsys/fceform/design/design_show.htm?tbtype=3&djid="+djid;
			window.open(sUrl);	
						
		}
		
		function getcheckid(){
			var selid = "<%=sel_eform_id%>";	
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
				alert("请选择表单！");
				return;
			}else{
				//提交后页面变灰
				popSignFlow(1);
				document.eformlistform.sel_eform_id.value=getcheckid();
				document.eformlistform.submit();
			}
		}		
		
		function deleform(){
			if(document.all("select").selectedIndex < 0){
			    	alert("没有要删除的表单！");
			    	return;
			}							
			//提交后页面变灰
			popSignFlow(1);
			var temp = "<%=sel_eform_id%>";
			var defaultEformId ="<%=default_eform_id%>+<%=jawe_eform_id%>";
			var defaultEformIds = defaultEformId.split(",");

			for(var i=0;i<document.all("select").options.length;i++){
			var flag = false;//modify by wen.zhu 由选择流程添加的表单不加入选择串中
				if(document.all("select").options[i].selected){
						for(j=0;j<defaultEformIds.length;j++){
							if(	document.all("select").options[i].value ==	defaultEformIds[j]){						
								flag = true;
								break;
							}
						}
						if(!flag)
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
			document.eformlistform.sel_eform_id.value=selid;
			document.eformlistform.submit();
		}
						
		//选择用户
		function operuserlist(){
			var ww = openWin('userlist.jsp?app_id=<%=control.getCurrentSystemID()%>&&creator_person='+document.eformlistform.creator_person.value,screen.availWidth-520,screen.availHeight-400);
			if(ww)
			{
				document.eformlistform.creator_person.value=ww;				
			}
		}
		
		//保存配置
		function saveconfig(){
			//提交后页面变灰
			popSignFlow(1);
			menuissueChange.saveConfig("<%=moduleID%>","<%=control.getCurrentSystemID()%>","<%=default_eform_id+sel_eform_id%>","<%=default_jawe_id+sel_jawe_id%>","<%=default_report_id+sel_report_id%>","<%=default_filepath+sel_filepath%>",saveconfigresult);
		}
		
		function saveconfigresult(obj){
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			
			//页面变灰恢复正常
			cancelSign();
			if(obj[0]=="false"){
				alert(obj[1]);
			}else{
				alert("保存成功！");
				window.close();
			}
		}
		
		//重置
		function resetclick(){
			document.eformlistform.sel_eform_id.value="<%=init_sel_eform_id%>";
		
			//提交后页面变灰
			popSignFlow(1);
			
			document.eformlistform.submit();
		}
</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="left">
			<form name="eformlistform" action="eformlist.jsp" method="post">
				<input type="hidden" name="isFill" value="true">
				<input type="hidden" name="moduleID" value="<%=moduleID%>">
				<input type="hidden" name="workclass" value="<%=workclass%>">
				<input type="hidden" name="sel_eform_id" value="<%=sel_eform_id%>">
				<input type="hidden" name="sel_jawe_id" value="<%=sel_jawe_id%>">
				<input type="hidden" name="sel_report_id" value="<%=sel_report_id%>">
				<input type="hidden" name="sel_filepath" value="<%=sel_filepath%>">
				<input type="hidden" name="default_businessclass_id" value="<%=default_businessclass_id%>">
				<input type="hidden" name="default_eform_id" value="<%=default_eform_id%>">
				<input type="hidden" name="default_jawe_id" value="<%=default_jawe_id%>">				
				<input type="hidden" name="default_report_id" value="<%=default_report_id%>">
				<input type="hidden" name="default_filepath" value="<%=default_filepath%>">
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
									文件
								</td>
								<td height='20' class="headercolor">
									表单
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('jawelist')">
									流程
								</td>
								<td height='20' align="center" style="cursor: hand;"
									onclick="jumpPage('reportlist')">
									报表
								</td>
							</tr>
						</table>
					</LEGEND>
					<hr width="100%">
					<table width="100%" border="0" cellpadding="1" cellspacing="1"
						class="thin">
						<tr>
							<td class="detailtitle" width="20%" align=right>
								表单ID：
							</td>
							<td class="detailcontent" width="90%">
								<input type="text" name="sel_name" value="<%=sel_name%>"
									style="width:70%" maxlength="70">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="10%" align=right>
								创建人：
							</td>
							<td class="detailcontent" width="90%">
								<input type="text" name="creator_person"
									value="<%=creator_person%>" style="width:70%" maxlength="70">
								<input type="button" value="选择" class="input"
									onclick="operuserlist();">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="10%" align=right>
								创建日期：
							</td>
							<td class="detailcontent" width="90%">
								开始日期：
								<input type="text" name="begin_data" value="<%=begin_data%>"
									style="width:26%" onClick="showdate(this)" readonly="readonly">
								结束日期：
								<input type="text" name="end_data" value="<%=end_data%>"
									style="width:26%" onClick="showdate(this)" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td class="detailtitle" width="15%" align=right>
								排序方式：
							</td>
							<td class="detailcontent" width="30%" align="center">
								<table width="100%">
									<tr>
										<td align="left" style="border: 0px;">
											<input type="radio" name="sort" value="person">
											按创建人
											<input type="radio" name="sort" value="data"
												checked="checked">
											按创建日期
										</td>
										<td align="right" style="border: 0px;">
											<input name="Submit4" type="submit" class="input" value="查询">
											<input name="Submit22" type="button" class="input" value="重置"
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
										<td height='20' class="tablecells" align=center colspan=10>
											<b>表单列表</b>
										</td>
									</tr>
									<pg:listdata
										dataInfo="com.chinacreator.eppissue.menuissue.expmenu.menu.EformList"
										keyName="selectlist" />
									<!--分页显示开始,分页标签初始化-->
									<pg:pager maxPageItems="10" form="eformlistform"
										scope="request" data="selectlist" isList="false"
										commitevent="0">


										<tr class="labeltable_middle_td">
											<!--设置分页表头-->
											<td class="headercolor" width="6%">
												<P align="left">
													<INPUT type="checkbox" name="checkBoxAll"
														onClick="checkAll('checkBoxAll','checkBoxOne')" value="on">
												</P>
											</td>
											<td height='20' class="headercolor">
												表单ID
											</td>
											<td height='20' class="headercolor">
												名称
											</td>
											<td height='20' class="headercolor">
												创建日期
											</td>
											<td height='20' class="headercolor">
												创建人
											</td>
											<%--
											<td height='20' class="headercolor">
												描述
											</td>
											<td height='20' class="headercolor">
												发布状态
											</td>
											--%>
											<td height='20' class="headercolor">
												操作
											</td>
										</tr>
										<!--检测当前页面是否有记录-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													暂时没有表单
												</td>
											</tr>
										</pg:notify>

										<!--list标签循环输出每条记录-->
										<pg:list>

											<tr class="labeltable_middle_tr_01"
												onMouseOver="this.className='mousestyle1'"
												onMouseOut="this.className= 'mousestyle2'"
												onClick="getApplyInfo(this,'<%=control.getCurrentSystemID() %>')"
												id="app_<%=control.getCurrentSystemID() %>"
												enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="checkbox" name="checkBoxOne"
															onClick="checkOne('checkBoxAll','checkBoxOne')"
															value='<pg:cell colName="expmenu_id" defaultValue=""/>'>
													</P>
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_id" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_name" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_creator_data" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_creator_person" defaultValue="" />
												</td>
												<%--
												<td height='20' align=left class="tablecells">
													<pg:cell colName="expmenu_remark" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:equal colName="expmenu_state" expressionValue="0">未发布</pg:equal>
													<pg:equal colName="expmenu_state" expressionValue="1">已发布</pg:equal>
													<pg:equal colName="expmenu_state" expressionValue="2">重新发布</pg:equal>
												</td>
												--%>
												<td height='20' align=left class="tablecells">
													<input type="button" value="查看" class="input"
														onclick="showForm(this,'<pg:cell colName="expmenu_id" defaultValue=""/>')">
												</td>
										</pg:list>
										<tr height="30" class="labeltable_middle_tr_01">
											<td colspan=100 align='right'>
												共
												<pg:rowcount />
												条记录
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
											<b>已选表单</b>
										</td>
									</tr>
									<tr>
										<td>
											<select name="select" multiple style="width:100" size="20">
												<pg:list requestKey="sel_eform_id_list" needClear="false">
													<option value="<pg:cell colName="expmenu_id"/>">
														<pg:cell colName="expmenu_name" defaultValue="" />
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
									<input name="Submit" type="button" class="input" value="上一步"
										onClick="jumpPage('back')">
									<input name="Submit" type="button" class="input" value="保存配置"
										onClick="saveconfig()">
									<input name="Submit" type="button" class="input" value="重置" onClick="resetclick()">
									<input name="Submit" type="button" class="input" value="返回" onClick="window.close();">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
<script type="text/javascript">
<!--	
		var r = document.eformlistform.sort;
		for(var i = 0; i < r.length; i++){			
			if(r[i].value == "<%=sort%>"){
					r[i].checked = true;
					break;
				}
			}
	
//-->
</script>

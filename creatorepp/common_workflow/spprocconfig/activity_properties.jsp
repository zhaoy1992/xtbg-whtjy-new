<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.workflow.shark.spprocconfig.SPProcessConfigManager"%>
<%
	String rootPath = request.getContextPath();
	String module_id = request.getParameter("module_id");
	if(module_id == null){
		module_id = "";
	}
	String process_all_name = request.getParameter("process_all_name");
	if(process_all_name == null){
		process_all_name = "";
	}
	String activityId = request.getParameter("activityId");
	if(activityId == null){
		activityId = "";
	}
	String activityName = request.getParameter("activityName");
	if(activityName == null){
		activityName = "";
	}
	String paramForm = request.getParameter("activityForm");
	if(paramForm == null){
		paramForm = "";
	}
	String activityForm = "";//表单
	String activityAlias = "";//别名
	String activityLimit = "";//期限
	String activityParticipant = "";//参与者
	String remark = "";//备注
	String isJump = "";//是否跳过本环节
	
	SPProcessConfigManager sProcessConfigManager = new SPProcessConfigManager();
	activityForm = sProcessConfigManager.getActivityForm(module_id,process_all_name,activityId);
	if(activityForm == null){
		activityForm = "";
	}
	if("".equals(activityForm)){
		activityForm = paramForm;
	}
	activityAlias = sProcessConfigManager.getActivityAlias(module_id,process_all_name,activityId);
	if(activityAlias == null){
		activityAlias = "";
	}
	activityLimit = sProcessConfigManager.getActivityLimit(module_id,process_all_name,activityId);
	if(activityLimit == null){
		activityLimit = "";
	}
	activityParticipant = sProcessConfigManager.getActivityParticipant(module_id,process_all_name,activityId);
	if(activityParticipant == null){
		activityParticipant = "";
	}
	
	remark = sProcessConfigManager.getActivityProperty(module_id,process_all_name,activityId,"ACTIVITY_REMARK");
	if(remark == null){
		remark = "";
	}
	isJump = sProcessConfigManager.getActivityProperty(module_id,process_all_name,activityId,"ACTIVITY_ISJUMP");
	if(isJump == null){
		isJump = "";
	}
%>
<html>
	<head>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>活动配置页</title>

		<link href="style.css" rel="stylesheet" type="text/css" />

	 	<!-- dwr begin -->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/spProcessConfigManager.js'></script>
		<!-- dwr end -->
		<script language="javascript">
		var module_id = '<%=module_id%>';
		var process_all_name = '<%=process_all_name%>';
		
		function getActPARTICIPANT(){
			var data = document.getElementById("ACTIVITY_PARTICIPANT").value;
			var returnVal = window.showModalDialog("activity_participant.jsp?data="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:yes; resizable:yes;dialogWidth:450px; dialogHeight:360px");
			if(returnVal!=undefined){
				document.getElementById("ACTIVITY_PARTICIPANT").value = returnVal;
			}
		}
		
		function getActFORM(){
			var data = document.getElementById("ACTIVITY_FORM").value;
			var returnVal = window.showModalDialog("selEform.jsp?activity_form="+data,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:no; resizable:yes;dialogWidth:420px; dialogHeight:350px");
			if(returnVal!=undefined){
			    document.getElementById("ACTIVITY_FORM").value = returnVal;
			}
		}
		
		function changeColor(id){
			document.getElementById('baseProp_div').color='';
			document.getElementById('extendProp_div').color='';
			document.getElementById(id).color='#000000';
		}
		function changePage(id){
			document.getElementById('baseProp_div').style.display='none';
			document.getElementById('extendProp_div').style.display='none';
			document.getElementById(id).style.display='';
		}
		
		function uf_ok(){
			
			var activityId = document.getElementById("activityId").value;
			var activityForm = document.getElementById("ACTIVITY_FORM").value;
			var activityAlias = document.getElementById("ACTIVITY_ALIAS").value;
			var activityLimit = document.getElementById("ACTIVITY_LIMIT").value;
			var activityParticipant = document.getElementById("ACTIVITY_PARTICIPANT").value;
			var remark = document.getElementById("ACTIVITY_REMARK").value;//备注
			var isJump = document.getElementById("ACTIVITY_ISJUMP").checked;//是否跳过本环节
			if(isJump){
				isJump = "Y";
			}else{
				isJump = "N";
			}
			var jsonArray=["{moduleId:'",module_id,
						"',processName:'",process_all_name,
						"',activityId:'",activityId,
						"',activityProperties:[",
						"{propertyName:'ACTIVITY_FORM',propertyValue:'",activityForm,"'},",
						"{propertyName:'ACTIVITY_ALIAS',propertyValue:'",activityAlias,"'},",
						"{propertyName:'ACTIVITY_LIMIT',propertyValue:'",activityLimit,"'},",
						"{propertyName:'ACTIVITY_PARTICIPANT',propertyValue:'",activityParticipant,"'},",
						"{propertyName:'ACTIVITY_REMARK',propertyValue:'",remark,"'},",
						"{propertyName:'ACTIVITY_ISJUMP',propertyValue:'",isJump,"'}",
						"]}"
						];
			spProcessConfigManager.saveProcessActConfig(jsonArray.join(""),function(data){
				if(data){
					alert('保存成功！');
					window.returnValue="reload";
					window.close();
				}else{
					alert('保存失败！');
				}
			});
		}
		
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin">
		<div id="tabs2">
			<ul>
				<li>
					<a href="#"
						onClick="changePage('baseProp_div');changeColor('org_font_color');"><span><font
							id="org_font_color" color="#000000" size="2">基本配置</font>
					</span>
					</a>
				</li>

				<li>
					<a href="#"
						onClick="changePage('extendProp_div');changeColor('group_font_color');"><span><font
							id="group_font_color" color="" size="2">扩展配置</font>
					</span>
					</a>
				</li>

			</ul>
		</div>
		<div id="baseProp_div" align="center" style="display:''">
			<br />
			<fieldset style="width: 95%;">
				<LEGEND align=center>
					<FONT size="2">基本配置</FONT>
				</LEGEND>
				<table width="100%" height="35" border="0" align="left"
					cellpadding="0" cellspacing="1" class="table">
					<input type="hidden" name="activityId" value="<%=activityId %>">
					<tr style="height: 25px">
						<td nowrap>
							<span>活动名称</span>
						</td>
						<td>
							<input id="activityName" name="activityName" type="text"
								value="<%=activityName %>" style="width: 230px; border: 0px;"
								readonly="true" />
						</td>
						<td nowrap>
							<span>活动别名</span>
						</td>
						<td>
							<input id="ACTIVITY_ALIAS" name="ACTIVITY_ALIAS" type="text"
								value="<%=activityAlias %>" style="width: 250px; border: 0px;" />
						</td>
					</tr>
					<tr style="height: 25px">
						<td nowrap>
							<span>活动时限</span>
						</td>
						<td>
							<input id="ACTIVITY_LIMIT" name="ACTIVITY_LIMIT" type="text"
								value="<%=activityLimit %>" style="width: 230px; border: 0px;"/>
						</td>
						<td colspan="2">
							<input id="ACTIVITY_ISJUMP" name="ACTIVITY_ISJUMP" type="checkbox" <%if("Y".equals(isJump)){%>checked<%} %>>是否跳过本环节
						</td>
					</tr>
					<tr style="height: 25px">
						<td nowrap>
							<span>活动表单</span>
						</td>
						<td colspan="3">
							<input id="ACTIVITY_FORM" name="ACTIVITY_FORM" type="text"
								value="<%=activityForm %>" style="width: 85%; border: 0px;"
								readonly="true" />
							<input type="button" value="选择" onclick="getActFORM();">
						</td>
					</tr>
					<tr style="height: 25px">
						<td nowrap>
							<span>活动参与者</span>
						</td>
						<td colspan="3">
							<input id="ACTIVITY_PARTICIPANT" name="ACTIVITY_PARTICIPANT" type="text"
								value="" style="width: 85%; border: 0px;" readonly="true" />
							<input type="button" value="选择" onclick="getActPARTICIPANT();">
						</td>
					</tr>
					<tr>
						<td nowrap>
							<span>备注</span>
						</td>
						<td colspan="3">
							<textarea id="ACTIVITY_REMARK" name="ACTIVITY_REMARK" rows="" cols="10" style="width:100%;height:200"><%=remark %></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div align="center">
								<input name="Submit" type="button" class="input" value="保存" onClick="uf_ok()">&nbsp;&nbsp;
								<input name="cancel" type="button" class="input" value="取消"	onClick="window.close()">
							</div>
						</td>
					</tr>
				</table>
				<br />
			</fieldset>
		</div>
		
		<div id="extendProp_div" align="center" style="display:none">
			<br />
			<fieldset style="width: 95%;">
				<LEGEND align=center>
					<FONT size="2">扩展配置</FONT>
				</LEGEND>
				<table width="100%" height="100%" border="0" align="left"
					cellpadding="0" cellspacing="1" class="table">
					<tr>
						<td width="100%" class="detailcontent">
							<iframe width="100%" height="400" border="0" scrolling="no" src="<%=request.getContextPath() %>/eformsys/jxc/dj/20091118134341671956.jsp?ACTION_ID=<%=activityId %>&activityName=<%=activityName %>"></iframe>
						</td>
					</tr>
				</table>
				<br />
			</fieldset>
		</div>
	</body>
	<script type="text/javascript">
		var a = '<%=activityParticipant %>';
		document.getElementById("ACTIVITY_PARTICIPANT").value = a;
	</script>
</html>

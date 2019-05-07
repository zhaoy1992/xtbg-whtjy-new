<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.ProcessConfigManager"%>
<%@ page import="com.chinacreator.workflow.shark.SharkEngine"%>
<%@ page import="org.enhydra.shark.SharkUtilities"%>
<%@ page import="org.enhydra.shark.xpdl.elements.WorkflowProcess"%>
<%@ page import="org.enhydra.shark.xpdl.elements.ProcessHeader"%>

<% 
//add by minghua.guo[2011-6-1]����������
String type = request.getParameter("type");
String title = "��������Χ����";
if("subflow".equals(type)){
	title = "��������������Χ����";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title><%=title %></title>
    
 	<!-- dwr begin -->
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/processConfigManager.js'></script>
	<!-- dwr end -->
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/css/ext-all.css" />
 	<script type="text/javascript" src="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/ext-base.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/ext-all.js"></script>
    <link rel="stylesheet" type="text/css" href="examples.css" />
	
	<script type="text/javascript" src="ext.js" language="javascript"></script>
    
	<%
		String name = "";
		String module_id = "";
		String process_name = "";
		String process_package = "";
		String process_version = "";
		String activityProperties4JSON = "{}";
		String processMgrName = "";
		String process_id = "";
		String process_limit = "";
		String duration_unit = "";
	%>
	<%
		//�õ�ģ��id������
		if(request.getParameter("id")!=null){
			module_id = request.getParameter("id");
		}
		if(request.getParameter("processMgrName")!=null){
			processMgrName = request.getParameter("processMgrName");
			processMgrName = new String(processMgrName.getBytes("8859_1"), "UTF-8");
		}		
		if(request.getParameter("name")!=null){
			name = request.getParameter("name");
		}
		
		
		
		if(processMgrName!=null&&!"".equals(processMgrName)){
			//�õ���ǰ�汾
			SharkEngine shark = SharkEngine.getInstance();
			shark.loginWorkflowServer("admin","");
	    	processMgrName = shark.getCurVerMgrNameByMgrName(processMgrName);
	    	//add by minghua.guo[2011-05-11] �����쳣
	    	if(processMgrName == null || "".equals(processMgrName)){
	    		out.print("<p align=center><font color=red>�˵��󶨵������Ѳ����ڣ����޸Ĳ˵����°�����</font></p>");
	    		return;
	    	}
			String[] mgrNames = processMgrName.split("#");
			process_package = mgrNames[0];
			process_version = mgrNames[1];
			process_name = mgrNames[2];
			WorkflowProcess wp = SharkUtilities.getworkflowprocess(process_package, process_version, process_name);
			ProcessHeader ph = wp.getProcessHeader();
     		duration_unit = ph.getDurationUnit();
			process_limit = ph.getLimit();
		}
		if(module_id!=null&&!"".equals(module_id)){
			ProcessConfigManager processConfigManager = new ProcessConfigManager();
			activityProperties4JSON = processConfigManager.getProcessConfig4JSON(module_id,processMgrName);
			process_id = processConfigManager.getProcessID(processMgrName);
		}
		
	%>
	
    <script language="javascript">
    	var pro_version;
    	var pro_name;
    	var pro_id;
		pro_name = "<%=process_package%>";
		pro_version = "<%=process_version%>";
		pro_id = "<%=process_name%>";
    	var processConfig4JSON = <%=activityProperties4JSON%>;

		var process_config_id = ((typeof processConfig4JSON.id)=='undefined')?"":processConfig4JSON.id;
		var module_id = '<%=module_id%>';
		var module_name = '<%=name %>';
		var process_all_name = '<%=processMgrName%>';	
		
		function showHistoryFlow(id,name){
			var historyFlow = window.showModalDialog("historyFlow.jsp?id="+id,"", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:yes; resizable:yes;dialogWidth:500px; dialogHeight:400px");
			if(historyFlow!='-1'&&historyFlow!=''&&historyFlow!=undefined){
				window.navigate('shark_content.jsp?id='+id+'&name='+name+'&flow_id='+historyFlow);
			}
		}
		//�ָ�
		function restore(){
			grid.getStore().loadData(processConfig4JSON);
		}
		function $(id){
			return document.getElementById(id);
		}
		//������������
		function loadProcessProperties(data4JSON){
			if(typeof data4JSON!='undefined'){
				$("process_limit").value = ((typeof data4JSON.id)=='undefined')?"":data4JSON.processLimit;
				if(typeof data4JSON.durationUnit!='undefined'){
					var durationUnitObject = $("duration_unit");
					for(var i=0;i<durationUnitObject.options.length;i++){
						if(durationUnitObject.options[i].value==data4JSON.durationUnit){
							durationUnitObject.options[i].selected = true;
							break;
						}
					}
				}
				process_config_id = ((typeof data4JSON.id)=='undefined')?"":data4JSON.id;
				//grid.getStore().loadData(data4JSON);
			}
		}
		window.onload = (function(){
			var tabHeight = document.body.style.pixelHeight;
			if(tabHeight<450){
				tabHeight = 450;
			} 
			var tabs = new Ext.TabPanel({
				renderTo: 'tabPanel',
				height:tabHeight,
				autoScroll:true,
				autoWidth:true,
				activeTab: 0,
				frame:true, 
				//defaults:{autoHeight: true},
				items:[
					{contentEl:'script1', title: '��������'}
					,{contentEl:'markup1', title: '��չ����'}
				]
			});
			//������������
			loadProcessProperties(processConfig4JSON);
		});
	</script>
	

</head>
<body style="height:100%;width:100%;margin:0px;padding:0px;">
    <div id="tabPanel" style="LEFT: 0px; POSITION: absolute; TOP: 0px;width:100%;height:100%">
      <div id="script1" style="width:680px">
      	<div id="processPropertyDiv" style="width:100%;margin:10px;height:110px;">
      		<table border="0px" style="width:100%;cellspacing:0;cellpadding:0" >
      			<tr style="height:25px">
	      			<td><span>�����ţ�</span></td>
	      			<td><input id="module_id" name="module_id" type="text" value="<%=module_id%>"  style="width: 230px" readonly="true"/></td>
	      			<td><span>�������ƣ�</span></td>
					<td><input id="module_name" name="module_name" type="text" value="<%=name%>"  style="width: 250px" readonly="true"/></td>
				</tr>
				<tr style="height:25px">
      				<td><span>���̱�ţ�</span></td>
					<td><input id="process_id" name="process_id" type="text" value="<%=process_id%>" style="width: 230px;" readonly="true"/></td>
					<td><span>���̰汾��</span></td>
					<td><input id="process_version" name="process_version" type="text" value="<%=process_version%>" style="width: 250px;" readonly="true"/></td>
				</tr>	
				<tr style="height:25px">
					<td><span>���̶���ID��</span></td>
					<td><input id="process_name" name="process_name" type="text" value="<%=process_name%>" style="width: 230px;" readonly="true"/></td>
					<td><span>���̰�ID��</span></td>
					<td><input id="process_package" name="process_package" type="text" value="<%=process_package%>" style="width: 250px;" readonly="true"/></td>
				</tr>
				<tr style="height:25px">
					<td><span>�������ޣ�</span></td>
					<td><input id="process_limit" name="process_limit" type="text" value="<%=process_limit%>" style="width: 230px;"/></td>
					<td><span>���޵�λ��</span></td>
					<td>
						<select id="duration_unit" name="duration_unit" style="width: 255px;">
							<option value="Y" <%=("Y".equals(duration_unit)?"selected":"")%>>��</option>
							<option value="M" <%=("M".equals(duration_unit)?"selected":"")%>>��</option>
							<option value="D" <%=("D".equals(duration_unit)?"selected":"")%>>��</option>
							<option value="h" <%=("h".equals(duration_unit)?"selected":"")%>>Сʱ</option>
							<option value="m" <%=("m".equals(duration_unit)?"selected":"")%>>����</option>
							<option value="s" <%=("s".equals(duration_unit)?"selected":"")%>>��</option>
						</select>
					</td>
				</tr>
			</table>
			</div>
			<!--
			<input name="button1" type="button" value="�鿴��ʷ����" style="LEFT: 571px; POSITION: absolute; TOP: 23px; width: 85px;" onclick="javascript:showHistoryFlow('<%=module_id%>','<%=name%>');"/>-->
			<div id="helpDiv" style="width:100%;text-align:right;margin-right:12px"><a href="javascript:showHelp()"><img src="images/help.gif"/>���������˵��</a></div>			
			<div id="editgrid" style="margin-left:12px"></div>
			
			<div id="buttomDiv" style="text-align:center;width:100%;margin:10px;height:25px;">
				<input name="saveButton" type="button" value="������" onclick="savaProcessData(process_config_id,'<%=module_id%>','<%=processMgrName%>');"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="restoreButton" type="button" value="�֡���"  onclick="restore();"/>
            	<% 
            	if("subflow".equals(type)){
            	%>
            	&nbsp;&nbsp;&nbsp;&nbsp;
            	<input name="closeButton" type="button" value="�ء���"  onclick="window.close();"/>
            	<%} %>
            </div>
            <div id="helpWin" class="x-hidden">
            	<p style="margin:9px">
            	<p>
            	<b>�������</b>�����������ַ�
            	</p><p>
            	<b>�����ߣ�</b>������Ԫ�񣬴ӵ�������֯��������ѡ��
            	</p><p>
            	<b>���ޣ�</b>Ĭ�ϵ�λΪ�������޵�λ������λΪ������ʱ�����ޱ���Ϊ��λ���ڵ������������������޺�����ϵ�λ����������D��d��ʾ��Сʱ��H��h��ʾ�����磺
            	<br/>����5�������տ���д�ɣ�5D��5d�������̵�λΪ������ʱ����ֱ������5
            	<br/>����2.5��Сʱ����д�ɣ�2.5H��2.5h�������̵�λΪСʱʱ������ֱ������2.5
            	</p><p>
            	<b>����</b>������Ԫ���ڵ����Ĵ����������ѡ���</p>
            	</p>
            </div>
      </div>
      <div id="markup1" class="x-hide-display">
      		<div id="editgrid-extend" style="margin-left:0px"></div>
      		<div id="editform" style="margin-left:0px"></div>
      </div>
</div>
<script type="text/javascript">
	var helpWindow=new Ext.Window({
           contentEl:"helpWin",//������ʾ��htmlԪ�أ�Ҳ����дΪel:"win"
           width:450,
           height:250,
           closeAction:'hide',
           title:"���������˵��",
           buttons:[{text:"�ر�",handler:function(){helpWindow.hide();}}],//footer��
   		   buttonAlign:"center"//footer����ť����λ��,�������м�
           
        });
    function showHelp(){
    	helpWindow.show();
    }
</script>
<script type="text/javascript" src="editgrid.js" language="javascript"></script>
<script type="text/javascript" src="editform.js" language="javascript"></script>
</body>
</html>
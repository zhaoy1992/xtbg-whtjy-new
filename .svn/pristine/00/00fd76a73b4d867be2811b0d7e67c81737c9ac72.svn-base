<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.epp.reportmanage.service.ReportManage" %>
<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>
<%@page import="com.chinacreator.epp.reportmanage.ReportConfig"%>
<%@page import="com.chinacreator.ireport.rmi.ReportDatasourceBean"%>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<html>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	AccessControl control = AccessControl.getInstance();
 	control.checkAccess(request,response);
 	//添加创建者
 	String userName= control.getUserName();
 	request.getSession().setAttribute("creator",userName);
 	
 	String ec_id = request.getParameter("ec_id");
 	String classname = "";
 	String methodname = "";
 	Tb_report rep = null;
 	boolean isEdit = (request.getParameter("isEdit")!=null&&request.getParameter("isEdit").equals("true"))?true:false;
 	String repId = null;
 	if(isEdit)
 	{
 		repId = request.getParameter("repId");
 		ReportManage rm = ReportBeanFactory.getReportManager();
 		rep = rm.getReport(repId);
 		
 		ReportDatasourceBean reportDataSource = rm.findReportDatasourceBean(repId);
 		if(reportDataSource!=null){
 			classname = reportDataSource.getClass_name()==null?"":reportDataSource.getClass_name();
 			methodname = reportDataSource.getMethod_name()==null?"":reportDataSource.getMethod_name();
 		}
 	}
%>
<head>
	<title>请输入报表名</title>

	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css"/>
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css"/>
	<script src="report.js"></script>
	<script type="text/javascript" src="prototype-1.4.0.js"></script>
	<script type="text/javascript">
		function testmethod()
		{
		var classname = document.getElementById('classnameid').value;
		var methodname = document.getElementById("methodnameid").value;
		
		if(classname == ''){
			alert('类名必须填写');
			return;
		}
		if(methodname == ''){
			alert('方法名必须填写');
			return;
		}
		
		var url = '<%=request.getContextPath()%>/report/doajax.jsp';
		var pars = 'businesscode=testmethod&classname='+classname+'&methodname='+methodname+'&nowtime=' + new Date().getTime();
		var myAjax = new Ajax.Request(
		url,
		{
		method: 'get',
		parameters: pars,
		onComplete: showResponse
		});
		}
		function showResponse(originalRequest)
		{
		//put returned XML in the textarea
		var restr=originalRequest.responseText;
		if(restr.replace(/\s+/g,"")=="success"){
		alert('测试成功');
		}else{
		alert(restr);
		}
		}
		
		</script>
		
		
	<script>
		var _val ='1';

		function creatornew(t){
		var currentVersion = document.getElementById('currentVersion').value;
			if(t.checked){
				var i = parseInt(currentVersion);
				if(isNaN(i)){
					document.getElementById('currentVersion').value = 1;
				}else{
					document.getElementById('currentVersion').value = i+1;
				}
			}else{
			var i = parseInt(currentVersion);
				if(isNaN(i)){
					//donothing
				}else{
					document.getElementById('currentVersion').value = i-1;
				}
			}
		}

		function hideServerFileSel()
		{
			//不能从服务器上传文件的选项
			//document.all.fs2.disabled=true;
		}

		function showServerFileSel()
		{
			//显示从服务器上传文件的选项
			//document.all.fs2.disabled=false;
		}

		function val_input(input)
	  	{
	  		 //验证输入的是否为合法字符
	  		 if(input==null||input=="")
			{
				alert("您没有输入报表名称！");
				return false;
			}
		     //var patten=/^[a-zA-Z0-9]+$/;
		     var patten=/^([a-zA-Z0-9]|[\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
		  	 if(patten.test(input))
		  	 {
		  		 return true;
		  	 }else
		  	 {
		  	 	 alert("只能输入字符和数字！");
		   	     return false;
		     }
	  	}

	  	function val_obj(input)
	  	{
	  		 //验证输入的是否为合法字符
	  		 if(input.value==null||input.value=="")
			{
				alert("您没有输入"+input.desc+"！");
				input.focus();
				return false;
			}
		     //var patten=/^[a-zA-Z0-9]+$/;
		     var patten=/^([a-zA-Z0-9]|[\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
		  	 if(patten.test(input.value))
		  	 {
		  		 return true;
		  	 }else
		  	 {
		  	 	 alert(input.desc+"只能输入字符和数字！");
		  	 	 focus();
		   	     return false;
		     }
	  	}

	  	//验证应用中是否有同名的报表
	  	function val_process_name(_name,_ver)
	  	{
	  		<%
	  			if(isEdit){
	  		%>
	  			var isCreateNew = (document.all.isCreateNew.checked)?true:false;
	  			if(isCreateNew)
	  			{
	  				//如果要创建新版本，就要进行同名验证
	  			}
	  			else
	  			{
	  				//否则不验证
	  				return true;
	  			}
	  		<%}%>
			var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=validatereportname&name="+_name+"&ver="+_ver);
			if(retX=="false")
			{
				alert("此报表已经存在，请使用其他的报表名或版本！");
				return false;
			}
			return true;
	  	}

	  	function befo_submit()
	  	{
		  	
	  		if(document.getElementById("myspan").innerHTML != "") {
				alert("报表名称不能重复");return;
			}
	  		var _name=document.getElementsByName("repName")[0].value;
	  		var _ver=document.getElementsByName("repVer")[0].value;
	  		var _desc=escape(document.getElementsByName("repDesc")[0].value);
	  		document.all.repDesc.value = _desc;
	  		if(_ver==null||_ver==undefined)
	  		{
	  			_ver="";
	  		}
	  		if(_desc==null||_desc==undefined)
	  		{
	  			_desc="";
	  		}

	  		if(document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_GROU0P%>||document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>||document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_JASPERREPORT%>)
	  		{
	  			//如果是报表组，不能从服务器上传
	  			hideServerFileSel();
	  		}
	  		else
	  		{
	  			showServerFileSel();
	  		}

	  		if(document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>||document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
	  		{
	  			//如果是参数报表
	  			document.all.f2.style.display="block";
	  			//document.all.sb.style.display="inline";
	  			//document.all.server_file2.style.display="inline";
	  			
	  			if(document.all.repSType.value != <%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>){
	  				document.all.classname.style.display="none";
	  				document.all.methodname.style.display="none";
	  				document.all.testme.style.display="none";
	  			}
	  			
	  		}
	  		else
	  		{
	  			document.all.f2.style.display="none";
	  			//document.all.server_file2.style.display="none";
	  			
	  			if(document.all.repSType.value == <%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>){
	  				document.all.classname.style.display="block";
	  				document.all.methodname.style.display="block";
	  				document.all.testme.style.display="block";
	  			}
	  		}

	  		if(val_obj(document.all.repName)&&val_obj(document.all.repVer)&&val_process_name(_name,_ver))
	  		{
	  			/*if(_desc!="")
	  			{
		  			//如果报表描述不为空，则验证
	  				if(!val_obj(document.all.repDesc))
	  				{
		  				return false;
	  				}
	  			}*/
	  			//如果通过验证，则提交
	  			var ec_id = "<%=ec_id%>"
	  			//newReport(ec_id,_name,_ver,_desc);
	  			document.all.escapeRepDesc.value=escape(document.all.repDesc.value);
	  			<%
					if(isEdit){
				%>
					document.all.reportForm.action="report_new2.jsp?ec_id=<%=ec_id %>&repId=<%=repId%>";
				<%}else{%>
					document.all.reportForm.action="report_new2.jsp?ec_id=<%=ec_id %>";
				<%}%>
	  			//document.all.reportForm.submit();
	  			
	  			
	  			if(document.all.repSType.value==<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT%>){
	  					document.all.new1.style.display="none";
	  					document.all.new3.style.display="block";
	  			}else {
	  			
	  			document.all.new1.style.display="none";
	  			document.all.new2.style.display="block";
	  			}
	  		}
	  		else
	  		{
	  			return false;
	  		}
	  	}

		function setFileSource(val)
		{
			if(val=='1')
			{
				_val='1';
				//document.all.serverfile.style.display="none";
				document.all.lfile.style.display="block";
				//document.all.localfile.style.display="block";
				document.all.reportForm.encoding="multipart/form-data";
				document.all.reportForm.method="post";
				//document.all.reportForm.target="uploadframe";
			}
			else
			{
				_val='2';
				//document.all.serverfile.style.display="block";
				document.all.lfile.style.display="none";
				document.all.reportForm.encoding="application/x-www-form-urlencoded";
				document.all.reportForm.method="get";
				//document.all.reportForm.target="uploadframe";
			}
		}

		//上一步
		function new1()
		{
			document.all.new1.style.display="block";
			document.all.new2.style.display="none";
			document.all.new3.style.display="none";
		}

		function openWin1()
		{
		     var retx = window.showModalDialog("file_list_main.jsp");
		     if(retx == undefined){
		     retx = "";
		     }
		     document.all.server_file.value=retx;
		}
		function openWin2()
		{
		     var retx = window.showModalDialog("file_list_main.jsp");
		     if(retx == undefined){
		     retx = "";
		     }
		     //document.all.server_file2.value=retx;
		}

		//保存
		function save_submit()
		{
			setFileSource(_val);
			var ec_id="<%=ec_id%>";
			var _name=document.all.repName.value;
			var _ver=document.all.repVer.value;
			var _desc=escape(document.all.repDesc.value);
			var _repSType=document.all.repSType.value;

			//如果是参数报表或者参数报表组
			var submit_url = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=addreport&";
			document.all.reportForm.action=submit_url;
			document.all.divProcessing.style.display="block";
			<%
				if(isEdit){
					//String isCreateNew = (request.getParameter("isCreateNew")!=null)?"true":"false";
			%>
				submit_url = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=updatereport&";
				document.all.reportForm.action=submit_url;

				var fileType__ = document.all.f.value;
				if(!IsSpace(document.all.f2))
				{
					var fileType2__ = document.all.f2.value;
				}

				//修改的时候是否创建新版本
				var isCreateNew = (document.all.isCreateNew.checked)?"true":"false";
				if(_val=='2')
				{
					var server_file = document.all.server_file.value;
					submit_url = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=serverfile&isEdit=true&repId=<%=repId%>&isCreateNew="+isCreateNew+"&server_file="+server_file+"&repSType="+_repSType;
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>||_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{
						//参数报表
						//var server_file2 = document.all.server_file2.value;
						//submit_url += "&server_file2="+server_file2;
					}
					window.location.href = submit_url;
				}
				else
				{
					document.all.reportForm.action = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=localfile&isEdit=true&repId=<%=repId%>&isCreateNew="+isCreateNew+"&repSType="+_repSType;
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ%>||_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>)
					{
						if(!IsSpace(fileType__)&&fileType__==-1)
						{
							//非报表组只能上传.raq文件
							alert("只能上传.raq类型的文件！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{
						//报表组可能要上传.rpg的报表组和.raq的参数报表
						if(fileType__.lastIndexOf(".raq")==-1&&fileType__.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}

					if(_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P%>){
						//报表组可能要上传.rpg的报表组
						if(fileType__.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}

					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>||_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{
						if(IsSpace(fileType__)&&IsSpace(fileType2__)&&<%=isEdit%>)
						{
							//修改的时候可以不上次文件
						}
						else
						{
							if((IsSpace(fileType__)||IsSpace(fileType2__))||(IsSpace(fileType__)&&IsSpace(fileType2__)))
							{
								alert("请同时上传2个文件！或者不上传文件");
								document.all.divProcessing.style.display="none";
								return false;
							}
							//参数报表要同时上传两个文件
							if(fileType__.lastIndexOf(".raq")==-1&&fileType__.lastIndexOf(".rpg")==-1&&fileType2__.lastIndexOf(".raq")==-1&&fileType2__.lastIndexOf(".rpg")==-1)
							{
								alert("文件类型错误！！");
								document.all.divProcessing.style.display="none";
								return false;
							}
						}
					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_JASPERREPORT%>)
					{

						if(!IsSpace(fileType__)&&fileType__.lastIndexOf(".jrxml")==-1)
						{
							alert("只能上传.jrxml类型的文件！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					
					if(_repSType == <%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>){
					
						var classname = document.getElementById('classnameid').value;
						var methodname = document.getElementById("methodnameid").value;
						if(classname.replace(/\s+/g,"")==''){
							alert('类名必须填写');
							return;
						}
						
						if(methodname.replace(/\s+/g,"")==''){
							alert('方法名必须填写');
							return;
						}
						var currentUrl = document.all.reportForm.action;
						currentUrl += "&classname="+classname;
						currentUrl += "&methodname="+methodname;
						
						document.all.reportForm.action = currentUrl;
					}
					
					document.all.reportForm.submit();
				}
			<%}else{%>
				if(_val=='2')
				{
					var server_file = document.all.server_file.value;
					submit_url = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=serverfile&repSType="+_repSType+"&server_file="+server_file;
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>||_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{
						//参数报表
						//var server_file2 = document.all.server_file2.value;
						//submit_url += "&server_file2="+server_file2;
					}
					
					window.location.href = submit_url;
				}
				else
				{
					//新增的时候一定要上传报表文件
				    var fileType__ = document.all.f.value;
				    var fileType2__ = document.all.f2.value;
				    if(IsSpace(fileType__))
				    {
				        alert("请上传报表文件！");
				        document.all.divProcessing.style.display="none";
				        return false;
				    }
					document.all.reportForm.action = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=localfile&repSType="+_repSType;
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ%>||_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>)
					{
						if(fileType__.lastIndexOf(".raq")==-1)
						{
							//非报表组只能上传.raq文件
							alert("只能上传.raq类型的文件！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>||_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{
						if(IsSpace(fileType__)||IsSpace(fileType2__))
						{
							alert("请同时上传2个文件！");
							document.all.divProcessing.style.display="none";
							return false;
						}
						//参数报表要同时上传两个文件
						if(fileType__.lastIndexOf(".raq")==-1&&fileType__.lastIndexOf(".rpg")==-1&&fileType2__.lastIndexOf(".raq")==-1&&fileType2__.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>)
					{

						//报表组可能要上传.rpg的报表组和.raq的参数报表
						if(fileType__.lastIndexOf(".raq")==-1&&fileType__.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}

					if(_repSType==<%=ReportUtil.REPORT_TYPE_GROU0P%>){
						//报表组可能要上传.rpg的报表组
						if(fileType__.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}

					}
					if(_repSType==<%=ReportUtil.REPORT_TYPE_JASPERREPORT%> || _repSType==<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%> || _repSType==<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL%>)
					{
						//jasperreport要上传.jrxml的文件
						if(fileType__.lastIndexOf(".jrxml")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					
				
					
					if(_repSType == <%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>){
					
						var classname = document.getElementById('classnameid').value;
						var methodname = document.getElementById("methodnameid").value;
						if(classname.replace(/\s+/g,"")==''){
							alert('类名必须填写');
							return;
						}
						
						if(methodname.replace(/\s+/g,"")==''){
							alert('方法名必须填写');
							return;
						}
						var currentUrl = document.all.reportForm.action;
						currentUrl += "&classname="+classname;
						currentUrl += "&methodname="+methodname;
						
						document.all.reportForm.action = currentUrl;
					}
					document.all.reportForm.submit();
				}
			<%}%>
		}

//返回子资源调用方法
function getSubInfo(){
	   var reportFile = document.all.superreport.value;
	   var repStype=document.all.repSType.value;
	 	var ec_id="<%=ec_id%>";
		var reportVer=document.all.repVer.value;
		var reportDesc=document.all.repDesc.value;
	   var reportName=document.all.repName.value;
	   
				    if(IsSpace(reportFile))
				    {
				        alert("请上传父报表文件！");
				        document.all.divProcessing.style.display="none";
				       		 return false;
				    }else if(reportFile.lastIndexOf(".jrxml")==-1) {
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
				    }else {
				    	//document.all.reportForm.action = "ReportTools?ec_id=<%=ec_id%>&repName="+reportName+"&repStype="+repStype+"&op=upload"";
				    	//FIXME
				    	
				    	var urls = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/reportTools?op=upload&repSType="+repStype+"&reportName="+reportName+"&reportFile="
				    	+reportFile+"&reportDesc="+reportDesc
				    	+"&reportVer="+reportVer+"&ec_id="+ec_id
				    	;
				    	document.all.reportForm.action=urls;
				    	document.all.reportForm.encoding="multipart/form-data";
						document.all.reportForm.method="post";
						document.all.reportForm.target="uploadframe";
				    	document.all.reportForm.submit();
				    }
}

function checkReportName(repname){
	var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=validatereportname&name="+repname);
	if(retX != "" && retX != null) {
		document.getElementById("myspan").innerHTML= "<font size='2' color='red'>"+retX+"</font>";
		document.reportForm.repName.focus();
	}else if(retX == "") {
		document.getElementById("myspan").innerHTML="";
	}
}

</script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="no">
	<form method="post" name="reportForm" id="reportFormid" action="report_new2.jsp?ec_id=<%=ec_id %>" >
		<div id="new1">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表名称*：</td>
						
						<td height="25">
							<input type="text" id="repName" name="repName" desc="报表名称" maxlength="100" value="<%=isEdit?rep.getRep_name():"" %>" <%=isEdit?"readonly":"" %> onblur="checkReportName(this.value)"/>
							<span id="myspan" name="myspan"></span>
							<input type="hidden" name="isEdit" value="<%=isEdit %>"/>
						</td>
					</tr>

					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表类型*：</td>
						<td height="25">
							<select name="repSType" <%=isEdit?"DISABLED":"" %>>
								<%if(ReportConfig.getPropertiesBoolean("USE_RUNQIAN")){ %>
								<option value="<%=ReportUtil.REPORT_TYPE_RAQ%>" <%=isEdit?(rep.getRep_stype()==0?"SELECTED":""):"SELECTED" %>>普通报表</option>
								<option value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>" <%=isEdit?(rep.getRep_stype()==1?"SELECTED":""):"" %>>参数报表</option>
								<option value="<%=ReportUtil.REPORT_TYPE_GROU0P%>" <%=isEdit?(rep.getRep_stype()==2?"SELECTED":""):"" %>>普通报表组</option>
								<option value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>" <%=isEdit?(rep.getRep_stype()==3?"SELECTED":""):"" %>>参数报表组</option>
								<%}
								if(ReportConfig.getPropertiesBoolean("USE_JASPERREPORT")){
								 %>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT%>" <%=isEdit?(rep.getRep_stype()==6?"SELECTED":""):"" %>>jasperreport</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>" <%=isEdit?(rep.getRep_stype()==7?"SELECTED":""):"" %>>jasperreport(javabean数据源)</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL%>" <%=isEdit?(rep.getRep_stype()==8?"SELECTED":""):"" %>>jasperreport(填报)</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT%>" <%=isEdit?(rep.getRep_stype()==9?"SELECTED":""):"" %>>jasperreport(子报表)</option>
								<%} %>
							</select>
						</td>
					</tr>

					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表版本*：</td>
						<td height="25">
							<input id="currentVersion" type="text" name="repVer" desc="版本" maxlength="100" value="<%=isEdit?rep.getRep_ver():"1" %>" readonly="readonly"/>
							<%
								if(isEdit){
							%>
								是否创建新版本<input type="checkbox" name="isCreateNew" onclick="creatornew(this);"/>
							<%}%>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表描述：</td>
						<td height="25">
							<input type="text"  name="repDesc" desc="报表描述" maxlength="100" value="<%=isEdit?rep.getRep_desc():"" %>"/>
							<input type="hidden" name="escapeRepDesc"/>
						</td>
					</tr>
				</table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input name="button_" type="button" class="input" value="下一步" onClick="befo_submit();"/>
						    </div>
						</td>
					</tr>
				  </table>
		</div>

		<div id="new2" style="display:none">
				<table width="100%" height="145" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td colspan= "2" width="35%" height="25" class="detailtitle" align="center">
							<input type="radio" name="filesource" value="1" onclick="setFileSource(this.value)" CHECKED/><font color="red" size="5">请选择本地文件</font>
						</td>
						
					</tr>
					
					<tr class="tr" id="lfile" style="display:block">
						<td width="35%" height="25" class="detailtitle" align="center">报表文件*：</td>
						<td height="25">
							<input type="file" name="f" maxlength="100" contentEditable="false"/>
							<input type="file" name="f2" maxlength="100" contentEditable="false" style="display:none"/>
						</td>
					</tr>
					
					<tr id="classname" style="display:none">
						<td width="35%" height="30" class="detailtitle" align="center">类全名*：</td>
						<td height="25">
                            <input id= "classnameid" name="classname_" type="text" size="50" value="<%=classname %>"/>
                      </td>
					</tr>
					
					<tr id="methodname" style="display:none">
						<td width="35%" height="30" class="detailtitle" align="center">方法名*：</td>
						<td height="25">
                            <input id="methodnameid" name="methodname_" type="text" size="50" value="<%=methodname %>"/>
                        </td>
					</tr>
					
					<tr id="testme" style="display:none">
						<td colspan="2" height="30" class="detailtitle" align="right"><input type="button" value="测试方法" class="input" onclick="testmethod();"/></td>
					</tr>
					
		  </table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input type="button" class="input" value="上一步" onclick="new1()"/>
								<input name="button_" type="button" class="input" value="确定" onClick="save_submit();"/>
						    </div>
						</td>
					</tr>
		  </table>
		</div>

		<div id="new3" style="display:none">
				<table width="100%" height="145" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td colspan= 2 width="35%" height="25" class="detailtitle" align="center">
						<br/>
							<font size="3">请选择您需要上传的父报表文件路径</font>
						</td>
						
					</tr>

					<tr class="tr" id="fatherfile" style="display:block">
						<td width="35%" height="25" class="detailtitle" align="center">父报表文件*：</td>
						<td height="25">
							<input type="file" name="superreport" maxlength="100" contentEditable="false"/>
						</td>
					</tr>
					
		  </table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input type="button" class="input" value="上一步" onclick="new1()"/>
								<input type="button" class="input" value="下一步" onclick="getSubInfo()"/>
						    </div>
						</td>
					</tr>
		  </table>
		</div>


	</form>

		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
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
		
		
	<iframe id="uploadframe" name="uploadframe" width="0" height="0" style="display: none;"></iframe>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String app_id = request.getParameter("app_id");
	String css = request.getParameter("css");
%>
<!-- 模态窗口刷新 -->
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
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
			src="<%=request.getContextPath()%>/include/pager.js"
			type="text/javascript"></script>

		<script>
			
			function setRadioSelect(){
			    var r = document.all.radioSelect;
			    var obj1=document.all.selectId;	
			    if(r==undefined){
			        alert("请先选择记录！");
			        return 0;
			    }
			    if(r.length==undefined){
			        if(r.checked){
			            obj1.value = r.value;			            		            
			            return 1; 
			        }else{
			            alert("请先选择记录！");
			            return 0;
			        }
			    }else{
			        var num = 0;
			        for(var i = 0;i<r.length;i++){
			            if(r[i].checked){			               
			                obj1.value = r[i].value;			                
			                num++;
			            }
			        }
			        if(num==0){
			            alert("请先选择记录！");
			            return 0;
			        }else{
			            return 1;
			        }
			    }	
			   		    
			}
			
			function cmd_ok(){
			    var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var obj1=document.all.selectId;		
			    var url=obj1.value;			   
			    parent.close();
			    window.returnValue=url;	    
			}	
		</script>
	</head>
	<tab:tabConfig />
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ApplyForm" method="post">
				<input class="text" type="hidden" name="selectId" value="">
				<fieldset style="width: 95%;">
					<LEGEND align=center>
						<FONT size="2">样式选择</FONT>
					</LEGEND>
					<br />
					<table width="90%" height="25" border="0" cellpadding="0"
						cellspacing="1" class="thin">
						<tr class="tr">
							<td align="center" width="5%">
								<input type="radio" name="radioSelect" id="radioSelect"
									value="default" checked="checked" />
							</td>
							<td width="20%" height="35" class="detailtitle" align="center">
								<img src="imager/css1.bmp" />
							</td>
						</tr>
						<tr class="tr">
							<td align="center" width="5%">
								<input type="radio" name="radioSelect" id="radioSelect"
									value="tree" />
							</td>
							<td width="20%" height="35" class="detailtitle" align="center">
								<img src="imager/css2.bmp" />
							</td>
						</tr>
						<tr class="tr">
							<td align="center" width="5%">
								<input type="radio" name="radioSelect" id="radioSelect"
									value="class" />
							</td>
							<td width="20%" height="35" class="detailtitle" align="center">
								<img src="imager/css3.bmp" />
							</td>
						</tr>
					</table>
					<br />
					<input type="button" class="input" value="确定" onClick="cmd_ok()">
					<input type="button" class="input" value="返回"
						onclick="window.close();">
				</fieldset>
			</form>
		</div>

	</body>
</html>
<script type="text/javascript">
		var r = document.ApplyForm.radioSelect;
			for(var i = 0; i < r.length; i++){
   						if(r[i].value == "<%=css%>"){
    							r[i].checked = true;
    							break;
   							}
						}
</script>

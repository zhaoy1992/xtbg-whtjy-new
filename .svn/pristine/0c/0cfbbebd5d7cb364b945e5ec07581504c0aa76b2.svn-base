<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//从应用目录下的report目录中去找临时报表文件
	String filePath = ConfigManager.getInstance().getConfigValue("approot")
	+ "/ccapp/app_"+control.getCurrentSystemID()+"/report/";
	String search  = request.getParameter("search");
	if(search==null || search.trim().equals("")){
	search = "";
	}
	request.setAttribute("searchme",search);
	request.setAttribute("filePath",filePath);
%>
<html>
	<head>
		<title>属性容器</title>

		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/include/pager.js"
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

			function lookfile(obj){
				var url = "<%=request.getContextPath()%>"+obj;
				window.open(url,"_blank");
			}

function searchme(){
var queryStr = document.getElementById('searchbox').value;

window.location.href='file_list.jsp?search='+queryStr;

}
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">

		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
				<input type="hidden" name="filePath" value="<%=filePath %>"/>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>文件列表</b>
						</td>

					</tr>
					<tr>
						<td height='30' class="detailtitle" align="right" colspan="9">
							<b>查询文件</b><input type="text" size="15" id="searchbox" value="<%=(search==null||search.trim().equals(""))?"":search %>"><input type="button" class="input" value="查询" onclick="searchme()">
						</td>

					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.reportmanage.menu.FileList" keyName="com.chinacreator.epp.reportmanage.menu.FileList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="com.chinacreator.epp.reportmanage.menu.FileList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td height='20' class="headercolor">
							<input class="text" type="hidden" name="selectId" value="">
							<input name="delSingle" type="hidden" validator="string"
								maxlength="100" value="false">

							</td>
							<td height='20' class="headercolor">
								文件名称
							</td>
						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有文件
								</td>
							</tr>
						</pg:notify>

						<pg:param name="filePath"/>

						<!--list标签循环输出每条记录-->
						<pg:list>

								<tr class="labeltable_middle_tr_01"
									onMouseOver="this.className='mousestyle1'"
									onMouseOut="this.className= 'mousestyle2'">
									<td class="tablecells" nowrap="true">
										<P align="left">
											<INPUT type="radio" name="radioSelect" id="radioSelect"
												value='<pg:cell colName="fileName" defaultValue=""/>'>
										</P>
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="fileName" defaultValue="" />
									</td>
								</tr>


						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<input name="Submit" type="button" class="input" value="确定"
									onClick="cmd_ok()">

							</td>
						</tr>
					</pg:pager>

				</table>
				<div align="center">
				</div>
			</form>
		</div>

	</body>
</html>
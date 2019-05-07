<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.util.ModelsDataBase"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	String defaultUrl = basePath + "/FusionCharts/test_data.xml";		
	String[] alltype = FusionUtil.getAllType();
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String eform_class = StringUtils.defaultString(request.getParameter("class_id"));
	if("".equals(eform_class)){
	    eform_class = "0";
	}
	
	String type = (String)request.getParameter("type");
	String id = (String)request.getParameter("id");
	String flag = (String)request.getParameter("flag");
	(new ModelsDataBase()).deleteById(type,id);
	if("delete".equals(flag)){
	   	type = "";
	}
	if("delete".equals(flag)){
	   	id = "";
	}
%>
<html>
	<head>
		<title>图形列表</title>

		 <link rel="stylesheet" type="text/css" href="../css/windows.css">
  	 	 <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
 	 	 <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
 		 <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  		 <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
 	 	 <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script type="text/javascript" src="s2u.js"></script>
<script type="text/javascript">
	 String.prototype.startWith=function(str){
	  if(str==null||str==""||this.length==0||str.length>this.length)
	   return false;
	  if(this.substr(0,str.length)==str)
	     return true;
	  else
	     return false;
	  return true;
	 }
 
	function copyUrl(id,url){
		var finalUrl = _getURL(id,url)
		window.clipboardData.setData("Text",finalUrl); 
		alert('运行连接\n'+finalUrl+'\n已经复制到剪贴板');
	}
	
	function _getURL(id,url){
		var runurl = '';
		if(url.startWith('http://') || url.startWith('https://')){
			runurl = url;
		}else{
			if(url.startWith('/')){
				runurl = '<%=basePath%>'+url;
			}else{
				runurl = '<%=basePath%>/'+url;
			}
		}
		
		var finalUrl = '<%=basePath%>/FusionCharts/xmlrunning.jsp?fusionid='+id+'&dataurl='+runurl;
		return finalUrl;
	}
	
	function doopenlink(id,url){
		var   xMax  =   screen.width;   
     	var   yMax  =   screen.height;
     	var modelw = xMax/1.5;
     	var modelh = yMax/2;
   	 	var dialogLeft  =(xMax - modelw)/2;
   	 	var dialogTop = (yMax - modelh)/4; 
   	 	window.showModalDialog('previewXmlRunning.jsp?__dataurl='+toUN.on(_getURL(id,url)),null,'dialogWidth='+modelw+'px;dialogHeight='+modelh+'px;dialogLeft='+dialogLeft+';dialogTop='+dialogTop+';scroll:1');   
	}
	
	function deletelink(id,url){
	    var _index = id.indexOf("_");
		var onlyId = id.substring(_index+1);
		var modecode = id.substring(0,_index);
		window.location.href='main.jsp?modelcode='+modecode+'&fusiontype='+modecode+'&fusionid='+onlyId+'&datasourcetype=xml&dataurl='+url;
	}
	function queryForm(){	
		var type = document.all("type").value;
		var id = document.all("id").value;
		var sUrl="<%=basePath%>/FusionCharts/chartslist.jsp?id="+id+"&type="+type;
		ApplyForm.action=sUrl;
		ApplyForm.submit();	
	}
	function deleteById(type,id){	
		var sUrl="<%=basePath%>/FusionCharts/chartslist.jsp?id="+id+"&type="+type+"&flag=delete";
		window.location.href=sUrl;
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%>
		<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							图表类型：
						</td>
						<td>
						<select id="type">
							<option value="all">全部</option>
							<%for(int j = 0;j < alltype.length;j++){%>
								<option value="<%=alltype[j] %>" <%=alltype[j].equals(type)?"selected=\"selected\"":"" %>><%=alltype[j] %> 类型</option>
							<%} %>
							</select>
						</td>
						<td class="detailtitle" width="10%" align=right>
							图表ID：
						</td>
						<td class="detailcontent" width="40%">
							<input type="text" name="id" style="width:70%" value="<%=id==null?"":id%>">
						</td>
					</tr>
					<tr>
						<td class="detailcontent" width="30%" colspan="4" align="right">
							<input name="Submit4" type="button" class="input" value="查询" onClick="queryForm()">
							<input name="Submit22" type="button" class="input" value="清空" onClick='document.all("id").value="";document.all("type").value="all"'>
						</td>
					</tr>
				</table>
				
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					<tr>
						<td height='15' class="detailtitle" align=center colspan=10>
							<b>图形列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.fusionchart.web.ChartList" keyName="ChartList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="ChartList" isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td height='20' width="20%" class="headercolor">
								图形ID
							</td>
							<td height='20' width="10%" class="headercolor">
								图形类型
							</td>
							<td height='20' width="30%"  class="headercolor">
								数据源地址
							</td>
							<td height='20' width="15%" class="headercolor">
								最后修改时间
							</td>
							<td height='20' width="18%" class="headercolor">
								操作
							</td>
						</tr>
						<pg:param name="type"  defaultValue="<%=type%>"/>
						<pg:param name="id" defaultValue="<%=id%>"/>
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									未找到图形控件信息
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" ondblclick="copyUrl('<pg:cell colName="id" defaultValue="" />','<pg:cell colName="dataurl" defaultValue="<%=defaultUrl %>"/>');">
							
								<td height='20'  align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="id" defaultValue="" />
								</td>
								<td height='20'  align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="">
									<pg:cell colName="chartName" defaultValue=""/>
								</td>
								<td height='20'  align=left class="tablecells" style="word-wrap:break-word;">
									<input name="dataurl" value="<pg:cell colName="dataurl" defaultValue="<%=defaultUrl %>"/>" size="60">
								</td>
								<td height='20'  align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="lastModifyData" defaultValue=""/>
								</td>
								
								<td height='20'  align=center class="tablecells" style="word-wrap:break-word;">
									<input type="button" value="删除" class="input" onclick="deleteById('<pg:cell colName="chartName" defaultValue="" />','<pg:cell colName="id" defaultValue=""/>');"/>
									<input type="button" value="预览" class="input" onclick="doopenlink('<pg:cell colName="id" defaultValue="" />','<pg:cell colName="dataurl" defaultValue="<%=defaultUrl %>"/>');"/>
								</td>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
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

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
<head>  

	<script src="../../eformsys/fceform/js/fcpub.js"></script>

  <title>属性容器</title>
   <link rel="stylesheet" type="text/css" href="../../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">

  
  <script type="text/javascript">  	
  	function val_input(input)
  	{
  		//验证输入的是否为合法字符
	     var patten=/^[a-zA-Z0-9]+$/;
	  	 if(patten.test(input))
	  	 {
	  		 return true;
	  	 }else
	  	 {
	   	     return false;
	     }
  	}
  	
  	function newXPDL(ec_id,expkgids)
	{	
		var wpf_name=window.prompt("请输入并联流程名称：");
		if(wpf_name==null||wpf_name=="")
		{
			alert("您没有输入并联流程名称！");
			return false;
		}
		
		if(!val_input(wpf_name))
		{
			alert("流程名只能输入字符和数字！");
			return false;
		}
		
		//验证应用中是否有同名的流程
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valPName&pid="+wpf_name);
		if(retX=="false")
		{
			alert("此流程已经存在，请使用其他的流程名！");
			return false;
		}
		
		//需要压缩jar包，并将名称给客户端
		var zipName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/jawe_unite/down.jsp?expkgids="+expkgids);
		alert(zipName);	
		retx=window.showModalDialog("../xpdl_open.jsp?ec_id="+ec_id+"&op=new&mgrName="+wpf_name+"&expkgids="+expkgids+"&zipName="+zipName);
		if(retx) window.location.reload();
	}
	
	//修改流程基本信息 add by minghua.guo 090617
  	function editXPDLMes(pId)
	{	
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/xpdl_edit.jsp?pId="+pId,window);
		if(retx=='true') window.location.reload();
	}
	
	function openXpdl(mgrName,pid)
	{
		//首先验证是否已经打开
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valIsOpen&pid="+pid);
		if(retX=="true")
		{
			alert("该文件已经被其他用户打开,请稍后再试！");
			return false;
		}
		var reg=/#/g;
		mgrName=mgrName.replace(reg,"~");
		document.getElementById("divProcessing").style.display="block";
		var _url = "<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id=<%=request.getParameter("ec_id")%>"+"&op=modify&mgrName="+mgrName+"&pid="+pid;
		document.getElementById("myFrame").src=_url;
	}
	
	function showXpdlHistory(pname)
	{
		var retx=window.showModalDialog("../xpdl_history.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=read&pname="+pname,window);
		if(retx) window.location.reload();
	}
	
	function showSubflow(pname)
	{
		var reg = /#/g;
		pname=pname.replace(reg,"~");
		var retx=window.showModalDialog("subflow_list.jsp?pname="+pname);
		if(retx) window.location.reload();
	}
	
	function deleteProcess(forceToDel)
	{
		//删除流程记录
		setSelectId();
		var obj1=document.all.selectId;
		if(IsSpace(obj1.value))
		{
		   alert("没有选择任何记录！");
		   return false;
		}
		else
		{
			if(forceToDel=='true')
			{
				//强制删除
				if(!window.confirm("进行该删除操作会将所有将该流程的运行数据都删除,是否确定删除？"))
				{
					return false;
				}
			}
			else
			{
				if(!window.confirm("是否确定删除？"))
					return false;
			}
				var url = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=processDelete&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>&pid="+obj1.value;
				if(forceToDel=='true')
				{
					url += "&forceToDel=true";
				}
				document.all.divProcessing.style.display="block";
				var retX=SendHttp(url);
				alert(retX);
				window.location.reload();
		}
	}
	
	
	function setSelectId()
	{
		var els=document.getElementsByName("checkBoxOne");
		var obj1=document.all.selectId;
		obj1.value="";
		for(var i=0;i<els.length;i++)
		{
			if(els[i].checked) obj1.value+=els[i].value+",";
		}
	}
	
	// 复选框全部选中
	function checkAll(totalCheck,checkName){	
 	 		var selectAll = document.getElementsByName(totalCheck);
  			var o = document.getElementsByName(checkName);
  			if(selectAll[0].checked==true){
   			for (var i=0; i<o.length; i++){
     	  			if(!o[i].disabled){
     	  				o[i].checked=true;
     	  			}
   			}
  			}else{
   			for (var i=0; i<o.length; i++){
  	  	 	 		o[i].checked=false;
  	   			}
  			}
	}

   
	// 单个选中复选框
	function checkOne(totalCheck,checkName){
  			var selectAll = document.getElementsByName(totalCheck);
  			var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}
	
	function newUniteXpdl()
	{
		var chks =getNavigatorContent().applyform.process;
		var tmp="";
		alert(chks.length);
		for(i=0;i<chks.length;i++)
		{
			if(chks[i].checked) tmp+=chks[i].value+",";
		}
		var reg = /#/g;
		//var url="../xpdl_open.jsp?ec_id=<%=request.getParameter("ec_id")%>&expkgids="+tmp;
		var ec_id ="<%=request.getParameter("ec_id")%>";
		var expkgids=tmp.replace(reg,"~");
		if(expkgids!=null&&expkgids.length>0)
		{
			newXPDL(ec_id,expkgids);
		}
		else
		{
			alert("请选择要插入的外部包！");
			return false;
		}
	}
	//打开输入名称的页面，然后再跳转到选择树
	function openXpdlSelectPage()
	{
		//var retx=window.showModalDialog("iframe_main.jsp");
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/jawe_unite/xpdl_new.jsp",window);
		if(retx) window.location.reload();
	}
	
	//发布流程
	function publish(pId,pName,userName)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/ProcessTools?op=publish&pId="+pId+"&pName="+pName+"&userName="+userName);
		alert(retX);
		window.location.reload();	
	}
	//取消发布	
	function cancelPublish(pId)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/ProcessTools?op=cancelPublish&pId="+pId);
		alert(retX);
		window.location.reload();	
	}
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ProcessForm" action="" method="post">

				
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=8>
							<b>流程列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="UniteProcessList" keyName="UniteProcessList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="UniteProcessList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								流程编号
							</td>
							<td height='20' class="headercolor">
								流程名称
							</td>
							<td height='20' class="headercolor">
								流程描述
							</td>
							<td height='20' class="headercolor">
								发布日期
							</td>
							<td height='20' class="headercolor">
								发布人
							</td>
							<td height='20' class="headercolor">
								发布状态
							</td>
							<td height='20' class="headercolor">
								修改
							</td>
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>

						<pg:param name="ec_id" />
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有流程
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="pId" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')">
									<pg:cell colName="pId" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=dataSet.getString("pName").split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publishTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publisher" defaultValue=""/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">
										未发布
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										已发布
									</pg:equal>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">
										<input type="button" value="修改" onclick="openXpdl('<pg:cell colName="pName" defaultValue=""/>','<pg:cell colName="pId" defaultValue=""/>')"/>
										<input type="button" value="查看历史版本" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="查看引用的流程" onclick="showSubflow('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="发布" onclick="publish('<pg:cell colName="pId" defaultValue="" />','<pg:cell colName="pName" defaultValue=""/>','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										<input type="button" value="查看引用的流程" onclick="showSubflow('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="取消发布" onclick="cancelPublish('<pg:cell colName="pId" defaultValue="" />')"/>
									</pg:equal>
									<input type="button" value="修改信息" onclick="editXPDLMes('<pg:cell colName="pId" defaultValue=""/>')"/>
								</td>
								</tr>
						</pg:list>
						
						
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<input name="Submit" type="button" class="input" value="新增"
									onClick="openXpdlSelectPage()"/>
								<%--<input name="Submit" type="button" class="input" value="新增"
									onClick="newUniteXpdl()"/>--%>
								<input type="button" value="删除" class="input"
									onclick="deleteProcess('false')"/>
								<!-- //强制删除liuc -->
								<input type="button" value="强制删除" class="input"
									onclick="deleteProcess('true')"/>								
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe id="myFrame" scrolling="no" noresize frameborder="0"/>
</html>

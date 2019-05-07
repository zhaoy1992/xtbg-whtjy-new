<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.workflow.bean.ProcessDefinitionBean"%>
<%@page import="com.chinacreator.workflow.shark.SharkEngine"%>


<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0); 
%>

<%
	//对xpdl文件的操作，只读或者可读写
	String op = (request.getParameter("op")!=null)?(String)request.getParameter("op"):"modify";
	SharkEngine se = SharkEngine.getInstance();
	List list = se.getHistrProcDefiniton(request.getParameter("pname"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>查看历史流程</title>
		
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">
		
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
	
		<script type="text/javascript">
		/*
				function openXpdl(ec_id,mgrName)
				{
					var tmp = escape(mgrName);
					//window.showModalDialog("xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp);
					var _url = "<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id="+ec_id+"&op=read&mgrName="+tmp;
					var ParentObj = parent.window.dialogArguments.document.getElementById("myFrame"); 
					ParentObj.src=_url;
					parent.window.dialogArguments.document.getElementById("divProcessing").style.display="block";
					window.close();
				}
		*/
				function openXpdl(ec_id,mgrName)
				{
					var tmp = escape(mgrName);
					var _url = "<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id="+ec_id+"&op=read&mgrName="+tmp;
					var obj = document.getElementById("myFrame"); 
					obj.src=_url;
					document.getElementById("divProcessing").style.display="block";
				}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body>
		<script type="text/javascript">
			//alert("<%=list.size()%>");
		</script>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
					
					<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<!-- P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P-->
							</td>
							<td height='20' class="headercolor">
								版本号
							</td>
							<td height='20' class="headercolor">
								流程名称
							</td>
							<td height='20' class="headercolor">
								修改时间
							</td>
							<td height='20' class="headercolor">
								查看
							</td>
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>
						<!-- 循环体 -->
						<%
							if(list.size()>0){
							Iterator it = list.iterator();
							while(it.hasNext()){
								ProcessDefinitionBean p = (ProcessDefinitionBean)it.next();
						%>
						<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<!--P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value=''>
									</P-->
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=p.getVersion() %>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=p.getMgrName().split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<%=new Date(Long.parseLong(p.getCreated())).toLocaleString() %>
								</td>

								<td height='20' align="left" class="tablecells">
									<input type="button" value="查看" onclick="openXpdl('<%=request.getParameter("ec_id") %>','<%=p.getMgrName() %>')"/>
								</td>
						</tr>
						<%}} %>	
		</table>
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
	<iframe id="myFrame" scrolling="no" noresize frameborder="0" HEIGHT="1px" width="1px"/>
</html>
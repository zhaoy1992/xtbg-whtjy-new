<%@ page contentType="text/html; charset=GBK" language="java" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<html>
	<head>
		<title>意见审核</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css"/>
		<link href="css/main.css" rel="stylesheet" type="text/css">
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
		<META HTTP-EQUIV="expires" CONTENT="Mon, 23 Jan 1978 20:52:30 GMT">
		<script language="javascript" src="../inc/js/func.js"></script>
		<style type="text/css">
		 a   {   cc:expression(window.status='')   }  
		
</style>
  </head>
  <body>
  
	<table id="tag_attach_list" width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Atable" id="docListTable">
			<tr>
				<td height="25" colspan="9" >
					<span  class="text">自由问答操作：</span>
					
					<input name="button" type="button" onClick="questionPass();" class="buttons3" value=" 审 核 " />
					<input name="button" type="button" onClick="questionDelete();" class="buttons3" value=" 删 除 " />
				</td>
		    </tr> 
		</table>
	<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request,response);
	%>
	
	<%
	    String id = request.getParameter("id");
		
	%>
  <form name="Answerlist" method="post" >
  	<input name="actionType" type="hidden" />
  	<input name="answerIDs" type="hidden" />
   <table width="100%" border="0" cellpadding="5" cellspacing="0" class="Atable"><!--分页显示开始,分页标签初始化-->
         				<pg:listdata dataInfo="Answerlist" keyName="Answerlist" />
						
						<pg:pager maxPageItems="20" scope="request" data="Answerlist" isList="false">
							<!--检测当前页面是否有记录--><!--list标签循环输出每条记录-->
							<TR class="cms_report_tr">
								<!--设置分页表头-->
								<td class="c1" align="center"  width="2%" align="left"></td>
								<TD width="2%" align="center" >
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on" class="checkbox">
</TD>                            
								<td class="c1" align="center"  width="10%" align="left">自由问答题目</td>
					
					<td class="c1" align="center"  width="10%" align="left">回答内容</td>
					<td class="c1" align="center"  width="8%" align="left">回答人IP</td>
					<td class="c1" align="center"  width="8%" align="left">回答时间</td>
					<td class="c1" align="center"  width="8%" align="left">状态</td>
												
							</TR>
							<pg:param name="qtitle" />
					<pg:param name="answer" />
					<pg:param name="whoIp" />
					<pg:param name="when" />
					<pg:param name="id"/>
								
							<%int j = 0 ; %>
				<!--list标签循环输出每条记录-->
				<pg:list>
				
				<tr <%j++;if(j%2==1) out.print("bgcolor=#EEF2F7"); %>>
								<td class="tablecells" nowrap="nowrap" width="3%">
									<div align="left"><img src="../images/note.gif" width="16" height="15"></div>
								</td>
								<td class="tablecells" align=center height='30'>
								<INPUT type="checkbox" name="checkBoxOne"  onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="answerID" defaultValue=""/>' >
								</td>
								<td class="tablecells" nowrap="true" title="<pg:cell colName="qtitle" defaultValue=""/>">
                                      <pg:cell colName="qtitle" maxlength="13" replace="..." defaultValue=""/>
								</td>
								
								<td class="tablecells" nowrap="true" title="点击这里查看详细信息" style="cursor:hand" onclick="view('<pg:cell colName="answerID" defaultValue=""/>')">
                                   <pg:cell colName="answer" maxlength="13" replace="..." defaultValue=""/>
								</td>
									
								<td class="tablecells" nowrap="true" >
										<pg:cell colName="whoIp" defaultValue="" />
								</td>
								
								<td class="tablecells" nowrap="true" >
										<pg:cell colName="when" defaultValue="" />
								</td>
								<td class="tablecells" nowrap="true" >
								<%
									int state=dataSet.getInt(Integer.parseInt(rowid),"state");
									if(state==1)
									{%>
										已审核
									<%}
									else
									{%>
										未审核
									<%}
									
								%>
								</td>							
							</tr>
							</pg:list>
						<tr >
						<td colspan=10 align="right" class="c2">
							共
							<pg:rowcount />
							条记录
							<pg:index />
						</td>
						
					    </tr>
					     
							<P align="center"><input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">	</P>
						</pg:pager>

				  </table>
</FORM>
	<iframe name="hidFrm" width="0" height="0"></iframe>		
  </body>
    
<script language="javascript">

	function checkAll(totalCheck,checkName){	//复选框全部选中
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
	
		
	function  questionDelete(){
			
		document.all("answerIDs").value = "";
		var j=0;
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				if(j==0){
				 document.all("answerIDs").value = obj[i].value;
				 j++;
			    }else
				{
				  document.all("answerIDs").value += ","+obj[i].value;
				}
			}
		}
		if (document.all("answerIDs").value==''){
			alert("请作选择!");
			return;
		}
		if (!confirm("是否要删除这些回答?"))
			return;
			
		document.all("actionType").value ="delete";
		//alert(document.Answerlist.action);
		document.Answerlist.action = "<%=request.getContextPath()%>/cms/voteManager/answer_del.jsp?id=<%=id%>";
		document.Answerlist.method = "post";
		document.Answerlist.target="hidFrm";
		document.Answerlist.submit();
	}
	function  questionPass(){
			
		document.all("answerIDs").value = "";
		var j=0;
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
			   if(j==0){
				 document.all("answerIDs").value = obj[i].value;
				 j++;
			    }else
				{
				  document.all("answerIDs").value += ","+obj[i].value;
				}
			}
		}
		if (document.all("answerIDs").value==''){
			alert("请作选择!");
			return;
		}
		if (!confirm("是否要审核这些回答?"))
			return;
			
		document.all("actionType").value ="pass";
		//alert(document.Answerlist.action);
		document.Answerlist.action = "<%=request.getContextPath()%>/cms/voteManager/answer_pass.jsp?id=<%=id%>";
		document.Answerlist.method = "post";
		document.Answerlist.target="hidFrm";
		document.Answerlist.submit();
	}	
	function view(answerId)
	{
	  showModalDialog('answerView.jsp?answerId='+answerId,window,"dialogWidth:600px;dialogHeight:500px;help:no;scroll:auto;status:no");
	  //window.open('answerView.jsp?answerId='+answerId,'_blank','toolbar=no,left=100,top=50,width=600,scrollbars=yes,height=500,menubar=no,systemMenu=no,resizable=yes');
	  document.location.reload();
	}
	
</script>
</html>

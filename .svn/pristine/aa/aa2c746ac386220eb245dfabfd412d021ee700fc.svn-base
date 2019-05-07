<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.*"%>

<html>
	<head>
		<title>选项查看</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="../inc/js/func.js"></script>
		<link href="css/main.css" rel="stylesheet" type="text/css">

  </head>
  <%
        AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request,response);
  	if (request.getParameter("qids")!=null&&!"".equals(request.getParameter("qids"))){
    	VoteManager voteMgr  = new VoteManagerImpl();
  		if ("delete".equals(request.getParameter("actionType"))){
  			if(voteMgr.delQuestions(request.getParameter("qids"))==1){
  				%><script language="javascript">alert("删除成功!");</script><%
  			}
  		}
  		if ("active".equals(request.getParameter("actionType"))){
  			if(voteMgr.activateQuestions(request.getParameter("qids"),accesscontroler.getUserAccount(),accesscontroler.getUserName(),request.getRemoteAddr())==1){
  				%><script language="javascript">alert("审核成功!");</script><%
  			}
  		}
  		if ("unactive".equals(request.getParameter("actionType"))){
  			if(voteMgr.unactivateQuestions(request.getParameter("qids"),accesscontroler.getUserAccount(),accesscontroler.getUserName(),request.getRemoteAddr())==1){
  				%><script language="javascript">alert("取消审核成功!");</script><%
  			}
  		}
    	if ("settop".equals((String)request.getParameter("actionType"))){
    		if(voteMgr.setQuestionTop((String)request.getParameter("qids"))!=1){
    			%><SCRIPT language="javascript">alert("置顶失败！");</script><%
    		}
    	}
  	}
  %>
    <%

    String deptID = accesscontroler.getChargeOrgId();
	String deptName = accesscontroler.getChargeOrgName();
	
	
	if(accesscontroler.isAdmin()||accesscontroler.isGrantedRole("网上调查管理员"))
	{
		deptName = "admin";
	}
	
	session.setAttribute("deptID",deptID);
	session.setAttribute("deptName",deptName);
%>
  <body>
  <form name="questionList" method="post" action="<%=request.getContextPath()%>/cms/voteManager/questionList.jsp" >
  	<input name="actionType" type="hidden" />
  	<input name="qids" type="hidden" />
  	<input name="channel" type="hidden" value="<%=request.getParameter("channel")%>"/>
  	
	<table width="100%" border="0"  class="table02" cellspacing="0">
  		<tr>
  		<td width="47%"  height="25" >
  			问卷名称：<input name="surveyName" id="surveyName" type="text" style="width:200px;"/>
  		</td>
  		<td   height="25"  colspan="2" >
  			是否审核：<input name="active" id="active" type="radio" value="1"/>审核
  			<input name="active" id="active" type="radio" value="0" />未审核
  			<input name="active" id="active" type="radio" value="2" checked/>全部
  		</td></tr>
  		<TR>
  		<td width="47%"  height="25" >
  			问题描述：<input name="questionTitle" id="questionTitle" type="text" style="width:200px;"/>
  		</td>
  		<td   height="25">
  			回答方式：<input name="style" id="style" type="radio" value="0"/>单选
  			<input name="style" id="style" type="radio" value="1" />多选
  			<input name="style" id="style" type="radio" value="2" />自由回答
  			<input name="style" id="style" type="radio" value="3" checked/>全部
  		</td>
  		<TD>
  		<INPUT name="search" type="button" class="button2"value=" 查 询 " onclick="return query();">
												
		<INPUT name="search" type="button" class="button2"value="显示所有" onclick="return clean();">
  		</TD>
  		
  		</tr>
  	</table>
  	
	<table id="tag_attach_list" width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Atable" id="docListTable">
			<tr>
				<td height="25" colspan="9" >
					<span class="text">问卷操作：</span>
					<input name="button" type="button" onClick="return setTop()" class="buttons3" value=" 问题置顶 " />
					 <input name="button" type="button" onClick="questionActivate()" class="buttons3" value=" 审 核 " />
					  <input name="button" type="button" onClick="questionUnActivate()" class="buttons3" value="取消审核" />
					   <input name="button" type="button" onClick="return2('<%=request.getParameter("channel")%>')" class="buttons3" value=" 返 回 " />
	
				</td>
		    </tr> 
		</table>
    <table width="100%" border="0" cellpadding="5" cellspacing="0" class="Atable">
 				<pg:listdata dataInfo="CmsQuestionList" keyName="CmsQuestionList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="30" scope="request" data="CmsQuestionList" isList="false">
				<tr  class="cms_report_tr">
					<!--设置分页表头-->
					<td   width="3%" class="c1" align="center">全选</td>
					<td  width="5%" class="c1" align="center">
						<P align="left">
							<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')">
						</P>
					</td>
					<td class="c1" align="center"  width="10%" >问题编号</td>
					<td class="c1" align="center"  width="5%" >置顶</td>
					<td class="c1" align="center"              >问题描述</td>
					<td class="c1" align="center"              >问卷名称</td>
					<td class="c1" align="center"  width="10%" >回答方式</td>
					<td class="c1" align="center"  width="10%" >答复次数</td>
					<td class="c1" align="center"  width="5%" >审核</td>
					<td class="c1" align="center"  width="5%" ></td>
				</tr>
				
				
					<pg:param name="id" />
					<pg:param name="title" />
					<pg:param name="surveyName" />
					<pg:param name="active" />
					<pg:param name="questionTitle" />
					<pg:param name="style" />
				<%int j = 0; %>	
				<!--list标签循环输出每条记录-->
				<pg:list>
				<%
						
						
						j++;
						
					%>
				<tr <%if(j%2==1) out.print("bgcolor=#EEF2F7"); %>   >
					<td class="tablecells" nowrap="nowrap" width="3%">
						<div align="left"><img src="../images/note.gif" width="16" height="15"></div>
					</td>
					<td class="tablecells" nowrap="true">
					<P align="left">
						<INPUT type="checkbox" name="checkBoxOne" value='<pg:cell colName="id" defaultValue=""/>' >
					</P>
					</td>
					<td class="tablecells" nowrap="nowrap" align="center">
						<pg:cell colName="id" defaultValue="" />
					</td>
					<td class="tablecells" nowrap="nowrap" align="center">
						<pg:equal colName="isTop" value="1"><font color="#ff0000">置顶</font></pg:equal>
					</td>
					<td class="tablecells" nowrap="nowrap" title="点击这里查看详细信息" align="center">
						<pg:cell colName="title" defaultValue="" maxlength="15" replace="..."/>
					</td>
					<td class="tablecells" nowrap="nowrap" title="<pg:cell colName="surveyName" defaultValue=""/>" align="center">
						<pg:cell colName="surveyName" defaultValue="" maxlength="15" replace="..."/>
					</td>
					<td class="tablecells" nowrap="nowrap"  align="center">
						<pg:equal colName="style" value="0">单选</pg:equal>
						<pg:equal colName="style" value="1">多选</pg:equal>
						<pg:equal colName="style" value="2">自由回答</pg:equal>
					</td>
					<td class="tablecells" nowrap="nowrap"  align="center">
						<pg:cell colName="votecount" defaultValue="0" />
					</td>
					<td class="tablecells" nowrap="nowrap" align="center">
						<pg:equal colName="active" value="0">否</pg:equal>
						<pg:equal colName="active" value="1">是</pg:equal>
					</td>
					<TD class="tablecells" nowrap="nowrap" align="center">
					<a  href="#" onClick="seeIP('<pg:cell colName="id" defaultValue=""/>')">IP记录</a>
					</TD>
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
					     
							<P align="center"><input name="queryString" value="<pg:querystring/>" type="hidden"></P>
						</pg:pager>

				  </table>
</FORM>
			
  </body>
    
<script language="javascript" src="js/qlist.js">
</script>
</html>

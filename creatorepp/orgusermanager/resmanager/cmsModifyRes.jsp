<%
/**
 * 
 * <p>Title: �Զ�����Դ�޸�ҳ��</p>
 *
 * <p>Description: �Զ�����Դ�޸�</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-9-16
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.sysmgrcore.entity.Res,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "true";
	}	
String resId = request.getParameter("resId");
ResManager resManager = SecurityDatabase.getResourceManager();
Res res = resManager.getRes("res_Id",resId);
String title = res.getTitle();
String path = res.getPath();
String restypeId=request.getParameter("restypeId");
String restypeName=request.getParameter("restypeName");
String rootpath = request.getContextPath();

%>
<html>
<head>     
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
 <script language="javaScript" src="../validateForm.js"></script> 
<script language="JavaScript">
var isResExist = "<%=reFlush%>";
	if ( isResExist == "true"){
		alert("������ͬ������!");
	}


  
function update(){

    		var title=document.forms[0].title.value;
    		
				if (title.length == 0 ){
			    alert("��Դ���Ʋ���Ϊ�գ�"); 
			    return false;
			    }
			    document.all("Submit1").disabled = true;
				document.all("Submit3").disabled = true;	
			    document.forms[0].target = "updateRes";
			    document.forms[0].action="saveCmsResOp.jsp?opType=update&resId=<%=resId%>&restypeId=<%=restypeId%>&restypeName=<%=restypeName%>&oldTitle=<%=title%>";
			    document.forms[0].submit();

}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">

<div id="contentborder" align="center">
<br><br>
<center>

<form name="thisform" action="" method="post"  >	
<pg:beaninfo requestKey="newRes">
	
		 <input type="hidden"  name="resId" value="<pg:cell colName="resId"  defaultValue=""/>"/>						 			 		 
		 <input type="hidden"  name="parentId" value="<pg:cell colName="parentId"  defaultValue="-1"/>" />
		
		 <input type="hidden"  name="marker" value="<pg:cell colName="marker"  defaultValue=""/>" />
		 <input type="hidden"  name="reserved1" value="<pg:cell colName="reserved1"  defaultValue=""/>" />
		 <input type="hidden"  name="reserved3" value="<pg:cell colName="reserved3"  defaultValue=""/>" />
		 <input type="hidden"  name="reserved4" value="<pg:cell colName="reserved4"  defaultValue=""/>" />
		 <input type="hidden"  name="reserved5" value="<pg:cell colName="reserved5"   defaultValue=""/>">
		 <input type="hidden"  name="attr1" value="<pg:cell colName="attr1"  defaultValue=""/>" />
		 <input type="hidden"  name="attr2" value="<pg:cell colName="attr2"  defaultValue=""/>" />
		 <input type="hidden"  name="attr3" value="<pg:cell colName="attr3"  defaultValue=""/>" />
		 <input type="hidden"  name="attr4" value="<pg:cell colName="attr4"  defaultValue=""/>" />
		 <input type="hidden"  name="attr5" value="<pg:cell colName="attr5"  defaultValue=""/>" />
		 <input type="hidden"  name="attr6" value="<pg:cell colName="attr6"  defaultValue=""/>" />
		 <input type="hidden"  name="attr7" value="<pg:cell colName="attr7"  defaultValue=""/>" />
		 <input type="hidden"  name="attr8" value="<pg:cell colName="attr8"  defaultValue=""/>" />
		 <input type="hidden"  name="attr9" value="<pg:cell colName="attr9"  defaultValue=""/>" />
		 <input type="hidden"  name="attr10" value="<pg:cell colName="attr10"  defaultValue=""/>" />
		 <input type="hidden"  name="attr11" value="<pg:cell colName="attr11"  defaultValue=""/>" />
		 <input type="hidden"  name="attr12" value="<pg:cell colName="attr12"  defaultValue=""/>" />
		  <input type="hidden"  name="attr13" value="<pg:cell colName="attr13"  defaultValue=""/>" />
		 <input type="hidden"  name="attr14" value="<pg:cell colName="attr14"  defaultValue=""/>" />
		 <input type="hidden"  name="attr15" value="<pg:cell colName="attr15"  defaultValue=""/>" />
		 <input type="hidden"  name="attr16" value="<pg:cell colName="attr16"  defaultValue=""/>" />
		 <input type="hidden"  name="attr17" value="<pg:cell colName="attr17"  defaultValue=""/>" />
		 <input type="hidden"  name="attr18" value="<pg:cell colName="attr18"  defaultValue=""/>" />
		 <input type="hidden"  name="attr19" value="<pg:cell colName="attr19"  defaultValue=""/>" />
		 <input type="hidden"  name="attr20" value="<pg:cell colName="attr20"  defaultValue=""/>" />
		 <input type="hidden"  name="attr21" value="<pg:cell colName="attr21"  defaultValue=""/>" />
		 <input type="hidden"  name="attr22" value="<pg:cell colName="attr22"  defaultValue=""/>" />
		 <input type="hidden"  name="attr23" value="<pg:cell colName="attr23"  defaultValue=""/>" />
		 <input type="hidden"  name="attr24" value="<pg:cell colName="attr24"  defaultValue=""/>" />
		 <input type="hidden"  name="attr25" value="<pg:cell colName="attr25"  defaultValue=""/>" />
		 <input type="hidden"  name="attr26" value="<pg:cell colName="attr26"  defaultValue=""/>" />
		 <input type="hidden"  name="attr27" value="<pg:cell colName="attr26"  defaultValue=""/>" />
		  <input type="hidden"  name="roleUsage" value="<pg:cell colName="roleUsage"  defaultValue=""/>" />	 	
<div class="detailtitle"><%=restypeName %>�������ļ������õ�IDΪ��<%=restypeId %></div>		 		 			 
<table width="50%" border="0"   cellpadding="0" cellspacing="1" class="thin">
  <tr  >    
    <td align="center"  class="detailtitle">��Դ����*</td>
    <td align="left" class="detailcontent">&nbsp;&nbsp;&nbsp;&nbsp;
    <input name="title" type="text" size="40" readonly="true"
				 validator="string" cnname="����" value="<pg:cell colName="title"  defaultValue="<%=title%>"/>"></td>	
	</tr>	
<!--	<tr  >		 -->
<!--	<td align="center" class="detailtitle">�Ƿ�ʹ��</td>-->
<!--    <td align="left" class="detailcontent">-->
<!--   &nbsp;&nbsp;&nbsp;&nbsp;-->
<!--    <select name="roleUsage"  class="select">			  -->
<!--				<option value="0">��</option>	-->
<!--				<option value="1">��</option>		-->
<!--				-->
<!--	</select>	-->
<!--    </td>	   -->
<!--  </tr>-->
	
	<tr  >		 
	<td align="center" class="detailtitle">��Դ����</td>
    <td align="left" class="detailcontent">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input name="path" type="text" size="40"
				  value="<pg:cell colName="path"  defaultValue="<%=path%>"/>"></td>	   
  </tr>
  </table>
<br>
<br>
<table>
  <tr align="center" >     
          <td  class="detailcontent" colspan="2">
             <input name="Submit1" type="button" class="input" value="�޸�" onclick="update()">        	
             <input name="Submit3" type="button" class="input" value="����" onclick="window.close();">                                       
          </td> 	   
                     
  </tr>
</table>				
</pg:beaninfo>
</form>
</center>
</div>
<iframe width="0" height="0" name="updateRes" ></iframe>
		
</body>
</html>

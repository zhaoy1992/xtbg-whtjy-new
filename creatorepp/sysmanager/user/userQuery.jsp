<%@include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	String hasKey = (String)request.getAttribute("hasKey");
	if(hasKey == null)
	hasKey="0";	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>ϵͳ����</title>
<SCRIPT LANGUAGE="JavaScript"> 
function query(){	
   if(document.all("userName").value.length<1){
   		alert("�������ѯ����");
   		return;
   }     
   document.forms[0].action="../user/userManager.do?method=userQuery";
   document.forms[0].submit();
}
</SCRIPT>
<link href="Images/style.css" rel="stylesheet" type="text/css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="middleleft">
<form name="form1" method="post" action="">
<table width="100%" border="0" class="table" cellpadding="0" cellspacing="1">
  <tr class="tr">
    <td class="td" align="center"><strong>�û���ѯ</strong></td>
  </tr>
</table>
<table width="100%" class="table">
  
  <tr class="tr">
    <td class="td"><table class="table" width="100%%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr class="tr">
        <td class="td">�û�����</td>
        <td class="td"><input type="text" class="text" name="userName"></td>
        
        <td class="td"><input name="Submit22" type="button" class="input" onClick="query()" value="��ѯ"></td>
        <td class="td"><input name="Submit3" type="reset" class="input" value="����"></td>
      </tr>
    </table>    </td>
  </tr>
  <tr class="tr">
    <td height="25" class="td"><hr width="98%"></td>
  </tr>
  <%
  	if(hasKey.equals("1")){  
  %>
  <tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" class="tr">
    <td class="td"><table width="100%%" border="0" cellpadding="0" cellspacing="0" class="table">
      
      <pg:listdata dataInfo="UserSearchList" keyName="UserSearchList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="5"
				  scope="request"  
				  data="UserSearchList" 
				  url="../user/userManager.do"
				  isList="false">
			      <tr class="tabletop">
			      <!--���÷�ҳ��ͷ-->				    
				    <td align="center">�û�����</td>
				    <td align="center">�û�ID</td>    	     		    		    
				    <td align="center">������Ϣ</td>
			      </tr>
			      <pg:param name="method" value="userQuery"/>
			      <pg:param name="userName"/>
				  
				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" class="labeltable_middle_tr_01">
			      	<td colspan=100 align='center'>��ʱû���û�</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
						<tr class="labeltable_middle_tr_01"  >		      				
							<td align=center><pg:cell colName="userName" defaultValue=""/></td>
							<td align=center><pg:cell colName="userSn" defaultValue=""/></td>
							<td align=center><pg:cell colName="userRealname" defaultValue=""/></td>
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" class="labeltable_middle_tr_01">
			      	<td colspan=4 align='center'><pg:index/></td>
			      	<td align='left'>					
				</td>
			      </tr>   		
			      <input name="queryString" value="<pg:querystring/>" type="hidden">
		</pg:pager>
    </table>
    </td>
  </tr>
  <%
	}  
  %>
</table>
</form>
<%@ include file="../sysMsg.jsp"%>
</body>
</html>

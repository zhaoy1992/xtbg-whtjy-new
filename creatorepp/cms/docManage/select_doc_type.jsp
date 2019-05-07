<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.security.authorization.AuthUser"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    DocumentManager dm = new DocumentManagerImpl();
	List status = dm.getStatusList();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<title>��ѡĿ��״̬�б�</title>
	<script src="../inc/js/func.js"></script>
	<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	<script language="javascript">
		//�ύ	
		var restr = ""; 
		function sub(){
			var all = document.getElementsByName("desStatus");
			var flag = false;
			
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					flag = true;
					restr = all[i].value;
					break;
				}		
			}
			if(flag){				
				window.close();
			}
			else{
				alert("��ѡ��һ��Ŀ��״̬");
			}
		}
		
		window.onunload = function setValue(){
		    window.returnValue = restr;
  		            
  		}
	</script>
	<style type="text/css">
		body {
			background-color:#FFFFFF;
		}
	</style>
</head>
<body>
<form name="form1"  method="post">
<table width="80%" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" align="center">
  <th colspan="2" height="30"  class="cms_title_blue">
  	��ѡ��һ��Ŀ��״̬
  </th>
  <tr class="cms_report_tr">
    <td align="center" height="30" colspan=2>
		��ѡĿ��״̬
	</td>
  </tr>
  <%
	  	for(int i=0;i<status.size();i++){
			DocStatus sta =(DocStatus)status.get(i);
			int staid = sta.getStatus_id();
			String staname = sta.getStatus_name();
			//1:�¸� 2:���� 5:�ѷ� 11:������
			if(staid==1 || staid==5 || staid==11){
			  %>
			  <tr class="cms_data_tr">
			    <td align="center" height="30"  class="tablecells">
					<input name="desStatus" type="radio" value="<%=staid%>" hidefocus">
				</td>
			    <td align="center" height="30"  class="tablecells">
					<%=staname%>
				</td>
			  </tr>
			  <%	
			 }
  		}
  %>
  <tr>
    <td colspan="2" align="center" height="30">
		<input name="submit1" type="button" value="ȷ��" class="cms_button" onClick="sub()">
		&nbsp;
		<input name="close1" type="button" value="����" class="cms_button" onClick="window.close()">
	</td>
  </tr>
  <tr>
  </tr>
</table>
</form>
<div style="display:none">
	<iframe name="statusFrame" width="0" height="0">
	</iframe>
</div> 
</body>
</html>


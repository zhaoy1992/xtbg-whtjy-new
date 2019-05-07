<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request, response);
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);
    response.setDateHeader("max-age", 0);
    
    String siteId = request.getParameter("siteId");
    siteId = siteId==null?"":siteId;
    String templateIds = request.getParameter("templateIds");
    templateIds = templateIds==null?"":templateIds;
%>
<html>
<head>
<title>ģ�嵼����</title>
<base target="_self">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<script language="javascript">
//window.dialogTop = "px"; 
//window.dialogLeft = "px"; 
window.dialogHeight = "300px"; 
window.dialogWidth = "400px";
</script>
</head>
<base target="_self">
<body>   

<form name="importForm" method="post">
    <table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">    
        <tr>
            <td width="4%" height="30" align="right">
                <img src="../images/ico_point.gif" width="25" height="25">
            </td>
            <td height="30" class="cms_title_blue">
                  ����ģ��
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:9px; background-color:#3266B1"></td>
        </tr>
        <tr>
            <td colspan="2" style="height:10px; background-color:#fff"></td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="100%" align="center" border="1"  bordercolor="#f0f0f0">
                    <tr>                        
                        <td rowspan=2 align="center" width="30%">
                            <label>ģ���Ϊ:
                        </td> 
                        <td height="24" align="left">
                            <input type="radio" name="expType" value="0" checked>����ģ�� 
                        </td>  
                    </tr>
                    <tr>
                        <td height="24" align="left">
                            <input type="radio" name="expType" value="1">˽��ģ��
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        
        <tr>       
            <td colspan=2 height="54" align="center">
                <input name="button" onClick="nextStep()" type="button" class="cms_button" value="��һ��" />
            </td>
        </tr>
    </table>
</form>

</body>
<iframe id="hidFrm" name="hidFrm" src="" style="display:none"></iframe>
<script>
    /**
     * type����ֵ:
     * 0:����ģ��,ȱʡֵ
     * 1:˽��ģ��
     */
    function nextStep(){
        var type = "0";
        var imptype = new Array(); 
        imptype = document.all("expType");        
        for(var i=0;i<imptype.length;i++){
        	if(imptype[i].checked){
        	    type = imptype[i].value;
        	    break;
        	}	
        }         
        var actionstr = "exportTemplate.jsp?siteId=<%=siteId%>&templateIds=<%=templateIds%>&expType="+type;
        document.importForm.action=actionstr;
        document.importForm.submit();
    }
</script>
</html>


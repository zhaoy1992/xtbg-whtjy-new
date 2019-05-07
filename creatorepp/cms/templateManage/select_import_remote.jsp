<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.cms.container.TmplateExport"%>
<%@ page import="java.sql.*,java.util.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request, response);
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);
    response.setDateHeader("max-age", 0);
    String templatePath = application.getRealPath("cms/siteResource/siteTemplate");
    String siteId = request.getParameter("siteId");
    siteId = siteId==null?"":siteId;    
    //TemplateManager tmplUtil = new TemplateManagerImpl();
    //List list = tmplUtil.exportTmplRecordList(2,Integer.parseInt(siteId)); 
%>
<html>
<head>
<title>��������ģ�嵼��</title>
<base target="_self">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
<script src="../inc/js/func.js"></script>
<script language="javascript">
//window.dialogTop = "px"; 
//window.dialogLeft = "px"; 
window.dialogHeight = "450px"; 
window.dialogWidth = "550px";
</script>
</head>
<base target="_self">
<body>   
<form name="importForm" method="POST">
    <table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">    
        <tr>
            <td width="4%" height="30" align="right">
                <img src="../images/ico_point.gif" width="25" height="25">
            </td>
            <td height="30" class="cms_title_blue">
                  ��������ģ�嵼��
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:9px; background-color:#3266B1"></td>
        </tr>
        <tr>
            <td colspan="2" style="height:10px; background-color:#fff"></td>
        </tr>
        <tr>
            <td>                
            </td>
        </tr>
    </table>
        
    <table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" id="docListTable">
		<tr class="cms_report_tr">
			<pg:listdata dataInfo="ExportTmplList" keyName="ExportTmplList" />
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="5" scope="request" data="ExportTmplList" isList="false">						
			<!--���÷�ҳ��ͷ-->
			<td width="2%" align=center style="width:5%">
			    <!--input class="checkbox" name="tmplname" value="on" type="checkbox" id="tmplname" class="checkbox" onclick="selectall()"-->
			</td>
			<td width="8%">ģ�������</td>
			<td width="8%">ģ�������</td>
		</tr>
		<pg:param name="tmplname" />
		<pg:param name="siteId" />
		<!--��⵱ǰҳ���Ƿ��м�¼-->
		<pg:notify>
			<tr class="labeltable_middle_tr_01">
				<td colspan=100 align='center' height="18px">��Ƶ����ʱû���ĵ�	</td>
			</tr>
		</pg:notify>

		<!--list��ǩѭ�����ÿ����¼-->
		<pg:list>
            <tr class="cms_data_tr" id="<pg:cell colName='tmplname' defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
				<td class="tablecells" align=center height='30'>
				    <!-- input type="checkbox" class="checkbox" onclick="checkOne(this)" id="tmplname" name="tmplname" value="<pg:cell colName='tmplname' defaultValue=""/>"-->
				<!-- ��ԭ���Ķ�ѡ���Ϊ��ѡ��-->
				<input type="radio" name="tmplname" value="<pg:cell colName='tmplname' defaultValue=""/>"/>
				</td>
				<td class="tablecells">
				    <pg:cell colName="tmplname" defaultValue="" />							
				</td>
				<td class="tablecells">
				    <pg:cell colName="tmpldesc" defaultValue="" />
				</td>
				
			</tr>
		</pg:list>
		
		<tr class="labeltable_middle_tr_01">
			<td colspan=10 >
			    <div class="Data_List_Table_Bottom">��
				<pg:rowcount />
				����¼
				ÿҳ��ʾ5��
				<pg:index />
				</div>  
		    </td>
		</tr>
		
		<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
		<tr></tr>
	    </pg:pager>
    </table>
        
    <table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">   
        <tr>
            <td colspan="2" style="height:20px; background-color:#fff"></td>
        </tr>
        <tr>       
            <td colspan="2" align="center">
                <input name="button" onClick="preStep()" type="button" class="cms_button" value="��һ��" />&nbsp;&nbsp;
                <input name="button" onClick="nextStep()" type="button" class="cms_button" value="��һ��" />
            </td>
        </tr>
	</table>
</form>

</body>
<iframe id="hidFrm" name="hidFrm" src="" style="display:none"></iframe>
<script>
    var checkValue="";
    function getRadioValue(radioName){
	    var radioValue = "";
	    var arr = new Array();
	    arr = document.all(radioName);
	    for(var i=0;i<arr.length;i++){
	        if(arr[i].checked){
	            radioValue = arr[i].value;
	            break;
	        }   
	    }
	    return radioValue;
	}
    function nextStep(){
        var selectOne = false;
        var o = document.getElementsByName("tmplname");
        for (var i=0; i<o.length; i++){
            if(o[i].checked){
                selectOne = true;
            }
        }
        if(!selectOne){
            alert("��ѡ��Ҫ�����ģ���!");
            return false;
        }
        //document.frames[0].src = "examine_import.jsp";
		//document.importForm.target = "hidFrm";
		//document.all("divProcessing").style.display="";
		document.importForm.action = "select_import_remote_second.jsp?siteId=<%=siteId%>&checkValue="+getRadioValue("tmplname");
		document.importForm.submit();
         
    }
    function preStep(){
        document.importForm.action = "select_import_first.jsp?siteId=<%=siteId%>";
        document.importForm.submit();
    }
    var checkflag = false;    
    //ȫѡ�и�ѡ��
    function selectall(){
        var o = document.getElementsByName("tmplname");
        if(checkflag==false){
            for (var i=0; i<o.length; i++){
                if(!o[i].disabled){
                        o[i].checked=true;
                }
            }
            checkflag = true;
        }else{
            for (var i=0; i<o.length; i++){
                if(!o[i].disabled){
                        o[i].checked=false;
                }
            }
            checkflag = false;
        }
    }
    //����ѡ�и�ѡ��
    
    function checkOne(e){
        var o = document.getElementsByName("tmplname");
        for (var i=0;i<o.length;i++){
            if(o[i].value==e.value){
                o[i].checked=true
                checkflag=true;
            }else{
                o[i].checked=false
            }
            checkValue = e.value;
        }
    }
    
</script>
</html>


<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration,
				com.frameworkset.common.poolman.util.JDBCPoolMetaData"%>
<%@page import="com.chinacreator.remote.Utils"%>
<%@page import="org.jgroups.blocks.GroupRequest"%>
<%@page import="java.util.Iterator"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
 	<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/datasourceChange.js'></script>
	<!-- dwr end -->
    <title>datasourceList</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
				<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
	<script type="text/javascript">
	
	function modifyRecord(dealType) {
	    var outMsg;
		var count=0;   
	    for (var i=0;i<datasourceform.elements.length;i++) {
			var e = datasourceform.elements[i];
							
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		count++;
			    }
			}
	    }
	    if (count==1){
			editApply();
	    }else{
	    	alert("��ѡ����Ҫ�޸ĵ�һ��(��һ��)��¼��");
	    	return false;
	    }
		return false;
	}
	
	function editApply(){
		var value = document.getElementsByName("selectId").value;
		var ww = openWin('<%=basePath%>epp/datasourcemanage/datasourceInfo.jsp?isEdit=modify&&dbname='+value,screen.availWidth-320,screen.availHeight-80);
		if(ww)
			{
				location.reload();
			}
	}
	
	function getApplyInfo(datasource_name){
		document.getElementsByName("selectId").value=datasource_name;
	}
	
	function createDatasource(){
		var ww=openWin('<%=basePath%>epp/datasourcemanage/datasourceInfo.jsp?isEdit=add',screen.availWidth-320,screen.availHeight-80);
		if(ww){
			location.reload();
		}
	}
	//ɾ������Դ
	function delRecord(dealType){
		var isSelect = false;
    	var outMsg;
	    for (var i=0;i<datasourceform.elements.length;i++) {
			var e = datasourceform.elements[i];						
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		isSelect=true;    		
		       		break;
			    }
			}
	    }
	    if (isSelect){    		
	        	if (confirm("ȷ��ɾ����")){
	        		var inputObjects = document.getElementsByName("checkBoxOne");
					var arrayValues = new Array;
					for(var i = 0;i < inputObjects.length;i ++){
						if(false != inputObjects[i].checked)
							//alert("value="+inputObjects[i].value);
							arrayValues[arrayValues.length] = inputObjects[i].value;
					}
					datasourceChange.delDatasource(arrayValues,returnValue);
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	    }
		return false;
	}
	//���ݷ���ֵ������ɹ�orʧ��
	function returnValue(obj){
		if(obj){
			alert("ɾ���ɹ�,��������������Ч!");
		}else{
			alert("ɾ��ʧ��");
		}
		
		window.parent.location.reload();
	}
	</script>
  </head>
  <%@ include file="/epp/css/cssControl.jsp"%> 
  <body class="contentbodymargin" scroll="no">
    <form name="datasourceform" action="" method="post">
    	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
   			<tr>
				<td height='30' class="detailtitle" align=center colspan=10>
					<h4><b>����Դ�б�</b></h4>
				</td>
			</tr>
    		<pg:listdata dataInfo="com.chinacreator.epp.datasourcemanage.menu.DatasourceList" keyName="DatasourceList" />
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="10" scope="request" data="DatasourceList" isList="false">
			
			<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>
							<td height='20' class="headercolor">
								����Դ����
							</td>
							<input class="text" type="hidden" name="selectId">
							<input class="text" type="hidden" name="selectBusinessEntity">
							<input class="text" type="hidden" name="selectUddiUrl">
							<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
							<td height='20' class="headercolor">
								���ݿ�����
							</td>
							<td height='20' class="headercolor">
								���ݿ����ӵ�ַ
							</td>
							<td height='20' class="headercolor">
								���ݿ��û���
							</td>
							<!-- 
							<td height='20' class="headercolor">
								����ģ��
							</td>
							<td height='20' class="headercolor">
								ע�����·��
							</td>
							<td height='20' class="headercolor">
								��ѯ����·��
							</td>
							 -->
						</tr>

						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû������Դ����
								</td>
							</tr>
						</pg:notify>

						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onClick="getApplyInfo('<pg:cell colName="dbname" defaultValue="" />')" onDBLclick="editApply()">
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="dbname" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="dbname" defaultValue="" />
								</td>
								<td height='20' width="150" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="driver" defaultValue="" />
								</td>
								<td height='20' width="150" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="url" defaultValue="" />
								</td>
								<td height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="">
									<pg:cell colName="username" defaultValue="" maxlength="30" replace="..." />
								</td>
				<!-- 				<td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="tmodelkey" defaultValue="" maxlength="30" replace="..."/>
								</td>
								 -->
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
								<%
								if (control.isAdmin()) {
								%>
								<input name="Submit" type="button" class="input" value="����" onClick="createDatasource()">
								<input name="Submit" type="button" class="input" value="�޸�" onClick="javascript:modifyRecord(0); return false;">
								<input type="button" value="ɾ��" class="input" onClick="javascript:delRecord(0); return false;">
								<%
								}
								%>
							</td>
						</tr>
			
			</pg:pager>
    	</table>
    </form>
  </body>
</html>

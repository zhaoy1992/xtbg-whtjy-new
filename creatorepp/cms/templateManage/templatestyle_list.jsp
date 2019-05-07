
<%@ page contentType="text/html; charset=GBK" language="java" errorPage=""%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*,com.chinacreator.cms.templatemanager.tag.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	if(!accesscontroler.checkAccess(request, response)){
		return ;
	}

	//String addurl = "doc_extfield_add.jsp";
%>
<html>
	<head>
		<base target=_self><!-- use for submit to self-->
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>.::::::::::ģ�������::::::::::::::::::::::::::::::..</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript">
			
 			function addaStyle(){
 				var re = openWin("templatestyle_add.jsp?action=add",400,300);
 				if(re=="cf"){
 					var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
 				}
 			}
 			function deleteStyles(){
 				if(haveSelect('ID')){
 					var ids = getStyleIds();
	 				templateStyleForm.action="templateStyleHandle_do.jsp?action=delete&ids="+ids;
					templateStyleForm.submit();
				}else{
					alert("��ѡ��Ҫɾ����ģ����");
					return false;
				}
				var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
 			}
 			//����ģ����
			function updateaStyle(styleId,styleName,siteId,styleDesc)
			{
				var re = openWin("templatestyle_edit.jsp?action=edit&styleId=" + styleId + "&siteId=" + siteId + "&styleName=" + styleName + "&styleDesc=" + styleDesc,400,300);
 				if(re=="cf"){
 					var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
 				}
			}
			
			
			function top()
			{
				var all = document.getElementsByName("ID");
				var flag = 0;
				for(var i=0;i<all.length;i++){
					if(all[i].checked == true){
						flag ++;
						if(flag > 1)
						{
							alert("��ѡ����ģ�����ƶ���");
							return false;
						}
					}
				}
				if(flag < 1)
				{
					alert("��ѡ��Ҫ�ƶ���ģ����");
					return false;
				}
				for(var i=0;i<all.length;i++){
					up();
				}
				
				//���ñ�������ť���ɼ�
				var div = document.getElementById("saveorder");
				div.style.visibility = "visible";
			}
			
			function up()
			{
				var all = document.getElementsByName("ID");
				var row;
				var flag = 0;
				for(var i=0;i<all.length;i++){
					if(all[i].checked == true){
						row = all[i];
						flag ++;
						if(flag > 1)
						{
							alert("��ѡ����ģ�����ƶ���");
							return false;
						}
					}
				}
				if(flag < 1)
				{
					alert("��ѡ��Ҫ�ƶ���ģ����");
					return false;
				}
				var tmp = row;
				upRow(row);
				tmp.checked = true;
				
				var div = document.getElementById("saveorder");
				div.style.visibility = "visible";
			}
			
			function down()
			{
				var all = document.getElementsByName("ID");
				var row;
				var flag = 0;
				for(var i=0;i<all.length;i++){
					if(all[i].checked == true){
						row = all[i];
						flag ++;
						if(flag > 1)
						{
							alert("��ѡ����ģ�����ƶ���");
							return false;
						}
					}
				}
				if(flag < 1)
				{
					alert("��ѡ��Ҫ�ƶ���ģ����");
					return false;
				}
				var tmp = row;
				downRow(row);
				tmp.checked = true;
				
				var div = document.getElementById("saveorder");
				div.style.visibility = "visible";
			}
			function base()
			{
				var all = document.getElementsByName("ID");
				var flag = 0;
				for(var i=0;i<all.length;i++){
					if(all[i].checked == true){
						flag ++;
						if(flag > 1)
						{
							alert("��ѡ����ģ�����ƶ���");
							return false;
						}
					}
				}
				if(flag < 1)
				{
					alert("��ѡ��Ҫ�ƶ���ģ����");
					return false;
				}
				for(var i=0;i<all.length;i++){
					down();
				}
				
				var div = document.getElementById("saveorder");
				div.style.visibility = "visible";
			}
			//���row����
			function upRow(e){
				var _row=e.parentElement.parentElement;
				if(_row.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling)
				{
					//alert(_row.previousSibling.outerHTML);
					swapNode(_row,_row.previousSibling);
				}
			}
			//���row����(˵��ע���Ե�����Ҳ�� һ��nextSibling��
			function downRow(e)
			{
				//ͨ�����Ӷ����ȡ����е�����
				var _row=e.parentElement.parentElement;
				//����������һ�У�������һ�н���˳��
				if(_row.nextSibling.nextSibling.nextSibling.nextSibling)
				{	
					//alert(_row.nextSibling.outerHTML);
					swapNode(_row,_row.nextSibling);
				}
		
			}
			//����
			function swapNode(node1,node2){
				//ȡ�ý�Ҫ�����������ڵĸ�ѡ���ֵstyleOrder�����,Ȼ�󽻻�
				//if(node1.cells(0).all.length>0&&node2.cells(0).all.length>0){
				var cv = node1.cells(0).all[1].value;
				node1.cells(0).all[1].value = node2.cells(0).all[1].value;
				node2.cells(0).all[1].value = cv;
				//}
				//alert(node1.cells(0).all[1].value+"------------"+node2.cells(0).all[1].value);
				//��ȡ�����
				var _parent=node1.parentNode;
				//��ȡ�����������λ��
				var _t1=node1.nextSibling;
				var _t2=node2.nextSibling;
				//��node2���뵽ԭ��node1��λ��
				if(_t1)_parent.insertBefore(node2,_t1);
				else _parent.appendChild(node2);
				//��node1���뵽ԭ��node2��λ��
				if(_t2)_parent.insertBefore(node1,_t2);
				else _parent.appendChild(node1);
			}
			
			//��������
			function saveOrder(){
				var allCheck = document.getElementsByName("ID");
				var allHidden = document.getElementsByName("styleId");
				var orderNum = "";
				var styleId = "";
				if(allCheck.length == allHidden.length){	
					for(var i=0;i<allCheck.length;i++){
						orderNum += allCheck[i].value+":";
						styleId += allHidden[i].value+":";
					}
				}
				
				templateStyleForm.action="templateStyleHandle_do.jsp?action=saveOrder&orderNum="
											+orderNum+"&styleIds="+styleId;
				//alert(templateStyleForm.action);
				templateStyleForm.submit();
				
				var div = document.getElementById("saveorder");
				div.style.visibility = "hidden";
				
				var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
			}
			
			function getStyleIds(){
				var allCheck = document.getElementsByName("ID");
				var allHidden = document.getElementsByName("styleId");
				var styleIds = "";
				if(allCheck.length == allHidden.length){	
					for(var i=0;i<allCheck.length;i++){
						if(allCheck[i].checked==true)
							styleIds += allHidden[i].value+":";
					}
				}
				return styleIds;
			}
			
			//���ñ�������ť���ɼ�
           function loadSaveOrder() {
				var div = document.getElementById("saveorder");
				div.style.visibility = "hidden";
			}
			
			function test() {
				//checkOne('checkBoxAll','ID')
				var allCheck = document.getElementsByName("ID");
				for(var i=0;i<allCheck.length;i++){
					if(allCheck[i].checked==true)
						alert(allCheck[i].value);
				}
			}
			
		</script>
	</head>

	<body topmargin="2" rightmargin="0" onload="loadSaveOrder()">
		<form name="templateStyleForm" id="templateStyleForm" action="" method="post" target="templateStyleFrame">
			<table width="100%" border="0" align=center cellpadding="3" cellspacing="0" id="docVerListTable" class="Datalisttable">
				<tr>
					<td colspan="7" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7"><div class="DocumentOperT">
						ģ�������</div>
						<a style="cursor:hand" onClick="addaStyle()"><div class="DocumentOper">����</div></a>
						<a style="cursor:hand" onClick="deleteStyles()"><div class="DocumentOper">ɾ��</div></a>
						<a style="cursor:hand" onClick="top();"><div class="DocumentOper">��������</div></a>
						<a style="cursor:hand" onClick="up();"><div class="DocumentOper">����</div></a>
						<a style="cursor:hand" onClick="down();"><div class="DocumentOper">����</div></a>
						<a style="cursor:hand" onClick="base();"><div class="DocumentOper">�����ײ�</div></a>
						<div id="saveorder">
						<a style="cursor:hand" onClick="saveOrder()"><div class="DocumentOper">��������</div></a>
						<div>
					</td>
				</tr>
				<pg:listdata dataInfo="com.chinacreator.cms.templatemanager.tag.TemplateStyleList" 
								keyName="TemplateStyleList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="10" scope="request" data="TemplateStyleList" isList="false">
					<tr class="cms_report_tr">
						<!--���÷�ҳ��ͷ-->
						<td width="10%" height='30' align=center style="width:5%">
							<input class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
 					    </td>
						<td width="30%">�������</td>
						<td width="65%">�������</td>
					</tr>
					
					<!--��⵱ǰҳ���Ƿ��м�¼-->
					<pg:notify>
						<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
							<td colspan=100 align='center'>��û�з��</td>
						</tr>
					</pg:notify>

					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<%
							int styleId = dataSet.getInt("styleId");
						%>
						<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'"
							 onMouseOut="this.style.background='#FFFFFF'" id="<pg:cell colName="styleId" defaultValue=""/>">
							<td class="tablecells" align=center height='30'>
								<input name="styleId" value="<pg:cell colName="styleId" defaultValue=""/>" type=hidden>
								<input   class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="styleOrder" defaultValue=""/>">
							</td>
							
							<td class="tablecells" align="center" style="cursor:hand" onclick="updateaStyle('<%=styleId%>','<pg:cell colName="styleName" defaultValue="" />','<pg:cell colName="siteId" defaultValue="" />','<pg:cell colName="styleDesc" defaultValue="" />')">
								<pg:cell colName="styleName" defaultValue="" />
							</td>
							<td class="tablecells" align="center">
								<pg:cell colName="styleDesc" defaultValue="" />
							</td>
						</tr>
					</pg:list>
					<tr class="labeltable_middle_tr_01">
						<td colspan=10><div class="Data_List_Table_Bottom">
							��
							<pg:rowcount />
							����¼
							<pg:index /></div>
						</td>
					</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>

		  </table>
		</form>
		<iframe name="templateStyleFrame" width="0" height="0"></iframe>
	</body>
</html>
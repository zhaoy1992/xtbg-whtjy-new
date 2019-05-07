
<%@ page contentType="text/html; charset=GBK" language="java" errorPage=""%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String addurl = "doc_extfield_add.jsp";
%>
<html>
	<head>
		<base target=_self><!-- use for submit to self-->
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>.::::::::::�ֵ�ʻ����::::::::::::::::::::::::::::::..</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript">
 			function addaWord(){
 				var re = openWin("dict_word_add.jsp?action=add",400,300);
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
 			function deleteWords(){
 				if(haveSelect('ID')){
	 				dictManageform.action="dictWordHandle.jsp?action=delete";
					dictManageform.submit();
				}else{
					alert("��ѡ��Ҫɾ���Ĵʻ㣡");
					return false;
				}
 			}
 			//�����ֵ�ʻ�
			function updateaWord(wordId,word,siteId,description)
			{
				var re = openWin("dict_word_add.jsp?action=edit&wordId=" + wordId + "&siteId=" + siteId + "&word=" + word + "&description=" + description,400,300);
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
		</script>
	</head>

	<body topmargin="2" rightmargin="0">
		<form target="dictManageFrame" name="dictManageform" action="" method="post">
			<table width="100%" border="0" align=center cellpadding="3" cellspacing="0" id="docVerListTable" class="Datalisttable">
				<tr>
					<td colspan="7" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7"><div class="DocumentOperT">
						�ֵ����</div>
						<a style="cursor:hand" onClick="addaWord()"><div class="DocumentOper"><img 
									class="operStyle" src="../../sysmanager/images/plan.gif">����</div></a>
						<a style="cursor:hand" onClick="deleteWords()"><div class="DocumentOper"><img 
									class="operStyle" src="../../sysmanager/images/plan.gif">ɾ��</div></a>				  </td>
				</tr>
				<pg:listdata dataInfo="DocCommentDictList" keyName="DocCommentDictList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="10" scope="request" data="DocCommentDictList" isList="false">
					<tr class="cms_report_tr">
						<!--���÷�ҳ��ͷ-->

						<td width="10%" height='30' align=center style="width:5%">
							<input  class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">					  </td>
						<td width="20%">
							�ʻ�����						</td>
						<td width="10%">
							����						</td>
						<td width="15%">
							ʹ��վ��						</td>
					</tr>
					
					<!--��⵱ǰҳ���Ƿ��м�¼-->
					<pg:notify>
						<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
							<td colspan=100 align='center'>
								��û�дʻ�							</td>
						</tr>
					</pg:notify>

					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<%
							int wordId = dataSet.getInt("wordId");
						%>
						<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'" id="<pg:cell colName="wordId" defaultValue=""/>">
							<td class="tablecells" align=center height='30'>
								<input   class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="wordId" defaultValue=""/>">
							</td>
							
							<td class="tablecells" align="center" style="cursor:hand" onclick="updateaWord('<%=wordId%>','<pg:cell colName="word" defaultValue="" />','<pg:cell colName="siteId" defaultValue="" />','<pg:cell colName="description" defaultValue="" />')">
								<pg:cell colName="word" defaultValue="" />
							</td>
							<td class="tablecells" align="center">
								<pg:cell colName="description" defaultValue="" />
							</td>
							<td class="tablecells"  align="center">
								<pg:cell colName="siteName" defaultValue="" />
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
		<iframe height="0" width="0" name="dictManageFrame"></iframe>
	</body>
</html>



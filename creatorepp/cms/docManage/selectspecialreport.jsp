
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
		<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
		<title>���ݹ��������</title>
		<style type="text/css">
		body {
			background-color: #ffffff;
		}
		.STYLE1 {color: #0000FF}
		.STYLE2 {color: #000099}
		.style3 {
			font-size: 14px;
			font-weight: bold;
			color: #3300FF;
		}
		.operStyle{ display:none;
		width:17;
		height:16;
		}

</style>
<script language="javascript">
<!--
function selectspecialreport()
{
  if(!haveSelect('ID'))
  {
    alert('��ѡ��ĳ��ר�ⱨ��');
  }
  else
  {
    var tables=window.dialogArguments.document.all("doc_attach_list");
    
    var specialvalue='';
    var specialobjs=document.getElementsByName("ID");
    for(var i=0;i<specialobjs.length;i++){
			if(specialobjs[i].checked == true){
			//����td
			var row1 = tables.insertRow(1);
			var td1 = window.dialogArguments.document.createElement("td");
		    var td2 = window.dialogArguments.document.createElement("td");
		    var td3 = window.dialogArguments.document.createElement("td");
		    var trvalue=specialobjs[i].value.split('&');
		    
		td1.innerHTML="<input type='checkBox' name='id' hideFocus=true  value='"+trvalue[0]+"&"+trvalue[1]+"'/>";		 
		td2.innerText = trvalue[2];
		
		td3.innerText =trvalue[3];
		row1.appendChild(td1);
		row1.appendChild(td2);
		row1.appendChild(td3);
			   
			}
			}
	//����������
	window.close();
  }
}
-->
</script>
	</head>

	<body topmargin="1" rightmargin="1" scroll=auto leftmargin="1">
		<form name="form1" action="" method="post">
            
			<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" id="docListTable">
				<tr>
					<td height='25' colspan="10" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
					<div  class="DocumentOperT">ר�ⱨ����</div>
				
						
						<a style="cursor:hand" onClick="selectspecialreport()"><div class="DocumentOper"><img 
									src="../images/new_doc.gif" class="operStyle">ѡȡר��</div></a><a style="cursor:hand" onClick="window.close();"><div class="DocumentOper"><img 
									src="../images/new_doc.gif" class="operStyle">����</div></a>
					</td>
				</tr>
				<%
				String pasiteid=request.getParameter("siteid");
				String channelid=request.getParameter("channelid");
				String sql="select a.site_id siteid ,b.name sitename,a.display_name channelname,channel_id from td_cms_channel a,td_cms_site b  where a.site_id=b.SITE_ID and b.STATUS=0 and channel_id!="+channelid+" and a.specialflag=1";
				String sitename="";
				String siteid="";
				%>
				
				<pg:pager scope="request" statement="<%=sql%>" title="��ҳ" dbname="bspf" isList="true">
					<tr class="cms_report_tr">
						<!--���÷�ҳ��ͷ-->

						<td width="6%" align=center style="width:6%"><input class="checkbox" type="checkBox" hidefocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')"></td>
						<td width="38%">
							����վ��						</td>
						<td width="56%">
							ר�ⱨ������						</td>
						
					</tr>
				
					
					<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								��ʱû��ר�ⱨ��							</td>
						</tr>
					</pg:notify>

					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
					<%
					siteid=dataSet.getString("siteid");
					sitename=dataSet.getString("sitename");
					%>
                        <tr class="cms_data_tr">
							<td class="tablecells" align=center height='30'>
							  <input class="checkbox" onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="siteid" defaultValue=""/>&<pg:cell colName="channel_id" defaultValue=""/>&<%=sitename%>&<pg:cell colName="channelname" defaultValue=""/>"></td>

							<td class="tablecells" align=center height='30'><%=sitename%>
							</td>
							
							<td class="tablecells" align=center height='30'><%=dataSet.getString("channelname")%>
							</td>
						</tr>
					</pg:list>
				</pg:pager>
		  </table>
		</form>
	</body>
</html>


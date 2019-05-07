<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page autoFlush="true" %>
<%@ page import="com.chinacreator.security.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
 	cmsManager.init(request,session,response,accesscontroler);
 	String currentSiteid = cmsManager.getSiteID();
 	session.setAttribute("currentSiteid",currentSiteid);
 	
 	CMSSearchManager sm = new CMSSearchManager();
%>
<html>
<head>
<title>ȫ�ļ�������</title>
<tab:tabConfig/>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
<script language="JavaScript">
    //�������ڶ���
	var win = null;
	//�رն�������
	function closewin()
	{
		win.close();
	}
	function startLocalIndex(indexFlag,indexId){		//��ʼ���������뽨����������ҳ�棬��ʼ������̨�̡߳�
		//indexFlagΪ0��ʾ��վ������Ϊ2��ʾ��վ��Ƶ����������,1��ʾ�����Ķ�ָ��վ��Ƶ����������
		if(indexFlag == 0){
			myform.action = "localcrawler.jsp?indexFlag=0&siteId=<%=currentSiteid%>";
			myform.target = "crawlerFrame";
			myform.submit();
		}else if(indexFlag == 2){
			myform.action = "localcrawler.jsp?indexFlag=2&siteId=<%=currentSiteid%>&indexId=" + indexId;
			myform.target = "crawlerFrame";
			myform.submit();
		}else if(indexFlag == 1){
			if(haveSelect('siteIndexID')){
				myform.action = "localcrawler.jsp?indexFlag=1&siteId=<%=currentSiteid%>";
				myform.target = "crawlerFrame";
				myform.submit(); 
			}else{
				alert("������Ҫѡ��һ��������");
			}
		}
	}
	function startSitesIndex(indexFlag,indexId){		//��ʼ���������뽨����������ҳ�棬��ʼ������̨�̡߳�
		//Ϊ2��ʾ��ָ��վȺ��������,1��ʾ�����Ķ�ָ��վȺ��������
		if(indexFlag == 2){
			myform.action = "sitescrawler.jsp?indexFlag=2&siteId=<%=currentSiteid%>&indexId=" + indexId;
			myform.target = "crawlerFrame";
			myform.submit();			
		}else if(indexFlag == 1){
			if(haveSelect('sitesIndexID')){
				myform.action = "sitescrawler.jsp?indexFlag=1&siteId=<%=currentSiteid%>";
				myform.target = "crawlerFrame";
				myform.submit();
			}else{
				alert("������Ҫѡ��һ��������");
			}
		} 
		
	}
	function startWebIndex(indexFlag,indexId){
		//Ϊ2��ʾ��ָ��վ��վ���������,1��ʾ�����Ķ�ָ��վ��վ�㽨������
		if(indexFlag == 2){
			myform.action = "webcrawler.jsp?indexFlag=2&siteId=<%=currentSiteid%>&indexId=" + indexId;
			myform.target = "crawlerFrame";
			myform.submit();
			
		}else if(indexFlag == 1){
			if(haveSelect('webIndexID')){
				myform.action = "webcrawler.jsp?indexFlag=1&siteId=<%=currentSiteid%>";
				myform.target = "crawlerFrame";
				myform.submit();
			}else{
				alert("������Ҫѡ��һ��������");
			}
		} 
		
	}
	
	function startDBIndex(indexFlag,indexId){
		//Ϊ2��ʾ��ָ������������,1��ʾ�����ĶԿ��������
		if(indexFlag == 2){
			myform.action = "dbcrawler.jsp?indexFlag=2&siteId=<%=currentSiteid%>&indexId=" + indexId;
			myform.target = "crawlerFrame";
			myform.submit();			
		}else if(indexFlag == 1){
			if(haveSelect('dbIndexID')){
				myform.action = "dbcrawler.jsp?indexFlag=1&siteId=<%=currentSiteid%>";
				myform.target = "crawlerFrame";
				myform.submit();
			}else{
				alert("������Ҫѡ��һ��������");
			}
		} 
	}
	
	//�༭����
	function editIndex(indexId){
		
		var re = openWin("editIndex.jsp?siteId=<%=currentSiteid%>&indexId="+indexId,600,450);
		if(re == "cf"){
			var str = document.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			document.location.href = strArray+"?"+document.all.queryString.value;
		}
	}
	function addIndex(flag){
		var re = openWin("addIndex.jsp?siteId=<%=currentSiteid%>&flag="+flag,600,450);
		if(re == "cf"){
			var str = document.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			document.location.href = strArray+"?"+document.all.queryString.value;
		}
	}
	//flag Ϊ1��ʾվ��������Ϊ0��ʾվ������
	function deleteIndex(flag){		
		if((flag == "0" && haveSelect('siteIndexID')) || (flag == "1" && haveSelect('webIndexID')) || (flag == "3" && haveSelect('sitesIndexID')) || (flag == "4" && haveSelect('dbIndexID'))){
			if(confirm("ȷ��ɾ��?")){
				myform.action = "indexHandle.jsp?siteId=<%=currentSiteid%>&action=delete&flag=" + flag;
				myform.target = "crawlerFrame";
				myform.submit();
				win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
				
			}	
			else{
				return false;
			}
		}else{
			alert("������Ҫѡ��һ��������");
		}
		
	}
	//ǿ��ɾ�������ļ�
	function deleteIndexFile(flag){
		if((flag == "0" && haveSelect('siteIndexID')) || (flag == "1" && haveSelect('webIndexID')) || (flag == "3" && haveSelect('sitesIndexID')) || (flag == "4" && haveSelect('dbIndexID'))){
			if(confirm("ȷ��ɾ��?")){
				myform.action = "indexHandle.jsp?siteId=<%=currentSiteid%>&action=deleteFile&flag=" + flag;
				myform.target = "crawlerFrame";
				myform.submit();
				//ˢ��ҳ��
				win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
			}
		}else{
			alert("������Ҫѡ��һ��������");
		}
	}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" bottommargin=0 rightmargin-0 leftmargin=0 topmargin="0">
<form method="post" name="myform">
<table border="0" width="100%" cellspacing="0" cellpadding="0" align="center" >
  <tr valign="middle" align="center">     
    <td colspan="2" width="99%"  >
	  <tab:tabContainer id="foo-extfield-add" selectedTabPaneId="foo-extfield">
	  <tab:tabPane id="webSearch" tabTitle="վ������">
		<table bordercolor="#B7CBE4"  class="Datalisttable" width="100%">
		  			<tr>
						<td height='25' colspan="10" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
						<div  class="DocumentOperT">������</div>				
							<a style="cursor:hand" onClick="addIndex(1)" style="cursor:hand"><div class="DocumentOper"><img 
										src="../images/new_doc.gif" class="operStyle">����</div></a>
							<a style="cursor:hand" onClick="deleteIndex(1)" style="cursor:hand"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ������</div></a>
 							<a style="cursor:hand" onClick="deleteIndexFile(1)"><div class="DocumentOper"><img  
 										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ���ļ�</div></a>  
							<a style="cursor:hand" onClick="startWebIndex(1,'')" style="cursor:hand"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">��ʼ����</div></a>
						</td>
					</tr>
	  				<pg:listdata dataInfo="CMSWebSearchIndexList" keyName="CMSWebSearchIndexList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="CMSWebSearchIndexList" isList="false">
						<tr class="cms_report_tr">
							<!--���÷�ҳ��ͷ-->
	
							<td width="3%" height='30' align=center style="width:3%">
								<input  class="checkbox" type="checkBox" hideFocus=true name="webCheckBoxAll" onClick="checkAll('webCheckBoxAll','webIndexID')">					  </td>
							<td width="8%">������</td>
							<td width="22%">������</td>
							<td width="20%">��ʼ��</td>
							<td width="8%">����Ƶ��</td>
							<td width="8%">��������</td>
							<td width="6%">��ʼʱ��</td>							
							<!-- <td width="10%">������Ŀ¼</td>-->
							<td width="3%"><img src="../../templateManage/images/lock.gif"></td>
							<td width="12%">����</td>
						</tr>
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
								<td colspan=100 align='center'>
									��ûվ��������¼							</td>
							</tr>
						</pg:notify>
	
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								int indexId = dataSet.getInt("id");
								int lever = dataSet.getInt("lever");
								int day = dataSet.getInt("day");
								int time = dataSet.getInt("time");
															
								String[] LDTDes = sm.getIndexLDTDes(lever,day,time);
								String leverDes = LDTDes[0];
								String dayDes = LDTDes[1];
								String timeDes = LDTDes[2];
								
								boolean islocked = sm.isIndexLocked(sm.getIndex(indexId+""));
							%>
							<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'" id="<%=indexId%>">
								
								<td class="tablecells" align=center height='30'>
									<input   class="checkbox" hideFocus onClick="checkOne('webCheckBoxAll','webIndexID')" type="checkbox" name="webIndexID" value="<%=indexId%>">
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="indexName" defaultValue="" />
								</td>
								<td class="tablecells"  align="left" style="word-wrap:break-word;word-break:break-all;">
									<pg:cell colName="domainUrl" defaultValue="" />
								</td>
								<td class="tablecells"  align="left" style="word-wrap:break-word;word-break:break-all;">
									<pg:cell colName="startUrl" defaultValue="" />
								</td>
								<td class="tablecells" align="center">
									<%=leverDes%>
								</td>
								<td class="tablecells"  align="center">
									<%=dayDes%>
								</td>
								<td class="tablecells"  align="center">
									<%=timeDes%>
								</td>
								<!-- <td class="tablecells"  align="left">
									<pg:cell colName="indexPath" defaultValue="" />
								</td>-->
								<td class="tablecells"  align="left">
									<%if(islocked){%>
										<img src="../../templateManage/images/lock.gif">
									<%}%>
								</td>
								<td class="tablecells"  align="center">
									<font color="blue"><a style="cursor:hand" onclick="editIndex('<%=indexId%>')">�޸�</a></font> | <font color="blue"><a style="cursor:hand" onclick="startWebIndex(2,'<%=indexId%>')">��ʼ����</a></font>
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
					</pg:pager>
			</table>
	  </tab:tabPane>
	  <tab:tabPane id="siteSearch" tabTitle="վ������">
	  		<table bordercolor="#B7CBE4"  class="Datalisttable" width="100%">
		  			<tr>
						<td height='25' colspan="10" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
						<div  class="DocumentOperT">������</div>				
							<a style="cursor:hand" onClick="addIndex(0)"><div class="DocumentOper"><img 
										src="../images/new_doc.gif" class="operStyle">����</div></a>
							<a style="cursor:hand" onClick="deleteIndex(0)"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ������</div></a> 
 							<a style="cursor:hand" onClick="deleteIndexFile(0)"><div class="DocumentOper"><img  
 										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ���ļ�</div></a> 
							<a style="cursor:hand" onClick="startLocalIndex(1,'')"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">��ʼ����</div></a>
							<!-- 
							<a style="cursor:hand" onClick="startLocalIndex(0,'')"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">��վ����</div></a>
							-->
						</td>
					</tr>
	  				<pg:listdata dataInfo="CMSSiteSearchIndexList" keyName="CMSSiteSearchIndexList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="CMSSiteSearchIndexList" isList="false">
						<tr class="cms_report_tr">
							<!--���÷�ҳ��ͷ-->
	
							<td width="6%" height='30' align=center >
								<input  class="checkbox" type="checkBox" hideFocus=true name="siteCheckBoxAll" onClick="checkAll('siteCheckBoxAll','siteIndexID')">					  </td>
							<td width="8%">������</td>
							<td width="10%">�������</td>
							<td width="17%">վ������</td>
							<td width="17%">Ƶ������</td>
							<td width="8%">����Ƶ��</td>
							<td width="10%">��������</td>
							<td width="9%">��ʼʱ��</td>							
							<!-- <td width="15%">������Ŀ¼</td>-->
							<td width="3%"><img src="../../templateManage/images/lock.gif"></td>
							<td width="12%">����</td>
						</tr>
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
								<td colspan=100 align='center'>
									��ûվ��������¼							</td>
							</tr>
						</pg:notify>
	
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								int searchType0 = dataSet.getInt("searchType");
								String searchTypeStr0 = "վ��Ƶ������";
								if(searchType0 == 2)
									searchTypeStr0 = "��վ����";
								
								int indexId0 = dataSet.getInt("id");
								int lever0 = dataSet.getInt("lever");
								int day0 = dataSet.getInt("day");
								int time0 = dataSet.getInt("time");
															
								String[] LDTDes0 = sm.getIndexLDTDes(lever0,day0,time0);
								String leverDes0 = LDTDes0[0];
								String dayDes0 = LDTDes0[1];
								String timeDes0 = LDTDes0[2];
								
								boolean islocked0 = sm.isIndexLocked(sm.getIndex(indexId0+""));
							%>
							<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'" id="<%=indexId0%>">
								
								<input type="hidden" name="chnlId" value="<pg:cell colName="chnlId" defaultValue="" />">
								
								<td class="tablecells" align=center height='30'>
									<input   class="checkbox" hideFocus onClick="checkOne('siteCheckBoxAll','siteIndexID')" type="checkbox" name="siteIndexID" value="<%=indexId0%>">
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="indexName" defaultValue="" />
								</td>
								<td class="tablecells"  align="center">
									<%=searchTypeStr0%>
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="siteName" defaultValue="" />
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="chnlName" defaultValue="" />
								</td>
								<td class="tablecells" align="center">
									<%=leverDes0%>
								</td>
								<td class="tablecells"  align="center">
									<%=dayDes0%>
								</td>
								<td class="tablecells"  align="center">
									<%=timeDes0%>
								</td>								
								<!-- <td class="tablecells"  align="center">
									<pg:cell colName="indexPath" defaultValue="" />
								</td>-->
								<td class="tablecells"  align="left">
									<%if(islocked0){%>
										<img src="../../templateManage/images/lock.gif">
									<%}%>
								</td>
								<td class="tablecells"  align="center">
									<font color="blue"><a style="cursor:hand" onclick="editIndex('<%=indexId0%>')">�޸�</a></font> | <font color="blue"><a style="cursor:hand" onclick="startLocalIndex(2,'<%=indexId0%>')">��ʼ����</a></font>
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
					</pg:pager>
			</table>
	  </tab:tabPane>

	  <tab:tabPane id="sitesSearch" tabTitle="վȺ����">
	  		<table bordercolor="#B7CBE4"  class="Datalisttable" width="100%">
		  			<tr>
						<td height='25' colspan="10" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
						<div  class="DocumentOperT">������</div>				
							<a style="cursor:hand" onClick="addIndex(3)"><div class="DocumentOper"><img 
										src="../images/new_doc.gif" class="operStyle">����</div></a>
							<a style="cursor:hand" onClick="deleteIndex(3)"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ������</div></a> 
 							<a style="cursor:hand" onClick="deleteIndexFile(3)"><div class="DocumentOper"><img  
 										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ���ļ�</div></a> 
							<a style="cursor:hand" onClick="startSitesIndex(1,'')"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">��ʼ����</div></a>
						</td>
					</tr>
	  				<pg:listdata dataInfo="CMSSitesSearchIndexList" keyName="CMSSitesSearchIndexList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="CMSSitesSearchIndexList" isList="false">
						<tr class="cms_report_tr">
							<!--���÷�ҳ��ͷ-->
	
							<td width="6%" height='30' align=center >
								<input  class="checkbox" type="checkBox" hideFocus=true name="sitesCheckBoxAll" onClick="checkAll('sitesCheckBoxAll','sitesIndexID')">					  </td>
							<td width="8%">������</td>
							<td width="10%">վ������</td>
							<td width="8%">����Ƶ��</td>
							<td width="10%">��������</td>
							<td width="6%">��ʼʱ��</td>							
							<!-- <td width="15%">������Ŀ¼</td>-->
							<td width="3%"><img src="../../templateManage/images/lock.gif"></td>
							<td width="12%">����</td>
						</tr>
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
								<td colspan=100 align='center'>
									��ûվ��������¼							</td>
							</tr>
						</pg:notify>
	
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								int searchType1 = dataSet.getInt("searchType");
								String searchTypeStr1 = "Ƶ������";
								if(searchType1 == 2)
									searchTypeStr1 = "��վ����";
								
								int indexId1 = dataSet.getInt("id");
								int lever1 = dataSet.getInt("lever");
								int day1 = dataSet.getInt("day");
								int time1 = dataSet.getInt("time");
															
								String[] LDTDes1 = sm.getIndexLDTDes(lever1,day1,time1);
								String leverDes1 = LDTDes1[0];
								String dayDes1 = LDTDes1[1];
								String timeDes1 = LDTDes1[2];
								
								boolean islocked1 = sm.isIndexLocked(sm.getIndex(indexId1+""));
							%>
							<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'" id="<%=indexId1%>">
								
								<td class="tablecells" align=center height='30'>
									<input   class="checkbox" hideFocus onClick="checkOne('sitesCheckBoxAll','sitesIndexID')" type="checkbox" name="sitesIndexID" value="<%=indexId1%>">
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="indexName" defaultValue="" />
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="siteNames" defaultValue="" />
								</td>
								<td class="tablecells" align="center">
									<%=leverDes1%>
								</td>
								<td class="tablecells"  align="center">
									<%=dayDes1%>
								</td>
								<td class="tablecells"  align="center">
									<%=timeDes1%>
								</td>								
								<!-- <td class="tablecells"  align="center">
									<pg:cell colName="indexPath" defaultValue="" />
								</td>-->
								<td class="tablecells"  align="left">
									<%if(islocked1){%>
										<img src="../../templateManage/images/lock.gif">
									<%}%>
								</td>
								<td class="tablecells"  align="center">
									<font color="blue"><a style="cursor:hand" onclick="editIndex('<%=indexId1%>')">�޸�</a></font> | <font color="blue"><a style="cursor:hand" onclick="startSitesIndex(2,'<%=indexId1%>')">��ʼ����</a></font>
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
					</pg:pager>
			</table>
	  </tab:tabPane>
	  
	  <tab:tabPane id="dbSitesSearch" tabTitle="���ݿ�����">
	  		<table bordercolor="#B7CBE4"  class="Datalisttable" width="100%">
		  			<tr>
						<td height='25' colspan="10" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
						<div  class="DocumentOperT">������</div>				
							<a style="cursor:hand" onClick="addIndex(4)"><div class="DocumentOper"><img 
										src="../images/new_doc.gif" class="operStyle">����</div></a>
							<a style="cursor:hand" onClick="deleteIndex(4)"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ������</div></a> 
 							<a style="cursor:hand" onClick="deleteIndexFile(4)"><div class="DocumentOper"><img  
 										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">ɾ���ļ�</div></a> 
							<a style="cursor:hand" onClick="startDBIndex(1,'')"><div class="DocumentOper"><img 
										class="operStyle" src="<%=request.getContextPath()%>/cms/images/ico_point.gif">��ʼ����</div></a>
						</td>
					</tr>
	  				<pg:listdata dataInfo="CMSDBTSearchIndexList" keyName="CMSDBTSearchIndexList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="CMSDBTSearchIndexList" isList="false">
						<tr class="cms_report_tr">
							<!--���÷�ҳ��ͷ-->
	
							<td width="6%" height='30' align=center >
								<input  class="checkbox" type="checkBox" hideFocus=true name="dbCheckBoxAll" onClick="checkAll('dbCheckBoxAll','dbIndexID')">					  </td>
							<td width="8%">������</td>
							<td width="10%">���ݿ�</td>
							<td width="10%">������</td>
							<td width="8%">����Ƶ��</td>
							<td width="10%">��������</td>
							<td width="6%">��ʼʱ��</td>							
							<!-- <td width="15%">������Ŀ¼</td>-->
							<td width="3%"><img src="../../templateManage/images/lock.gif"></td>
							<td width="12%">����</td>
						</tr>
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr  class="labeltable_middle_tr_01" onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'">
								<td colspan=100 align='center'>
									��ûվ��������¼							</td>
							</tr>
						</pg:notify>
	
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								int searchType2 = dataSet.getInt("searchType");
								
								int indexId2 = dataSet.getInt("id");
								int lever2 = dataSet.getInt("lever");
								int day2 = dataSet.getInt("day");
								int time2 = dataSet.getInt("time");
															
								String[] LDTDes2 = sm.getIndexLDTDes(lever2,day2,time2);
								String leverDes2 = LDTDes2[0];
								String dayDes2 = LDTDes2[1];
								String timeDes2 = LDTDes2[2];
								
								boolean islocked2 = sm.isIndexLocked(sm.getIndex(indexId2 + ""));
							%>
							<tr class="cms_data_tr"  onMouseOver="this.style.background='#E9EDF3'" onMouseOut="this.style.background='#FFFFFF'" id="<%=indexId2%>">
								
								<td class="tablecells" align=center height='30'>
									<input   class="checkbox" hideFocus onClick="checkOne('dbCheckBoxAll','dbIndexID')" type="checkbox" name="dbIndexID" value="<%=indexId2%>">
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="indexName" defaultValue="" />
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="db_name" defaultValue="" />
								</td>
								<td class="tablecells"  align="center">
									<pg:cell colName="table_name" defaultValue="" />
								</td>
								<td class="tablecells" align="center">
									<%=leverDes2%>
								</td>
								<td class="tablecells"  align="center">
									<%=dayDes2%>
								</td>
								<td class="tablecells"  align="center">
									<%=timeDes2%>
								</td>								
								<!-- <td class="tablecells"  align="center">
									<pg:cell colName="indexPath" defaultValue="" />
								</td>-->
								<td class="tablecells"  align="left">
									<%if(islocked2){%>
										<img src="../../templateManage/images/lock.gif">
									<%}%>
								</td>
								<td class="tablecells"  align="center">
									<font color="blue"><a style="cursor:hand" onclick="editIndex('<%=indexId2%>')">�޸�</a></font> | <font color="blue"><a style="cursor:hand" onclick="startDBIndex(2,'<%=indexId2%>')">��ʼ����</a></font>
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
					</pg:pager>
			</table>
	  </tab:tabPane>

	  </tab:tabContainer>
	</td>      
  </tr>    
</table> 
</form> 
<div style="display:none;"> 
<iframe width=0 height=0 name="crawlerFrame"></iframe>   
</div> 
</body>     
</html> 

<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	String channelname = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	//System.out.println(channelname);
	//System.out.println(siteid);
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteName(siteid);
				
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>���ݹ��������</title>
<script src="inc/js/func.js"></script>
<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<script language="javascript" >
 	function checkAll(totalCheck,checkName){	//��ѡ��ȫ��ѡ��
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   }
	}
	//����ѡ�и�ѡ��
	function checkOne(totalCheck,checkName){
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}		
	
	function queryUser()
	{	
		//��ѯ
		form1.action="<%=rootpath%>/cms/docManage/garbage_list.jsp?flag=1&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"
		form1.submit();	
	}
	
	//��ԭ�ĵ�
		function dealRecord(dealType) {
	    var isSelect = false;
	    var outMsg;
	    
	    for (var i=0;i<form1.elements.length;i++) {
			var e = form1.elements[i];
			
			if (e.name == 'ID'){
				if (e.checked){
			       		isSelect=true;
			       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫ��ԭ��ѡ�ĵ���";
	        	if (confirm(outMsg)){
	        	form1.action="<%=rootpath%>/cms/channelManage/delete_doc.jsp?flag=2&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>";
				form1.submit();
		 		return true;
			    }
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
  		return false;
	}
		//����ɾ���ĵ�
		function deletedoc(dealType) {
	    var isSelect = false;
	    var outMsg;
	    
	    for (var i=0;i<form1.elements.length;i++) {
			var e = form1.elements[i];
			
			if (e.name == 'ID'){
				if (e.checked){
			       		isSelect=true;
			       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫɾ����ѡ�ĵ���(ɾ�����ǲ������ٻָ���)��";
	        	if (confirm(outMsg)){
	        	form1.action="<%=rootpath%>/cms/channelManage/delete_doc.jsp?flag=1&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>&list=1";
				form1.submit();
		 		return true;
			    }
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
  		return false;
	}
</script>
<style type="text/css">
<!--
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
-->
</style></head>

<body topmargin="3" rightmargin="0">
<form id="form1" name="form1" method="post" action="">
<table width="100%" border="0"   cellpadding="3" align="center" cellspacing="0">
  <tr>
    <td height="82" valign=top background="../images/pagebar.jpg" style="background-repeat:no-repeat">
    <table width="100%" border="0">
      <tr>
        <td height="23">&nbsp;&nbsp;&nbsp;&nbsp; ��ǰλ��:<%=sitename%>վ��  >>  <%=channelname%>Ƶ��</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
	   <tr>
       <td >
	   
	      <div align="right"><a href="<%=rootpath%>/cms/channelManage/channel_doc_list.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>&title=null&doclevel=null&status=null&doclevel=null&status=null&flag=2">����</a>|  <a href="/creatorcms/cms/main.jsp">��ӭҳ</a></div></td>
       </tr>
    </table>
    </td>
  </tr>
<tr>
    <td  height="483" valign=top background="images/tile.jpg" bgcolor="#FFFFFF">
  <table class="mhwz_table" width="98%" align=center><tr><td> 
  <table width="100%" border="0" align="center" class="">
         				
         				
         				
         				<tr >
         					
           				    <td width="11%" height='30' align="center" valign='middle'>�ĵ����⣺</td>
       					    <td width="11%" height='30' align="center" valign='middle'>
       					   		 <div align="left">
       					   		   <input type="text" size="10" name="title" >
			   		      </div></td>
           					<td width="11%"  height='30' align="center" valign='middle'>�����ˣ�</td>
           					<td width="11%"  height='30' align="left" valign='middle'>
           					 	 <input type="text" size="10" name="userid" >
							</td>
           					<td width="11%"  height='30' align="center" valign='middle'>�ĵ�����:</td>
           					<td width="39%"  height='30' align="center" valign='middle'>
	           					 <div align="left">
	           					   <select name="doctype">
           					         <option value=""></option>
           					         <option value="0">��ͨ�ĵ�</option>
           					         <option value="1">�ⲿ����</option>
           					         <option value="2">�ⲿ�ļ�</option>
       					           </select>
   					          </div></td>
           					<td width="1%"  height='30' align="center"valign='middle'>&nbsp;	
           					</td>
           					<td width="5%"  height='30' align="left"valign='middle'>&nbsp;
           					</td>
         				</tr>
						
         				<tr >
         					
           				    <td height='30'valign='middle' align="center">�ĵ�״̬��</td>
           					<td height='30'valign='middle' align="left">
           					<select name="status">
           					  <option value=""></option>
           					  <option value="1">�¸�</option>
           					  <option value="2">����</option>
           					  <option value="3">����</option>
           					  <option value="4">�ѷ�</option>
           					  <option value="5">�ѻ���</option>
           					  <option value="6">�ѹ鵵</option>
                             </select></td>
           					<td  height='30'valign='middle' align="center">���ȼ���</td>
           					<td  height='30'valign='middle' align="left">
           					
           						 <select name="doclevel">
	           					  <option value=""></option>
	           					  <option value="0">��ͨ</option>
	           					  <option value="1">�߼�</option>
	           					  <option value="2">��߼�</option>
           					  </select>
           					</td>
           					<td  height='30' colspan="4" align="center"valign='middle'>
           						 <div align="right">
        					       <input name="search" type="button" class="cms_button" value="��ѯ" onClick="queryUser()">
<!--        					       <input type="button" value="��ԭ��ѡ�ĵ�" class="cms_button"-->
<!--									onclick="javascript:dealRecord(1); return false;">-->
<!--									 <input type="button" value="ɾ����ѡ�ĵ�" class="cms_button"-->
<!--									onclick="javascript:deletedoc(1); return false;">		-->
<!--         					       </div>-->
       					  </td>
       					</tr>
						<tr>
         					<td  height='30' colspan="2" align="left" valign='middle' class="cms_title_blue"> <%=channelname%>_�Ļ���վ�б�
         					</td>
       					    <td  height='30' colspan="6" align="left" valign='middle'>
							  <a  style="cursor:hand" onClick="javascript:dealRecord(1); return false;"><u><img src="../images/del.gif">��ԭ��ѡ�ĵ�</u></a>
         					  <a  style="cursor:hand" onClick="javascript:deletedoc(1); return false;"><u><img src="../images/del.gif">ɾ����ѡ�ĵ�</u></a>         					
							</td>
   					    </tr>
   			  </table>
     			</td></tr></table>    			
         			
         				
						<table  width="100%" border="1" align=center cellpadding="3" cellspacing="0" class="Datalisttable">
         				<pg:listdata dataInfo="Doc_GarbageList" keyName="Doc_GarbageList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="10" scope="request" data="Doc_GarbageList" isList="false">
							<tr class="cms_report_tr">
								<!--���÷�ҳ��ͷ-->
								
								 <td width="5%" align=center>
								  	<input class="checkbox" type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
								 </td>
								<td   width="11%" >�ĵ�����</td>
								
								<td   width="40%" >�ĵ�����</td>
								<td   width="8%" >����Ƶ��</td>
								<td   width="8%" >״̬</td>								
								<td   width="10%" >������</td>
								<td   width="8%" >����</td>
								<td   width="10%" >��������</td>
							</tr>
					
							<pg:param name="title" />
							<pg:param name="doclevel" />
							<pg:param name="status" />
							<pg:param name="userid" />
							<pg:param name="doctype" />
							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'> �û���վ��ʱû���ĵ� </td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								
								<tr class="cms_data_tr">
									<td class="tablecells" align=center><input class="checkbox" onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="document_id" defaultValue=""/>"></td>					

									<td  class="tablecells" align=center>
										<pg:equal colName="doctype" value="0"><div align="center"><img  title="HTML�ĵ�" src="../images/doc_html.gif" width="20" height="20"></div>
										</pg:equal>
										<pg:equal colName="doctype" value="1"><div align="center"><img  title="�ⲿ���������ĵ�" src="../images/doc_link.gif" width="20" height="20"></div>
										</pg:equal>
										<pg:equal colName="doctype" value="2"><div align="center"><img title="�����ļ�����" src="../images/doc_downloadfile.gif" width="15" height="16"></div>
										</pg:equal>
										
									</td>
								
									<td class="tablecells" nowrap="nowrap">
										<pg:equal colName="doctype" value="0"><a href=/creatorcms/cms/docManage/doc_gather_update.jsp?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>><pg:cell colName="subtitle" defaultValue="" /></a>
										</pg:equal>
										<pg:equal colName="doctype" value="1"><a href=/creatorcms/cms/docManage/doc_gather_links_update.jsp?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>><pg:cell colName="subtitle" defaultValue="" /></a>
										</pg:equal>
										<pg:equal colName="doctype" value="2"><a href=/creatorcms/cms/docManage/doc_gather_filedownload_update.jsp?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>><pg:cell colName="subtitle" defaultValue="" /></a>
										</pg:equal>
									</td>
									<td class="tablecells" nowrap="nowrap" width="16%">
										<%=channelname%>
									</td>
									<td class="tablecells" nowrap="nowrap" width="10%">
										
										<pg:equal colName="status" value="1">�¸�</pg:equal>
										<pg:equal colName="status" value="2">����</pg:equal>
										<pg:equal colName="status" value="3">����</pg:equal>
										<pg:equal colName="status" value="4">�ѷ�</pg:equal>
										<pg:equal colName="status" value="5">�ѻ���</pg:equal>
										<pg:equal colName="status" value="6">�ѹ鵵</pg:equal>
									</td>
									
									<td class="tablecells" nowrap="nowrap" width="10%">
										<pg:cell colName="username" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" width="10%">
										<pg:cell colName="author" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" width="10%">
										<pg:cell colName="createTime" defaultValue="" />
									</td>
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=10 align='center'>��<pg:rowcount/>����¼
									<pg:index />
								</td>
								
					      </tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

	    </table>
 </td></tr>
</table> </form>

</body>
</html>

<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();
%>
<html>
	<head>
		<title></title>

		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">


	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	var schedularID;
	
	
	function modify(checkName){		
		if(!validatecheck(checkName))
		{
			alert("��ѡ��Ҫ�޸ĵ��ճ�");
			return;
		}
		
		if(!validateOnlyCheck(checkName))
		{
			alert("һ��ֻ��ѡ��һ���ճ̽����޸�");
			return;
		}
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=getModifySchedular&path=success";
		document.forms[0].submit();
	}
	function validateOnlyCheck(checkName)
	{
		 var o = document.all.item(checkName);
		 for (var i=0,j=0; o && o.length && i<o.length; i++){
	   	  	if(o[i].checked)
	   	  	{
	   	  		j++;
	   	   	}
	   	   	if(j == 2)
	   	   	{
	   	   		return false;
	   	   	}
	   	   }
		 return true;
	}
	function validatecheck(checkName)
	{
			 var o = document.all.item(checkName);
		for (var i=0; o && o.length && i<o.length; i++){
	   	  	  if(o[i].checked)
	   	  	  	return true;
	   	   }
	   	   if(o && !o.length )
			{
				if(o.checked)
					return true;
			}
			return false;
	}
	function view(checkName){		
		if(!validatecheck(checkName))
		{
			alert("��ѡ��Ҫ�鿴���ճ�");
			return;
		}
		if(!validateOnlyCheck(checkName))
		{
			alert("һ��ֻ��ѡ��һ���ճ̽��в鿴");
			return;
		}
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=getSchedularAndRemind&path=success";
		document.forms[0].submit();
	}
	function history(checkName){
		if(!validatecheck(checkName))
		{
			alert("��ѡ��Ҫ������ʷ���ճ�");
			return;
		}
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=history&path=success";
		document.forms[0].submit();
	}
	function checkAll(totalCheck,checkName){	//��ѡ��ȫ��ѡ��
	   var selectAll = document.all.item(totalCheck);
	   
	   var o = document.all.item(checkName);
	   
	   if(selectAll.checked==true){
		   for (var i=0; o && o.length && i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
		   if(o && !o.length && !o.checked)
			{
				o.checked=true;
			}
		   
	   }else{
		   for (var i=0; o && o.length && i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   	   if(o && !o.length && !o.checked)
			{
				o.checked=false;
			}
	   	   
	   }
	}
	//����ѡ�и�ѡ��
	function checkOne(totalCheck,checkName){
	   var selectAll = document.all.item(totalCheck);
	   var o = document.all.item(checkName);
		var cbs = true;
		
		for (var i=0;o && o.length && i < o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(o && !o.length && !o.checked)
		{
			cbs = false;
		}
		if(cbs){
			selectAll.checked=true;
		}
		else{
			selectAll.checked=false;
		}
	}	
	
	function dealRecord(checkName,dealType) {
	    if(!validatecheck(checkName))
		{
			alert("��ѡ��Ҫɾ�����ճ�");
			return false;
		}
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
	        	if (confirm(outMsg)){
		        	Org.action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=deleteSchedular&path=success";
					Org.submit();
			 		return true;
				}
			} 
	    return false;
	}
	function actionOnmouseover(e){	
		e.style.backgroundColor = "#8080FF";
	}

	function actionOnmouseup(e){
		e.style.backgroundColor = "#BEC0C2";
	}

	
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scrolling="no">
		<div id="contentborder" align="center">
			<FORM name="Org" action="" method="post">
				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<TR>
						<TD height="30" class="detailtitle" align="center" colspan="8">
							<B>�ȴ�ִ�е��ճ��б�</B>
						</TD>
					</TR>
					<pg:listdata dataInfo="SuccessfulSchedularList" keyName="SuccessfulSchedularList" />

					<pg:pager maxPageItems="15" scope="request" data="SuccessfulSchedularList" isList="false">
						<td class="headercolor" width="10">
							<input type="checkBox" name="checkBox" onClick="checkAll('checkBox','ID')">
						</td>
						
						<td class="headercolor">
							����
						</td>
						<td class="headercolor">
							�ص�
						</td>
						<td class="headercolor">
							�ճ̿�ʼʱ��
						</td>
						<td class="headercolor">
							�ճ̽���ʱ��
						</td>
						<td class="headercolor">
							�ճ�����
						</td>
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<td class="tablecells" width="5%" nowrap="nowrap">
									<input type="checkBox" name="ID" onClick="checkOne('checkBox','ID')" value="<pg:cell colName="schedularID" defaultValue=""/>">
								</td>
								
								<td class="tablecells" width="20%" nowrap="nowrap">

									<pg:equal colName="topic" value="">������</pg:equal>
									<pg:cell colName="topic" defaultValue="������" />
								</td>
								<td class="tablecells" width="20%" nowrap="nowrap">

									<pg:equal colName="place" value="">�޵ص�</pg:equal>
									<pg:cell colName="place" defaultValue="�޵ص�" />

								</td>
								<td class="tablecells" width="20%" nowrap="nowrap">

									<pg:equal colName="beginTime" value="">δ����</pg:equal>
									<pg:cell colName="beginTime" dateformat="yyyy-MM-dd HH:mm:ss" defaultValue="δ����" />
								</td>
								<td class="tablecells" width="20%" nowrap="nowrap">

									<pg:equal colName="endTime" value="">δ����</pg:equal>
									<pg:cell colName="endTime" dateformat="yyyy-MM-dd HH:mm:ss" defaultValue="δ����" />
								</td>
								<td class="tablecells" width="15%" nowrap="nowrap">
									<pg:equal colName="type" value="">���Ͳ�ȷ��</pg:equal>
									<pg:cell colName="type" defaultValue="��" />
								</td>

							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=6 align='center' nowrap="nowrap">
								<pg:index />
								<input type="submit" class="input" value="ɾ���ճ�" onclick="javascript:dealRecord('ID',1); return false;">
								<INPUT type="button" class="input" name="viewSD" value="�鿴�ճ�" onclick="view('ID')">
								<INPUT type="button" class="input" name="modifySD" value="�޸��ճ�" onclick="modify('ID')">
								
							</td>
						</tr>
						<input name="queryString" value="<pg:querystring/>" type="hidden">
					</pg:pager>
				</TABLE>
			</FORM>
		</div>
			<%@include file="sysMsg.jsp" %>
	</body>
</html>

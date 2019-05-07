
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
	AccessControl accesscontroler = AccessControl.getInstance();
	if(!accesscontroler.checkAdminAccess(request, response)){
		return;	
	}
	
	//��ȡ����Դ����
	String db = (String) request.getParameter("db");
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
			function addKeyInfo()
			{
				winuser = window.showModalDialog("addtableinfo.jsp?db=<%=db%>",
										 window,"dialogWidth:"+(650)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no");
				
					window.location.href = window.location.href ;
				
			}
			
			function updateKeyInfo()
			{
				
				var obj = document.getElementsByName("checkboxOne");
				
				var size = 0;
				var tablename = "";
				
				if(obj)
				{
					for(var i=0; i<obj.length; i++)
					{
						if(obj[i].checked)
						{
							size ++;
							tablename = obj[i].value ;
						}		
					}
				}
				
				if(size == 0)
				{
					alert("��ѡ��Ҫ�޸ĵļ�¼!");
					return false ;
				}
				else if(size > 1)
				{
					alert("ÿ��ֻ���޸�һ����¼!");
					return false ;
				}
				
				winuser = window.showModalDialog("updatetableinfo.jsp?db=<%=db%>&tablename=" + tablename,window,"dialogWidth:"+(600)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no");
				
					window.location.href = window.location.href ;
			}
			
			
			
			function checkAll(totalCheck,checkName)
			{	//��ѡ��ȫ��ѡ��
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
			   if(selectAll[0].checked==true)
			   {
				   for (var i=0; i<o.length; i++)
				   {
			      	  if(!o[i].disabled)
			      	  {
			      	  	o[i].checked=true;
			      	  }
				   }
			   }
			   else
			   {
				   for (var i=0; i<o.length; i++)
				   {
			   	  	  o[i].checked=false;
			   	   }
			   }
			}
			
			//����ѡ�и�ѡ��
			function checkOne(totalCheck,checkName)
			{
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++)
				{
					if(!o[i].disabled){
						if (o[i].checked==false)
						{
							cbs=false;
						}
					}
				}
				if(cbs)
				{
					selectAll[0].checked=true;
				}
				else
				{
					selectAll[0].checked=false;
				}
			}	
			
				
			//ɾ������
			function dealKeyInfo()
			{
			    
			    var obj = document.getElementsByName("checkboxOne");
			    var size = 0;
			    
			    if(obj)
			    {
			    	for(var i=0; i<obj.length; i++)
			    	{
			    		if(obj[i].checked)
			    		{
			    			size ++ ;	
			    		}
			    	}
			    }
			    
			    if (size > 0)
			    {
			    	
			    	var msg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)";
		        	if(confirm(msg))
		        	{    
		        		
			            tableInfoOpForm.action = "deletetableinfo.jsp?db=<%=db%>";
			            tableInfoOpForm.target = "hiddenFrame";
						tableInfoOpForm.submit();
			        } 
			    }
			    else
			    {
			    	alert("����Ҫѡ��һ����¼��");
			    	return false;
			   }
			}
		</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<form action="" method="post" name="tableInfoOpForm">
			<div align="left">
				<input name="button" type="button" class="input"
	                                onclick="addKeyInfo()" value="����">&nbsp;
				<input type="button" value="�޸�" class="input"
									onclick="updateKeyInfo()">&nbsp;
								  
				<input name="button" type="button" class="input"
									onclick="dealKeyInfo()" value="ɾ��ѡ����">&nbsp;	
			</div>
			
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
				<pg:listdata dataInfo="com.chinacreator.dbmanager.TableInfoSearchList" keyName="TableInfoSearchList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="15" scope="request" data="TableInfoSearchList" isList="false">
					<tr class="labeltable_middle_td">
						<!--���÷�ҳ��ͷ-->
						<td class="headercolor" align=center>
			  				<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkboxOne')">
			  			</td>
			    		<td height='20' class="headercolor">������</td>
			    		<input class="text" type="hidden" name="selectId">
						<td height='20' class="headercolor">�ؼ�����</td>
						<td height='20' class="headercolor">����������</td>
						<td height='20' class="headercolor">������ǰֵ</td>
						<td height='20' class="headercolor">�Զ�������</td>
						<td height='20' class="headercolor">�ؼ�������</td>
						<td height='20' class="headercolor">�ؼ���ǰ׺</td>
				</tr>
					<pg:param name="tableName"/>
					<pg:param name="keyName"/>
					<pg:param name="keyType"/>
					<pg:param name="db"/>
					
					<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû����Ϣ
								</td>
							</tr>
						</pg:notify>

						<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
							<td class="tablecells" align=center>
								<input onClick="checkOne('checkBoxAll','checkboxOne')" type="checkbox" name="checkboxOne" value="<pg:cell colName="tableName" defaultValue=""/>">
							</td>						      				
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="tableName" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="tableKeyName" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyIncrement" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="currentKeyValue" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyGenerator" defaultValue=""/>
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyType" defaultValue=""/>
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyPrefix" defaultValue=""/>
							</td>
							
						</tr>
					</pg:list>
					<tr height="30" class="labeltable_middle_tr_01">
						<td colspan=100 align='center'>
						  ��<pg:rowcount/>����¼&nbsp;&nbsp;<pg:index />
						<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
					</tr>
				</pg:pager>
			</table>
		</form>
		<iframe src="" name="hiddenFrame" width="0" height="0"></iframe>
	</body>
</html>

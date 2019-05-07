<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
	//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
	boolean isAdminOrOrgManager = false;
	//�Ƿ��ǹ���Ա
	boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
	boolean isAdmin = accessControl.isAdmin();
	if(isAdmin || isOrgManager){
		isAdminOrOrgManager = true;
	}	
	
	
	
	//Ӧ���ɵ�ǰ��Ӧ��id��ö�Ӧ�Ĳ˵��ļ���Ϣ����ģ���id��ö�Ӧ�Ĳ˵�����Ϣ
	//�Ӳ˵���id
	String itemId = StringUtil.replaceNull(request
			.getParameter("id"));
	//���˵���id
	String moduleId = StringUtil.replaceNull(request
			.getParameter("resId"));
%>
<html>
	<head>
		<title>��������</title>
		<script language="JavaScript" src="changeView.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	<%@ include file="/epp/css/cssControl.jsp"%>
	<script language="javascript">
	
		function openWin(url,swidth,sheight){
			var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");			
			return w;
		}
	
		function reclaimOrgUserRes(){
		    //openWin("../../reclaimManager/reclaimOrgUserRes.jsp?orgId=" + orgId,500,400);
		    //document.write("test");
		    var aa = window.showModalDialog("../../testpage/test1.jsp?jobId=2",
										 window,"dialogWidth:"+(850)+"px;dialogHeight:"+(520)+"px;help:no;scroll:auto;status:no");
			alert("aa="+aa);
		}
		//�������˵�
		function addmodule()
		{
			var ww = openWin('../../epp/menuconfigure/addmodule.jsp',screen.availWidth-320,screen.availHeight-240)
			if(ww)
			{								
				parent.location.reload();
				getNavigatorContent().location.reload();
			}
		}
		//�����Ӳ˵�
		function additem(id)
		{
			alert("itemId=<%=itemId%>");
			//var ww = openWin('../../epp/menuconfigure/additemmain.jsp?moduleId=<%=itemId%>',screen.availWidth-320,screen.availHeight-240)
			var ww = openWin('../../epp/menuconfigure/additemmain.jsp?moduleId='+id,screen.availWidth-320,screen.availHeight-240)
			if(ww)
			{
				//Ư����ģ̬����ˢ�·���
				var a = document.createElement("a"); 
				a.href = document.location.href; 
				document.body.appendChild(a); 
				a.click();
				
				document.location.reload();				
				getNavigatorContent().location.reload();
			}
		}
			
		//ɾ��module
		function deletemodule(moduleId)
		{
		alert("moduleId="+moduleId);
			//if(haveSelect('ID'))
			if(moduleId!=null)
			{		
				if(confirm('��ȷ��Ҫɾ����ѡ��ģ�飿��'))
				{								
					document.all.divProcessing.style.display = "block";
					var moduleIds = moduleId;
				  	treeForm.action = "../../epp/menuconfigure/deletemenu_do.jsp?moduleIds="+moduleId;
				    treeForm.target = "hiddenFrame";
				    treeForm.submit();
				}
				else
				{
				  return false;
				}
			
			}else{
		    	alert("��ѡ��Ҫ��ɾ����ģ�飡");
		    	return false;
		   	}
		   	return true;
		}
		//ɾ���Ӳ˵�item
		function deleteitem(itemId)
		{
			//if(haveSelect('ID')){
			if(itemId!=null){
				if(confirm('��ȷ��Ҫɾ����ѡ�Ĳ˵����'))
				{								
					document.all.divProcessing.style.display = "block";
				  	treeForm.action = "../../epp/menuconfigure/deleteitem_do.jsp?itemIds="+itemId;
				    treeForm.target = "hiddenFrame";
				    treeForm.submit();					    	
				}
				else
				{
				  return false;
				}
			
			}else{
		    	alert("��ѡ��Ҫ��ɾ���Ĳ˵��");
		    	return false;
		   	}
		   	return true;
		}
		
		function modifymodule(moduleId)
		{
			var ww = openWin('../../epp/menuconfigure/modifymodule.jsp?moduleId='+moduleId,screen.availWidth-320,screen.availHeight-240);

			if(ww)
			{
				parent.location.reload();
				getNavigatorContent().location.reload();
			}
		}
		
		function modifyitem(itemId,moduleId)
		{			
			var ww = openWin('../../epp/menuconfigure/modifyitem.jsp?moduleId='+moduleId+'&itemId='+itemId,screen.availWidth-320,screen.availHeight-240);
			if(ww)
			{
				//Ư����ģ̬����ˢ�·���
				var a = document.createElement("a"); 
				a.href = document.location.href; 
				document.body.appendChild(a); 
				a.click();
				
				document.location.reload();				
				getNavigatorContent().location.reload();
			}
		}
		
	</script>
	</head>
	<body  class="contentbodymargin" scroll="no">
	<form name="treeForm" action="" method="post">
	<%if(isAdminOrOrgManager){ %>
		<div id="contentborder">				
					<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
						
						
						<tr class="tr">
							<td class="td" width="40%" align="center">
								
							</td>
						</tr>
						<tr class="tr">
							<td class="td">

								<tree:tree tree="role_column_tree" node="role_column_tree.node" 
								imageFolder="../images/tree_images/" collapse="true" includeRootNode="false" 
								href="/sysmanager/menumanager/resMenu_tab.jsp" 
								mode="static-dynamic"
								target="base_properties_content">
									<tree:param name="resTypeId"/>

									<tree:treedata treetype="ColumnTree" scope="request" 
									rootid="0" rootName="�˵�����" expandLevel="1" 
									showRootHref="false" 
									sortable="false"
									needObserver="false" 
									refreshNode="false" 
									enablecontextmenu="true"/>
									
								</tree:tree>
							</td>
						</tr>
					</table>
		

		</div>
		<%}else{ %>
		<div align="center">û��Ȩ�ޣ�</div>
		<%} %>
		
		<div id=divProcessing
				style="width:200px;height:30px;position:absolute;left:250px;top:460px;display:none;">
				<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000"
					width="100%" height="100%">
					<tr>
						<td bgcolor=#3A6EA5>
							<marquee align="middle" behavior="alternate" scrollamount="5">
								<font color=#FFFFFF>...������...��ȴ�...</font>
							</marquee>
						</td>
					</tr>
				</table>
			</div>
			<iframe name="hiddenFrame"></iframe>
		</form>
	</body>
</html>

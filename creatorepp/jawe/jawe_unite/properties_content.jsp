<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
<head>  

	<script src="../../eformsys/fceform/js/fcpub.js"></script>

  <title>��������</title>
   <link rel="stylesheet" type="text/css" href="../../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">

  
  <script type="text/javascript">  	
  	function val_input(input)
  	{
  		//��֤������Ƿ�Ϊ�Ϸ��ַ�
	     var patten=/^[a-zA-Z0-9]+$/;
	  	 if(patten.test(input))
	  	 {
	  		 return true;
	  	 }else
	  	 {
	   	     return false;
	     }
  	}
  	
  	function newXPDL(ec_id,expkgids)
	{	
		var wpf_name=window.prompt("�����벢���������ƣ�");
		if(wpf_name==null||wpf_name=="")
		{
			alert("��û�����벢���������ƣ�");
			return false;
		}
		
		if(!val_input(wpf_name))
		{
			alert("������ֻ�������ַ������֣�");
			return false;
		}
		
		//��֤Ӧ�����Ƿ���ͬ��������
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valPName&pid="+wpf_name);
		if(retX=="false")
		{
			alert("�������Ѿ����ڣ���ʹ����������������");
			return false;
		}
		
		//��Ҫѹ��jar�����������Ƹ��ͻ���
		var zipName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/jawe_unite/down.jsp?expkgids="+expkgids);
		alert(zipName);	
		retx=window.showModalDialog("../xpdl_open.jsp?ec_id="+ec_id+"&op=new&mgrName="+wpf_name+"&expkgids="+expkgids+"&zipName="+zipName);
		if(retx) window.location.reload();
	}
	
	//�޸����̻�����Ϣ add by minghua.guo 090617
  	function editXPDLMes(pId)
	{	
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/xpdl_edit.jsp?pId="+pId,window);
		if(retx=='true') window.location.reload();
	}
	
	function openXpdl(mgrName,pid)
	{
		//������֤�Ƿ��Ѿ���
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valIsOpen&pid="+pid);
		if(retX=="true")
		{
			alert("���ļ��Ѿ��������û���,���Ժ����ԣ�");
			return false;
		}
		var reg=/#/g;
		mgrName=mgrName.replace(reg,"~");
		document.getElementById("divProcessing").style.display="block";
		var _url = "<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id=<%=request.getParameter("ec_id")%>"+"&op=modify&mgrName="+mgrName+"&pid="+pid;
		document.getElementById("myFrame").src=_url;
	}
	
	function showXpdlHistory(pname)
	{
		var retx=window.showModalDialog("../xpdl_history.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=read&pname="+pname,window);
		if(retx) window.location.reload();
	}
	
	function showSubflow(pname)
	{
		var reg = /#/g;
		pname=pname.replace(reg,"~");
		var retx=window.showModalDialog("subflow_list.jsp?pname="+pname);
		if(retx) window.location.reload();
	}
	
	function deleteProcess(forceToDel)
	{
		//ɾ�����̼�¼
		setSelectId();
		var obj1=document.all.selectId;
		if(IsSpace(obj1.value))
		{
		   alert("û��ѡ���κμ�¼��");
		   return false;
		}
		else
		{
			if(forceToDel=='true')
			{
				//ǿ��ɾ��
				if(!window.confirm("���и�ɾ�������Ὣ���н������̵��������ݶ�ɾ��,�Ƿ�ȷ��ɾ����"))
				{
					return false;
				}
			}
			else
			{
				if(!window.confirm("�Ƿ�ȷ��ɾ����"))
					return false;
			}
				var url = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=processDelete&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>&pid="+obj1.value;
				if(forceToDel=='true')
				{
					url += "&forceToDel=true";
				}
				document.all.divProcessing.style.display="block";
				var retX=SendHttp(url);
				alert(retX);
				window.location.reload();
		}
	}
	
	
	function setSelectId()
	{
		var els=document.getElementsByName("checkBoxOne");
		var obj1=document.all.selectId;
		obj1.value="";
		for(var i=0;i<els.length;i++)
		{
			if(els[i].checked) obj1.value+=els[i].value+",";
		}
	}
	
	// ��ѡ��ȫ��ѡ��
	function checkAll(totalCheck,checkName){	
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

   
	// ����ѡ�и�ѡ��
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
	
	function newUniteXpdl()
	{
		var chks =getNavigatorContent().applyform.process;
		var tmp="";
		alert(chks.length);
		for(i=0;i<chks.length;i++)
		{
			if(chks[i].checked) tmp+=chks[i].value+",";
		}
		var reg = /#/g;
		//var url="../xpdl_open.jsp?ec_id=<%=request.getParameter("ec_id")%>&expkgids="+tmp;
		var ec_id ="<%=request.getParameter("ec_id")%>";
		var expkgids=tmp.replace(reg,"~");
		if(expkgids!=null&&expkgids.length>0)
		{
			newXPDL(ec_id,expkgids);
		}
		else
		{
			alert("��ѡ��Ҫ������ⲿ����");
			return false;
		}
	}
	//���������Ƶ�ҳ�棬Ȼ������ת��ѡ����
	function openXpdlSelectPage()
	{
		//var retx=window.showModalDialog("iframe_main.jsp");
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/jawe_unite/xpdl_new.jsp",window);
		if(retx) window.location.reload();
	}
	
	//��������
	function publish(pId,pName,userName)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/ProcessTools?op=publish&pId="+pId+"&pName="+pName+"&userName="+userName);
		alert(retX);
		window.location.reload();	
	}
	//ȡ������	
	function cancelPublish(pId)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/ProcessTools?op=cancelPublish&pId="+pId);
		alert(retX);
		window.location.reload();	
	}
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ProcessForm" action="" method="post">

				
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=8>
							<b>�����б�</b>
						</td>
					</tr>
					<pg:listdata dataInfo="UniteProcessList" keyName="UniteProcessList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="UniteProcessList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								���̱��
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								������
							</td>
							<td height='20' class="headercolor">
								����״̬
							</td>
							<td height='20' class="headercolor">
								�޸�
							</td>
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>

						<pg:param name="ec_id" />
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû������
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="pId" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')">
									<pg:cell colName="pId" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=dataSet.getString("pName").split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publishTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publisher" defaultValue=""/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">
										δ����
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										�ѷ���
									</pg:equal>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">
										<input type="button" value="�޸�" onclick="openXpdl('<pg:cell colName="pName" defaultValue=""/>','<pg:cell colName="pId" defaultValue=""/>')"/>
										<input type="button" value="�鿴��ʷ�汾" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="�鿴���õ�����" onclick="showSubflow('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="����" onclick="publish('<pg:cell colName="pId" defaultValue="" />','<pg:cell colName="pName" defaultValue=""/>','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										<input type="button" value="�鿴���õ�����" onclick="showSubflow('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="ȡ������" onclick="cancelPublish('<pg:cell colName="pId" defaultValue="" />')"/>
									</pg:equal>
									<input type="button" value="�޸���Ϣ" onclick="editXPDLMes('<pg:cell colName="pId" defaultValue=""/>')"/>
								</td>
								</tr>
						</pg:list>
						
						
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
								<input name="Submit" type="button" class="input" value="����"
									onClick="openXpdlSelectPage()"/>
								<%--<input name="Submit" type="button" class="input" value="����"
									onClick="newUniteXpdl()"/>--%>
								<input type="button" value="ɾ��" class="input"
									onclick="deleteProcess('false')"/>
								<!-- //ǿ��ɾ��liuc -->
								<input type="button" value="ǿ��ɾ��" class="input"
									onclick="deleteProcess('true')"/>								
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe id="myFrame" scrolling="no" noresize frameborder="0"/>
</html>

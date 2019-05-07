<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 org.apache.commons.lang.StringUtils,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager,
                 com.chinacreator.epp.businessClassManager.vo.FormClass"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String  eform_class = StringUtils.defaultString(request.getParameter("class_id"));

   
  
	FormClassManager formClassManager = new FormClassManager();
	FormClass formClass = new FormClass();
	formClass = formClassManager.getFormClassByClassId(eform_class);
	String eform_class_name = formClass.getEc_name();
     
    String initDjid = (String)request.getParameter("djid");
	String initDjname = (String)request.getParameter("djname");
	
	if(initDjid == null)
    {
	   	initDjid = "";
	}
	if(initDjname == null)
    {
	   	initDjname = "";
	}
	
	String showDelete = request.getParameter("showDelete");
    showDelete = StringUtils.defaultString(showDelete);
%>

<jsp:include page="/eformsys/fceformext/public/public.jsp"></jsp:include>
<html>
	<head>
		<title>��������</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="../../../include/pager.js"
			type="text/javascript"></script>

		<script src="../js/fcpub.js"></script>
		<script src="../js/fcopendj.js"></script>
		<script src="../js/fcselfuse.js"></script>	
		<script language="javascript">
			var djtype ="";
			function window_onload(){
				//var sHtml=GetBillType(); //��ȡbilltype.xml�еļ�¼.
				//djtype = sHtml.substring(sHtml.indexOf('value=')+7,sHtml.indexOf('value=')+9);
			}
		</script>
		<script>
			
			//��ѡ��Ķ�ѡ���ֵ����selectId
			function setSelectId()
			{
				var els=document.all.checkBoxOne;
				var obj1=document.all.selectId;		        
		        if(els==undefined){              //�б���û��һ����¼��ʱ��
		        	alert("����ѡ��һ��������");
		            return 0;
		        }
		        if(els.length==undefined){		 //�б���ֻ��һ����¼��ʱ��els��length�ͻ�Ϊundefined				
					if(els.checked){
					    obj1.value=els.value;
					    return 1;
					}else{
					    alert("����ѡ��һ��������");
		                return 0;
					}
				}else{                            //�б����ж�����¼��ʱ��
					var num =0;
					for(var i=0;i<els.length;i++){		     
		            	if(els[i].checked){
		                	obj1.value=els[i].value;
		                	num++;		                
		            	}
		        	}
		        
		        	if(num>1){
		            	alert("ֻ��ѡ��һ��������");
		            	return 0;
		        	}
		        
		        	if(num==0){
		           		alert("����ѡ��һ��������");
		            	return 0;
		        	}
		        	return 1;
				}				
			}
			
			function setRadioSelect(){
			    var r = document.all.radioSelect;
			    var obj1=document.all.selectId;	
			    if(r==undefined){
			        alert("����ѡ���¼��");
			        return 0;
			    }
			    if(r.length==undefined){
			        if(r.checked){
			            obj1.value = r.value;			            		            
			            return 1; 
			        }else{
			            alert("����ѡ���¼��");
			            return 0;
			        }
			    }else{
			        var num = 0;
			        for(var i = 0;i<r.length;i++){
			            if(r[i].checked){			               
			                obj1.value = r[i].value;			                
			                num++;
			            }
			        }
			        if(num==0){
			            alert("����ѡ���¼��");
			            return 0;
			        }else{
			            return 1;
			        }
			    }	
			   		    
			}
			
			function cmd_ok(){
			    var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var obj1=document.all.selectId;			    
			    parent.close();
			    window.returnValue=obj1.value;	    
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
			
			//��ʾģ��,��ʾ�������̬��ģ�壬�����ܽ��б��档		
			function showForm(e,djid)
			{
				//var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/common/djframe.htm?djsn="+djid+"&djtype="+djtype ;
				//open(sUrl);
				//DjOpen(djid,null,"չ��","��ǰ����","����","");
				//var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/opendj.htm?djsn="+djid;
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design_show.htm?tbtype=3&djsn="+djid+"&eform_class=<%=eform_class%>";
				window.open(sUrl);
				//location.href=sUrl;
			}	
			
			//�޸�ģ��
			function modify(djid,cssfolder)
			{
				var userId = getSysElement('userid');
                if(userId.length == 0)
                {
                	alert("�Ự���ڣ������µ�¼��");
                	window.location.reload();
                	return;
                }
               	var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design.jsp?tbtype=1&cssfolder="+cssfolder+"&djsn="+djid+"&eform_class=<%=eform_class%>";
				open(sUrl);
			}	
			
			//ɾ��ģ��
			function deleteTemplate(){
				var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    else
			    {
			    	if(confirm("��ȷ��Ҫɾ����ģ����"))
			    	{
			    		var url = window.location.href;
			    		var obj1=document.all.selectId;
			    		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=deleteForms&djid="+obj1.value);
						alert(retX);
						//window.location.reload();
						window.location.href=url;
			    	}
			    }
			}
			
			//�½�ģ�壬ʵ�������������������������ʱ����ģ�屣�档
			function creatTemplate(class_id)
			{				
				location.href=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design.jsp?tbtype=1&app_id=1&eform_class="+class_id+"&isTemplate=false";
			}
			
			function queryForm()
			{	
				var userId = getSysElement('userid');
                if(userId.length == 0)
                {
                	alert("�Ự���ڣ������µ�¼��");
                	window.location.reload();
                	return;
                }
				var djid = trim(document.all("djid").value);
				var djname = trim(document.all("djname").value);
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/eformTree/templateForm_list.jsp?djid="+djid+"&djname="+djname+"&bool=true&class_id=<%=eform_class%>&showDelete=true";
				ApplyForm.action=sUrl;
				//ApplyForm.submit();	
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onLoad="window_onload()">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
                <table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							����ģ���ţ�
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="djid" style="width:70%" value="<%= initDjid%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							����ģ�����ƣ�
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="djname" style="width:70%" value="<%= initDjname%>">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">                             
							<input name="Submit4" type="submit" class="input" value="��ѯ" onClick="queryForm()">
							<input name="Submit22" type="button" class="input" value="���" onClick='document.all("djid").value="";document.all("djname").value=""'>
						</td>
					</tr>
                </table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
				<%if(eform_class==null){ %>
				    <tr>
				        <td height='30' class="detailtitle" align="center" colspan="9">
							<b>��ѡ����ߵ����鿴����ģ��</b>				        
				        </td>
				    </tr>
			    <%}else{%>
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>����ģ���б�<% if(eform_class_name != null) out.print("("+eform_class_name+")"); %></b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.eform.formmanage.menu.FormTemplateList" keyName="FormTemplateList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="FormTemplateList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<!-- P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P-->
							</td>
							<input class="text" type="hidden" name="selectId" value="">
							<input name="delSingle" type="hidden" validator="string"
								maxlength="100" value="false">
							<td height='20' class="headercolor">
								ģ����
							</td>
							<td height='20' class="headercolor">
								ģ������
							</td>
							<td height='20' class="headercolor">
								�汾��
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								������
							</td>
							<%if(showDelete.equals("true")){ %>
							<td height='20' class="headercolor">
								�޸�
							</td>
							<%} %>										
						</tr>

						<pg:param name="class_id" />
						<pg:param name="djid"  defaultValue="<%= initDjid %>"/>
						<pg:param name="djname" defaultValue="<%= initDjname %>"/>
						<pg:param name="showDelete" />

						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû�б���
								</td>
							</tr>
						</pg:notify>

						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>

								<tr class="labeltable_middle_tr_01"
									onMouseOver="this.className='mousestyle1'"
									onMouseOut="this.className= 'mousestyle2'">
									<td class="tablecells" nowrap="true">
										<P align="center">
											<INPUT type="radio" name="radioSelect"												
												value='<pg:cell colName="djid" defaultValue=""/>'>
										</P>
									</td>
									<td height='20' align=left class="tablecells" style="cursor:hand" onclick="showForm(this,'<pg:cell colName="djid" defaultValue=""/>')">
										<pg:cell colName="djid" defaultValue="" />
								    </td>
									<td height='20' align="center" class="tablecells" style="cursor:hand" onclick="showForm(this,'<pg:cell colName="djid" defaultValue=""/>')">
										<pg:cell colName="dj_name" defaultValue="" />
									</td>
									<td height='20' align="center" class="tablecells">
										<pg:cell colName="dj_ver" defaultValue="" />
									</td>
									<td height='20' align="center" class="tablecells">
										<pg:cell colName="creattime" defaultValue=""
											dateformat="yyyy-mm-dd hh24:mm:ss" />
									</td>
									<td height='20' align="center" class="tablecells">
										<pg:cell colName="creator" defaultValue="" />
									</td>	
									<%if(showDelete.equals("true")){ %>
									<td height='20' align="center" class="tablecells">
										<input type="button" value="�޸�" onclick="modify('<pg:cell colName="djid" defaultValue=""/>','<pg:cell colName="cssfolder" defaultValue=""/>')"/>
									</td>
									<%} %>												
								</tr>
							

						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
										
								<%if(showDelete.equals("true"))
								 {
								   //���ѡ���˾����ҵ��������������������ֻ��ʾɾ����ť(�˴���eform_class_name������eform_class,���߿���ȡֵΪnull,����Ϊ4)
								   if(eform_class_name != null)
								   {
								%>
									<input name="newTemplate" type="button" class="input" value="����" onclick="creatTemplate('<%=eform_class%>')"/>
								<%
								   }
								%>
									<input name="delete" type="button" class="input" value="ɾ��" onclick="deleteTemplate()"/>						
								<%}
								  else
								  {
								%>
									<input name="Submit" type="button" class="input" value="ȷ��"
									onClick="cmd_ok()"/>
								<%} %>
							</td>
						</tr>
					</pg:pager>
				<%}%>

				</table>

				<div align="center">
				</div>
			</form>
		</div>

	</body>
</html>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 org.apache.commons.lang.StringUtils"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String eform_class = StringUtils.defaultString(request.getParameter("class_id"));
	if("".equals(eform_class)){
	    eform_class = "0";
	}
	//FormClassManager formClassManager = new FormClassManager();
	//FormClass formClass = new FormClass();
	//formClass = formClassManager.getFormClassByClassId(eform_class);
	//String eform_class_name = formClass.getEc_name();

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
		<script language="JavaScript" src="../../include/pager.js"
			type="text/javascript"></script>
		<script language="javascript" type="text/javascript" src="../../epp/menuconfigure/pageGrey.js"></script>	
		<script src="js/fcpub.js"></script>	
		<script src="js/fcopendj.js"></script>
		<script type="text/javascript">
		    var childWindow = this;
		    function setSelectId()
			{
				var els=document.all.checkBoxOne;
				var obj1=document.all.selectId;
		        if(els==undefined){
		            alert("����ѡ���¼��");
		            return 0;
		        }
		        if(els.length==undefined){		//��ֻ��һ����¼��ʱ��els��length�ͻ�Ϊundefined				
					if(els.checked){
					    obj1.value=els.value;
					    return 1;
					}else{
					    alert("����ѡ���¼��");
		                return 0;
					}
				}else{				   
					var num =0;
					for(var i=0;i<els.length;i++){
						if(els[i].checked){
						    obj1.value+=els[i].value+",";
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
			
		    function deleteForm()
			{ 
				var num = setSelectId();
				if(num==0){
				    return;
				}
				if(!confirm('��ȷ��Ҫɾ����')){
				    return;
				}
				var obj1=document.all.selectId;				
				var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=deleteForms&djid="+obj1.value);
				alert(retX);
				//window.location.reload();   //����������
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/form_list.jsp?djid=<%= initDjid %>&djname=<%= initDjname %>";				
				window.location.replace(sUrl);
			}
		    
		    function publishForm(djid)
			{
				var offset=creator_getQueryString("pager.offset");
			    var desc=creator_getQueryString("pager.desc");
			    var para="";
			    if(!IsSpace(offset) && !IsSpace(desc)){
			       para="&pager.offset="+offset+"&pager.desc="+desc;
			    }
				var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=publishForm&djid="+djid);
				alert(retX);
				//window.location.reload();	  //����������滻�˾䣬�����ѯ��������ٷ�����ʱ������ʾҪ���ط���Ϣ������ˢ��ҳ��
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/form_home.jsp?djid=<%= initDjid %>&djname=<%= initDjname %>"+para;				
				window.location.replace(sUrl);
			}
			
			function cancelPublish(djid)
			{
				var offset=creator_getQueryString("pager.offset");
			    var desc=creator_getQueryString("pager.desc");
			    var para="";
			    if(!IsSpace(offset) && !IsSpace(desc)){
			       para="&pager.offset="+offset+"&pager.desc="+desc;
			    }
				var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=cancelPublish&djid="+djid);
				alert(retX);
				//window.location.reload();	
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/form_home.jsp?djid=<%= initDjid %>&djname=<%= initDjname %>"+para;				
				window.location.replace(sUrl);
			}
			
			//added by zhou.luo 2008-11-11 ��������������ķ����Ƿ���Ӧ���µ����б�
			function publishFormBat(eformClassId)
			{
			    //modified by zhou.luo 2009-01-07			   			    
			    var url = location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=publishFormBat&eformClassId="
			             +eformClassId+"&recursion=true";
			    if(confirm('��ȷ��Ҫ������Ӧ����������б���'))
			    {			
			    	popSignFlow(1);
			    	ApplyForm.action = "issueAllForms.jsp?eformClassId="+eformClassId+"&recursion=true";
			        ApplyForm.target = "item1";
			    	ApplyForm.submit();	
			    	//var retX = SendHttp(url);
			    	//alert(retX);
			    	//url = location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/form_home.jsp?djid=<%= initDjid %>&djname=<%= initDjname %>";
			    	//window.location.replace(url);
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
			
			function showForm(e,djid)
			{
				//var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/common/djframe.htm?djsn="+djid+"&djtype="+eform_class ;
				//open(sUrl);
				//DjOpen(djid,null,"չ��","��ǰ����","����","");
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/opendj1.htm?djsn="+djid;
				//open(sUrl);
				location.href=sUrl;
			}
			
			function modify(djid,cssfolder)
			{
                var userId = getSysElement('userid');
                if(userId.length == 0)
                {
                	alert("�Ự���ڣ������µ�¼��");
                	window.location.reload();
                	return;
                }
				var cur_date = new Date();
				var cur_date_str = (cur_date.getMonth()+1)+'-'+cur_date.getDate()+'-'+cur_date.getYear()+' '+cur_date.getHours()+':'+cur_date.getMinutes()+':'+cur_date.getSeconds();
				//alert("cur_date_str: " + cur_date_str);		
				
				var status = SqlToField("select dj_modified FROM tb_form where djid ='" + djid + "'");
			      
			    if (status == 1)��������������������������������������������//��������
			    {
			        var editor = SqlToField("select dj_editor FROM tb_form where djid ='" + djid + "'");
			    	var edittime_ora = SqlToField("select to_char(dj_edittime,'mm-dd-yyyy HH24:MI:SS') FROM tb_form where djid ='" + djid + "'");	
			    	var edit_date = new Date(Date.parse(edittime_ora));
					var compare_time = edit_date.getTime() + (60*60*1000);
					var compare_date = new Date();
					compare_date.setTime(compare_time);
					//var compare_date_str = compare_date.getMonth()+'-'+compare_date.getDate()+'-'+compare_date.getYear()+' '+compare_date.getHours()+':'+compare_date.getMinutes()+':'+compare_date.getSeconds();
					//alert("compare_date_str: " + compare_date_str);
					
			        if(editor == userId)����������������������          //����޸������Լ�����ֱ�Ӵ򿪱�����
			        {
			        	var s=InsertSql("Update tb_form set dj_edittime = to_date('"+cur_date_str+"','mm-dd-yyyy HH24:MI:SS') where djid='" + djid + "'");
			        	var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design.jsp?tbtype=1&cssfolder="+cssfolder+"&djsn="+djid+"&eform_class=<%=eform_class%>";
				   ������ childWindow = open(sUrl);
			        }
			        else if(cur_date > compare_date)����������        //����޸��˲����Լ��ұ����޸�ʱ�䳬����Сʱ����Դ򿪱�
			        {
			        	var s1=InsertSql("Update tb_form set dj_editor='"+userId+"',dj_edittime=to_date('"+cur_date_str+"','mm-dd-yyyy HH24:MI:SS') where djid='"+djid+"'");
			        	var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design.jsp?tbtype=1&cssfolder="+cssfolder+"&djsn="+djid+"&eform_class=<%=eform_class%>";
				        childWindow = open(sUrl);
			        }
					else��������������������������������������������������   //����޸��˲����Լ��ұ����޸�ʱ��δ������Сʱ����ʾҳ������
					{
						 alert("������һ���û������޸Ĵ˱���");
				         return false;
					}
		        }  
			    else											    //��δ������
			    { 
			       var s2 = InsertSql("Update tb_form set dj_modified='1',dj_editor='"+userId+"',dj_edittime=to_date('"+cur_date_str+"','mm-dd-yyyy HH24:MI:SS') where djid='"+djid+"'");
			       var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design.jsp?tbtype=1&cssfolder="+cssfolder+"&djsn="+djid+"&eform_class=<%=eform_class%>";
				   childWindow = open(sUrl);
			    }
			    
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
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/form_home.jsp?djid="+djid+"&bool=true&djname="+djname;
				ApplyForm.action=sUrl;
				ApplyForm.submit();	
			}
			
			function closeChildWindow()
			{
			 	if(!childWindow.closed)
			 	{
			 		childWindow.close();
			 	}
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no"	onLoad="" onbeforeunload="closeChildWindow()">
		<!--  
		<div id="contentborder" align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>��ѡ����ߵ���������鿴��</b>
						</td>
					</tr>	
				</table>
		</div>
		-->
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
              
              <table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							����ţ�
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="djid" style="width:70%" value="<%= initDjid%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							�����ƣ�
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
					<tr>
						<td colspan="2" char="detailcontent" align="right">
						    <input name="publishBat" type="button" class="input" value="����Ӧ���µ����б�" onclick="publishFormBat('<%=eform_class%>')"/>
						</td>
					</tr>
				</table>
				
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<pg:listdata dataInfo="com.chinacreator.eform.formmanage.menu.FormSeachList" keyName="FormList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="FormList"	isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<input class="text" type="hidden" name="selectId" value="">
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false">
							<td height='20' class="headercolor">
								�����
							</td>
							<td height='20' class="headercolor">
								������
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
						</tr>
						
						<pg:param name="djid"  defaultValue="<%= initDjid %>"/>
						<pg:param name="djname" defaultValue="<%= initDjname %>"/>
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû�б�
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
											value='<pg:cell colName="djid" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align=left class="tablecells" >
									<pg:cell colName="djid" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells" >
									<pg:cell colName="dj_name" defaultValue=""/>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="dj_ver" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="creattime" defaultValue="" dateformat="yyyy-mm-dd hh24:mm:ss"/>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="creator" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="publishTime" defaultValue="" dateformat="yyyy-mm-dd hh24:mm:ss"/>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="publisher" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:equal colName="publishState" value="0">
										δ����
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										�ѷ���
									</pg:equal>
								</td>
								
								<td height='20' align=center class="tablecells">									
									<input type="button" value="�޸�" onclick="modify('<pg:cell colName="djid" defaultValue="" />','<pg:cell colName="cssfolder" defaultValue="" />')"/>
									<pg:equal colName="publishState" value="0">
										<input type="button" value="����" onclick="publishForm('<pg:cell colName="djid" defaultValue="" />')"/>
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										<input type="button" value="ȡ������" onclick="cancelPublish('<pg:cell colName="djid" defaultValue="" />')"/>
									</pg:equal>
									<pg:equal colName="publishState" value="2">
									    <input type="button" value="���·���" onclick="publishForm('<pg:cell colName="djid" defaultValue="" />')"/>
									</pg:equal>							
								</td>
							</tr>		
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
								<input type="button" value="ɾ��" class="input"	onclick="deleteForm()">
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
	<iframe name="item1" width="0" height="0" style="display: none;"></iframe>			
	</body>
</html>
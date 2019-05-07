<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String dflag = (String)request.getAttribute("dflag");
	if(dflag == null || dflag.length() == 0){
		dflag = "0";
	}
%>
<html>
	<head>
		<title></title>
		<SCRIPT LANGUAGE="JavaScript">
		var http_request = false;
		//��ʼ����ָ������ĺ�������������ĺ���
		function send_request(url){
			http_request = false;
			//��ʼ��ʼ��XMLHttpRequest����
			if(window.XMLHttpRequest){//Mozilla
				http_request = new XMLHttpRequest();
				if(http_request.overrideMimeType){//����MIME���
					http_request.overrideMimeType("text/xml");						
				}
			}
			else if(window.ActiveXObject){//IE
				try{
					http_request = new ActiveXObject("Msxml2.XMLHTTP");
				}catch(e){
					try{
						http_request = new ActiveXObject("Microsoft.XMLHTTP");							
					}catch(e){
					}
				}
			}
			if(!http_request){
				alert("���ܴ���XMLHttpRequest����");
				return false;
			}
			http_request.onreadystatechange = processRequest;
			http_request.open("GET",url,true);
			http_request.send(null);
		}
		
		function processRequest(){
			if(http_request.readyState == 4){
				if(http_request.status == 200){
					//alert(http_request.responseText);
				}
				else{
					alert("�Բ��𣬷���������");
				}
			}
		} 
		var dflag = "<%=dflag%>"; 
		function init(){
		if(dflag == "0"){
			//document.forms[0].b1new.disabled=true;   
			//document.forms[0].b3del.disabled=true;   
			document.forms[0].button1.disabled=true; 
			document.forms[0].button2.disabled=true; 
			document.forms[0].button3.disabled=true; 
			document.forms[0].button4.disabled=true; 
		}
		}
	    function deleteUser(){
		    var orgId = document.all("orgId").value;
		    var jobId = document.all("curJobId").value;
	    	var isselected = 0;
	    	var len=document.all("userList").options.length;
			for (var i=0;i<len;i++){
				if(document.all("userList").options[i].selected)
					isselected = 1;
		    }
		    if(isselected == 0){
		   		alert("����ѡ��һ����Ա�ٽ��д˲���");
		   		return;
		   	}
		   	if(window.confirm("��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)")){
		   		var userId=new Array()
		   		var s = 0;
			    for (var j=0;j<len;j++){       
		        	if(document.all("userList").options[j].selected){
		        		userId[s]=document.all("userList").options[j].value;
		        	
		        		//s ++;
		        		//document.all("userList").options[j] = null;
		        	}
	        	}   
			    //send_request('<%=rootpath%>/sysmanager/orgmanager/userjobchange.jsp?orgId='+orgId+'&jobId='+jobId+'&userId='+userId);
			    //window.opener.location = window.opener.location;
			    document.forms[0].action="<%=rootpath%>/orgmanager/orgoperjob.do?method=deleteUser";
         		document.forms[0].submit();
			    		   		
         	}
		}
		
		function saveUser(){	    	
	    	var len=document.all("userList").options.length;
			for (var i=0;i<len;i++){
				document.all("userList").options[i].selected = true;					
		    }
		    
		   	document.forms[0].action="<%=rootpath%>/orgmanager/orgoperjob.do?method=storeUserjoborg";
         	document.forms[0].submit();
		}
		
		function adduser(){	    	
	    	//window.open('<%=rootpath%>/sysryxz.jsp?type1=document.forms[0].type1&type2=document.forms[0].type2','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
			var orgId = document.all("orgId").value;
			var jobId = document.all("curJobId").value;
			
			window.open('<%=rootpath%>/sysmanager/orgmanager/org2user.jsp?orgId='+orgId+'&jobId='+jobId,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
			
		}
		
		function sendUser(){     
	       var orgId = document.all("orgId").value;
	       var len=document.all("userList").options.length;
	       var jobSn = document.all("jobSn").value;
		   var jobId = document.all("curJobId").value;
	       var userId=new Array()
	       for (var i=0;i<len;i++){       
	         userId[i]=document.all("userList").options[i].value;
	        }   
		   send_request('<%=rootpath%>/sysmanager/orgmanager/usersnchange.jsp?orgId='+orgId+'&jobId='+jobId+'&jobSn='+jobSn+'&userId='+userId);
   		}
   
		function up1() {
			var len=document.all("userList").options.length;
			var isselected = 0;
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			isselected = 1;
		   		}
		   	}
		   	if(isselected == 0){
		   		alert("����ѡ��һ����λ�ٽ��д˲���");
		   		return;
		   	}
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			var tmp = new Option(op.text,op.value);
		   			if(i>0){
			   			var dest = document.all("userList").options[i-1];
			   			var userId1 = tmp.value;	   				
		   				var orgId = document.all("orgId").value;
	   					var userId2 = dest.value;
	   					var jobSn = document.all("jobSn").value;
	   					var jobId = document.all("curJobId").value;
	   					var userSn = i;
		   				document.all("userList").options[i-1] = tmp;
		   				document.all("userList").options[i] = dest;
		   				document.all("userList").options[i-1].selected=true;
		   				send_request('<%=rootpath%>/sysmanager/orgmanager/usersnchange.jsp?userId1='+userId1+'&userId2='+userId2+'&orgId='+orgId+'&jobSn='+jobSn + '&userSn='+userSn +'&jobId='+jobId);
		   			}
		   		}
		    }
		}
		function upall() {
			var len=document.all("userList").options.length;	
			var isselected = 0;
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			isselected = 1;
		   		}
		   	}
		   	if(isselected == 0){
		   		alert("����ѡ��һ����λ�ٽ��д˲���");
		   		return;
		   	}
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			var tmp = new Option(op.text,op.value);
		   			op.selected = false;   			
		   			var j=i;   			
		   			for(;j>=1;j--){     				
		   				var atmp =  document.all("userList").options[j-1];   				
		   				var btmp = new Option(atmp.text,atmp.value);   				
		   				document.all("userList").options[j] = btmp;   				
		   			}   			
		   			document.all("userList").options[0] = tmp;	
		   		}
		    }
		    sendUser();
		    document.all("userList").options[0].selected=true;
		}
		
		function down1() {
			var len=document.all("userList").options.length;
			var isselected = 0;
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			isselected = 1;
		   		}
		   	}
		   	if(isselected == 0){
		   		alert("����ѡ��һ����λ�ٽ��д˲���");
		   		return;
		   	}
			var flag = 0;
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			var tmp = new Option(op.text,op.value);   			
		   			op.selected=false;
		   			if(i == len-1){
		   				flag = len-2;
		   			}
		   			else {
		   				flag = i;
		   			}
		   			if(i<len-1){
		   				var dest = document.all("userList").options[i+1];
			   			var userId2 = tmp.value;	   				
		   				var orgId = document.all("orgId").value;
	   					var userId1 = dest.value;
	   					var jobSn = document.all("jobSn").value;
	   					var jobId = document.all("curJobId").value;
	   					var userSn = i;
		   				document.all("userList").options[i+1] = tmp;
		   				document.all("userList").options[i] = dest;
		   				send_request('<%=rootpath%>/sysmanager/orgmanager/usersnchange.jsp?userId1='+userId1+'&userId2='+userId2+'&orgId='+orgId+'&jobSn='+jobSn + '&userSn='+userSn +'&jobId='+jobId);   				
		   			}
		   		}
		    }
		    document.all("userList").options[flag+1].selected=true;
		}
		
		function downall() {
			var len=document.all("userList").options.length;
			var isselected = 0;
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			isselected = 1;
		   		}
		   	}
		   	if(isselected == 0){
		   		alert("����ѡ��һ����λ�ٽ��д˲���");
		   		return;
		   	}	
			for (var i=0;i<len;i++){
				var op=document.all("userList").options[i];
		   		if(op.selected){   			
		   			var tmp = new Option(op.text,op.value);
		   			op.selected = false;   			
		   			var j=i;   			
		   			for(;j<len-1;j++){     				
		   				var atmp =  document.all("userList").options[j+1];   				
		   				var btmp = new Option(atmp.text,atmp.value);   				
		   				document.all("userList").options[j] = btmp;   				
		   			}   			
		   			document.all("userList").options[len-1] = tmp;	
		   		}
		    }
		    sendUser();
		    document.all("userList").options[len-1].selected=true;
		}
		
		function changeorg(){	
			var username = document.all("type1").value;
			var userid = document.all("type2").value;
			var orgId = document.all("orgId").value;
			var jobSn = document.all("jobSn").value;
			var jobId = document.all("curJobId").value;
			//alert(username + "===" + userid);
			//alert();
			var usernames = username.split(",");
			var userids = userid.split(",");
			//��Ϊ���滹��һ��&,���Գ��ȼ�һ
			for(var i = 0;i <usernames.length;i++){
				var ausername = usernames[i];
				var auserid = userids[i];				
				var op = new Option(ausername,auserid);
				var isadd = 1;
				for(var j = 0;j<document.all("userList").length;j++){
					if(op.value ==	document.all("userList").options[j].value){	
						isadd = 0;
					}
				}
				if(isadd == 1){
					document.all("userList").add(op);
	   				send_request('<%=rootpath%>/sysmanager/orgmanager/userjobchange.jsp?auserId='+op.value+'&orgId='+orgId+'&jobSn='+jobSn + '&jobId='+jobId);   				
				}
			}
		   
		}
	</SCRIPT>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
   <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
   <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
   <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
   <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
	</head>
	
	<%@ include file="/epp/css/cssControl.jsp"%><body  onload=init()>
		<form name="form1" method="post">
			<table width="184" height="341" border="0" align="center">
				<tr>
					<td height="16" colspan="3" valign="top">
						<div align="center">
							��λ���û��б�
						</div>
				  </td>
					<td></td>
				</tr>
				<tr>
					<td height="266" colspan="3" valign="top">
						<div align="center">
							<select name="userList" multiple style="width:90%" onDBLclick="deleteUser()" size="18">
								<pg:list requestKey="userList">
									<option value="<pg:cell colName="userId"/>">
										<pg:cell colName="userName" />(<pg:cell colName="userRealname" />)
									</option>
								</pg:list>
							</select>
						</div>
				  </td>
					<td>
						<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" class="detailcontent">
									<!--input name="button1" type="button" class="input" value="������" onClick="upall()"-->
								</td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">&nbsp;
									
							  </td>
							</tr>
							<tr>
								<td align="center">
									<!--input name="button2" type="button" class="input" value="������" onClick="up1()"-->
								</td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">&nbsp;
									
							  </td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">
									<!--input name="button3" type="button" class="input" value="������" onClick="down1()"-->
								</td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">&nbsp;
									
							  </td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">
									<!--input name="button4" type="button" class="input" value="���ײ�" onClick="downall()"-->
								</td>
							</tr>
							<tr>
								<td align="center" class="detailcontent">&nbsp;
									
							  </td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				
				</tr>
				<tr>
					<td width="48" height="33">
						
					</td>
					<td width="48" height="33">
						
					</td>
					<!--
					<td width="52">
						<div align="right">
							<input type="button" onClick="saveUser()" class="input" name="b2save" value="����">
						</div>
					</td>
					 <td width="62">
						<div align="right">
							<input type="button" onClick="deleteUser()" name="b3del" value="ɾ��">
						</div>
					</td>-->
					<pg:beaninfo requestKey="orgJobForm">
						<input type="hidden" name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>" />
						<input type="hidden" name="curJobId" value="<pg:cell colName="curJobId"  defaultValue=""/>" />
						<input type="hidden" name="jobSn" value="<pg:cell colName="jobSn"  defaultValue=""/>" />
						<input type="hidden" name="type1" />
						<input type="hidden" name="type2"  onpropertychange="changeorg()"/>
					</pg:beaninfo>
				</tr>
		  </table>
		</form>
	</body>
</html>

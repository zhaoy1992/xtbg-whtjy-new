
<%
/*
 * <p>Title: �û�����</p>
 * <p>Description: �û�����</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    String orgId = request.getParameter("orgId");
%>
<html>
    <head>
        <title>�������û�����</title>
        <SCRIPT LANGUAGE="JavaScript">
        var http_request = false;
        //��ʼ����ָ������ĺ�������������ĺ���
        function send_request(url){
            //http_request = false;
            //��ʼ��ʼ��XMLHttpRequest����
            //if(window.XMLHttpRequest){//Mozilla
            //    http_request = new XMLHttpRequest();
            //    if(http_request.overrideMimeType){//����MIME���
            //        http_request.overrideMimeType("text/xml");                      
            //    }
            //}
            //else if(window.ActiveXObject){//IE
           //     try{
            //        http_request = new ActiveXObject("Msxml2.XMLHTTP");
            //    }catch(e){
            //        try{
            //            http_request = new ActiveXObject("Microsoft.XMLHTTP");                          
           //         }catch(e){
            //        }
            //    }
            //}
           // if(!http_request){
            //    alert("���ܴ���XMLHttpRequest����");
            //    return false;
            //}
           // http_request.onreadystatechange = processRequest;
           // http_request.open("GET",url,true);
           // http_request.send(null);
           document.all.button1.disabled = true;
           document.all.button2.disabled = true;
           document.all.button3.disabled = true;
           document.all.button4.disabled = true;
           document.all.b1new.disabled = true;
           document.all.divProcessing.style.display = "block";
			document.form1.action = url;
			document.form1.target = "hiddenFrame";
			document.form1.submit();
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
        var dflag = false;
        function init(){
	        if(dflag){
	            //document.forms[0].b1new.disabled=true;   
	            //document.forms[0].b3del.disabled=true;   
	            document.forms[0].button1.disabled=true; 
	            document.forms[0].button2.disabled=true; 
	            document.forms[0].button3.disabled=true; 
	            document.forms[0].button4.disabled=true; 
	        }
        }        
        //�־û�
        function sendUser(){    
           var len=document.all("userList").options.length;
           var orgId = document.all("orgId").value;           
           var userId=new Array() 
           for (var i=0;i<len;i++){       
             userId[i]=document.all("userList").options[i].value;
           }
           send_request('userorderchange.jsp?orgId='+orgId+'&userId='+userId);
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
                alert("����ѡ��һ���û��ٽ��д˲���");
                return;
            }
            for (var i=0;i<len;i++){
                var op=document.all("userList").options[i];
                if(op.selected){            
                    var tmp = new Option(op.text,op.value);
                    if(i>0){
                        var dest = document.all("userList").options[i-1];
                        var userId1 = tmp.value; 
                        var userId2 = dest.value;                   
                        
                        document.all("userList").options[i-1] = tmp;
                        document.all("userList").options[i] = dest;
                        document.all("userList").options[i-1].selected=true;
                        
                    }
                }
            }
            //sendUser()
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
                alert("����ѡ��һ���û��ٽ��д˲���");
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
                        var userId1 = dest.value;     
                        var userSn = i;
                        document.all("userList").options[i+1] = tmp;
                        document.all("userList").options[i] = dest;
                                         
                    }
                }                
            }
            //sendUser()
            document.all("userList").options[flag+1].selected=true;
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
		   		alert("����ѡ��һ���û��ٽ��д˲���");
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
		    //sendUser();
		    document.all("userList").options[0].selected=true;
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
		   		alert("����ѡ��һ���û��ٽ��д˲���");
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
		    //sendUser();
		    document.all("userList").options[len-1].selected=true;
		}
		function deleteUser(){}
		
		
        
        
    </SCRIPT>
    <link rel="stylesheet" type="text/css" href="../../css/windows.css">
    <link rel="stylesheet" type="text/css" href="../../css/treeview.css">
    </head>
    
    <%@ include file="/epp/css/cssControl.jsp"%><body  onload=init() onunload="window.returnValue = 'ok'">
        <form name="form1" method="post">
            <input type="hidden" name="orgId" value="<%=orgId%>">
            <table width="450" height="20" border="0" align="center">
                <tr>
                    <td height="16" colspan="15" valign="top" width="60%">
                        <div align="center">
                            �������û��б�
                        </div>
                    </td>
                    <td width="40%"></td>                  
                </tr>
                
                <tr>
                    <td height="400" colspan="15" width="60%" valign="top">
                        <div align="center">
                            <select name="userList" multiple style="width:90%;height:400" onDBLclick="deleteUser()" size="18">
                                <pg:listdata dataInfo="OrgSubUserList" keyName="OrgSubUserList" />                                
                                <pg:pager  scope="request" data="OrgSubUserList" isList="true">
                                <pg:list>
                                    <option value="<pg:cell colName="userId"/>">
                                        <pg:cell colName="userName" />(<pg:cell colName="userRealname" />)
                                    </option>
                                </pg:list>
                                </pg:pager>
                            </select>
                        </div>
                    </td>
                    <td width="40%">
                        <table align="left" width="100%" border="0"  valign="top" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="detailcontent">
                                    <input name="button1" type="button" class="input" value="������" onClick="upall()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">&nbsp;
                                    
                              </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <input name="button2" type="button" class="input" value="������" onClick="up1()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">&nbsp;
                                    
                              </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">
                                    <input name="button3" type="button" class="input" value="������" onClick="down1()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">&nbsp;
                                    
                              </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">
                                    <input name="button4" type="button" class="input" value="���ײ�" onClick="downall()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="detailcontent">&nbsp;
                                    
                              </td>
                            </tr>
                        </table>
                    </td>
                </tr> 
            </table>
            <table width="450" height="33" border="0" align="center">
                <tr>
					<td height="33">
						<div align="center">
							<input type="button" name="b1new" value="ȷ��" class="input" onclick="sendUser()">
							<input type="button" value="ȡ��" class="input" onclick="window.close()">
						</div>
					</td>
			    </tr>             
          </table>
        </form>
        <div id=divProcessing style="width:200px;height:25px;position:absolute;left:340px;top:298px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
			    <tr>
				    <td bgcolor=#3A6EA5>
					    <marquee align="middle" behavior="alternate" scrollamount="5">
						    <font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>	
		<iframe name="hiddenFrame" width=0 height=0></iframe>
    </body>
</html>

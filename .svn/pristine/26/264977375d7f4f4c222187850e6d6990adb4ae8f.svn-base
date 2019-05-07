<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	String currGroupId = (String)request.getAttribute("groupId");
%>
<html>
<head>    
  <title>属性容器</title>
<SCRIPT LANGUAGE="JavaScript"> 
function addrestype(){	
   var n=document.all("restypeId").options.length-1;	 	
   for(var i=0;i<document.all("allist").options.length;i++){
   var op=document.all("allist").options[i];
   if(op.selected)
   addone(op.text,op.value,n);
  }
}
function addone(name,value,n){

   for(var i=n;i>=0;i--){
		if(value==document.all("restypeId").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("restypeId").add(op);
   
}
function deleteall(){
	for (var m=document.all("restypeId").options.length-1;m>=0;m--)
    document.all("restypeId").options[m]=null
}
      
function addall(){
	var n=document.all("restypeId").options.length-1;
	var p=document.all("allist").options.length-1;		  
     for(var i=0;i<document.all("allist").options.length;i++){
     var op=document.all("allist").options[i];
     addone(op.text,op.value,n);  
   }
}
function deleterestype(){
 for (var m=document.all("restypeId").options.length-1;m>=0;m--)
	      if(document.all("restypeId").options[m].selected)
         document.all("restypeId").options[m]=null;
}
function okadd(){
	var len=document.all("restypeId").options.length;
	for (var i=0;i<len;i++){	      
         document.all("restypeId").options[i].selected="true";
    }
    document.groupRestypeForm.action="../opermanager/operManager.do?method=storeOpgroupRestype";
    document.groupRestypeForm.submit();
}

function returnPrev(){
	var groupId="<%=currGroupId%>";
    document.groupRestypeForm.action="../opermanager/operManager.do?method=getGroupInfo&groupId="+groupId;
    document.groupRestypeForm.submit();
}

</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
<center>
<form name="groupRestypeForm" action="" method="post" >
<table width="98%" border="0" cellpadding="0" cellspacing="1">
  <tr class="tabletop">
    <td width="40%" align="center">可选资源类型</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">已授予资源类型</td>
  </tr>
  <tr>
     <td>
     <select name="allist"  multiple style="width:100%" onDBLclick="addrestype()" size="6">
				  <pg:list requestKey="allRestype">
					<option value="<pg:cell colName="restypeId"/>"><pg:cell colName="restypeName"/></option>
				  </pg:list>			
	</select>
	</td>				  
		  	
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addrestype()"></td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()"></td>
      </tr>
      <tr>
        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()"></td>
      </tr>
      <tr>
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleterestype()"></td>
      </tr>
    </table></td>
    <td >
     <select name="restypeId"  multiple style="width:98%" onDBLclick="deleterestype()" size="6">
				  <pg:list requestKey="existRestype">
					<option value="<pg:cell colName="restypeId"/>"><pg:cell colName="restypeName"/></option>
				  </pg:list>			
	 </select>				
					
	</td>				 
				  
  </tr>
  <tr><td colspan="3" align="center">
  <input name="add" type="button" class="input" value="确定" onclick="okadd()" >
  <input name="prev" type="button" class="input" value="返回" onclick="returnPrev()" >
  </td> </tr>
  
</table>
<tr>
</tr>
</form>
</center>
</div>
<%@ include file="../sysMsg.jsp"%>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>设置webOffice控件的展示状态</title>
    
    <link rel="stylesheet" type="text/css" href="../../../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../../purviewmanager/css/treeview.css">	
	<script src="../js/fcpub.js"></script>
    <script type="text/javascript" language="javascript">
    	function setRadioSelect(){
	        var r = document.all.officeStatus;
			var obj1=document.all.selectId;	
			if(r==undefined){
			    alert("请先选择记录！");
			    return 0;
			}
			if(r.length==undefined){
			    if(r.checked){
			        obj1.value = r.value;			            		            
			        return 1; 
			    }else{
			        alert("请先选择记录！");
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
			        alert("请先选择记录！");
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
			window.returnValue = obj1.value;
			window.close();	
	    }	
	    
	    var myPara = window.dialogArguments;
	    //alert(myPara[0]);
	    //alert(myPara[1]);
	    var strsql = "select perattr_type from TD_FORM_PERATTR where ctrl_id='"+myPara[0]+"' and oid ='"+myPara[1]+"'";
	    var isExist = SelectSql(strsql,1,5);
	    var myChecked = "";
	    if(isExist!="<root></root>"){
	    	myChecked = isExist.substr(18,1);
	    }
    </script>
    
  </head>
  
  <body class="contentbodymargin">
    <br/>
    <form name="form1">    	
    	<input type="hidden" name="selectId" value=""/>
    	<table width="95%" border="0" cellpadding="0" cellspacing="1" class="thin" align="center">
    		<tr class="th"><td width="50%" height="25" class="detailtitle" align="center">webOffice控件在该活动的展示状态</td>
    		               <td width="50%" height="25" class="detailtitle" align="center">选择</td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">只读</td>
    		               <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="3"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">起草(允许修改，无痕迹)</td>
    		               <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="8"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">允许修改，保留痕迹</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="4"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">领导手写批注</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="5"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">成文员文档核稿</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="6"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">成文员文档核稿(带套红)</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="9"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">清稿有痕迹</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="10"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">允许修改，保留痕迹，可修订</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="7"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">文档核稿（只读）</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="11"/></td>
    		</tr>
    		<tr class="tr"><td colspan="2" height="25" class="detailtitle" align="center"><input type="button" name="mySubmit" value="确定" onclick="cmd_ok()"/>
    		                                                                              <input type="button" name="myCancel" value="取消" onclick="window.close();"/></td>
    	    </tr>
    	</table>
    </form>
    <script type="text/javascript" language="javascript">
    	var radios = document.getElementsByName("officeStatus");
    	for(var i = 0;i < radios.length;i++){
    		//alert("radios["+i+"].value:"+radios[i].value);
    		//alert("myChecked:"+myChecked);
    		if(radios[i].value==myChecked){
    			radios[i].checked = true;
    			break;
    		}
    	}
    </script>
  </body>
</html>

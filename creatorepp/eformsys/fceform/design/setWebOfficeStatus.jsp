<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>����webOffice�ؼ���չʾ״̬</title>
    
    <link rel="stylesheet" type="text/css" href="../../../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../../purviewmanager/css/treeview.css">	
	<script src="../js/fcpub.js"></script>
    <script type="text/javascript" language="javascript">
    	function setRadioSelect(){
	        var r = document.all.officeStatus;
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
    		<tr class="th"><td width="50%" height="25" class="detailtitle" align="center">webOffice�ؼ��ڸû��չʾ״̬</td>
    		               <td width="50%" height="25" class="detailtitle" align="center">ѡ��</td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">ֻ��</td>
    		               <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="3"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">���(�����޸ģ��޺ۼ�)</td>
    		               <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="8"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">�����޸ģ������ۼ�</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="4"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">�쵼��д��ע</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="5"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">����Ա�ĵ��˸�</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="6"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">����Ա�ĵ��˸�(���׺�)</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="9"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">����кۼ�</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="10"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">�����޸ģ������ۼ������޶�</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="7"/></td>
    		</tr>
    		<tr class="tr"><td width="50%" height="25" class="detailtitle">�ĵ��˸壨ֻ����</td>
    			           <td width="50%" height="25" class="detailtitle" align="center"><input type="radio" name="officeStatus" value="11"/></td>
    		</tr>
    		<tr class="tr"><td colspan="2" height="25" class="detailtitle" align="center"><input type="button" name="mySubmit" value="ȷ��" onclick="cmd_ok()"/>
    		                                                                              <input type="button" name="myCancel" value="ȡ��" onclick="window.close();"/></td>
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

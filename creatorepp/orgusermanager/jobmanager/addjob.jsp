<%
/*
 * <p>Title: ��λ����ҳ��</p>
 * <p>Description: ��λ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
%>
<html>
	<head>
		<title>������λ</title>
		<style type="text/css">
			<!--
			.style1 {color: #CC0000}
			-->
		</style>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		<SCRIPT language="JavaScript" SRC="../include/validateForm.js"></SCRIPT>
		<SCRIPT LANGUAGE="JavaScript"> 
			function trim(string)
			{
			  var temp="";
			  string = ''+string;
			  splitstring = string.split(" ");
			  for(i=0;i<splitstring.length;i++)
			  {
			    temp += splitstring[i];
			  } 
			  return temp;
			}
			
			// �����ַ����ĳ��ȣ�����ռ�����ַ�
			function StringLength(str)
			{
			    // replace�����ϴ�������ַ����滻��ָ���ַ� Ȼ���ڼ��㳤��
			    return str.replace(/[^\x00-\xff]/g,"**").length
			}
					
			function savejob() 
			{
				var form = document.forms[0];
				var jobname=form.jobname.value;
				var jobNumber=form.jobNumber.value;
				var jobRank=form.jobRank.value;
				var jobAmount=form.jobAmount.value;
				var jobFunction=form.jobFunction.value;
				var jobDesc=form.jobdesc.value;
				var jobCondition=form.jobCondition.value;
				
				if (trim(jobname).length == 0 )
				{
				    alert("��¼���λ���ƣ�"); 
				    return false;
			    }
			    
			    //if (trim(jobNumber).length == 0 )
			    //{
				//    alert("��¼���λ��ţ�"); 
				//    return false;
			   // }  
			    if(jobname.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			    {
					alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
					form.jobname.focus();
					return;
				}
				
				if(jobNumber.search(/\W/g)!=-1 )
				{
					alert("��λ���ֻ��Ϊ���֡���ĸ���»���!");
					form.jobNumber.focus();
					return false;
				}
				
				if(jobRank.search(/[\\\/\|:\*\?<>"']/g)!=-1)
				{
					alert("��λ�ȼ�������\\/|:*?<>\"'!�������ַ�");
					form.jobRank.focus();
					return;
				}
				
				if(jobAmount.search(/[\\\/\|:\*\?<>"']/g)!=-1)
				{
					alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
					form.jobAmount.focus();
					return;
				}
				
				if(StringLength(jobname)>100)
				{
					alert("��λ���ƹ���,������100�ַ�����!");
					return;
				}
				if(StringLength(jobNumber)>100)
				{
					alert("��λ��Ź���,������100�ַ�����!");
					return;
				}
				if(StringLength(jobRank)>100)
				{
					alert("��λ�ȼ�����,������100�ַ�����!");
					return;
				}
				if(StringLength(jobAmount)>100)
				{
					alert("��λ���ƹ���,������100�ַ�����!");
					return;
				}
				if(StringLength(jobFunction)>100)
				{
					alert("��λְ�����,������100�ַ�����!");
					return;
				}
				if(StringLength(jobDesc)>100)
				{
					alert("��λ��������,������100�ַ�����!");
					return;
				}
				if(StringLength(jobCondition)>100)
				{
					alert("��λ��ְ��������,������100�ַ�����!");
					return;
				}
			    
				var form = document.forms[0];
				
				document.all.divProcessing.style.display = "block";
				
				document.all.Submit.disabled = true;
				document.all.Reset.disabled = true;
				document.all.BackButton.disabled = true;
				
			  	form.action = "addjob_do.jsp";
				form.target = "hiddenFrame";
				form.submit();				
			}
			
			function back()
			{
				window.returnValue = true;
				window.close();
			}
		</SCRIPT>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form action="" method="post">  
				<table width="100%" height="223" border="0" align="center" cellpadding="0" cellspacing="1" class="thin">
				  <tr>
				    <td height="35" align=center colspan=5><b>������λ</b></td>
				  </tr>
				  <tr>
				    <td width="" height="35" class="detailtitle"> ��λ���� <span class="style1">*</span></td>
				    <td width="" class="detailcontent">
				    	<input type="text" name="jobname" size="40" maxlength="20"/>
				    </td>
				  </tr>
				  <tr>
				    <td height="35" class="detailtitle"> ��λ��� </td>
				    <td class="detailcontent">
				    	<input type="text" name="jobNumber" size="40" maxlength="20"/>
				    </td>
				  </tr>
				   <tr>
				    <td height="35" class="detailtitle"> ��λ�ȼ� </td>
				    <td class="detailcontent">
				    	<input type="text" name="jobRank" size="40" maxlength="20"/>
				    </td>
				  </tr>
				   <tr>
				    <td height="35" class="detailtitle"> ��λ���� </td>
				    <td class="detailcontent">
				    	<input type="text" name="jobAmount" size="40" maxlength="20"/>
				    </td>
				  </tr>
				  <tr>
				    <td height="34" class="detailtitle"> ��λְ�� </td>
				    <td class="detailcontent">
				    	<textarea name="jobFunction" cols="50" rows="4"/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td height="35" class="detailtitle"> ��λ���� </td>
				    <td class="detailcontent">
				    	<textarea name="jobdesc" cols="50" rows="4"/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td height="35" class="detailtitle"> ��λ��ְ���� </td>
				    <td class="detailcontent">
				    	<textarea name="jobCondition" cols="50" rows="4"/>
				    	</textarea>
				    </td>
				   </tr>
				  <tr>
				    <table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
				      <tr>
				        <td>
					        <div align="center">
					            <input name="Submit" type="button" class="input" value="����" onClick="savejob()">
					        </div>
				        </td>
				        <td>
					        <div align="left">
					         <input type="reset" name="Reset" class="input" value="���" /> 
					        </div>
				        </td>
				        <td>
					        <div align="left"> 
					        	<input name="BackButton" type="button" class="input" value="����" onClick="back()"> 
					        </div>
				        </td>
				      </tr>
				    </table>
				  </tr>
				</table>
			</form>
		</div>
		
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
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
		<iframe name="hiddenFrame" width="0" height="0"></iframe>
	</body>
</html>

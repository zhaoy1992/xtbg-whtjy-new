<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	
	String setDisbaled = "";
	if ( request.getAttribute("userNameDisable") != null ){
		setDisbaled = "disabled = true";
	}		
	
	UserInfoForm user = (UserInfoForm)request.getAttribute("currUser");
	
	if(user == null)
		user = new UserInfoForm();
		
	String isNew = (String)request.getAttribute("isNew");
	if(isNew == null ){
		isNew = "0";
	}
	String entpeach = (String)request.getAttribute("entpeach");
	String outtype="";
	if(entpeach.equals("entp")){
		outtype ="��ҵ";
	}else{
		outtype ="����";
	}
	
	String isaddorupdate = (String)request.getAttribute("isaddorupdate");
	
	if(isaddorupdate == null ){
		isaddorupdate = "1";
	}
%>

<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../../sysmanager/scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../../sysmanager/scripts/validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo</title>
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
	    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {
	font-size: 16px;
	font-weight: bold;
}
-->
        </style>
</head>

<script language="JavaScript">

var reFlush = "<%=reFlush%>";
var userErr = 0;



function trim(string){
  var temp="";
  string = ''+string;
  splitstring = string.split(" ");
  for(i=0;i<splitstring.length;i++){
    temp += splitstring[i];
  } 
  return temp;
 }
function storeUser()
{
	var UserInfoForm = document.all.UserInfoForm;
	var city = UserInfoForm.city.value;
	var area = UserInfoForm.area.value;
	if (UserInfoForm.city.value.length<1){
       alert("��ѡ����(��)!");
	   UserInfoForm.city.focus();
	   return false
    }	
	if (UserInfoForm.area.value.length<1){
       alert("��ѡ�����!");
	   UserInfoForm.area.focus();
	   return false
    }	

	if(UserInfoForm.userRealname.value.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
		UserInfoForm.userRealname.focus();
		return false;
	}
	document.UserInfoForm.userRealname.disabled = false;
	
	if (validateForm(UserInfoForm) )
	{
		var userRealname= document.forms[0].userRealname.value;
		if (trim(userRealname).length == 0 ){
    	alert("�����뵥λ���ƣ�"); 
    	return false;
    } 
    	
   		
		document.UserInfoForm.action="../member/memberManager.do?method=storeEnrollMember&city="+city+"area="+area;
		document.UserInfoForm.submit();
	}
}
function updateUser()
{
	
	document.UserInfoForm.userName.disabled = false;
	
	if (validateForm(UserInfoForm) )
	{
		var userName= document.forms[0].userName.value;
		if (trim(userName).length == 0 ){
    	alert("�������½����"); 
    	return false;
    } 
    	
   		if (confirm("��ȷ��Ҫ�޸ĸ��û���Ϣ��")){
		document.UserInfoForm.action="../member/memberManager.do?method=updateMember&flag=1";
		document.UserInfoForm.submit();
		}
	}
}
function defaultpass()//�ָ��û���ʼ����
{
		var userId= document.forms[0].userId.value;
		if (confirm("��ȷ��Ҫ�ָ�Ϊ��ʼ������")){
			document.UserInfoForm.action="../member/memberManager.do?method=defaultpass&userName="+userId+"&flag=1";
			document.UserInfoForm.submit();
		}
}

function reloadUser(){
	document.UserInfoForm.submit();
}

function newUser()
{
	document.UserInfoForm.action="../user/userManager.do?method=newUser";
	document.UserInfoForm.submit();
}

function back()
{
	document.location.href="../member/memberManager.do?method=getMemberList&flag=1";	
}

function resetuser()
{
	var userId= document.forms[0].userId.value;
	document.location.href="../member/memberManager.do?method=updateMember&memberId="+userId;	
}

function setDisable(v){
	v.disabled = false;
	if  ( document.UserInfoForm.userId.value != "" )
	{
		v.disabled = true;
	}
}


//Ĭ�Ϲ��ͣ�����ĵ����������
	function document.onreadystatechange(){
		if (document.readyState!="complete") return;
		document.all.UserInfoForm.userName.focus();
	}
	
	function outmember()
	{
		document.location.href="../member/memberManager.do?method=newMember&flag=0";
	}
	function entpeach()
	{
		document.location.href="../member/memberManager.do?method=newMember&flag=1&entpeach=each";
	}
	
	</script>
	<script language="JavaScript"> 
<!-- 
var g_selProvince; 
var g_selCity; 
var Provinces=new Array( 
new Array("A","��ɳ��"), 
new Array("B","������"), 
new Array("C","��̶��"), 
new Array("D","������"), 
new Array("E","������"), 
new Array("F","������"), 
new Array("G","������"), 
new Array("I","������"), 
new Array("J","¦�׵���"), 
new Array("K","������"), 
new Array("H","�żҽ���"), 
new Array("L","������"), 
new Array("M","������"), 
new Array("N","������"), 
new Array("P","ʡ����")

); 

var Citys=new Array( 

new Array("A01","��ɳ��ֱ"), 
new Array("A02","ܽ����"), 
new Array("A03","������"),
new Array("A04","��´��"),
new Array("A05","������"),
new Array("A06","�껨��"),
new Array("A07","��ɳ��"),
new Array("A08","������"),
new Array("A09","�����"),
new Array("A10","������"),

new Array("B01","������ֱ"), 
new Array("B02","��Ԫ��"), 
new Array("B03","������"),
new Array("B04","ʯ����"),
new Array("B05","«����"),
new Array("B06","������"),
new Array("B07","������"),
new Array("B08","����"),
new Array("B09","������"),
new Array("B10","������"),

new Array("C01","��̶��ֱ"), 
new Array("C02","������"), 
new Array("C03","������"),
new Array("C04","��ɽ��"),
new Array("C05","������"),
new Array("C06","��̶��"),

new Array("D01","������ֱ"), 
new Array("D02","������"), 
new Array("D03","������"),
new Array("D04","�Ǳ���"),
new Array("D05","����"),
new Array("D06","������"),
new Array("D07","������"), 
new Array("D08","������"), 
new Array("D09","������"),
new Array("D10","��ɽ��"),
new Array("D11","�ⶫ��"),
new Array("D12","������"),
new Array("D13","���"),

new Array("E01","������ֱ"), 
new Array("E02","˫����"), 
new Array("E03","������"),
new Array("E04","������"),
new Array("E05","�۶���"),
new Array("E06","������"),
new Array("E07","������"), 
new Array("E08","¡����"), 
new Array("E09","�����"),
new Array("E10","������"),
new Array("E11","������"),
new Array("E12","������"),
new Array("E13","�ǲ���"),

new Array("F01","������ֱ"), 
new Array("F02","����¥��"), 
new Array("F03","��Ϫ��"),
new Array("F04","������"),
new Array("F05","������"),
new Array("F06","ƽ����"),
new Array("F07","������"), 
new Array("F08","������"), 
new Array("F09","������"),
new Array("F10","��ɽ��"),
new Array("F11","��ԭ��"),

new Array("G01","������ֱ"), 
new Array("G02","������"), 
new Array("G03","������"),
new Array("G04","��ɽ��"),
new Array("G05","������"),
new Array("G06","������"),
new Array("G07","������"), 
new Array("G08","���"), 
new Array("G09","�����"),
new Array("G10","��Դ��"),
new Array("G11","ʯ����"),

new Array("I01","������ֱ"), 
new Array("I02","��ɽ��"), 
new Array("I03","������"),
new Array("I04","�佭��"),
new Array("I05","����"),
new Array("I06","�һ���"),
new Array("I07","������"), 

new Array("J01","¦�׵�ֱ"), 
new Array("J02","¦����"), 
new Array("J03","��ˮ����"),
new Array("J04","��Դ��"),
new Array("J05","˫����"),
new Array("J06","�»���"),

new Array("K01","������ֱ"), 
new Array("K02","������"), 
new Array("K03","������"),
new Array("K04","������"),
new Array("K05","������"),
new Array("K06","������"),
new Array("K07","������"), 
new Array("K08","�κ���"), 
new Array("K09","������"),
new Array("K10","�����"),
new Array("K11","����"),
new Array("K12","������"),
 
new Array("H01","�żҽ���ֱ"), 
new Array("H02","������"), 
new Array("H03","����Դ��"),
new Array("H04","������"),
new Array("H05","ɣֲ��"),

new Array("L01","������ֱ"), 
new Array("L02","֥ɽ��"), 
new Array("L03","��ˮ̲��"),
new Array("L04","������"),
new Array("L05","����"),
new Array("L06","��Զ��"),
new Array("L07","������"), 
new Array("L08","������"), 
new Array("L09","��ɽ��"),
new Array("L10","������"),
new Array("L11","˫����"),
new Array("L12","������"),

new Array("M01","������ֱ"), 
new Array("M02","�׳���"), 
new Array("M03","�齭��"),
new Array("M04","�з���"),
new Array("M05","������"),
new Array("M06","��Ϫ��"),
new Array("M07","������"), 
new Array("M08","������"), 
new Array("M09","�»���"),
new Array("M10","�ƽ���"),
new Array("M11","��ͬ��"),
new Array("M12","������"),
new Array("M13","ͨ����"),
   
new Array("N01","������ֱ"), 
new Array("N02","������"), 
new Array("N03","��Ϫ��"),
new Array("N04","�����"),
new Array("N05","��ԫ��"),
new Array("N06","������"),
new Array("N07","������"), 
new Array("N08","��˳��"), 
new Array("N09","��ɽ��"),

new Array("P01","����"), 
new Array("P02","���в�"), 
new Array("P03","��ѯ��"),
new Array("P04","�칫��"),
new Array("P05","������"),
new Array("P06","��沿"),
new Array("P07","��ֽ�༭"), 
new Array("P08","ҩƷ��"), 
new Array("P09","�������"),
new Array("P10","���Ľ���")
); 

function FillProvinces(selProvince) 
{ 
	selProvince.options[0]=new Option("��ѡ��",""); 
	for(i=0;i<Provinces.length;i++) 
	{ 
	selProvince.options[i+1]=new Option(Provinces[i][1],Provinces[i][0]); 
	} 
	selProvince.options[0].selected=true; 
	selProvince.length=i+1; 
} 

function FillCitys(selCity,ProvinceCode) 
{ 
	//if the city is a direct-managed area, like Beijing, shanghai, tianjin, chongqin,hongkong, macro 
	//need not "��ѡ��ѡ��" 
	if(ProvinceCode=="A"||ProvinceCode=="B"||ProvinceCode=="C" 
	||ProvinceCode=="D"||ProvinceCode=="E"||ProvinceCode=="F") 
	count=0; 
	else 
	{selCity.options[0]=new Option("��ѡ��",""); 
	count=1;} 
	for(i=0;i<Citys.length;i++) 
	{ 
		if(Citys[i][0].toString().substring(0,1)==ProvinceCode.substring(0,1)) 
		{ 
		selCity.options[count]=new Option(Citys[i][1],Citys[i][0]); 
		count=count+1; 
		} 
	} 
	selCity.options[0].selected=true; 
	selCity.length=count; 
} 

function Province_onchange() 
{ 
	FillCitys(g_selCity,g_selProvince.value); 
} 

function InitCitySelect(selProvince,selCity) 
{ 
	//alert("begin"); 
	g_selProvince=selProvince; 
	g_selCity=selCity; 
	selProvince.onchange=Function("Province_onchange();"); 
	FillProvinces(selProvince); 
	Province_onchange(); 
} 
function InitCitySelect2(selProvince,selCity,CityCode) 
{ 
	InitCitySelect(selProvince,selCity) 
	for(i=0;i<selProvince.length;i++) 
	{ 
		if(selProvince.options[i].value.substring(0,2)==CityCode.substring(0,2)) 
		{ 
		selProvince.options[i].selected=true; 
		} 
	} 
	Province_onchange(); 
	for(i=0;i<selCity.length;i++) 
	{ 
		if(selCity.options[i].value==CityCode) 
		{ 
		selCity.options[i].selected=true; 
		} 
	} 
} 
//--> 
</script>
	<body class="info"  onload="">
		<form   name="UserInfoForm" method="post">
		<pg:beaninfo requestKey="currUser">
		<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<input type="hidden" name="remark3" value="<pg:cell colName="remark3"  defaultValue=""/>" />
		<input type="hidden" name="shortMobile" value="<pg:cell colName="shortMobile"  defaultValue=""/>" />
		
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" >
			 <tr height="35">
				<td colspan=4 height="25" class="detailtitle">
				  <div align="center">
			        <%if(isNew.equals("1")){%>
					  <span class="style2">����ע���û�</span>
			        <%}else{%>
					  <span class="style2">�޸�ע���û���Ϣ</span>
			        <%}%>
				    </div></td>
			</tr>
			 <tr height="35">
				<td colspan=4 height="25" class="detailtitle">
				</td>
			</tr>		
			<%if(isNew.equals("1")){%>
				 <tr>
				 <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" class="detailtitle" width="23%"><strong>��Ա������(��)��</strong></td>
                  <td height="25">  
           						<SELECT id=city size=1 name=city style="width:160px">
           						<OPTION selected></OPTION>
           						</SELECT> 
           						<span class="STYLE1">*</span>
  				  </td>
  				 
  				 </tr>
  				  <tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>����:</strong></td>
  				  <td height="25" >
				  		
                    			<SELECT id=area size=1 name=area style="width:160px"><OPTION selected></OPTION></SELECT> 
									<SCRIPT language=javascript> 
											InitCitySelect(document.UserInfoForm.city,document.UserInfoForm.area); 
								</SCRIPT> 
								<span class="STYLE1">*����ѡ����(��)</span>
				  </td>
				
  				 </tr>  
			<%}%>
			<%if(!isNew.equals("1")){%>
			<tr>
				<td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle" width="23%"><strong>�ʺ�:</strong></td>						
				<td height="25">
					<input type="text" style="width:160px" id="userName" name="userName" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="��½��" maxlength="100" <%=setDisbaled%> onfocus="setDisable(this)"><span class="STYLE1">*</span>
				</td>
				
			</tr>
			<%}%>
			<tr>
				<td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle" width="20%"><strong>��Ա����:</strong></td>						
				<td height="25">
					<input type="text" style="width:160px" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="�û�����" maxlength="100"><span class="STYLE1">*</span>
				</td>
				
			</tr>
			            
			<tr>	
				<td height="25" class="detailtitle" width="23%"></td>					
				<td height="25" class="detailtitle"><strong> ����:</strong></td>
				<td height="25">
					<input type="password" style="width:160px" name="userPassword" value="<pg:cell colName="userPassword"  defaultValue="123456"/>" validator="string" cnname="����" maxlength="40">
					<span class="STYLE1">*ȱʡ����Ϊ123456</span>
				</td>
			</tr>
			
			<tr>
				<td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle">
						<strong>��ϵ��ַ:</strong>
				</td>
				<td  height="25">
						<input type="text" style="width:160px" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" >
				</td>
				
			</tr>
			<tr>
				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>��λ����:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="enterpriseName" value="<pg:cell colName="enterpriseName"  defaultValue=""/>"  maxlength="100">
				  </td>
				 
  			</tr>
  			<tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>��ϵ��:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="enterpriseLinkman" value="<pg:cell colName="enterpriseLinkman"  defaultValue=""/>">
				  </td>
				 
  			</tr>
  			<tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>��ϵ�绰:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>"  cnname="��λ�绰" maxlength="13">
				  </td>
				 
  			</tr>
  			<tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>�����ʼ�:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="mail" value="<pg:cell colName="mail"  defaultValue=""/>" validator="emailNull" cnname="�����ʼ�" maxlength="40">
				  </td>
				 
  			</tr>
  			<tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>��λ��ַ:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="network_address" value="<pg:cell colName="network_address"  defaultValue=""/>" >
				  </td>
				 
  			</tr>
  			<tr>
  				  <td height="25" class="detailtitle" width="23%"></td>
                  <td height="25" width="20%" class="detailtitle" width="23%"><strong>�û�״̬:</strong></td>
  				  <td height="25" >
				  		<input type="text" style="width:160px" name="" value="������" readonly="true">
				  </td>
				 
  			</tr>     
			<tr>
			    <td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle">
					<strong> ��������ʱ����:</strong>
				</td>
				<td height="25">
					<input type="text" style="width:160px" name="question" value="<pg:cell colName="question"  defaultValue=""/>" maxlength="100">
				</td>
			
			</tr>
			
			<tr>
				<td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle">
					<strong>��������ʱ��:</strong>
				</td>
				<td height="25">
					<input type="text" style="width:160px" name="answer" value="<pg:cell colName="answer"  defaultValue=""/>" maxlength="40">
				</td>
				
			</tr>
			
			
			
			<tr>
				 <td height="25" class="detailtitle" width="23%"></td>
				 <td height="25" class="detailtitle"><strong>��Ա���:</strong></td>
				 <td height="25">
				  		<input type="text" style="width:160px" name="" value="F���ɫ" readonly="true">
				 </td>	
				 
		   </tr>
		     <tr>
		   		<td height="25" class="detailtitle" width="23%"></td>
				<td height="25" class="detailtitle">
					<strong>��������:</strong>
				</td>
				<td colspan=3 height="25">
					<input type="text" style="width:160px" name="postalCode" value="<pg:cell colName="postalCode"  defaultValue=""/>" validator="intNull" cnname="��������" maxlength="8">
				</td>
		 </tr>      
		 <tr>
		   		<td height="25" class="detailtitle" width="23%"></td>
		   		<td height="25" class="detailtitle">
						<strong>������Դ˵��:</strong>
				</td>
				<td  colspan=3 height="25">
						<input type="text" style="width:160px" name="serverexplain" value="<pg:cell colName="serverexplain"  defaultValue=""/>" maxlength="100">
				</td>
		  </tr>
		
		 <tr>
		 	<td height="25" class="detailtitle" width="23%"></td>
			<td height="25" class="detailtitle">
				<strong>��λ���:</strong>
			</td>
			<td colspan=3 height="25">
				<textarea name="enterpriseIntro"   cols="40" rows="2" defaultValue=""><pg:cell colName="enterpriseIntro" defaultValue=""/></textarea>
			</td>
		</tr>
		 <tr>
		 	<td height="25" class="detailtitle" width="23%"></td>
			<td height="25" class="detailtitle">
				<strong>��ע:</strong>
			</td>
			<td colspan=3 height="25">
				<textarea name="user_desc"   cols="40" rows="2" defaultValue=""><pg:cell colName="user_desc" defaultValue=""/></textarea>
			</td>
		</tr>			
				
					<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />
					<input type="hidden" name="userRegdate" value="<pg:cell colName="userRegdate"  defaultValue=""/>" />
		</table>
		  </pg:beaninfo>
		</form>
		
		
		<table width="100%" cellpadding="2" cellspacing="0" >
			<tr>
				<td align="center">
						<%
							//����û�����ð�ť
							if(isNew.equals("0")){
						%>
						<input name="update" type="button" class="input" value="�޸�" onClick="updateUser()">
						<input name="default" type="button" onClick="defaultpass()" class="input" value="����ָ�">
						<%
						}
						else {
						%>
						<input name="resave" type="button" class="input" value="����" onClick="storeUser()">
						<%}%>
						<input name="Submit32" type="submit" class="input" value="����" onClick="back()">
				</td>
			</tr>
		</table>
		
	</body>
</html>
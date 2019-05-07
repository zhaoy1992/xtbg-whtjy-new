<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%	
	//Ȩ��(�ɼ�)��ϵ���������б�
		
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	//�ֵ�����ID
	String ids = request.getParameter("did");
	String typeName = request.getParameter("typeName");	
	//����ID
	String orgId = request.getParameter("orgId");
	ids = ids==null?"":ids;
	typeName = typeName==null?"":typeName;	
	orgId = orgId==null?"":orgId;
	String dicttype_name = "";
	String did = "";
	//ʵ������datavalue ���������ֵ
	String dictdataValue = "";
	String dictdataName = "";
	session.setAttribute("dictTabId", "2");
	Data dtype = null;	
	DictManager dictManager = null;
	String data_org = "";
	if(!"".equals(ids)){
		dictManager = new DictManagerImpl();
		did = ids;
		dtype = dictManager.getDicttypeById(did);
		dicttype_name = dtype.getName();
		data_org = dtype.getData_create_orgid_field();
	}
	if(dtype == null){
		dtype = new Data();
	}	
	
	if("root".equals(dictdataValue)){
	    dictdataValue="0";
	}
	 String showdata = request.getParameter("showdata");
    if(showdata == null || "".equals(showdata)){
    	showdata = "";
    }
%>
<html>
	<head>
		<title>��������</title>
		<link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<script language="JavaScript" src="../../user/common.js" type="text/javascript"></script>

  
<SCRIPT language="javascript">
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	var win;
	var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
	
function queryData(){
	var showdata = document.all.showdata.value;
	var orgId = "<%=orgId%>";
	var path = "org_dictdataList.jsp?did=<%=did%>&typeName=<%=typeName%>&orgId="+orgId+"&showdata="+showdata+"&identifier=sealed";
	dictList.action = path;
	dictList.submit();
	document.location.href=path;
}
<!--Ϊ��ҳ�ύ��׼��-->
function turnPageSumbmitSet(){

    //ǰ�� ѡ���˻��� ѡ�����ֵ�����.
    var orgId = "";
    var dicttypeId = "";
    if(parent.parent.orgTaxcode){	            
        if(parent.parent.orgTaxcode.document.frames[0]){
            dicttypeId = parent.parent.orgTaxcode.document.frames[0].document.all("selected_typeId").value;
        }
        if(parent.parent.orgTaxcode.document.frames[1]){
            orgId = parent.parent.orgTaxcode.document.frames[1].document.all("orgId").value;
        }
	}
	
	if(orgId.length==0){
	    return false;
	    //alert("û��ѡ�����,�˴η�ҳ���޷���������!");
	    
	}
		
    if(orgId.length>0 && dicttypeId.length>0){
	    var dicttypeValues = "";
		//var un_dicttypeValues = "";
		var arr = document.getElementsByName("dictdataValue");
	    for(var i=0;i<arr.length;i++){
	        if(arr[i].checked==true){
	            if(dicttypeValues=="") dicttypeValues = arr[i].value;
	            else dicttypeValues = dicttypeValues + "," + arr[i].value;
	        }
	        //else{
	        //    if(un_dicttypeValues=="") un_dicttypeValues = un_dicttypeValues + arr[i].value;
	        //    else un_dicttypeValues = un_dicttypeValues + "," + arr[i].value;
	        //}	                    
	    }
	    if(dicttypeValues==""){
	        return false;
	    }
	    //����--���� utf-8
	    document.all.selectedNodeValue.value = encodeURI(dicttypeValues);//ѡ�е�checkbox
	    //document.all.un_selectedNodeValue.value = encodeURI(un_dicttypeValues);//δѡ��checkbox
	    //document.all.selectedNodeValue.value = dicttypeValues;
	    document.all.sendOrgId.value = orgId;
	    document.all.sendDicttypeId.value = dicttypeId;	
	    document.all.data_org.value = "<%=data_org%>";
	    document.all.readOp.value = "save";
	    return true;
    }
    
}


<!-- ���� -->
</SCRIPT>		
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" action="pageSaveandDel.jsp" method="post" target="hiddenFrame">
		    <!--Ϊ��ҳ�ύ��׼��-->
		    <input type="hidden" name="selectedNodeValue">
            <input type="hidden" name="sendOrgId"> 
            <input type="hidden" name="sendDicttypeId">
            <input type="hidden" name="readOp">
            <input type="hidden" name="data_org">
            <input type="hidden" name="dictdataValues">
           
            <!-- ���� -->	
		    <br/>
			<p align="center"><font size=2><strong>δ������</strong></font>
			<br/>
			
			<table id="oTable" cellspacing="1" cellpadding="0" border="0" width=100%  class="thin">
			<tr align="right" style="text-align:left">
				<td colspan="4" align="right" style="text-align:left">�����<input name="showdata" value="<%=showdata%>" type="text" />
					<input name="querySub" type="button" class="input" value="��ѯ" onclick="queryData()" />
					<input name="retSub" type="button" class="input" value="����" onclick="document.all.showdata.value='';" />
				</td>
			</tr>
				<pg:listdata dataInfo="com.chinacreator.dictionary.tag.UserDictListSelected" keyName="DictList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<!--Ϊ��ҳ�ύ��׼�� form="dictList" promotion="false" commitevent="turnPageSumbmitSet()" -->
				<pg:pager form="dictList" maxPageItems="10" scope="request" promotion="true" data="DictList"  isList="false">
				
				    <tr>
						<!--���÷�ҳ��ͷ-->
						<td class="headercolor" >
							<input type="checkBox"  name="checkBoxAll" onClick="checkAll('checkBoxAll','dictdataValue')">
						</td>						
						<td class="headercolor" >������</td>	
						<%if(!data_org.equals("") && data_org != null){%>
						<td class="headercolor">��������</td>	
						<%}%>
					<tr>					
					<pg:param name="did" />
					<pg:param name="typeName" />
					<pg:param name="orgId" />
					<pg:param name="identifier" />
					<!--��⵱ǰҳ���Ƿ��м�¼-->
					<pg:notify>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=100 align='center'>
								��ʱû������
							</td>
						</tr>
					</pg:notify>
					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<tr onclick="checkTrue(this);">							
							<td class="tablecells" style="width:20%" nowrap="nowrap" style="text-align:center" >
								<pg:equal colName="dataValidate" value="1">
									<input type="checkbox" name="dictdataValue" 
									value="<pg:cell colName='value' defaultValue='' />:<pg:cell colName='name' defaultValue='' /><%if(!data_org.equals("") && data_org != null){%>:<pg:cell colName="dataOrg" defaultValue="" /><%}%>" />
								</pg:equal>
								<pg:equal colName="dataValidate" value="0">
									<input type="checkbox" disabled="true" name="dictdataValue" 
									value="<pg:cell colName='value' defaultValue='' />:<pg:cell colName='name' defaultValue='' /><%if(!data_org.equals("") && data_org != null){%>:<pg:cell colName="dataOrg" defaultValue="" /><%}%>" />
								</pg:equal>
								<pg:null colName="dataValidate" >
									<input type="checkbox"  name="dictdataValue" 
									value="<pg:cell colName='value' defaultValue='' />:<pg:cell colName='name' defaultValue='' /><%if(!data_org.equals("") && data_org != null){%>:<pg:cell colName="dataOrg" defaultValue="" /><%}%>" />
								</pg:null>
							</td>									
							<td class="tablecells" style="width:80%;text-align:left"  nowrap="nowrap" >								
								<pg:cell colName="name" defaultValue="" />
							</td>
							<%if(!data_org.equals("") && data_org != null){%>
							<td class="tablecells" style="width:80%;text-align:left"  nowrap="nowrap" >								
								<pg:cell colName="dataOrg" defaultValue="" />
							</td>
							<%}%>
						</tr>
					</pg:list>
					<input name="dictTypeId" value="<%=did%>" type="hidden">
				    <tr height="30" class="labeltable_middle_tr_01">
						<td colspan=100 align='center'>��<pg:rowcount/>����¼<pg:index />
						<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
					</tr>
					<tr height="30" class="labeltable_middle_tr_01">
					<td  colspan=100 align='center'>
					<input name="saveRead" type="button" class="input" value="����ѡ��δ������" onClick="saveReadUnsetup();" />
					<input name="saveAllRead" type="button" class="input" value="����ȫ��δ������" onClick="saveAllReadUnsetup();" />
					</td>
					</tr>
                
			</pg:pager>
		  </table>
		</form>
		<iframe height="0" width="0" name="hiddenFrame"></iframe>
	</body>
	<script language="javascript">
	function saveReadUnsetup(){
		var dictdataValues = "";
		var obj=document.getElementsByName("dictdataValue");
		var n = 0;
		var dicttypeId = "";
		var orgId = "";
	    if(parent.parent.orgTaxcode){	            
	        if(parent.parent.orgTaxcode.document.frames[0]){
	            dicttypeId = parent.parent.orgTaxcode.document.frames[0].document.all("selected_typeId").value;
	        }
	        if(parent.parent.orgTaxcode.document.frames[1]){
	            orgId = parent.parent.orgTaxcode.document.frames[1].document.all("orgId").value;
	        }
		}
		if(orgId.length==0){
		    alert("û��ѡ�����,������Ч!");
		    return;
		}
		for(var i=0;i< obj.length;i++){
		    if(obj[i].checked){
		    	if(dictdataValues == ""){
		    		dictdataValues = obj[i].value;
		    	}else{
		    		dictdataValues += "," + obj[i].value;
		    	}
		    	n++;
		    }
		}
		if(n == 0){
			alert("û��ѡ��Ҫ�����δ�����");
		}else{
			document.all.dictdataValues.value = dictdataValues;
			dictList.action = "saveOrgTaxcodeRead.jsp?dicttypeId="+dicttypeId+"&orgId="+orgId+"&state=read&data_org=<%=data_org%>";
			dictList.submit();
		}
	}
	
	function saveAllReadUnsetup(){
		var obj=document.getElementsByName("dictdataValue");
		if(obj.length==0){
			alert("û��Ҫ�����δ���������ݣ�");
			return;	
		}
		var dicttypeId = "";
		var orgId = "";
	    if(parent.parent.orgTaxcode){	            
	        if(parent.parent.orgTaxcode.document.frames[0]){
	            dicttypeId = parent.parent.orgTaxcode.document.frames[0].document.all("selected_typeId").value;
	        }
	        if(parent.parent.orgTaxcode.document.frames[1]){
	            orgId = parent.parent.orgTaxcode.document.frames[1].document.all("orgId").value;
	        }
		}
		if(orgId.length==0){
		    alert("û��ѡ�����,������Ч!");
		    return;
		}
		dictList.action = "saveOrgTaxcodeRead.jsp?identifier=sealed&dicttypeId="+dicttypeId+"&orgId="+orgId+"&state=allRead&data_org=<%=data_org%>";
		dictList.submit();
	}
	
	function checkTrue(obj){
	
	}
	</script>	
</html>


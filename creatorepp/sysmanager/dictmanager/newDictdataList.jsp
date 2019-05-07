<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.dictionary.input.InputType"%>
<%@ page import="com.chinacreator.dictionary.DictAttachField,
				com.chinacreator.dictionary.input.InputTypeScript,
				com.chinacreator.dictionary.input.InputTypeScriptImpl"%>
<%@ page import="java.util.*"%>
<%	 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String currentOrgName = accesscontroler.getChargeOrg() != null ?accesscontroler.getChargeOrg().getRemark5():"";
	String currentOrgIdNO = accesscontroler.getChargeOrgCode();
	String ids = request.getParameter("did");	
	String selected = request.getParameter("selected");
	String dicttypeId = request.getParameter("dicttypeId");
	ids = ids==null?"":ids;
	if("".equals(ids)){
	    ids = request.getParameter("selected");
	}
	String dicttype_name = "";
	String did = "";
	//ʵ������datavalue ���������ֵ
	String dictdataValue = "";
	String dictdataName = "";
	session.setAttribute("dictTabId", "2");
	Data dtype = null;	
	DictManagerImpl dictManager = new DictManagerImpl();
	dictManager.init(request,response);
	if(!"".equals(ids)){
		
		String[] ids_ = ids.split(":");
		if(ids_.length>1){
			did = ids_[0];	
			dictdataValue = ids_[1];
			if(!"root".equals(ids_[2])){
			    dictdataName = ":"+ids_[2];
			}
		}else{
		    did = ids;	
			dictdataValue = "root";
		}
		dtype = dictManager.getDicttypeById(did);
		dicttype_name = dtype.getName();
	}
	if(dtype == null){
		dtype = new Data();
	}	
	String dbname = dtype.getDataDBName();
    String tablename = dtype.getDataTableName();
    String dataNameField = dtype.getDataNameField();
    String dataValueField = dtype.getDataValueField();
    
    //�ֵ�����:�����ֶζ���
    ColumnMetaData nameObj = DBUtil.getColumnMetaData(dbname,tablename,dataNameField);
    //�ֵ�����:ֵ�ֶζ���
    ColumnMetaData valueObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueField);
    //�������Ƿ���Ч,���б�������,ͬʱ��ʾ"ͣ��/���ù���"
    boolean showDataValidate = false;
    String dataValidate = dtype.getData_validate_field();
    //��������������,�ɶ��,ȱʡ�ǵ�½�û��Ļ���,��������ʱ������,���б�����
    boolean showDataValueOrg = false;
    String dataValueOrg = dtype.getData_create_orgid_field();
    
    //�Ƿ��������ֶ�,�����Ƿ���ʾ����ť
    boolean showOrderButton = false;
    String dataOrderField = dtype.getDataOrderField();
    if(dataOrderField != null && dataOrderField.trim().length()>0){
        showOrderButton = true;
    }
    
    //��ά�������ֶ�
    String data_name_cn = dtype.getField_name_cn()==""?"����":dtype.getField_name_cn();
    String data_value_cn = dtype.getField_value_cn()==""?"��ʵֵ":dtype.getField_value_cn();
	
	if("root".equals(dictdataValue)){
	    dictdataValue="";
	}
	String nameValidType = dictManager.getValidatorTypeByColumnMetaData(nameObj);
    String valueValidType = dictManager.getValidatorTypeByColumnMetaData(valueObj);
    
    String dataValidateType = "";
    String dataValidateTypeName = "";
    String dataOrgType = "";
    String dataOrgTypeName = "";
    if(dataValidate != null && dataValidate.trim().length()>0){
        //�ֶ�����:�Ƿ���Ч
        showDataValidate = true;
    	ColumnMetaData validateObj = DBUtil.getColumnMetaData(dbname,tablename,dataValidate);
        dataValidateType = dictManager.getValidatorTypeByColumnMetaData(validateObj);
        dataValidateTypeName = validateObj.getTypeName();
    }
    if(dataValueOrg != null && dataValueOrg.trim().length()>0){        
    	//�ֶ�����:��������������
    	showDataValueOrg = true;
    	ColumnMetaData dataOrgObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueOrg);
        dataOrgType = dictManager.getValidatorTypeByColumnMetaData(dataOrgObj);
        dataOrgTypeName = dataOrgObj.getTypeName();
    }
    
    
    List dictatts = dictManager.getDictdataAttachFieldList(dicttypeId,-1);
%>

<html>
	<head>
		<base target="_self">
		<title>��<%=dicttype_name%><%=dictdataName%>���߼������б�</title>
		<link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
        <SCRIPT language="JavaScript" SRC="../user/validateForm.js"></SCRIPT>
<SCRIPT language="javascript">
	
	function queryDictItem(){
	  var tablesFrame= document.getElementsByName("theIframe");
	  var showdata = document.all.showdata.value;
		var realitydata = document.all.realitydata.value;
		var occurOrg = "";
		if(document.all.occurOrg){
			occurOrg = document.all.occurOrg.value;
		}
		var isaVailability = "-1";
		if(document.all.isaVailability){
			isaVailability = document.all.isaVailability.value;
		}
	  tablesFrame[0].src = "newDictdataList_iframe.jsp?did=<%=ids%>&selected=<%=selected%>&dicttypeId=<%=did%>&showdata="+showdata+"&realitydata="+realitydata+"&occurOrg="+occurOrg+"&isaVailability="+isaVailability;
	}
	
	function resetQuery(){
		document.all.showdata.value="";
		document.all.realitydata.value="";
		if(document.all.occurOrg){
			document.all.occurOrg.value="";
		}
		if(document.all.isaVailability){
			document.all.isaVailability.value="-1";
		}
	}
</SCRIPT>
    </head>
  	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" method="post" target="hiddenFrame">
		<table  width="98%" border="0"   cellpadding="0" cellspacing="1" class="thin">
			    <tr>
   					<td height='30'  colspan="2"><img src='../images/edit.gif' height="16" border=0 >
   					    &nbsp;<strong>��<%=dicttype_name%><%=dictdataName%>���߼������б�</strong>
   					</td>
 				</tr>
 				<tr>
 				<td colspan="2" align="right" style="text-align:left">
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=data_name_cn%>��<input name="showdata" value="" type="text" />
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				&nbsp;&nbsp;&nbsp;<%=data_value_cn%>��<input name="realitydata" value="" type="text" />
 				</td>
 				</tr>
 				<tr>
 				<td colspan="2" align="right" style="text-align:left">
 				<%if(showDataValueOrg){%>
 				�ɼ�������<input name="occurOrg" value="" type="text" />
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				<%}%>
 				<%
 					 if(showDataValidate){
 				%>
 				�Ƿ����ã�<select name="isaVailability">
			    		<option value="-1">--��ѡ��--</option>
			    		<option value="1">����</option>
			    		<option value="0">ͣ��</option>
			    	    </select>
			   	<%
			   		}
			   	%>
			    </td>
 				</tr>
			    <tr>
			    <td colspan="2" align="right" style="text-align:right">
			    <input name="queryBut" type="button" value="��ѯ" class="input" onClick="queryDictItem();" />
			    <input name="resetBut" type="button" value="����" class="input" onclick="resetQuery();" />
			    <input name="closeBut" type="button" value="�ر�" class="input" onclick="window.close();" />
			    </td>
			    </tr>
 		</table>
			<table cellspacing="1" cellpadding="0" border="0" width=98% height=100%  class="thin">
				<tr><td>
				<iframe name="theIframe" src="newDictdataList_iframe.jsp?did=<%=ids%>&selected=<%=selected%>&dicttypeId=<%=did%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1"></iframe>
				</td></tr>
		  </table>
		</form>
		<iframe height="0" width="0" name="hiddenFrame"></iframe>
	</body>
		
</html>
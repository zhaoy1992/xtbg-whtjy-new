<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
String submittedinfoId = request.getParameter("submittedinfoId");
String state = request.getParameter("state");

String rolename = "reportGetUser";//��ɫ���ƣ�reportGetUser�ϱ������˽�ɫ��sendGetUser��������˽�ɫ

AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String inputuser_id = accesscontroler.getUserID();
String inputuser_name = accesscontroler.getUserName();
String org_id = accesscontroler.getChargeOrgId();
String subid=request.getParameter("subid");
AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
String rolesNames = "";
StringBuffer buf = new StringBuffer();
for(int i=0;i<authRoles.length;i++){
	buf.append(authRoles[i].toString()+ ",");
}    
rolesNames = buf.toString();
if(rolesNames.length()>0){
rolesNames = rolesNames.substring(0,rolesNames.length()-1);
}
String type = "public";

if(rolesNames.indexOf("��Ϣ�ϱ�������")!=-1){
	type = "chushen";
}else if(rolesNames.indexOf("��Ϣ�ϱ�������")!=-1){
	type = "fushen";
}

InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");

InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao.findInfoReportBaseInfo(submittedinfoId);

GetInfoUserBean getInfoUserBean = new GetInfoUserBean();
List<InfoReportAuditIdeaBean> auditlist = null;
String canShowAuditIdea = "'"+InfoType.HAS_BE_SUBMITTED+"','"+InfoType.HAS_BE_SUBMITTED_REAUDIT+"','"+InfoType.HAS_BE_PUBLISHED+"','"+InfoType.HAS_BE_AUDIT+"'";
if(InfoType.NOT_BE_DEALWITH_LEADER.equals(state)){//�쵼������״̬
	getInfoUserBean = infoReportdao.findUser4InfoReport(submittedinfoId,InfoType.HAS_BE_SUBMITTED_REAUDIT);
	auditlist = infoReportdao.findInfoReportAuditListByUser(submittedinfoId,canShowAuditIdea,"");
}

GetInfoUserBean getInfoUserBeanRejection = new GetInfoUserBean();
if(InfoType.NOT_BE_DEALWITH_REAUDIT.equals(state)){//�����ߴ�����״̬
	getInfoUserBeanRejection = infoReportdao.findUser4InfoReport(submittedinfoId,InfoType.HAS_BE_SUBMITTED);
	auditlist = infoReportdao.findInfoReportAuditListByUser(submittedinfoId,canShowAuditIdea,"");
}

if(InfoType.NOT_BE_DEALWITH.equals(state) || InfoType.HAS_BE_REJECTION_REAUDIT.equals(state)){//�����ߴ�����״̬
	getInfoUserBeanRejection = infoReportdao.findUser4InfoReport(submittedinfoId,InfoType.HAS_BE_REPORTED);
}
String typeflag = request.getParameter("type");
boolean isExsitReporter = false;//�Ƿ�����ϱ���

StringBuffer reporterSql = new StringBuffer(); 
	reporterSql.append("select count(*) ");
	reporterSql.append("from ta_oa_infre_audit a ");
	reporterSql.append("where a.submittedinfo_id = '"+submittedinfoId+ "'");
	reporterSql.append("  and a.andit_state = '2' ");


String result = DaoUtil.SqlToField(reporterSql.toString());
if(Integer.parseInt(result) > 0){
	isExsitReporter = true;
}
String tablepage = request.getParameter("tablepage");

if(null == tablepage){
	tablepage ="";
}

String windowId = request.getParameter("windowId");
if(windowId == null){
	windowId="";
}
String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
String operwindowid = request.getParameter("operwindowid");
String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id",StringUtil.deNull(infoReportBaseInfoBean.getInfotype_id()),"",true,"","width:188px");//��Ϣ����������
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.GetInfoUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoReportServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>��Ϣ�������չʾ</title>
</head>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- ����my97ʱ��ؼ� -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- ����formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- �����������ý��� -->
<script type="text/javascript">
var type = '<%=type%>';
var state = "<%=state%>";
var typeflag ='<%= typeflag%>'
//�Ƿ����쵼����
var leadedit_state='<%=infoReportBaseInfoBean.getLeadedit_state()%>';
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	//$("#eWebEditor1").append($("#submit_content").val());
	jQuery("#form1").validationEngine();
});

	function validateForm(){
		var str = eWebEditor1.getHTML();
			$('#submit_content').val(str);
			if(IsSpace($('#submit_content').val())){
				alert("���ݲ���Ϊ��");
				return false;
			}
			
			return true;
	}

	/* ���� */
	var publishInfo = function (){
		$("#published_user_name").addClass("validate[required]"); // ���������˲���Ϊ��
		$("#sendaudit_user_name").removeClass("validate[required]");
		if(jQuery("#form1").validationEngine("validateform")){
			if(validateForm()){
				var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
				$("#sendaudit_user_name").val("");//����������������
				$("#sendauditusers").val("");
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_PUBLISHED%>,<%=InfoType.HAS_BE_SAVEINFO%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_VIEW%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
				
				var okF = function(){
					document.all.form1.action = url;
					document.all.form1.target = "hiddenFrame";
					$('#form1').submit();
					}
					 var p={
						headerText:'��ʾ',
						okName:'ȷ��',
					    okFunction:okF,
					    cancelName:'ȡ��'
					};
				alert('ȷ��Ҫ������',p);
			}
		}
		
	}

	/* ���� */
	var sendauditInfo = function (){
		$("#sendaudit_user_name").addClass("validate[required]");
		$("#published_user_name").removeClass("validate[required]");
		if(jQuery("#form1").validationEngine("validateform")){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//��շ�������������
			$("#partunits").val("");//��շ�������������
			
			if("<%=InfoType.NOT_BE_DEALWITH%>" == state){//����ǳ�����-δ���״̬
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH%>");
			}else if("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>" == state){//����Ǹ�����-δ���״̬
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED_REAUDIT%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_LEADER%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			}else if("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>" == state){
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED_REAUDIT%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>");
			}
			var okF = function(){
				document.all.form1.action = url;
				document.all.form1.target = "hiddenFrame";
				$('#form1').submit();
				}
				 var p={
					headerText:'��ʾ',
					okName:'ȷ��',
				    okFunction:okF,
				    cancelName:'ȡ��'
				};
			alert('ȷ��Ҫ������',p);
		}
		}
	}
	
	/* �˸� */
	var rejectionInfo = function (){
		$("#published_user_name").removeClass("validate[required]");
		$("#sendaudit_user_name").removeClass("validate[required]");
		if(jQuery("#form1").validationEngine("validateform")){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//��շ�������������
			$("#partunits").val("");//��շ�������������
			$("#sendaudit_user_name").val("<%=StringUtil.deNull(getInfoUserBeanRejection.getGetinfousername())%>");
			$("#sendauditusers").val("<%=StringUtil.deNull(getInfoUserBeanRejection.getGetinfouserid())%>");
			//$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REJECTION%>");
			if("<%=InfoType.NOT_BE_DEALWITH%>" == state){//����ǳ�����-δ���״̬
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REJECTION%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_REJECTION%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH%>");
			}else if("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>" == state){
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			}else if("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>" == state){
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REJECTION%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_REJECTION%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_REJECTION_REAUDIT%>");
			}
			var okF = function(){
				document.all.form1.action = url;
				document.all.form1.target = "hiddenFrame";
				$('#form1').submit();
				}
				 var p={
					headerText:'��ʾ',
					okName:'ȷ��',
				    okFunction:okF,
				    cancelName:'ȡ��'
				};
			alert('ȷ��Ҫ�˸���',p);
		}
	  }
	}
	
	/* ��� */
	var auditInfo = function (){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//��շ�������������
			$("#partunits").val("");//��շ�������������
			$("#sendaudit_user_name").val("<%=StringUtil.deNull(getInfoUserBean.getGetinfousername())%>");
			$("#sendauditusers").val("<%=StringUtil.deNull(getInfoUserBean.getGetinfouserid())%>");
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_AUDIT%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_LEADER%>");
			
			var okF = function(){
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
			}
			var p={
					headerText:'��ʾ',
					okName:'ȷ��',
				    okFunction:okF,
				    cancelName:'ȡ��'
				};
			alert('ȷ��Ҫ�����',p);
		}	
	}		

	/* �浵 */
	var saveInfo = function (){
	$("#published_user_name").removeClass("validate[required]");
	$("#sendaudit_user_name").removeClass("validate[required]");
	if(jQuery("#form1").validationEngine("validateform")){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//��շ�������������
			$("#partunits").val("");//��շ�������������
			$("#sendaudit_user_name").val("");
			$("#sendauditusers").val("");
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SAVEINFO%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			
			var okF = function(){
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
			}
			var p={
					headerText:'��ʾ',
					okName:'ȷ��',
				    okFunction:okF,
				    cancelName:'ȡ��'
				};
			alert('ȷ��Ҫ�浵��',p);

		}	
	}
	}

	var choosePartUnits = function(){
		  var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.titelText = "ѡ����Ա";
		  s.rightHeaderText="����ӻ�������Ա";
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
			  	{
				  	  $('#partunits').val('');
				  	  $('#published_user_name').val('');
				 }else
				 {
					  $('#partunits').val(orgObj.ps.id);
					  $('#published_user_name').val(orgObj.ps.name);
				 }
		  }
		  s.treeList=
				  [{
					  leftHeaderText:'����Աѡ��',
					  valueKey:'ps',
					  selectedIds:$('#partunits').val(),
					  type:'{"type":"3"}'
			}];
		  s.init();
	}

	/* ����ɹ��󷵻ط���-��ҳ����� */
	function saveBack(){
		//if(typeflag == 'true')
	//	{	
			//window.top.window.frames["_document_body_miansub_main_todowork"].document.location.reload();
			window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
	  //	}
			  if('<%=windowId%>' == ""){
				  removeWindows('<%=operwindowid%>',true);
			  }else{
	  			removeWindows('<%=windowId%>',true);
			  }
	  	
	}

	var chooseOrg = function (){
		 //�ؼ�ԺOA  ѡ����Ա �޸�Ϊ��ѡ  start 
		  /* var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.titelText = "ѡ����Ա";
		  s.rightHeaderText="����ӻ�������Ա";
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
			  	{
				  	  $('#sendauditusers').val('');
				  	  $('#sendaudit_user_name').val('');
				 }else
				 {
					  $('#sendauditusers').val(orgObj.ps.id);
					  $('#sendaudit_user_name').val(orgObj.ps.name);
				 }
			 
		  }
		  s.treeList=
				  [{
					  leftHeaderText:'����Աѡ��',
					  valueKey:'ps',
					  selectedIds:$('#sendauditusers').val(),
					  type:'{"type":"2"}'
			}];
		  s.init(); */
		  //һ���ϱ���Ժ�쵼�ġ��������ˡ����͡�Ժ�쵼��ˡ����� 
		  if(leadedit_state=='1'||"<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>" == state){
			  var s = new $.z_tree();
			  s.treeID='mian';
			  s.treetypestr="radio";
			  s.ischekc="false";
			  s.isShowSeacher=true;
			  s.treeName="ѡȡ��Ա";
			  s.headerName="ѡȡ��Ա";
			  s.type="{'type':'23'}";
			  s.selectedIds=$('#sendauditusers').val();
			  s.returnFunction=function(orgObj){
				 $('#sendauditusers').val(orgObj.id);
			  	 $('#sendaudit_user_name').val(orgObj.name);
			  }
		  	 s.init();
		  } else {
		
			  var s = new $.z_tree();
			  s.treeID='mian';
			  s.treetypestr="radio";
			  s.ischekc="false";
			  s.isShowSeacher=true;
			  s.treeName="ѡȡ��Ա";
			  s.headerName="ѡȡ��Ա";
			  s.type="{'type':'2'}";
			  s.selectedIds=$('#sendauditusers').val();
			  s.returnFunction=function(orgObj){
				 $('#sendauditusers').val(orgObj.id);
			  	 $('#sendaudit_user_name').val(orgObj.name);
			  }
		  	 s.init();
		  }
		  //�ؼ�ԺOA  ѡ����Ա �޸�Ϊ��ѡ  end 
	}



	$(function() {
		if("<%=InfoType.NOT_BE_DEALWITH%>" == state || "<%=InfoType.HAS_BE_REJECTION_REAUDIT%>" == state){//����ǳ�����-δ���״̬�����쵼-δ���״̬
			$("#publishinfo,#published_area,#auditinfo,#saveinfo").hide();//���η�������
			if(<%=!isExsitReporter%>){
				$("#rejectioninfo").hide();
			}
		}else if("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>" == state){
			$("#auditinfo").hide();//���η�������
			if(<%=StringUtil.nullOrBlank(getInfoUserBeanRejection.getGetinfouserid())%>){
				$("#rejectioninfo").hide();//���û���ݴ���Ա�������˸幦�ܣ�˵���ǴӲɱ�ֱ�ӱ��������
			}
		}else if("<%=InfoType.NOT_BE_DEALWITH_LEADER%>" == state){
			$("#publishinfo,#published_area,#sendauditinfo,#auditarea1,#auditarea2,#rejectioninfo,#saveinfo").hide();//���η�������
		}
	});
	function chooseManage(){
		var eWebEditValue=eWebEditor1.getHTML();
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','�ֻ�Ԥ��','402','500','20%');
	}
	function backTo()
	{
		window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
		 if('<%=windowId%>' == ""){
			  removeWindows('<%=operwindowid%>',true);
		  }else{
 			removeWindows('<%=windowId%>',true);
		  }
	}
</script>
<body style=" overflow:hidden;" onload="adaptationWH('_top','vcenter',45)">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom:10px;">
				<input class="but_y_01" type="button" name="operation" value="����" onclick="sendauditInfo()" id="sendauditinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="����" onclick="publishInfo()" id="publishinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="���" onclick="auditInfo()" id="auditinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="�浵" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="�˸�" onclick="rejectionInfo()" id="rejectioninfo"/>
				<input class="but_y_01" type="button" name="operation5" value="����" onclick="backTo();"id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
				<input type="hidden" name="windowId" id="windowId" value="<%=windowId %>"/>
				
	</div>
</div>
	<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>������Ϣ</span></div>
	 <div class="content_02_box_div">
	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
		  <tr>
           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>���⣺</th>
           <td class="content_02_box_div_table_td">
           	<input type="hidden" id="submittedinfo_id" name="submittedinfo_id" value="<%=submittedinfoId %>" />
			<input type="hidden" id="inputuser_id" name="inputuser_id" value="<%=inputuser_id %>" />
			<input type="hidden" id="inputuser_name" name="inputuser_name" value="<%=inputuser_name %>" />
			<input class="validate[required] input_185" id="submittedinfo_title" name="submittedinfo_title" 
			value="<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>" />
          
           </td>
           <th class="content_02_box_div_table_th">�ؼ��֣�</th>
           <td class="content_02_box_div_table_td">
           
           <input class="input_185" id="keyword" name="keyword" value="<%=infoReportBaseInfoBean.getKeyword() %>"/>
           </td>
         </tr>
      
	 <tr>
           <th class="content_02_box_div_table_th">¼�벿�ţ�</th>
           <td class="content_02_box_div_table_td">
           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getOrg_name() %>" id="orgname" name="orgname"/>
			
          
           </td>
           <th class="content_02_box_div_table_th">¼���ߣ�</th>
           <td class="content_02_box_div_table_td">
           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getInputuser_name() %>" id="inputuser_name" name="inputuser_name"/>
           </td>
         </tr>
		
		
		
		  <tr>
           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>��Ϣ���ͣ�</th>
           <td class="content_02_box_div_table_td">
               <%=infotypeHtml %>
              </td>
             
           <th class="content_02_box_div_table_th" id="auditarea1"><FONT style="COLOR: red">*</FONT>��������ˣ�</th>
             <td class="content_02_box_div_table_td" id="auditarea2">
           <INPUT class="input_160" onmouseover="this.title=this.value"
			 id="sendaudit_user_name" name="sendaudit_user_name" 
			value="<%=StringUtil.deNull(infoReportBaseInfoBean.getSendauditusersname()) %>"
			readOnly size=13 onclick='chooseOrg()'/>
			<input name="" type="button" value="" class="but_x" onclick="chooseOrg()"/>
	  		<input type="hidden" id=sendauditusers name="sendauditusers"
	  		 value="<%=StringUtil.deNull(infoReportBaseInfoBean.getSendauditusers()) %>"/>
	  		 </td>
	  		 
         </tr>
		
		<tr id="published_area">
		   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>���������ˣ�</th>
			<td class="content_02_box_div_table_td">
			<INPUT class="input_160" onmouseover="this.title=this.value"
			 id="published_user_name" name="published_user_name" 
			value="<%=StringUtil.deNull(infoReportBaseInfoBean.getPartunitsname()) %>"
			readOnly size=13 onclick='choosePartUnits()'/>
			<input name="" type="button" value="" class="but_x" onclick="choosePartUnits()"/>
	  		<input type="hidden" id=partunits name="partunits" value="<%=StringUtil.deNull(infoReportBaseInfoBean.getPartunits()) %>"/>
	  		</td>
	  		<th class="content_02_box_div_table_th">¼��ʱ�䣺</th>
           <td class="content_02_box_div_table_td" colspan="3">
		   <input class="input_185" readonly="readonly" type="text" id="input_date" value="<%=infoReportBaseInfoBean.getInput_date() %>"/>
		   </td>
		</tr>
		
		
		
		</table>
	</div>
	</div>
	 <div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>����</span>
	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 <!-- <span class="color_red">��ע��Ϊ�淶���������������ĸ�ʽ����ʹ�����������ʽ���б༭��</span>  -->
	 <span class="color_red" >��ʾ������ֱ��ճ��word��excel���</span>
	 <div class="content_02_box_add" id="t2">
	</div>
	 </div>
	 
	 <div class="content_02_box_div">
			 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
					 <tr>
						 <td>
				 <textarea id=edit_content_phone name="edit_content_phone" rows="1" cols="1" style="DISPLAY: none;" ><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
							<textarea id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
							<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
						</td>
					</tr>
				</table>
		</div>
		</div>
		
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>������</span>
	 <div class="content_02_box_add"></div>
	 </div>
	 <div  class="text_show_main_box">
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	   			<tr>
	   				<td>
	   					<table style="background:none;" width="100%" border="0" cellspacing="0" cellpadding="0">
	  						<tr>
							   	 <td align="center">
							      <textarea type="text" id="audit_idea" name="audit_idea"  style="width:99%;height: 80px;border:0px solid #FFF3C9; margin:2px 0 2px; "></textarea>
							     </td>
 		 					</tr>
	  						<tr>
	   							 <td align="center">
	   							
	   							 <%if(null != auditlist){ %>
								<tr>
								<td colspan="5">
								<div id="audit_idea" style="font-size: 12px;" >
								<ul>
								<%for(InfoReportAuditIdeaBean auditBean : auditlist){ %>
								<li style=" margin-right:20px;"><%=auditBean.getAndit_person() %>��<%=auditBean.getAndit_state() %>���:  <%=auditBean.getAndit_opinion() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=auditBean.getAndit_time() %></li>
								<%} %>	
							   </ul>
							</div>
							</td>
							</tr>
							<%} %>
	   							 </td>
	 						 </tr>
	  					</table>
	   					
	   				</td>
	   			</tr>
</table>

	 </div>
</div>
	</div>
	</div>
	</dvi>
</form>

<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
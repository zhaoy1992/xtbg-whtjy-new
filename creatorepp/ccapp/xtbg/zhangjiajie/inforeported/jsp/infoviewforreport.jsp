<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil" %>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String submittedinfoId = request.getParameter("submittedinfoId");
String state = request.getParameter("state");
//�жϴ�廹���˸�  0 �˸�  1 ��� 
String view_num = request.getParameter("view_num");
String inputuser_id = accesscontroler.getUserID();

InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao.findInfoReportBaseInfo(submittedinfoId);

List<InfoReportAuditIdeaBean> auditlist = null;
if(InfoType.HAS_BE_REJECTION.equals(state)){
	auditlist = infoReportdao.findInfoReportAuditListByUser(submittedinfoId,InfoType.HAS_BE_REJECTION,"");
}
String path = request.getContextPath();
String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
String operwindowid = request.getParameter("operwindowid");
String currentDbTime =new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id",StringUtil.deNull(infoReportBaseInfoBean.getInfotype_id()),"",false,"","width:188px");//��Ϣ����������
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>��Ϣ����ϱ�չʾ(�ݸ���)</title>
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
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- �����������ý��� -->
<script type="text/javascript">
var state = '<%=state%>';
jQuery(document).ready(function() {

	jQuery("#form1").validationEngine({
		promptPosition : "topLeft",
		scroll: false
	});
});

	var saveInfo = function (){
		if(validateForm()){
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_TEMPORARY%>")
			if("<%=InfoType.HAS_BE_REJECTION%>" == state){
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_REJECTION%>");
			}else{
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			}
			var url = "infoinputdetailsaveform.jsp?tablepage=1";
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
		}
		
	}

	function validateForm(){
		var str = eWebEditor1.getHTML();
		if(jQuery("#form1").validationEngine("validateform")){
		
		$('#submit_content').val(str);
		if(IsSpace($('#submit_content').val())){
			alert("���ݲ���Ϊ��");
			return false;
		}
		
		return true;
		}
	}
	
	function reportInfo(){
		$('#reportuser_name').addClass("validate[required]");
		if(validateForm()){
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_REPORTED%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH%>");
			if("<%=InfoType.HAS_BE_REJECTION%>" == state){
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_REJECTION%>");
			}else{
				$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			}
			var okF = function(){
				var url = "infoinputdetailsaveform.jsp?tablepage=2";
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
			alert('ȷ��Ҫ�ϱ���',p);
			
		}
	}

	var chooseReportUnits = function(){
		  //�ؼ�Ժ  ѡ����Ա��Ϊ��ѡ  start
		  /* var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher=true;
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.titelText = "ѡ����Ա";
		  s.rightHeaderText="�������Ա";
	
		  s.returnFunction=function(orgObj){

			  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
			  	{
				  $('#reportunits').val('');
				  $('#reportuser_name').val('');
				 }else
				 {
					 $('#reportunits').val(orgObj.ps.id);
					  $('#reportuser_name').val(orgObj.ps.name);
				 }
		  
		}
		  s.treeList=
			  [{
				  leftHeaderText:'����Աѡ��',
				  valueKey:'ps',
				  selectedIds:$('#reportunits').val(),
				  type:'{"type":"1"}'
		}];
	  s.init(); */
	  var s = new $.z_tree();
		  s.treeID='mian';
		  s.treetypestr="radio";
		  s.ischekc="false";
		  s.isShowSeacher=true;
		  s.treeName="ѡȡ��Ա";
		  s.headerName="ѡȡ��Ա";
		  s.type="{'type':'1'}";
		  s.selectedIds=$('#reportunits').val();
		  s.returnFunction=function(orgObj){
			 $('#reportunits').val(orgObj.id);
		  	 $('#reportuser_name').val(orgObj.name);
		  }
	  	 s.init();
	  	//�ؼ�Ժ  ѡ����Ա��Ϊ��ѡ  end
}
		 
	
	function backTo(){
		//var url = "infomydraftslist.jsp";
		//location.href = url;
		var okF = function(){
			removeWindows('<%=operwindowid%>',true);
			}
			 var p={
					headerText:'��ʾ',
					okName:'ȷ��',
			        okFunction:okF,
			        cancelName:'ȡ��'
			};
			
		alert('���ظ�ҳ,δ�������Ϣ���ᶪʧ '+'<br>'+'ȷ�����أ�',p);
		
		}
	/* ����ɹ��󷵻ط���-��ҳ����� */
	function saveBack(){
		removeWindows('<%=operwindowid%>',true);
	}

	function chooseManage(){
		var eWebEditValue=eWebEditor1.getHTML();
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','�ֻ�Ԥ��','412','500','20%');
	}
	
</script>
<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter',50)">
<div  class="content_02" style="overflow:hidden;" >
<form action="" id="form1" name="form1" method="post">
 		<div  class="content_02" style="overflow:hidden;" id="_top">
			<div class="content_02_top" style="margin-bottom:10px;"  >
 				<input class="but_y_01" type="button" name="operation" value="����" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation" value="�ϱ�" onclick="reportInfo()" id="reportinfo"/>
				<input class="but_y_01" type="button" name="operation" value="����"  onclick="backTo()"  id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
					<input type="hidden" name="relese_time" id="relese_time" value="<%=currentDbTime%>"/>
				<input type="hidden" name="operwindowid" id="operwindowid" value="<%=StringUtil.deNull(request.getParameter("operwindowid"))%>"/>
			</div>
		</div>
		<div id="vcenter" style="float:left; width:100%; overflow:scroll" scrolling="yes">
		<div style="float: left; width: 775px; ">
		<div class="content_02_box" >
		<div class="content_02_box_title_bg"><span>������Ϣ</span></div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
				 <tr>
			           <th width="191" class="content_02_box_div_table_th">
					   <span class="color_red">*</span>���⣺</th>
			           <td class="content_02_box_div_table_td" colspan="3">
			           <input type="hidden" id="submittedinfo_id" name="submittedinfo_id" value="<%=submittedinfoId %>" />
					  	
					   <input class="validate[required,maxSize[100]] input_title_text" id="submittedinfo_title" name="submittedinfo_title" value="<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>" />
					   </td>
		         </tr>
		         
				 <tr>
			           <th class="content_02_box_div_table_th">¼�벿�ţ�</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getOrg_name() %>" id="orgname" name="orgname"/></td>
			           <th class="content_02_box_div_table_th">¼���ߣ�</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getInputuser_name() %>" id="inputuser_name" name="inputuser_name"/></td>
		         </tr>
			
				  <tr>
			           <th class="content_02_box_div_table_th">��Ϣ���ͣ�</th>
			           <td class="content_02_box_div_table_td">
			                <%=infotypeHtml %>
			              </td>
			           <th class="content_02_box_div_table_th">�ؼ��֣�</th>
			           <td class="content_02_box_div_table_td">
			           <input type="text"  class="input_185" id="keyword" name="keyword" value="<%=infoReportBaseInfoBean.getKeyword() %>"/>
			           </td>
		         </tr>
			
				 <tr>
			           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>�ϱ������ˣ�</th>
			           <td class="content_02_box_div_table_td">
			           <input  id="reportuser_name" name="reportuser_name" value="<%=infoReportBaseInfoBean.getReportunitsname() %>" class="validate[required] input_160"
			           readOnly  onclick='chooseReportUnits()'/>
			           <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
			           <input type="hidden" id="reportunits" name="reportunits" value="<%=infoReportBaseInfoBean.getReportunits() %>"/>
			            
			           </td>
			            <th class="content_02_box_div_table_th">¼��ʱ�䣺</th>
			           <td class="content_02_box_div_table_td">
			           <input class="date_187" readonly="readonly" id="input_date" value="<%=infoReportBaseInfoBean.getInput_date() %>" readonly="readonly" type="text"/>
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
	 		 <span class="color_red">��ע��Ϊ�淶���������������ĸ�ʽ����ʹ�����������ʽ���б༭��</span>
			
			</div>
			<div class="content_02_box_div">	
					<table border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
							<tr>
									<td colspan="5">
									<textarea id=edit_content_phone name="edit_content_phone" rows="1" cols="1" style="DISPLAY: none;" ><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
									<textarea id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
									<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
									</td>
							</tr>
					</table>
			</div>
			</div>
			<%if("0".equals(StringUtil.deNull(view_num))){ %>
			<div class="content_02_box" >
			<div class="content_02_box_title_bg"><span>���</span>
			<div class="content_02_box_add">
			</div>
			</div>
			<div  class="text_show_main_box">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
						 <td align="center">
			
							<table border="0" cellspacing="0" cellpadding="0"  class="text_show_box">
								 <%if(null != auditlist){
										for(InfoReportAuditIdeaBean auditBean : auditlist){ %>
									<tr>
										 <td style=" margin-right:40px;"><span class="list_main_pl_neir"><%=auditBean.getAndit_person() %>��<%=auditBean.getAndit_state() %>���:  <%=auditBean.getAndit_opinion() %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="list_main_pl_time"><%=auditBean.getAndit_time() %></span></td>
									</tr>
								<%}} else { %>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>
								<%} %>	
		                   </table>
			  	 	</td>
		      </tr>
		</table>
		</div>
		</div>
		<%} %>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</div>
</body>
</html>
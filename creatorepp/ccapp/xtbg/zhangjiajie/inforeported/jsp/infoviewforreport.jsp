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
//判断存稿还是退稿  0 退稿  1 存稿 
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
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id",StringUtil.deNull(infoReportBaseInfoBean.getInfotype_id()),"",false,"","width:188px");//信息类型下拉框
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
<title>信息浏览上报展示(草稿箱)</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
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
			alert("内容不能为空");
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
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
			alert('确定要上报吗？',p);
			
		}
	}

	var chooseReportUnits = function(){
		  //特检院  选择人员改为单选  start
		  /* var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher=true;
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加人员";
	
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
				  leftHeaderText:'按人员选择',
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
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.type="{'type':'1'}";
		  s.selectedIds=$('#reportunits').val();
		  s.returnFunction=function(orgObj){
			 $('#reportunits').val(orgObj.id);
		  	 $('#reportuser_name').val(orgObj.name);
		  }
	  	 s.init();
	  	//特检院  选择人员改为单选  end
}
		 
	
	function backTo(){
		//var url = "infomydraftslist.jsp";
		//location.href = url;
		var okF = function(){
			removeWindows('<%=operwindowid%>',true);
			}
			 var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
		
		}
	/* 保存成功后返回方法-子页面调用 */
	function saveBack(){
		removeWindows('<%=operwindowid%>',true);
	}

	function chooseManage(){
		var eWebEditValue=eWebEditor1.getHTML();
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','手机预览','412','500','20%');
	}
	
</script>
<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter',50)">
<div  class="content_02" style="overflow:hidden;" >
<form action="" id="form1" name="form1" method="post">
 		<div  class="content_02" style="overflow:hidden;" id="_top">
			<div class="content_02_top" style="margin-bottom:10px;"  >
 				<input class="but_y_01" type="button" name="operation" value="保存" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation" value="上报" onclick="reportInfo()" id="reportinfo"/>
				<input class="but_y_01" type="button" name="operation" value="返回"  onclick="backTo()"  id="backto"/>
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
		<div class="content_02_box_title_bg"><span>基本信息</span></div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
				 <tr>
			           <th width="191" class="content_02_box_div_table_th">
					   <span class="color_red">*</span>标题：</th>
			           <td class="content_02_box_div_table_td" colspan="3">
			           <input type="hidden" id="submittedinfo_id" name="submittedinfo_id" value="<%=submittedinfoId %>" />
					  	
					   <input class="validate[required,maxSize[100]] input_title_text" id="submittedinfo_title" name="submittedinfo_title" value="<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>" />
					   </td>
		         </tr>
		         
				 <tr>
			           <th class="content_02_box_div_table_th">录入部门：</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getOrg_name() %>" id="orgname" name="orgname"/></td>
			           <th class="content_02_box_div_table_th">录入者：</th>
			           <td class="content_02_box_div_table_td">
			           <input class="input_185" readonly="readonly" type="text" value="<%=infoReportBaseInfoBean.getInputuser_name() %>" id="inputuser_name" name="inputuser_name"/></td>
		         </tr>
			
				  <tr>
			           <th class="content_02_box_div_table_th">信息类型：</th>
			           <td class="content_02_box_div_table_td">
			                <%=infotypeHtml %>
			              </td>
			           <th class="content_02_box_div_table_th">关键字：</th>
			           <td class="content_02_box_div_table_td">
			           <input type="text"  class="input_185" id="keyword" name="keyword" value="<%=infoReportBaseInfoBean.getKeyword() %>"/>
			           </td>
		         </tr>
			
				 <tr>
			           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>上报接收人：</th>
			           <td class="content_02_box_div_table_td">
			           <input  id="reportuser_name" name="reportuser_name" value="<%=infoReportBaseInfoBean.getReportunitsname() %>" class="validate[required] input_160"
			           readOnly  onclick='chooseReportUnits()'/>
			           <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
			           <input type="hidden" id="reportunits" name="reportunits" value="<%=infoReportBaseInfoBean.getReportunits() %>"/>
			            
			           </td>
			            <th class="content_02_box_div_table_th">录入时间：</th>
			           <td class="content_02_box_div_table_td">
			           <input class="date_187" readonly="readonly" id="input_date" value="<%=infoReportBaseInfoBean.getInput_date() %>" readonly="readonly" type="text"/>
			           </td>
		         </tr>
	         </table>
         </div>
		</div>
	
			<div class="content_02_box" >
			<div class="content_02_box_title_bg"><span>正文</span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 		 <span class="color_red">备注：为规范政府行政机关行文格式，请使用正常字体格式进行编辑！</span>
			
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
			<div class="content_02_box_title_bg"><span>意见</span>
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
										 <td style=" margin-right:40px;"><span class="list_main_pl_neir"><%=auditBean.getAndit_person() %>的<%=auditBean.getAndit_state() %>意见:  <%=auditBean.getAndit_opinion() %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="list_main_pl_time"><%=auditBean.getAndit_time() %></span></td>
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
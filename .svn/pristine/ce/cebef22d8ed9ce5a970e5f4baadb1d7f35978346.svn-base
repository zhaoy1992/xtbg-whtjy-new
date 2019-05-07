<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.AreaBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%><html>
<%
	AccessControl accesscontrol = AccessControl.getAccessControl();
	accesscontrol.checkAccess(request,response);
	String orgname = accesscontrol.getChargeOrgName();
	String orgid = accesscontrol.getChargeOrgId();
	String username = accesscontrol.getUserName();
	String userid = accesscontrol.getUserID();

	
	ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
	
	ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
	
	String department = rruBean.getOrgname();
	String departmentid = rruBean.getOrgid();
	
	AuthRole authRoles[] = accesscontrol.getAllRoleofUser(accesscontrol.getUserAccount());
	String rolesNames = "";
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	}    
	rolesNames = buf.toString();
	rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	String type = "public";

	if(rolesNames.indexOf("信息上报初审者")!=-1){
		type = "chushen";
	}else if(rolesNames.indexOf("信息上报复审者")!=-1){
		type = "fushen";
	}
	String operwindowid = request.getParameter("operwindowid");
	String path = request.getContextPath();
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",true,"");//信息类型下拉框
	
	String currentDbTime = DaoUtil.SqlToField("select to_char(sysdate,'yyyy-MM-dd HH:mm:ss') from dual");
	//查询使用的地区，区分是否在eweb中使用红头
	String CURSYSTEMCODE= CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
%>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>



<!-- 引入jQueryTimePicker -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-timepicker-addon.js"></script>
<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<link href="../../../resources/css/layer.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/style.css" rel="stylesheet" type="text/css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"
	href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"
	type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
	type="text/javascript" charset="utf-8">
	
</script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
	type="text/javascript" charset="utf-8">
</script>
<script type="text/javascript">
var type = '<%=type%>';
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	jQuery("#form1").validationEngine();
	//'1'为显示红头，‘0’为不显示红头
	if("430800"=="<%=CURSYSTEMCODE%>"){
		document.getElementById("eWebEditor1").contentWindow.setHTML(
				"<DIV style='WIDTH: 100%; '></DIV>"
				+"<P"
					+" style='TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: 10.5pt "
					+" align=center>"
					+" <SPAN style='FONT-FAMILY: 方正小标宋_GBK; COLOR: red; FONT-SIZE: 36pt'>"
						+"张家界信息"
						+" <SPAN>(</SPAN>"
						+"</SPAN>"
						+"<SPAN style='FONT-FAMILY: 方正小标宋_GBK; COLOR: black; FONT-SIZE: 26pt'>业务交流</SPAN>"
						+"<SPAN style='FONT-FAMILY: 方正小标宋_GBK; COLOR: red; FONT-SIZE: 36pt'>)</SPAN>"
						+"<br/><br/><SPAN style='FONT-FAMILY: 黑体; COLOR: black; FONT-SIZE: 16pt'>第</SPAN>"
						+"	<SPAN style='COLOR: black; FONT-SIZE: 16pt'>10</SPAN>"
						+"	<SPAN style='FONT-FAMILY: 黑体; COLOR: black; FONT-SIZE: 16pt'>期</SPAN>"
						+"</P>"
						+"<P"
						+"	style='TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: 10.5pt"
						+"	align=center>"
						+"	<SPAN style='FONT-FAMILY: 黑体; COLOR: black; FONT-SIZE: 16pt'></SPAN>"
						+"	<SPAN style='COLOR: black; FONT-SIZE: 16pt'>&nbsp;</SPAN>"
						+"</P>"
						+"<P "
						+"style='white-space: nowrap;TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; LINE-HEIGHT: 25pt; MARGIN: 0cm 3.55pt 0pt 0cm; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt'>"
						+"	<SPAN style='FONT-FAMILY: 仿宋_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 1%'>中共张家界市委办公室</SPAN>"
						+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'> </SPAN>"
					+"<SPAN style='COLOR: black; FONT-SIZE: 16pt'>"
					+"<SPAN>&nbsp;</SPAN>"
					+"</SPAN>"
					+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'>"
					+"<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>"
					+"</SPAN>"
					+"<SPAN style='FONT-FAMILY: 仿宋_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 28% ' >2012 年 7 月 13 日</SPAN>"
					+"</P>"
					+"<P "
					+"style='TEXT-JUSTIFY: inter-ideograph; text-align: center; LINE-HEIGHT: 25pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt' "
					+">"
					+"<SPAN style='COLOR: black; FONT-SIZE: 14pt'>"
					+"	<IMG style='WIDTH:100%; HEIGHT: 2px;' height=2 "
					+"		src='/xtbg/ccapp/xtbg/resources/plug/eWebEditor_V4.60/uploadfile/20120803105442001.gif'>"
					+"</SPAN>"
					+"</P><br/><p></p>" );
		}

});

	var saveInfo1 = function (){
		if(validateForm()){
			
			var url = "infoinputdetailsaveform.jsp?tablepage=1";
			$("#submittedinfo_typecode").val("<%=InfoType.NOT_BE_DEALWITH%>");//当前操作人的操作之后状态
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH%>");//接收人的操作之后状态
			if("fushen" == type){//如果是复审者
				$("#submittedinfo_typecode").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");//当前操作人的操作之后状态
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");//接收人的操作之后状态
			}
			//$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_LEADER%>");//需要删除的相关状态
			
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();

		}	
		
	}

	var sendauditInfo = function (){
		if(validateForm()){
			$("#sendaudit_user_name").addClass("validate[required]");
			var url = "infoinputdetailsaveform.jsp?tablepage=2";
			$("#published_user_name").val("");//清空发布接收人数据
			$("#partunits").val("");//清空发布接收人数据
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH%>");
			if("fushen" == type){//如果是复审者
				$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED_REAUDIT%>");
				$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_LEADER%>");
				$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			}
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
			$("#sendaudit_user_name").removeClass("validate[required]");
		}	
	}

	function validateForm(){
		var str = eWebEditor1.getHTML();
		
		
		$('#submit_content').val(str);
		if(IsSpace($('#submit_content').val())){
			alert("内容不能为空");
			return false;
		}
		return true;
	}
	
	function publishInfo(){
		if(validateForm()){
			$("#published_user_name").addClass("validate[required]");
			var url = "infoinputdetailsaveform.jsp?tablepage=2";
			$("#sendaudit_user_name").val("");//清空送审接收人数据
			$("#sendauditusers").val("");
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_PUBLISHED%>,<%=InfoType.HAS_BE_SAVEINFO%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_VIEW%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
			$("#published_user_name").removeClass("validate[required]");
		}
	}

	var choosePartUnits = function(){
		  var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
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
					  leftHeaderText:'按人员选择',
					  valueKey:'ps',
					  selectedIds:$('#partunits').val(),
					  type:'{"type":"3"}'
			}];
		  s.init();



		 
	}

	var chooseOrg = function (){
		  var s = new $.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
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
					  leftHeaderText:'按人员选择',
					  valueKey:'ps',
					  selectedIds:$('#sendauditusers').val(),
					  type:'{"type":"2"}'
			}];
		  s.init();

		 
	}
	function saveBack(){
		removeWindows('<%=operwindowid%>',true);
	}
	var saveInfo = function (){
		if(validateForm()){
			
			var url = "infoinputdetailsaveform.jsp?tablepage=3";
			$("#published_user_name").val("");//清空发布接收人数据
			$("#partunits").val("");//清空发布接收人数据
			$("#sendaudit_user_name").val("");
			$("#sendauditusers").val("");
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SAVEINFO%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();

		}	
	}

	function backTo(){
		//var url = "infopendinglist.jsp";
		//location.href = url;
		removeWindows('<%=operwindowid%>',true);
	}
	function chooseManage(){
		var eWebEditValue=eWebEditor1.getHTML();
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','手机预览','402','500','20%');
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>信息录入详细页面</title>

</head>
<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter',50)">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;" >
 <div class="content_02_top" style="margin-bottom:10px;" id="_top">
	 <input class="but_y_01" type="button" name="operation" value="存草稿" onclick="saveInfo1()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation" value="送审" onclick="sendauditInfo()" id="sendauditinfo"/>
				<%if("fushen".equals(type)){ %>
					<input class="but_y_01" type="button" name="operation" value="发布" onclick="publishInfo()" id="publishinfo"/>
					<input class="but_y_01" type="button" name="operation3" value="存档" onclick="saveInfo()" id="saveinfo"/>
				<%} %>
				<input class="but_y_01" type="button" name="operation" value="返回" onclick="backTo()" id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
                <input type="hidden"  name="operwindowid" id="operwindowid" value="<%=operwindowid%>"/>
</div>
<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden;" scrolling="yes"> 
<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
	   <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
		 <tr>
            <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>标题：</th>
           <td class="content_02_box_div_table_td">
           <input class="validate[required] input_185" type="text" id="submittedinfo_title" name="submittedinfo_title">
           </td>
            <th class="content_02_box_div_table_th">信息类型：</th>
           <td class="content_02_box_div_table_td">
                 	<%=infotypeHtml%>
              </td>
          
         </tr>
		
		<tr>
		  <th class="content_02_box_div_table_th">录入部门：</th>
           <td class="content_02_box_div_table_td">
	           <input class="input_185" readonly="readonly" type="text" value="<%=department %>" id="department" name="department"></input>
			   <input type="hidden"  name="departmentid" id="departmentid" value="<%=departmentid %>">
			   <input type="hidden"  name="orgid" id="orgid" value="<%=orgid %>">
            </td>
		
		   <th class="content_02_box_div_table_th">录入者：</th>
           <td class="content_02_box_div_table_td">
           
           <input class="input_185" readonly="readonly" type="text" value="<%=username %>" id="inputuser_name" name="inputuser_name"></input>
		   <input type="hidden"  name="inputuser_id" id="inputuser_id" value="<%=userid %>">
           </td>
		</tr>
		
		<tr>
		  <th class="content_02_box_div_table_th">关键字：</th>
           <td class="content_02_box_div_table_td">
         <input class="input_185" type="text" id="keyword" name="keyword">
            </td>
		
		 <th class="content_02_box_div_table_th">录入时间：</th>
           <td class="content_02_box_div_table_td">
           <input class="input_185" readonly="readonly" type="text" id="input_date" value="<%=currentDbTime%>"/>
            </td>
		</tr>
		<tr>
		  
			 <th class="content_02_box_div_table_th" id="auditarea1"><FONT style="COLOR: red">*</FONT>送审接收人：</th>
           	 <td class="content_02_box_div_table_td" id="auditarea2">
	             <INPUT class="input_160"  onmouseover="this.title=this.value"
				 id="sendaudit_user_name" name="sendaudit_user_name" 
				value=""
				readOnly size=13 onclick='chooseOrg()'>
				<input name="" type="button" value="" class="but_x" onclick="chooseOrg()"/>
		  		<input type="hidden" id=sendauditusers name="sendauditusers"/>
             </td>
             <%if("fushen".equals(type)){ %>
              <th class="content_02_box_div_table_th" ><FONT style="COLOR: red">*</FONT>发布接收人：</th>
           	 <td class="content_02_box_div_table_td" >
	             <INPUT class="input_160"   onmouseover="this.title=this.value"
			 id="published_user_name" name="published_user_name" 
			value=""
			readOnly size=13 onclick='choosePartUnits()'>
			<input name="" type="button" value="" class="but_x" onclick="choosePartUnits()"/>
	  		<input type="hidden" id=partunits name="partunits" />
             </td>
             <%}else{ }%>
		</tr>
		
		</table>
		</div>
		</div>
		 <div class="content_02_box" >
	 			<div class="content_02_box_title_bg"><span>正文</span>
	 			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 		 	<!-- <span class="color_red">备注：为规范政府行政机关行文格式，请使用正常字体格式进行编辑！</span>  -->
	 		 	<span class="color_red" >提示：可以直接粘贴word、excel表格</span>
	 			<div class="content_02_box_add" id="t2">

				 </div>
	 			
	 			</div>
			    <div class="text_show_main_box">
			  	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  	    <tr>
			  	    <td>
			  	    	<textarea id=edit_content_phone name="edit_content_phone" rows="1" cols="1" style="DISPLAY: none;" ></textarea>
			  	    	<textarea id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"></textarea>
						<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
			  	    </td>
			  	    </tr>
		</table>
		</div>
		</div>
</div>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
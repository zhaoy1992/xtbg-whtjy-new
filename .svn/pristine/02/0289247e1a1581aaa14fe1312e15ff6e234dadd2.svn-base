<%@page import="com.chinacreator.framework.Item"%>
<%@page import="com.chinacreator.framework.ItemQueue"%>
<%@page import="com.chinacreator.framework.Module"%>
<%@page import="com.chinacreator.framework.ModuleQueue"%>
<%@page import="com.chinacreator.framework.MenuHelper"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
String submittedinfoId = request.getParameter("submittedinfoId");
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String username = accesscontroler.getUserName();
String userid = accesscontroler.getUserID();
String orgid = accesscontroler.getChargeOrgId();
ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
String department =  "";
String departmentid = "";
if(!StringUtil.isBlank(rruBean.getOrgname())){
	 department = rruBean.getOrgname();
}
if(!StringUtil.isBlank(rruBean.getOrgid())){
	departmentid = rruBean.getOrgid();
}
String subid=request.getParameter("subid");
String tablepage = request.getParameter("tablepage");
if(null == tablepage){
	tablepage ="";
}

String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
String operwindowid = request.getParameter("operwindowid");
String currentDbTime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",false,"","width:188px");//信息类型下拉框

boolean returnPath = false;
String modulePath = "module::menu://sysmenu$root";
MenuHelper menuHelper = new MenuHelper(accesscontroler);
ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
List<Module> moduleList = moduleQueue.getList();
String modstr="";
List<Module> submoduleList =  null;
ModuleQueue submoduleQueue = null;
for(Module fristModule : moduleList) {
	ItemQueue itemQueue3 = fristModule.getItems();
	List<Item> itemList3 = itemQueue3.getList();
	for(Item item1 : itemList3){//二级菜单
		modstr+=item1.getId()+",";
	 }
}
//存在信息采编 菜单
if(modstr.indexOf("infocaibian")!=-1){
	returnPath = true;
} 


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
<title>领导报送</title>
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
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var returnPath = "<%=returnPath%>";
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
});

	function validateForm(){
		var str = eWebEditor1.getHTML();
			$('#submit_content').val(str);
			if(IsSpace($('#submit_content').val())){
				alert("内容不能为空");
				return false;
			}
			return true;
	}

	/* 发布 */
	var publishInfo = function (){
		$("#published_user_name").addClass("validate[required]"); // 发布接收人不能为空
		$("#sendaudit_user_name").removeClass("validate[required]");
		if(jQuery("#form1").validationEngine("validateform")){
			if(validateForm()){
				var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
				$("#sendaudit_user_name").val("");//清空送审接收人数据
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
						headerText:'提示',
						okName:'确认',
					    okFunction:okF,
					    cancelName:'取消'
					};
				alert('确定要发布吗？',p);
			}
		}
		
	}

	/* 送审 */
	var sendauditInfo = function (){
		$("#sendaudit_user_name").addClass("validate[required]");
		$("#published_user_name").removeClass("validate[required]");
		if(jQuery("#form1").validationEngine("validateform")){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//清空发布接收人数据
			$("#partunits").val("");//清空发布接收人数据
			//如果是复审者-未审核状态
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_SUBMITTED_REAUDIT%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.NOT_BE_DEALWITH_LEADER%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH_REAUDIT%>");
			var okF = function(){
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
			alert('确定要送审吗？',p);
		}
		}
	}
	
	
	/* 存档 */
	var saveInfo = function (){
	$("#published_user_name").removeClass("validate[required]");
	$("#sendaudit_user_name").removeClass("validate[required]");
	if(jQuery("#form1").validationEngine("validateform")){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp?tablepage="<%=tablepage%>;
			$("#published_user_name").val("");//清空发布接收人数据
			$("#partunits").val("");//清空发布接收人数据
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
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
			alert('确定要存档吗？',p);

		}	
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

	/* 保存成功后返回方法-子页面调用 */
	function saveBack(){
		window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
		if(returnPath=="true"){
			window.parent.location.href="<%=path%>/ccapp/xtbg/zhangjiajie/inforeported/jsp/infocaibian.jsp";
		} else {
			//直接关闭领导报送界面
			removeWindows('paper',true);	
		}
	}

	var chooseOrg = function (){
		  var s = new $.z_tree();
		  s.treeID='mian';
		  s.treetypestr="radio";
		  s.ischekc="false";
		  s.isShowSeacher=true;
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.type="{'type':'23'}";
		  s.selectedIds=$('#sendauditusers').val();
		  s.returnFunction=function(orgObj){
			 $('#sendauditusers').val(orgObj.id);
		  	 $('#sendaudit_user_name').val(orgObj.name);
		  }
	  	 s.init();
	}
	function backTo()
	{
		var okF = function(){
			window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
			if(returnPath=="true"){
				window.parent.location.href="<%=path%>/ccapp/xtbg/zhangjiajie/inforeported/jsp/infocaibian.jsp";
			} else {
				//直接关闭领导报送界面
				removeWindows('paper',true);	
			}
			
		}
		var p={
				headerText:'提示',
				okName:'确认',
			    okFunction:okF,
			    cancelName:'取消'
		};
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
	}	
</script>
<body style=" overflow:hidden;" onload="adaptationWH('_top','vcenter',0)">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom:10px;">
				<input class="but_y_01" type="button" name="operation" value="送审" onclick="sendauditInfo()" id="sendauditinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="发布" onclick="publishInfo()" id="publishinfo"/>
				<input class="but_y_01" type="button" name="operation3" value="存档" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation5" value="返回" onclick="backTo();"id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
				<input type="hidden" name="windowId" id="windowId" value=""/>
				<input type="hidden" name="leadedit_state" id="leadedit_state" value="1"/>
				
	</div>
</div>
	<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
		  <tr>
           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>标题：</th>
           <td class="content_02_box_div_table_td">
           	<input type="hidden" id="submittedinfo_id" name="submittedinfo_id" />
			<input class="validate[required,maxSize[100]] input_185" id="submittedinfo_title" name="submittedinfo_title" />
          
           </td>
           <th class="content_02_box_div_table_th">关键字：</th>
           <td class="content_02_box_div_table_td">
           		<input class="validate[maxSize[50]] input_185" id="keyword" name="keyword" />
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
           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>信息类型：</th>
           <td class="content_02_box_div_table_td">
               <%=infotypeHtml %>
           </td>
             
           <th class="content_02_box_div_table_th" id="auditarea1"><FONT style="COLOR: red">*</FONT>送审接收人：</th>
             <td class="content_02_box_div_table_td" id="auditarea2">
           		<INPUT class="input_160" onmouseover="this.title=this.value" id="sendaudit_user_name" name="sendaudit_user_name" 
						readOnly size=13 onclick='chooseOrg()'/>
				<input name="" type="button" value="" class="but_x" onclick="chooseOrg()"/>
	  			<input type="hidden" id=sendauditusers name="sendauditusers" />
	  		 </td>
	  		 
         </tr>
		
		<tr id="published_area">
		   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>发布接收人：</th>
			<td class="content_02_box_div_table_td">
			<INPUT class="input_160" onmouseover="this.title=this.value"
			 id="published_user_name" name="published_user_name" 
			readOnly size=13 onclick='choosePartUnits()'/>
			<input name="" type="button" value="" class="but_x" onclick="choosePartUnits()"/>
	  		<input type="hidden" id=partunits name="partunits" />
	  		</td>
	  		<th class="content_02_box_div_table_th">录入时间：</th>
           <td class="content_02_box_div_table_td" colspan="3">
		   <input class="input_185" readonly="readonly" type="text" id="input_date" value="<%=currentDbTime %>" />
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
	 <!-- <span class="color_red">备注：为规范政府行政机关行文格式，请使用正常字体格式进行编辑！</span>  -->
	 <span class="color_red" >提示：可以直接粘贴word、excel表格</span>
	 <div class="content_02_box_add" id="t2">
	</div>
	 </div>
	 
	 <div class="content_02_box_div">
			 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
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
	</dvi>
</form>

<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
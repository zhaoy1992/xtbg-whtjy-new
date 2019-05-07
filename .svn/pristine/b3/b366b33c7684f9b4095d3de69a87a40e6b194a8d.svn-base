<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.AreaBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%><html>
<%
	AccessControl accesscontrol = AccessControl.getAccessControl();
	accesscontrol.checkAccess(request,response);
	String path = request.getContextPath();
	String orgname = accesscontrol.getChargeOrgName();
	String orgid = accesscontrol.getChargeOrgId();
	String username = accesscontrol.getUserName();
	String userid = accesscontrol.getUserID();
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
	String operwindowid = request.getParameter("operwindowid");
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",false,"","width:188px");//信息类型下拉框
	String currentDbTime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
	//查询使用的地区，区分是否在eweb中使用红头
	String CURSYSTEMCODE= CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	System.out.print(CURSYSTEMCODE);
	
%>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入formvValidatetion -->

<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
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
					+"style='white-space: nowrap;TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; LINE-HEIGHT: 25pt; MARGIN: 0cm 3.55pt 0pt 0cm; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt';>"
					+"	<SPAN style='FONT-FAMILY: 仿宋_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 1%'>中共张家界市委办公室</SPAN>"
					+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'> </SPAN>"
				+"<SPAN style='COLOR: black; FONT-SIZE: 16pt'>"
				+"<SPAN>&nbsp;</SPAN>"
				+"</SPAN>"
				+"<SPAN style='COLOR: black; FONT-SIZE: 15pt'>"
				+"<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>"
				+"</SPAN>"
				+"<SPAN style='FONT-FAMILY: 仿宋_GB2312; COLOR: black; FONT-SIZE: 16pt;margin-left: 28% ;' >2012 年 7 月 13 日</SPAN>"
				+"</P>"
				+"<P "
				+"style='TEXT-JUSTIFY: inter-ideograph; text-align: center; LINE-HEIGHT: 25pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: 'Times New Roman'; FONT-SIZE: '10.5pt' "
				+">"
				+"<SPAN style='COLOR: black; FONT-SIZE: 14pt'>"
				+"<div style='border-bottom:solid 2px #F00;'></div>"
				+"</SPAN>"
				+"</P><br/><p></p>" );
	}
});

	var saveInfo = function (){
// 		if(IsSpace($('#submittedinfo_title').val())){
// 			alert("标题不能为空");
// 			return false;
// 		}
// 		if(IsSpace($('#reportuser_name').val())){
// 			alert("上报接收人不能为空");
// 			return false;
// 		}
		if(validateForm()){
			$("#submittedinfo_typecode").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			$("#submittedinfo_typecode4getinfouser").val("<%=InfoType.HAS_BE_TEMPORARY%>");
			$("#submittedinfo_typecode2delete").val("<%=InfoType.HAS_BE_TEMPORARY%>");
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
			$("#submittedinfo_typecode2delete").val("<%=InfoType.NOT_BE_DEALWITH%>");
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
		//特检院  选择人员修改为单选 start
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
		  /* var s = new $.z_tree();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
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
		  
		  //特检院 选择人员改为单选 end
	  
	}
	
	function backTo(){
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
		openAlertWindows('windowId','../../publicjsp/jsp/publicPhoneLook.jsp','手机预览','402','500','20%');
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>信息录入详细页面</title>

</head>
<body onload="adaptationWH('_top','vcenter',50)" style="overflow-y:hidden;">
<form action="" id="form1" name="form1" method="post">
<div  class="content_02" style="overflow:hidden;">
	
			<div class="content_02_top" id="_top">
				<input class="but_y_01" type="button" name="operation" value="存草稿" onclick="saveInfo()" id="saveinfo"/>
				<input class="but_y_01" type="button" name="operation" value="上报" onclick="reportInfo()" id="reportinfo"/>
				<input class="but_y_01" type="button" name="operation" value="返回" onclick="backTo()" id="backto"/>
				<input type="hidden" name="submittedinfo_typecode" id ="submittedinfo_typecode"/>
				<input type="hidden" name="submittedinfo_typecode4getinfouser" id="submittedinfo_typecode4getinfouser"/>
				<input type="hidden" name="submittedinfo_typecode2delete" id="submittedinfo_typecode2delete"/>
				<input type="hidden" name="relese_time" id="relese_time" value="<%=currentDbTime%>"/>
			</div>
	<div  id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden;" scrolling="yes">
	<div style="float: left; width: 775px; ">
		 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>基本信息</span></div>
		 <div class="content_02_box_div">
				<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>标题：</th>
			           <td class="content_02_box_div_table_td">
			           <input type="text" name="submittedinfo_title" id="submittedinfo_title" class="validate[required,maxSize[100]] input_185"/>
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
				           <input class="validate[maxSize[50]] input_185"  type="text" id="keyword" name="keyword"></input>
				           
				           </td>
				           <th class="content_02_box_div_table_th">录入时间：</th>
				           <td class="content_02_box_div_table_td">
				           <input class="input_185" readonly="readonly" type="text" id="input_date" value="<%=currentDbTime %>">
				           </td>
		        </tr>
				
				 <tr>
				           <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>上报接收人：</th>
				           <td class="content_02_box_div_table_td">
				           <INPUT class="validate[required] input_160" onmouseover="this.title=this.value"
							 id="reportuser_name" name="reportuser_name" 
							value=""
							readOnly  onclick='chooseReportUnits()'>
							 <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
					  		<input type="hidden" id=reportunits name="reportunits"/>
				           </td>
				          
		         </tr>
		         
				
				</table>
			</div>
			</div>
			 <div class="content_02_box" >
			 <div class="content_02_box_title_bg"><span>正文</span>
			 <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 		 <!-- <span class="color_red">备注：为规范政府行政机关行文格式，请使用正常字体格式进行编辑！</span>  -->
	 		 <span class="color_red">提示：可以直接粘贴word、excel表格</span>
			 </div>
			 
			 <div class="content_02_box_div">	
					<table border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
									<tr>
										<td>
										<textarea id=edit_content_phone name="edit_content_phone" rows="1" cols="1" style="DISPLAY: none;" ></textarea>
										<textarea  id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"></textarea>
										<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content&style=gray" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
										</td>
									</tr>
									
					</table>
			</div>
			</div>
	</div>
</div>
</form>
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>

</html>
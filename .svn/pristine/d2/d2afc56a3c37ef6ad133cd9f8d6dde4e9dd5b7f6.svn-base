<%-- 
描述：是否公开
作者：shuqi.liu
版本：1.0
日期：2013-08-27
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.DsCRUDService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>

<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String ins_id = request.getParameter("ins_id");
	DsCRUDService Service = new DsCRUDServiceImpl();
	
	String is_public = StringUtil.deNull(request.getParameter("is_public"));
	String info_type = StringUtil.deNull(request.getParameter("info_type"));
	if(StringUtil.isBlank(is_public)){
		is_public = Service.getPublicConfig(ins_id);
	}
	if(StringUtil.isBlank(info_type)){
		info_type = Service.getInfoTypeConfig(ins_id);
	}
	//下拉框  选中的id由bean存的值确定
    //String k_secrecy_id_dictType = "gwsfgk";//密级
    //String k_secrecy_id_selectHtml = DictDropDownList.buildSelect4DictType(k_secrecy_id_dictType,"is_public" ,  StringUtil.deNull(is_public), "" , true, "" ,"" ,"","" );
	//下拉框  选中的id由bean存的值确定
    //String number_type_html = DictDropDownList.buildSelect4DictType("gwsfgk","is_public" ,  StringUtil.deNull(is_public), "" , true, "" ,"" ,"class='validate[required] select_240'","" );
  	//下拉框  选中的id由bean存的值确定
    String k_secrecy_id_dictType = "gwxxfl";//密级
    String sql="select d.dictdata_id, d.dictdata_name, d.dictdata_value from oa_dict_data d,oa_dict_type t where d.dict_id=t.dict_id and t.dict_code='gwxxfl' order by d.dictdata_order";
    String[][] selectHtml = DictDropDownList.queryDictData4Expand(sql);
    
    String sql1="select d.dictdata_id, d.dictdata_name, d.dictdata_value from oa_dict_data d,oa_dict_type t where d.dict_id=t.dict_id and t.dict_code='gwsfgk' order by d.dictdata_order";
    String[][] selectHtml1 = DictDropDownList.queryDictData4Expand(sql1);
%>
<title>公文编号页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript">

jQuery(function() {
	jQuery("#is_public").val("<%=is_public%>");
	jQuery("#info_type").val("<%=info_type%>");
});

/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  savePublic
说明:  设置是否公开
参数:   无
返回值: 无
*/
function savePublic(){
	
	var is_public = jQuery("#is_public").val();
	var info_type=jQuery("#info_type").val();
	if(is_public=='1' && info_type==''){
		alert("请选择一个分类！");
		return;
	}
	var values = ["■主动公开   □不予公开   □依申请公开","□主动公开   ■不予公开   □依申请公开","□主动公开   □不予公开   ■依申请公开"];  //1,2,3
	var value ="";
	if(is_public=='1'){
		value = values[0];
	}else if(is_public=='2'){
		value = values[1];
	}else if(is_public=='3'){
		value = values[2];
	}
	getParentWindow("windowIds").selectIsPublicInPut(value);
	getParentWindow("windowIds").isPublicConfigReset(is_public,info_type);
	removeAlertWindows('windowIds',true);
}


//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="savePublic()">保存</button>
<button id=button8 class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" action="" method="post">
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
					   <th class="content_02_box_div_table_th">是否公开：</th>
			           <td class="content_02_box_div_table_td" style="width: 290px">
			           	 <select name="is_public" id="is_public"  class="validate[required] cms_select" style="width: 100%">
				       		<option value="">---请选择---</option>
				       	<%for(int i=0;i<selectHtml1.length;i++){ %>
				       		<option   value='<%=selectHtml1[i][2] %>' ><%=selectHtml1[i][1] %></option>
				       	<%} %>
				       		<!-- <option value="1">公开</option>
				            <option value="2">不公开</option>
				            <option value="3">申请后公开</option> -->
				        </select>
					   </td>
					</tr>
					<tr>
					   <th class="content_02_box_div_table_th">信息分类：</th>
			           <td class="content_02_box_div_table_td" style="width: 290px">
			           	<select name="info_type" id="info_type"  class="validate[required] cms_select" style="width: 100%">
				       	<option  value='' selected>---请选择---</option>
				       	<%for(int i=0;i<selectHtml.length;i++){ %>
				       		<option   value='<%=selectHtml[i][1] %>' title='<%=selectHtml[i][1] %>'><%=selectHtml[i][1] %></option>
				       	<%} %>
				       	<!-- <option   value='机构设置' title='机构设置'   >机构设置</option>
				       	<option   value='财政规范' title='财政规范'   >财政规范</option>
				       	<option   value='行政许可' title='行政许可'   >行政许可</option>
				       	<option   value='财政数据' title='财政数据'   >财政数据</option>
				       	<option   value='业务流程' title='业务流程'   >业务流程</option>
				       	<option   value='人事管理' title='人事管理'  >人事管理</option>
				       	<option   value='政府采购' title='政府采购'   >政府采购</option>
				       	<option   value='信访举报' title='信访举报'   >信访举报</option>
				       	<option   value='其他信息' title='其他信息'   >其他信息</option> -->
				       	</select>

					   </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
</body>
</html>
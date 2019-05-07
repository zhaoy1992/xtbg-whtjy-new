<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String person_id = StringUtil.deNull(request
			.getParameter("person_id"));
	
	PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
	PersonInfoBean personInfoBean = personInfodao.findPersonBaseInfo(person_id);
	String getGroupSelectHtml = personInfodao.getGroupSelectHtml(user_id);
	List<PersonExtraShowBean> phoneBeanList = personInfodao.findPersonExtraInfoList(person_id,"1");
	List<PersonExtraShowBean> foxBeanList = personInfodao.findPersonExtraInfoList(person_id,"2");
	List<PersonExtraShowBean> emailBeanList = personInfodao.findPersonExtraInfoList(person_id,"3");
	List<PersonExtraShowBean> qqBeanList = personInfodao.findPersonExtraInfoList(person_id,"4");
	List<PersonExtraShowBean> birthBeanList = personInfodao.findPersonExtraInfoList(person_id,"5");
	List<PersonExtraShowBean> companyBeanList = personInfodao.findPersonExtraInfoList(person_id,"6");
	List<PersonExtraShowBean> positionBeanList = personInfodao.findPersonExtraInfoList(person_id,"7");
	List<PersonExtraShowBean> addressBeanList = personInfodao.findPersonExtraInfoList(person_id,"8");
	List<PersonExtraShowBean> websiteBeanList = personInfodao.findPersonExtraInfoList(person_id,"9");
	
	String orgid = "";
	String orgname = "";
	if(StringUtil.nullOrBlank(request.getParameter("org_id"))){
		orgid = personInfoBean.getOrg_id();
		orgname = personInfoBean.getOrg_name();
	}else{
		orgid = request.getParameter("org_id");
		orgname = personInfodao.getOrgNameByOrgId(orgid);
	}
	//PersonExtraShowBean 
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonExtraShowBean"%>
<%@page import="java.util.List"%><html>
<head>
<style>
.ui-button {
	margin-left: -1px;
}

.ui-button-icon-only .ui-button-text {
	padding: 0.35em;
}

.ui-autocomplete-input {
	margin: 0;
	padding: 0.48em 0 0.47em 0.45em;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>



<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"
	href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"
	type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
	type="text/javascript" charset="GBK">
	
</script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
	type="text/javascript" charset="GBK">
</script>
<script type="text/javascript">
var person_id = '<%=person_id%>';
var user_id = '<%=user_id%>';
	
	
	$(function() {
		$("#form1").validationEngine();
		
		$("input[name='birth']").datepicker({
			showOn: "button",
			changeYear: true,
			changeMonth: true,
			yearRange: '1900:2012',
			buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"yy-mm-dd"
		});
			
	});
	//分组checkbox点击方法
	var onclickcheckbox = function(){
	
		var groupstr = "";
		var groupids = "";
		$("input[name='group']").each(function (i) {
			if($(this).prop("checked")){//如果被选中了
				groupstr += $(this).val() + ",";
				groupids += $(this).attr("id") + ",";
			}
		});
		//alert(groupstr);
		groupstr = (groupstr.length > 0 )?groupstr.substring(0,groupstr.length-1) : "未分组";
		if (groupids.length > 0 ) groupids = groupids.substring(0,groupids.length-1);
		$('#groupshowstr').text(groupstr);
		$('#groupshowids').val(groupids);
	}

	  //用于添加一个新行 
    function do_Add(tag)
 	{
    	//首先将DOM对象转换成JQuery对象
    	   //然后获得当前DOM对象的父元素tr
    	   //调用Jquery的clone方法，克隆一个行的副本
    	   var tr = $(tag).parents("tr").first().clone();
    	   //清空tr中的input
    	   tr.find("input:text").attr("value","");
    	   //得到当前td所在的table对象
    	   var table = $(tag).parents("table").first();
    	   tr.appendTo(table);
    	   
    	   return false;
 	}

	//用于删除当前行
 	function do_Delete(tag){
 	 	//获取当前td的父级tr
 		 var tr = $(tag).parents("tr").first();
 	   //得到当前td所在的table对象
  	   var table = $(tag).parents("table").first();

		if(table.find("tr").size() > 1){//如果当前table行数大于1，则删除当前行
	  	 	tr.remove();
	 	}else{//否则，清空最后一行的所有input:text的文本框的值
	 		tr.find("input:text").attr("value","");
	 	}
	}

	//获取table的值
	function get_TableValue(name){
	    var personinfoInstance = new Object();
	    var personinfoListStr = "";
		var selectList = $("select[name='" + name + "']");
		var inputList = $("input[name='" + name + "']");
		var type = "";
		switch(name){
			case 'phone': type = "1"; break;
			case 'fox': type = "2"; break;
			case 'email': type = "3"; break;
			case 'qq': type = "4"; break;
			case 'birth': type = "5"; break;
			case 'company': type = "6"; break;
			case 'position': type = "7"; break;
			case 'address': type = "8"; break;
			case 'website': type = "9"; break;
			default :  ;	
		}
		if(selectList.size() <= 0 && inputList.size() <= 0)
			return;
		if(selectList.size() > 0){
			selectList.each(function(i,item){
				if(!IsSpace(inputList.eq(i).val())){//如果input框的值不为空
					personinfoInstance.field_name = $(item).val();
					personinfoInstance.field_value = inputList.eq(i).val();
					personinfoInstance.person_id = person_id;
					personinfoInstance.type = type;
					personinfoInstance.showindex = ""+i;
					personinfoListStr = personinfoListStr + getJsonString(personinfoInstance) + "_____"; 
				}
				
			})
		}else{
			inputList.each(function(i,item){
				if(!IsSpace($(item).val())){//如果input框的值不为空
					personinfoInstance.field_name = name;
					personinfoInstance.field_value = $(item).val();
					personinfoInstance.person_id = person_id;
					personinfoInstance.type = type;
					personinfoInstance.showindex = ""+i;
					personinfoListStr = personinfoListStr + getJsonString(personinfoInstance) + "_____"; 
				}
			})
		}
		
		personinfoListStr = IsSpace(personinfoListStr)?"":personinfoListStr.substring(0,personinfoListStr.length-5);
		//alert(personinfoListStr);
		return personinfoListStr;
	}	
	

	var saveinfo = function(){
		var nametext = IsSpace($('#personname').val())?'未命名':$('#personname').val();
		var nicktext = IsSpace($('#nickname').val())?'无昵称':$('#nickname').val();
		  var baseinfoJson = "{'person_id':'"+person_id+"','name':'"+nametext+"',"+
			"'nick_name':'"+nicktext+"','user_id':'" + user_id + "',"+
			"'org_id':'" + $('#orgid').val() + "','info_type':'public'}";
		var phoneVOList = get_TableValue('phone');
		var foxVOList = get_TableValue('fox');
		var emailVOList = get_TableValue('email');
		var qqVOList = get_TableValue('qq');
		var birthVOList = get_TableValue('birth');
		var companyVOList = get_TableValue('company');
		var positionVOList = get_TableValue('position');
		var addressVOList = get_TableValue('address');
		var websiteVOList = get_TableValue('website');

		$("#baseinfoJson").val(descape(escape(baseinfoJson)));
		$("#phoneVOList").val(escape(phoneVOList));
		$("#foxVOList").val(escape(foxVOList));
		$("#emailVOList").val(escape(emailVOList));
		$("#qqVOList").val(escape(qqVOList));
		$("#birthVOList").val(escape(birthVOList));
		$("#companyVOList").val(escape(companyVOList));
		$("#positionVOList").val(escape(positionVOList));
		$("#addressVOList").val(escape(addressVOList));
		$("#websiteVOList").val(escape(websiteVOList));
		var url = "personinfosaveform.jsp";
		
		document.all.form1.action = url;
		document.all.form1.target = "hiddenFrame";
		$('#form1').submit();
	}

	function closeWin(){
		parent.JqueryDialog.Close();
	}
	
	</script>

<title>人员详细信息</title>

</head>
<body>

<form id="form1" name="form1" class="formular" method="post">
<table class="ctable"">
	<tr>
		<td colspan="4">　　
		<input id="savebtn" name="savebtn" type="button" class="cButton_4text" onclick="saveinfo();" value="保存"/>
		<input id="backbtn" name="backbtn" type="button" class="cButton_4text" onclick="closeWin();" value="关闭"/>
		</td>
	</tr>
	<tr>
		<td width="180" rowspan="3" align="center" ><img
			src="../resources/images/blankpersonimage.gif"  class="personwork_img"/></td>
		<td colspan="2" align="left" valign="top">
		<table width="100%">
			<tr>
				<td class="personwork_title">姓名:</td>
				<td class="tableValue" ><input class="cText_out"
					id="personname" name="personname" value="<%=StringUtil.deNull(personInfoBean.getName()) %>"></input></td>
			</tr>
			<tr>
				<td class="personwork_title">昵称:</td>
				<td class="tableValue" ><input class="cText_out"
					id="nickname" name="nickname" value="<%=StringUtil.deNull(personInfoBean.getNick_name()) %>"></input></td>
			</tr>
			<tr>
				<td colspan="2"><label id="orgname"><span class="personwork_fz"><%=orgname%></span></label><input
			id="orgid" type="hidden" value="<%=orgid%>"></input></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table class="ColumnTableArea">
      <tr>
        <td class="Columnbg">联系方式</td>
         </tr>
    </table>
<table align="center" class="ctable">
	<tr>
		<td valign="top">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话</td>
		<td>
		<table id="phonetable" width="100%">
		<%for(int i = 0 ; i < phoneBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=phoneBeanList.get(i).getSelectHtml() %></td>
				<td align="left" class="personwork_box"><input class="validate[custom[phone]] cText_out" id="phone" name="phone" value="<%=phoneBeanList.get(i).getValue()%>"></input>				</td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真</td>
		<td>
		<table id="foxtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < foxBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_xl"><%=foxBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box"><input class="validate[custom[fax]] cText_out" id="fox" name="fox" value="<%=foxBeanList.get(i).getValue()%>"></input>
				</td>
				<td >
				<input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' />
				</td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">电子邮箱</td>
		<td>
		<table id="emailtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < emailBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_xl"><%=emailBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box"><input class="validate[custom[email]] cText_out" id="email" name="email" value="<%=emailBeanList.get(i).getValue()%>"></input>
				</td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<td rowspan="2" valign="top">QQ&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>
		<table id="qqtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < qqBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_box"><input class="validate[custom[qq]] cText_out"
				id="qq"	name="qq"  value="<%=qqBeanList.get(i).getValue() %>"></input></td>
				<td align="left"><input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' /></td>
			</tr>
		<%} %>
		</table>
		</td>

	</tr>
</table>

<table class="ColumnTableArea">
      <tr>
        <td class="Columnbg">更多详情</td>
         </tr>
    </table>
<table align="center" class="ctable">
	<tr class="personwork_Area">
		<td valign="top">
		生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</td>
		<td>
		<table id="birthtable" width="100%" >
			<tr>
				<td class="personwork_box" ><input class="input_date" style="width:200px;"
					name="birth"  readonly="readonly" value="<%=birthBeanList.get(0).getValue() %>"></input></td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr class="personwork_Area">
		<td valign="top">
		公&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;司</td>
		<td>
		<table id="companytable" width="100%" >
			<tr>

				<td class="personwork_box" ><input class="cText_out"
					name="company"  value="<%=companyBeanList.get(0).getValue() %>"></input></td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr class="personwork_Area">
		<td valign="top">
		职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位</td>
		<td>
		<table id="positiontable" width="100%">
			<tr>
				<td class="personwork_box"><input class="cText_out"
					name="position"  value="<%=positionBeanList.get(0).getValue() %>"></input></td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</td>
		<td>
		<table id="addresstable" width="100%">
		<%for(int i = 0 ; i < addressBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=addressBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box"><input class="cText_out" name="address" value="<%=addressBeanList.get(i).getValue() %>"></input>
				</td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		网&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</td>
		<td>
		<table id="websitetable" width="100%">
		<%for(int i = 0 ; i < websiteBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=websiteBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box"><input class="validate[custom[url]] cText_out" id="website" name="website" value="<%=websiteBeanList.get(i).getValue() %>"></input>
				</td>
				<td><input class='del' id=del type='button' onclick='do_Delete(this)' />
				<input class='add' id=add type='button' onclick='do_Add(this)' /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
</table>
		

<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="">
<input id="phoneVOList" name="phoneVOList" type="hidden" value="">
<input id="foxVOList" name="foxVOList" type="hidden" value=""> <input
	id="emailVOList" name="emailVOList" type="hidden" value=""> <input
	id="qqVOList" name="qqVOList" type="hidden" value=""> <input
	id="birthVOList" name="birthVOList" type="hidden" value=""> <input
	id="companyVOList" name="companyVOList" type="hidden" value="">
<input id="positionVOList" name="positionVOList" type="hidden" value="">
<input id="addressVOList" name="addressVOList" type="hidden" value="">
<input id="websiteVOList" name="websiteVOList" type="hidden" value="">
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
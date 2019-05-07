<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonExtraShowBean"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String person_id = StringUtil.deNull(request
			.getParameter("person_id"));
	String subid=request.getParameter("subid");
	
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
	//PersonExtraShowBean
	
	String cnt = DaoUtil.SqlToField("select count(group_id) cnt from TA_OA_PERSONWORK_GROUP where user_id ='"+user_id+"'");
	
	boolean isConfigGroupInfo = false;//是否配置了分组信息
	if(Integer.parseInt(cnt) > 0)
		isConfigGroupInfo = true;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">
var person_id = '<%=person_id%>';
var user_id = '<%=user_id%>';


	(function( $ ) {
		$.widget( "ui.combobox", {
			_create: function() {
				var self = this,
					select = this.element.hide(),
					selected = select.children( ":selected" ),
					value = selected.val() ? selected.text() : "";

					
				var button = this.button = $( "<input  type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='添加到组'/>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "添加到组" )
				.insertAfter( select )
				.autocomplete({
						delay: 0,
						minLength: 0,
						source: function( request, response ) {
							var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
							response( select.children( "option" ).map(function() {
								var text = $( this ).text();
								if ( this.value && ( !request.term || matcher.test(text) ) )
									return {
										label: text.replace(
											new RegExp(
												"(?![^&;]+;)(?!<[^<>]*)(" +
												$.ui.autocomplete.escapeRegex(request.term) +
												")(?![^<>]*>)(?![^&;]+;)", "gi"
											), "<strong>$1</strong>" ),
										value: text,
										option: this
									};
							}) );
						}
					})
				.removeClass("ui-autocomplete-input")
				.click(function() {
					if(<%=!isConfigGroupInfo%>){//如果没配置分组
						alert("您还没有配置分组信息！");
						return;
					}
					// close if already visible
					if ( button.autocomplete( "widget" ).is( ":visible" ) ) {
						button.autocomplete( "close" );
						return;
					}
					// work around a bug (likely same cause as #5265)
					// pass empty string as value to search for, displaying all results
					button.autocomplete( "search", "" )
				});
				
				this.button.data( "autocomplete" )._renderItem = function( ul, item ) {
					
					var ischeck = "";
					var groupshowids = $('#groupshowids').val();
					var idsArry = groupshowids.split(",");
					$(idsArry).each(function(n,value){
						if(value == item.option.value){
							ischeck = "checked='checked'";
							return;
						}	
					});
					
					var inputhtml =  $( "<li></li>" )
						.data( "item.autocomplete", item )
						.append( "<input type='checkbox'  name='group' onclick='onclickcheckbox()' id='" + item.option.value + "' " + ischeck + " value='" + item.option.text + "'/>" + item.label + "")
						.appendTo( ul );
					 return inputhtml;
				};

				
			},

			destroy: function() {
				//this.input.remove();
				this.button.remove();
				this.element.show();
				$.Widget.prototype.destroy.call( this );
			}
		});
	})( jQuery );

	
	
	$(function() {
		$( "#combobox" ).combobox();
		$( "#toggle" ).click(function() {
			$( "#combobox" ).toggle();
		});

		$("#form1").validationEngine({
			validationEventTrigger: "" //屏蔽焦点事件
		});
					
	});
	//分组checkbox点击方法
	var onclickcheckbox = function(){
	
		var groupstr = "";
		var groupids = "";
		$('#groupshowstr').children().remove();
		$("input[name='group']").each(function (i) {
			if($(this).prop("checked")){//如果被选中了
				groupstr += $(this).val() + ",";
				$('#groupshowstr').append("<span class='personwork_fz'>"+$(this).val()+"&nbsp;&nbsp;</span>")
				groupids += $(this).attr("id") + ",";
			}
		});
		//alert(groupstr);
		if(groupstr.length == 0 ){
			$('#groupshowstr').append("<span class='personwork_fz'>未分组</span>");
		}
		if (groupids.length > 0 ) groupids = groupids.substring(0,groupids.length-1);
		
		
		$('#groupshowids').val(groupids);
	}

	  //用于添加一个新行 
    function do_Add(tag)
 	{
     	var firstTr = $(tag).parents("tr").first();
     	if($("#del",firstTr).is(":hidden")){//如果删除按钮隐藏了，则开启
     		$("#del",firstTr).show();
     	}
    	//首先将DOM对象转换成JQuery对象
    	   //然后获得当前DOM对象的父元素tr
    	   //调用Jquery的clone方法，克隆一个行的副本
    	   var tr = firstTr.clone();
    	
    	   //清空tr中的input
    	   tr.find("input:text").attr("value","");
    	   //得到当前td所在的table对象
    	   var table = $(tag).parents("table").first();
    	   tr.appendTo(table);
    	   adaptationWH('_top','vcenter',45);
    	  
    	   return false;
 	}

	//用于删除当前行
 	function do_Delete(tag){
 		if($(tag).parents("tr").eq(1).find("#del").size()<=2){//如果当前表格里的行数小于等于2，则表示进行删除操作之后要隐藏掉删除按钮
 			$(tag).parents("tr").eq(1).first().find("#del").hide();
     	}
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
			"'group_id':'" + $('#groupshowids').val() + "','info_type':'personal'}";
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
		$("#form1").attr("target","hiddenFrame");
		$("#form1").submit();
	}
/* 
 * 返回 
 */
function back(){
	 var url = "<%=path%>/ccapp/xtbg/public/personwork/jsp/personaladdressbook.jsp";
	 /*location.href = url; */
	var okF = function(){
		removeWindows('<%=subid%>',true);
		location.href = url;
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/public/personwork/jsp/personaladdressbook.jsp";
	location.href = url;
}

</script>

<title>人员详细信息</title>
</head>

<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);setDataTimeClickShowOrHide('birth',window);">
<form id="form1" name="form1" action="personinfosaveform.jsp" class="formular" method="post">
 <div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;"
				id='content_02_top'>
		<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="saveinfo();" value="保存" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		<%=getGroupSelectHtml%>
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 <!--------------基本信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>基本信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="191" class="content_02_box_div_table_th" style="border-top:none; border-left:none;"><span class="color_red">*</span>姓名：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[required,maxSize[15]] input_188"
					id="personname" name="personname" value="<%=StringUtil.deNull(personInfoBean.getName()) %>"></input>
				</td>
				
			</tr>
			<tr>
				<th width="191" class="content_02_box_div_table_th"  style="border-top:none; border-left:none;">昵称：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[maxSize[15]] input_188"
					id="nickname" name="nickname" value="<%=StringUtil.deNull(personInfoBean.getNick_name()) %>"></input>
				</td>
				
			</tr>
			<tr>
			<td colspan="3" style="border:1px solid #EAEAEA; border-top:none; padding:10px;"><label id="groupshowstr">
			<%if(StringUtil.nullOrBlank(personInfoBean.getGroup())){ %>
				<span class="personwork_fz">未分组</span>
			<%}else{ 
				for(String groupstr : personInfoBean.getGroup().split(",")){
						%>
				<span class="personwork_fz"><%=groupstr %></span>
			<%}} %></label>
			 <input
			id="groupshowids" type="hidden" value="<%=StringUtil.deNull(personInfoBean.getGroup_id()) %>"></input></td>
			</tr>				
		</table>
	</div>
 
 		<!--------------联系方式-------------->
 <div >
 	 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>联系方式</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr class="personwork_Area">
		<th width="191" class="content_02_box_div_table_th">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</th>
		<td class="content_02_box_div_table_td" >
		<table id="phonetable" width="100%">
		<%for(int i = 0 ; i < phoneBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=phoneBeanList.get(i).getSelectHtml() %></td>
				<td align="left" class="personwork_box_leftblank"><input class="validate[custom[phone]] input_188" id="phone" name="phone" value="<%=phoneBeanList.get(i).getValue()%>" style="border:solid 1px #C6C6C6;"></input>				</td>
				<td>
				<input class='but_y_01' id=add type='button' onclick='do_Add(this)' value="添加" onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' id=del type='button' value="删除" <%if(phoneBeanList.size() <= 1){ %>style="display: none"<%} %> onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th">
		传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真：</th>
		<td class="content_02_box_div_table_td" >
		<table id="foxtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < foxBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_xl"><%=foxBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box_leftblank"><input class="validate[custom[fax]] input_188" id="fox" name="fox" value="<%=foxBeanList.get(i).getValue()%>" style="border:solid 1px #C6C6C6;"></input>
				</td>
				<td >
				<input class='but_y_01' id=add type='button' onclick='do_Add(this)' value="添加" onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' id=del type='button' value="删除" <%if(foxBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				</td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th">电&nbsp;子&nbsp;邮&nbsp;&nbsp;箱：</th>
		<td class="content_02_box_div_table_td" >
		<table id="emailtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < emailBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_xl"><%=emailBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box_leftblank"><input class="validate[custom[email]] input_188" id="email" name="email" value="<%=emailBeanList.get(i).getValue()%>" style="border:solid 1px #C6C6C6;"></input>
				</td>
				<td>
				<input class='but_y_01' value="添加" id=add type='button' onclick='do_Add(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' value="删除" id=del type='button' <%if(emailBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				</td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr style="display: none;">
		<th width="191" class="content_02_box_div_table_th">QQ：</th>
		<td class="content_02_box_div_table_td" >
		<table id="qqtable" width="100%" class="personwork_Area">
		<%for(int i = 0 ; i < qqBeanList.size() ; i ++){ %>
			<tr  class="personwork_Area">
				<td class="personwork_box">
				<input class="validate[custom[qq]] input_188"
				id="qq"	name="qq"  value="<%=qqBeanList.get(i).getValue() %>"></input>
				</td>
				<td align="left" >
				<input class='but_y_01' value="添加" id=add type='button' onclick='do_Add(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' value="删除" id=del type='button' <%if(qqBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
</table>
</div>
			<!------------更多详情  ---------------->
<div >
	 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>更多详情</span>
				</div>
 	<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
 	<tr class="personwork_Area">
		<th width="191" class="content_02_box_div_table_th">
		生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</th>
		<td class="content_02_box_div_table_td" >
		<table width="100%" cellpadding="0" id="birthtable" >
			<tr>
				<td class="personwork_box" ><input class="date_187" id="birth"  onclick="WdatePicker()" style="width:188px;"
					name="birth"  readonly="readonly" value="<%=birthBeanList.get(0).getValue() %>"></input></td>
				<td><input class='but_y_01' value="删除" id=del type='button' <%if(birthBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr class="personwork_Area">
		<th width="191" class="content_02_box_div_table_th">
		单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</th>
		<td class="content_02_box_div_table_td" >
		<table id="companytable" width="100%" >
			<tr>

				<td class="personwork_box" ><input class="validate[maxSize[50]] input_188" style="border:solid 1px #C6C6C6;width: 183px;"
					name="company" id="company"  value="<%=companyBeanList.get(0).getValue() %>"></input></td>
				<td><%-- <span class="personwork_box">
				  <input class="date_187"  onClick="WdatePicker()" style="width:200px;"
					name="birth"  readonly="readonly" value="<%=birthBeanList.get(0).getValue() %>">
				  </span> --%>
				  <input class='del' id=del type='button' <%if(companyBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' /></td></tr>
		</table>
		</td>
	</tr>
	<tr class="personwork_Area">
		<th width="191" class="content_02_box_div_table_th">
		职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</th>
		<td class="content_02_box_div_table_td" >
		<table id="positiontable" width="100%">
			<tr>
				<td class="personwork_box"><input class="validate[maxSize[50]] input_188" style="border:solid 1px #C6C6C6;width: 183px;"
					name="position" id="position" value="<%=positionBeanList.get(0).getValue()%>"></input></td>
				<td><input class='del' id=del type='button' <%if(positionBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th">
		地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</th>
		<td class="content_02_box_div_table_td" >
		<table id="addresstable" width="100%">
		<%for(int i = 0 ; i < addressBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=addressBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box_leftblank"><input class="validate[maxSize[100]] input_188" id="address" name="address" value="<%=addressBeanList.get(i).getValue() %>" style="border:solid 1px #C6C6C6;"></input>
				</td>
				<td>
				<input class='but_y_01' value="添加" id=add type='button' onclick='do_Add(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' value="删除" id=del type='button' <%if(addressBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th">网&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</th>
		<td class="content_02_box_div_table_td" >
		<table id="websitetable" width="100%">
		<%for(int i = 0 ; i < websiteBeanList.size() ; i ++){ %>
			<tr class="personwork_Area">
				<td class="personwork_xl"><%=websiteBeanList.get(i).getSelectHtml() %></td>
				<td class="personwork_box_leftblank"><input class="validate[maxSize[100]] input_188" id="website" name="website" value="<%=websiteBeanList.get(i).getValue() %>" style="border:solid 1px #C6C6C6;"></input>
				</td>
				<td>
				<input class='but_y_01' value="添加" id=add type='button' onclick='do_Add(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" />
				<input class='but_y_01' value="删除" id=del type='button' <%if(websiteBeanList.size() <= 1){ %>style="display: none"<%} %>  onclick='do_Delete(this)' onMouseOver="javascript:$(this).attr('class','but_y_02');" onMouseOut="javascript:$(this).attr('class','but_y_01');" /></td>
			</tr>
		<%} %>
		</table>
		</td>
	</tr>
 	</table>
 	</div>
 	</div>
 </div>
 </div>
</div>

<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="" />
<input id="phoneVOList" name="phoneVOList" type="hidden" value="" />
<input id="foxVOList" name="foxVOList" type="hidden" value="" /> 
<input id="emailVOList" name="emailVOList" type="hidden" value="" /> 
<input id="qqVOList" name="qqVOList" type="hidden" value="" /> 
<input id="birthVOList" name="birthVOList" type="hidden" value="" /> 
<input id="companyVOList" name="companyVOList" type="hidden" value="" />
<input id="positionVOList" name="positionVOList" type="hidden" value="" />
<input id="addressVOList" name="addressVOList" type="hidden" value="" />
<input id="websiteVOList" name="websiteVOList" type="hidden" value="" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
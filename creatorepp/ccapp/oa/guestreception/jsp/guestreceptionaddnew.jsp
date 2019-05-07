<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.dao.UserCacheDao"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.QueryBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	UserCacheBean userbean=UserCache.getUserCacheBean(userid);
	String grinfo_orgid=userbean.getUnit_id();
	String grinfo_org=userbean.getUnit_name();
	String accids="";
	String accNames="";
	String theRootOrgid = DaoUtil.sqlToField("select org_id from td_sm_organization where parent_id='0'");
	String subid=request.getParameter("subid");
	String grinfo_id = request.getParameter("grinfo");
	GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
	QueryBean queryBean=new QueryBean();
	String grinfo_titile="";
	String grinfo_receptionorg="";
	String grinfo_dutyofficer="";
	String grinfo_dutyofficerid="";
	String grinfo_tel="";
	String grinfo_startime="";
	String grinfo_endtime="";
	String grinfo_guestcontact="";
	String grinfo_guestphone="";
	String content="";
	if(!StringUtil.isBlank(grinfo_id)){
		queryBean= guestreceptionDao.queryGuestInfoAll(grinfo_id);
		grinfo_titile=queryBean.getGuestreceptionBean().getGrinfo_titile();
		grinfo_receptionorg=queryBean.getGuestreceptionBean().getGrinfo_receptionorg();
		grinfo_dutyofficer=	queryBean.getGuestreceptionBean().getGrinfo_dutyofficer();
		grinfo_dutyofficerid=queryBean.getGuestreceptionBean().getGrinfo_dutyofficerid();
		grinfo_tel=  queryBean.getGuestreceptionBean().getGrinfo_tel();
		grinfo_startime=queryBean.getGuestreceptionBean().getGrinfo_startime().toString().substring(0,16);
		grinfo_endtime=queryBean.getGuestreceptionBean().getGrinfo_endtime().toString().substring(0,16);
		grinfo_guestcontact=queryBean.getGuestreceptionBean().getGrinfo_guestcontact();
		grinfo_guestphone=queryBean.getGuestreceptionBean().getGrinfo_guestphone();
		content=queryBean.getGuestreceptionBean().getGrinfo_content();
	}
		
%>
<style type="text/css">
.input_title_text_noborder{ width:99%; border:0px solid #C6C6C6; height:24px; margin-top:0px; font:12px/24px "宋体"; padding:0px 0px; display:inline;}
.date_187_noborder{width:189px; height:24px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../resources/style/blue/images/date_img.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
.xz_187_noborder{width:189px; height:26px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../resources/style/blue/images/xuanze.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
.input_185_noborder{width:180px; height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;overflow:hidden;  float:left; padding:0px 2px; display:inline; }
.texteare_lbjd_noborder{height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;  float:left; padding:0px 2px; display:inline; }
</style>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
//获得登录用户的id
var loginUserID='<%=userid%>';
$(function(){
	$("#formAdd").validationEngine();
	copyvalue();
	setGuestSexCheck();
})

//copy值
function copyvalue(){
	var grinfo_id='<%=grinfo_id%>';
	if( grinfo_id!=null){
		$("#grinfo_titile").val('<%=grinfo_titile%>');
		$("#grinfo_receptionorg").val('<%=grinfo_receptionorg%>');
		$("#grinfo_dutyofficer").val('<%=grinfo_dutyofficer%>');
		$("[name=grinfo_dutyofficerid]").val('<%=grinfo_dutyofficerid%>');
		$("#grinfo_tel").val('<%=grinfo_tel%>');
		$("#grinfo_startime").val('<%=grinfo_startime%>');
		$("#grinfo_endtime").val('<%=grinfo_endtime%>');
		$("#grinfo_guestcontact").val('<%=grinfo_guestcontact%>');
		$("#grinfo_guestphone").val('<%=grinfo_guestphone%>');
		$("#content").val(replaceTextarea2('<%=content%>'));
		}
}

//选择联系人
//var grinfo_dutyofficerid;
function chooseActUser(objId,objName){
	
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type='{"type":"PRESON"}';
	  s.selectedIds=$('#'+objId).val();
	  s.returnFunction=function(orgObj){
		$('#'+objId).val(orgObj.id);
		$('#'+objName).val(orgObj.name);
		queryUserPhone(orgObj.id);
	  }
      s.otherParam={"toporgId":"<%=theRootOrgid%>","userid":"<%=userid%>","resourceType":"GUESTRECEPTION_ADD_CHOOSECONTACTPERSON","backchooseuserids":"","showLevel":"1"};
      s.init();
}
//选择群发人
function chooseMuser(id){
	var url = "../tree/jsp/orguserroletree.jsp?ischeck=true&resourceType=GUESTRECEPTION_ADD_MPSERSON&backchooseuserids="+$("#muserIds").val();
	var userObj= null;
	userObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes");
	var name;
	if(userObj!=null){
		name=userObj.name;
		var orgName=userObj.orgName;
		//var td=$(id).parents("td").first();
		//var input=td.find("input:text");
		userID=userObj.id;
		$("#textareaMuser").val(name);
		$("#muserIds").val(userID);
		//orgID=userObj.orgId;
		//input.val(name);
	}
}
//选择接待人
function chooseFrontman(id){
	var url = "../tree/jsp/orguserroletree.jsp?resourceType=GUESTRECEPTION_ADD_CHOOSEFRONTMAN";
	var userObj= null;
	userObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes");
	if(userObj){
		var name;
		name=userObj.name;
		var orgName=userObj.orgName;
		var td=$(id).parents("td").first();
		var input=td.find("input:text");
		var hiinput=td.find("input:[name='frontusernameid']");
		userID=userObj.id;
		hiinput.val(userID);
		orgID=userObj.orgId;
		input.val(name);
	}
}

function ok() {
	var paramjosn = "";
	paramjosn = "{'loginUserID':'" +  loginUserID + 
	"','groupName':'" + $("#groupName").val()+"'}";
	$("#paramjosn").val(paramjosn);
	var fm = document.getElementById("formAdd");
	fm.target = "hiddenFrame";
	$('#formAdd').submit();
	
}

function returnPage() {
	var url = "pGroup.jsp";
	location.href = url;
}
//选择接待单位
var	orgid;
var chooseOrg = function (){
	var url = "../tree/jsp/orgroletree.jsp?resourceType=GUESTRECEPTION_ADD_CHOOSEOGR";

	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 orgid=orgObj.id;
		 $('#org_id').val(orgObj.id);
		 $('#org_name').val(orgObj.name);
	 }
}



<!-- 动态表格start -->
//var index=1;
//var index1=1;
function Add_Row4NewDay1(){
	var firstTr = $("[name=dayrow]").first().clone();
	
	$(firstTr).find("input[type=text]").val("");
	
	$(firstTr).find("input[type=hidden]").val("");
	
	firstTr.find("textarea").val("");
	
	//把日期的id根据当前tstarttime日期的控件的最大id自增+1
	$(firstTr).find("input[name=tstarttime]").attr("id","tstarttime"+($("input[name=tstarttime]",dayTable).first().attr("id").substr(10,2)+1));
	$(firstTr).find("input[name=ttstarttime]").attr("id","ttstarttime"+($("input[name=ttstarttime]",dayTable).first().attr("id").substr(10,2)+1));
	
	var dayTable = $("#dayTable");
	
	firstTr.appendTo(dayTable);
	
	$(firstTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}

function Del_Row4Day(tag){
	$(tag).parents("tr").first().remove();
	freshShowPtUserList();
}

function do_Add4NewDay(tag){
	var firstTr = $(tag).parents("tr").first().clone();
	firstTr.find("input:text").val("");
	firstTr.find("textarea").val("");
	firstTr.find("[name=accompanyid]").val("");
	$(tag).parents("tr").first().find("#ddel").show();
 	if($("#ddel",firstTr).is(":hidden")){//如果删除按钮隐藏了，则开启
 		$("#ddel",firstTr).show();
 	}
	//首先将DOM对象转换成JQuery对象
	   //然后获得当前DOM对象的父元素tr
	   //调用Jquery的clone方法，克隆一个行的副本
	  // var tr = $("#timerow").clone();
		//tr.attr("name","timerow");
		var table = $(tag).parents("table").first();
		firstTr.appendTo(table);
		//tr.show();
	   //清空tr中的input
	   //tr.find("input:text").attr("value","");
	   //得到当前td所在的table对象
	   return false;
}
//删除天
function deleteDay(tag){
	var intable=$(tag).parents("table");
	var tr=$(tag).parents("tr").first();
	var trsize= $(intable).find("tr[name=dayrow]").size();
	//alert(trsize);
	if(trsize==1){
		Add_Row4NewDay1();
		$(tr).remove();
	}else{
		$(tr).remove();
	}
	freshShowPtUserList();
}


function do_Delete4NewDay(tag){
	//alert("test:"+tag);
	if($(tag).parents("tr").eq(1).find("#ddel").size()<=2){//如果当前表格里的行数小于等于2，则表示进行删除操作之后要隐藏掉删除按钮
			$(tag).parents("tr").eq(1).first().find("#ddel").hide();
 	}
	 	//获取当前td的父级tr
		 var tr = $(tag).parents("tr").first();
	   //得到当前td所在的table对象
	   var table = $(tag).parents("table").first();
	//alert(  table.find("tr").size());
	//if(table.find("tr").size() > 0){//如果当前table行数大于1，则删除当前行
  	 	tr.remove();
 	//}else{//否则，清空最后一行的所有input:text的文本框的值
 		//tr.find("input:text").attr("value","");
 	//}
	freshShowPtUserList();
}
var currentPtUserids = [];//当前陪同人员列表显示的人员id集合
var willAddPtUserids = [];//当前需要新增到陪同人员列表的id集合
var doneDelPtUserids = [];//当前需要删除的陪同人员列表id集合

//解析陪同人员id
function resolvePtUserids(){
	//获得存在的接待人员id
	var existacpids="";
	var existacp=$("#ptUserList").find("tr[id=jiedai]").find("input[name=ptuserid]");
	var existacpArry=[];
	existacp.each(function() {
		if(!IsSpace($(this).val())){
			existacpids +=  $(this).val() + ",";
		}
	});
	existacpids=existacpids.substring(0,existacpids.length-1);
	if(existacpids.indexOf(",") == -1){
		existacpArry.push(existacpids);
	}else{
		existacpArry=existacpids.split(",");
	}
	/* for(var i = 0 ; i < existacpArry.length ; i ++ ){
		doneDelPtUserids.push(existacpArry[i]);
	} */
	/* for(var i = 0 ; i < doneDelPtUserids.length ; i ++ ){
		alert(doneDelPtUserids[i]);
	} */
	
	var accompanyid = $("input[name=accompanyid]");
	var accompanyname = $("input[name=accompany]");
	var accompanyids = "";
	var accompanyidArry = [];
	var accompanyidResult = "";
	accompanyid.each(function() {
		if(!IsSpace($(this).val())){
			accompanyids +=  $(this).val() + ",";
		}
	});
	//alert(existPtuserIdArry)
	if(!IsSpace(accompanyids)){
		accompanyids = accompanyids.substring(0,accompanyids.length-1);
	}
	
	var userids = accompanyids.split(",").unique();
	//alert("userids:"+userids)
	if(!IsSpace(currentPtUserids)){
		willAddPtUserids = [];
		doneDelPtUserids = [];
		for(var i = 0 ; i < currentPtUserids.length ; i ++ ){
			if(userids.join(",").indexOf(currentPtUserids[i]) == -1){
				doneDelPtUserids.push(currentPtUserids[i]);//找出需要删除的陪同人员id集合
			}
		}
		
		currentPtUserids = userids;
	}else{
		willAddPtUserids = [];
		currentPtUserids = userids;
	}
	//去掉接待人员的id

	for(var i = 0 ; i < userids.length ; i++ ){
		for(var j=0; j< existacpArry.length;j++){
			if(userids[i]==trim(existacpArry[j])){
				break;
			}
			if(j==existacpArry.length-1){
				willAddPtUserids.push(userids[i]);
			}
		}
	}
	//alert(willAddPtUserids[0]) 
}

function chooseActUserlead(tag){
	 var objId=$(tag).parent("td").find("input[name=accompanyid]");
	 var s = new $.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加人员";
	  s.returnFunction=function(orgObj){
		    var td=$(tag).parents("td").first();
			if(!IsSpace(orgObj)){
				//var td=$(tag).parents("td").first();
				var existacpids="";
				var existacp=$("#ptUserList").find("tr[id=jiedai]").find("input[name=ptuserid]");
				var existacpArry=[];
				existacp.each(function() {
					if(!IsSpace($(this).val())){
						existacpids +=  $(this).val() + ",";
					}
				});
				existacpids=existacpids.substring(0,existacpids.length-1);
				existacpArry=existacpids.split(",");
				//alert(existacpArry)
				var existacpnames="";
				var existacpname=$("#ptUserList").find("tr[id=jiedai]").find("input[name=ptusername]");
				//alert(existacpname)
				var existacpnameArry=[];
				existacpname.each(function() {
					if(!IsSpace($(this).val())){
						existacpnames +=  $(this).val() + ",";
					}
				});
				existacpnames=existacpnames.substring(0,existacpnames.length-1);
				existacpnameArry=existacpnames.split(",");
				//alert(existacpnameArry)
				var userid="";
				var username=""
				if(orgObj.ps!=null){
					//alert(orgObj.ps.id)
					userid=orgObj.ps.id.split(",");
					//alert(orgObj.ps.name)
					username=orgObj.ps.name.split(",");
				}
				
				
 				/* for(var i=0;i<existacpArry.length;i++){
					for(var j=0;j<userid.length;j++){
						if(existacpArry[i]==userid[j]){
							userid.splice(j,1);
							break;
						}
						
					}
				}
				
				for(var i=0;i<existacpnameArry.length;i++){
					for(var j=0;j<username.length;j++){
						if(existacpnameArry[i]==username[j]){
							username.splice(j,1);
							break;
						}
					}
				} */
				$(td).find("textarea").val(username);
				$(td).find("input[name=accompanyid]").val(userid);
			}else if(orgObj==false){
				$("textarea",td).val("");
				$("input[name=accompanyid]",td).val("");
			}
			$("tr[id=peitong]").remove();
			freshShowPtUserList();
			   
	  }
	  s.treeList=
			  [{
				  'leftHeaderText':'按人员选择',
				  type:'{"type":"105"}',
				  valueKey:'ps',
				  'otherParam':{
					  "toporgId":"<%=theRootOrgid%>",
					  "userid":"<%=userid%>",
					  "resourceType":"GUESTRECEPTION_ADD_CHOOSELEADER",
					  "backchooseuserids":$(objId).val(),
					  "showLevel":"3"}
		}];
	  s.init();
}

function choosePtUser(tag){
	var objId=$(tag).parent("td").find("input[name=ptuserid]");
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.selectIds=objId;
	 
	  s.type='{"type":"106"}';
	  s.returnFunction=function(orgObj){
		if(!IsSpace(orgObj)){
			if(isExsitThePtUser(orgObj.id)||isExsitThePtUser1(orgObj.id)){
				if(isExsitThePtUser(orgObj.id)!=""  ){
					alert("陪同人员已经存在！");
				}else{
					alert("接待人员已经存在！");
				}
			}else{
				var td=$(tag).parents("td").first();
				$("input:text",td).val(orgObj.name);
				$(":hidden",td).val(orgObj.id);
				var url="getajaxuserinfo.jsp";
				var params =  {user_ids:$(tag).parent("td").find("input:hidden").val()};
				$.ajax({
					url: url,
					type: 'POST',
					dataType:'json',
					data: params,
					success: function(data){
						if("null" != data.value){
							showUserSex(data,tag);
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
					}
				})
			
			}	
		}
	  }
    s.otherParam={
    	    "toporgId":"<%=theRootOrgid%>",
    	    "userid":"<%=userid%>",
    	    "resourceType":"GUESTRECEPTION_ADD_CHOOSEFRONTMAN",
    	    "backchooseuserids":$(tag).parent("td").find("input[name=ptuserid]").val(),
    	    "showLevel":"1"};
    s.init();
}
//ajax获得性别机构名称
function showUserSex(data,tag){
	$(tag).parents("tr").find("td").eq(1).find("input:text").val(data.usersex);
	$(tag).parents("tr").find("td").eq(2).find("input:text").val(data.orgname);
}


//刷新陪同人员list
function freshShowPtUserList(){
	resolvePtUserids();
	
	addPtUserList(willAddPtUserids);//将合并的所有日程人员id去重，放入陪同人员列表初始化方法中
	deletePtUserList(doneDelPtUserids);
}



function addPtUserList(userids){
	var url = "getajaxrequest.jsp";
	params = {user_ids:""+willAddPtUserids+""};
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if("null" != data.value){
				createPtUserList(data);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
		}
	});
}
//查询电话号码
function queryUserPhone(userid){
	var url = "getajaxuserphone.jsp";
	params = {user_id:""+userid+""};
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if("null" != data.value){
				showUserPhone(data);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
		}
	});
}
function showUserPhone(data){
	//alert(data.userPhone);
	$("#grinfo_tel").val(data.userPhone);
}
//删除指定的陪同人员数据
function deletePtUserList(delUserids){
	for(var i=0 ; i < delUserids.length ; i++){
		$("tr[name=ptuser_"+delUserids[i]+"]").remove();
	}
}

//创建指定的陪同人员数据
function createPtUserList(data){
	$("tr[id=peitong]").remove();
	
	for(var i=0 ; i < data.length ; i++){
		var tr = $(['<tr id="peitong" name=ptuser_'+data[i].id+'>',
						'<td class="content_02_box_div_table_td" style="width: 183px"><input class="input_185_noborder" style="width: 177px" readonly="readonly"'+
						'style=""  name="ptusername" value="'+data[i].name+'"  />'+
        				'<input type="hidden"  name="ptuserid" value="'+data[i].id+'" /></td>',
						'<td class="content_02_box_div_table_td" style="width: 76px"><input type="text"  class="input_185_noborder" style="width: 69px" readonly="readonly" name="ptsex" value="'+data[i].sex+'"  /></td>',
						/**
						'<td style="width:25%; border-top:none;"><input type="text" class="cText_out_hidden" readonly="readonly" name="ptUnit" value="'+data[i].orgname+'" style="width:80%" /></td>',
						**/
						'<td class="content_02_box_div_table_td" style="width: 335px"><input type="text" name="ptPost" class="input_185_noborder" style="width: 330px" value="'+data[i].orgname+'" readonly="readonly" /></td>',
						'<td class="content_02_box_div_table_td" style="width: 110px;text-align: center;"><input name="upindex" onclick="reSortPtUser(this,\'up\')" type="button" class="up" value=""></input>&nbsp;&nbsp;&nbsp;'+
						'<input name="downindex" onclick="reSortPtUser(this,\'down\')" type="button" class="down" value=""></input></td>',
						'<td class="content_02_box_div_table_td" style="width: 59px">'+
						'<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">'+
						'<a onClick="do_Delete4PtUser(this)"> <img src="../resources/images/del.gif" id="del">删除</a>'+
						'</div>'+
						'</td>',
				   '</tr>'].join(''));
		$("#ptUserList").prepend(tr);
		
	}
}
//控制陪同人员名单上下
function reSortPtUser(tag,type){
	var curTr = $(tag).parents("tr").first();
	var cuTable=$(tag).parents("table").first();
	var tempTr;
	var ptTrList = $("tr",cuTable);
	var index = ptTrList.index(curTr.first());
	if("up" == type && index != 0){
		var upTr = ptTrList.eq(index-1);
		upTr.before(curTr);
	}else if("down" == type && index != ptTrList.length){
		var downTr = ptTrList.eq(index+1);
		downTr.after(curTr);
	}
	
}
//添加接待人员
function do_Add4PtUser(){
	var firstTr = $("tr[id=jiedai]").first();
	//首先将DOM对象转换成JQuery对象
	   //然后获得当前DOM对象的父元素tr
	   //调用Jquery的clone方法，克隆一个行的副本
	   var tr = firstTr.clone();
	   //tr.show();
	   //tr.removeClass();
	   //清空tr中的input
	   tr.find("input:text").attr("value","");
	   //alert(tr.find("[name=ptuserid]").val());
	   tr.find("[name=ptuserid]").val("");
	   $("#ptusername",tr).attr("name","ptusername");
	   $("#ptuserid",tr).attr("name","ptuserid");
	   $("#ptsex",tr).attr("name","ptsex");
	   $("#ptPost",tr).attr("name","ptPost");
	   $("#ptUnit",tr).attr("name","ptUnit");
	   //得到当前td所在的table对象
	   var table = $("#ptUserList");
	   tr.appendTo(table);
	   
	   return false;
}
//删除接待人员
function do_Delete4PtUser(tag){
	var tr = $(tag).parents("tr").first();
	var tableId=$(tag).parents("table").attr("id");
	//alert(tableId);
	if(tableId=="ptUserList"){
		var trsize= $(tag).parents("table").find("tr[id=jiedai]").find("#del").size();
		var table=$(tag).parents("table");
		var userid = $("input[name=ptuserid]",tr).val();
		var username = $("input[name=ptusername]",tr).val();
		if(trsize>1){
			$(tag).parents("tr").remove();
			//trsize--;
		}
		if(trsize==1){
			//$(tr).find("input[type=text]").val("");
			do_Add4PtUser(tag);
			$(tag).parents("tr").remove();
			
		}
	}else{
		var userid = $("input[name=ptuserid]",tr).val();
		var username = $("input[name=ptusername]",tr).val();
		$(tag).parents("tr").remove();
	}
	do_DeletePtUser4AllRelation(userid,username);
}

/**
 * 删除陪同人员以及所有上面的关联
 */
function do_DeletePtUser4AllRelation(userid,username){
	$("textarea[name=accompany]").each(function() {
		if(!IsSpace(username)){
			$(this).val(deleteStrfromSourceStr(username,$(this).val()));
		}
	})

	$("input[name=accompanyid]").each(function() {
		if(!IsSpace(userid)){
			$(this).val(deleteStrfromSourceStr(userid,$(this).val()));
		}
	})
	
}
//从源字符串中删除指定字符串
function deleteStrfromSourceStr(str,sourceStr){
	if(sourceStr.indexOf(str) != -1){
		sourceStr = sourceStr.replace(","+str,"");
		sourceStr = sourceStr.replace(str+",","");
		sourceStr = sourceStr.replace(str,"");
	}
	for(var i=0;i<currentPtUserids.length;i++){
		if(currentPtUserids[i]==str){
			//delete currentPtUserids[i];
			currentPtUserids.splice(i,1)
		}
	}
	return sourceStr;
	
}
//判断陪同人员列表中已存在指定陪同人员
function isExsitThePtUser(userid){
	var result = false;
	$("input[name=ptuserid]","tr[id=peitong]").each(function() {
		//alert($(this).val()+"---"+userid);
		if(trim($(this).val()) == userid){
			result = true;
		}
	});
	return result;
	
}
function isExsitThePtUser1(userid){
	var result = false;
	$("input[name=ptuserid]","tr[id=jiedai]").each(function() {
		//alert($(this).val()+"---"+userid);
		if(trim($(this).val()) == userid){
			result = true;
		}
	});
	return result;
	
}
//动态宾客名单
function addGuestTable(){
	
	//var name= $(tag).parents("tr").attr("name");
	var guestTable=$("#guestinfo");
	cloneTr=$("#guestinfo").find("tr").eq(1).clone();
	//if($("[name="+name+"]").size()==1){
		//$(tag).parents("tr").find("#del").show();
	//}
	//var cloneTr= $(tag).parents("tr").first().clone();
	cloneTr.find("input:text").attr("value","");
	var guestTable=$("#guestinfo");
	cloneTr.appendTo(guestTable);
}

function deleteGuestTable(tag){
	var guestTable=$("#guestinfo");
	var tr=$(tag).parents("tr").first();
	//var name= $(tag).parents("tr").attr("name");
	//var trsize= $("[name="+name+"]").size();
	var trsize=$(guestTable).find("tr[name=trguest]").size();
	//alert(trsize)
	if(trsize==1){
		//$(tag).parents("tr").remove();
		$(tr).find("input[type=text]").val("");
		$(tr).find("[name=guestsex]").html("<option value=''>请选择</option>"
				+"<option value='男'>男</option>"
				+"<option value='女'>女</option>");
	}else{
		$(tr).remove("");
	}
	
}


	//提交方法
	function saveInfo(id){
		var url = "guestreceptionadddonew.jsp?whatDo=1&grstatus_id=1";
		$('#formAdd').attr("target","hiddenFrame");
		$('#formAdd').attr("action",url);
		$('#formAdd').submit();
		
	}
	
	/* 发布按钮 */
	function quickRelease(){
	if(jQuery("#formAdd").validationEngine("validateform")){
		var okF = function(){
			var url = "guestreceptionadddonew.jsp?whatDo=1&grstatus_id=2";
				$('#formAdd').attr("target","hiddenFrame");
				$('#formAdd').attr("action",url);
				$('#formAdd').submit();
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
	
	var returnpage = function() {
		var url = "guestreceptionlist.jsp";
		location.href = url;
	}
	//判断接待单位和来宾单位是否相同
	function judgeOrg(){
		var guestorgName=$("#grinfo_receptionorg").val();
		var orgName=$("#org_name").val();
		if(guestorgName==orgName){
			alert("接待单位和来宾单位不能相同");
			return false;
		}
		return true;
	}
	//当宾客名单不为空的时候，设置性别必填
	function setGuestSexCheck(){
		//var selectTable= $(object).parents("table").first();
		var selectTr= $("#guestinfo").find("[name=trguest]");
		for(var i=0;i<selectTr.length;i++){
			//alert($(selectTr[i]).find("[name=guestname]").val());
			if($(selectTr[i]).find("[name=guestname]").val()!=""){
				$(selectTr[i]).find("[name=guestsex]").attr("class","validate[required]");
			}else{
				$(selectTr[i]).find("[name=guestsex]").attr("class","");
				//当删除宾客姓名的时候情况性别选择
				$(selectTr[i]).find("[name=guestsex]").html("<option value=''>请选择</option>"+
						"<option value='男'>男</option>"+
						"<option value='女'>女</option>");
			}
		}
		
	}
	//保存textarea换行
	function replaceTextarea1(str){
		var reg=new RegExp("\n","g"); 
		var reg1=new RegExp(" ","g"); 
		str = str.replace(reg,"＜br＞"); 
		str = str.replace(reg1,"＜p＞"); 
		return str; 
	}

	//取出textarea显示换行
	function replaceTextarea2(str){
		var reg=new RegExp("＜br＞","g"); 
		var reg1=new RegExp("＜p＞","g"); 
		str = str.replace(reg,"\n"); 
		str = str.replace(reg1," "); 
		return str; 
	}
	
/* 返回 */
	function backTo(){
		
		var okF = function(){
			removeWindows('<%=subid%>',true,false);
			}
			 var p={
				headerText:'提示',
				okName:'确认',
			    okFunction:okF,
			    cancelName:'取消'
			};
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
} 
window.onload = function () {
	setDataTimeClickShowOrHide('grinfo_startime',window);
	setDataTimeClickShowOrHide('grinfo_endtime',window);
	setDataTimeClickShowOrHide('tstarttime',window);
	setDataTimeClickShowOrHide('ttstarttime',window);
	setDataTimeClickShowOrHide('tstarttime1',window)
	setDataTimeClickShowOrHide('ttstarttime1',window)
		adaptationWH('_top','vcenter','15');
	}
</script>
</head>
<body style=" overflow-y:hidden;">
	<!-- 栏目 -->
	<form id="formAdd" method="post">
	<input type="hidden" name="widowsid" value="<%=subid%>" />
	<div class="content_02" style="overflow:hidden;">
	<div class="content_02_top" style=""  id="_top">
		<input class="but_y_01" id="quickReleasebtn" name="quickReleasebtn" type="button"
			class="cButton_4text" onClick="quickRelease();" value="发布" />
		<input class="but_y_01" id="savebtn" name="savebtn" type="button" class="cButton_4text"
			onClick="saveInfo(this.id);" value="存草稿" />
		<input class="but_y_01" id="backbtn" name="backbtn" type="button" class="cButton_4text"
			onClick="backTo()" value="返回" />
	</div>
	<div id="vcenter" scrolling="yes" style="float: left; width: 100%; overflow: scroll; height: 650px;">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box">
	<div class="content_02_box_title_bg">
			<span>接待基本信息</span>
	</div>
	<div class="content_02_box_div">
			<table class="content_02_box_div_table" id="queryTable" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<th class="content_02_box_div_table_th" style="width: 130px">
						<span style="color: red">*</span>主题：
					</th>
					<td class="content_02_box_div_table_td" colspan="5" style="width: 680px">
						<input class="input_title_text_noborder validate[required,maxSize[75]]" id="grinfo_titile" name="grinfo_titile"
							type="text" value="" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" />
					</td>
				</tr>
				<tr>
					<th  class="content_02_box_div_table_th" style="width: 130px" >
						<span style="color: red">*</span>来宾单位：
					</th>
					<td  class="content_02_box_div_table_td" >
						<input class="input_title_text_noborder validate[required,maxSize[75]]" 
							id="grinfo_receptionorg" name="grinfo_receptionorg" value="" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" onClick=''>
						<input type="hidden" id=org_id name=org_id />
					</td>
					<th class="content_02_box_div_table_th" style="width: 130px">
						<span style="color: red">*</span>抵达时间：
					</th>
					<td class="content_02_box_div_table_td">
						<input id="grinfo_startime" name="grinfo_startime" style="width: 180px;height: 26px"
							class="validate[required] date_120 Wdate" type="text"
							onclick="WdatePicker({maxDate:'#F{$dp.$D(\'grinfo_endtime\')}',dateFmt:'yyyy-MM-dd HH:mm'})"" />
					</td>
					<th class="content_02_box_div_table_th" style="width: 130px"><span style="color: red">*</span>离开时间：</th>
					<td class="content_02_box_div_table_td">
							<input id="grinfo_endtime" name="grinfo_endtime" style="width: 184px;height: 26px"
								class="validate[required] date_120 Wdate"
								type="text"
								onclick="WdatePicker({minDate:'#F{$dp.$D(\'grinfo_startime\')}',dateFmt:'yyyy-MM-dd HH:mm'})" />
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 130px">
						<span style="color: red">*</span>联络人：
					</th>
					<td class="content_02_box_div_table_td">
						<input class="input_cx_title_240 validate[required]" style="width: 70px;height: 26px"
							onClick="chooseActUser('grinfo_dutyofficerid','grinfo_dutyofficer')" id="grinfo_dutyofficer" name="grinfo_dutyofficer" value="" readonly>
						<input type="hidden" id="grinfo_dutyofficerid" name="grinfo_dutyofficerid"/>
						<input name="chose_notice_button" id="chose_notice_button" type="button"  class="but_x" style="display:block;" onclick="chooseActUser('grinfo_dutyofficerid','grinfo_dutyofficer')"/>	
					</td>
					<th  class="content_02_box_div_table_th" style="width: 130px">
						<span style="color: red">*</span>联系电话：
					</th>
					<td  class="content_02_box_div_table_td" colspan="5" >
						<input class="input_185_noborder validate[required,custom[phone]]"
							id="grinfo_tel" name="grinfo_tel" type="text"  />
					</td>
					</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 130px">
						<span style="color: red">*</span>来宾联系人：
					</th>
					<td class="content_02_box_div_table_td">
						<input class="input_185_noborder validate[required,maxSize[25]]" id="grinfo_guestcontact" name="grinfo_guestcontact" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value=''
							size=13 style="width: 100px">
					</td>
					<th  class="content_02_box_div_table_th" style="width: 130px" >
						<span style="color: red">*</span>联系电话：
					</th>
					<td  class="content_02_box_div_table_td" colspan="5">
						<input class="input_185_noborder validate[custom[mphone],required]"
							id="grinfo_guestphone" name="grinfo_guestphone"  value=''>
					</td>
				</tr>
			</table>
		</div>	
		</div>	
			<!-- 形成安排表 -->
			<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>行程安排</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()">
				<img src="../resources/images/add.gif">
				添加行程
			</a>
			</div>
			</div>
			<div class="content_02_box_div">
			<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">

				<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 92px">接待日期</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 92px">时间</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">内容</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 187px">地点</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 179px">陪同人员</td>
					<td class="content_02_box_div_table_th" style="text-align: center; width: 59px">操作</td>
				</tr>
				
				<!-- 显示的第一行 -->
				<% 
					if(queryBean.getGuestList()!=null){
						if(queryBean.getTravelList().size()>0){
							for(int i=0;i<queryBean.getTravelList().size();i++){
									accids+=queryBean.getTravelList().get(i).getAccompanyid()+",";
									accNames+=queryBean.getTravelList().get(i).getAccompany()+",";
			    %>	
				<tr name="dayrow">

					<td class="content_02_box_div_table_td">
						<input type="text" name="tstarttime" id="tstarttime" class="date_120 Wdate" style="width: 90px;" 
						  value="<%=queryBean.getTravelList().get(i).getTstarttime()%>"	
						  onClick="WdatePicker({minDate:'#F{$dp.$D(\'grinfo_startime\')}',maxDate:'#F{$dp.$D(\'grinfo_endtime\')}'})"  />
					</td>

					<td class="content_02_box_div_table_td">
						<input type="text" name="ttstarttime" id="ttstarttime" class="date_120 Wdate" onclick="WdatePicker({dateFmt:'HH:mm'})"
							value="<%=queryBean.getTravelList().get(i).getTtstarttime()%>"
							style="width: 90px" />
					</td>
					<td class="content_02_box_div_table_td">
						 
						<textarea class="texteare_lbjd validate[maxSize[100]]" style="width: 150px;overflow:hidden"  name="fromcontent" id="fromcontent"><%=queryBean.getTravelList().get(i).getFromcontent()%></textarea> 
						
					</td>
					<td class="content_02_box_div_table_td">
						<input class="input_185 validate[maxSize[100]]"  id="place" name="place" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" type="text"
							value="<%=queryBean.getTravelList().get(i).getPlace()%>" >
					</td>
					<td class="content_02_box_div_table_td">
					<textarea class="texteare_lbjdx" style="width: 173px" readonly="readonly" name="accompany" onclick="chooseActUserlead(this)" ><%=queryBean.getTravelList().get(i).getAccompany()%></textarea>
					<input type="hidden" name="accompanyid" value="<%=queryBean.getTravelList().get(i).getAccompanyid()%>" />
					</td>
					<td class="content_02_box_div_table_td" id="fftd" name="fftd">
						
						<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
								<a onClick="deleteDay(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
						</div>
					</td>
				</tr>
				<%
							}
							}	
						}else{
				%>
					<tr name="dayrow">

					<td class="content_02_box_div_table_td">
						<input type="text" name="tstarttime" id="tstarttime1" class="date_187_noborder" style="width: 90px;" 
						  value=""	
						  onClick="WdatePicker({minDate:'#F{$dp.$D(\'grinfo_startime\')}',maxDate:'#F{$dp.$D(\'grinfo_endtime\')}'})"  />
					</td>

					<td class="content_02_box_div_table_td">
						<input type="text" name="ttstarttime" id="ttstarttime1" class="date_187_noborder" onclick="WdatePicker({dateFmt:'HH:mm'})"
							value=""
							style="width: 90px" />
					</td>
					<td class="content_02_box_div_table_td" style="border-right:1px solid #DFDFDF;">
						<textarea class="texteare_lbjd_noborder validate[maxSize[100]]" style="width: 140px;overflow:auto;"  name="fromcontent" id="fromcontent"></textarea>
					</td>
					<td class="content_02_box_div_table_td">
						<input class="input_185_noborder validate[maxSize[100]]" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" id="username" name="place" type="text"
							value="" >
					</td>
					<td class="content_02_box_div_table_td">
						<textarea class="texteare_lbjd_noborder" style="width: 173px;overflow: auto" readonly="readonly" name="accompany" onclick="chooseActUserlead(this)" ></textarea>
					 	<input type="hidden" name="accompanyid" value="" />
					</td>
					<td class="content_02_box_div_table_td" id="fftd" name="fftd">
						
						<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
								<a onClick="deleteDay(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
						</div>
					</td>
				</tr>	
				<%
						}
					
				%>
			</table>
			</div>
			</div>
			
			<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>来宾名单</span>
			<div class="content_02_box_add">
			<a onclick="addGuestTable()">
				<img src="../resources/images/add.gif">
				添加来宾
			</a>
			</div>
			</div>
			<div class="content_02_box_div">
			<table id="guestinfo" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 184px">姓名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 76px">性别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 446px">单位及职务</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 59px">操作</td>
				</tr>
				<% 
					if(queryBean.getGuestList()!=null){
						if(queryBean.getGuestList().size()>0){
							for(int i=0;i<queryBean.getGuestList().size();i++){
			    %>	
				<tr name="trguest">
					<td class="content_02_box_div_table_td">
						<input class="input_185 validate[maxSize[25]]" style="width: 177px"  onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"
							id="guestname" name="guestname" value="<%=queryBean.getGuestList().get(i).getGuestname() %>" 
							onblur="setGuestSexCheck()">
					</td>
					<td class="content_02_box_div_table_td">
						<span style="color: red;">*</span>
						<select class="select_188_box" style="border: 0px" id="guestsex" name='guestsex' value=''>
						<%
							if (!StringUtil.isBlank(queryBean.getGuestList().get(i).getGuestsex())) {
						%>
							<option value="<%=queryBean.getGuestList().get(i).getGuestsex()%>"><%=queryBean.getGuestList().get(i).getGuestsex()%></option>
						<%
							if ("男".equals(queryBean.getGuestList().get(i).getGuestsex())) {
						%>
							<option value="女">女</option>
						<%
							} else if ("女".equals(queryBean.getGuestList().get(i).getGuestsex())) {
						%>
							<option value="男">男</option>
						<%
							} else if ("请选择".equals(queryBean.getGuestList().get(i).getGuestsex())) {
						%>
							<option value="男">男</option>
							<option value="女">女</option>
						<%
							}
						%>
						<%
							} else {
						%>
							<option value="">请选择</option>
							<option value="男">男</option>
							<option value="女">女</option>
							
						<%
								}
						%>
						</select>
					</td>
					<td class="content_02_box_div_table_td">
						<input class="input_185 validate[maxSize[100]]" style="width: 440px;" id="guestpost" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" type="text"
							name="guestpost" value="<%=queryBean.getGuestList().get(i).getGuestpost()%>" />
					</td>
					<td class="content_02_box_div_table_td">
					<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">	 
						<a onClick="deleteGuestTable(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
					</div>	
					</td>
				</tr>
				<%
							}
							}
						}else{
				%>
					<tr name="trguest">
					<td class="content_02_box_div_table_td">
						<input class="input_185_noborder validate[maxSize[25]]" style="width: 177px"
							id="guestname" name="guestname" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="" onblur="setGuestSexCheck()"
							>
					</td>
					<td class="content_02_box_div_table_td">
						<select class="select_188_box"  style="border: 0px" id="guestsex" name='guestsex' value=''>
							<option value="">请选择</option>
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
					</td>
					<td class="content_02_box_div_table_td">
						<input class="input_185_noborder validate[maxSize[100]]" style="width: 440px;" id="guestpost" type="text"
							name="guestpost" value='' onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" >
					</td>
					<td class="content_02_box_div_table_td">
					<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">	 
						<a onClick="deleteGuestTable(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
					</div>	
					</td>
				</tr>
				
				<%
						}
					
				%>
			</table>
			</div>
			</div>
			<!-- 接待人员人员名单 -->
			<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>接待人员名单</span>
			<div class="content_02_box_add">
			<a onclick="do_Add4PtUser()">
				<img src="../resources/images/add.gif">
				添加接待人员
			</a>
			</div>
			</div>
			<div class="content_02_box_div">
			<table class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td class="content_02_box_div_table_td" style="text-align:center ;width: 184px">姓名</td>
					<td class="content_02_box_div_table_td" style="text-align:center ;width:76px">性别</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 336px">单位及职务</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 110px">排序</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width:59px" >操作</td>
				</tr>
			</table>
			<table id="ptUserList" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0"
				style="text-align: center; margin-top: 0px; border-top-width: 0px; border-top: none; margin-bottom: 0">
				<%
				List<GuestReceiveBean> accPtNameList=new ArrayList<GuestReceiveBean>();
				if(queryBean.getGuestReceiveList()!=null){
					accPtNameList=queryBean.getGuestReceiveList();
				}
				int count=0;
				if(accPtNameList.size()>0){
					 String accIdsA []={};
					 if(!StringUtil.isBlank(accids)){
						 accIdsA=accids.split(",");
					 }
					for(int i=0;i<accPtNameList.size();i++){ 
					  int count1 =0;
					  for(int j=0; j<accIdsA.length;j++){
						if(accIdsA[j].equals(accPtNameList.get(i).getPtuserid().trim())){
							count1++;
				%>
				<tr id="peitong">
					<td class="content_02_box_div_table_td" style="width: 183px">
						<input type="text" class="input_185_noborder" style="width: 177px" readonly="readonly" 
							 name="ptusername" value="<%=accPtNameList.get(i).getPtusername() %>" />
						<input type="hidden" name="ptuserid" value="<%=accPtNameList.get(i).getPtuserid()%>" />
					</td>
					<td class="content_02_box_div_table_td" style="width: 76px">
						<input class="input_185_noborder" style="width: 69px" readonly="readonly" type="text"
						 name="ptsex" value="<%=accPtNameList.get(i).getPtsex()%>">
					</td>
					<td class="content_02_box_div_table_td" style="width: 335px">
						<input class="input_185_noborder" style="width: 330px" name="ptPost" value="<%=accPtNameList.get(i).getPtpost()%>" />
						<input type="hidden" style="width: 330px" name="remark2" value="<%=i %>" />
					</td>

					<td class="content_02_box_div_table_td" style="width: 110px;text-align: center;">
						<input  onClick="reSortPtUser(this,'up')" class="up" value=""
							type=button name=upindex></input>&nbsp;&nbsp;
						<input  onClick="reSortPtUser(this,'down')" class="down" value=""
							type=button name=downindex></input>
					</td>
					<td class="content_02_box_div_table_td" style="width: 59px">
						<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">	 
						<a onClick="do_Delete4PtUser(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
						</div>	
					</td>
				</tr>
				<%
								}
							}
					  if(count1==0){
						  count++;
						  %>
							<tr id="jiedai">
								<td class="content_02_box_div_table_td" style="width: 183px">
									<input class="input_185_noborder" style="width: 150px;height: 26px;" readonly="readonly" onclick="choosePtUser(this)"
										 name="ptusername" value="<%=accPtNameList.get(i).getPtusername() %>" />
									<input type="hidden" name="ptuserid" value="<%=accPtNameList.get(i).getPtuserid()%>" />
									<input name="chose_button" id="chose_button" type="button"  class="but_x" style="display:block;" onclick="choosePtUser(this)"/>
									
								</td>
								<td class="content_02_box_div_table_td" style="width: 76px">
									<input class="input_185_noborder" style="width: 69px" readonly="readonly" type="text"
									 name="ptsex" value="<%=accPtNameList.get(i).getPtsex()%>">
								</td>
								<td class="content_02_box_div_table_td" style="width: 335px">
									<input class="input_185_noborder" style="width: 330px" name="ptPost" value="<%=accPtNameList.get(i).getPtpost()%>" />
								</td>

								<td class="content_02_box_div_table_td" style="width: 110px;text-align: center;">
									<input  onClick="reSortPtUser(this,'up')" class="up" value=""
										type=button name=upindex></input>&nbsp;&nbsp;
									<input  onClick="reSortPtUser(this,'down')" class="down" value=""
										type=button name=downindex></input>
								</td>
								<td class="content_02_box_div_table_td" style="width: 59px">
									<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">	 
									<a onClick="do_Delete4PtUser(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
									</div>	
								</td>
							</tr>
							<%
					  }
						}
					}
					if(count==0){
						%>
						<tr id="jiedai">
						<td class="content_02_box_div_table_td" style="width: 183px">
							<input class="input_185_noborder" style="width: 150px;height: 26px;" readonly="readonly" onclick="choosePtUser(this)"
								 name="ptusername" value="" />
							<input type="hidden" name="ptuserid" value="" />
							<input name="chose_button" id="chose_button" type="button"  class="but_x" style="display:block;" onclick="choosePtUser(this)"/>
							
						</td>
						<td class="content_02_box_div_table_td" style="width: 76px">
							<input class="input_185_noborder" style="width: 69px" readonly="readonly" type="text"
							 name="ptsex" value="">
						</td>
						<td class="content_02_box_div_table_td" style="width: 335px">
							<input class="input_185_noborder" style="width: 330px" name="ptPost" value="" />
						</td>

						<td class="content_02_box_div_table_td" style="width: 110px;text-align: center;">
							<input  onClick="reSortPtUser(this,'up')" class="up" value=""
								type=button name=upindex></input>&nbsp;&nbsp;
							<input  onClick="reSortPtUser(this,'down')" class="down" value=""
								type=button name=downindex></input>
						</td>
						<td class="content_02_box_div_table_td" style="width: 59px">
							<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">	 
							<a onClick="do_Delete4PtUser(this)"> <img src="../resources/images/del.gif" id="del">删除</a>
							</div>	
						</td>
					</tr>
					
					<%	
					}
				%>
			
				
			</table>
			</div>
			</div>
			
			
			<!-- 备注说明 -->
			<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>说明备注</span>
			</div>
			<div class="content_02_box_div">
			<table class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<th>
					
				</th >
				<td class="content_02_box_div_table_02_td">
					<textarea name="content"  class="textarea_575 validate[required,maxSize[250]]" style="width:99%;overflow: auto" id="content"></textarea>
				</td>
			
			</tr>
			</table>
			</div>
			</div>
			<p>&nbsp;</p>
			<input type="hidden" id="grinfo_sendpersonid" name="grinfo_sendpersonid" value="<%=userid%>">
			<input type="hidden" id="grinfo_id" name="grinfo_id" value="<%=grinfo_id%>">
			<!-- 基本非动态信息 -->
			<input type="hidden" id="baseinfo" name="baseinfo">
			<input type="hidden" id="grinfo_orgid" name="grinfo_orgid" value="<%=grinfo_orgid %>">
			<input type="hidden" id="grinfo_org" name="grinfo_org" value="<%=grinfo_org %>">
			<!-- 双层动态信息,行程安排-->
			<input type="hidden" id="tstarttimelist" name="tstarttimelist">
			<input type="hidden" id="ttstarttimelist" name="ttstarttimelist">
			<input type="hidden" id="fromContentlist" name="fromContentlist">
			<input type="hidden" id="accompanylist" name="accompanylist">
			<input type="hidden" id="accompanyidlist" name="accompanyidlist">
			<input type="hidden" id="placelist" name="placelist">
			<!-- 宾客名单 -->
			<input type="hidden" id="guestnamelist" name="guestnamelist">
			<input type="hidden" id="guestsexlist" name="guestsexlist">
			<input type="hidden" id="guestpostlist" name="guestpostlist">
			<input type="hidden" id="guestUnitlist" name="guestUnitlist">
			<!-- 陪同人员 -->
			<input type="hidden" id="ptusernamelist" name="ptusernamelist">
			<input type="hidden" id="ptuseridlist" name="ptuseridlist">
			<input type="hidden" id="ptPostlist" name="ptPostlist">
			<input type="hidden" id="ptUnitlist" name="ptUnitlist">
			<input type="hidden" id="ptsexlist" name="ptsexlist">
			<!-- 区分页面 -->
			<input type="hidden" name="pageName" value="add">
			<input type="hidden" name="pageName" value="edit">
		
		</div>
		</div>
		</div>
		</form>
		<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>

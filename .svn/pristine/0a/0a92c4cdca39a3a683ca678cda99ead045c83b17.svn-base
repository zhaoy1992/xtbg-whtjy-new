
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(user_id);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();

	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//正文ID
	String document_id = UUID.randomUUID().toString();
	
	String appIds  = "";
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	appIds = osHavaObjectService.queryOsAppIdsForAppRegId(busi_id);
	
	List<Map<String,String>> osAppRegObjectList = new ArrayList<Map<String,String>>();
	osAppRegObjectList = osHavaObjectService.queryAppRegObjectForRegId(busi_id);
	
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="gzjb_wp1_act1";
	}
	
	//跳转windowId
		String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
		
			
	//分类
	OsupplieTypeService typeService = new OsupplieTypeServiceImpl();
	OsupplieTypeBean typeBean = new OsupplieTypeBean();
	List<Map<String,String>> typeList = new ArrayList<Map<String,String>>();
	typeList = typeService.getTypeList(typeBean);

%>
<!-- 公共部分开始 -->
<title>申购计划</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type="text/javascript" src="ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" href="ccapp/xtbg/resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">

	//添加物品
	function Add_Row4NewDay1(type){
		var lastTrObject = jQuery("[name=dayrow]").last();
		var lastTr = jQuery("[name=dayrowhidden]").last().clone();
		
		jQuery(lastTr).find("input[type=text]").val("");
		
		jQuery(lastTr).find("input[type=hidden]").val("");
		
		lastTr.find("input[type=text]").val("");
		
		
		var lastSelectId = lastTrObject.find("input[name=T_OSAPPREG_OB_ID]").attr("id");
		var newlastSelectId;
		if(lastSelectId){
			var lastSelectIdArr = lastSelectId.split("T_OSAPPREG_OB_ID");
			newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
		}else{
			newlastSelectId = 1;
		}
		jQuery(lastTr).find("select[name=PTYPE_SELECT]").attr("id","PTYPE_SELECT"+newlastSelectId);
		jQuery(lastTr).find("select[name=PTYPE_SELECT]").val("");
		jQuery(lastTr).find("input[name=PTYPE_ID]").attr("id","PTYPE_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=PTYPE_NAME]").attr("id","PTYPE_NAME"+newlastSelectId);
		
		jQuery(lastTr).find("select[name=TYPE_SELECT]").attr("id","TYPE_SELECT"+newlastSelectId);
		jQuery(lastTr).find("select[name=TYPE_SELECT]").empty();
		jQuery(lastTr).find("select[name=TYPE_SELECT]").show();
		jQuery(lastTr).find("input[name=OFTYPE_ID]").attr("id","OFTYPE_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=OFTYPE_NAME]").attr("id","OFTYPE_NAME"+newlastSelectId);
		
		jQuery(lastTr).find("select[name=OFUSTYPE_SELECT]").attr("id","OFUSTYPE_SELECT"+newlastSelectId);
		jQuery(lastTr).find("select[name=OFUSTYPE_SELECT]").empty();
		jQuery(lastTr).find("select[name=OFUSTYPE_SELECT]").show();
		jQuery(lastTr).find("input[name=OFUSTYPE_ID_VALUE]").attr("id","OFUSTYPE_ID_VALUE"+newlastSelectId);
		jQuery(lastTr).find("input[name=OFUSTYPE_NAME_VALUE]").attr("id","OFUSTYPE_NAME_VALUE"+newlastSelectId);
		
		jQuery(lastTr).find("select[name=IT_NAME_SELECT]").attr("id","IT_NAME_SELECT"+newlastSelectId);
		jQuery(lastTr).find("select[name=IT_NAME_SELECT]").empty();
		jQuery(lastTr).find("select[name=IT_NAME_SELECT]").show();
		jQuery(lastTr).find("input[name=IT_ID_VALUE]").attr("id","IT_ID_VALUE"+newlastSelectId);
		jQuery(lastTr).find("input[name=IT_NAME_VALUE]").attr("id","IT_NAME_VALUE"+newlastSelectId);
		
		jQuery(lastTr).find("input[name=T_OSAPPREG_OB_ID]").attr("id","T_OSAPPREG_OB_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=T_OSAPPREG_OB_NO]").attr("id","T_OSAPPREG_OB_NO"+newlastSelectId);
		jQuery(lastTr).find("input[name=T_OSAPPREG_OB_BZ]").attr("id","T_OSAPPREG_OB_BZ"+newlastSelectId);//备注
		//序号
		jQuery(lastTr).find("input[name=sequencId]").attr("id","sequencId"+newlastSelectId);
		
		jQuery(lastTr).find("input[name=ADD_STATE]").attr("id","ADD_STATE"+newlastSelectId);//物品添加状态
		
		//操作  删除按钮显示  plan:计划表的物品    control：手动添加物品
		if(type == "plan"||type == ""){ 
			jQuery(lastTr).find("div[name=delDiv]").hide();
			//物品添加状态
			jQuery(lastTr).find("input[name=ADD_STATE]").val("plan");
		} else if(type == "control"){
			jQuery(lastTr).find("div[name=delDiv]").show();
			jQuery(lastTr).find("input[name=ADD_STATE]").val("control");
		} else{
			jQuery(lastTr).find("div[name=delDiv]").show();
			jQuery(lastTr).find("input[name=ADD_STATE]").val("control");
		}
		lastTr.attr("id","dayrow");
		lastTr.attr("name","dayrow");
		
		lastTr.attr("style","");
		
		var dayTable = jQuery("#dayTable");
		
		lastTr.appendTo(dayTable);
		//序号 赋值
		var newTrsize= jQuery("#dayTable").find("tr[name=dayrow]").size();
		for(var i=0;i<newTrsize;i++){
			jQuery("#dayTable").find("tr[name=dayrow]").eq(i).find("input[name=sequencId]").val(i+1);
		}
		
		jQuery(lastTr).find(".date_187").each(function(i,e){
			setDataTimeClickShowOrHide($(this).attr("id"),window);
		});
	}
	function choseOsAppReg(){
		var path ="<%=path%>/ccapp/xtbg/tjy/officesupplies/jsp/osappoverexanoreglist.jsp?windowsId=windowIds";
		openAlertWindows('windowIds',path,'计划表列表',810,400,'25%','25%');
	}
	
	function loadInfo(OsAppIds){
		loadOsAppItemObject(OsAppIds,'<%=busi_id%>');
	}


	//同步获取计划审批表物品信息并填充表格信息
	function loadOsAppItemObject(OsAppIds,_busi_id){
		var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/getbackosappregobjectajax.jsp";
		var params = {osappitem:OsAppIds,busi_id:_busi_id};
		var dayrowtr = jQuery("[name=dayrow]");
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				dayrowtr.remove();
				for (var i = 0; i<data.length; i++){
					Add_Row4NewDay1("plan");
					var objectidno = i+1;
					//物品类别
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].p_type; 
					newOption.value = data[i].p_type_id+";"+data[i].p_type; 
					jQuery("#PTYPE_SELECT"+objectidno).empty();
					jQuery("#PTYPE_SELECT"+objectidno).get(0).options.add(newOption); 
					jQuery("#PTYPE_ID"+objectidno).val(data[i].p_type_id); 
					jQuery("#PTYPE_NAME"+objectidno).val(data[i].p_type); 
					//子物品类别
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].type; 
					newOption.value = data[i].type_id+";"+data[i].type; 
					jQuery("#TYPE_SELECT"+objectidno).empty();
					jQuery("#TYPE_SELECT"+objectidno).get(0).options.add(newOption); 
					jQuery("#OFTYPE_ID"+objectidno).val(data[i].type_id); 
					jQuery("#OFTYPE_NAME"+objectidno).val(data[i].type); 
					//物品
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].ofustype_name; 
					newOption.value = data[i].ofustype_id+";"+data[i].ofustype_name; 
					jQuery("#OFUSTYPE_SELECT"+objectidno).empty();
					jQuery("#OFUSTYPE_SELECT"+objectidno).get(0).options.add(newOption); 
					jQuery("#OFUSTYPE_ID_VALUE"+objectidno).val(data[i].ofustype_id); 
					jQuery("#OFUSTYPE_NAME_VALUE"+objectidno).val(data[i].ofustype_name); 
					//规格
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].it_name; 
					newOption.value = data[i].it_id+";"+data[i].it_name; 
					jQuery("#IT_NAME_SELECT"+objectidno).empty();
					jQuery("#IT_NAME_SELECT"+objectidno).get(0).options.add(newOption); 
					jQuery("#IT_ID_VALUE"+objectidno).val(data[i].it_id); 
					jQuery("#IT_NAME_VALUE"+objectidno).val(data[i].it_name);
					
					jQuery("#T_OSAPPREG_OB_NO"+objectidno).val(data[i].t_os_ob_no);
					jQuery("#T_OSAPPREG_OB_BZ"+objectidno).val(data[i].t_os_ob_bz);
					
					jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_APPIDS").val(OsAppIds);
				}
				jQuery("[name=dayrow]").show();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
		jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_TITLE").focus();
	}
	
	//检查输入的数量与库存数量对比
	function checkHavaNo(T_OSAPPREG_OB_NO){
		var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/getbackoshavabyitidajax.jsp";
		
		var T_OSAPPREG_OB_NO_ID = T_OSAPPREG_OB_NO.id;
		var T_OSAPPREG_OB_NO_IDArr = T_OSAPPREG_OB_NO_ID.split("T_OSAPPREG_OB_NO");
        var IT_ID_VALUE = jQuery("#IT_ID_VALUE"+T_OSAPPREG_OB_NO_IDArr[1]).val();
        
        var T_OSAPPREG_OB_NO_NUM = parseFloat(T_OSAPPREG_OB_NO.value);    //页面填写数量
        var T_NOW_OB_NO_NUM;                                              //库存数量
		
        var falg = true;
        
		var params = {it_id:IT_ID_VALUE};
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				if(data.length>0){
					for (var i = 0; i<data.length; i++){
						if(data[i].t_ha_no==""){
							data[i].t_ha_no = "0";
						}
						T_NOW_OB_NO_NUM = parseFloat(data[i].t_ha_no);
					}
				}else{
					T_NOW_OB_NO_NUM = 0;
				}
				if(T_OSAPPREG_OB_NO_NUM > T_NOW_OB_NO_NUM){
					alert("第"+T_OSAPPREG_OB_NO_IDArr[1]+"行数量过大!库存数量为："+T_NOW_OB_NO_NUM);
					falg = false;
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
		jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_TITLE").focus();
		return falg;
	}

	jQuery(function(){
		<% 
		  if(osAppRegObjectList.size()>0){
			  for(int i = 0;i<osAppRegObjectList.size();i++){
				  Map<String,String> osAppRegObjectMap = osAppRegObjectList.get(i);
		%>
		Add_Row4NewDay1('<%=osAppRegObjectMap.get("add_state")%>'); 
		          var id = '<%=i+1%>';
		          jQuery("#T_OSAPPREG_OB_ID"+id).val('<%=osAppRegObjectMap.get("t_osappreg_ob_id")%>');
		          //父类		         
		          jQuery("#PTYPE_SELECT"+id).val('<%=osAppRegObjectMap.get("p_type_id")%>;<%=osAppRegObjectMap.get("p_type_name")%>');
		          jQuery('#PTYPE_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("p_type_id")%>;<%=osAppRegObjectMap.get("p_type_name")%>']").attr('selected','selected');
		          loadTypeSelect(jQuery("#PTYPE_SELECT"+id)[0]);
		          jQuery("#PTYPE_ID"+id).val('<%=osAppRegObjectMap.get("p_type_id")%>');
		          jQuery("#PTYPE_NAME"+id).val('<%=osAppRegObjectMap.get("p_type_name")%>');
		          
		          //子类别		         
		          jQuery("#TYPE_SELECT"+id).val('<%=osAppRegObjectMap.get("oftype_id")%>;<%=osAppRegObjectMap.get("oftype_name")%>');
		          jQuery('#TYPE_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("oftype_id")%>;<%=osAppRegObjectMap.get("oftype_name")%>']").attr('selected','selected');
		          loadNameSelect(jQuery("#TYPE_SELECT"+id)[0]);
		          jQuery("#OFTYPE_ID"+id).val('<%=osAppRegObjectMap.get("oftype_id")%>');
		          jQuery("#OFTYPE_NAME"+id).val('<%=osAppRegObjectMap.get("oftype_name")%>');
		          
		          //物品	         
		          jQuery("#OFUSTYPE_SELECT"+id).val('<%=osAppRegObjectMap.get("ofustype_id")%>;<%=osAppRegObjectMap.get("ofustype_name")%>');
		          jQuery('#OFUSTYPE_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("ofustype_id")%>;<%=osAppRegObjectMap.get("ofustype_name")%>']").attr('selected','selected');
		          loadItNameSelect(jQuery("#OFUSTYPE_SELECT"+id)[0]);
		          jQuery("#OFUSTYPE_ID_VALUE"+id).val('<%=osAppRegObjectMap.get("ofustype_id")%>');
		          jQuery("#OFUSTYPE_NAME_VALUE"+id).val('<%=osAppRegObjectMap.get("ofustype_name")%>');
		          
		          //规格
		          jQuery("#IT_NAME_SELECT"+id).val('<%=osAppRegObjectMap.get("it_id")%>;<%=osAppRegObjectMap.get("it_name")%>');
		          jQuery('#IT_NAME_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("it_id")%>;<%=osAppRegObjectMap.get("it_name")%>']").attr('selected','selected');
		          jQuery("#IT_ID_VALUE"+id).val('<%=osAppRegObjectMap.get("it_id")%>');
		          jQuery("#IT_NAME_VALUE"+id).val('<%=osAppRegObjectMap.get("it_name")%>');
		          
		          
		          jQuery("#T_OSAPPREG_OB_NO"+id).val('<%=osAppRegObjectMap.get("t_osappreg_ob_no")%>');
		          //如果数量是负数就标记红色  
		          <%if(Integer.valueOf(osAppRegObjectMap.get("t_osappreg_ob_no"))<0){%>
		       	   		jQuery("#T_OSAPPREG_OB_NO"+id).css("color","red");
		          <%}%>
		          
		          jQuery("#T_OSAPPREG_OB_BZ"+id).val('<%=osAppRegObjectMap.get("t_osappreg_ob_bz")%>');
		<%}}%>
		
	  	jQuery("[name=dayrowhidden]").hide();
	  	<%--【办公用品领用登记表】的【办公室负责人】栏改成意见框，并移动到清单的下方。在其他环节为禁用，在【办公室审核】环节为必填项。--%>
	  	<%-- //当处于物品发放环节是填充办公室负责人
	  	if('<%=action_defid %>' == 'yhply_wp1_act2'){   
	  		jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_BGSUSERID").val("<%=user_id %>");
	  		jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_BGSUSERNAME").val("<%=user_name %>");
	  	} --%>
	  	
	});

	
	//删除物品
	function deleteDay(tag,goodsId){
		
		var intable=jQuery(tag).parents("table");
		var tr=jQuery(tag).parents("tr").first();
		var trsize= jQuery(intable).find("tr[name=dayrow]").size();
		if(trsize==1){
			jQuery(tr).remove();
		}else{
			jQuery(tr).remove();
		}
		var newTrsize= jQuery(intable).find("tr[name=dayrow]").size();
		for(var i=0;i<newTrsize;i++){
			jQuery(intable).find("tr[name=dayrow]").eq(i).find("input[name=sequencId]").val(i+1);
		}
	}
	
//异步填充子类别下拉列表
function loadTypeSelect(OFUSTYPE_SELECT){
	var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies2/jsp/getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"type"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("PTYPE_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#TYPE_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#PTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#PTYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#OFTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#OFTYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val(ofustypevalueArr[0]);
		
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].oftype_name; 
					newOption.value = data[i].oftype_id+";"+data[i].oftype_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val(data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
	jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_TITLE").focus();
}

//异步填充物品下拉列表
function loadNameSelect(OFUSTYPE_SELECT){
	var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies2/jsp/getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"name"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("TYPE_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#OFUSTYPE_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#OFTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#OFTYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#OFUSTYPE_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#OFUSTYPE_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val(ofustypevalueArr[0]);
		
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].ofustype_name; 
					newOption.value = data[i].ofustype_id+";"+data[i].ofustype_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val(data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
	jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_TITLE").focus();
}

//异步填充规格下拉列表
function loadItNameSelect(OFUSTYPE_SELECT){
	var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies2/jsp/getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"it_name"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("OFUSTYPE_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#IT_NAME_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#OFUSTYPE_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#OFUSTYPE_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val(ofustypevalueArr[0]);
		
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].it_name; 
					newOption.value = data[i].it_id+";"+data[i].it_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val(data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
	jQuery("#TA_OA_OSAPPREGYHP__T_APPREGYHP_TITLE").focus();
}
//选择规格
	function inItNameForSelect(IT_NAME_SELECT){
		var ofusvalue = IT_NAME_SELECT.value;
		var ofustypevalueArr = ofusvalue.split(";");
		
		var IT_NAME_SELECT_ID =  IT_NAME_SELECT.id;
		var IT_NAME_SELECT_ARR = IT_NAME_SELECT_ID.split("IT_NAME_SELECT");
		
		var IT_NAME_VALUE_ID = "#IT_NAME_SELECT"+IT_NAME_SELECT_ARR[1];
		var IT_ID_VALUE_ID = "#IT_ID_VALUE"+IT_NAME_SELECT_ARR[1];
		var IT_ID_VALUE_NAME = "#IT_NAME_VALUE"+IT_NAME_SELECT_ARR[1];
		
		jQuery(IT_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(IT_ID_VALUE_ID).val(ofustypevalueArr[0]);
		jQuery(IT_ID_VALUE_NAME).val(ofustypevalueArr[1]);
	}
</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input type="hidden" id="org_id" name="org_id"  value="<%=org_id%>"/>
	<input type="hidden" id="orgName" name="orgName"  value="<%=orgName%>"/>
	<oa:input type="hidden" column="UNIT_ID" table="TA_OA_OSAPPREGYHP" value="<%= unit_id%>"/>
	<oa:input type="hidden" column="UNIT_NAME" table="TA_OA_OSAPPREGYHP" value="<%= unit_name%>"/>
	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsAppRegObject" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>

<div id="tabs1" style="width:100%;overflow-x: hidden;overflow: scroll;height: 540px;"  scrolling="yes" >
	<div id="tabs-1">
		<table width="98%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 98%;">
			<%--shang--%>
			<div class="content_02_box" style="width:100%;">
				<div class="content_02_box_title_bg" style="width: 100%;">
					<span>办公用品申领登记表</span>
				</div>
				<div class="content_02_box_div" style="width: 100%;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
						<oa:input type="hidden" column="T_APPREGYHP_APPIDS" table="TA_OA_OSAPPREGYHP" value=""/>
						<oa:input type="hidden" column="T_APPREGYHP_ORG_ID" table="TA_OA_OSAPPREGYHP" value="<%= org_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>领用部室：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_APPREGYHP_ORG_NAME" table="TA_OA_OSAPPREGYHP"
										other="class='input_cx_title_240' readonly='readonly'" value="<%=orgName%>"  />
							</td>
							<oa:input type="hidden" column="T_APPREGYHP_USER_ID" table="TA_OA_OSAPPREGYHP" value="<%= user_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申领人：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="T_APPREGYHP_USER_NAME" table="TA_OA_OSAPPREGYHP"
										other="class='input_cx_title_240' readonly='readonly' " value="<%=user_name %>"/>
							</td>
						</tr>
						<tr>
						<%--row2--%>
						  <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填写时间：</th>
							<td class="content_02_box_div_table_td">
								<oa:date dateFmt='yyyy-MM-dd' other="class='Wdate validate[required]'" style='height:22px;line-height: 22px;float:left;margin-top:3px;'
								   column="T_APPREGYHP_DATE" defaultValue="sysDate" table="TA_OA_OSAPPREGYHP"/>
							</td>
							<th class="content_02_box_div_table_th">采购清单：</th>
							<td class="content_02_box_div_table_td">
								<input class="but_y_06" type="button" id="osappreg" value="选择采购清单" onclick="choseOsAppReg()"/>
							</td>
						</tr>
						<tr>
						<%--row3--%>
						<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申领标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_APPREGYHP_TITLE" table="TA_OA_OSAPPREGYHP"
										other="class='input_cx_title_240 validate[required,maxSize[200]]'" style="width:705px;" />
							</td>
						</tr>
						
						<%-- <tr>
						row4
						<th class="content_02_box_div_table_th">办公室负责人：</th>
						<oa:input type="hidden" column="T_APPREGYHP_BGSUSERID" table="TA_OA_OSAPPREGYHP" value=""/>
						<td class="content_02_box_div_table_td" colspan="3">
							<oa:input
									type="text" column="T_APPREGYHP_BGSUSERNAME" table="TA_OA_OSAPPREGYHP"
									other="class='input_cx_title_240 validate[maxSize[200]]' readonly='readonly'" style="width:705px;" />
						</td>
						</tr> --%>
						
					</table>
				</div>
			</div>
			
			<!-- 形成申购物品清单 DIV-->
			<div class="content_02_box" style="width: 100%;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span>办公用品申领清单</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1('control')" id="addButton"><img src="ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 100%;">
			<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
					 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">序号</td>
					 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 140px"><span style="color: red">*</span>物品类别</td>
					 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 140px"><span style="color: red">*</span>子类别</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span> 名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span>规格型号</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span> 数量</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"> 备注</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 140px;">操作</td>
						</tr>
							<tr  id ="dayrowhidden" name="dayrowhidden">
								<td class="content_02_box_div_table_td">
										<input type="text" id="sequencId" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
								<td>
									<select id="PTYPE_SELECT" name="PTYPE_SELECT" onchange="loadTypeSelect(this);" class="validate[required]" style="width: 150px;">
										<option value="">--请选择--</option>
										<%if(typeList.size()>0){ 
											for(int j=0;j<typeList.size();j++){
												Map<String,String> pTypeMap = typeList.get(j);%>
										<option value="<%=pTypeMap.get("oftype_id")+";"+pTypeMap.get("oftype_name")%>"><%=pTypeMap.get("oftype_name")%></option>
										<%}}%>
									</select>
									<input type="hidden" id="PTYPE_ID" name="PTYPE_ID" value="">
									<input type="hidden" id="PTYPE_NAME" name="PTYPE_NAME" value="">
								</td>
							    <td class="content_02_box_div_table_td">
							    	<!--物品添加状态-->
							    	<input type="hidden" id="ADD_STATE" name="ADD_STATE" class="input_title_text" value="" />
							        <input type="hidden" id="T_OSAPPREG_OB_ID" name="T_OSAPPREG_OB_ID" class="input_title_text" value="" />
							        <select id="TYPE_SELECT" name="TYPE_SELECT"onchange="loadNameSelect(this);" class="validate[required]" style="width: 150px;">
							
									</select>
							        <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" value="" />
							        <input type="hidden" id="OFTYPE_NAME" name="OFTYPE_NAME" value="" />
								</td>
								<td class="content_02_box_div_table_td">
									<select id="OFUSTYPE_SELECT" name=OFUSTYPE_SELECT class="validate[required]" onchange="loadItNameSelect(this);" style="width: 165px;">
									
									</select>
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" /> 
						            <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value=""/>
								</td>
								<td class="content_02_box_div_table_td"> 
						             <select id="IT_NAME_SELECT" name="IT_NAME_SELECT" class="validate[required]" style="width: 165px;" onchange="inItNameForSelect(this);">
						             
									</select>
						             <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value=""/>
									 <input type="hidden" id="IT_NAME_VALUE" name="IT_NAME_VALUE" value=""/> 
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSAPPREG_OB_NO" name="T_OSAPPREG_OB_NO" class="validate[required,maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSAPPREG_OB_BZ" name="T_OSAPPREG_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
									<div class="content_02_box_del" name="delDiv" style="height:24px; margin:0;float: none;text-align: center;">
											<a onClick="deleteDay(this,'')"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
									</div>
														
								</td>
							</tr>
				</table>
				</div>
			</div>
			<!-- 形成申购物品清单DIV -->
			<!--审核意见DIV
			<div class="content_02_box" style="width: 100%;"  >
			 <div class="content_02_box_title_bg" style="width: 100%;">
					<span>申领意见</span>
				</div>
			 	  <table width="100%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">办公室负责人意见：</span>
							 <oa:view column="T_APPREGYHP_BGSYJ" table="TA_OA_OSAPPREGYHP" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
				 </table>
			审核意见DIV END-->
			</div>
			
			</div>
			<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>	
	
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview_conferceBase() {
		jQuery("#print_table").show();
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,800,980,document.getElementById("print_conferenceBase").innerHTML);
	};	                     
	
	//点击完成
	var afterActionSuccessFn=function(){
		getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		removeAlertWindows('<%=windowsId%>',true);
		
	};
	//返回按钮
	function returnPage() {
		window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		removeAlertWindows('<%=windowsId%>',true);
		
	}
	
	function checkDataBeforeRunFlow(){
		var dayrowArr = jQuery("input[name=T_OSAPPREG_OB_NO]");
		var flagValue = true;
		for(var i = 1;i<dayrowArr.size();i++){
			if(!checkHavaNo(dayrowArr[i])){
				return false;
			}
		}
		if(flagValue){
			var flag = false;
			jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
			flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
			if(!flag){
				resetSubmit();
			}
			return flag;
		}
	}
</script>
</body>
</oa:init>
</html>


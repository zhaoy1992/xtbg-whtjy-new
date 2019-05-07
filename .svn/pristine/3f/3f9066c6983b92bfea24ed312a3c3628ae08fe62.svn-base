<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieTypeServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%@page import="com.chinacreator.security.AccessControl"%>											  
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>                                   
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>                        
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>                                            
<%@page import="java.util.Map"%>                                                                       
<%@page import="java.util.HashMap"%>                                                                   
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>  
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>                       
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>              
<%@page import="com.chinacreator.xtbg.core.archive.entity.FlowMoveBean"%>                              
<%@page import="com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean"%>        
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>        

<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String windowsId = request.getParameter("windowsId");
String drag_in_title = "";
String drag_in_attach = "";
String drag_in_webtext = "";
FlowMoveBean fmb = new FlowMoveBean(request);
//正文通过JS搞定
if(fmb.isFlowInFlow()){
String fmb_config = "1,1,1";
fmb_config = (StringUtil.nullOrBlank(fmb_config))?"1,1,1":fmb_config;
String[] fmb_config_arr = fmb_config.split(",");
if(fmb_config_arr[1].equals("1")){
 drag_in_title = request.getParameter("flowTitle");
}
if(fmb_config_arr[2].equals("1")){
 drag_in_attach = StringUtil.getUUID();
 WordArchiveService service = new WordArchiveServiceImpl();
 String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
 Map<String,String> argMap = new HashMap<String,String>();
 argMap.put("flowTitle", request.getParameter("flowTitle"));
 argMap.put("textIdYW", null);
 argMap.put("textIdMQ", null);
 argMap.put("textIdZBD", null);
 argMap.put("attachId", drag_in_attach);
 argMap.put("oldAttachId", request.getParameter("oldAttachId"));
 argMap.put("mFilePath", mFilePath);
 argMap.put("userId", accesscontroler.getUserID());
 Map<String,String> messMap = service.copyAttachForNewFlow(argMap); 
}
}
OfficialDocumentRegisterHandleBean ofr = new OfficialDocumentRegisterHandleBean(request,true);							
if(ofr.isGWDJ()){                                                                                               
	String gwdj = request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);                             
	String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
	String userId = accesscontroler.getUserID();                                                                            
	WordArchiveService service = new WordArchiveServiceImpl();                                                              
	Object mess[] = service.getOfficialDocumentRegisterMess(gwdj, null, mFilePath, userId);                                 
	if(mess!=null&&mess.length>0){                                                                                                      
		Map<String,String> map = (Map<String,String>)mess[0];                                                                 
		drag_in_title = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_TITLE));                                            
		drag_in_attach = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_ATTACH));                                          
	}                                                                                                                       
}                                                                                                                        
com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean pihBean = new com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean();
Map<String,String> pihBeanmap = pihBean.getPageDefaultData(request,response);
String user_id = pihBeanmap.get("user_id");
String user_name = pihBeanmap.get("user_name");
String org_id = pihBeanmap.get("org_id");
String org_name = pihBeanmap.get("org_name");
String unit_id = pihBeanmap.get("unit_id");
String unit_name = pihBeanmap.get("unit_name");
String time = pihBeanmap.get("time");
String date = pihBeanmap.get("date");
String user_worktel = pihBeanmap.get("user_worktel");
String user_mobiletel1 = pihBeanmap.get("user_mobiletel1");

//主键ID
String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));

String appIds  = "";
OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
appIds = osHavaObjectService.queryOsAppIdsForAppRegId(busi_id);
	
List<Map<String,String>> osAppRegObjectList = new ArrayList<Map<String,String>>();
osAppRegObjectList = osHavaObjectService.queryAppRegObjectForRegId(busi_id);

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>事业中心申领审批流程表</title>
  <script src="<%=path %>/ccapp/xtbg/resources/js/util/public.js" type="text/javascript"></script>
  <script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
  <script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
  <script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
  <script type="text/javascript" src="<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
  <script>jQuery(function(){ //DOM Ready
	initGridster();
	jQuery("#OFUSTYPE_NAME_VALUE").hide();
	jQuery("#IT_NAME_VALUE").hide();
});
//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
	}

	function initGridster(){
		jQuery(".gridster ul").gridster({
				widget_margins: [0.5, 0.5],//元素间隔
				widget_base_dimensions: [30,30],//初始化宽度 
				avoid_overlapped_widgets: true,  //不可以重叠
				max_size_y: 35,				//最多可以添加行数
				max_size_x: 35,				//最多可以添加列数
				max_cols: 35
				//collision:{on_overlap_stop: function(collider_data){ }}
		  });
	   jQuery(".gridster ul li").each(function(){//将LI设置为不可拖拽
		   jQuery(".gridster ul").gridster().data('gridster').disable(jQuery(this));
	   });
	  }
	function initPageObj(){
		jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
	   }
   
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
					//子物品类别

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

		          //子类别		         
		          jQuery("#OFTYPE_ID"+id).val('<%=osAppRegObjectMap.get("oftype_id")%>');
		          jQuery("#OFTYPE_NAME"+id).val('<%=osAppRegObjectMap.get("oftype_name")%>');
		          
		          //物品	         
		          jQuery("#OFUSTYPE_SELECT"+id).val('<%=osAppRegObjectMap.get("ofustype_id")%>;<%=osAppRegObjectMap.get("ofustype_name")%>');
		          jQuery('#OFUSTYPE_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("ofustype_id")%>;<%=osAppRegObjectMap.get("ofustype_name")%>']").attr('selected','selected');
		          //loadItNameSelect(jQuery("#OFUSTYPE_SELECT"+id)[0]);
		          jQuery("#OFUSTYPE_ID_VALUE"+id).val('<%=osAppRegObjectMap.get("ofustype_id")%>');
		          jQuery("#OFUSTYPE_NAME_VALUE"+id).val('<%=osAppRegObjectMap.get("ofustype_name")%>');
		          jQuery("#OFUSTYPE_NAME_VALUE"+id).show()
		          jQuery("#OFUSTYPE_SELECT"+id).hide();
		          //规格
		          jQuery("#IT_NAME_SELECT"+id).val('<%=osAppRegObjectMap.get("it_id")%>;<%=osAppRegObjectMap.get("it_name")%>');
		          jQuery('#IT_NAME_SELECT'+id +"option[value='<%=osAppRegObjectMap.get("it_id")%>;<%=osAppRegObjectMap.get("it_name")%>']").attr('selected','selected');
		          jQuery("#IT_ID_VALUE"+id).val('<%=osAppRegObjectMap.get("it_id")%>');
		          jQuery("#IT_NAME_VALUE"+id).val('<%=osAppRegObjectMap.get("it_name")%>');
		          jQuery("#IT_NAME_VALUE"+id).show();
		          jQuery("#IT_NAME_SELECT"+id).hide();
		          
		          jQuery("#T_OSAPPREG_OB_NO"+id).val('<%=osAppRegObjectMap.get("t_osappreg_ob_no")%>');
		          //如果数量是负数就标记红色  
		          <%if(Integer.valueOf(osAppRegObjectMap.get("t_osappreg_ob_no"))<0){%>
		       	   		jQuery("#T_OSAPPREG_OB_NO"+id).css("color","red");
		          <%}%>
		          
		          jQuery("#T_OSAPPREG_OB_BZ"+id).val('<%=osAppRegObjectMap.get("t_osappreg_ob_bz")%>');
		<%}}%>
	  	jQuery("[name=dayrowhidden]").hide();
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
		//选类别
	function chooseType(ofutype_name){
		var ofutype_name_id = ofutype_name.id;
		var id_arr = ofutype_name_id.split("OFTYPE_NAME");
		var ofutype_id_id = "#OFTYPE_ID" + id_arr[1]; 
		
		var ofustype_select_id = "#OFUSTYPE_SELECT" + id_arr[1];
		var ofustype_select = jQuery(ofustype_select_id);
		var it_name_select_id = "#IT_NAME_SELECT" + id_arr[1];
		var it_name_select = jQuery(it_name_select_id);
		
		var s = new jQuery.z_tree();
		s.treeID='mian';
		s.treetypestr='radio';
		s.isShowSeacher=true;
		s.treeName="选取类型";
		s.isType='dept';
		s.headerName="选取类型";
		s.item_id = 'oftype_id';
		s.selectedIds = jQuery(ofutype_id_id).val();
		s.type='OSUPPLIE_TYPE';
		s.returnFunction=function(orgObj){
			it_name_select.empty(); //物品类别改变 规格也跟着改变
			if(!IsSpace(orgObj)){
				ofutype_name.value = orgObj.name;
				jQuery(ofutype_id_id).val(orgObj.id);
				var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies2/jsp/getbacktypeajax2.jsp";
				var params = {ofustypeValue:orgObj.id,method:"name"};
				ofustype_select.show();
				jQuery.ajax({
					async:false,
					url: url,
					type: 'POST',
					dataType: 'json',
					data: params,
					success: function(data){
						ofustype_select.empty();
								
						var newOption1 = document.createElement("OPTION"); 
						newOption1.text = "--请选择--"; 
						newOption1.value = "";
						ofustype_select.get(0).options.add(newOption1); 
								
						for (var i = 0; i<data.length; i++){
							//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
							var newOption = document.createElement("OPTION"); 
							newOption.text = data[i].ofustype_name; 
							newOption.value = data[i].ofustype_id + ";" + data[i].ofustype_name;
								
							ofustype_select.get(0).options.add(newOption); 
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
						alert(jqXHR);
						alert(textStatus);
						alert(errorThrown);
					}
				});
			}else{
				ofutype_name.value = "";
				jQuery(ofutype_id_id).val("");
				ofustype_select.empty();
			}
		}
		s.init();
	}
	//检查数量 大于等于0
	function checkHavaNo2(t_os_ob_no){
		var number = t_os_ob_no.value;
		var regex = /^\+?[1-9][0-9]*$/;
		var re = new RegExp(regex);
		if(!re.test(number)){
			alert("数量为大于0的整数！");
			t_os_ob_no.value = "";
		}
	}
</script>
	
	<style>
		body{
			font-family: Helvetica, arial, sans-serif;
			margin:10px auto;
			color: #fff;
			font-size: 12px;
			width:931px;
			text-align:center;
		}
		ul{	
			background:black;
			list-style:none;
			border: solid 1px black;
		}
		li{	
			border-collapse:collapse;
			color: black;
			margin:-0.5px;
			text-align: left;
			line-height: 100%;
			font: normal;
		}
	</style>

</head>
<body style="width:931px">
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden" value="<%=busi_id %>"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId %>"/>
<input type="hidden" id="action_defid" name="action_defid"  value=""/>


<input type="hidden" id="org_id" name="org_id"  value="<%=org_id %>"/>
<input type="hidden" id="orgName" name="orgName"  value="<%=org_name %>"/>
<oa:input type='hidden' column='T_APPREGYHP_USER_ID' table='TA_OA_OSAPPREGYHP'  value = '<%=user_id %>'/>
<oa:input type='hidden' column='T_APPREGYHP_ORG_ID' table='TA_OA_OSAPPREGYHP'  value = '<%=org_id%>'/>
<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsAppRegObject" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>


<div id="tabs1" style="width:100%;border: 0px;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:60px">
				<td style="display: inline;"><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
		</table>
		<div id="titleids" style="display:none;">
			<ul>
				<li><a href="#tabs-1" onclick="changeIndex(1)">基本信息</a></li>
							</ul>
		</div>
		<div id="tabs-1">
			<article>
				<section>
				<div class="gridster">
					<ul>
						<li id="0570b56f-25c9-44d2-b4cc-6a0c56859f07" data-col="1" data-row="1" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 50px; line-height: 30px;' column='null'  table='' value= '领用部室：' />
						</li>
						<li id="ecbbd330-cf43-494e-a2c4-e9c8688236d2" data-col="6" data-row="1" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='T_APPREGYHP_ORG_NAME' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name %>'/>
						</li>
						<li id="131476b9-a8ef-4aba-ae04-ef7621494993" data-col="16" data-row="1" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 70px; line-height: 30px;' column='null'  table='' value= '申领人：' />
						</li>
						<li id="6932b2e5-1414-4b27-b387-bb8a33ce5db9" data-col="21" data-row="1" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='T_APPREGYHP_USER_NAME' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name %>'/>
						</li>
						<li id="5601380d-7cbc-436d-8853-0074f694c79c" data-col="1" data-row="2" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 50px; line-height: 30px;' column='null'  table='' value= '填写时间：' />
						</li>
						<li id="a9fbebce-b9c7-4db9-bab9-696b2e34cc9b" data-col="6" data-row="2" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:date defaultValue='sysDate' dateFmt='yyyy-MM-dd HH:mm:ss' column='T_APPREGYHP_DATE' table='TA_OA_OSAPPREGYHP' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/>
						</li>
						<li id="174118b8-501f-4c77-be41-e66ba50999be" data-col="16" data-row="2" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left:50px; line-height: 30px;' column='null'  table='' value= '采购清单：' />
						</li>
						<li id="616d36fb-7b71-482a-be65-5908f27ff89f" data-col="21" data-row="2" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<input class="but_y_06" type="button" id="osappreg" value="选择采购清单" onclick="choseOsAppReg()"/>
						</li>
						<li id="3a2abed7-0be6-4bf2-b02d-0c55eef934dd" data-col="1" data-row="3" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 50px; line-height: 30px;' column='null'  table='' value= '申领标题：' />
						</li>
						<li id="0b2b8023-5048-4149-ad37-f33a796397a6" data-col="6" data-row="3" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='T_APPREGYHP_TITLE' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
						</li>
						<li id="30f24d39-b90d-4a47-bfa4-3fcce9edd2e0" data-col="1" data-row="4" data-sizex="5" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 0; line-height: 30px;' column='null'  table='' value= '部门负责人意见：' />
						</li>
						<li id="c4c6b45d-5403-4b4c-83ea-36e7bfb0b07c" data-col="6" data-row="4" data-sizex="25" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='T_APPREGYHP_BMFZRYJ' table='TA_OA_OSAPPREGYHP' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="20420326-5ddc-4a86-8526-274068f4123d" data-col="1" data-row="6" data-sizex="5" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left:0; line-height: 30px;' column='null'  table='' value= '事业中心主任意见：' />
						</li>
						<li id="ba058cef-e23d-4229-ad87-7013ae2529cf" data-col="6" data-row="6" data-sizex="25" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='T_APPREGYHP_SYZXZRYJ' table='TA_OA_OSAPPREGYHP' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="8246a3d1-e8cf-4104-aa7f-8178f3f7a330" data-col="1" data-row="8" data-sizex="5" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left:0; line-height: 30px;' column='null'  table='' value= '后勤部负责人意见：' />
						</li>
						<li id="414e4ab6-7989-4cb3-b983-1f9c61113b90" data-col="6" data-row="8" data-sizex="25" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='T_APPREGYHP_HQBFZRYJ' table='TA_OA_OSAPPREGYHP' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="654e0d02-51a9-4f12-95ab-a7d12b3a8bf8" data-col="1" data-row="10" data-sizex="5" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left:0; line-height: 30px;' column='null'  table='' value= '仓库管理员办结：' />
						</li>
						<li id="968b091d-5ff9-47cd-baf3-a5f9834968d0" data-col="6" data-row="10" data-sizex="25" data-sizey="2" class="gs_w" style="display: list-item; background: white;"> 
							<oa:select column='T_APPREGYHP_CKGLY' table='TA_OA_OSAPPREGYHP' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
								<oa:option optionName='--请选择--' optionValue='' />
								<oa:option optionName='同意发放' optionValue='0' />
								<oa:option optionName='不同意发放' optionValue='1' />
							</oa:select>
						</li>
					</ul>				
					<div class="content_02_box_title_bg" style="width: 100%">
						<span>办公用品申领清单</span>
						<div class="content_02_box_add">
							<a onclick="Add_Row4NewDay1('control')" id="addButton"><img src="ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
						</div>
					</div>
					<div class="content_02_box_div" style="width: 100%;">
						<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
						 	<tr>
						 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px"><span style="color:black;">序号</span></td>
						 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 140px"><span style="color: red">*</span><span style="color:black;">物品类别</span></td>
								<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span><span style="color:black;">名称</span></td>
								<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span><span style="color:black;">规格型号</span></td>
								<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color: red">*</span><span style="color:black;">数量</span></td>
								<td class="content_02_box_div_table_th" style="text-align: center;width: 140px"><span style="color:black;">备注</span></td>
								<td class="content_02_box_div_table_th" style="text-align: center;width: 140px;"><span style="color:black;">操作</span></td>
							</tr>
							<tr  id ="dayrowhidden" name="dayrowhidden">
								<td class="content_02_box_div_table_td">
									<input type="text" id="sequencId" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td">
								    	<!--物品添加状态-->
								    <input type="hidden" id="ADD_STATE" name="ADD_STATE" class="input_title_text" value="" />
								    <input type="hidden" id="T_OSAPPREG_OB_ID" name="T_OSAPPREG_OB_ID" class="input_title_text" value="" />

								    <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" value="" />
								     <input onclick="chooseType(this);" type="text" class="validate[maxSize[400]] input_title_text" style="text-align: center;"  readonly="readonly" id="OFTYPE_NAME" name="OFTYPE_NAME" value="" />
								</td>
								<td class="content_02_box_div_table_td">
									<select id="OFUSTYPE_SELECT" name=OFUSTYPE_SELECT class="validate[required]" onchange="loadItNameSelect(this);" style="width: 165px;">
										
									</select>
							        <input type="text" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" /> 
							        <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value=""/>
								</td>
								<td class="content_02_box_div_table_td"> 
							        <select id="IT_NAME_SELECT" name="IT_NAME_SELECT" class="validate[required]" style="width: 165px;" onchange="inItNameForSelect(this);">
							             
									</select>
							        <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value=""/>
									<input type="text" id="IT_NAME_VALUE" name="IT_NAME_VALUE" value="" readonly="readonly" class="validate[required] input_title_text" style="text-align: center;" /> 
								</td>
								<td class="content_02_box_div_table_td"> 
									<input type="text" id="T_OSAPPREG_OB_NO" onblur="checkHavaNo2(this);" name="T_OSAPPREG_OB_NO" class="validate[required,maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
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
				</section>
			</article>
		</div>
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
<script language="javascript" type="text/javascript">	                     
	
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
<script>jQuery(function(){ //DOM Ready
	initPageObj();
});
</script>

<%--
describe: 会议纪要登记的主页面
author:dailianchun
date: 2013-6-26
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String windowId = request.getParameter("windowId");//窗口id
    String flag = StringUtil.deNull(request.getParameter("flag"));//标志 0：可操作，1：只能查看
    //如果没有传入参数，则默认设置为只能查看
    flag = StringUtil.nullOrBlank(flag)?"1":flag;
    
     
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    
    String orgId = usercachebean.getUnit_id();//accesscontroler.getChargeOrgId();//用户所属机构id
    String orgName = usercachebean.getUnit_name();//accesscontroler.getChargeOrgName();//机构名   
    String time = DateUtil.getCurrentDateTime();//创建时间
    
    //服务对象
    MeetingTemplateService service = new MeetingTemplateServiceImpl();
    MeetingTemplateBean bean = null;    
    if(!StringUtil.nullOrBlank(id)){
        bean = service.queryToMeetingTemplateBean(id);
        //处理会议开始时间
        String beginTime = bean.getM_begin_time().toString();
        if(!StringUtil.nullOrBlank(beginTime)){
            bean.setM_begin_time(beginTime.substring(0,beginTime.length()-3));
        }
        //处理会议结束时间
        String endTime = bean.getM_end_time().toString();
        if(!StringUtil.nullOrBlank(endTime)){
            bean.setM_end_time(endTime.substring(0,endTime.length()-3));
        }
       //处理报名截止时间
        String closeTime = bean.getM_close_time().toString();
        if(!StringUtil.nullOrBlank(closeTime)){
            bean.setM_close_time(closeTime.substring(0,closeTime.length()-3));
        }         
    }else{
        bean = new MeetingTemplateBean();
        bean.setM_tmp_unit_id(orgId);
        bean.setM_tmp_unit_name(orgName);
        bean.setM_tmp_creator_id(userId);
        bean.setM_tmp_creator_name(userName);
        bean.setM_tmp_create_time(time);
        bean.setM_tmp_org_id(usercachebean.getOrg_id());
        bean.setM_tmp_org_name(usercachebean.getOrg_name());
    }    
    
    //会议室service对象
    MeetingRoomService roomService = new MeetingRoomServiceImpl();
    //根据机构id查询对应的会议室数据
    List<MeetingRoomBean> roomList = roomService.queryListMeetingRoom(bean.getM_tmp_unit_id());
    //会议类型数据
    MeetingTypeService typeService = new MeetingTypeServiceImpl();
    //根据机构id查询对应的会议类型数据
    List<MeetingTypeBean> typeList = typeService.queryListMeetingTypeByOrgId(bean.getM_tmp_unit_id());

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
    
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
var id = "<%=StringUtil.deNull(bean.getM_tmp_id())%>";
var flag = "<%=StringUtil.deNull(flag) %>"; 
var windowId ="<%=windowId%>";

    jQuery(function(){
        //控制按钮的显示
        if("0" == flag){
          jQuery("#cz_zc_button").show();
        }
        
        //给输入框赋值
        setAllValues();
       
        //会议室多选框添加onchange事件
        jQuery("#m_room_id").change(function(){
            //给会议地址赋值
            jQuery("#m_address").val(jQuery("#m_room_id option[selected=selected]").attr("address"));
        });
        
    });
    
   /**
    *给所有的输入框赋值
    */
    function setAllValues(){
       jQuery("#m_tmp_id").val("<%=StringUtil.deNull(bean.getM_tmp_id())%>");
       jQuery("#m_title").val("<%=StringUtil.deNull(bean.getM_title())%>");
       jQuery("#m_begin_time").val("<%=StringUtil.deNull(bean.getM_begin_time())%>");
       jQuery("#m_end_time").val("<%=StringUtil.deNull(bean.getM_end_time())%>");
       jQuery("#m_address").val("<%=StringUtil.deNull(bean.getM_address())%>");
       jQuery("#m_link_user_id").val("<%=StringUtil.deNull(bean.getM_link_user_id())%>");
       jQuery("#m_link_user_name").val("<%=StringUtil.deNull(bean.getM_link_user_name())%>");
       jQuery("#m_link_dept_id").val("<%=StringUtil.deNull(bean.getM_link_dept_id())%>");
       jQuery("#m_link_dept_name").val("<%=StringUtil.deNull(bean.getM_link_dept_name())%>");
       jQuery("#m_link_tel").val("<%=StringUtil.deNull(bean.getM_link_tel())%>");
       jQuery("#m_master_user_id").val("<%=StringUtil.deNull(bean.getM_master_user_id())%>");
       jQuery("#m_master_user_name").val("<%=StringUtil.deNull(bean.getM_master_user_name())%>");
       jQuery("#m_attender_count").val("<%=StringUtil.deNull(bean.getM_attender_count())%>");
       jQuery("#m_close_time").val("<%=StringUtil.deNull(bean.getM_close_time())%>");
       jQuery("#m_contents").val("<%=StringUtil.deNull(bean.getM_contents())%>");
       jQuery("#m_receiver_unit_ids").val("<%=StringUtil.deNull(bean.getM_receiver_unit_ids())%>");
       jQuery("#m_receiver_user_ids").val("<%=StringUtil.deNull(bean.getM_receiver_user_ids())%>");
       jQuery("#m_receiver_unit_names").val("<%=StringUtil.deNull(bean.getM_receiver_unit_names())%>");
       jQuery("#m_receiver_user_names").val("<%=StringUtil.deNull(bean.getM_receiver_user_names())%>");
       jQuery("#m_tmp_create_time").val("<%=StringUtil.deNull(bean.getM_tmp_create_time())%>");
       jQuery("#m_tmp_creator_id").val("<%=StringUtil.deNull(bean.getM_tmp_creator_id())%>");
       jQuery("#m_tmp_creator_name").val("<%=StringUtil.deNull(bean.getM_tmp_creator_name())%>");
       jQuery("#m_tmp_unit_id").val("<%=StringUtil.deNull(bean.getM_tmp_unit_id())%>");
       jQuery("#m_tmp_unit_name").val("<%=StringUtil.deNull(bean.getM_tmp_unit_name())%>");
       jQuery("#m_tmp_org_id").val("<%=StringUtil.deNull(bean.getM_tmp_org_id())%>");
       jQuery("#m_tmp_org_name").val("<%=StringUtil.deNull(bean.getM_tmp_org_name())%>");
       
       //设置会议类型类型选中
       jQuery("#m_type_id option[value=<%=StringUtil.deNull(bean.getM_type_id())%>]")
          .removeAttr("selected").attr("selected","selected");
       //设置会议室选中
       jQuery("#m_room_id option[value=<%=StringUtil.deNull(bean.getM_room_id())%>]")
          .removeAttr("selected").attr("selected","selected");
       //会议发送名义
       jQuery("#m_send_name option[value=<%=StringUtil.deNull(bean.getM_send_name())%>]")
          .removeAttr("selected").attr("selected","selected");       

       //是否需要 报名
        //默认是需要报名的，故默认值为1
        var m_is_need_signup_value = ("" == "<%=StringUtil.deNull(bean.getM_is_need_signup())%>"
                                     ?"1":"<%=StringUtil.deNull(bean.getM_is_need_signup())%>");

        jQuery('input[name=m_is_need_signup][value="'+m_is_need_signup_value+'"]')
          .removeAttr("checked").attr("checked","checked");
       
       //短信发送方式多选框
       var msgType = "<%=StringUtil.deNull(bean.getM_msg_type())%>".split(",");
       //由于提交的值是将两个多选框拼接成已“,”分割，故需截取字符串后再赋值
       for(var i=0;i<msgType.length;i++){
          jQuery(":checkbox[name=m_msg_type][value="+msgType[i]+"]").removeAttr("checked").attr("checked","checked");
       }
       

       //单位列表
       createrDeptAndPosn({
           id:jQuery("#m_receiver_unit_ids").val(),
           name:jQuery("#m_receiver_unit_names").val()
       },"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');      
       //人员列表
       createrDeptAndPosn({ 
           id:jQuery("#m_receiver_user_ids").val(),
           name:jQuery("#m_receiver_user_names").val()},
           "userTd", 'm_receiver_user_ids','m_receiver_user_names',false,false,false,true);
    }

    /**
     *获得所有需要提交的参数
     */
    function getAllValues(){
       var params = new Object();
       params["m_tmp_id"] = jQuery("#m_tmp_id").val();
       params["m_title"] = jQuery("#m_title").val();
       params["m_begin_time"] = jQuery("#m_begin_time").val();
       params["m_end_time"] = jQuery("#m_end_time").val();
       params["m_address"] = jQuery("#m_address").val();
       params["m_link_user_id"] = jQuery("#m_link_user_id").val();
       params["m_link_user_name"] = jQuery("#m_link_user_name").val();
       params["m_link_dept_id"] = jQuery("#m_link_dept_id").val();
       params["m_link_dept_name"] = jQuery("#m_link_dept_name").val();
       params["m_link_tel"] = jQuery("#m_link_tel").val();
       params["m_master_user_id"] = jQuery("#m_master_user_id").val();
       params["m_master_user_name"] = jQuery("#m_master_user_name").val();
       params["m_attender_count"] = jQuery("#m_attender_count").val();
       params["m_close_time"] = jQuery("#m_close_time").val();
       params["m_send_name"] = jQuery("#m_send_name").val();
       params["m_contents"] = jQuery("#m_contents").val();
       params["m_receiver_unit_ids"] = jQuery("#m_receiver_unit_ids").val();
       params["m_receiver_user_ids"] = jQuery("#m_receiver_user_ids").val();
       params["m_receiver_unit_names"] = jQuery("#m_receiver_unit_names").val();
       params["m_receiver_user_names"] = jQuery("#m_receiver_user_names").val();
       params["m_tmp_contents"] = jQuery("#m_tmp_contents").val();
       params["m_tmp_create_time"] = jQuery("#m_tmp_create_time").val();
       params["m_tmp_creator_id"] = jQuery("#m_tmp_creator_id").val();
       params["m_tmp_creator_name"] = jQuery("#m_tmp_creator_name").val();
       params["m_msg_contents"] = jQuery("#m_msg_contents").val();
       params["m_tmp_unit_id"] = jQuery("#m_tmp_unit_id").val();
       params["m_tmp_unit_name"] = jQuery("#m_tmp_unit_name").val();
       params["m_tmp_org_id"] = jQuery("#m_tmp_org_id").val();
       params["m_tmp_org_name"] = jQuery("#m_tmp_org_name").val();
       
       params["m_type_id"] = jQuery("#m_type_id").val();
       //如果选中第一个option则不要
       params["m_type_name"] = jQuery("#m_type_id option[value='']~option:selected").text();
       params["m_room_id"] = jQuery("#m_room_id").val();
       params["m_room_name"] = jQuery("#m_room_id option[value='']~option:selected").text();
       params["m_send_name"] = jQuery("#m_send_name").val();
       //是否需要报名
       params["m_is_need_signup"] = jQuery("input[name='m_is_need_signup']:checked").val();
       //短信发送方式
       var msgType = new Array();
       jQuery("input[name='m_msg_type']:checked").each(function(){         
           msgType.push(jQuery(this).val());
       });       
       params["m_msg_type"] = msgType.join(","); 
       return params;
    }

    /*
    函数:  adddeptanduser
    说明:  弹出公告接收人和接收部门树
    参数:   无
    返回值: 无
    */
    function adddeptanduser() {
        var s = new jQuery.z_tree_leftRigth();
        s.treeID='button_envelop_username';
        s.isShowSeacher="aa";
        s.treeName="选取人员";
        s.headerName="选取人员";
        s.titelText = "选择人员";
        s.rightHeaderText="已添加机构和人员";
        s.isNewCommonUse=false;
        s.treeList=[{
                        leftHeaderText:'按人员选择',
                        valueKey:'ps',
                        selectedIds:jQuery("#m_receiver_user_ids").val(),
                        type : 'APERSON'
                     },
                    {
                        leftHeaderText:'按部门选择',
                        item_id :'org_id',
                        isType:'dept', 
                        valueKey:'dept',
                        selectedIds:jQuery("#m_receiver_unit_ids").val(),
                        type:'AORG'
                    }];
         s.returnFunction=function(object){
             jQuery("#deptTd").html("");
             jQuery("#m_receiver_user_ids").val("");
             jQuery("#m_receiver_user_names").val("");
             jQuery("#userTd").html("");
             jQuery("#m_receiver_unit_ids").val("");
             jQuery("#m_receiver_unit_names").val("");
             createrDeptAndPosn(object.dept,"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');
             createrDeptAndPosn(object.ps,"userTd",'m_receiver_user_ids','m_receiver_user_names',false,false,false,true);
         }
         s.init();
    }   

    /*
    函数:  Ok
    说明:  提交添加与修改(发布操作)
    参数:   无
    返回值: 无
    */
    var save = function() {
        //没有传入id,或为复制操作时，则为插入数据
        if("" == id){
            //发布，传入状态和操作参数
            ajaxSubmit("add","确定要保存吗？",1);
        }else{
             //发布，传入状态和操作参数
            ajaxSubmit("update","确定要更新吗？",1);
        }   
    }


    /**
     函数:  ajaxSubmit
     说明:  ajax访问后台
     参数: action 操作事件（add，update等）
         alertMsg 弹出框的提示信息 
         state 状态 0：暂存，1：发布
          
     返回值: 无
     */
    var ajaxSubmit = function(action,alertMsg){
        
        //是否全部验证通过      
        if(!jQuery('#form1').validationEngine('validate') ){
          return ;
        }
        
        var okF = function(){
                    jQuery("#cz_fb_button").attr("disabled","disabled");
                    jQuery("#cz_zc_button").attr("disabled","disabled");
                    //获得所有参数
                    var param = getAllValues();
                    param["action"] = action;
                    //ajax方式提交数据
                    jQuery.ajax({
                        type: "post", 
                        url: "meetingtemplatedo.jsp", 
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        data : param,
                        dataType: "json",
                        success: function (data) {
                            jQuery("#cz_fb_button").removeAttr("disabled");
                            jQuery("#cz_zc_button").removeAttr("disabled");
                            if(data&&data.msg){
                               alert(data.msg);
                            }
                            //操作成功，返回上层界面
                            if(data && data.flag && "true" == data.flag){
                               removeWindows(windowId,true);                                
                            }
                        }, 
                        error: function (XMLHttpRequest, textStatus, errorThrown) { 
                            jQuery("#cz_fb_button").removeAttr("disabled");
                            jQuery("#cz_zc_button").removeAttr("disabled");
                            alert("出现异常，请稍后再试！");
                        }
                     });
              }
              var p={
                        headerText:'提示',
                        okName:'确认',
                        okFunction:okF,
                        cancelName:'取消'
              };
                    alert(alertMsg,p);        
    }
    /**
     * 关闭弹出框
     */
    function closed(){
        if(flag == 0){
        //新增或修改数据，提示是否保存
            var okF = function(){
                removeWindows(windowId,true);
            }
            var p={
                headerText:'提示', 
                okName:'确认',
                okFunction:okF,
                cancelName:'取消'
            };
            alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
        }else{
            removeWindows(windowId,true);
        }
    }

    /*
        函数:  chooseOrg
        说明:  选择人员
        参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,
            orgName(回填父页面的“单位”控件id),treetypestr（单选radio或多选checkbox）
    */
    var chooseActUsers = function (userId,userName,orgId,orgName,treetypestr){
        var s = new jQuery.z_tree();
        s.treeID = 'mianUser';
        s.treetypestr = treetypestr;
        s.isShowSeacher = true;
        s.treeName = "选取人员";
        s.headerName = "选取人员";
        s.type = "APERSON";
        s.selectedIds = jQuery("#"+userId).val(),
        s.returnFunction = function(userObj,o) {            
           try{
            if (!IsSpace(userObj)) {
                jQuery('#'+userId).val(userObj.id);
                jQuery('#'+userName).val(userObj.name);
                jQuery('#'+orgName).val(userObj.returnparentNode);                
                if(o&&o.length>0){
                    jQuery('#'+orgId).val(o[0].parent_id);
                }
            } else {
                jQuery('#'+userId).val("");
                jQuery('#'+userName).val("");
                jQuery('#'+orgName).val("");
            }
           }catch(e){
             /**忽略客户端异常信息**/ 
           }
        }
        s.init();
    }
    
</script>
<title>会议纪要</title>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',1)">
<form action="" id="form1" name="form1" method="post" >
 <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input name="cz_zc_button" id="cz_zc_button" value="保存" style="display: none"
                onclick="save();" type="button" class="but_y_01" /> 
            <input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
        </div>
    </div>
<div id="vcenter" style="float:left; width:100%;" >
    <div style="float: left; width: 800px;">
        <div class="content_02_box" style="width:880px;">
            <div class="content_02_box_title_bg" style="width:880px;">
                <span>会议模板基本信息</span>
            </div>
            <div class="content_02_box_div" style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" >
                            <span class="color_red">*</span>会议模板标题：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <input id="m_tmp_id" name="m_tmp_id" type="hidden"/>
                            <input type="text" style="width:95%" class="validate[required,maxSize[100]] input_cx_title_240" name="m_title" id="m_title"/>
                        </td>  
                        <th class="content_02_box_div_table_th" >
                            <span class="color_red">*</span>模板登记人：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <input type="text" class="validate[required,maxSize[25]] input_cx_title_120" name="m_tmp_creator_name" id="m_tmp_creator_name" disabled="disabled"/>
                            <input type="hidden" name="m_tmp_creator_id" id="m_tmp_creator_id" />
                        </td>                     
                    </tr>
                   
                    <tr>
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>模板所属单位：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <input type="text" class="validate[required,maxSize[100]] input_cx_title_120" name="m_tmp_unit_name" id="m_tmp_unit_name" disabled="disabled"/>
                            <input type="hidden" name="m_tmp_unit_id" id="m_tmp_unit_id" />
                        </td>
                        
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>所属部门：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <input type="hidden" class="input_cx_title_120" name="m_tmp_org_id" id="m_tmp_org_id" disabled="disabled"/>
                            <input type="text" class="validate[required] input_cx_title_120" name="m_tmp_org_name" id="m_tmp_org_name" disabled="disabled"/>
                        </td>
                    </tr>
                     <tr>                      
                        
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>模板登记时间：
                        </th>
                        <td class="content_02_box_div_table_td" colspan="3">
                            <input type="text" class="validate[required] input_cx_title_120" name="m_tmp_create_time" id="m_tmp_create_time" disabled="disabled"/>
                        </td>
                    </tr>               
                    <tr>
                      <th class="content_02_box_div_table_th">
                                                                                 模板说明：
                        </th>
                        <td class="content_02_box_div_table_td" colspan="3" >
                            <textarea id="m_tmp_contents" name="m_tmp_contents" class="validate[maxSize[1000]] textarea_575" style="width:98%" rows="5" ><%=StringUtil.deNull(bean.getM_tmp_contents())%></textarea>
                        </td>                        
                    </tr>                                        
                </table>
            </div>
        </div>
        
        <div class="content_02_box" style="width:880px;">
            <div class="content_02_box_title_bg" style="width:880px;">
                <span>会议基本信息</span>
               
            </div>
            <div class="content_02_box_div" style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:880px;">
                    
                    <tr>
                        <th width="200px" class="content_02_box_div_table_th">
                                                                               会议室：
                        </th>
                        <td class="content_02_box_div_table_td">
                           <select id="m_room_id" name="m_room_id" style="width:150px;">
                              <option value="" address="">---请选择---</option>
                              <%for(MeetingRoomBean room : roomList){ %>
                              <option value="<%=StringUtil.deNull(room.getM_room_id()) %>" 
                                 address="<%=StringUtil.deNull(room.getM_address()) %>"><%=StringUtil.deNull(room.getM_room_name()) %></option>
                              <%} %>
                           </select>
                        </td>
                        <th width="200px" class="content_02_box_div_table_th">
                                                                               会议地点：
                        </th>
                        <td class="content_02_box_div_table_td"  colspan="3">
                            <input type="text" style="width:94%" class="validate[maxSize[200]] input_cx_title_240" value="" name="m_address" id="m_address" />    
                        </td>
                       
                    </tr>
                    <tr>
                        <th class="content_02_box_div_table_th"  width="200px">会议开始时间：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input class="date_120 Wdate" style="width:150px;"
                                    type="text" id="m_begin_time" name="m_begin_time"
                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'m_end_time\')||\'2099-12-12\'}'})" />
                        </td>
                        <th class="content_02_box_div_table_th">会议结束时间：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input class="date_120 Wdate" style="width:150px;"
                                    type="text" id="m_end_time" name="m_end_time"
                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'m_begin_time\')||\'1980-01-01\'}'})" />
                        </td>
                        <th class="content_02_box_div_table_th">需要报名：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input type="radio" value="0" name="m_is_need_signup"/>
                                                                                            否 &nbsp;&nbsp;
                            <input type="radio" value="1" name="m_is_need_signup"/>
                                                                                            是
                        </td>
                    </tr>
                    <tr>                       
                        <th class="content_02_box_div_table_th">联系人：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input type="hidden" name="m_link_user_id" id="m_link_user_id"  />
                            <input type="text" id="m_link_user_name" name="m_link_user_name" class="validate[maxSize[25]] xz_89_border" 
                              style="width:150px;"  onclick="chooseActUsers('m_link_user_id','m_link_user_name','m_link_dept_id','m_link_dept_name','radio')" />
                        </td>
                         <th class="content_02_box_div_table_th">联系部门：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input type="text" style="width:146px;"  name="m_link_dept_name" id="m_link_dept_name"   class="validate[maxSize[100]] input_cx_title_120" />
                            <input type="hidden" name="m_link_dept_id" id="m_link_dept_id"   />
                        </td>
                        <th class="content_02_box_div_table_th">联系电话：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input type="text" style="width:150px;"  name="m_link_tel" id="m_link_tel" value="" class="validate[custom[onlyNumberSp],maxSize[25]] input_cx_title_120" />
                        </td>
                        
                    </tr>
                    <tr>
                        <th class="content_02_box_div_table_th">会议类型：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <select style="width:150px;" name ="m_type_id" id= "m_type_id" size ="1"  class ="select_100_box_type" >
                                <option value ="">---请选择---</option>
                                <%for(MeetingTypeBean type : typeList){ %>
                                <option value="<%=StringUtil.deNull(type.getM_type_id()) %>"><%=StringUtil.deNull(type.getM_type_name()) %></option>
                                <%} %>
                            </select>
                        </td>
                        <th class="content_02_box_div_table_th">主持人：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input type="hidden" name="m_master_user_id" id="m_master_user_id" value="" />
                            <input style="width:150px;" type="text" id="m_master_user_name" name="m_master_user_name" class="validate[maxSize[25]] xz_89_border" 
                                value="" onclick="chooseActUsers('m_master_user_id','m_master_user_name','','','radio')" />
                        </td>
                        <th class="content_02_box_div_table_th">与会人数：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input style="width:150px;" type="text"   name="m_attender_count" id="m_attender_count" maxlength="8" class="validate[custom[onlyNumberSp],maxSize[8]] input_cx_title_120" />
                        </td>
                    </tr>
                    <tr id="more" >
                        <th class="content_02_box_div_table_th">报名截止时间：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <input style="width:150px;" class="date_120 Wdate"
                                    type="text" id="m_close_time" name="m_close_time"
                                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'m_begin_time\')||\'2099-12-12\'}'})" />
                        </td>
                        <th class="content_02_box_div_table_th">发送名义：</th>
                        <td class="content_02_box_div_table_td" width="200px">
                            <select style="width:150px;" name ="m_send_name" id= "m_send_name" size ="1"  class ="select_100_box_type" >
                                <option value ="0" >单位名义发送</option>
                                <option value ="1" >个人名义发送</option>
                            </select>
                        </td>
                        <th class="content_02_box_div_table_th"></th>
                        <td class="content_02_box_div_table_td" width="200px"></td>
                    </tr>                    
                </table>
            </div>
        </div>
        <!-- 与会单位与人员 begin -->
        <div id="more" class="content_02_box" style="width:880px;">
            <div class="content_02_box_title_bg"  style="width:880px;">
                <span>与会单位与人员</span>
            </div>
            <div class="content_02_box_div"  style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" style="width:191px;">                            
                        </th>
                        <td class="content_02_box_div_table_td" colspan="5">
                            <input type="button" value="选择部门和人员" class="but_six" onclick="adddeptanduser()" />
                        </td>
                    </tr>
                </table>
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" style="width:191px;">与会单位列表：
                            <input type="hidden" id="m_receiver_unit_ids" name="m_receiver_unit_ids" value="" />
                            <input type="hidden" id="m_receiver_unit_names" name="m_receiver_unit_names" value="" />
                        </th>
                        <td class="content_02_box_div_table_td" id="deptTd" colspan="5" >
                        </td>
                    </tr>
                </table>
            </div>
            <div class="content_02_box_div"  style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" style="width:191px;">与会人员列表：
                        </th>
                        <td class="content_02_box_div_table_td" colspan="5">
                            <input type="hidden" id="m_receiver_user_ids" name="m_receiver_user_ids" value="" />
                            <input type="hidden" id="m_receiver_user_names" name="m_receiver_user_names" value="" />
                            <textarea id="userTd" name= "userTd" class="textarea_575" style="width:98%" rows="5" readonly></textarea>
                                
                        </td>
                    </tr>
                </table>
            </div>
           
        </div>
        <!-- 与会单位与人员 end -->
        <!-- 消息提醒begin -->
        <div id="more" class="content_02_box" style="width:880px;">
            <div class="content_02_box_title_bg">
                <span>消息提醒</span>
            </div>
            <input type="hidden" id="m_id" name="m_id" value="" />
            <input type="hidden" id="" name="" value="" />
            <div class="content_02_box_div"  style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" >提醒方式：</th>
                        <td class="content_02_box_div_table_td" colspan="5">
                            <input name="m_msg_type" id="m_msg_type" type="checkbox" value="<%=MeetingConstants.NOTE %>" />&nbsp;短信
                            &nbsp;
                            <input name="m_msg_type" id="m_msg_type" type="checkbox"  value="<%=MeetingConstants.MSG %>" />&nbsp;即时信息
                        </td>
                    </tr>
                </table>
            </div>
            <div class="content_02_box_div"  style="width:880px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width:880px;">
                    <tr>
                        <th class="content_02_box_div_table_th" >提醒内容：</th>
                        <td class="content_02_box_div_table_td" colspan="5">
                            <textarea id="m_msg_contents" name="m_msg_contents" class="validate[maxSize[150]] textarea_575" style="width:98%" rows="5" ><%=StringUtil.deNull(bean.getM_msg_contents())%></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- 消息提醒end -->
    </div>
</div>
</form>
</body>
</html>
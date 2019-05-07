<%--
describe:督察督办任务立项
author:dailianchun
date: 2013-10-28
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectManageService"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String windowId = request.getParameter("windowId");//窗口id
    String flag = StringUtil.deNull(request.getParameter("flag"));//状态  0：暂存，1：交办，（2，3）：办结 （完成，未完成）
    flag = StringUtil.nullOrBlank(flag)?"0":flag;
    //会议纪要service
    InspectManageService service = new InspectManageServiceImpl();
    InspectBaseInfoBean bean = new InspectBaseInfoBean();

    //获得当前日期(用于时间控件限制最大时间)
    String date = DateUtil.getCurrentDateTime().substring(0,
            DateUtil.getCurrentDateTime().length()-3);
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    //获得当前登录用户所属单位信息
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String orgId = usercachebean.getUnit_id();//获得单位id
    String orgName = usercachebean.getUnit_name();
    String time = DateUtil.getCurrentDateTime();//创建时间
    String m_attach_id = StringUtil.getUUID(); //附件id
    String action = "add";
    //如果传入了id，则查询任务基本信息
    if (!StringUtil.nullOrBlank(id)) {
    	action = "update";    	
        bean = service.queryToInspectBaseInfoBean(id);               
        //将秒截取掉
        String plan_endtime = StringUtil.deNull(bean.getPlan_endtime());
        if(!StringUtil.nullOrBlank(plan_endtime)){
            bean.setPlan_endtime(plan_endtime.substring(0,plan_endtime.length()-3));
        }
        //创建时间
        String  create_time = StringUtil.deNull(bean.getCreate_time());
        if(!StringUtil.nullOrBlank(create_time)){
            bean.setCreate_time(create_time.substring(0,create_time.length()-3));
        }
        //提醒时间
        String  remind_time = StringUtil.deNull(bean.getRemind_time());
        if(!StringUtil.nullOrBlank(remind_time)){
            bean.setRemind_time(remind_time.substring(0,remind_time.length()-3));
        }
        //交办时间
        String  send_time = StringUtil.deNull(bean.getSend_time());
        if(!StringUtil.nullOrBlank(send_time)){
            bean.setSend_time(send_time.substring(0,send_time.length()-3));
        }
    }else{
        //没有传入id，则赋初值
        bean.setInfo_id(StringUtil.getUUID());
        bean.setSend_user_id(userId);
        bean.setSend_user_name(userName);
        bean.setCreate_time(time);//创建时间
        bean.setAttach_id(m_attach_id);
        bean.setUser_orgid(orgId);
        bean.setUser_orgname(orgName);
        bean.setInspect_state("0");//默认状态为草稿
        bean.setSend_time(date);
        bean.setCreate_time(date);        
    }   
    
    //查询所有分类信息
    List<Map<String,String>> typeList = service.queryAllType();
    
  //判断是否有短信，及时，邮件，站内消息提示
    SysParamUitl noticeutil=new SysParamUitl();
    Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
    String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
    String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
    String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
    String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript"src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script  src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"  href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../resources/plug/form/jquery.form.js" type="text/javascript"></script>

<script type="text/javascript">
var id = "<%=id%>";
var orgId = "<%=orgId%>";//机构id
var flag = "<%=flag%>";//状态
var windowId = "<%=windowId%>";
//任务id
var info_id = "<%=StringUtil.deNull(bean.getInfo_id())%>";
//登记人员id
var userId = "<%=StringUtil.deNull(bean.getSend_user_id())%>";
//附件id
var m_attach_id = "<%=bean.getAttach_id() %>";
//附件是否可编辑的选项
var attachFlag = (flag == 0)?true:false;

//系统根路径
var path = "<%=path %>";


jQuery(function() {        
     jQuery("#inspect_name").focus();
     if(attachFlag){
       //附件
       MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','111');
     }else{
       MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','001');
     }
     if(!attachFlag){
         //设置上传按钮大小，间接实现隐藏
        jQuery("#_filebut").width(1).height(0);
     }
     
     //暂存的才可以进行操作，已发布的不能操作
     if('0' == flag){
         jQuery("#cz_fb_button").show();  
         jQuery("#cz_zc_button").show();
         jQuery("#chose_notice_button").show();
     }else{
         jQuery("#m_begin_time").prop("disabled", true);
         eWebEditor1.setReadOnly("1");
         jQuery("#evalTd").prop("disabled", true);
         jQuery("#adduserbutton").hide();
     }    

     //任务接收单位        
     createrDeptAndPosn({
              id : jQuery("#recept_orgids").val(),
              name: jQuery("#recept_orgnames").val()
         },"evalTd",'recept_orgids','recept_orgnames');     
     
     //添加点击事件
     addClick();

   //将表单升级为ajax的提交方式
     jQuery("#form1").submit(function(){
         jQuery(this).ajaxSubmit(
             {
                 type: "post", 
                 //url: "filefilesdo.jsp", 
                 url : path+"/ajaxServlet?className=com.chinacreator.xtbg."
                 +"core.inspect.action.InspectManageAction&method=saveBaseInfo",
                 dataType: "json",
                 contentType: "application/x-www-form-urlencoded; charset=utf-8",
                 beforeSubmit : function(data,form,options ){                                            
                    //if(data && data.length){                      
                       //for(var i=0;i<data.length;i++){
                           //data[i].value = descape(escape(data[i].value));   
                       //}                         
                    //}
                 },
                 success: function (data,status) {
                     if(data.flag){
                         //removeWindows(windowId,true);   
                         var state = jQuery("#inspect_state").val();
                         var tabs = ["#tabs-2","#tabs-3","#tabs-4","#tabs-5"];
                         //跳转到父界面对应的tab页
                         var parentWin = getParentWindow(windowId);
                         if(parentWin && parentWin.parent){                             
                             if(parentWin.parent.jQuery("#tabs").size()>0){                                 
                            	 parentWin.parent.jQuery("#tabs").tabs('select', tabs[state]);    
                             }                
                         }
                         alert(data.msg,{
                             headerText:'提示',
                             okName:'确认',
                             okFunction:function(){
                                   removeAlertWindows(windowId,true);
                                
                             }
                             });
                     }else{
                         if(data.msg){
                             alert(data.msg);
                          }
                     }
                     
                     //jQuery("#form1").resetSubmit(false);
                 }, 
                 clearForm : false,
                 resetForm:false,
                 timeout : 300000                                
              }
         );
         return false;
      });
});

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
        ajaxSubmit("add","确定要发布吗？",1);
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("update","确定要发布吗？",1);
    }   
}

/**
 * 暂存
 */
var saveToDraft = function() {
    //没有传入id,或为复制操作时，则为插入数据
    if("" == id){
        //发布，传入状态和操作参数
        ajaxSubmit("add","确定要暂存吗？",0);
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("update","确定要暂存吗？",0);
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
var ajaxSubmit = function(action,alertMsg,state){	
    //是否全部验证通过
    var isFlag = jQuery('#form1').validationEngine('validate'); 
    if(!isFlag ){
      return ;
    }
    //本地验证
    var nativeFlag = nativeValidate();
    if(!nativeFlag){
       return;
    }    
    var p={
          headerText:'提示',
          okName:'确认',
          okFunction:function(){
             jQuery("#inspect_state").val(state);
             jQuery("#form1").submit();           
          },
          cancelName:'取消'
    };
    alert(alertMsg,p);        
}

/**
 * 本地验证
 */
function nativeValidate(){
    var str = eWebEditor1.getHTML();
    jQuery('#content').val(str); 
    if(IsSpace(str)){
           alert("正文不能为空");
           return false;       
    }   
    var orgs = jQuery("#recept_orgids").val();
    if(IsSpace(orgs)){
      alert("办理单位不能为空");
      return false;
    }
    return true;
}

/**
 * 关闭弹出框
 */
function closed(){
	if(flag == 0 || flag==1){
        //新增或修改数据，提示是否保存
            var okF = function(){
                removeAlertWindows(windowId,true);
            }
            var p={
                headerText:'提示', 
                okName:'确认',
                okFunction:okF,
                cancelName:'取消'
            };
            alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
        }else{
            removeAlertWindows(windowId,true);
        }
}

/*
函数:  cg
说明:  添加人员
参数:  nameArea : 展示的人员信息的textArea
      ids ：存放人员id列表
      names ： 存放人员名字信息
返回值: 无
*/
function adddeptanduser(nameArea,ids,names){
           var s = new jQuery.z_tree_leftRigth();
            s.treeID='inspect_addBaseInfo';
            s.isShowSeacher="aa";
            s.treeName="选取单位";
            s.headerName="选取单位";
            s.titelText = "选择单位";
            s.rightHeaderText="已添加单位";
            s.isNewCommonUse=true;
            s.treeList=[{
                leftHeaderText:'按单位选择',
                item_id :'org_id',
                isType:'unit', 
                valueKey:'unit',
                selectedIds:jQuery("#recept_orgids").val(),
                type:'AORG'
                //type:'{"type":"7"}'
            }];
             s.returnFunction=function(object){
                 jQuery("#"+nameArea).val("");
                 jQuery("#"+ids).val("");
                 jQuery("#"+names).val("");
                 debugger;
                 createrDeptAndPosn(object.unit,nameArea,ids,names);
             }
            s.init();
      }


   /**
    *添加点击事件
    */
   function addClick(){
        //置顶期限
        jQuery("#plan_endtime").click(function(){
            WdatePicker({
                minDate:'#F{$dp.$D(\'send_time\')||\'%y-%M-%d %H:%m\'}',
                dateFmt:'yyyy-MM-dd HH:mm'});
         });
        //催办提醒时间
        jQuery("#remind_time").click(function(){
            WdatePicker({
                minDate:'%y-%M-%d',
                maxDate:'#F{$dp.$D(\'plan_endtime\')||\'2099-01-01 23:59\'}',
                dateFmt:'yyyy-MM-dd HH:mm'});
         });
        //任务发送时间
        jQuery("#send_time").click(function(){
            WdatePicker({
                minDate:'%y-%M-%d 00:00',
                maxDate:'#F{$dp.$D(\'plan_endtime\')||\'2099-01-01 23:59\';}',
                dateFmt:'yyyy-MM-dd HH:mm'});
         });
         
        //催办提醒多选框选中
        jQuery("input[type=checkbox][name=m_msg_type]").each(function(){
            var This = this;
            jQuery(this).click(function(){
               if(jQuery(This).attr("checked")=="checked"){
                      jQuery("#"+jQuery(This).val()).val("1");
                   }else{
                      jQuery("#"+jQuery(This).val()).val("0");
                   }
           });
        });
   }
   /**
    *影藏or显示div
    */
   function slideUpOrDown(slideId,assistId,obj){
     //如果影藏执行显示动画
     if(jQuery("#"+slideId+":hidden").length >0){
         jQuery("#"+slideId).slideDown(400,function(){
             jQuery(obj).attr("src","../resources/images/slideup_button.gif");
         });
     }else{ 
         jQuery("#"+slideId).slideUp(400,function(){
             jQuery(obj).attr("src","../resources/images/slidedown_button.gif");
         });
        //增强动画体验
         jQuery("#"+assistId).slideUp(400);
         jQuery("#"+assistId).slideDown(500);
     }
   }
  
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',30)">
<form id="form1" action="" method="post">  
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%;">
        <div style="float: left; width: 775px;">
            <div class="content_02_box" >
            <div class="content_02_box_title_bg"><span>基本信息</span>
               <div class="content_02_box_add" id="t2">
               </div>
            </div>
                <div class="content_02_box_div" id="baseInfo_div">
                    <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table">
                        <tr>
                            <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>名称：
                            </th>
                            <td colspan="3" class="content_02_box_div_table_td">
                                <input type="hidden" id="info_id" 
                                name="bean.info_id" value="<%=StringUtil.deNull(bean.getInfo_id())%>"/>
                                <input type="hidden" id="action" 
                                name="action" value="<%=StringUtil.deNull(action)%>"/>
                                <input type="text" style="width:556px"
                                    value="<%=StringUtil.deNull(bean.getInspect_name())%>" 
                                    id="inspect_name" name="bean.inspect_name" class="validate[required,maxSize[200]] input_160" />
                                <input type="hidden" id="inspect_state" name="bean.inspect_state" 
                                    value="<%=StringUtil.deNull(bean.getInspect_state()) %>"/>
                           </td>                           
                        </tr>
                        <tr>
                         <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>任务类型：
                            </th>
                            <td class="content_02_box_div_table_td">
                                <select  style="width:160px;border:#c6c6c6 1px solid;" id='inspect_type' name="bean.inspect_type"
                                    class="validate[required]">
                                   <%if(null == typeList || typeList.size() == 0){%>
                                    <option value="">尚未添加类型</option>
                                   <% }else{ 
                                      for(Map<String,String> type : typeList){
                                   %>
                                      <option  value="<%=type.get("type_id") %>" ><%=type.get("type_name") %></option>
                                   <%} }%>
                                </select>
                            </td>
                         <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>指定期限：
                            </th>
                            <td class="content_02_box_div_table_td">
                                <input type="text" 
                                    class="validate[required] date_187 input_160" id="plan_endtime" name="bean.plan_endtime"
                                    value="<%=StringUtil.deNull(bean.getPlan_endtime())%>"/>
                            </td>
                        </tr>
                        <tr>
                            <th valign="top" class="content_02_box_div_table_02_th">
                                <span class="color_red">*</span>登记人：
                            </th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" readonly="readonly"
                                        value="<%=StringUtil.deNull(bean.getSend_user_name())%>" id="send_user_name"
                                        name="bean.send_user_name" class="validate[required] input_160" />
                               <input type="hidden" 
                                        value="<%=StringUtil.deNull(bean.getSend_user_id())%>" id="send_user_id"
                                        name="bean.send_user_id"/>                                        
                            </td>   
                            <th valign="top" class="content_02_box_div_table_02_th">
                                <span class="color_red">*</span>登记人单位：
                            </th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" readonly="readonly"
                                        value="<%=StringUtil.deNull(bean.getUser_orgname())%>" id="user_orgname"
                                        name="bean.user_orgname" class="validate[required] input_160" />
                               <input type="hidden" 
                                        value="<%=StringUtil.deNull(bean.getUser_orgid())%>" id="user_orgid"
                                        name="bean.user_orgid"/>                                        
                            </td>                            
                        </tr>
                         <tr>
                            <th valign="top" class="content_02_box_div_table_02_th">
                                <span class="color_red">*</span>交办时间：
                            </th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" readonly="readonly"
                                        value="<%=StringUtil.deNull(bean.getSend_time())%>" id="send_time"
                                        name="bean.send_time" class="validate[required] input_160 date_187" />
                               <input type="hidden" 
                                        value="<%=StringUtil.deNull(bean.getCreate_time())%>" id="create_time"
                                        name="bean.create_time"/>  
                                                                     
                            </td>   
                            <th valign="top" class="content_02_box_div_table_02_th">
                                 &nbsp;
                            </th>
                            <td class="content_02_box_div_table_02_td">
                               <span id="inspect_state_name"></span>                   
                               <input type="hidden" 
                                        value="<%=StringUtil.deNull(bean.getInspect_state())%>" id="inspect_state"
                                        name="bean.inspect_state"/>                      
                            </td>                            
                        </tr>
                    </table>
                </div>
            </div>
            <div id="baseInfo_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>
            
            <div class="content_02_box" style="margin-top:0px;" >
            <div class="content_02_box_title_bg">
                <span>催办提醒</span>
                <div class="content_02_box_add" id="t2">
                 <img src="../resources/images/slidedown_button.gif" border="0" 
                     onclick="slideUpOrDown('remind_div','remind_div_assist',this)"
                     style="margin-top:3px;float: right;width: 15px;height:20px;display: inline;margin-right: 5px;cursor: pointer;"/>
                 </div>
            </div>
            <div class="content_02_box_div" id="remind_div" style="<%if(StringUtil.nullOrBlank(bean.getRemind_time())){ %>display:none;<%} %>">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
                      <tr>
                      <th class="content_02_box_div_table_th"  style="width:200px;">催办提醒时间：</th>
                        <td class="content_02_box_div_table_td" >
                          <input type="text" readonly="readonly"
                                        value="<%=StringUtil.deNull(bean.getRemind_time())%>" id="remind_time"
                                        name="bean.remind_time" class="date_187 input_160" />
                        </td>   
                      </tr>
                      <tr>
                        <th class="content_02_box_div_table_th"  style="width:200px;">催办提醒方式：</th>
                        <td class="content_02_box_div_table_td">
                            <%if("1".equals(is_pub_sms)){ %>
                            <input style="margin-left: 5px;" name="bean.m_msg_type"  type="checkbox" value="is_sms"
                             <%if("1".equals(StringUtil.deNull(bean.getIs_sms()))){%>
                                checked="checked"
                             <%} %>
                            />&nbsp;短信 
                            &nbsp;<%} %> 
                            <%if("1".equals(is_pub_mail)){ %>
                            <input name="m_msg_type"  type="checkbox" value="is_mail" 
                            <%if("1".equals(StringUtil.deNull(bean.getIs_mail()))){%>
                                checked="checked"
                             <%} %>
                            />&nbsp;邮件&nbsp;
                            <%} if("1".equals(is_pub_rtx)){%>
                            <input name="m_msg_type"  type="checkbox" value="is_rtx"
                            <%if("1".equals(StringUtil.deNull(bean.getIs_rtx()))){%>
                                checked="checked"
                             <%} %>
                             />&nbsp;即时信息&nbsp;
                            <%} if("1".equals(is_pub_msg)){%>
                            <input name="m_msg_type"  type="checkbox" value="is_msg"
                            <%if("1".equals(StringUtil.deNull(bean.getIs_msg()))){%>
                                checked="checked"
                             <%} %>
                             />&nbsp;站内信息&nbsp;
                            <%} %>
                            <input type="hidden" id="is_sms"   name="bean.is_sms" value="<%=StringUtil.deNull(bean.getIs_sms()) %>" />
                            <input type="hidden" id="is_mail"  name="bean.is_mail" value="<%=StringUtil.deNull(bean.getIs_mail()) %>"/>
                            <input type="hidden" id="is_rtx"   name="bean.is_rtx" value="<%=StringUtil.deNull(bean.getIs_rtx()) %>" />
                            <input type="hidden" id="is_msg"   name="bean.is_msg" value="<%=StringUtil.deNull(bean.getIs_msg()) %>" />
                        </td> 
                                                   
                    </tr>
                    <tr>
                        <th class="content_02_box_div_table_th" >提醒内容：</th>
                        <td class="content_02_box_div_table_td">
                            <textarea id="remind_content" name="bean.remind_content" 
                            class="validate[maxSize[250]] textarea_575" 
                            cols="110" rows="2" ><%=StringUtil.deNull(bean.getRemind_content())%></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            </div>
            <div id="remind_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>
            <div class="content_02_box" style="margin-top:0px;">        
            <div class="content_02_box_title_bg"><span>正文</span> 
	            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	            <span class="color_red">提示：可以直接粘贴word、excel表格</span>
	            <div class="content_02_box_add" id="t2">
	            </div>
            </div>
        
            <div class="content_02_box_div" id="content_div">
                <table border="0" cellspacing="0" cellpadding="0"
                    class="content_02_box_div_table">
                    <tr>
                        <td colspan="4">
                        <textarea style="display: none" name="bean.content" id="content"><%=StringUtil.deNull(bean.getContent()) %></textarea> 
                        <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=content&style=gray" frameborder="0" 
                        scrolling="no" width="100%" height="400"></iframe>
                        </td>
                    </tr>                    
                </table>
            </div>            
        </div>                      
        <div id="content_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>  
                    
        <div class="content_02_box" style="margin-top:0px;">
        <div class="content_02_box_title_bg">
            <span>办理单位</span>
             <div class="content_02_box_add" id="t2">
              </div>
            <div class="content_02_box_add show_content" style="cursor: hand">
                <input id="adduserbutton" type="button" value="添加办理单位" class="but_y_03"
                       style="margin-top:3px;"
                        onclick="adddeptanduser('evalTd','recept_orgids','recept_orgnames')" />
            </div>            
        </div>
        
        <div class="content_02_box_div"  id="org_div">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="content_02_box_div_table_02">
            <tr>
                <th class="content_02_box_div_table_02_th">
                   <span class="color_red">*</span>办理单位列表：
                   <input  type="hidden" id="recept_orgids" name="bean.recept_orgids"
                        value="<%=StringUtil.deNull(bean.getRecept_orgids())%>" /> 
                    <input type="hidden" id="recept_orgnames" name="bean.recept_orgnames"
                        value="<%=StringUtil.deNull(bean.getRecept_orgnames())%>" />
                </th>
                <td valign="top" class="content_02_box_div_table_02_td" id="evalTd" height="100">
                </td>
            </tr> 
        </table>
        </div>
        </div>     
        <div id="org_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>  
                    
        <div class="content_02_box" style="margin-top:0px;">
                <div class="content_02_box_title_bg" >
                    <span>附件信息</span>
                     <div class="content_02_box_add" id="t2">
                     </div>
                    <div class="content_02_box_add show_content" style="cursor: hand">
                        <input class="but_y_03" style="margin-top: 3px;"  type="button" id="_filebut" value="请选择文件"/>
                        <input type="hidden" id="attach_id" name="bean.attach_id" value="<%=StringUtil.deNull(bean.getAttach_id()) %>"/>
                    </div>
                </div>
                <div class="content_02_box_div" id="file_div">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0"
                        id="content_02_box_div_table_02">
                        <tr>
                            <th valign="top">附件列表：</th>
                            <td>
                            <ul id="_fileshow"></ul>
                            &nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="height:10px;border:0px;width:100%;">&nbsp;</div>
        </div>  
     </div>
</form>
      <div id="_top" class="toolbar_bottom">
          <input  value="关闭" onclick="closed()" type="button" class="but_y_01" 
            style="float: right;margin-top:5px;margin-right:10px;"/>            
           <input name="cz_zc_button" id="cz_zc_button" value="发布" 
           style="display: none;float: right;margin-top:5px;margin-right:5px;"
               onclick="save();" type="button" class="but_y_01" /> 
           <input name="cz_fb_button" id="cz_fb_button" value="暂存" onclick="saveToDraft();"
               style="display: none;float: right;margin-top:5px;margin-right:5px;"
                type="button" class="but_y_01" /> 
       </div>    
</body>
</html>
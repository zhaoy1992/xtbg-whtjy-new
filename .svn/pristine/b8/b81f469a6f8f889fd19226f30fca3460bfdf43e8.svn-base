<%--
describe:添加会议纪要
author:dailianchun
date: 2013-6-26
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
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String windowId = request.getParameter("windowId");//窗口id
    String flag = StringUtil.deNull(request.getParameter("flag"));//会议纪要的状态  0：暂存，1：发布

    //会议纪要service
    MeetingMinutesService service = new MeetingMinutesServiceImpl();
    MeetingMinutesBean bean = new MeetingMinutesBean();

    //获得当前日期(用于时间控件限制最大时间)
    String date = DateUtil.getCurrentDate()+" 23:59";
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    //获得当前登录用户所属单位信息
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String orgId = usercachebean.getUnit_id();//获得单位id
    String orgName = usercachebean.getUnit_name();
    String time = DateUtil.getCurrentDateTime();//创建时间
    String m_attach_id = StringUtil.getUUID(); //附件id
    //如果传入了id，则查询出会议纪要对象
    if (!StringUtil.nullOrBlank(id)) {
        bean = service.queryToMeetingMinutesBean(id);       
        
        //将会议开始时间的秒截取掉
        String  beginTime = StringUtil.deNull(bean.getM_begin_time());
        if(!StringUtil.nullOrBlank(beginTime)){
        	bean.setM_begin_time(beginTime.substring(0,beginTime.length()-3));

        }
    }else{
        //没有传入id，则赋初值
        bean.setM_reg_user_id(userId);
        bean.setM_reg_user_name(userName);
        bean.setM_reg_time(time);
        bean.setM_attach_id(m_attach_id);
    }
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

<script type="text/javascript">
var id = "<%=id%>";
var orgId = "<%=orgId%>";//机构id
var flag = "<%=flag%>";//会议纪要状态
var windowId = "<%=windowId%>";
//会议纪要id
var m_minutes_id = "<%=StringUtil.deNull(bean.getM_minutes_id())%>";
//登记人员id
var userId = "<%=StringUtil.deNull(bean.getM_reg_user_id())%>";
//附件id
var m_attach_id = "<%=bean.getM_attach_id() %>";
//附件是否可编辑的选项
var attachFlag = (flag == 0)?true:false;

//系统根路径
var path = "<%=path %>";


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
    //设置状态
    jQuery("#m_current_flag").val(state);
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
    
    var okF = function(){
                jQuery("#cz_fb_button").attr("disabled","disabled");
                jQuery("#cz_zc_button").attr("disabled","disabled");
                var param = setParamJson();
                param["action"] = action;
                //ajax方式提交数据
                jQuery.ajax({
                    type: "post", 
                    url: "meetingmunutesdo.jsp", 
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
                            //跳转到父界面对应的tab页
                            if(window.parent){
                                var tab = state == 0 ? "#tabs-1":"#tabs-2"
                            	window.parent.jQuery("#tabs").tabs('select', tab);
                            }
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
 * 本地验证
 */
function nativeValidate(){
    var str = eWebEditor1.getHTML();
    jQuery('#m_contents').val(str); 
    if(IsSpace(str)){
           alert("正文不能为空");
           return false;       
    }
    var userIds = jQuery("#m_read_person_ids").val();
    if(IsSpace(userIds)){
        alert("阅读人员不能为空!");
        return false;
    }
    return true;
}

/**
 * 将参数转换成对象
 */ 
function setParamJson(){
    var param ={
            m_minutes_id:m_minutes_id,
            m_title:jQuery('#m_title').val(),
            m_contents:jQuery('#m_contents').val(),
            m_unit_name:jQuery('#m_unit_name').val(),
            m_current_flag:jQuery('#m_current_flag').val(),
            m_reg_user_id:userId,
            m_reg_user_name:jQuery('#m_reg_user_name').val(),
            m_reg_time:jQuery('#m_reg_time').val(),
            m_attach_id:m_attach_id,  
            m_notice_id:jQuery('#m_notice_id').val(), 
            m_begin_time:jQuery('#m_begin_time').val(), 
            m_read_person_ids:jQuery('#m_read_person_ids').val(), 
            m_read_person_names:jQuery('#m_read_person_names').val()
   };
   return param;
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
函数:  cg
说明:  添加人员
参数:  nameArea : 展示的人员信息的textArea
      ids ：存放人员id列表
      names ： 存放人员名字信息
返回值: 无
*/
function adddeptanduser(nameArea,ids,names){
           var s = new jQuery.z_tree_leftRigth();
            s.treeID='addmeetingroom_administor';
            s.isShowSeacher="aa";
            s.treeName="选取人员";
            s.headerName="选取人员";
            s.titelText = "选择人员";
            s.rightHeaderText="已添加人员";
            s.isNewCommonUse=true;
            s.treeList=[{
                      
                        leftHeaderText:'按人员选择',
                        valueKey:'ps',
                        selectedIds:jQuery("#"+ids).val(),
                        //由于测试速度太慢，暂时用这个
                        //type:'{"type":"23"}'
                        type:'APERSON'
                          
              }];
             s.returnFunction=function(object){
                 jQuery("#"+nameArea).val("");
                 jQuery("#"+ids).val("");
                 jQuery("#"+names).val("");
                 createrDeptAndPosn(object.ps,nameArea,ids,names,false,false,false,true);
             }
            s.init();
      }


//搜索框的控制对象
var control = new defaultValueControl('请输入会议标题','#m_title_search');
jQuery(function() {
    //初始化 
    control.init();
    
    jQuery("#_win_div_rootwindowId").keydown(function(){
        if(event.keyCode == 13){
            search();
        }
        });

    //添加点击事件
    jQuery("#m_begin_time").click(function(){
    	WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm'});

     });
    if(attachFlag){
      //附件
      MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','100');
    }else{
      MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','001');
    }
    if(!attachFlag){
        //设置上传按钮大小，间接实现隐藏
       jQuery("#_filebut").width(1).height(1);
    } 

    
    
    //暂存的才可以进行操作，已发布的不能操作
    if('0' == flag){
        jQuery("#cz_fb_button").show();  
        jQuery("#cz_zc_button").show();
        jQuery("#chose_notice_button").show();
    }else{
    	jQuery("#m_title").prop("disabled", true);
    	jQuery("#m_begin_time").prop("disabled", true);
    	eWebEditor1.setReadOnly("1");
    	jQuery("#evalTd").prop("disabled", true);
    	jQuery("#adduserbutton").hide();
    }             
    
    //设置阅读人员的值
    createrDeptAndPosn({
        id:jQuery("#m_read_person_ids").val(),
        name:jQuery("#m_read_person_names").val()
    } ,"evalTd",'m_read_person_ids','m_read_person_names'
    ,false,false,false,true);
});   
   function openmeetingends(){
	   openAlertWindows('showMeetingends'
               ,getCurrentFilePath()+'meetingendschoose.jsp?windowId=showMeetingends','已结束会议列表',540,450,'10%','10%');
   }
   
  
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="" method="post">
    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input name="cz_fb_button" id="cz_fb_button" value="暂存" onclick="saveToDraft();"
                style="display: none" type="button" class="but_y_01" /> 
            <input name="cz_zc_button" id="cz_zc_button" value="发布" style="display: none"
                onclick="save();" type="button" class="but_y_01" /> 
            <input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
        </div>
    </div>
    
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%; overflow: scroll"
        scrolling="yes">
        <div style="float: left; width: 775px;">
            <div class="content_02_box">
            <div class="content_02_box_title_bg"><span>基本信息</span></div>
                <div class="content_02_box_div">
                    <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table">
                        <tr>
                            <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>会议标题：
                            </th>
                            <td colspan="3" class="content_02_box_div_table_td">
                                <input type="hidden" id="m_current_flag" 
                                name="m_current_flag" value=""/>
                                <input type="hidden" id="m_notice_id" 
                                name="m_notice_id" value="<%=StringUtil.deNull(bean.getM_notice_id())%>"/>
                                <input type="text" style="width:540px"
                                    value="<%=StringUtil.deNull(bean.getM_title())%>" id="m_title"
                                    id="m_title" name="m_title" class="validate[required,maxSize[100]] input_160" />
                               <input name="chose_notice_button" id="chose_notice_button"
                                   type="button"  class="but_x" style="display:none" onclick="openmeetingends();"/>
                           </td>                           
                        </tr>
                        <tr>
                         <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>登记人：
                            </th>
                            <td class="content_02_box_div_table_td">
                                <input disabled="disabled" class="validate[required] input_160" id="m_reg_user_name" name="m_reg_user_name"
                                    value="<%=StringUtil.deNull(bean.getM_reg_user_name())%>" readonly="readonly" />
                                <input type="hidden" id="m_reg_user_id" name="m_reg_user_id"
                                    value="<%=StringUtil.deNull(bean.getM_reg_user_id())%>" />
                            </td>
                         <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>会议开始时间：
                            </th>
                            <td class="content_02_box_div_table_td">
                                <input type="text" 
                                    class="validate[required] date_187" id="m_begin_time" name="m_begin_time"
                                    value="<%=StringUtil.deNull(bean.getM_begin_time()) %>" />
                            </td>
                           
                           
                        </tr>
                        <tr>
                            <th valign="top" class="content_02_box_div_table_02_th">
                                <span class="color_red">*</span>登记时间：
                            </th>
                            <td colspan="3" class="content_02_box_div_table_02_td">
                                <input type="text" maxlength="5"  disabled="disabled"
                                        value="<%=StringUtil.deNull(bean.getM_reg_time())%>" id="m_reg_time"
                                        name="m_reg_time" class="validate[required] input_160" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="content_02_box">        
            <div class="content_02_box_title_bg"><span>正文</span> 
            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <span class="color_red">提示：可以直接粘贴word、excel表格</span>
            <div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
            </div>
        
            <div class="content_02_box_div">
                <table border="0" cellspacing="0" cellpadding="0"
                    class="content_02_box_div_table">
                    <tr>
                        <td colspan="4">
                        <textarea style="display: none" name="m_contents" id="m_contents"><%=StringUtil.deNull(bean.getM_contents()) %></textarea> 
                        <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=m_contents&style=gray" frameborder="0" 
                        scrolling="no" width="100%" height="400"></iframe>
                        </td>
                    </tr>                    
                </table>
            </div>            
        </div>
                      
            <div class="content_02_box">
            <div class="content_02_box_title_bg">
            	<span>会议纪要阅读人员</span>
            	<div class="content_02_box_add show_content" style="cursor: hand">
					<input id="adduserbutton" name="" type="button" value="添加阅读人员" class="but_y_03"
                            onclick="adddeptanduser('evalTd','m_read_person_ids','m_read_person_names')" />
				</div>
            </div>
            <div class="content_02_box_div">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                class="content_02_box_div_table_02">
                <tr>
                    <th class="content_02_box_div_table_02_th">
                       <span class="color_red">*</span>阅读人员列表列表：
                    </th>
                    <td class="content_02_box_div_table_02_td">
                        <textarea id="evalTd" class="textarea_575" style="width:99%" rows="5" readonly></textarea> 
                        <input  type="hidden" id="m_read_person_ids" name="m_read_person_ids"
                            value="<%=StringUtil.deNull(bean.getM_read_person_ids())%>" /> 
                        <input type="hidden" id="m_read_person_names" name="m_read_person_names"
                            value="<%=StringUtil.deNull(bean.getM_read_person_names())%>" />
                    </td>
                </tr> 
            </table>
            </div>
            </div>            
            <div class="content_02_box">
                <div class="content_02_box_title_bg">
               		<span>附件信息</span>
               		<div class="content_02_box_add show_content" style="cursor: hand">
						<input class="but_y_03"  type="button" id="_filebut" value="请选择文件"/>
					</div>
                </div>
                <div class="content_02_box_div">
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
        </div>  
     </div>
</form>
</body>
</html>
<%--
describe:添加会议室
author:dailianchun
date: 2013-6-25
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String windowId = request.getParameter("windowId");//窗口id

    //service
    MeetingRoomService service = new MeetingRoomServiceImpl();
    MeetingRoomBean bean = new MeetingRoomBean();

    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String orgId = usercachebean.getOrg_id();//所属部门id
    String orgName = usercachebean.getOrg_name();//部门名 
	String m_dept_id = usercachebean.getUnit_id();
	String m_dept_name = usercachebean.getUnit_name();
	
    
    String time = DateUtil.getCurrentDateTime();//创建时间
    //如果传入了id，则查询出对象
    if (!StringUtil.nullOrBlank(id)) {
        bean = service.queryToMeetingRoomBean(id);       
    }else{
    	//没有传入id，则赋初值
    	bean.setM_reg_user_id(userId);
    	bean.setM_reg_user_name(userName);
    	bean.setM_unit_id(m_dept_id);
    	bean.setM_unit_name(m_dept_name);   
    	bean.setM_reg_time(time);
    	bean.setM_dept_id(orgId);
    	bean.setM_dept_name(orgName);
    	
    }
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>

<!-- 公共部分引用结束 -->
<script type="text/javascript">
var id = "<%=id%>";
var windowId = "<%=windowId%>";
//是否有效
var isUseFlag = "<%=bean.getM_is_use_flag()%>";
//是否需要审核
var isNeedCheck = "<%=bean.getM_is_need_check()%>";
jQuery(function(){
    //是否有效
    jQuery("#m_is_use_flag option[value='"+isUseFlag+"']").removeAttr("selected");
    jQuery("#m_is_use_flag option[value='"+isUseFlag+"']").attr("selected","selected");

    //是否需要审核
    jQuery("#m_is_need_check option[value='"+isNeedCheck+"']").removeAttr("selected");
    jQuery("#m_is_need_check option[value='"+isNeedCheck+"']").attr("selected","selected");
          
    //新增操作
    jQuery("#cz_fb_button").show();  
                
    
    //设置会议室管理人员的值
    createrDeptAndPosn({
        id:jQuery("#administrator_ids").val(),
        name:jQuery("#administrator_names").val()
    } ,"evalTd",'administrator_ids','administrator_names'
    ,false,false,false,true);
            
});

/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function(name) {
    //没有传入id,或为复制操作时，则为插入数据
    if("" == id){
        //发布，传入状态和操作参数
        ajaxSubmit("add","确定要"+name+"吗？");
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("update","确定要"+name+"吗？");
    }
   
}

/**
 函数:  ajaxSubmit
 说明:  ajax访问后台
 参数:  state 状态 0：暂存，1：发布
 返回值: 无
 */
var ajaxSubmit = function(action,alertMsg){    
    //是否全部验证通过
    var isFlag = jQuery('#form1').validationEngine('validate'); 
    if(!isFlag ){
      return ;
    }
    //new add hai.huang 加入如果选择需要审核，则做会议管理管理员的必填验证   2013-08-01 ---begin
    if (isSpace(jQuery('#administrator_ids').val()) && jQuery('#m_is_need_check').val() =="1" ){
    	alert('请选择‘会议室管理员’！');
    	return;
    }
    //-------------------------------------------------------- 2013-08-01----end
    var okF = function(){
                jQuery("#cz_fb_button").attr("disabled","disabled");
                //ajax方式提交数据
                jQuery.ajax({
                    type: "post", 
                    url: "meetingroomdo.jsp", 
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data : {
                        action : action,
                        m_is_use_flag : jQuery('#m_is_use_flag').val(),//当更新时设置了m_is_use_flag为否，无效时且会议室被使用时，提示不成功
                        paramJson : setParamJson()      
                    },
                    dataType: "json", 
                    success: function (data) {
                        jQuery("#cz_fb_button").removeAttr("disabled");
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
 * 将参数转换成json数据
 */ 
function setParamJson(){
    var paramjson = "{'m_room_id':'"+jQuery("#m_room_id").val()+"',"+
                    " 'm_room_name':'"+jQuery("#m_room_name").val()+"',"+
                    " 'm_unit_id':'"+jQuery("#m_unit_id").val()+"',"+
                    " 'm_unit_name':'"+jQuery("#m_unit_name").val()+"',"+
                    " 'm_address':'"+jQuery("#m_address").val()+"',"+
                    " 'm_people_num':'"+jQuery("#m_people_num").val()+"',"+
                    " 'm_is_need_check':'"+jQuery('#m_is_need_check').val()+"',"+
                    " 'm_reg_user_id':'"+jQuery('#m_reg_user_id').val()+"',"+  
                    " 'm_reg_user_name':'"+jQuery('#m_reg_user_name').val()+"',"+ 
                    " 'm_remark':'"+jQuery('#m_remark').val()+"',"+ 
                    " 'm_is_use_flag':'"+jQuery('#m_is_use_flag').val()+"',"+ 
                    " 'administrator_ids':'"+jQuery('#administrator_ids').val()+"',"+ 
                    " 'administrator_names':'"+jQuery('#administrator_names').val()+"',"+ 
                    " 'm_dept_name':'"+jQuery('#m_dept_name').val()+"',"+ 
                    " 'm_dept_id':'"+jQuery('#m_dept_id').val()+"',"+ 
                    " 'm_reg_time':'"+jQuery("#m_reg_time").val()+"'"+
                    "}";
    return paramjson
}
/**
 * 关闭弹出框
 */
function closed(){
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
            s.isNewCommonUse=false;
            s.treeList=[{
                      
                        leftHeaderText:'按人员选择',
                        valueKey:'ps',
                        selectedIds:jQuery("#"+ids).val(),
                        //由于测试速度太慢，暂时用这个
                        //type:'{"type":"23"}'
                        type:'{"type":"SEFTUNIT"}'
                          
              }];
             s.returnFunction=function(object){
                 jQuery("#"+nameArea).val("");
                 jQuery("#"+ids).val("");
                 jQuery("#"+names).val("");
                 createrDeptAndPosn(object.ps,nameArea,ids,names,false,false,false,true);
             }
            s.init();
      }

</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',1)">
<form id="form1" action="" method="post">
	<div class="content_02" style="overflow: hidden;" id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;">
			<input name="cz_fb_button" id="cz_fb_button" value="保存" onclick="Ok(this.value);"
			    style="display: none" type="button" class="but_y_01" /> 
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
					            <span class="color_red">*</span>会议室名称：
					        </th>
					        <td class="content_02_box_div_table_td">
						        <input type="text" 
						            value="<%=StringUtil.deNull(bean.getM_room_name())%>" id="m_room_name"
						            name="m_room_name" class="validate[required,maxSize[25]] input_160" />
					       </td>
					        <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>所属单位：
                            </th>
                            <td class="content_02_box_div_table_td">
                                <input type="hidden" id="m_room_id" name="m_room_id" value="<%=bean.getM_room_id() %>"/>
                                <input type="text"
                                    id="m_unit_name" name="m_unit_name" 
                                    class="validate[required,maxSize[100]] input_160"
                                    value="<%=bean.getM_unit_name()%>"  disabled="disabled"/> 
                                <input type="hidden" id="m_unit_id" name="m_unit_id" value="<%=bean.getM_unit_id()%>" />
                            </td>
					    </tr>
					    <tr>
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>登记人：
					        </th>
					        <td class="content_02_box_div_table_td">
						        <input class="validate[required] input_160" id="m_reg_user_name" name="m_reg_user_name"
						            value="<%=StringUtil.deNull(bean.getM_reg_user_name())%>" disabled="disabled" />
						        <input type="hidden" id="m_reg_user_id" name="m_reg_user_id"
						            value="<%=StringUtil.deNull(bean.getM_reg_user_id())%>" />
					        </td>
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>是否有效：
					        </th>
					        <td class="content_02_box_div_table_td">
						        <select id="m_is_use_flag"
		                                    name="m_is_use_flag" size="1" class="select_100_box" style="width: 160px;">
		                            <option value="1">是</option>
		                            <option value="0">否</option>
		                        </select>
					        </td>
					    </tr>
					    <tr>
					        <th valign="top" class="content_02_box_div_table_02_th">
					            <span class="color_red">*</span>登记时间：
					        </th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" maxlength="5" disabled="disabled"
                                        value="<%=StringUtil.deNull(bean.getM_reg_time())%>" id="m_reg_time"
                                        name="m_reg_time" class="validate[required] input_160" />
                            </td>
					       
					       
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>是否需要审核：</th>
					        <td class="content_02_box_div_table_td">
						        <select id="m_is_need_check"
		                                    name="m_is_need_check" size="1" class="select_100_box" style="width: 160px;">
		                            <option value="1">是</option>
		                            <option value="0">否</option>
		                        </select>
						    </td>
					    </tr>
					    <tr>
                           <th valign="top" class="content_02_box_div_table_02_th">可容纳人数：</th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" maxlength="5"
                                        value="<%=StringUtil.deNull(bean.getM_people_num())%>" id="m_people_num"
                                        name="m_people_num" class="validate[maxSize[5],custom[positiveinteger]] input_160" />
                            </td>
                           
                            <th class="content_02_box_div_table_th"><span class="color_red">*</span>所属部门：</th>
                            <td class="content_02_box_div_table_td">
                              <input type="text"
                                    id="m_dept_name" name="m_dept_name" 
                                    class="validate[required,maxSize[100]] input_160"
                                    value="<%=bean.getM_dept_name()%>"  disabled="disabled"/> 
                                <input type="hidden" id="m_dept_id" name="m_dept_id" value="<%=bean.getM_dept_id()%>" />
                                                    
                            </td>
                        </tr>
					    <tr>
					        <th valign="top" class="content_02_box_div_table_02_th"><span class="color_red">*</span>会议室地点：</th>
					        <td colspan="3" class="content_02_box_div_table_02_td">
			                    <input type="text" value="<%=StringUtil.deNull(bean.getM_address())%>" id="m_address"
			                        name="m_address" class="validate[required,maxSize[50]] input_160" style="width:98%;"/>
		                    </td>					        
					    </tr>	
					    <tr>
		                    <th valign="top" class="content_02_box_div_table_02_th">描述：</th>
		                    <td colspan="3" class="content_02_box_div_table_02_td">
		                        <textarea class="validate[maxSize[500]] textarea_575"  style="width:99%"
		                                      rows="5" id="m_remark" 
		                                      name="m_remark"><%=StringUtil.deNull(bean.getM_remark())%></textarea>
		                    </td>                    
		                </tr>   
					</table>
				</div>
			</div>
			
			<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>会议室管理员</span></div>
			<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
			    class="content_02_box_div_table_02">
			    <tr>
			        <th valign="top" class="content_02_box_div_table_02_th">会议室管理员：</th>
			        <td class="content_02_box_div_table_02_td">
				        <input name="" type="button" value="添加会议室管理员" class="but_y_03"
				            onclick="adddeptanduser('evalTd','administrator_ids','administrator_names')" />
			        </td>
			    </tr>
			
			    <tr>
			        <th class="content_02_box_div_table_02_th">
                                                            <span class="color_red">*</span>会议室管理员列表：
                    </th>
			        <td class="content_02_box_div_table_02_td">
			            <textarea id="evalTd" class="textarea_575 validate[maxSize[2000]]" style="width:99%" rows="5" readonly></textarea> 
			            <input  type="hidden" id="administrator_ids" name="administrator_ids"
			                value="<%=StringUtil.deNull(bean.getAdministrator_ids())%>" /> 
			            <input type="hidden" id="administrator_names" name="administrator_names"
			                value="<%=StringUtil.deNull(bean.getAdministrator_names())%>" />
			        </td>
			    </tr>
			</table>
			</div>
			</div>
		</div>  
	</div>
</form>
</body>
</html>
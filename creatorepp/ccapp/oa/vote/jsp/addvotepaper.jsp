<%-- 
描述：添加问卷
作者：戴连春
版本：1.0
日期：2013-05-14
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.*"%>
<%@page import="java.util.*"%>
<%@page
	import="com.chinacreator.xtbg.core.vote.service.VotePaperService"%>
<%@page
	import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.sql.Timestamp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();

	String id = StringUtil.deNull(request.getParameter("id"));//主键id
	String state = StringUtil.deNull(request.getParameter("stauts"));//问卷的状态 0:暂存；1:发布
	String type = StringUtil.deNull(request.getParameter("type"));//操作类型  0:保存 1:查看

	String subid = request.getParameter("subid");

	//对外联络的service
	VotePaperService service = new VotePaperServiceImpl();
	OAVotePaperBean bean = new OAVotePaperBean();

	String userId = accesscontroler.getUserID();//用户id
	String userName = accesscontroler.getUserName();//用户名
	String orgId = accesscontroler.getChargeOrgId();//用户所属机构id
	String orgName = accesscontroler.getChargeOrgName();//机构名
	String createdate = DateUtil.getCurrentDateTime();//创建时间
	String paper_id = StringUtil.getUUID();//问卷id
	//如果传入了id，则查询出问卷对象
	if (!StringUtil.nullOrBlank(id)) {
		bean = service.queryToOAVotePaperBean(id);
		userId = bean.getUser_id();
		userName = bean.getUser_name();
		orgId = bean.getOrg_id();
		orgName = bean.getOrg_name();
		createdate = StringUtil.deNull(bean.getCreatdate());
		paper_id = bean.getId();
	}
	//查询问卷类型
	List<Map<String, Object>> list = (List<Map<String, Object>>) service
			.findListPaperType();
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


<script
	src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script
    src="<%=path%>/ccapp/oa/resources/util/htmlutil.js"
    type="text/javascript"></script>    
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var rycpid = "<%=Constant.RYCPID%>";//人员测评类型id

jQuery(document).ready(function() {
    jQuery("#form1").validationEngine();
    
    
});
jQuery(function(){
    //根据传入的类型设置显示还是隐藏
    //如果状态为草稿
    if('0' == '<%=type%>' && '0' == '<%=state%>'){      
            jQuery("#cz_fb_button").show();  
            jQuery("#cz_zc_button").show();         
    }else{
    	jQuery("#vcenter input[type=text],#vcenter select").each(function(){
            HTMLUtil.readOnly(this);
         });
    	jQuery("#vcenter input[type=button]").hide();
    	jQuery("#vcenter input[type=radio]").attr("disabled","disabled");
    	jQuery("#vcenter textarea").attr("readOnly","readOnly");
    }
    
    //设置问卷类型     
    jQuery("#papaer_type option[value='<%=bean.getPapaer_type()%>']").attr("selected","selected");

    //设置是否置顶
    jQuery("#istop option[value='<%=bean.getIstop()%>']").attr("selected","selected");

    //设置是否发送信息的单选框选中
    if("1" == "<%=StringUtil.deNull(bean.getIs_send())%>"){
        jQuery("input[name='is_send']:eq(1)").attr("checked",'checked');
    }else{
        jQuery("input[name='is_send']:eq(0)").attr("checked",'checked');
    }
    
    //设置textArea的值
    createrDeptAndPosn({
             id:jQuery("#people_ids").val(),
             name:jQuery("#people_names").val()
        }
        ,"userTd",'people_ids','people_names'
        ,false,false,false,true);
    
    //设置被测评人员的值
    createrDeptAndPosn({
        id:jQuery("#eval_userids").val(),
        name:jQuery("#eval_usernames").val()
    } ,"evalTd",'eval_userids','eval_usernames'
    ,false,false,false,true);

  //问卷类型绑定事件
    jQuery("#papaer_type").change(function(){
        changeType();
     });
    //初始化被测评人员
    changeType();  
            
});

/**
 * 函数 changeType
 * 说明 当问卷类型更改时，改变被评测人员显示或是隐藏
 * 参数  ： 无
 * 返回值 ： 无
 */
function changeType(){
    //此处硬编码，当为人员评测时，才需要填写被评测人员
    if(rycpid == jQuery("#papaer_type").val()){
        jQuery("#eval_name_tr").slideDown(500);
        jQuery("#evalTd").removeClass('validate[required]').addClass('validate[required]');
    }else{
        jQuery("#eval_name_tr").slideUp(500);
        jQuery("#evalTd").removeClass('validate[required]');
        jQuery("#type_id").val();
               
    }
}

/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function() {
    //没有传入id则为插入操作
    if("" == "<%=id%>"){
        //发布，传入状态和操作参数
        ajaxSubmit("1","add","确定要发布吗？");
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("1","update","确定要发布吗？");
    }
   
}
/*
函数:  cg
说明:  提交添加与修改(存稿操作)
参数:   无
返回值: 无
*/
var cg = function() {
  //没有传入id则为插入操作
    if("" == "<%=id%>"){
         //发布，传入状态和操作参数
        ajaxSubmit("0","add","确定要暂存吗？");
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("0","update","确定要暂存吗？");
    }
}

var ajaxSubmit = function(state,action,alertMsg){
     //将状态设置为   (0：暂存，1：发布)
    jQuery("#stauts").val(state);
    
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
   
    if(!isFlag ){
      return ;
    }
    var okF = function(){
                //设置按钮为不可点击,以防止重复提交
                jQuery("#cz_fb_button").attr("disabled","disabled");
                jQuery("#cz_zc_button").attr("disabled","disabled");
                //ajax方式提交数据
                jQuery.ajax({ 
                    type: "post", 
                    url: "votepaperaction.jsp", 
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data : {
                        action : action,
                        subid : "<%=subid%>",
                        paramJson : setParamJson()      
                    },
                    dataType: "json", 
                    success: function (data) {
                        //恢复按钮为可点击
                        jQuery("#cz_fb_button").removeAttr("disabled");
                        jQuery("#cz_zc_button").removeAttr("disabled");

                        if(data&&data.msg){
                          alert(data.msg);
                        }
                        //操作成功，返回上层界面
                        if(data && data.flag && "true" == data.flag){
                            removeWindows('<%=subid%>',true);                                                      
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
 * 将参数转换成json数据
 */ 
function setParamJson(){
	 //清空值
    //jQuery("#evalTd").val("");
    //jQuery("#eval_usernames").val("");
    //jQuery("#eval_userids").val("");
    var paramjson = "{'id':'<%=StringUtil.deNull(paper_id)%>',"+
                    " 'title':'"+jQuery("#title").val()+"',"+
                    " 'stauts':'"+jQuery("#stauts").val()+"',"+
                    " 'direction':'"+jQuery("#direction").val()+"',"+
                    " 'creatdate':'<%=createdate%>',"+
                    " 'contact_date':'"+jQuery("#contact_date").val()+"',"+
                    " 'startdate':'"+jQuery("#startdate").val()+"',"+
                    " 'enddate':'"+jQuery("#enddate").val()+"',"+
                    " 'istop':'"+jQuery('#istop').val()+"',"+
                    " 'org_id':'"+jQuery('#org_id').val()+"',"+
                    " 'org_name':'"+jQuery("#org_name").val()+"',"+
                    " 'user_id':'"+jQuery("#user_id").val()+"',"+
                    " 'user_name':'"+jQuery("#user_name").val()+"',"+ 
                    " 'papaer_type':'"+jQuery("#papaer_type").val()+"',"+
                    " 'people_ids':'"+jQuery("#people_ids").val()+"',"+
                    " 'people_names':'"+jQuery("#people_names").val()+"',"+
                    " 'eval_usernames':'"+(rycpid == jQuery("#papaer_type").val()?jQuery("#eval_usernames").val():"")+"',"+
                    " 'eval_userids':'"+(rycpid == jQuery("#papaer_type").val()?jQuery("#eval_userids").val():"")+"',"+
                    " 'is_send':'"+jQuery('input[name="is_send"]:checked').val()+"',"+
                    " 'message_content':'您好！有一份关于【"+jQuery("#title").val()
                                 +"】的投票，请您及时参与投票'"+                    
                    "}";
    return paramjson
}

//返回
function closed(){
//  location.href ="announcementlist.jsp";
    var state = '<%=state%>';
    //新增的数据，提示是否保存
    if(state == "0"){
        var okF = function(){
            removeWindows('<%=subid%>',true);
            }
        var p={
            headerText:'提示',
            okName:'确认',
            okFunction:okF,
            cancelName:'取消'
        };
             alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
      
    }else{//如果是已发布的，则直接返回上一个界面
          removeWindows('<%=subid%>',true);
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
            s.treeID='cz_foreignContact_sharePeople';
            s.isShowSeacher="aa";
            s.treeName="选取人员";
            s.headerName="选取人员";
            s.titelText = "选择人员";
            s.rightHeaderText="已添加机构和人员";
            s.isNewCommonUse=false;
            s.treeList=
                    [{
                      
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

</script>
</head>
<body style="overflow-y: hidden;"
	onload="adaptationWH('_top','vcenter',1)">
<form id="form1" action="" method="post"><input type="hidden"
	name="stauts" id="stauts" /> <!-- table页面跳转 --> <input type="hidden"
	id="tablepage" name="tablepage" />
<div class="content_02" style="overflow: hidden;" id="_top"><!-- 操作-->
<div class="content_02_top" style="margin-bottom: 10px;"><input
	name="cz_fb_button" id="cz_fb_button" value="发布" onclick="Ok();"
	style="display: none" type="button" class="but_y_01" /> <input
	name="cz_zc_button" id="cz_zc_button" value="暂存" style="display: none"
	onclick="cg();" type="button" class="but_y_01" /> <input name=""
	value="返回" onclick="closed()" type="button" class="but_y_01" /></div>
</div>



<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll"
	scrolling="yes">

<div style="float: left; ">
<div class="content_02_box" style="width: 790px;">
<div class="content_02_box_title_bg"  style="width: 788px;"><span>基本信息</span></div>
<div class="content_02_box_div"  style="width: 788px;">
<table border="0" cellspacing="0" cellpadding="0"
	class="content_02_box_div_table" style="width:100%">
	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>标题：</th>
		<td colspan="3" class="content_02_box_div_table_td"><input
			type="text" style="width: 98%"
			value="<%=StringUtil.deNull(bean.getTitle())%>" id="title"
			name="title"
			class="validate[required,maxSize[100]] input_cx_title_150" /></td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th"><span
			class="color_red">*</span>发起人：</th>
		<td class="content_02_box_div_table_td"><input
			class="validate[required] input_160" id="user_name" name="user_name"
			value="<%=StringUtil.deNull(userName)%>" readonly="readonly" /> <input
			type="hidden" id="user_id" name="user_id"
			value="<%=StringUtil.deNull(userId)%>" /></td>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>发起日期：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[required] date_187" id="startdate" name="startdate"
			value="<%=StringUtil.deNull(bean.getStartdate())%>"
			onclick="WdatePicker({minDate:'%y-%M-%d 00-00-00',maxDate:'#F{$dp.$D(\'enddate\'||\'2099-01-01 00:00:00\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
	</tr>
	<tr>
		<th width="191" class="content_02_box_div_table_th"><span
			class="color_red">*</span>发起单位：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			id="org_name" name="org_name"
			class="validate[required,maxSize[100]] input_160"
			value="<%=orgName%>" readonly="readonly" /> <input type="hidden"
			id="org_id" name="org_id" value="<%=orgId%>" /></td>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>截止日期：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[required] date_187" id="enddate" name="enddate"
			value="<%=StringUtil.deNull(bean.getEnddate())%>"
			onclick="WdatePicker({minDate:'#F{$dp.$D(\'startdate\'||\'1980-01-01 00:00:00\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
	</tr>
	<tr>
		<th width="212" valign="top" class="content_02_box_div_table_02_th">考核类型：</th>
		<td class="content_02_box_div_table_02_td"><select
			id="papaer_type" name="papaer_type" size="1" class="select_100_box"
			style="width: 160px">
			<%
				if (null != list && !list.isEmpty()) {
					for (Map<String, Object> map : list) {
			%>
				<option selected="selected" value="<%=map.get("id")%>"><%=map.get("name")%></option>
			<%
				}
				}
			%>

		</select></td>
		<th width="212" valign="top" class="content_02_box_div_table_02_th">是否置顶：</th>
		<td class="content_02_box_div_table_02_td"><select id="istop"
			name="istop" size="1" class="select_100_box" style="width: 190px">
			<option value="1">否</option>
			<option value="0">是</option>
		</select></td>
	</tr>


</table>
</div>
</div>
<div class="content_02_box" id="eval_name_tr" style="display:none;width: 790px;">
<div class="content_02_box_title_bg"  style="width: 788px;"><span>被测评人员</span></div>
<div class="content_02_box_div"  style="width: 788px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="content_02_box_div_table_02">
	<tr>
		<th width="212" valign="top" class="content_02_box_div_table_02_th">被测评人员：</th>
		<td width="560" class="content_02_box_div_table_02_td"><input
			name="" type="button" value="选择被测评人员" class="but_y_03"
			onclick="adddeptanduser('evalTd','eval_userids','eval_usernames')" /></td>
	</tr>

	<tr>
		<th class="content_02_box_div_table_02_th"><span
			class="color_red">*</span>被测评人员列表：</th>
		<td class="content_02_box_div_table_02_td"><textarea id="evalTd"
			class="textarea_575" rows="5" readonly></textarea> <input
			type="hidden" id="eval_userids" name="eval_userids"
			value="<%=StringUtil.deNull(bean.getEval_userids())%>" /> <input
			type="hidden" id="eval_usernames" name="eval_usernames"
			value="<%=StringUtil.deNull(bean.getEval_usernames())%>" /></td>
	</tr>
</table>
</div>
</div>

<div class="content_02_box"  style="width: 790px;">
<div class="content_02_box_title_bg"  style="width: 788px;"><span>评分人员</span></div>
<div class="content_02_box_div"  style="width: 788px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="content_02_box_div_table_02">
	<tr>
		<th width="212" valign="top" class="content_02_box_div_table_02_th">评分人员：</th>
		<td width="560" class="content_02_box_div_table_02_td"><input
			name="" type="button" value="选择评分人员" class="but_y_03"
			onclick="adddeptanduser('userTd','people_ids','people_names')" /></td>
	</tr>

	<tr>
		<th class="content_02_box_div_table_02_th"><span
			class="color_red">*</span>评分人员列表：</th>
		<td class="content_02_box_div_table_02_td"><textarea id="userTd"
			class="validate[required] textarea_575" rows="5" readonly></textarea>
		<input type="hidden" id="people_ids" name="people_ids"
			value="<%=StringUtil.deNull(bean.getPeople_ids())%>" /> <input
			type="hidden" id="people_names" name="people_names"
			value="<%=StringUtil.deNull(bean.getPeople_names())%>" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_02_th">是否短信提醒：</th>
		<td class="content_02_box_div_table_02_td">&nbsp;<input
			type="radio" value="0" name="is_send" />否 &nbsp;&nbsp; <input
			type="radio" value="1" name="is_send" />是 <input type="hidden"
			id="message_content" name="message_content"
			value="<%=StringUtil.deNull(bean.getMessage_content())%>" /></td>
	</tr>
</table>
</div>
</div>

<div class="content_02_box" style="width:790px;">
<div class="content_02_box_title_bg"  style="width: 788px;"><span>考核对象描述</span></div>
<div class="content_02_box_div"  style="width: 788px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="content_02_box_div_table_02">
	<tr>
		<th class="content_02_box_div_table_02_th">被考核人员：</th>
		<td class="content_02_box_div_table_02_td"><textarea
			id="direction" name="direction"
			class="validate[maxSize[500]] textarea_575" rows="5"><%=StringUtil.deNull(bean.getDirection())%></textarea>
		<!-- 与会人员id --></td> 
	</tr>
</table>
</div>
</div>
<div class="content_02_box"  style="width:790px;border: 1px;">
<div class="content_02_box_title_bg" style="width: 788px"><span>考核试题管理</span></div>
<div class="content_02_box_div"  style="width: 788px;">
<iframe
	frameborder="0"
	style="padding: 0px; border: 0px; width: 100%; height: 450px"
	id="question_manage" name="question_manage"
	src="votequestionlist.jsp?subid=windowId&paper_id=<%=paper_id%>&status=<%=state%>&beforAdd=1"></iframe>
</div>
</div>
</div>
</div>
</form>
</body>
</html>
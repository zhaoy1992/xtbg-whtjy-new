<%-- 
描述：添加会议类型
作者：戴连春
版本：1.0
日期：2013-05-14
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.VotePaperService"%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.sql.Timestamp"%><html
    xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
     AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String paper_id = StringUtil.deNull(request.getParameter("paper_id"));//问卷id
    String id = StringUtil.deNull(request.getParameter("id"));//主键id
    String state = StringUtil.deNull(request.getParameter("status"));//状态 0:暂存；1:发布
    String type = StringUtil.deNull(request.getParameter("type"));//操作类型  0:保存 1:查看
    String copyFlag = StringUtil.deNull(request.getParameter("copyFlag"));//是否为复制问题的操作 1：是 ，其他：不是
    //window的id
    String subid = request.getParameter("subid");

    //网上投票管理的service 
    VotePaperService service = new VotePaperServiceImpl();
    OAVoteQuestionBean bean = new OAVoteQuestionBean();

    String question_id = id;
    //如果传入了id，则查询出问卷对象
    if (!StringUtil.nullOrBlank(id)) {
        bean = service.queryToQuestionBean(id);
        //复制问题的操作，则重新生成一个id
        if("1".equals(copyFlag)){
        	question_id =  StringUtil.getUUID();
        }
    }else{
    	//未传入id，则获取
    	question_id = StringUtil.getUUID();
    }
    //查询问卷类型
    List<Map<String, Object>> list = (List<Map<String, Object>>) service
            .findListQuestionType();
    //问题选项列表
    List<VoteOptionBean> optionList = bean.getOptionList();
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

var state = "<%=state%>";
jQuery(document).ready(function() {
    jQuery("#form1").validationEngine();

    //控制按钮的显示与隐藏
    if("0" == state){
         jQuery("#cz_fb_button").show();
         jQuery("#cz_zc_button").show();
    }else{
         jQuery("#cz_fb_button").hide();
         jQuery("#cz_zc_button").hide();
    }
    
});
jQuery(function(){
    
    
    //设置问卷类型 
    jQuery("#type_id option[value='<%=bean.getType_id()%>']").removeAttr("selected");
    jQuery("#type_id option[value='<%=bean.getType_id()%>']").attr("selected","selected");

    //设置是否必答
    jQuery("#answer option[value='<%=bean.getAnswer()%>']").removeAttr("selected");
    jQuery("#answer option[value='<%=bean.getAnswer()%>']").attr("selected","selected");

    //问题存在选项，则添加选项
    <%if(null != optionList && !optionList.isEmpty()){
      for(VoteOptionBean option : optionList){
    %>
    //给问题添加选项[复制问题的操作，则选项id赋值为空，以防违反唯一约束]
    tableControl.addHtml("<%=StringUtil.deNull("1".equals(copyFlag) ? "" : option.getId() )%>",
    	    "<%=StringUtil.deNull(option.getOption_code())%>",
    	    "<%=StringUtil.deNull(option.getContent())%>",
    	    "<%=StringUtil.deNull(option.getCheck_max())%>");
   <%}}%>

 //如果是新增操作且状态为草稿
   if('0' == '<%=type%>' && '0' == '<%=state%>'){
       jQuery("#cz_fb_button").show();  
       jQuery("#cz_zc_button").show();  
   }else{
	 //设置输入框为只读
	   
	   jQuery("#vcenter input[type=text],#vcenter select").each(function(){
		   HTMLUtil.readOnly(this);
		});
		jQuery("#vcenter input[type=button],#vcenter input[type=checkbox]").hide().attr("disabled","disabled");
		
   }
	choose();
   
});

/**
 * 函数 changeType
 * 说明 当问卷类型更改时，改变被评测人员显示或是隐藏
 * 参数  ： 无
 * 返回值 ： 无
 */
function changeType(){
    //此处硬编码，当为人员评测时，才需要填写被评测人员
    if("DC3075FBC7A77E97E0430100007F2424" == jQuery("#papaer_type").val()){
        jQuery("#eval_name_tr").show();
        jQuery("#evalTd").removeClass('validate[required]').addClass('validate[required]');
    }else{
        jQuery("#eval_name_tr").hide();
        jQuery("#evalTd").removeClass('validate[required]');
        //清空值
        jQuery("#evalTd").val("");
        jQuery("#eval_usernames").val("");
        jQuery("#eval_userids").val("");
    }
}



/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function() {
	//如果是人员测评投票的话，那么提醒不能为问答题
	var paper_id = jQuery("#papaer_type",parent.document.body).val();
	var str = jQuery("#type_id").val();
	if(paper_id  == 'DC3075FBC7A77E97E0430100007F2424' && str =='2579A194AF044FDE9D270C0BED70511F'){
		alert("请修改问卷类型或题型！");
	}else{
	    //没有传入id,或为复制操作时，则为插入数据
	    if("" == "<%=id%>" || "1" == "<%=copyFlag%>"){
	        //发布，传入状态和操作参数
	        ajaxSubmit("1","add","确定要发布吗？");
	    }else{
	         //发布，传入状态和操作参数
	        ajaxSubmit("1","update","确定要发布吗？");
	    }
	}
   
}
/*
函数:  cg
说明:  提交添加与修改(存稿操作)
参数:   无
返回值: 无
*/
var cg = function() {
	//如果是人员测评投票的话，那么提醒不能为问答题
	var paper_id = jQuery("#papaer_type",parent.document.body).val();
	var str = jQuery("#type_id").val();
	if(paper_id  == 'DC3075FBC7A77E97E0430100007F2424' && str =='2579A194AF044FDE9D270C0BED70511F'){
		alert("请修改问卷类型或题型！");
	}else{
	    //没有传入id则为插入操作
	    if("" == "<%=id%>"  || "1" == "<%=copyFlag%>"){
	         //发布，传入状态和操作参数
	        ajaxSubmit("0","add","确定要暂存吗？");
	    }else{
	         //发布，传入状态和操作参数
	        ajaxSubmit("0","update","确定要暂存吗？");
	    }
	}
}

/**
 函数:  ajaxSubmit
 说明:  ajax访问后台
 参数:  state 状态 0：暂存，1：发布
 返回值: 无
 */
var ajaxSubmit = function(state,action,alertMsg){
     //将状态设置为   (0：暂存，1：发布)
    jQuery("#status").val(state);
    
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
   
    if(!isFlag ){
      return ;
    }
    //本地验证
    var nativeFlag = nativeValidation();
    if(!nativeFlag ){
        return ;
      }
    var okF = function(){

                jQuery("#cz_fb_button").attr("disabled","disabled");
                jQuery("#cz_zc_button").attr("disabled","disabled");
                //ajax方式提交数据
                jQuery.ajax({ 
                    type: "post", 
                    url: "votequestionaction.jsp", 
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data : {
                        action : action,
                        subid : "<%=subid%>",
                        paramJson : setParamJson()      
                    },
                    dataType: "json", 
                    success: function (data) {
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
    var paramjson = "{'id':'<%=StringUtil.deNull(question_id)%>',"+
                    " 'paper_id':'<%=StringUtil.deNull(paper_id)%>',"+
                    " 'title':'"+jQuery("#title").val()+"',"+
                    " 'status':'"+jQuery("#status").val()+"',"+
                    //" 'direction':'"+jQuery("#direction").val()+"',"+
                    " 'answer':'"+jQuery("#answer").val()+"',"+
                    " 'type_id':'"+jQuery("#type_id").val()+"',"+
                    " 'question_number':'"+jQuery("#question_number").val()+"',"+
                    " 'order_no':'"+jQuery('#order_no').val()+"',"+
                    " 'optionList':"+ getOptionList()+
                   
                    " 'status':'"+jQuery("#status").val()+"'"+
                    "}";
    return paramjson
}

/**
 * 获得选项列表
 */
function getOptionList(){
    var paramjson = new Array();
    var code = jQuery("input[name=option_code]");//选项编号
    var  content = jQuery("input[name=content]");//选项内容

    var id = jQuery("input[name=option_id]");//选项id
    var check_max = jQuery("input[name=check_max]");//最大可选数
    paramjson.push("[");
    for(var i=0;i<code.length;i++){
        if(i != 0){
        	paramjson.push(",");
        }
        paramjson.push("{'id':'"+id[i].value+"',"+
                "'content':'"+content[i].value+"',"+
                "'option_code':'"+code[i].value+"',"+
                "'check_max':'"+check_max[i].value+"',"+
                "'question_id':'<%=StringUtil.deNull(question_id)%>',"+
                "}");
    }
    paramjson.push("],");
    return paramjson.join();
}

//返回
function closed(){
//  location.href ="announcementlist.jsp"
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

/**
 * 控制添加问题选项
 */
var tableControl = {
   tableId : "option_List",//dom id
   count : 0, //添加条数，用于唯一标示
   startCode : 65,//选项编号起始的ASSCI码值，即为（A）
   countCode : 0 ,
   /**
    *添加
    */
   addHtml : function(id,code,content,checkMax){
     var table = jQuery("#"+this.tableId);
     //传入的选项为空，则自动给选项赋值
     code =IsSpace(code) ? String.fromCharCode(this.startCode+this.countCode):code;
     var tr = '<tr id="tr'+this.count+'">'+
     '<td style="width:20px"><input name="option_box" type="checkbox" value="tr'+this.count+'"/></td>'+
     '<td style="width:40px"><span class="color_red">*</span>编号</td>'+
     '<td style="width:80px">'+
     ' <input type="text" id="option_code'+this.count+'" name="option_code" maxlength="2"'+
     '    class="validate[required,maxSize[2]] input_cx_title_150" '+
     '    style="width:50px;text-align:center" value="'+code+'"/></td>'+
     '<td style="width:40px"><span class="color_red">*</span>内容</td>'+
     '<td ><input type="text"  id="content'+this.count+'" name="content" maxlength="100" value="'+content+'"'+
     '    class="validate[required,maxSize[100]] input_cx_title_150" style="width:250px;"/>'+
     '<input type="hidden"  id="option_id'+this.count+'"  name="option_id" value="'+id+'"/>'+
     '</td>'+
     '<td style="width:50px;text-align:right;">可选数</td>'+
     '<td ><input type="text"  id="check_max'+this.count+'" name="check_max" maxlength="5" value="'+checkMax+'"'+
     '    class="validate[maxSize[5]] input_cx_title_150" style="width:50px;"/>'+
     
     '</td>'+
     '</tr>';
     //给table添加列
     table.html(table.html()+tr);
     
     this.count = this.count +1;
     this.countCode = this.countCode + 1;
   },
   /**
    *移除html
    */
   removeHtml : function(){
     //移除选中的行  
     jQuery("input[name=option_box]").each(function () {         
      if (jQuery(this).attr("checked")) {    
          jQuery("#"+this.value).remove();
      }
     });
     
   },
   /**
    *对问题选项重新编号
    */
   newCode : function(){
      var optionCodes = jQuery("input[name=option_code]");
      if(optionCodes.length <1){
        return;
      }
      this.countCode = 0;//编号计数器置0
      var This = this;
      optionCodes.each(function(){
         jQuery(this).val(String.fromCharCode(This.startCode + This.countCode));
         This.countCode = This.countCode + 1; 
      });
   }
   
}
/**
* 问题选项
*/
function choose(){
	var str = jQuery("#type_id").val();
	if(str =='2579A194AF044FDE9D270C0BED70511F'){
		jQuery("#questionChoose").hide();
		jQuery("#questionlegth").show();
		jQuery("#question_number").show();
	}else{
		jQuery("#questionChoose").show();
		jQuery("#questionlegth").hide();
		jQuery("#question_number").hide();
		
	}
}
/**
 * 本地表单验证
 */
function nativeValidation(){
  try{
    var pattern = "^[0-9]*$"; //只能是数字
    var flag = true;
    jQuery("input[name=check_max]").each(function(index) {
        //没有输入数字，或者输入的数字为正整数
        if(!IsSpace(jQuery(this).val())
                &&(jQuery(this).val().search(pattern)!=0
                ||  parseInt(jQuery(this).val())!=jQuery(this).val()) ){
            flag = false;
        }
    });

    if(flag){
       return flag;
    }else{
        alert("问题选项的可选数只能是正整数!");
        return flag;
    }           
    }catch(e){
       return false;
    }
}



</script>
</head>
<body style="overflow-y: hidden;"
    onload="adaptationWH('_top','vcenter',45)">
<form id="form1" action="" method="post"><input type="hidden"
    name="status" id="status" /> <!-- table页面跳转 --> <input type="hidden"
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
<div id="vcenter" style="float: left; width: 100%; overflow: scroll；padding:0px;"
    scrolling="yes">

<div style="float: left; width: 98%;margin:0px;padding:0px">
<div class="content_02_box">
<div class="content_02_box_title_bg"><span>问题信息</span></div>
<div class="content_02_box_div">
<table border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table">
    <tr>
        <th class="content_02_box_div_table_th"><span class="color_red">*</span>题目：</th>
        <td colspan="3" class="content_02_box_div_table_td"><input
            type="text" style="width: 98%"
            value="<%=StringUtil.deNull(bean.getTitle())%>" id="title"
            name="title" maxlength="500"
            class="validate[required,maxSize[500]] input_cx_title_150" /></td>
    </tr>
    <tr>
        <th valign="top" class="content_02_box_div_table_02_th">题型：</th>
        <td class="content_02_box_div_table_02_td"><select id="type_id" onclick="choose();"
            name="type_id" size="1" class="select_100_box" style="width: 160px">
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
        <th width="212" valign="top" class="content_02_box_div_table_02_th">是否必答：</th>
        <td class="content_02_box_div_table_02_td"><select id="answer"
            name="answer" size="1" class="select_100_box" style="width: 160px">
            <option value="1">是</option>
            <option value="0">否</option>
        </select>
       </td>
    </tr>
    <tr>
        <th valign="top" class="content_02_box_div_table_02_th"><span class="color_red">*</span>排序号：</th>
        <td class="content_02_box_div_table_02_td"><input type="text"
            id="order_no" name="order_no" value="<%=StringUtil.deNull(bean.getOrder_no()) %>"
            class="validate[required,custom[onlyNumberSp],maxSize[3]] input_160" maxlength="3" /></td>
        <th width="212" valign="top" class="content_02_box_div_table_02_th">
        <span id="questionlegth"><span  class="color_red">*</span>答案长度：</span> 
        </th>
        <td class="content_02_box_div_table_02_td">
	        <input type="text"
	            id="question_number" name="question_number" value="<%=StringUtil.deNull(bean.getQuestion_number()) %>"
	            class="validate[required,custom[onlyNumberSp]] input_160"/>
        </td>
    </tr>
</table>
</div>
</div>

<div class="content_02_box" id = "questionChoose">
<div class="content_02_box_title_bg"><span>问题选项</span></div>
<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table_02">
    <tr>
        <th width="212" valign="top" class="content_02_box_div_table_02_th">问题选项：</th>
        <td width="560" class="content_02_box_div_table_02_td">
        <input style="margin-right:5px;"
            name="" type="button" value="添加选项" class="but_y_01" onclick="tableControl.addHtml('','','','');" /> 
            <input style="margin-right:5px;"
            name="" type="button" value="删除选项" class="but_y_01" onclick="tableControl.removeHtml();" />
            <input style="margin-right:5px;"
            name="" type="button" value="重新编号" class="but_y_01" onclick="tableControl.newCode();" />
            </td>
    </tr>
    
    <tr>
        <th class="content_02_box_div_table_02_th">选项列表：</th>
        <td class="content_02_box_div_table_02_td" >
        <div style="height:120px; overflow: auto;overflow-x:hidden;width:100%" scrolling="yes">
        <table id="option_List" width="95%" border="0" cellspacing="0"
            cellpadding="0" class="content_02_box_div_table_02">
            
        </table>
        </div>
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
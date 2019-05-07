<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.OaWordTemplate"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdTableBean"%>
<%@page import="java.util.List"%>
<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String path = request.getContextPath();
    String flow_id = request.getParameter("flow_id");
    FlowInfoBean flowInfoBean = new FlowInfoBean();
    FlowInfoDao flowInfodao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
    FormserviceImpl FormserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = FormserviceImpl.getTableList();//获取表LIST
    if (!StringUtil.nullOrBlank(flow_id)) {
        flowInfoBean = flowInfodao.findFlowBaseInfoById(flow_id);
    }
    FlowDefInfoBean flowDefInfoBean = new FlowDefInfoBean();
    flowDefInfoBean = flowInfodao.findFlowDefInfoByFlowId(flow_id);
    /**
     *修改为一个业务类型只能添加一条流程信息
     * @author 戴连春
     * 2013-06-06
     */
    String sql = "select i.BUSITYPE_CODE, i.BUSITYPE_NAME "+
          "from oa_flow_busitype i "+
          "where (not exists (select busitype_code "+
          "         from oa_flow_baseinfo f "+
          "        where f.busitype_code = i.busitype_code)"+
          " or exists (select busitype_code from oa_flow_baseinfo b "+
          " where b.busitype_code = i.busitype_code and b.flow_id='"+StringUtil.deNull(flow_id)+
          "' )) and  i.is_valid = 'Y'";
    String infotypeHtml = DictDropDownList.buildSelect(sql,
            "busitype_code", StringUtil.deNull(flowInfoBean.getBusitype_code()), "",false, "没有可选的业务类型,请添加");//业务类型下拉框
    String type = request.getParameter("type");
    String openwindid = request.getParameter("operwindowid");

    //业务层操作类
    FlowInfoConfigServiceIfc service = new FlowInfoConfigServiceImpl();
    //查询出所有的表单信息
    List<FlowFormBean> formList = service.queryListFlowForm();
    //查詢出所有word 模板
    List<OaWordTemplate> tempList = service.queryListWordTemp();
    //图标附件ID
    String form_image_id = flowInfoBean.getForm_image_id();
    String attach_id =  flowInfoBean.getAttach_id();
    if(StringUtil.isBlank(attach_id)) {
    	attach_id = StringUtil.getUUID();
	}
    
    //流程下拉框
    String flowsql="select flow_id,flow_name  from OA_FLOW_BASEINFO ";
    String flowHtml = DictDropDownList.buildSelect(flowsql,"next_flow_id", "","",true,"","width: 300px;");
    
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
jQuery.noConflict();
</script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"> </script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid_old.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
});
var typetemp = '<%=type%>';
var did=null;
var idss=null;
//系统根路径
var path = "<%=path %>";

function getmodledown(){
    if(did<idss){
        did=did*1+1*1;
    }
    var modelup=jQuery("#flowwfactiongridTable").jqGrid('getRowData', did);
    var aid=modelup.action_id;
    return aid;
}

function showcflow(){
    jQuery("#selectButton").css("display","");
    jQuery("#bindButton").css("display","");
}

function judgeshowcflow(){
    var flowId='<%=StringUtil.deNull(flowInfoBean.getFlow_id())%>';
    if(flowId!=""){
        showcflow();
    }
}
function getmodleup(){
    if(did>1){
        did=did*1-1*1
    };
    var modelup=jQuery("#flowwfactiongridTable").jqGrid('getRowData', did)
    var aid=modelup.action_id;
    return aid;
}

function showAndhide()
{   
    var  typeflag = '<%=type%>';
    if(typeflag == 'flag')
    {
         jQuery('#saveButton').hide();
         jQuery('#bindButton').hide();
         jQuery('#selectButton').hide();
        // jQuery('#restoreButton').hide();
    }
}
//流程定义配置列表
jQuery(function() {
    judgeshowcflow();
    jQuery("#flowdefgridTable").jqGrid({
        url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.processconfig.list.FlowDefInfoList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype: "json",
        //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
        mtype: "POST",
        //定义使用哪种方法发起请求，GET或者POST
        height: "100%",//270
        //Grid的高度，可以接受数字、%值、auto，默认值为150
        //width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
        //shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
        autowidth: true,
        //默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
        colNames: ['流程定义主键', '流程定义ID', '流程ID ', '流程版本 ', '流程包 ','流程描述', '创建时间 ', '是否生效 ','操作'],
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
        {
            name: 'def_id',
            index: 'def_id',
            hidden: true
        },
        {
            name: 'flow_defid',
            index: 'flow_defid',
            width: 150,
            editable: true
        },
        {
            name: 'flow_id',
            index: 'flow_id',
            width: 180,
            search: true
        },
        {
            name: 'flow_version',
            index: 'flow_version',
            width: 80,
            search: true
        },
        {
            name: 'package_id',
            index: 'package_id',
            width: 120,
            search: true
        },
        {
            name: 'flow_desc',
            index: 'flow_desc',
            width: 225
        },
        {
            name: 'create_time',
            index: 'create_time',
            width: 140
        },
        {
            name: 'is_valid',
            index: 'is_valid',
            width: 100,
            search: true
        },
        {
            name: 'act',
            index: 'act',
            width: '100',
            search: false,
            sortable: false,
            editable: false
        },
        ],
        sortname: 'flow_version',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder: '',
        viewrecords: true,
        
        //设置是否在Pager Bar显示所有记录的总数。
        rowNum: 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList: [10, 20, 30],
        //一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
            // alert(idss);
            var ids = jQuery("#flowdefgridTable").getDataIDs(); //jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                
                be = "<input class='but_y_01'onMouseOver=javascript:jQuery(this).attr('class','but_y_02'); onMouseOut=javascript:jQuery(this).attr('class','but_y_01');  type='button'  id='modify' value='启用' onclick='startFlow("+cl+")'>";
                jQuery("#flowdefgridTable").jqGrid('setRowData', ids[i], {
                    act: be
                });
            }
        },
        
        jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems: false
        },
        //pager: "#flowdefgridPager",
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
        //定义页码控制条Page Bar
        //caption: "流程绑定",
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJosn(),
        prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows: "rows",
            //表示请求行数的参数名称  
            sort: "sidx",
            //表示用于排序的列名的参数名称  
            order: "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
        toolbar: [true,"top","<input class='but_y_01' id=del type='button' onclick='deleteFlowDefInfo()' value='删除'/>"],
        multiselect: true,
        ondblClickRow: function(id) {
            
        }
    }).navGrid('#flowdefgridPager', {
        edit: false,
        add: false,
        del: false,
        serach:false,
        refresh:false
    });

    

    jQuery("#t_flowdefgridTable").append("<div>")
    .append("流程绑定")
    //.append("<select id='combobox'><option value='1'>组1</option><option value='2'>组2</option><option value='3'>组3</option></select>") 
    .append("</div>");
        
//流程活动配置列表


jQuery("#flowwfactiongridTable").jqGrid({
    url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.processconfig.list.FlowWfactionInfoList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
    //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
    datatype: "json",
    //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
    mtype: "POST",
    //定义使用哪种方法发起请求，GET或者POST
    height: "100%",//270
    //Grid的高度，可以接受数字、%值、auto，默认值为150
    //width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
    //shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
    autowidth: true,
    //默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
    // add by 黄海  增加操作列 2013-05-28
    colNames: ['活动id', '活动名称', '活动别名 ', '时限单位 ', '活动时限 ', '备注 ', '创建时间 ', '操作'],
    // add end
    //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
    colModel: [ //最重要的数组之一，用于设定各列的参数
    {
        name: 'action_id',
        index: 'action_id',
        hidden: true,
        sortable: false
    },
    {
        name: 'action_name',
        index: 'action_name',
        width: 180,
        editable: true,
        sortable: false
    },
    {
        name: 'action_alias',
        index: 'action_alias',
        width: 230,
        search: true,
        sortable: false
    },
    {
        name: 'limit_unit',
        index: 'limit_unit',
        search: true,
        sortable: false
    },
    {
        name: 'action_limit',
        index: 'action_limit',
        search: true,
        sortable: false
    },
    {
        name: 'remark',
        index: 'remark',
        search: true,
        sortable: false
    },
    {
        name: 'create_time',
        index: 'create_time',
        sortable: false
    },
    // add by 黄海  增加操作列 2013-05-28
    {
        name: 'act_col',
        index: 'act_col',
        width: '100',
        search: false,
        sortable: false,
        editable: false
    },
    // add end
    ],
    sortname: 'action_id',
    //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
    sortorder: 'desc',
    viewrecords: true,
    
    //设置是否在Pager Bar显示所有记录的总数。
    rowNum: 10,
    //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
    rowList: [10, 20, 30],
    //一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
    
    gridComplete: function() { 
        // add by 黄海  增加操作列 2013-05-28
        var ids = jQuery("#flowwfactiongridTable").getDataIDs(); 
        for (var i = 0; i < ids.length; i++) {
            var cl = ids[i];
            be = "<input class='but_y_01' onMouseOver=javascript:jQuery(this).attr('class','but_y_02'); onMouseOut=javascript:jQuery(this).attr('class','but_y_01');  type='button'  id='modify' value='配置' onclick='startActColStatus("+cl+")'>";
            jQuery("#flowwfactiongridTable").jqGrid('setRowData', ids[i], {
                act_col: be
            });
        }
        //add end 
    },
    jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
        repeatitems: false
    },
    //pager: "#flowwfactiongridPager",
    pagerintoolbar:true,//上面的分页条
    pagerinBottombar:true,//下面的分页条
    //定义页码控制条Page Bar
    //caption: "流程活动列表",
    //设置Grid表格的标题，如果未设置，则标题区域不显示。
    search : toUserParamJosn(),
    prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        rows: "rows",
        //表示请求行数的参数名称  
        sort: "sidx",
        //表示用于排序的列名的参数名称  
        order: "sord",
        //表示采用的排序方式的参数名称 
        search : "search"
    },
    toolbar: [true,"top"],
    multiselect: false,
    onSelectRow : function(id) {
        configActionDetail(id);
    }
}).navGrid('#flowwfactiongridPager', {
    edit: false,
    add: false,
    del: false
    
});

jQuery("#t_flowwfactiongridTable").append("<div>")
.append("流程活动列表")
.append("</div>");


//如果高度不够，重新对外层的ifram赋值一次
var a = setTimeout(function(){
	resizeIfram(a);
	
},3000);



});

function resizeIfram(a){
	clearTimeout(a);
  var height = jQuery(document).height();
  var iframheight = jQuery("#frame1",window.parent.document);
  if(height>iframheight.height()){
    //重置iframe的高度
	iframheight.height(height);
  }
}
/*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
var toUserParamJosn = function() {
    var str = "{'flow_id':'"+jQuery('#flow_id').val()+"'}";
    return descape(str);
}

var refreshGrid4FlowInfo = function() {
    var sdata = { //构建查询需要的参数 
            paramJson: toUserParamJosn()
        }; //获得当前postData选项的值  
        var postData = jQuery("#flowdefgridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
        jQuery.extend(postData, sdata);
        jQuery("#flowdefgridTable").jqGrid("setGridParam", {
            search: true // 将jqGrid的search选项设为true  
        }).trigger("reloadGrid", [{
            page: 1
        }]); //重新载入Grid表格，以使上述设置生效 
    var sdata1 = { //构建查询需要的参数 
            paramJson: toUserParamJosn()
        }; //获得当前postData选项的值  
        var postData1 = jQuery("#flowwfactiongridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
        jQuery.extend(postData1, sdata1);
        jQuery("#flowwfactiongridTable").jqGrid("setGridParam", {
            search: true // 将jqGrid的search选项设为true  
        }).trigger("reloadGrid", [{
            page: 1
        }]); //重新载入Grid表格，以使上述设置生效 
}

var refreshGrid4WfactionInfo = function() {
    var sdata = { //构建查询需要的参数 
            paramJson: toUserParamJosn()
        }; //获得当前postData选项的值  
        var postData = jQuery("#flowwfactiongridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
        jQuery.extend(postData, sdata);
        jQuery("#flowwfactiongridTable").jqGrid("setGridParam", {
            search: true // 将jqGrid的search选项设为true  
        }).trigger("reloadGrid", [{
            page: 1
        }]); //重新载入Grid表格，以使上述设置生效
}

var refreshFlowInfo = function(version,packageId,flowdefId){
    jQuery("#flow_version").val(version);
    jQuery("#package_id").val(packageId);
    jQuery("#flow_defid").val(flowdefId);
}

var saveFlowBaseInfo = function() {
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
    //本地验证
    var nFlag = nativeValidate();
    if(!nFlag){
       return;
    }
    var jsonparam = "{'flow_id':'"+jQuery('#flow_id').val()+"','flow_name':'"+jQuery("#flow_name").val()+"',"+
                    "'busitype_code':'"+jQuery('#busitype_code').val()
                    +"','flow_limit':'"+jQuery('#flow_limit').val()
                    +"','limit_unit':'"+jQuery('#limit_unit').val()
                    +"','org_id':'"+jQuery('#org_id').val()
                    +"','insname_rule':'"+jQuery('#insname_rule').val()
                    +"','from_path':'"+jQuery('#from_path').val()
                    +"','flow_tyle':'"+jQuery('#flow_tyle').val()
                    +"','template_id':'"+jQuery('#template_id').val()
                    +"','form_image_id':'"+jQuery('#form_image_id').val()
                    +"','attach_id':'"+jQuery('#attach_id').val()
                    +"','next_flow_id':'"+jQuery('#next_flow_id').val()
                    +"','is_valid':'"+jQuery('#is_valid').val()+"'}";
    jQuery("#jsonparam").val(descape(escape(jsonparam)));
    var fm = document.getElementById("form1");
    fm.action = "flowconfigaddorupdateform.jsp?openwindid=<%=openwindid%>";
    fm.target = "hiddenFrame";
    jQuery('#form1').submit();
}
/**
 * 表单验证
 */
function nativeValidate(){

    //业务类型
    if(isSpace(jQuery("#busitype_code").val())){
      alert("业务类型不能为空");
      return false;
    }

    //所属表格
    if(isSpace(jQuery("#table_id").val())){
      alert("所属表格不能为空");
      return false;
    }
    if(jQuery("#flow_tyle").val()=="1"){
    	
    	//表单路径
        if(isSpace(jQuery("#from_path").val())){
          alert("表单路径不能为空");
          return false;
        }
    }else if(jQuery("#flow_tyle").val()=="2"){
    	//模板类型
        if(isSpace(jQuery("#template_id").val())){
          alert("模板类型不能为空");
          return false;
        }
    }
    return true;    
}

var init = function() {
    showAndhide();
    setSelectValue("busitype_code","<%=flowInfoBean.getBusitype_code()%>");
    setSelectValue("limit_unit","<%=flowInfoBean.getLimit_unit()%>");
    setSelectValue("from_path","<%=flowInfoBean.getFrom_path()%>");
    setSelectValue("table_id","<%=flowInfoBean.getTable_id()%>");
    setSelectValue("flow_tyle","<%=flowInfoBean.getFlow_tyle()%>");
    setSelectValue("template_id","<%=flowInfoBean.getTemplate_id()%>");
    setSelectValue("is_valid","<%=flowInfoBean.getIs_valid()%>");
    setSelectValue("next_flow_id","<%=flowInfoBean.getNext_flow_id()%>");
    fromTypeChange("<%=flowInfoBean.getFlow_tyle()%>");
    
    var attach_id = "<%=attach_id%>";
    var typeFilter  = {'图片 (*.jpg, *.jpeg, *.gif, *.png)': '*.jpg; *.jpeg; *.gif; *.png'}
	MyFancyupload.createUpload('_fileshow', '#_filebut', path, path+'/servlet/pubFileUpload?buessid='+attach_id, true, attach_id,typeFilter,setImagePath,'110');
    changeTable('init');
}

//附件上传成功回调函数
function setImagePath(djsn,filetype){
	if(filetype!= ".jpg" && filetype!= ".jpeg" && filetype!= ".gif"&& filetype!= ".png"){
		alert("上传的文件不是图片，请删除后上传图片！");
	}
	jQuery("#form_image_id").val(djsn+filetype);	
}

var startFlow = function(id) {
    var model = jQuery("#flowdefgridTable").jqGrid('getRowData', id);

    if(model.is_valid == "是"){
        alert("此流程已启用");
        return false;
    }
    var processId = model.def_id;
    var flow_id = model.flow_id;
    var is_valid = model.flow_version;
    var jsonparam = "{'flow_id':'"+flow_id+"','def_id':'"+processId+"'}";
        
    var url = "flowinfobangdingform.jsp?type=userflowinfo&def_id="+processId;
    jQuery("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    jQuery('#form1').submit();
}

var deleteFlowDefInfo = function(id) {
    var selectedIds = jQuery("#flowdefgridTable").jqGrid("getGridParam", "selarrrow");
    if(selectedIds.length>1){
		alert("请只选择一条数据！");
		return; 
	}else if(selectedIds.length==0){
		alert("请选择要删除的记录！");
		return;
	}
    var defids='';
    var flag=false;
    for ( var i = 0; i < selectedIds.length; i++){
		model = jQuery("#flowdefgridTable").jqGrid('getRowData',selectedIds[i]);
		defids+=model.def_id; //+",";
	    if(model.is_valid == "是"){
	    	flag=true;
	    }
	}
    if(flag){
        alert("请只选择没有被启用的流程删除！");
        return false;
    }
    var p={
		headerText:'提示',
		okName:'确认',
		okFunction:function(){
		    var url = "deleteflowdefinfodo.jsp?defids="+defids;
		    document.all.form1.action = url;
		    document.all.form1.target = "hiddenFrame";
		    jQuery('#form1').submit();
		},
		cancelName:'取消'
		};
	alert("你确定要删除该信息？",p);
}

/*
    函数:  startActColStatus
    说明:  弹出配置流程活动表单元素状态的子页面
    作者：  黄海
    日期： 2013-05-29
    参数:  行主键id
    返回值: 无
*/
var startActColStatus = function(id) {
    var busitype_code = jQuery('#busitype_code').val()
    var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData' , id);
    var action_name = model.action_name;
    action_name = encodeURI(encodeURI(action_name));
    try{
        var url = "<%=path%>/ccapp/oa/process/processconfig/jsp/setcolandtesttabform.jsp?actionId="+model.action_id+"&action_name="+action_name+"&bussinessType="+busitype_code;
        var window = openAlertWindows('windowId',url,'配置流程活动表单元素与正文状态','900','1200','2%');
    }catch(error){}
    
}

var chooseWorkFlow = function(){
    try{
    var url = "<%=path%>/jawe/jawe_tree/jaweTree.jsp";
    var wfInfo= window.showModalDialog(url,"","dialogWidth=700px;dialogHeight=600px;center:yes");
    var packageId=wfInfo.split("%23")[0];
    var version=wfInfo.split("%23")[1];
    var flowdefId=wfInfo.split("%23")[2];
    var flow_desc=unescape(wfInfo.split("%23")[3]);
    jQuery("#flow_version").val(version);
    jQuery("#package_id").val(packageId);
    jQuery("#flow_defid").val(flowdefId);
    jQuery("#flow_desc").val(flow_desc);
    }catch(error){}
}


var saveFlowInfo = function(){
    var flowInfo=jQuery("#flow_defid").val();
    if(IsSpace(flowInfo)){
        alert("请选择发布的流程信息");
        return;
    }
    var packageId=jQuery("#package_id").val();
    var version=jQuery("#flow_version").val();
    var flowdefId=jQuery("#flow_defid").val();
    var flow_id = jQuery('#flow_id').val();
    var flow_desc = jQuery('#flow_desc').val();

    var jsonparam = "{'flow_id':'"+flow_id+"','package_id':'"+packageId+"',"+
                    "'flow_version':'"+version+"','flow_defid':'"+flowdefId+"','flow_desc':'"+flow_desc+"'}";
        
    var url = "flowinfobangdingform.jsp?type=saveflowinfo";
    jQuery("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    jQuery('#form1').submit();
}
/**
 * 流程继承
 */
var extendsflowversion = function(oldFlowId,newFlowId){
    var url = "flowinfobangdingform.jsp?type=extendsflowversion&old_flow_id="
        +oldFlowId+"&new_flow_id="+newFlowId+"&oldTableId=<%=StringUtil.deNull(flowInfoBean.getTable_id())%>";
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    jQuery('#form1').submit();
}

//初始化流程 
var flowacitoninit = function(newFlowId){
    var url = "flowinfobangdingform.jsp?type=flowacitoninit&new_flow_id="+newFlowId;
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    jQuery('#form1').submit();
}

//actionconfigdetail.jsp参数
var configActionDetail = function(id){
    did=id;
    idss = jQuery("#flowwfactiongridTable").getGridParam("records");
    var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData', id);
    var url ='<%=path%>/ccapp/oa/process/processconfig/jsp/actionconfigdetail.jsp?action_id='
        +model.action_id+'&type=<%=type%>&flow_id=<%=flow_id %>';
    openAlertWindows('windowId',url,'配置环节','810','480','20%');
    
}
/* 保存成功后返回方法-子页面调用 */
function saveBack(){
    removeWindows('<%=openwindid%>',false);
}


var setFlowIdAfterSave = function (flowid){
    jQuery('#flow_id').val(flowid);
}

//选择机构
var chooseOrg = function (){
    var s = new jQuery.z_tree();
      s.treeID='mian';
      s.treetypestr='radio';
      s.isShowSeacher=true;
      s.treeName="选取单位";
      s.isType='dept';
      s.headerName="选取单位";
      s.item_id = 'org_id';
      s.selectedIds=jQuery('#org_id').val();
      s.type='AORG';
      s.returnFunction=function(orgObj){
          if(!IsSpace(orgObj)){
                 jQuery('#org_id').val(orgObj.id);
                 jQuery('#org_name').val(orgObj.name);
             }else{
                 jQuery('#org_id').val("");
                 jQuery('#org_name').val("");
             }

         }
      s.init();
}

//返回
function backparent(){
    var typeflag = '<%=type%>'
    if(typeflag == 'flag')
    {
        var url="flowinfoconfiguserlist.jsp";
        location.href=url;
    }else
    {
        var url="flowinfoconfiglist.jsp";
        location.href=url;
    }
}

//改变表单类型时，显示，隐藏对应的下拉框。
function fromTypeChange(type){
	if(type == "2"){
		jQuery("#span").html("模版类型：");
		jQuery("#select_form").hide();
		jQuery("#select_word").show();
	}else{
		jQuery("#span").html("表单路径：");
		jQuery("#select_word").hide();
		jQuery("#select_form").show();
	}
	
}

/*
函数：changeTable
描述：切换绑定表
参数：
返回值：
*/
function changeTable(changeType){
var table_id = jQuery('#table_id').val();//获取表ID
var table_code=jQuery('#table_id option:selected').attr("code");
if(changeType=="select"){//切换流程实例生成规则到下拉框
	jQuery("input[name='input_insname_rule']").attr("id","");
	jQuery("input[name ='input_insname_rule']").hide();
	jQuery("select[name ='select_insname_rule']").attr("id","insname_rule");
	jQuery("select[name='select_insname_rule']").show();	
}
//ajax方式提交数据
  jQuery.ajax({
      type: "post", 
      url: "../../../form/configparmdo.jsp", 
      contentType: "application/x-www-form-urlencoded; charset=utf-8",
      data : {
          action : 'query',
          table_id : table_id    
      },
      dataType: "json", 
      success: function (data) {
    	var selectID= false;
      	jQuery("#insname_rule").empty();
      	if(data!=null && data.length>0){
      		for(var i=0; i<data.length; i++){
      			jQuery("#insname_rule").append("<option value='{"+table_code+"__"+data[i].column_code+"}'>{"+table_code+"__"+data[i].column_code+"}["+data[i].column_name+"]</option>");  
      			//如果是下拉框中出现过的值
      			if("<%= StringUtil.deNull(flowInfoBean.getInsname_rule())%>" != ""){
	      			if("<%= StringUtil.deNull(flowInfoBean.getInsname_rule())%>" == "{"+table_code+"__"+data[i].column_code+"}"){
	      				selectID = true;
	      			}
      			}
      		}
  			jQuery("#insname_rule").append("<option value='zdyzz'>自定义规则</option>");  
      	}
      	//如果规则为空
      	if("<%= StringUtil.deNull(flowInfoBean.getInsname_rule())%>" == ""){
				selectID = true;
			}
      	//如果是表切换 
      	if(changeType=="select"){
      		selectID = true;
      	}
      	if(!selectID){//切换流程实例生成规则到文本框
      		jQuery("select[name='select_insname_rule']").attr("id","");
    		jQuery("select[name='select_insname_rule']").hide();
    		jQuery("input[name ='input_insname_rule']").attr("id","insname_rule");
    		jQuery("input[name ='input_insname_rule']").show();
      	}
      	jQuery('#insname_rule').val("<%= StringUtil.deNull(flowInfoBean.getInsname_rule())%>");
      }, 
      error: function (XMLHttpRequest, textStatus, errorThrown) { 
          alert("出现异常，请稍后再试！");
      } 
   });     
}

//实例名称规则切换
function insnameRuleChange(ruleSelect){
	var ruleStr = ruleSelect.value
	//alert(jQuery('#insname_rule').val());
	if(ruleStr=="zdyzz"){//如果是自定义规则，那么隐藏下拉框，显示文本框
		jQuery("select[name='select_insname_rule']").attr("id","");
		jQuery("select[name='select_insname_rule']").hide();
		jQuery("input[name ='input_insname_rule']").attr("value","");
		jQuery("input[name ='input_insname_rule']").attr("id","insname_rule");
		jQuery("input[name ='input_insname_rule']").show();
	}
}

//实例名称规则双击文本框
function insnameRuledbClick(ruleInput){
	var ruleStr = ruleInput.value
	//alert(jQuery('#insname_rule').val());
	jQuery("input[name='input_insname_rule']").attr("id","");
	jQuery("input[name ='input_insname_rule']").hide();
	jQuery("select[name ='select_insname_rule']").attr("value","");
	jQuery("select[name ='select_insname_rule']").attr("id","insname_rule");
	jQuery("select[name='select_insname_rule']").show();
}

//复制流程
function copyFlow(){
	var flow_id = jQuery('#flow_id').val();
	if(flow_id){
		var url = '<%=path%>/ccapp/oa/process/processconfig/jsp/flowinfoconfigforcopylist.jsp?flow_id='+flow_id+'&windowsId=windowId1';
		openAlertWindows('windowId1',url,'选择复制信息','810px','484px','15%','15%');
	}else{
		alert("流程基本信息未保存，请先保存");
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body onLoad="init();"
    style="overflow: hidden;">
<form id="form1" name="form1" method="post" class="formular">
<input type="hidden" name="form_image_id" id="form_image_id"  value="<%=form_image_id %>"/>
<input type="hidden" name="attach_id" id="attach_id"  value="<%=attach_id %>"/>
<div class="content_02" style="overflow: hidden;">

<div id="vcenter"
    style="float: left; width: 100%; overflow: hidden; ">
<div style="float: left; width: 775px;">
<div class="content_02_box" style="overflow: hidden;">
<div class="content_02_box_title_bg"><span>基本信息</span></div>
<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table_02">
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>流程名称：</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name="flow_name" id="flow_name" class="validate[required,maxSize[100]] input_185"
            value="<%=StringUtil.deNull(flowInfoBean.getFlow_name())%>">
        </td>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>业务类型：</th>
        <td class="content_02_box_div_table_td"><%=infotypeHtml%></td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th">流程定义ID：</th>
        <td class="content_02_box_div_table_td"><input class="input_185"
            type="text" disabled="disabled" readonly="readonly"
            value="<%=StringUtil.deNull(flowDefInfoBean.getFlow_defid())%>"
            id="flow_defid" name="flow_defid" /></td>
        <th class="content_02_box_div_table_th">流程版本：</th>
        <td class="content_02_box_div_table_td"><input class="input_185"
            type="text" readonly="readonly" disabled="disabled"
            value="<%=StringUtil.deNull(flowDefInfoBean
                                    .getFlow_version())%>"
            id="flow_version" name="flow_version" />
            <input class="input_185"
            type="hidden" value="" id="flow_desc" name="flow_desc" />
            </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>流程期限：</th>
        <td class="content_02_box_div_table_td"><input class="validate[required,custom[onlyNumberSp],maxSize[5]] input_155"
            type="text"
            value="<%=StringUtil.deNull(flowInfoBean.getFlow_limit())%>"
            id="flow_limit" name="flow_limit" style="width: 68%" /> <select id="limit_unit"
            style="height: 25px;width: 50px" name="limit_unit">
            <option value="D">日</option>
            <option value="H">小时</option>
        </select></td>
        <th class="content_02_box_div_table_th">流程包ID：</th>
        <td class="content_02_box_div_table_td"><input class="input_185"
            type="text" readonly="readonly" disabled="disabled"
            value="<%=StringUtil.deNull(flowDefInfoBean.getPackage_id())%>"
            id="package_id" name="package_id" /></td>
    </tr>

    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>所属机构：</th>
        <td class="content_02_box_div_table_td"><INPUT class="validate[required] input_160"
            onmouseover="this.title=this.value" id="org_name" name="org_name"
            value="<%=StringUtil.deNull(flowInfoBean.getOrg_name())%>" readOnly
            onclick='chooseOrg()' style="width: 82%" > <input name="" type="button" value=""
            class="but_x" onclick="chooseOrg()" /> <input type="hidden"
            id=org_id name=org_id
            value="<%=StringUtil.deNull(flowInfoBean.getOrg_id())%>" /></td>
        <th class="content_02_box_div_table_th">是否有效：</th>
        <td class="content_02_box_div_table_td"><select id="is_valid"
            style="width: 186px" name="is_valid">
            <option value="Y">是</option>
            <option value="N">否</option>
        </select> <!--      <input type="radio"--> <!--         name="is_valid" value="Y" checked="checked">是 <input-->
        <!--            type="radio" name="is_valid" value="N">否--> <input id="flow_id"
            name="flow_id" type="hidden"
            value="<%=StringUtil.deNull(flowInfoBean.getFlow_id())%>"
            class="cText_out" readonly="readonly" disabled="disabled" /></td>
    </tr>
    <tr>	
    	<th class="content_02_box_div_table_th"><span style="color: red">*</span>表单类型：</th>
        <td class="content_02_box_div_table_td">
        <select name="flow_tyle" id="flow_tyle" class="validate[required] cms_select" style="width: 100%" onChange="fromTypeChange(this.value);">
       		<option value="1">页面</option>
            <option value="2">WORD文档</option>
        </select>
        </td>
        
    	<th class="content_02_box_div_table_th"><span style="color: red">*</span><span id="span">表单路径：</span></th>
        <td class="content_02_box_div_table_td">
        <div id = "select_form">
        <!-- JSP頁面 -->
        <select name="from_path" id="from_path" class=" cms_select" style="width: 186px" onChange="">
            <option value="">请选择</option>
            <%
                if (null != formList && !formList.isEmpty()) {
                    for (FlowFormBean formBean : formList) {
		            %>
		            <option value="<%=StringUtil.deNull(formBean.getForm_path())%>"
		                title="<%=StringUtil.deNull(formBean.getForm_path())%>">
		                <%=StringUtil.deNull(formBean.getForm_name())%></option>
		            <%
                	}
                }else{
                    %>
                    <option value="">没有可选择的表单路径</option>
                    <%
                }
            %>
        </select>
        </div>
        <div id = "select_word" style="display:none;">
        <!-- WORD模板 -->
        <select name="template_id" id="template_id" class=" cms_select" style="width: 186px" onChange="">
            <option value="">请选择</option>
            <%
                if (null != tempList && !tempList.isEmpty()) {
                    for (OaWordTemplate wordTemplate : tempList) {
		            %>
		            <option value="<%=StringUtil.deNull(wordTemplate.getTemplate_id())%>"
		                title="<%=StringUtil.deNull(wordTemplate.getTemplate_remark())%>">
		                <%=StringUtil.deNull(wordTemplate.getTemplate_name())%></option>
		            <%
                	}
                }else{
                    %>
                    <option value="">没有可选择的模板</option>
                    <%
                }
            %>
        </select>
        </div>
        </td>
        
    </tr>
    <!-- add by 黄海  增加操作列 2013-06-03 说明：由于业务类型和所属表格是主从关系的需求不适合调用封闭好的select方法，故按下述与法-->
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>所属表格：</th>
        <td class="content_02_box_div_table_td" colspan="3"><select name="table_id"
            class="validate[required] select_188_box" id="table_id"
            style="width: 300px;" onchange="changeTable('select')" size="1">
            <option value="">请选择</option>
			<%for(int i=0; i<oaMdTableBeanlist.size(); i++){%>
				<option value="<%= oaMdTableBeanlist.get(i).getTable_id() %>"  code="<%= oaMdTableBeanlist.get(i).getTable_code() %>" 
				  title="<%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>"
				  >
				  <%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>
				</option>
			<% } %>
        </select></td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>流程名生成规则：</th>
        <td class="content_02_box_div_table_td" colspan="3">
        <%-- <input type="text" name="insname_rule"
            class="validate[maxSize[100],required] input_185" id="insname_rule"
            style="width: 300px;" value="<%=StringUtil.deNull(flowInfoBean.getInsname_rule()) %>"
            maxlength="100"/> --%>
            <select class="validate[required] select_188_box"  id="insname_rule"  name="select_insname_rule" style="width: 300px;" onchange="insnameRuleChange(this)"></select>
	        <input class="validate[required] input_185" id="" name="input_insname_rule" style="width:298px; display: none;" title="双击选择字段" value="" ondblclick="insnameRuledbClick(this)"  />
	        &nbsp;
	        <span style="color: red">*注:使用{表名<%=Constant.SEPARATOR %>字段名}的形式流程实例标题</span>
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th">绑定下一流程：</th>
        <td class="content_02_box_div_table_td" colspan="3">
            <%=flowHtml %>
        </td>
    </tr>
    <!-- 附件  -->
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>请上传菜单图片：</th>
        <td class="content_02_box_div_table_td" colspan="3">
         <a href="#" id="_filebut">请选择文件</a>
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>附件列表：</th>
        <td class="content_02_box_div_table_td" colspan="3">
          <ul id="_fileshow"></ul>
        </td>
    </tr>
    <!-- end -->
</table>
</div>
</div>


<table>
    <tr>
        <td height="10px"></td>
    </tr>
</table>
<div class="content_02_box_div_special" style="overflow: hidden;"><!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="flowdefgridTable"></table>
<div id="flowdefgridPager"></div>
</div>
</div>

<table>
    <tr>
        <td height="10px"></td>
    </tr>
</table>
<div class="content_02_box_div_special" style="overflow: hidden;"><!-- 查询列表区 --> <!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="flowwfactiongridTable"></table>
<div id="flowwfactiongridPager"></div>
</div>
<!-- 查询列表区 --></div>
<p>&nbsp;</p>
<input id="jsonparam" name="jsonparam" type="hidden" /></div></div>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 />
</body>
</html>
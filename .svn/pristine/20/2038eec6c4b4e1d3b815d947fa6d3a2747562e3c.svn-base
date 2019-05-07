<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.entity.*"%>
<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page
    import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page
    import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.service.impl.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String path = request.getContextPath();
    String flow_id = request.getParameter("flow_id");
    FlowInfoBean flowInfoBean = new FlowInfoBean();
    FlowInfoDao flowInfodao = (FlowInfoDao) LoadSpringContext
            .getApplicationContext().getBean("flowInfoDaoImpl");
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
            "busitype_code", StringUtil.deNull(flowInfoBean
                    .getBusitype_code()), "", false, "没有可选的业务类型,请添加");//业务类型下拉框
    String type = request.getParameter("type");
    String openwindid = request.getParameter("operwindowid");

    //业务层操作类
    FlowInfoConfigServiceIfc service = new FlowInfoConfigServiceImpl();
    //查询出所有的表单信息
    List<FlowFormBean> formList = service.queryListFlowForm();
        
%>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script
    src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
    
    <script
    src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8">
</script>
<script
    src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript"
    src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript"
    src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
   
<script type="text/javascript">
jQuery(document).ready(function() {
	adaptationWH('_top','vcenter','5');
	judgeshowcflow();
	showAndhide();
	
});
var typetemp ='<%=type%>';
var did=null;
var idss=null;

function showcflow(){
    $("#selectButton").css("display","");
    $("#bindButton").css("display","");
}

function judgeshowcflow(){
    var flowId='<%=StringUtil.deNull(flowInfoBean.getFlow_id())%>';
    if(flowId!=""){
        showcflow();
    }
}


function showAndhide()
{   
    var  typeflag = '<%=type%>';
    if(typeflag == 'flag')
    {
         $('#saveButton').hide();
         $('#bindButton').hide();
         $('#selectButton').hide();
        // $('#restoreButton').hide();
    }
}

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

function saveFlowBaseInfo(){
   document.frame1.window.saveFlowBaseInfo();	
}

function chooseWorkFlow(){
	document.frame1.window.chooseWorkFlow();   	  
}
function saveFlowInfo(){
	document.frame1.window.saveFlowInfo();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body style="overflow-y: hidden;">
<form id="form1" name="form1" method="post" class="formular">
<div class="content_02" style="overflow: hidden;">
<div class="content_02_top"  id="_top">
	<input id="saveButton" name="saveButton" type="button" class="but_y_01"
	    value="保存" onClick="saveFlowBaseInfo();" /> 
	 <input id="selectButton" name="selectButton" class="but_y_01" type="button" value="选择流程"
	    style="display: none" onClick="chooseWorkFlow()" /> 
	<input id="bindButton" name="bindButton" class="but_y_01" type="button"
	    value="绑定" style="display: none" onClick="saveFlowInfo()" /> 
	<input name="copyButton" type="button" class="but_y_01" value="复制" onclick="document.frame1.window.copyFlow()"/>
	<input name="restoreButton" type="button" class="but_y_01" value="返回" onclick="backparent()"/>
</div>
<div id="vcenter" style="float: left; width: 100%; overflow: scroll; overflow-x: hidden;">
    <iframe src="flowinfoconfigdetail4detail.jsp?flow_id=<%=flow_id %>&operwindowid=<%=openwindid %>&type=<%=type %>"
     id="frame1" name="frame1" frameborder="0"  height="800" width="98%" scrolling="no"></iframe>  
</div>

</div>
</form>
</body>
</html>
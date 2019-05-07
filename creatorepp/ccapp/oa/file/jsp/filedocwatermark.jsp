<%--
describe:水印生成、展示、下载页面
author:dailianchun
date: 2013-10-14
--%>
<%--
describe:添加档案时需要的文件列表
author:dailianchun
date: 2013-7-22
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%><html>
<head>
<%
	AccessControl controler = AccessControl.getAccessControl();
	controler.checkAccess(request, response);
	String path = request.getContextPath();
	String id = StringUtil.deNull(request.getParameter("id"));//档案id
	String windowId = StringUtil.deNull(request
			.getParameter("windowId"));
	String f_fondsno = StringUtil.deNull(request
			.getParameter("f_fondsno"));//全宗号
	//传递过来的参数
	FileDocBean bean = new FileDocBean();
	bean = (FileDocBean) RequestBeanUtils.getValuesByRequest(request,
			bean);
	//根据机构id获得机构别名
	String orgNameOther = OrgCache.getOrgCacheBean(StringUtil.deNull(bean.getF_dept_id()))
			.getOrg_name();
	
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/UUID.js" charset="utf-8"></script>


<script type="text/javascript">
var path = "<%=path%>";
var fileId = "<%=id%>"; 
jQuery(function(){
    createWatermark();
});

//关闭弹窗
function closed(){
  removeAlertWindows('<%=windowId%>',true);
}
/**
 * 生成水印
 */
var createWatermark = function() {       
       //ajax方式提交数据
       jQuery.ajax({ 
           type: "post", 
           url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=createWatermark", 
           contentType: "application/x-www-form-urlencoded; charset=utf-8",
           data : {
               "bean.f_fondsno" : "<%=f_fondsno%>",
               "docBean.f_doc_num":descape(escape("<%=bean.getF_doc_num()%>")),
               "docBean.f_doc_year":descape(escape("<%=bean.getF_doc_year()%>")),
               "docBean.f_doc_deadline_name":descape(escape("<%=bean.getF_doc_deadline_name()%>")),
               "docBean.f_dept_name":descape(escape("<%=StringUtil.deNull(orgNameOther)%>"))               
           },
           dataType: "json", 
           success: function (data) {
               if(data){
                   //如果删除成功，刷新数据
                   if(data.flag){
                       jQuery("#vcenter").text("")
                       .html("<img src='"+data.path
                               +"?id="+new UUID().toString()
                               +"' style='margin-top:35px;border:0px;'></img>" );
                       jQuery("#downButton").removeAttr("disabled").click(function(){
                    	   downLoad(data.realPath);
                       });
                    }else{
                         jQuery("#vcenter").text("生成失败"); 
                         jQuery("#downButton").attr("disabled","disabled").unbind("click");                         
                    }
               }
           }, 
           error: function (XMLHttpRequest, textStatus, errorThrown) { 
               alert("系统异常，请稍后再试！");
           }
        });
            
     
    }

/**
 * 下载水印
 */
function downLoad(realPath){
    var url = path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=downLoadWatermark';      
       var html = new Array();
       html.push("<div id='export_excel'>");
       html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
       html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');

       if(realPath){
          html.push("<input type='hidden' name='realPath' value='"+descape(escape(realPath))+"' /> ");
       }
       
       html.push('</form>');
       html.push("</div>");
       //加载到body，提交后再删除
       jQuery(html.join("")).appendTo("body");
       jQuery("#downFrom").submit();
       jQuery("#export_excel").remove();
}
 
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div id="vcenter" style="height:150px;width:100%;vertical-align: middle;" align="center" >
         <span style="margin-top:35px;">正在生成...</span> 
</div>
<div class="cue_box_foot" style="bottom: 0px;position: absolute;text-align: right;">
  <input type="button" class="but_y_01" name="closeButton" id="closeButton" value="关闭" onclick="closed()"/>
  <input type="button" class="but_y_01" name="downButton" id="downButton" value="下载" disabled="disabled"/>
</div>
</body>
</html>
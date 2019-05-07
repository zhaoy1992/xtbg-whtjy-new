<%--
describe: 
author: 
date: 
--%>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperMakeNoticeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataDataService"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperService"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperServiceImpl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.paper.dao.PaperDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String userid=accesscontroler.getUserID();
    UserCacheBean userbean=UserCache.getUserCacheBean(userid);
    String p_manage_id = StringUtil.deNull(request.getParameter("p_manage_id"));
    Map<String, String> bean = new HashMap<String, String>();
    PaperService service=new PaperServiceImpl();
    bean = service.getPaperBeanById(p_manage_id);
    
    Connection conn = null;
	try {
		conn = DbManager.getInstance().getTransactionConnection();
		PaperDao paperDao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
		paperDao.updateReadStatusByUnit(conn,p_manage_id,userbean.getUnit_id());
		paperDao.updateReadStatusByUser(conn,p_manage_id,userbean.getUser_id());
    } catch (Exception e) {
        DbManager. rollBackNoThrow(conn);
    } finally{
         if(conn != null ){
             DbManager. closeConnection(conn);
        }
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
<!-- 引入其它 -->
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
<script type="text/javascript" src="../../resources/plug/jquery-media/jquery.media.js"></script>

<script type="text/javascript">
var p_manage_id = "../../../../uploadDocument/<%=p_manage_id%>.pdf";
/**
 * 关闭弹出框
 */
function tomainjsp(){
    window.location="paperlist4query.jsp";
}
jQuery(function() {
	//初始化插件 
	new controlWordOrPdf({
	 	 //展示插件的节点
	     dom : "#eWebEditor1",
	     //鼠标滚动的相对对象，默认为window,如果是相对于整个document滚动的，可以不传 
	     scrollDom : "#vcenter",  
	     //鼠标滚动到的高度
	     scrollHeight : 252,
	     //滚动缓冲的高度
	     bufferHeight : 20,
	     //插件节点的高度
	     height : getDocumentHeight(55),
	     //插件节点的宽度
	     width : "100%",        
	     //word是否可编辑
	     editAble : true,
	     //展示的文件类型
	     type : "pdf",
	     //展示的文件，word为文件id，pdf为文件名
	     file : p_manage_id 
	});
	
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-100);
});
</script>
</head>
<body>
    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input name="" value="返回" onclick="tomainjsp()" type="button" class="but_y_01" />
        </div>
    </div>
	<div class="content_02_box" id="maindiv" class="vcenter" style="height:480px;width:820px; overflow-y:hidden;overflow-x:hidden;">
		<div class="content_02_box_title_bg" style="width:820px;">
			<span>正文</span>
		</div>
		<div class="content_02_box_title_bg" id="printZW" style="width:820px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><iframe id="eWebEditor1" frameborder="0" scrolling="no"
							width="100%" style="Z-INDEX: 0;" src=""></iframe>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="content_02_box">
		<div class="content_02_box_title_bg">
			<span><font color=red>领导批示：</><%=StringUtil.deNull(bean.get("p_leader_remark"))%></span>
		</div>
	</div>
</body>
</html>
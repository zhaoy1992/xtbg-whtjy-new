<%--
describe:约稿通知信息查看
author:肖杰
date: 2013-09-12
--%>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperMakeNoticeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataDataService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String userid=accesscontroler.getUserID();
    UserCacheBean userbean=UserCache.getUserCacheBean(userid);
    String unit_id=userbean.getUnit_id();
    
    String p_notice_id=request.getParameter("p_notice_id");
    String subid=request.getParameter("subid");
    //资料service
    PaperMakeNoticeService service=new PaperMakeNoticeServiceImpl();   
    Map<String,String> bean = null;
    //如果传入了id，则查询资料信息
    if (!StringUtil.nullOrBlank(p_notice_id)) {
        bean = service.getMakeNoticeBean(p_notice_id);
    }else{
        bean = new HashMap<String,String>();
    }
    String p_send_time=StringUtil.deNull(bean.get("p_send_time"));
    if(!StringUtil.isBlank(p_send_time)){
	    p_send_time=p_send_time.substring(0, p_send_time.length()-3);
    }
    //更新查阅状态
    String type=request.getParameter("type");
    if("receive".equals(type)){
    	String sql="update OA_PAPER_RECEIVE_NOTICE set p_read_status='1' where  p_notice_id='"+p_notice_id+"' and p_receive_unit_id='"+unit_id+"'";
    	PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
    	preparedDBUtil.executeUpdate(sql);
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

<script type="text/javascript">
var id = "<%=p_notice_id%>";

//系统根路径
var path = "<%=path %>";

var subid = "<%=subid %>";
/**
 * 关闭弹出框
 */
function tomainjsp(){
    removeAlertWindows(subid,true);
        
}

</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter','0')">

    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top">
            <input name="" value="返回" onclick="tomainjsp()" type="button" class="but_y_01" />
        </div>
    </div>
    
    <!-- 表格-->
    <div id="vcenter" style="float: center; width: 100%; overflow: scroll"
        scrolling="yes">
        
        <div style="float: center; width: 100%;">
        	
        
        
            <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table"  style="float: center; width: 100%;">
                <tr>
                    <td colspan="2" height="50"
                    style="padding-top:5px;font-weight: bolder;font-size:28px; color:black;text-align:center;">
                        <%=bean.get("p_title") %>                
                    </td>
                </tr>
               <tr>
					<td align="left" width=30% style="text-align: left;padding-left:5px;"><font size=2>约稿时间： <%=p_send_time %></font></td>
					<td align="right"  width=70% style="text-align: right;padding-right:5px;"><font size=2>约稿单位：<%=bean.get("p_unit_name") %></font></td>
				</tr>
				
               <tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>               
              <%--  <tr>
                   <td colspan="2"  class="content_02_box_div_table_td" 
                   style="padding:20px;border:0px;text-align:center;font-weight: 800;font-size:18px">
                       <%=bean.get("d_data_name") %>
                   </td>
               </tr>  --%>
                <%-- <tr>
                   <td colspan="2"  class="content_02_box_div_table_td" 
                   style="height:400px;border:0px;text-align:left;padding:20px 20px 30px 20px;vertical-align: top;">
                       <%=bean.get("p_contents") %>
                   </td>
               </tr>  --%>
               <tr>
                   <td colspan="2" style="padding:20px 20px 20px 20px;"><font size=3 family='FangSong_GB2312'>
                       <%=bean.get("p_contents")%></font>
                   </td>
               </tr> 
            </table>                
        </div>  
    </div>

</body>
</html>
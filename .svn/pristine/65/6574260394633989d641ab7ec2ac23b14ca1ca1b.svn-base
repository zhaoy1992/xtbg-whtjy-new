<%--
describe:资料查看
author:肖杰
date: 2013-08-22
--%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
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
    String d_data_id=request.getParameter("d_data_id");
    //资料service
    DataDataService service = new DataDataServiceImpl();    
    Map<String,String> bean = null;
    //如果传入了id，则查询资料信息
    if (!StringUtil.nullOrBlank(d_data_id)) {
        bean = service.getDataBaseBean(d_data_id);
    }else{
        bean = new HashMap<String,String>();
    }
    
    String rootPath = request.getSession().getServletContext()
		.getRealPath("");
	rootPath = rootPath.replace("\\", "/");
	String tableName = "OA_FILEUPLOAD_KBM";
    String oType="0";
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
<script type="text/javascript" src="../../resources/plug/iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/fileupload.js"   charset="utf-8"></script>

<script type="text/javascript">
var id = "<%=d_data_id%>";
var oType="<%=oType%>";
//附件id
var m_attach_id = "<%=bean.get("d_data_attach") %>";

//系统根路径
var path = "<%=path %>";

jQuery(function(){
    //附件
    //MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, false, m_attach_id,'','',"001");

});
function callajaxUploadFile(){
	//
}
/**
 * 关闭弹出框
 */
function tomainjsp(){
    window.location="finddatabasemain.jsp";
        
}
/**
 * 查看详情
 */
function showDetail(){
	openWindows('databaseinfo','资料查看',"databaseinfo.jsp?type=find&actionName=query&d_data_id="+id,'databaseinfo',false,window);	   
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',1)">

    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input id="showDetail" name="showDetail" value="查看详情" onclick="showDetail();" type="button" class="but_y_01"/>
            <input name="" value="返回" onclick="tomainjsp()" type="button" class="but_y_01" />
        </div>
    </div>
    
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%; overflow: scroll"
        scrolling="yes">
        
        <div style="float: left; width: 775px;">
            <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table">
                <tr>
                    <td colspan="2"  valign="middle" 
                    style="padding-top:5px;font-weight: bolder;font-size:28px; color:black;text-align:center;">
                        <div style="height: auto;word-spacing: 10px;line-height: 35px"><%=bean.get("d_data_name") %></div>                
                    </td>
                </tr>
               <tr>
               <td colspan="2" class="content_02_box_div_table_td"  style="border:0px;">
                    <table>
                    	<tr>
                    		<td align="left" width="230">
			                                                      发布单位： <%=bean.get("d_data_unit_name") %>
                    		</td>
                    		<td align="center" width="270">
			                                                    编号：<%=bean.get("d_data_code") %>
                    		</td>
                    		<td align="right" width="275">
			                                                      发布时间：<%=bean.get("d_data_put_time").subSequence(0, bean.get("d_data_put_time").length()-9) %>
                    		</td>
                    	</tr>
                    </table>                     
               </td>
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
                <tr>
                   <td colspan="2"  class="content_02_box_div_table_td" 
                   style="height:400px;border:0px;text-align:left;padding:20px 20px 30px 20px;vertical-align: top;">
                       <%=bean.get("d_data_content") %>
                   </td>
               </tr> 
               <tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>   
                
                <tr>
					<th class="content_02_box_div_table_th" valign="top">查看附件：</th>
					<td class="content_02_box_div_table_td" colspan=3>
						<input class="but_y_03"  type="button" id="_filebut" value="查看附件" onclick="openuploadlist('<%=path+UploadConstants.WEBPATH %>','<%=tableName%>','<%=bean.get("d_data_attach") %>',oType)"/>
					</td>
				</tr>
            </table>                
        </div>  
    </div>

</body>
</html>
<%-- 
描述：知识库评论信息界面
作者：肖杰
版本：1.0
日期：2013-08-15
 --%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocBbsServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.KbmDocBbsService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String subid1=request.getParameter("subid1");
	String type=request.getParameter("type");
	String path = request.getContextPath();//服务器根路径
	String k_doc_id=StringUtil.deNull(request.getParameter("k_doc_id"));
	String k_title=StringUtil.deNull(request.getParameter("k_title"));
	//String k_doc_id="123";
	//String k_title="测试用";
	String k_create_user=curUserId;
	String k_create_user_name=curUserName;
	String k_create_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	
	//得到该文档所有评阅
	KbmDocBbsService service=new KbmDocBbsServiceImpl();
	List<Map<String,String>> list=service.selectKbmDocBbs(k_doc_id);
%>
<title>知识库评论信息界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">

var path = '<%=path %>';

var subid = '<%=subid %>';
var subid1 = '<%=subid1 %>';
var type = '<%=type %>';
/*
函数:  add
说明:  添加
参数:   无
返回值: 无
*/
var add = function() {
	
	if("checked"==jQuery("#chek_is_guest").attr("checked")){
		jQuery("#k_is_guest").val("1");
	}else{
		jQuery("#k_is_guest").val("0");
	}
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	var url="kbmdocbbsdo.jsp";
	jQuery("#form1").attr("action",url);
	jQuery("#action").val("add");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定提交吗？',p);

}

/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
	var typeurl = 'opentype=query'; 
	var detailjsp = 'kbmdocdetail4query.jsp';
	window.location=getCurrentFilePath()+detailjsp+'?'+typeurl+'&k_doc_id=<%=k_doc_id %>&windowId=updateKbmDocDetailWindow&subid1='+subid1+'&type='+type;
}
</script>

</head>
<body>
<form id="form1" action="" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="k_create_time" id="k_create_time"  value="<%=k_create_time %>" />
<input type="hidden" name="k_create_user" id="k_create_user"  value="<%=k_create_user %>" />
<input type="hidden" name=k_create_user_name id="k_create_user_name"  value="<%=k_create_user_name %>" />
<input type="hidden" name="k_doc_id" id="k_doc_id"  value="<%=k_doc_id %>" />
<input type="hidden" name="k_title" id="k_title"  value="<%=k_title %>" />
<input  type="hidden"  name="k_is_guest" id="k_is_guest" value="" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="fbbt" value="提交" onclick="add();"  type="button" class="but_y_01" /> 
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
		
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div>
	<div class="vcenter" style="float: left; height: 440px;overflow-y: auto;">
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th colspan="1" class="content_02_box_div_table_th">
							<div><span style="float:right;display:block;">匿名发表</span><input style="float:right;display:block;margin:7px 2px 0 2px" type="checkbox"  name="chek_is_guest" id="chek_is_guest"  /></div>
						</th>
						<td colspan="3" class="content_02_box_div_table_td">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">标题：</th>
						<td colspan="3" class="content_02_box_div_table_td">
							<input class="validate[maxSize[200]] input_cx_title_240" style="width: 98%" title="<%=k_title %>" name="k_title" id="k_title" disabled="disabled" value="<%=k_title %>"  />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>评阅内容：</br>(<font style="COLOR: red">100字内</font>)</th>
						<td colspan="3" class="content_02_box_div_table_td">
							<textarea class="validate[required,maxSize[100]] textarea_575" style="width:99%" name="k_content" id="k_content"  ></textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="content_02_box">
			<div class="content_02_box_title_bg" ><span>评论信息（<%=list.size() %>）</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<%if(list.size()>0){
						for(int i=0;i<list.size();i++){
							Map<String,String> bbsbean=list.get(i);
							String name=bbsbean.get("k_create_user_name");
							if("1".equals(bbsbean.get("k_is_guest"))){
								name="匿名";
							}
							%>
					<tr>
						<th class="content_02_box_div_table_th"><%=name%></br><%=bbsbean.get("k_create_time") %></th>
						<td colspan="3" class="content_02_box_div_table_td">
							<textarea class="validate[required,maxSize[200]] textarea_575" style="width:99%" name="k_content" disabled="disabled" id="k_content"  ><%=bbsbean.get("k_content") %></textarea>
						</td>
					</tr>
					<%
						}
					}
					%>
				</table>
			</div>
		</div>
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>
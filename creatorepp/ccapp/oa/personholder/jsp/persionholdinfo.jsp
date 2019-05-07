<%--
describe:持证信息管理界面
author:邱炼
date: 2014-02-21
--%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderUtil"%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderConstants"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personholder.entity.PersonHolder"%>
<%@page import="com.chinacreator.xtbg.core.personholder.service.PersonHolderServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.personholder.service.imp.PersonHolderServiceImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String hold_id = request.getParameter("hold_id");
	//人员用户ID
	String hold_usesnid = request.getParameter("hold_usesnid");
	//
	String windowId = request.getParameter("windowId");
	String attachment_id = "";
	//类型业务
	PersonHolderServiceIfc service = new PersonHolderServiceImpl();
	if("insert".equals(actionName)){
		attachment_id = StringUtil.getUUID();
		//创建日期
		bean.put("creator_time", DateUtil.getCurrentDateTime());
		//人员信息关联表ID
		bean.put("hold_usesnid", hold_usesnid);
		//是否注册
		bean.put("register_flag", "1");
		
		bean.put("attachment_id", attachment_id);
	
	} else {
		bean = service.getPersonHolderBean(hold_id);
		attachment_id = bean.get("attachment_id");
	}
	//人员持证管理员角色
	boolean isROLE = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ROLE_NAME);
	//部室持证管理员
	boolean isPersionRole = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ORG_PERSIONROLE);
	
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">

var windowId = "<%=windowId%>";
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	jQuery("#hold_name").focus();
	MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', true, '<%=attachment_id%>');
	//注册状态
	jQuery("#register_flag option[value='<%=StringUtil.deNull(bean.get("register_flag"))%>']").attr("selected","selected");
	//审批机构
	jQuery("#hold_org option[value='<%=StringUtil.deNull(bean.get("hold_org"))%>']").attr("selected","selected");
	//持证状态
	<%if("院本部".equals(StringUtil.deNull(bean.get("hold_state")))) {%>
		jQuery("#hold_state option[value='ybb']").attr("selected","selected");
	<%}else if("已借出".equals(StringUtil.deNull(bean.get("hold_state")))){%>
		jQuery("#hold_state option[value='yjc']").attr("selected","selected");
	<%}%>
});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if (isFlag){
			jQuery("#hidden_action").val("addInfo");
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
		}
	}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId1").userSearch();
					removeAlertWindows("windowId1",true);
			} else {
				alert(result);
				getParentWindow("windowId1").userSearch();
				removeAlertWindows("windowId1",true);
			}
			
		}
	}catch(e){alert(e.description);}
};

function closed(){
	removeAlertWindows("windowId1",true);
}

</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',1)">
<form id="form1" action="persionholdinfodo.jsp" method="post">
	<input type='hidden' name='action' id="hidden_action"/>
	<input type="hidden" id="attachment_id" name="attachment_id" value="<%=attachment_id%>">
	<input type="hidden" name="hold_id" id="hold_id" value="<%=StringUtil.deNull(bean.get("hold_id"))%>">
	<input type="hidden" name="creator_time" id="creator_time" value="<%=StringUtil.deNull(bean.get("creator_time"))%>">
	<input type="hidden" name="hold_usesnid" id="hold_usesnid" value="<%=StringUtil.deNull(bean.get("hold_usesnid"))%>">
	<div class="content_02" style="overflow: hidden;" id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;">
			<%if(isROLE==true || isPersionRole==true){%>
			<input name="cz_fb_button" id="cz_fb_button" value="保存" onclick="Ok(this.value);"  type="button" class="but_y_01" /> 
			<%}%>
			<input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
		</div>
	</div>
	
	<!-- 表格-->
	<div id="vcenter" style="float: left; width: 100%; overflow: scroll"
	    scrolling="yes">
		<div style="float: left; width: 775px;">
			<div class="content_02_box">
					<table border="0" cellspacing="0" cellpadding="0"
					    class="content_02_box_div_table">
					    <tr>
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>持证项目：
					        </th>
					        <td class="content_02_box_div_table_td" colspan="3">
						        <input type="text" 
						            value="<%=StringUtil.deNull(bean.get("hold_name"))%>" id="hold_name"
						            name="hold_name" class="validate[required,maxSize[50]] input_140" style="width: 555px;" />
					       </td>
					    </tr>
					    <tr>
					    	 <th class="content_02_box_div_table_th">
                                <span class="color_red">*</span>考证机构：
                            </th>
                            <td class="content_02_box_div_table_td">
                            	<!-- 
                           	   <select id="hold_org"
	                                    name="hold_org" class="select_100_box" style="width: 160px;">
		                            <option value="0">国家</option>
		                            <option value="1">省局</option>
		                            <option value="2">中国计量</option>
		                        </select> -->
		                         <input type="text" 
						            value="<%=StringUtil.deNull(bean.get("hold_org"))%>" id="hold_org"
						            name="hold_org" class="validate[required,maxSize[100]] input_160"/>
                            </td>
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>证书编号：
					        </th>
					        <td class="content_02_box_div_table_td">
						         <input type="text" 
                                        value="<%=StringUtil.deNull(bean.get("hold_number"))%>" id="hold_number"
                                        name="hold_number" class="validate[required,maxSize[25]] input_160" />
					        </td>
					    </tr>
					    <tr>
					    	 <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>初次取证日期：
					        </th>
					        <td class="content_02_box_div_table_td">
					       		 <input type="text" name="hold_ratifytime" id="hold_ratifytime" 
									 class="validate[required] date_120 Wdate" style="width: 160px;height :23px;" 
										value="<%=StringUtil.deNull(bean.get("hold_ratifytime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
					        </td>
					        <th valign="top" class="content_02_box_div_table_02_th">
					            <span class="color_red">*</span>有效截止日期：
					        </th>
                            <td class="content_02_box_div_table_02_td">
                                  <input type="text" name="hold_validtime" id="hold_validtime" 
									 class="validate[required] date_120 Wdate" style="width: 160px;height :23px;" 
										value="<%=StringUtil.deNull(bean.get("hold_validtime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                            </td>
					     
					    </tr>
					     <tr>
					     	  <th class="content_02_box_div_table_th">发证日期：</th>
					        <td class="content_02_box_div_table_td">
						        <input type="text" name="hold_replactime" id="hold_replactime" 
									 class="date_120 Wdate" style="width: 160px;height :23px;"  
										value="<%=StringUtil.deNull(bean.get("hold_replactime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						    </td>
					        <th valign="top" class="content_02_box_div_table_02_th">
					            <span class="color_red">*</span>持证级别：
					        </th>
                            <td class="content_02_box_div_table_02_td">
                                <input type="text" 
                                        value="<%=StringUtil.deNull(bean.get("hold_level"))%>" id="hold_level"
                                        name="hold_level" class="validate[required,maxSize[10]] input_160" />
                            </td>
					    </tr>
					     <tr>
					       <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>证书原件存放地：</th>
					        <td class="content_02_box_div_table_td">
					        	 <select id="hold_state"
	                                    name="hold_state" class="validate[required,maxSize[10]] select_100_box" style="width: 160px;">
	                                <option value="ybb">院本部</option>
		                            <option value="yjc">已借出</option>
		                        <!--<option value="ycz">已持证</option>
		                            <option value="dfz">待发证</option>
		                            <option value="ydx">已吊销</option>
		                            <option value="hzz">换证中</option>
		                            <option value="bgz">变更中</option>
		                            <option value="ycq">已超期</option>-->
		                        </select>
						    </td>
					        <th valign="top" class="content_02_box_div_table_02_th">
					            <span class="color_red">*</span>是否注册：
					        </th>
                            <td class="content_02_box_div_table_02_td">
                                <select id="register_flag"
		                                    name="register_flag" size="1" class="select_100_box" style="width: 160px;">
		                            <option value="1">是</option>
		                            <option value="0">否</option>
		                        </select>
                            </td>
					    </tr>
					      <tr>
					       <th class="content_02_box_div_table_th">
					            	备注：</th>
					        <td class="content_02_box_div_table_td" colspan="3">
					        	<textarea style="width:90%;" rows="4" cols="7" name="hold_remark" class="validate[maxSize[500]]"
								id="hold_remark" ><%=StringUtil.deNull(bean.get("hold_remark"))%></textarea>
						    </td>
					    </tr>
					    <tr id="accessory_id">
						<th class="content_02_box_div_table_th">附件：</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<a href="#" id="_filebut">请选择文件</a>
						</td>
					  </tr>
					  <tr>
					  <th class="content_02_box_div_table_th">附件列表：</th>
						<td class="content_02_box_div_table_td" colspan="5"><ul id="_fileshow"></ul></td>
					  </tr>
					</table>
			</div>
		</div>  
	</div>
</form>
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
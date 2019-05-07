<%--
　　描述：设置活动环节扩展信息操作页面
　　作者：黄海
　　版本：1.0
　　日期：2013-05-28
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@ page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@ page import="com.chinacreator.eform.util.Escape"%>
<%@ page import="com.chinacreator.xtbg.core.process.processconfig.entity.ActTextStatusBean"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String actionId = request.getParameter("actionId");//活动id
//特检院OA 中文乱码问题
String action_name = DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("action_name")));//活动名称

FlowInfoDao flowInfodao = (FlowInfoDao)LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
ActTextStatusBean model = flowInfodao.findActTextStatusBeanById(actionId);
String extendAttribute = StringUtil.deNull(model.getExtend_attribute());
String extendMethods   = StringUtil.deNull(model.getExtend_methods());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>配置流程活动正文状态</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
/*
函数:  convertTo01
说明:  选择框checked属性为true时返回1，否则 返回0
作者：  黄海
日期： 2013-05-31
参数:  obj 选择框对象
返回值: 1或0
*/
var convertTo01 = function(obj){
	if (obj.attr("checked")){
		return 1;
	}
	return 0;
}
/*
函数:  saveActTextStatusForm
说明:  提交组装好的json格式的表单数据至后台
作者：  黄海
日期：  2013-05-31
参数:  无
返回值: 相关alert提示
*/
var saveActTextStatusForm = function() {
	var url = "saveacttextstatusform.jsp";
	var asynFunc = function(){
		var jsonparam = "{'id':'"+$("#id").val()+"'," +
						"'action_id':'" +$("#actionId").val()+"',"+
						"'is_trace':'"   +convertTo01($("#is_trace"))+"',"+
						"'is_red':'"     +convertTo01($("#is_red"))+"',"+
						"'is_readonly':'"+convertTo01($("#is_readonly"))+"',"+
						//"'extend_attribute':'"+$("#extend_attribute").val()+"',"+
						"'msg_txt':'"+$("#msg_txt").val()+"',"+
						"'is_msg':'"+convertTo01($("#is_msg"))+"',"+
						"'is_sign':'"+convertTo01($("#is_sign"))+"',"+
						"'is_keeptrace':'"+convertTo01($("#is_keeptrace"))+"',"+
						"'is_attachment':'"+convertTo01($("#is_attachment"))+"',"+
						"'is_gwzl':'"+convertTo01($("#is_gwzl"))+"',"+
						"'is_ckcg':'"+convertTo01($("#is_ckcg"))+"',"+
						"'is_ckzw':'"+convertTo01($("#is_ckzw"))+"',"+
						"'is_ckmq':'"+convertTo01($("#is_ckmq"))+"',"+
						"'is_singname':'"+convertTo01($("#is_singname"))+"',"+
						"'is_affix':'"+convertTo01($("#is_affix"))+"',"+
						"'remark1':'"+convertTo01($("#remark1"))+"',"+
						"'is_xd':'"+convertTo01($("#is_xd"))+"',"+
						"'is_gwff':'"+convertTo01($("#is_gwff"))+"',"+
						"'is_cd':'"+convertTo01($("#is_cd"))+"',"+
						"'is_cklc':'"+convertTo01($("#is_cklc"))+"',"+
						"'is_newflow':'"+convertTo01($("#is_newflow"))+"',"+
						"'is_gk':'"+convertTo01($("#is_gk"))+"',"+
						"'is_print':'"+convertTo01($("#is_print"))+"',"+
						"'is_split':'"+convertTo01($("#is_split"))+"',"+
						//"'is_infotype':'"+convertTo01($("#is_infotype"))+"',"+
						"'is_nbfs':'"+convertTo01($("#is_nbfs"))+"',"+
						"'is_doback':'"+convertTo01($("#is_doback"))+"',"+
						"'is_chief':'"+convertTo01($("#is_chief"))+"',"+
						"'is_ckls':'"+convertTo01($("#is_ckls"))+"',"+
						"'is_sm':'"+convertTo01($("#is_sm"))+"',"+
						"'is_serialnumber':'"+convertTo01($("#is_serialnumber"))+"'}";
						//"'extend_methods':'"+$("#extend_methods").val()+"'}"
		var params =  {jsonparam : descape(escape(jsonparam))};
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			async : false, 
			success: function(data){
				alert("操作成功。");
				window.location.reload();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("操作成功。");
				window.location.reload();
			}
		});	
	}
	asynFunc();
}
</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',40)" >
<button id=button4 class="but_y_01" onclick="saveActTextStatusForm()">保存</button>
<button id=button8 class="but_y_01" onclick="removeAlertWindows('',true)">关闭</button>
<form action="saveacttextstatusform.jsp" id="form1" name="form1" method="post">
<input id="jsonparam" name="jsonparam" type="hidden"/>
<input type="hidden" id="actionId" value="<%=actionId %>" />
<input type="hidden" id="id" value="<%=model.getId() %>" />
<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>活动名称：<%=action_name%></span>
	 </div>
	 <div class="content_02_box_div">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
	        <tr>
	            <th class="content_02_box_div_table_th">显示痕迹：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_trace" name="is_trace" value="<%=model.getIs_trace() %>" <%="1".equals(model.getIs_trace())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">保留痕迹：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_keeptrace" name="is_keeptrace" value="<%=model.getIs_keeptrace() %>" <%="1".equals(model.getIs_keeptrace())?"checked":"" %>/>
	            </td>
	            <th class="content_02_box_div_table_th">套红：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_red" name="is_red" value="<%=model.getIs_red() %>" <%="1".equals(model.getIs_red())?"checked":"" %> />
	            </td>
	           
	        </tr>
	         <tr>
	            <th class="content_02_box_div_table_th">只读：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_readonly" name="is_readonly" value="<%=model.getIs_readonly() %>" <%="1".equals(model.getIs_readonly())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">签字：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_sign" name="is_sign" value="<%=model.getIs_sign() %>" <%="1".equals(model.getIs_sign())?"checked":"" %>/>
	            </td>
	            <th class="content_02_box_div_table_th">处理附件：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_attachment" name="is_attachment" value="<%=model.getIs_attachment() %>" <%="1".equals(model.getIs_attachment())?"checked":"" %>/>
	            </td>
	        </tr>
	        <tr>
	            <th class="content_02_box_div_table_th">整理：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_gwzl" name="is_gwzl" value="<%=model.getIs_gwzl() %>" <%="1".equals(model.getIs_gwzl())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">查看草稿：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_ckcg" name="is_ckcg" value="<%=model.getIs_ckcg() %>" <%="1".equals(model.getIs_ckcg())?"checked":"" %>/>
	            </td>
	            <th class="content_02_box_div_table_th">查看正文：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_ckzw" name="is_ckzw" value="<%=model.getIs_ckzw() %>" <%="1".equals(model.getIs_ckzw())?"checked":"" %>/>
	            </td>
	        </tr>
	          <tr>
	           <th class="content_02_box_div_table_th">查看流程：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_cklc" name="is_cklc" value="<%=model.getIs_cklc() %>" <%="1".equals(model.getIs_cklc())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">查看面签：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_ckmq" name="is_ckmq" value="<%=model.getIs_readonly() %>" <%="1".equals(model.getIs_ckmq())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">盖章：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_affix" name="is_affix" value="<%=model.getIs_attachment() %>" <%="1".equals(model.getIs_affix())?"checked":"" %>/>
	            </td>
	        </tr>
	        <tr>
	            <th class="content_02_box_div_table_th">信息公开：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_gk" name="is_gk" value="<%=model.getIs_gk() %>" <%="1".equals(model.getIs_gk())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">编号：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_serialnumber" name="is_serialnumber" value="<%=model.getIs_serialnumber() %>" <%="1".equals(model.getIs_serialnumber())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">校对：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_xd" name="is_xd" value="<%=model.getIs_xd() %>" <%="1".equals(model.getIs_xd())?"checked":"" %> />
	            </td>
	        </tr>
	        <tr>
	            <th class="content_02_box_div_table_th">外部分发：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_gwff" name="is_gwff" value="<%=model.getIs_gwff() %>" <%="1".equals(model.getIs_gwff())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">内部分送：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_nbfs" name="is_nbfs" value="<%=model.getIs_nbfs() %>" <%="1".equals(model.getIs_nbfs())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">发起新的流程：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_newflow" name="is_newflow" value="<%=model.getIs_newflow() %>" <%="1".equals(model.getIs_newflow())?"checked":"" %> />
	            </td>
	        </tr>
	        <tr>
	        	 <th class="content_02_box_div_table_th">签名：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_singname" name="is_singname" value="<%=model.getIs_singname() %>" <%="1".equals(model.getIs_singname())?"checked":"" %>/>
	            </td>
	             <th class="content_02_box_div_table_th">打印：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_print" name="is_print" value="<%=model.getIs_print() %>" <%="1".equals(model.getIs_print())?"checked":"" %>/>
	            </td>
	            <th class="content_02_box_div_table_th">存档：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_cd" name="is_cd" value="<%=model.getIs_cd() %>" <%="1".equals(model.getIs_cd())?"checked":"" %> />
	            </td>
	            <!--
	            --><!--
	             <th class="content_02_box_div_table_th">发送短信：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_msg" name="is_msg" value="<%=model.getIs_msg() %>" <%="1".equals(model.getIs_msg())?"checked":"" %> />
	            </td>
	        --></tr>
	        <tr>
	            <%-- <th class="content_02_box_div_table_th">信息分类：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_infotype" name="is_infotype" value="<%=model.getIs_infotype() %>" <%="1".equals(model.getIs_infotype())?"checked":"" %> />
	            </td> --%>
	            <th class="content_02_box_div_table_th">回退：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_doback" name="is_doback" value="<%=model.getIs_doback() %>" <%="1".equals(model.getIs_doback())?"checked":"" %> />
	            </td>
	             <th class="content_02_box_div_table_th">督办：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_chief" name="is_chief" value="<%=model.getIs_chief() %>" <%="1".equals(model.getIs_chief())?"checked":"" %> />
	            </td>
	            <th class="content_02_box_div_table_th">查看历史：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_ckls" name="is_ckls" value="<%=model.getIs_ckls() %>" <%="1".equals(model.getIs_ckls())?"checked":"" %> />
	            </td>
	        </tr>
	        <tr>
	            <th class="content_02_box_div_table_th">拆分指标文：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_split" name="is_split" value="<%=model.getIs_split() %>" <%="1".equals(model.getIs_split())?"checked":"" %>/>
	            </td>
	            <th class="content_02_box_div_table_th">扫描仪：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	                <input type="checkbox" id="is_sm" name="is_sm" value="<%=model.getIs_sm() %>" <%="1".equals(model.getIs_sm())?"checked":"" %>/>
	            </td>
	             <th valign="top" class="content_02_box_div_table_02_th">终止流程：</th>
	            <td  class="content_02_box_div_table_td" style="text-align: center;">
	           		 <input type="checkbox" id="remark1" name="remark1" value="<%=model.getRemark1() %>" <%="1".equals(model.getRemark1())?"checked":"" %>/>
	            </td>
	        </tr>
	        <!-- 
	         <tr>
	            <th valign="top" class="content_02_box_div_table_02_th">扩展属性</th>
	            <td colSpan="6" class="content_02_box_div_table_02_td">
	                <textarea class="textarea_575" id="extend_attribute" name="extend_attribute" style="width:99%;height: 40px; margin:2px 0 2px; ">//extendAttribute </textarea>
	            </td>
	        </tr>
	        <tr>
	            <th valign="top" class="content_02_box_div_table_02_th">扩展方法</th>
	            <td colSpan="6" class="content_02_box_div_table_02_td">
	                <textarea class="textarea_575" id="extend_methods" name="extend_methods" style="width:99%;height: 40px; margin:2px 0 2px; "> extendMethods </textarea> 
	            </td>
	        </tr> -->
	        <tr style="height: 30px">
	        </tr>
	        <tr>
	            <th valign="top" class="content_02_box_div_table_02_th">短信内容配置：</th>
	            <td colSpan="6" class="content_02_box_div_table_02_td">
	                <textarea class="textarea_575" id="msg_txt" name="msg_txt" style="width:99%;height: 40px; margin:2px 0 2px; "><%=StringUtil.deNull(model.getMsg_txt()) %></textarea> 
	            </td>
	        </tr>
	    </table>
	</div>
</div>
</form>
</body>
</html>
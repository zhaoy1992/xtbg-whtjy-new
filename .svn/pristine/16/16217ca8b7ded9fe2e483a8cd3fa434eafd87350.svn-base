<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String selectedField = FusionUtil.getParameterString(request,"selectedField");
String[] sfields = selectedField.split("\\^");

Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"));

if(sessionChartPMap == null){
	sessionChartPMap = new HashMap();
}

pageContext.setAttribute("path",path);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>drillDown_script.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body>
    <table width="100%" border="0" cellspacing="0" cellpadding="2">
    	<tr>
	    	<td >
	    	<%
	    			for(int i=0;i<sfields.length;i++){
	    				
	    				String sfieldsName = sfields[i];

	    				String functionName = sessionChartPMap.get("fusion_drilldown.script.functionName."+sfieldsName);
	    				functionName = functionName == null?"":functionName;
	    				
		    			String isParamValue = sessionChartPMap.get("fusion_drilldown.script.paramValue."+sfieldsName);
		    			
		    			String p1Value = "";
		    			String p2Value = "";
		    			String p3Value = "";
		    			
		    			if(isParamValue!=null){
		    				String[] pvalueArray = isParamValue.split("\\^");
		    				int len = pvalueArray.length;
		    				if(len == 1){
		    					p1Value = pvalueArray[0];    					
		    				}else if(len == 2){
		    					p1Value = pvalueArray[0]; 
		    					p2Value = pvalueArray[1];
		    				}else if(len == 3){
		    					p1Value = pvalueArray[0]; 
		    					p2Value = pvalueArray[1];
		    					p3Value = pvalueArray[2];
		    				}
		    			}
	    		%>
			<div id="fieldUrl" style="border: dotted;border-width: 1px;border-color: #cccccc" >
					<table width="90%" border="0" cellpadding="1" cellspacing="0">
					<tr>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;字段&nbsp;<%=sfieldsName%>&nbsp;调用脚本：</td>
						<td nowrap="nowrap" align="left"><input type="text" name="j_fusion_drilldown.script.functionName.<%=sfieldsName %>" size="50" value="<%=functionName %>"></td>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;是否添加参数：</td>
						<td nowrap="nowrap" align="left">
						
						<input type="radio" name="isParam-<%=sfieldsName%>" value="0" <%=StringUtils.isBlank(isParamValue)?"checked":""%> onClick="disableParam('param-<%=sfieldsName%>')" />否
						<input type="radio" name="isParam-<%=sfieldsName%>" value="1" <%=StringUtils.isBlank(isParamValue)?"":"checked"%> onClick="enableParam('param-<%=sfieldsName%>')" />是
						</td>
						<td width="50%"></td>
					</tr>
					<tr id="param-<%=sfieldsName%>" <%=StringUtils.isBlank(isParamValue)?"style='display: none'":""%> >
						<td colspan="5">&nbsp;&nbsp;
	    					参数值1：<select name="j_fusion_drilldown.script.paramValue.<%=sfieldsName %>.1" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p1Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p1Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p1Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  </select>&nbsp;&nbsp;
	    					参数值2：<select name="j_fusion_drilldown.script.paramValue.<%=sfieldsName %>.2" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p2Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p2Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p2Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  </select>&nbsp;&nbsp;
	    					参数值3：<select name="j_fusion_drilldown.script.paramValue.<%=sfieldsName %>.3" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p3Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p3Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p3Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p3Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p3Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  </select>
						</td>
					</tr>
					
					</table>
				</div>
				<%
						
				if(i!=sfields.length-1){
						out.print("<br>");
						}
	    			}
				%>
				<!-- 
				
				
				<div id="fieldUrl" style="border: dotted;border-width: 1px;border-color: #cccccc" >
					<table width="90%" border="0" cellpadding="1" cellspacing="0">
					<tr>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;字段2调用脚本：</td>
						<td nowrap="nowrap" align="left"><input type="text" name="linkUrl-field1" size="50"></td>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;是否添加参数：</td>
						<td nowrap="nowrap" align="left">
						<input type="radio" name="isParam-field2" value="0" checked onClick="disableParam('param-field2')" />否
						<input type="radio" name="isParam-field2" value="1" onClick="enableParam('param-field2')" />是
						</td>
						<td width="50%"></td>
					</tr>
					<tr id="param-field2" style="display: none">
						<td colspan="5">&nbsp;&nbsp;
							参数值1：<select name="paramValue1" style="width:65px">
								<option value="0">请选择</option>
								<option value="category">字段名称</option>
								<option value="seriesName">显示名称</option>
								<option value="fieldValue">数据信息</option>
							  </select>&nbsp;&nbsp;
							参数值2：<select name="paramValue2" style="width:65px">
								<option value="0">请选择</option>
								<option value="category">字段名称</option>
								<option value="seriesName">显示名称</option>
								<option value="fieldValue">数据信息</option>
							  </select>&nbsp;&nbsp;
							参数值3：<select name="paramValue3" style="width:65px">
								<option value="0">请选择</option>
								<option value="category">字段名称</option>
								<option value="seriesName">显示名称</option>
								<option value="fieldValue">数据信息</option>
							  </select>
						</td>
					</tr>
					
					</table>
				</div>
				 -->
			</td>
    	</tr>
    		    
	</table>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"));
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String selectedField = FusionUtil.getParameterString(request,"selectedField");
String[] sfields = selectedField.split("\\^");
if(sessionChartPMap == null){
	sessionChartPMap = new HashMap();
}
pageContext.setAttribute("path",path);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>drillDown_frame.html</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr><td align="right" nowrap="nowrap">&nbsp;&nbsp;&nbsp;Frame名称：</td>
			<td nowrap="nowrap" align="left" width="100%">&nbsp;&nbsp;<input type="text" name="f_fusion_drilldown.frameName" value="<%=sessionChartPMap.get("fusion_drilldown.frameName")==null?"":sessionChartPMap.get("fusion_drilldown.frameName") %>"></td></tr>
		<tr><td style="height:4px"></td></tr>
    	<tr><td colspan="2">
	    		<%
	    			for(int i=0;i<sfields.length;i++){
	    				
	    				String sfieldsName = sfields[i];
		    			String urlLink = sessionChartPMap.get("fusion_drilldown.linkUrl."+sfieldsName);
		    			urlLink = StringUtils.isBlank(urlLink)?"":urlLink;
		    			String isParamName = sessionChartPMap.get("fusion_drilldown.paramName."+sfieldsName);
		    			String isParamValue = sessionChartPMap.get("fusion_drilldown.paramValue."+sfieldsName);
		    			//name 为name1^name2 value 为{-fieldName}^{-seriesName}
		    			String p1Name = "";
		    			String p2Name = "";
		    			String p3Name = "";
		    			
		    			String p1Value = "";
		    			String p2Value = "";
		    			String p3Value = "";
		    			
		    			if(isParamName!=null){
		    				String[] pnameArray = isParamName.split("\\^");
		    				int len = pnameArray.length;
		    				if(len == 1){
		    					p1Name = pnameArray[0];    					
		    				}else if(len == 2){
		    					p1Name = pnameArray[0]; 
		    					p2Name = pnameArray[1];
		    				}else if(len == 3){
		    					p1Name = pnameArray[0]; 
		    					p2Name = pnameArray[1];
		    					p3Name = pnameArray[2];
		    				}
		    			}
		    			
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
				<div id="fieldUrl" style="border: dotted;border-width: 1px;border-color: #cccccc; overflow:auto" >
					<table width="90%" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;字段&nbsp;<%=sfieldsName%>&nbsp;地址：</td>
						<td nowrap="nowrap" align="left"><input type="text" name="f_fusion_drilldown.linkUrl.<%=sfieldsName %>" value="<%=urlLink %>" size="50"></td>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;是否添加参数：</td>
						<td nowrap="nowrap" align="left">
							<input type="radio" name="isParam-<%=sfieldsName%>" value="0" <%=StringUtils.isBlank(isParamName)?"checked":""%> onClick="disableParam('param-<%=sfieldsName%>')" />否
							<input type="radio" name="isParam-<%=sfieldsName%>" value="1" <%=StringUtils.isBlank(isParamName)?"":"checked"%> onClick="enableParam('param-<%=sfieldsName%>')" />是
						</td>
						<td width="90%"></td>
					</tr>
					<tr id="param-<%=sfieldsName%>" <%=StringUtils.isBlank(isParamName)?"style='display: none'":""%>>
						<td colspan="5">&nbsp;&nbsp;
							参数名1：<input type="text" name="f_fusion_drilldown.paramName.<%=sfieldsName %>.1" value="<%=p1Name%>" size="6">&nbsp;
	    					参数值1：<select name="f_fusion_drilldown.paramValue.<%=sfieldsName %>.1" style="width:80px">
								<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p1Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p1Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p1Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  </select>&nbsp;&nbsp;
							 参数名2：<input type="text" name="f_fusion_drilldown.paramName.<%=sfieldsName %>.2" value="<%=p2Name%>" size="6">&nbsp;
	    					参数值2：<select name="f_fusion_drilldown.paramValue.<%=sfieldsName %>.2" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p2Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p2Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p2Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  </select>&nbsp;&nbsp;
							参数名3：<input type="text" name="f_fusion_drilldown.paramName.<%=sfieldsName %>.3" value="<%=p3Name%>" size="6">&nbsp;
	    					参数值3：<select name="f_fusion_drilldown.paramValue.<%=sfieldsName %>.3" style="width:80px">
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
			</td>
    	</tr>
    	<tr>
			<td colspan="2" style="height:4px"></td>
		</tr>
    </table>
  </body>
</html>

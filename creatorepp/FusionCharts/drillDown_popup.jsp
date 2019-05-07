<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();

Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"));

if(sessionChartPMap == null){
	sessionChartPMap = new HashMap();
}

pageContext.setAttribute(FusionStaticField.PROPERTIES_STRING,sessionChartPMap);

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String selectedField = FusionUtil.getParameterString(request,"selectedField");
String[] sfields = selectedField.split("\\^");

pageContext.setAttribute("path",path);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>drillDown_link.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body>
   <table width="100%" border="0" cellspacing="0" cellpadding="2">
    	<tr>
	    	<td colspan="7">
	    	
	    	
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
				<div id="fieldUrl" style="border: dotted;border-width: 1px;border-color: #cccccc" >
					<table width="90%" border="0" cellpadding="1" cellspacing="0">
					<tr>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;字段&nbsp;<%=sfieldsName%>&nbsp;地址：</td>
						<td nowrap="nowrap" align="left"><input type="text" name="p_fusion_drilldown.linkUrl.<%=sfieldsName %>" size="50" value=<%=urlLink %>></td>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;是否添加参数：</td>
						<td nowrap="nowrap" align="left">
						<input type="radio" name="isParam-<%=sfieldsName%>" value="0" <%=StringUtils.isBlank(isParamName)?"checked":""%> onClick="disableParam('param-<%=sfieldsName %>')" />否
						<input type="radio" name="isParam-<%=sfieldsName%>" value="1" <%=StringUtils.isBlank(isParamName)?"":"checked"%> onClick="enableParam('param-<%=sfieldsName %>')" />是
						</td>
						<td width="50%"></td>
					</tr>
					<tr id="param-<%=sfieldsName %>" <%=StringUtils.isBlank(isParamName)?"style='display: none'":""%>>
						<td colspan="5">&nbsp;&nbsp;
							参数名1：<input type="text" name="p_fusion_drilldown.paramName.<%=sfieldsName %>.1" size="6" value="<%=p1Name %>">&nbsp;
	    					参数值1：<select name="p_fusion_drilldown.paramValue.<%=sfieldsName %>.1" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p1Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p1Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p1Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p1Value)?"selected=\"selected\"":"" %>>数据信息</option>
							  		</select>&nbsp;&nbsp;
							 参数名2：<input type="text" name="p_fusion_drilldown.paramName.<%=sfieldsName %>.2" size="6" value="<%=p2Name %>">&nbsp;
	    					参数值2：<select name="p_fusion_drilldown.paramValue.<%=sfieldsName %>.2" style="width:80px">
										<option value="<%=FusionStaticField.P_NULL %>" <%=StringUtils.isBlank(p2Value)?"selected=\"selected\"":"" %>>请选择</option>
										<option value="<%=FusionStaticField.P_CATEGORYVALUE %>" <%=FusionStaticField.P_CATEGORYVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>行头数据</option>
										<option value="<%=FusionStaticField.P_FIELDNAME %>" <%=FusionStaticField.P_FIELDNAME.equals(p2Value)?"selected=\"selected\"":"" %>>字段名称</option>
										<option value="<%=FusionStaticField.P_SERIESNAME %>" <%=FusionStaticField.P_SERIESNAME.equals(p2Value)?"selected=\"selected\"":"" %>>显示名称</option>
										<option value="<%=FusionStaticField.P_FIELDVALUE %>" <%=FusionStaticField.P_FIELDVALUE.equals(p2Value)?"selected=\"selected\"":"" %>>数据信息</option>
							 		 </select>&nbsp;&nbsp;
							参数名3：<input type="text" name="p_fusion_drilldown.paramName.<%=sfieldsName %>.3" size="6">&nbsp;
	    					参数值3：<select name="p_fusion_drilldown.paramValue.<%=sfieldsName %>.3" style="width:80px">
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
				<br>
				<%
						if(i!=sfields.length-1){
							out.print("<br>");
						}
	    			}
				%>
				<!-- 
				
				
				<div id="fieldUrl" style="border: dotted;border-width: 1px;border-color: #cccccc" >
					<table width="90%" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;字段2地址：</td>
						<td nowrap="nowrap" align="left"><input type="text" name="linkUrl-field1" size="50" /></td>
						<td nowrap="nowrap" align="right">&nbsp;&nbsp;是否添加参数：</td>
						<td nowrap="nowrap" align="left">
						<input type="radio"  name="isParam-field2" value="0" checked onClick="disableParam('param-field2')" />否
						<input type="radio"  name="isParam-field2" value="1" onClick="enableParam('param-field2')" />是
						</td>
						<td width="60%"></td>
					</tr>
					<tr id="param-field2" style="display: none">
						<td colspan="5">&nbsp;&nbsp;
							参数名1：<input type="text" name="paramName1" size="6">&nbsp;
	    					参数值1：<select name="paramValue1" style="width:80px">
								<option value="0">请选择</option>
								<option value="category">字段名称</option>
								<option value="seriesName">显示名称</option>
								<option value="fieldValue">数据信息</option>
							  </select>&nbsp;&nbsp;
							 参数名2：<input type="text" name="paramName1" size="6">&nbsp;
	    					参数值2：<select name="paramValue2" style="width:80px">
								<option value="0">请选择</option>
								<option value="category">字段名称</option>
								<option value="seriesName">显示名称</option>
								<option value="fieldValue">数据信息</option>
							  </select>&nbsp;&nbsp;
							参数名3：<input type="text" name="paramName1" size="6">&nbsp;
	    					参数值3：<select name="paramValue3" style="width:80px">
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
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
    	<tr>
    		<td align="right" nowrap>
	    	弹出窗口是否全屏：
	    	</td>
	    	<td align="left" nowrap colspan="6">
		    	<input type="radio" name="p_fusion_drilldown.popup.fullscreen" value="0" ${pstr['fusion_drilldown.popup.fullscreen'] ne '1' ?'checked':''}  onclick="enableInfo()">否
		    	<input type="radio" name="p_fusion_drilldown.popup.fullscreen" value="1" ${pstr['fusion_drilldown.popup.fullscreen'] eq '1' ?'checked':''} onClick="disableInfo()">是
	    	</td>
	    <tr>
    	<tr id="pageInfo" style="display:  ">
	    	<td colspan="7">页面高度：<input type="text" name="p_fusion_drilldown.popup.height" size="6" value="${pstr['fusion_drilldown.popup.height']}">&nbsp;&nbsp;
	    	页面宽度：<input type="text" name="p_fusion_drilldown.popup.width" size="6" value="${pstr['fusion_drilldown.popup.width']}">&nbsp;&nbsp;
	    	页面左边位置：<input type="text" name="p_fusion_drilldown.popup.left" size="6" value="${pstr['fusion_drilldown.popup.left']}">&nbsp;&nbsp;
	    	页面顶部位置：<input type="text" name="p_fusion_drilldown.popup.right" size="6" value="${pstr['fusion_drilldown.popup.right']}">
	    	</td>
    	</tr>
    	<tr>
        	<td colspan="7" height="1" background="./images/line_dot.gif"></td>
         </tr>
    	<tr valign="bottom">
	    	<td align="right" nowrap>
	    	大小是否可改变：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.resizable" value="0" ${pstr['fusion_drilldown.popup.resizable'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.resizable" value="1" ${pstr['fusion_drilldown.popup.resizable'] eq '1' ?'checked':''} >是&nbsp;&nbsp;
	    	</td>
	    	<td align="right" nowrap>
	    	&nbsp;&nbsp;&nbsp;&nbsp;是否有滚动条：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.scrollbars" value="0" ${pstr['fusion_drilldown.popup.scrollbars'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.scrollbars" value="1" ${pstr['fusion_drilldown.popup.scrollbars'] eq '1' ?'checked':''}>是
	    	</td>
	    	<td align="right" nowrap>
	    	&nbsp;&nbsp;&nbsp;&nbsp;是否地有址栏：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.location" value="0" ${pstr['fusion_drilldown.popup.location'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.location" value="1" ${pstr['fusion_drilldown.popup.location'] eq '1' ?'checked':''}>是&nbsp;&nbsp;
	    	</td>
	    	<td width=50%>&nbsp;</td>
    	</tr>
    	<tr valign="bottom">
	    	<td align="right" nowrap>
	    	是否有菜单栏：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.menubar" value="0" ${pstr['fusion_drilldown.popup.menubar'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.menubar" value="1" ${pstr['fusion_drilldown.popup.menubar'] eq '1' ?'checked':''}>是&nbsp;&nbsp;
	    	</td>
	    	<td align="right" nowrap>
	    	&nbsp;&nbsp;&nbsp;&nbsp;是否有工具栏：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.toolbar" value="0" ${pstr['fusion_drilldown.popup.toolbar'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.toolbar" value="1" ${pstr['fusion_drilldown.popup.toolbar'] eq '1' ?'checked':''}>是
	    	</td>
	    	<td align="right" nowrap>
	    	&nbsp;&nbsp;&nbsp;&nbsp;是否有状态栏：
	    	</td>
	    	<td align="left" nowrap>
		    	<input type="radio" name="p_fusion_drilldown.popup.status" value="0" ${pstr['fusion_drilldown.popup.status'] ne '1' ?'checked':''}>否
		    	<input type="radio" name="p_fusion_drilldown.popup.status" value="1" ${pstr['fusion_drilldown.popup.status'] eq '1' ?'checked':''}>是
	    	</td>
	    	<td width=50%>&nbsp;</td>
    	</tr>
    </table>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.util.TemplateInfo"%>
<%@page import="com.chinacreator.fusionchart.util.TemplateType"%>
<%@page import="com.chinacreator.fusionchart.util.ChartModel"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String modelType = request.getParameter("modelType");
if(modelType==null) modelType = "single";
if(modelType.equals("multi"))modelType = "ms";   		
System.out.println("--------modetype:"+modelType);

String modelCode = FusionUtil.getParameterString(request,"modelCode");
if(modelCode==null) modelCode = "Column2D";
   		
System.out.println("--------modecode:"+modelCode);
Map<String,TemplateType> modelMAP = TemplateInfo.getTemplateMAP();

String chart_only_id = request.getParameter("chart_only_id");
%>
    <script type="text/javascript" src="<%=path %>/FusionCharts/jquery-1.3.min.js"></script>
 	<script type="text/javascript" src="<%=path %>/FusionCharts/jquery.form.js"></script> 
<p id="modelList"> 
  <table width="100%"   border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td >
		<!-- 模板类别选择标签页 Begin-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<% 
          	Set<String> codeSet=modelMAP.keySet();
          	String[] codeAry = codeSet.toArray(new String[0]);
          	for(int i=0;i<codeAry.length;i++)
          	{
          		TemplateType type = modelMAP.get(codeAry[i]);
          		if(type.getTemplateCode().toLowerCase().equals(modelType.toLowerCase()))
          		{
          	%>
          	<td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7"><img src="<%=path %>/FusionCharts/styles/images/picture_08.gif" width="7" height="26" /></td>
                <td nowrap="nowrap" class="table_btn_on"><strong><%=type.getTemplateName() %></strong></td>
                <td><img src="<%=path %>/FusionCharts/styles/images/picture_11.gif" width="6" height="26" /></td>
				<td width="100%">&nbsp;</td>
              </tr>
            </table></td>
          	<%	
          		}
          		else
          		{
          		%>
          		<td ><table width="99%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="8"><img src="<%=path %>/FusionCharts/styles/images/picture_03.gif" width="8" height="26" /></td>
                <td width="116" class="table_btn_off" nowrap="nowrap">
                	<a href="javascript:changeType('<%=type.getTemplateCode() %>')"><%=type.getTemplateName() %></a>
                </td>
                <td width="8"><img src="<%=path %>/FusionCharts/styles/images/picture_06.gif" width="8" height="26" /></td>
				<td width="100%">&nbsp;</td>
              </tr>
            </table></td>
          		<%
          		}
          	}
          	%>
            <td width="80%">&nbsp;</td>
          </tr>
        </table>
		<!-- 模板类别选择标签页 End-->
		</td>
      </tr>
      <tr>
        <td class="blue_table">
        
        	<table width="98%" border="0" cellpadding="2" cellspacing="0">
   <% 
   		TemplateType showType = modelMAP.get(modelType);
   		List<ChartModel> modelList = showType.getModles();
   		Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"));
   		String sessionSelectType = sessionChartPMap==null?null:(sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.CHART_MODELNAME)==null?null:(String)sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.CHART_MODELNAME));
   		int k=0;
   		for(int i=0;i<modelList.size();i++)
   		{
   			k++;
   			ChartModel model = modelList.get(i);
   			String checked = "";
   			if(model.getModelCode().toLowerCase().equals(modelCode.toLowerCase()))
   				{
   					checked = sessionSelectType==null?"checked":sessionSelectType.equals(model.getModelCode())?"checked":"";
   				}
   			else
   				{
   					checked = sessionSelectType==null?"":sessionSelectType.equals(model.getModelCode())?"checked":"";
   				}
   			if(k%3==1) out.println("<tr>");
   		%>
   			<td align="center">
   				<img src="<%=path %>/FusionCharts/IMG_Model/<%=model.getModelCode() %>.gif" border="0" ><br>
   			<label onMouseover="this.style.cursor='pointer'">
				<input type="radio" id="chart_modelname<%=i %>" name="chart_modelname" value="<%=model.getModelCode() %>"  <%=checked %> onclick="javascript:changeModel();" /><%=model.getModelName() %>
   			</label>
			</td>
   		<%	
   			if(k%3==0) out.println("</tr>");
   		}
   		
   %>
   
   </table>
  
        </td>
      </tr>
    </table>
    <script language="javascript">
    var paramStr='';
    $(function(){
    <%
   		for(int i=0;i<modelList.size();i++)
   		{
   			ChartModel model = modelList.get(i);
   	%>
   		
		  $("#chart_modelname<%=i %>").click(function(){  
		  	selectModel(paramStr);
		  }); 
		  
   	<%
   		}
    %>  
    });
     </script>  
</p>

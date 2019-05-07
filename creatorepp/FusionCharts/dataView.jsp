<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="com.chinacreator.fusionchart.model.DataModel"%>
<%@page import="com.chinacreator.fusionchart.model.SqlDataModel"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.model.XmlDataModel"%>
<%@page import="java.net.URL"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String sql = request.getParameter("sql");
String chart_only_id = request.getParameter("chart_only_id");
String dataurl = FusionUtil.getParameterString(request,"dataurl");
String isuseurl = FusionUtil.getParameterString(request,"isuseurl");

String fields = request.getParameter("fields");
DataModel datamodle = null;

if("1".equals(isuseurl)){ //使用url数据源
	datamodle = new XmlDataModel(new URL(FusionUtil.getDetailURL(request,dataurl)));
}else{
	datamodle =	new SqlDataModel(sql,null,fields.split("\\$"));
}
Map<String,List<String>> data = datamodle.getData();
int showSize = Math.max(datamodle.rowCount(),10);
//保存到session 预览数据时需要用到
session.setAttribute(FusionStaticField.SESSION_DATA,datamodle);
pageContext.setAttribute("path",path);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>数据预览</title>
    
<style type="text/css">
<!--
.STYLE1 {color: #336600}
-->
</style>
</head>
<script>
	//选取的字段
	var allfiled='';
	//是否选取了行头
	var hasLineHead=0;
	//是否选取了数据列
	var hasFiled=0;
	function checkData()
	{
		//return true; //FIXME
		var models =  document.getElementsByName('chart_modelname');
			  var boo = false;
			  for(var i=0;i<models.length;i++){
			  	boo = boo || models[i].checked;
			  }
		if(!boo){
			  	alert('你未选择任何模板');
			  	return false;
		}
			  
		hasLineHead=0;
		hasFiled=0;
		//先检查是否选择了数据
		checkselectData();
		if(hasFiled==1)
		{
			//然后检查是否选择了正确的行头
			checkLineHead();
		}
		if(hasLineHead==1)
			return true;
		else
			return false;
	}
	
function change()
{
	var td_ary = document.all["aab"];
	for(var   i=0;i <td_ary.length;i++)
	{ 
   if(td_ary[i].style.display=="none")
		td_ary[i].style.display="";
	else
		td_ary[i].style.display="none";
	}
}

//检查是否选择了行头
function checkLineHead()
{
	
	var ra = document.all["ra"];
	var v_checked = 0;
	var checkvalue='';
	for(var i=0;i<ra.length;i++)
	{
		if(ra[i].checked)
		{
			v_checked=1;
			checkvalue=ra[i].value;
			break;
		}
	}
	if(v_checked==0)
	  alert('请选择行头');
	else
	{
		//判断行头是否包含已选了的列
		if(allfiled.indexOf(checkvalue)==-1)
		{
			//alert('ok');
			hasLineHead=1;
		}
		else
		{
			alert('行头和所选的数据列不能重复');
			hasLineHead=0;
		}
	}
}

//检查是否选了1个以上的数据
function checkselectData()
{
	
	var ra = document.all["chec"];
	var v_checked = 0;
	allfiled='';
	for(var i=0;i<ra.length;i++)
	{
		if(ra[i].checked)
		{
			v_checked++;
			allfiled=allfiled+ra[i].value;
		}
	}
	if(v_checked<1)
	  alert('请选择至少一列数据');
	else
	{
		hasFiled=1;
	}
}

//展示或隐藏数据设置div
function showdataset(){
	return;
	$("#datasetview").slideToggle(
		function(){
			if($(this).is(":hidden")){
				//alert('hiddd');
			}else{
				//alert('nnnn');
			}
		}
	);
}
</script>
  <body>
<table width="100%" border="0" style="height:3">
<tr>

<td id="hhhh"><div id="datasetview"></div></td>

</tr>
</table>
<table width="98%" border="0" cellpadding="1" cellspacing="1" bgcolor="#d0d0d0" style="margin-bottom:10px">
			        <tr>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead">字段名称</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead">选择列</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead">选择行头</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead" colspan="<%=showSize %>" width=100%></td>
			          
			        </tr>
			        
			        
			        <%
			        
			        Map<String,String> sessionChartPMap = (Map<String,String>)session.getAttribute(FusionStaticField.PROPERTIES_STRING+chart_only_id);
			        
			        String linehead = null;
			        String selectLine = null;
			        
			        if(sessionChartPMap==null){
			        	linehead = datamodle.getFieldsName()[0];
			        	selectLine = datamodle.getFieldsName()[1];
			        }else{
			        	
			        	linehead =  sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.MODEL_LINEHEAD);
			        	selectLine = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.MODEL_SELECTED_FIELD);
			        }
			        for(int i=0;i<datamodle.getFieldsName().length;i++){
			        	String headcheck = "";
			        	String select = "";
			        	if(sessionChartPMap==null){
			        	  if(i==0){
			        		  headcheck = "checked";
			        	  }
			        	  else if(i==1){
			        		  select = "checked";
			        	  }
			        	}else{
			        	 headcheck = datamodle.getFieldsName()[i].equals(linehead)?"checked":"";
			        	 select= datamodle.getFieldsName()[i].equals(selectLine)?"checked":"";
			        		
			        	}
									        	
			        %>
			        <tr>
			          <td bgcolor="#FFFFFF" class="tablehead">&nbsp;&nbsp;<%=datamodle.getFieldsName()[i] %></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead" style="width:40" nowrap><input type="radio" name="chart_selectfileds" id="chec" value="<%=datamodle.getFieldsName()[i] %>"  onclick="changeSelected()"  <%=select %>/></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead" style="width:40" nowrap><input type="radio" name="chart_linefiled" value="<%=datamodle.getFieldsName()[i] %>" id="ra" <%=headcheck %>/></td>
			          
			          <%
			          List<String> listdata = data.get(datamodle.getFieldsName()[i]);
			          for(String value : listdata){
			          %>
			          <td align="right" bgcolor="#FFFFFF" class="tablenum"><%=value%></td>
			          <%
			          }
			          %>
			        </tr>
			       <%
			       }
			       %>
      		</table>
  </body>
</html>

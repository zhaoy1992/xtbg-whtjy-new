<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.model.DataModel"%>
<%@page import="com.chinacreator.fusionchart.model.XmlDataModel"%>
<%@page import="java.net.URL"%>
<%@page import="com.chinacreator.fusionchart.model.SqlDataModel"%>
<%@page import="com.chinacreator.fusionchart.util.UIShow"%>
<%
try{
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//String modeltype = request.getParameter("modeltype");
String chart_only_id = request.getParameter("chart_only_id");
Map<String,String> sessionChartPMap = (Map<String,String>)session.getAttribute(FusionStaticField.PROPERTIES_STRING+chart_only_id);
String modelcode = request.getParameter("modelcode");
String sessionmodelcode = null;
if(sessionChartPMap!=null){
sessionmodelcode = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION + FusionStaticField.CHART_MODELNAME);
}
if(sessionmodelcode!=null){
	if(!sessionmodelcode.equals(modelcode)){
		modelcode = sessionmodelcode;
	}
}

String dataurl = FusionUtil.getParameterString(request,"dataurl");
String isuseurl = FusionUtil.getParameterString(request,"isuseurl");
UIShow uiShow = UIShow.showMe(modelcode);
//String style = FusionUtil.checkHave2Y(modelcode)?"":"display: none";

System.out.println(uiShow);
String axisStyle = "";//对应纵坐标
String renderStyle = "";//显示类型
String collectDataStyle = "";//对应数据集

axisStyle = uiShow.isVertical()?"":"display: none";
renderStyle = uiShow.isShowType()?"":"display: none";
collectDataStyle = uiShow.isDatasetType()?"":"display: none";;

pageContext.setAttribute("path",path);
pageContext.setAttribute("axisStyle",axisStyle);
pageContext.setAttribute("renderStyle",renderStyle);
pageContext.setAttribute("collectDataStyle",collectDataStyle);

String sql = request.getParameter("sql");
String fields = request.getParameter("fields");
DataModel datamodle = null;

if("1".equals(isuseurl)){ //使用url数据源
	datamodle = new XmlDataModel(new URL(FusionUtil.getDetailURL(request,dataurl)));
}else{
	datamodle =	new SqlDataModel(sql,null,fields.split("\\$"));
}
Map<String,List<String>> data = datamodle.getData();
int showSize = Math.max(datamodle.rowCount(),10);
int totalFieldsNameLength = 0;
//保存到session 预览数据时需要用到
session.setAttribute(FusionStaticField.SESSION_DATA,datamodle);

String[] fs = datamodle.getFieldsName(); //所具有的所有列，除去一行为行头，其余为可能出现最多的分组数
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
	<script type="text/javascript" src="${path}/FusionCharts/jquery-1.3.min.js"></script>
	<script type="text/javascript" src="${path}/FusionCharts/jquery.form.js"></script>
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

//检查是否选了2个以上的数据
function checkselectData()
{
	
	var ra = document.all["chec"];
	var v_checked = 0;
	var allfiled='';
	for(var i=0;i<ra.length;i++)
	{
		if(ra[i].checked)
		{
			v_checked++;
			allfiled=allfiled+ra[i].value;
		}
	}
	if(v_checked<1){
	  alert('请选择至少一列数据');
	  }
	else
	{
		hasFiled=1;
	}
}

</script>
  <body >
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
			          <td align="center" bgcolor="#e8e8e8" class="tablehead">显示名称</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead" id="combineDY" name="combineDY" style="display: none">对应纵坐标</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead" id="combine" name="combine" style="display: none">显示图形</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead" id="combineST" name="combineST" style="display: none">对应数据集</td>
			          <td align="center" bgcolor="#e8e8e8" class="tablehead" colspan="<%=showSize %>" width=100%></td>
			          
			        </tr>
			        
			        
			        <%
			        String datasetRenderAs = null;
					String datasetParentYAxis= null;
			        if(sessionChartPMap!=null){
			        datasetRenderAs = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+"dataset.renderAs");
			        datasetParentYAxis = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+"dataset.parentYAxis");
			        }
					
					Map<String,String> renderAsMap = null;
					Map<String,String> parentYAxisMap = null;
					if(!StringUtils.isBlank(datasetRenderAs)){
						renderAsMap = FusionUtil.splitStringToMap(datasetRenderAs);
						parentYAxisMap = FusionUtil.splitStringToMap(datasetParentYAxis);
					}
			        
			        String linehead = null;
			        String selectLine = null;
			        String selectLineAlias = null;
			        String[] selectLineArrays = null;
			        String[] selectLineAliasArrays = null;
			        
			        if(sessionChartPMap==null){
			        	linehead = datamodle.getFieldsName()[0];
			        	selectLine = datamodle.getFieldsName()[1];
			        }else{
			        	
			        	linehead =  sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.MODEL_LINEHEAD);
			        	selectLine = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.DATASET_FILED);
			        	selectLineAlias = sessionChartPMap.get(FusionStaticField.REQUEST_FUSION+FusionStaticField.DATASET_SERIESNAME);
			        	
			        	//selectLine 还可能为空
			        	if(selectLine!=null){
				        	selectLineArrays = selectLine.split("\\^");
				        	selectLineAliasArrays = selectLineAlias.split("\\^");
			        	}
			        	
			        }
			        
			        totalFieldsNameLength = datamodle.getFieldsName().length;
			        for(int i=0;i<totalFieldsNameLength;i++){
			        	String headcheck = "";
			        	String select = "";
			        	
			        	String aliasName = "";
			        	if(sessionChartPMap==null){
			        	  if(i==0){
			        		  headcheck = "checked";
			        	  }
			        	  else if(i==1){
			        		  select = "checked";
			        	  }
			        	}else{
			        	 headcheck = datamodle.getFieldsName()[i].equals(linehead)?"checked":"";
			        	 
			        	 if(selectLineArrays!=null){
			        		 for(int j=0;j<selectLineArrays.length;j++){
					        	 select= datamodle.getFieldsName()[i].equals(selectLineArrays[j])?"checked":"";
					        	 if("checked".equals(select)){
					        	  aliasName = selectLineAliasArrays[j] == null?"":selectLineAliasArrays[j];	 
					        	  break;
					        	 }
				        	 } 
			        	 }
			        	 
			        		
			        	}
			        	
						String fieldname = datamodle.getFieldsName()[i];		
						
						String p = "";
						String s = "";
						String l = "";
						String a = "";
						
						String y = "";
						String r = "";
						if(parentYAxisMap!=null){
							String ps = parentYAxisMap.get(fieldname);
							if(ps!=null){
								p = ps.equals("P")?"selected='selected'":"";
								s = ps.equals("S")?"selected='selected'":"";
							}else{
								y = "selected";
							}
							
							String la = renderAsMap.get(fieldname);
							if(ps!=null){
								if(la!=null){
									l = la.equals("Line")?"selected='selected'":"";
									a = la.equals("Area")?"selected='selected'":"";
								}else{
									r = "selected";
								}
							}
							
							
						}
						
			        %>
			        <tr>
			          <td bgcolor="#FFFFFF" class="tablehead">&nbsp;&nbsp;<%=fieldname %></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead" style="width:40" nowrap><input type="checkbox" name="fieldselected_<%=fieldname %>"  id="chec" value="<%=fieldname %>" <%=select %> onclick="changeSelected()"  class='noclass'/></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead" style="width:40" nowrap><input type="radio" name="chart_linefiled" value="<%=fieldname %>" id="ra" <%=headcheck %> /></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablenum"><input type="text" size=10 value="<%=aliasName %>" name="fieldAlias_<%=fieldname %>" ></td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead" id="combineDY" name="combineDY" style="${axisStyle}">
			          	<select name="dataset.parentYAxis_<%=i %>">
			          		<option value='' <%=y %>>默认纵坐标</option>
			          		<option value='<%=fieldname %>-P' <%=p %>>左边纵坐标</option>
			          		<option value='<%=fieldname %>-S' <%=s %>>右边纵坐标</option>
			          	</select>
			          </td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead"  id="combine" name="combine" style="${renderStyle}">
			          	<select name="dataset.renderAs_<%=i %>">
			          		<option value='' <%=r %>>默认图形</option>
			          		<option value='<%=fieldname %>-Line' <%=l %>>折线图</option>
			          		<option value='<%=fieldname %>-Area' <%=a %>>区域图</option>
			          	</select>
			          </td>
			          <td align="center" bgcolor="#FFFFFF" class="tablehead"  id="combineST" name="combineST" style="${collectDataStyle}">
			          	<select name="collectData_<%=fieldname %>">
			          	    <%
			          	    	
			      				int group = fs.length -1;
			          	    	if(group > 0){
			          	    		for(int j=0;j<group;j++){
			          	    %>
			          	    		<option value='<%=(j+1)%>'>数据集<%=(j+1)%></option>
			          	    <%
			          	    		}
			          	    	}
			          	    %>
			          	</select>
			          </td>
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
			        }catch(Exception e){
			        	out.println("数据预览出现错误:"+e.getMessage());
			        	e.printStackTrace();
			        }
			       %>
      		</table>
      		
      		<input id="msflag" value="1" type="hidden"/>
      		<form id="selectedfield" name="selectedfield" action="" >
      			<input type="hidden" name="selectedFieldNames" id="selectedFieldNames" value=""/>
      		</form>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.util.ChartViewBean"%>
<%@page import="com.chinacreator.fusionchart.util.ModelsDataBase"%>
<%@page import="org.apache.commons.lang.math.NumberUtils"%>
<%@page import="com.chinacreator.fusionchart.util.PageInfo"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%

	String path = request.getContextPath();
	String pageindexstr = request.getParameter("pageindex");
	String type = request.getParameter("type");
	int pageindex = NumberUtils.toInt(pageindexstr,0);
	PageInfo pageinfo = (new ModelsDataBase()).selectByPage(pageindex,type); 
	List<ChartViewBean> fusionlist = pageinfo.getData();
	String[] alltype = FusionUtil.getAllType();
	pageContext.setAttribute("pageinfo",pageinfo);
	pageContext.setAttribute("path",path);
	pageContext.setAttribute("type",type);
%>
	<script type="text/javascript">
	<!--
	function doblock(idname){
		var   xMax  =   screen.width;   
     	var   yMax  =   screen.height;
     	var modelw = xMax/1.5;
     	var modelh = yMax/2;
   	 	var dialogLeft  =(xMax - modelw)/2;
   	 	var dialogTop = (yMax - modelh)/4;   
   	 	window.showModalDialog('preview.jsp?idname='+idname,null,'dialogWidth='+modelw+'px;dialogHeight='+modelh+'px;dialogLeft='+dialogLeft+';dialogTop='+dialogTop);   
	}
	
	function pageme(){
		window.location.href='';
	}
	//-->
	</script>
	
							<select id="ctype" onchange="onselect();">
							<option value="all">全部</option>
							<%
							for(int j = 0;j < alltype.length;j++){
							%>
								<option value="<%=alltype[j] %>"><%=alltype[j] %> 类型</option>
							<%} %>
							</select>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="border: 0px;" >
						
						<tr>
							<td width="60%" bgcolor="#FFFFFF">
							
								<table width="98%" border="0" cellspacing="0" cellpadding="0"
									class="table_height">
									<tbody id="datatable">
									<tr class="table_thead">
										<td width="10%" class="right_line">
											选择
										</td>
										<td width="25%">
											图形主题
										</td>
										<td width="25%" align="center">
											预览
										</td>
									</tr>
									<%
										for(int i=0;i<fusionlist.size();i++){
									%>
									<tr>
									<td class='line_s2'><input type="radio" value="<%=fusionlist.get(i).getId() %>" name="idname"/></td>
									<td class='line_s2'><%=fusionlist.get(i).getId() %></td>
									<td class='line_s2' align="center"><img src="styles/images/pic_16.gif" alt="预览" style="cursor:hand" onclick="doblock('<%=fusionlist.get(i).getId()%>');"/></td>
									</tr>
									<%}%>
									</tbody>
								</table>
							</td>
							<td width="16%" bgcolor="#FFFFFF" class="space_10">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="table_right">
									<tr>
										<td>
											<p>
												<img src="styles/images/dian.gif" width="8" height="8" />
												说明:
											</p>
											<p>
												选择一个已经存在的属性模板
											</p>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
			<br/>		
<table width="50%" border="0" cellspacing="0" cellpadding="0"	style="border: 0px;" align="center">
<tr>
<td>
<img src="styles/images/pic_03.gif" alt="首页" style="cursor:hand" onclick="reloadTab2('0','${type}');"/>
&nbsp;&nbsp;
</td>
<td>
<%
if(pageindex > 0){
%>
<img src="styles/images/pic_05.gif" alt="上页" style="cursor:hand" onclick="reloadTab2('${pageinfo.currentPage-1}','${type}');"/>
<%
}else{
%>
<img src="styles/images/pic_05.gif" alt="上页" />
<%} %>
&nbsp;&nbsp;
</td>
<td>
<%
if(pageindex < pageinfo.getTotalPage()){
%>
<img src="styles/images/pic_07.gif" alt="下页" style="cursor:hand" onclick="reloadTab2('${pageinfo.currentPage+1}','${type}');"/>
<%}else{ %>
<img src="styles/images/pic_07.gif" alt="下页"/>
<%}%>
&nbsp;&nbsp;
</td>
<td>
<img src="styles/images/pic_09.gif" alt="尾页" style="cursor:hand" onclick="reloadTab2('${pageinfo.totalPage}','${type}');"/>
</td>
<td align="right">第${pageinfo.currentPage}页 &nbsp; 共${pageinfo.totalPage}页 &nbsp; ${pageinfo.totalCount}条记录 </td>
</tr>
</table>
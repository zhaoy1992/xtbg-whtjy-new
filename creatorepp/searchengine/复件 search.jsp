<%@page contentType="text/html;charset=GBK"%>
<%@page import = "com.chinacreator.lucene.*,com.chinacreator.lucene.search.*,com.chinacreator.lucene.util.*" %>
<%@page import = "java.util.List,java.util.Date" %>
<%@page import = "org.apache.commons.lang.math.NumberUtils, org.apache.commons.lang.StringUtils" %>
<%@page import="org.frameworkset.spi.ApplicationContext"%>
<%@page import="com.chinacreator.epp.util.AppIdThreadLocal"%>
<%
	String queryStr = request.getParameter("querystr");
	//queryStr = new String(queryStr.getBytes("ISO-8859-1"),"GBK");

	if(queryStr==null || "".equals(queryStr)){
		response.sendRedirect("advancesearch.jsp");
	}
	int startPage = NumberUtils.toInt(request.getParameter("start"), 1);
	int pageSize = NumberUtils.toInt(request.getParameter("pagesize"), 10); 
	Long sizeMin = NumberUtils.toLong(request.getParameter("sizemin"), 0);
	Long sizeMax = NumberUtils.toLong(request.getParameter("sizemax"), 0);
	String dateFrom = request.getParameter("datefrom");//.replaceAll("-","");
	String dateTo = request.getParameter("dateto");//.replaceAll("-","");
	System.out.println(dateFrom);
	System.out.println(dateTo);
	
	Date modifiedFrom = DateUtil.parse(dateFrom);
	Date modifiedTo =DateUtil.parse(dateTo);
	String fileTypes = request.getParameter("filetypes");
	String fields = request.getParameter("fields");
	
	
	SearchOptions opts = new SearchOptions();
	opts.setFields(fields.split(SearchOptions.Separate));
	if(sizeMax>sizeMin){
		opts.setDocSizeMin(sizeMin);
		opts.setDocSizeMax(sizeMax);
	}
	if(StringUtils.isNotEmpty(fileTypes)){
		opts.setDocTypes(fileTypes);
	}
	if(dateFrom!=null){
		opts.setModifiedDateFrom(modifiedFrom);
	}
	if(dateTo!=null){
		opts.setModifiedDateTo(modifiedTo);
	}
	opts.setQueryStr(queryStr);
	opts.setAppId(AppIdThreadLocal.get());//这里要获取当前系统的应用ID
	
	Searcher search = new Searcher();
	
	List<SearchResult> results = search.search(opts);
	int resultTotal = results.size();
%>
<html>
<head>
	<title>搜索结果</title>
	<script language="javascript">
		function $(id){
			return document.getElementById(id);
		}
		function toPage(pageno){
			$("start").value = pageno;
			$("searchForm").submit();		
		}
		function toNextPage(){
			var currentPage = parseInt($("start").value)+1;
			toPage(currentPage);
		}
	</script>
	<style>
		.docName{
			font-size:16px;
			color:blue;
		}
		.docSummary{
			font-size:13px;
		}
		.docOthers{
			font-size:13px;
			color:green
		}
		*{
			font-size:13px;
		}
	</style>
</head>
<body>
<div style="width:100%;text-align:right">
   符合条件的结果共有<%=resultTotal %>个  共花费<%=search.getExecuteTime() %>毫秒
</div>
<div id="resultList">
	<% 
		int start = (startPage-1)*pageSize; 
		for(int i=start;i<start+pageSize&&i<resultTotal;i++){ 
			SearchResult result = results.get(i); 
	 %>
	 	<div>
	 		<div class="docName"><a href="javascript:void(0)"><%=result.getDocName() %></a></div>
	 		<div class="docSummary"><%=result.getSummary() %></div>
	 		<div class="docOthers">文件大小：<%=result.getDocSize() %>kb 创建人：<%=result.getDocCreator() %></div>
	 	</div>
	 <%}%>
</div>
<div style="width:100%;text-align:left;">
<%
	int totalPage = resultTotal / pageSize + (resultTotal % pageSize>0? 1: 0);
	for(int i=1;i<=totalPage;i++){
		if(startPage!=i){
			out.print("<a href=\"javascript:toPage('"+i+"')\">["+i+"]</a>&nbsp;&nbsp;");
		}else{
			out.print(i+"&nbsp;&nbsp;");
		}
	}
 %>
 <%if(totalPage>1 && startPage<totalPage){ %>
 	<a href="javascript:toNextPage()">下一页</a>
 <%} %>
 </div>
 <!-- 翻页查询表单 -->
 	<form action="search.jsp" method="post" name="searchForm">
		<input type="hidden" name="querystr" value="<%=queryStr %>"/>
		<input type="hidden" name="pagesize" value="<%=pageSize %>"/>
		<input type="hidden" name="start" value="<%=startPage %>"/>
		<input type="hidden" name="sizemin" value="<%=sizeMin %>"/>
		<input type="hidden" name="sizemax" value="<%=sizeMax %>"/>
		<input type="hidden" name="datefrom" value="<%=dateFrom %>"/>
		<input type="hidden" name="dateto" value="<%=dateTo %>"/>
		<input type="hidden" name="filetypes" value="<%=fileTypes %>"/>
		<input type="hidden" name="fields" value="<%=fields %>"/>
	</form>
</body>
</html>
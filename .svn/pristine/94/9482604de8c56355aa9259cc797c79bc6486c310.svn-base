
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.list.ShowAllViews"%>
<%@page import="com.chinacreator.xtbg.core.dssave.entity.ViewListBean"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowViewDaoImpl"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
	FlowViewDaoImpl dao = new FlowViewDaoImpl();
	List<ViewListBean> list = dao.getViewListForShow(request);
	TreeSet<String> user = new TreeSet<String>();
	TreeSet<String> action = new TreeSet<String>();
	for(ViewListBean bean:list){
		user.add(bean.getUser_name());
		action.add(bean.getAction_name());
	}
	StringBuffer userStr = new StringBuffer();
	int code = 0;
	if(user.size()>1){
		userStr.append("['','--人员--']");
		for(String u:user){
			userStr.append(",['"+u+"','"+u+"']");
		}
		code +=1;
	}
	
	StringBuffer actionStr = new StringBuffer();
	if(action.size()>1){
		actionStr.append("['','--环节--']");
		for(String u:action){
			actionStr.append(",['"+u+"','"+u+"']");
		}
		code +=2;
	}
	StringBuffer html = new StringBuffer();
	switch(code){
	case  1:
		html.append("filterNames:['user_name'],");
		html.append("filterOptions:[["+userStr+"]],");
		html.append("filterOptionsDefValue:[0],");
		break;
	case  2:
		html.append("filterNames:['action_name'],");
		html.append("filterOptions:[["+actionStr+"]],");
		html.append("filterOptionsDefValue:[0],");
		break;
	case  3:
		html.append("filterNames:['user_name','action_name'],");
		html.append("filterOptions:[["+userStr+"],["+actionStr+"]],");
		html.append("filterOptionsDefValue:[0],");
		break;
	}
	System.out.println(html);
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"></script>
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	
	<script type="text/javascript" charset="utf-8" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
	
	<script type="text/javascript" charset="utf-8" src="<%=path%>/ccapp/oa/resources/util/public.js"></script>
	<script type="text/javascript">
	$(function(){
		jQuery("#gridTable").jqGrid({
	        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.flowprocessing.list.ShowAllViews', 
	        datatype : "json",
	        mtype : "POST",
	        height : "100%",
	        autowidth : true,
	        colModel : [
	        {
				label : "viewlist_id",
	            name : 'viewlist_id',
	            index : 'viewlist_id',
	            hidden : true
	        },{
	        	label : "用户",
	        	width:20,
	            name : 'user_name',
	            index: 'user_name'
	        }, {
	            label: "环节",
	            name : 'action_name',
	            index: 'action_name',
	            width:25
	        }, {
	            label: "时间",
	            name : 'hander_time',
	            index: 'hander_time',
	            width:30
	        }, {
	            label: "意见",
	            name : 'action_handeridea',
	            index: 'action_handeridea',
	            width:60
	        }
	        ],
	        sortname : 'hander_time',
	        sortorder : 'desc',
	        viewrecords : true,
	        rowNum : 10,
	        rowList : [ 10, 20, 30 ],
	        jsonReader : {
	            repeatitems : false
	        },
	        pagerintoolbar:true,
	        pagerinBottombar:true,
	        search : toUserParamJosn(),
	        prmNames : {
	            rows : "rows",
	            sort : "sidx",
	            order : "sord",
	            search : "search"
	        },
	        multiselect : false,
	        <%=html.toString()%>
	        onCellSelect:function (id,icol)
			{
			}
		});
	});
	
	var toUserParamJosn = function(){
		var str = "{";
		str += "'ins_id':'<%=request.getParameter("insid")%>',"
		str += "'table_name':'<%=request.getParameter("table")%>',"
		str += "'column_name':'<%=request.getParameter("column")%>'"
        str += "}";
        return descape(escape(str));
	};
	</script>
</head>
<body>
<%--
<textarea readonly='readonly' style='border:1;width:90%; height: 90%; overflow: auto;display:block;margin-top:4px;' >
<%for(ViewListBean bean : list){
	
	out.print(bean.getAction_handeridea());
	out.print("\n");
}%></textarea>
--%>
<div class="cGridArea">
	<table id="gridTable"></table>
	<div id="gridPager"></div>
</div>
</body>
</html>
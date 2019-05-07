<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VotePaperBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteOptionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>
<%-- 
描述：在线投票统计页面
作者：shuqi.liu
版本：1.0
日期：2013-05-13
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
	String paperId = request.getParameter("paperId");//问卷ID
	String uesr_id = accesscontroler.getUserID();
	String windowId=request.getParameter("windowId");
	VotePaperBean votePaperBean = new VotePaperBean();
	VoteViewService voteViewService = new VoteViewServiceImpl();
	votePaperBean = voteViewService.getPaperTotalInfo(paperId,uesr_id);
	List<VoteQuestionBean> voteQuestionBeanList = votePaperBean.getVoteQuestionBeanList();
%>	
<title><%=votePaperBean.getTitle()%></title>
<script src="" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
    <!-- 打印需要导入的内容、方法 -->
<script language="javascript"
    src="../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA"
    width=0 height=0> <!-- 是专为 FireFox 浏览器设计的代码  --> <embed
        id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
        ></embed>
</object>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/juan.css" />
<script type="text/javascript">
function changeChart(chartType,id){
	if(chartType=="column"){//如果是切换为柱状图
		$("#column_"+id).show();
		$("#table_"+id).hide();
		$("#pie_"+id).hide();
	}else if(chartType=="pie"){//如果是切换为饼状图
		$("#pie_"+id).show();
		$("#table_"+id).hide();
		$("#column_"+id).hide();
	}else{
		$("#table_"+id).show();
		$("#column_"+id).hide();
		$("#pie_"+id).hide();
	}
}

//返回
function closed(){
   removeWindows('<%=windowId%>',true);
}  
</script>
</head>
<body>
<div id="printpart">
<table width="70%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
      <tr>
        <td height="32" class="juan_top"><%=votePaperBean.getTitle()%></td>
      </tr>
      <tr>
        <td height="40" class="juan_biao">发起部门：<%= votePaperBean.getOrg_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发起人：<%=votePaperBean.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;问卷说明：<%=votePaperBean.getDirection()%></td>
      </tr>
      <tr>
        <td class="juan_kuang">
        <%int i=1;
          DecimalFormat format = new DecimalFormat("#0.0");
		  for(VoteQuestionBean voteQuestionBean:voteQuestionBeanList){%>
		  	<!-- 表格统计 -->
		 	<div id ="table_<%= voteQuestionBean.getId()%>">
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td>
			 <table width="100%" border="0" cellspacing="1" cellpadding="0" class="ceshi">
			 <tr>
                <td height="33" colspan="3" class="ce_ti"><%= i%>：<%= voteQuestionBean.getTitle() %> </td>
			 </tr>
			 <tr>
                <td width="30%" height="30" class="ce_shou">选项</td>
                <td width="15%" class="ce_shou">小计</td>
                <td width="55%" class="ce_shou">图形比例</td>
              </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){
					double baifenbi = ((Double.parseDouble(voteOptionBean.getSelectCount())/Double.parseDouble("0".equals(voteQuestionBean.getAnswerCount())?"1":voteQuestionBean.getAnswerCount()))*100);
				 	String baifenbiStr = format.format(baifenbi).toString(); %>
				 <tr>
				 <td height="<%= 160/voteQuestionBean.getVoteOptionBeanList().size()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
				 <td><div class="jindutiao"><div class="bianse" style="width:<%= baifenbiStr%>%"></div></div>&nbsp;&nbsp;<%= baifenbiStr%>%</td>		 
				</tr>
				 <%}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ 
				 	double baifenbi = ((Double.parseDouble(voteOptionBean.getSelectCount())/Double.parseDouble("0".equals(voteQuestionBean.getAnswerCount())?"1":voteQuestionBean.getAnswerCount()))*100);
				 	String baifenbiStr = format.format(baifenbi).toString();  %>
				 <tr>
				 <td height="40"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
                 <td><div class="jindutiao"><div class="bianse" style="width:<%= baifenbiStr%>%"></div></div>&nbsp;&nbsp;<%= baifenbiStr%>%</td>				 
				 </tr>
				 <%}%>
			 <% }//else{%>
				<!--  <tr>
				 <td height="31" class="tou_xuan">
				 	<textarea class="tou_wen"  name="<%=voteQuestionBean.getId()%>"></textarea>
				 </td>
				 </tr>
			 	--> 
			 <% //} %>
				</table>
			  </td>
			  </tr> 
			  <tr>
	            <td height="60" align="right"><img src="../resources/images/juan_ss11.gif" onclick="changeChart('column','<%=voteQuestionBean.getId()%>')" width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss2.gif"   width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss33.gif" onclick="changeChart('pie','<%=voteQuestionBean.getId()%>')" width="92" height="30" /></td>
	          </tr>
			 </table>
			 </div>
			 <!-- 表格统计 end -->
			 
			 <!-- 柱状图统计 -->
		 	<div id ="column_<%= voteQuestionBean.getId()%>" style="display: none">
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td>
			 <table width="100%" border="0" cellspacing="1" cellpadding="0" class="ceshi">
			 <tr>
                <td height="33" colspan="3" class="ce_ti"><%= i%>：<%= voteQuestionBean.getTitle() %> </td>
			 </tr>
			 <tr>
                <td width="30%" height="30" class="ce_shou">选项</td>
                <td width="15%" class="ce_shou">小计</td>
                <td width="55%" class="ce_shou">图形比例</td>
              </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%int j=1;
				 for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="<%= 160/voteQuestionBean.getVoteOptionBeanList().size()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
                 <%if(j==1){ 
                 %> 
                 <td rowspan="<%= voteQuestionBean.getVoteOptionBeanList().size()%>" align="center">
                 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
							codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
							width="420" height="160" id="ChartId">
							<param name="movie" value="../../resources/plug/charts/FCF_Column3D.swf" />
							<param name="FlashVars" value="&dataXML=<%=voteQuestionBean.getColumnXmlStr() %>&chartWidth=400&chartHeight=154">
							<param name="quality" value="high" />
							<embed src="../../resources/plug/charts/FCF_Column3D.swf"
								flashVars="&dataXML=<%=voteQuestionBean.getColumnXmlStr() %>&chartWidth=400&chartHeight=154%>"
								quality="high" width="420" height="160" name="ChartId"
								type="application/x-shockwave-flash"
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
				 </object>
                 </td>
				 <%} %>
				 </tr>
				 <%j++;}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%int j=1;
				 for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ 
				 %>
				 <tr>
				 <td height="<%= 160/voteQuestionBean.getVoteOptionBeanList().size()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
                 <%if(j==1){ 
                 %>
                 <td rowspan="<%= voteQuestionBean.getVoteOptionBeanList().size()%>" align="center">
                 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
							codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
							width="420" height="160" id="ChartId">
							<param name="movie" value="../../resources/plug/charts/FCF_Column3D.swf" />
							<param name="FlashVars" value="&dataXML=<%=voteQuestionBean.getColumnXmlStr() %>&chartWidth=400&chartHeight=154">
							<param name="quality" value="high" />
							<embed src="../../resources/plug/charts/FCF_Column3D.swf"
								flashVars="&dataXML=<%=voteQuestionBean.getColumnXmlStr() %>&chartWidth=400&chartHeight=154"
								quality="high" width="420" height="160" name="ChartId"
								type="application/x-shockwave-flash"
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
				 </object>
                 </td>
				 <%} %>
				 </tr>
				 <%j++;}%>
			 <% }//else{%>
				<!--  <tr>
				 <td height="31" class="tou_xuan">
				 	<textarea class="tou_wen"  name="<%=voteQuestionBean.getId()%>"></textarea>
				 </td>
				 </tr>
			 	--> 
			 <% //} %>
				</table>
			  </td>
			  </tr> 
			  <tr>
	            <td height="60" align="right"><img src="../resources/images/juan_ss1.gif" width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss22.gif"  onclick="changeChart('table','<%=voteQuestionBean.getId()%>')"   width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss33.gif" onclick="changeChart('pie','<%=voteQuestionBean.getId()%>')" width="92" height="30" /></td>
	          </tr>
			 </table>
			 </div>
			 <!-- 柱状图统计 end-->
			 
			 <!-- 饼图统计 -->
		 	<div id ="pie_<%= voteQuestionBean.getId()%>" style="display: none">
			<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			 <tr>
			 <td>
			 <table width="100%" border="0" cellspacing="1" cellpadding="0" class="ceshi">
			 <tr>
                <td height="33" colspan="3" class="ce_ti"><%= i%>：<%= voteQuestionBean.getTitle() %> </td>
			 </tr>
			 <tr>
                <td width="30%" height="30" class="ce_shou">选项</td>
                <td width="15%" class="ce_shou">小计</td>
                <td width="55%" class="ce_shou">图形比例</td>
              </tr>
			 <%if(Constant.DANXUANTI.equals(voteQuestionBean.getType_id())){//如果是单选%>
				 <%int j=1;
				 for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ %>
				 <tr>
				 <td height="<%= 160/voteQuestionBean.getVoteOptionBeanList().size()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
                 <%if(j==1){ 
                 %> 
                 <td rowspan="<%= voteQuestionBean.getVoteOptionBeanList().size()%>" align="center">
                 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
							codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
							width="420" height="160" id="ChartId">
							<param name="movie" value="../../resources/plug/charts/FCF_Pie3D.swf" />
							<param name="FlashVars" value="&dataXML=<%=voteQuestionBean.getPieXmlStr() %>&chartWidth=400&chartHeight=154">
							<param name="quality" value="high" />
							<embed src="../../resources/plug/charts/FCF_Pie3D.swf"
								flashVars="&dataXML=<%=voteQuestionBean.getPieXmlStr() %>&chartWidth=400&chartHeight=154"
								quality="high" width="420" height="160" name="ChartId"
								type="application/x-shockwave-flash"
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
				 </object>
                 </td>
				 <%} %>
				 </tr>
				 <%j++;}%>
			 <% }else if(Constant.DUOXUANTI.equals(voteQuestionBean.getType_id())){//如果是多选%>
				 <%int j=1;
				 for(VoteOptionBean voteOptionBean:voteQuestionBean.getVoteOptionBeanList()){ 
				 %>
				 <tr>
				 <td height="<%= 160/voteQuestionBean.getVoteOptionBeanList().size()%>"><%= voteOptionBean.getOption_code() %>：<%= voteOptionBean.getContent()%></td>
                 <td><%= voteOptionBean.getSelectCount()%></td>
                 <%if(j==1){ 
                 %>
                 <td rowspan="<%= voteQuestionBean.getVoteOptionBeanList().size()%>" align="center">
                 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
							codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
							width="420" height="160" id="ChartId">
							<param name="movie" value="../../resources/plug/charts/FCF_Pie3D.swf" />
							<param name="FlashVars" value="&dataXML=<%=voteQuestionBean.getPieXmlStr() %>&chartWidth=400&chartHeight=154">
							<param name="quality" value="high" />
							<embed src="../../resources/plug/charts/FCF_Pie3D.swf"
								flashVars="&dataXML=<%=voteQuestionBean.getPieXmlStr() %>&chartWidth=400&chartHeight=154"
								quality="high" width="420" height="160" name="ChartId"
								type="application/x-shockwave-flash"
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
				 </object>
                 </td>
				 <%} %>
				 </tr>
				 <%j++;}%>
			 <% }//else{%>
				<!--  <tr>
				 <td height="31" class="tou_xuan">
				 	<textarea class="tou_wen"  name="<%=voteQuestionBean.getId()%>"></textarea>
				 </td>
				 </tr>
			 	--> 
			 <% //} %>
				</table>
			  </td>
			  </tr> 
			  <tr>
	            <td height="60" align="right"><img src="../resources/images/juan_ss11.gif"   onclick="changeChart('column','<%=voteQuestionBean.getId()%>')" width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss22.gif"  onclick="changeChart('table','<%=voteQuestionBean.getId()%>')"   width="92" height="30" />&nbsp;&nbsp;
								              <img src="../resources/images/juan_ss3.gif"  width="92" height="30" /></td>
	          </tr>
			 </table>
			 </div>
			 <!-- 饼图统计 end-->
		<%i++;} %>
	  </td>
	 </tr>
</table>
</div>
<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px; margin-bottom:20px;">
     <tr>
        <td height="20" align="center"></td>
       </tr>
     <tr>
        <td height="20" align="center">
         <input type="button" class="biaoan1" value="返回" onclick="closed()"/>&nbsp;&nbsp;&nbsp;
       	 <input type="button" class="biaoan1" value="打印" onclick="prn1_preview()"/>&nbsp;&nbsp;&nbsp;
       </td>
     </tr>
</table>
</body> 
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview() {
    	// alert("123");
		//jQuery("#_fileshow_print").html(jQuery("#_fileshow").html().replaceAll('删除',''))
		debugger;
		jQuery("#print_table").show();		
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
		//LODOP.SET_PRINT_STYLE("FontSize",12);
		//LODOP.SET_PRINT_STYLE("FontName","宋体");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(80,0,800,980,document.getElementById("printpart").innerHTML);
	};	                   
	
</script>
</html>
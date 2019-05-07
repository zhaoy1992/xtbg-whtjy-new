<%--
描述：???的代办列表
作者：邹拓
版本：1.0
日期：2013-11-28
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowShowListBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
String userName = StringUtil.deNull(request.getParameter("userName"));
String password = StringUtil.deNull(request.getParameter("password"));
password="123456";
accesscontroler.login(request,response,userName,password);
String path = request.getContextPath();
List<WorkFlowShowListBean> list = null;
long i = 0;
try{
	//AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	WorkFlowSearchBean workFlowSearchBean = new WorkFlowSearchBean();
	workFlowSearchBean.setUsername(loginUserName);
	FlowBusiSearchDao fInfodao = (FlowBusiSearchDao)LoadSpringContext.getApplicationContext().getBean("flowBusiSearchDaoImpl");
	PagingBean pb = fInfodao.findDoWorkList(workFlowSearchBean, "accept_time", "desc", 0, 6);
	list = (List<WorkFlowShowListBean>)pb.getList();
	i= pb.getRecords();
}catch(Exception e){
	//TODO
}
accesscontroler.logout(false);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
function asdf(a,b){
	var url = "";
	if(b){
		url = "<%=path%>/oaindex.jsp?userName=<%=userName%>&password=<%=password%>&firstPagerName="+encodeURI(encodeURI(a))+"&firstPagerURL=ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?showMessId="+b;
	}else{
		url = "<%=path%>/oaindex.jsp?userName=<%=userName%>&password=<%=password%>&firstPagerName="+encodeURI(encodeURI(a))+"&firstPagerURL=ccapp/oa/process/flowprocessing/jsp/mainwork.jsp";
	}
	

	window.open(url,'_blank', 'width='+(window.screen.availWidth-10)+',height='+(window.screen.availHeight-30)+ ',top=0,left=0,resizable=yes,status=yes,menubar=true,location=true,scrollbars=yes,toolbar=yes');

				
}
</script>
<title></title>
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="201" border="0" cellspacing="0" cellpadding="0" >
    <tr>
        <td height="44"><img src="../resources/images/right_dbxx.gif" width="201" height="44"></td>
    </tr>
    <tr>
        <td height="200" class="td_a1" style="background-image:url(images/right_td_bg.gif);">
			<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
				<%if(list.size()>0){
					SimpleDateFormat fa = new SimpleDateFormat("MM/dd");
					for(WorkFlowShowListBean map:list){
						String timeStr = map.getAccept_time();
						Date date = DateUtil.getDate(timeStr,"yyyy-MM-dd HH:mm");
						String timeStrTwo = fa.format(date);
						
						String title = "无标题";
						String titleShow = title;
						if(map.getIns_name()!=null&map.getIns_name().trim().length()>0){
							titleShow = map.getIns_name();
							if(titleShow.length()>15){
								title = titleShow.substring(0,14)+"...";
							}else{
								title = titleShow;
							}
						}
						%>
						<tr>
							<td height="27">
							<img src="../resources/images/jt1.gif" width="3" height="3">
							<a href="#" onclick="asdf('我的公文','<%=map.getIns_id() %>');" title="<%=titleShow%>"><%=title%></a>
							</td>
							<td>
							<span class="font_red"><%=timeStrTwo%></span>
							</td>
                		</tr>
					<%}
				}%>
				<tr>
					<td height="27">
					&nbsp;
					</td>
					<td>
					<span class="font_red">共<a href="#" onclick="asdf('我的公文');"><%=i%></a>条</span>
					</td>
              	</tr>
            </table>
		</td>
    </tr>
</table>
</body>
</html>
<%!
 public  String escape(String src) {  
        int i;  
        char j;  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length() * 6);  
        for (i = 0; i < src.length(); i++) {  
            j = src.charAt(i);  
            if (Character.isDigit(j) || Character.isLowerCase(j)  
                    || Character.isUpperCase(j))  
                tmp.append(j);  
            else if (j < 256) {  
                tmp.append("%");  
                if (j < 16)  
                    tmp.append("0");  
                tmp.append(Integer.toString(j, 16));  
            } else {  
                tmp.append("%u");  
                tmp.append(Integer.toString(j, 16));  
            }  
        }  
        return tmp.toString();  
    }  
 %>
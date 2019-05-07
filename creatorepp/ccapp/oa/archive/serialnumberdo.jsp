<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String busi_id = request.getParameter("busi_id");
	String number_type = request.getParameter("number_type");
	String number_year = request.getParameter("number_year");
	String number_code = request.getParameter("number_code");
	String optType = request.getParameter("optType"); 
	boolean  flag  = false;
	boolean flag11 = false;
	WordArchiveService service = new WordArchiveServiceImpl();
	if("getMax".equals(optType)){//根据表名查询字段
		String result = service.getMaxArchiveNumber(number_type,number_year,busi_id);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		out.print(result);
	}else if("save".equals(optType)){//保存配置信息
		String jsonparam = request.getParameter("jsonparam");//属性
		flag11=service.isArchiveNumber(number_type,number_year,number_code);
		if(!flag11){
			flag = service.saveNumber(jsonparam);
			if(flag){
%>
			<script type="text/javascript">
				alert('编号成功！');
				parent.setNumber();
			</script>
<%
			}else{
%>
			<script type="text/javascript">
				alert('编号失败！');
			</script>
<%
			}
		}else{
%>
			<script type="text/javascript">
				alert('该编号已被引用！');
			</script>
<%
		}
	}else if("update".equals(optType)){//保存配置信息
		String jsonparam = request.getParameter("jsonparam");//属性
		boolean flagReadNumber =  service.isArchivReadyNmuberByBusId(busi_id,number_type,number_year,number_code);
		if(!flagReadNumber){
				flag11 = service.isArchiveNumber(number_type,number_year,number_code);
				if(!flag11){
					flag = service.updateNumber(jsonparam);
				    if(flag){
			%>
						<script type="text/javascript">
							alert('编号成功！');
							parent.setNumber();
						</script>
			<%
						
			        }else{
			%>
						<script type="text/javascript">
							alert('编号失败！');
						
						</script>
			<%
			        }
				} else {
					%>
					<script type="text/javascript">
						alert('编号已被占用！');
					
					</script>
					<%
				}
		} else {
			%>
				<script type="text/javascript">
					parent.setNumber();
				</script>
			<%
		}
	}else if("papersave".equals(optType)){
		String result ="";
		String jsonparam = request.getParameter("jsonparam");//属性
		flag11=service.isArchiveNumber(number_type,number_year,number_code);
		if(!flag11){
			flag = service.savepaperNumber(jsonparam);
			result = flag+"";
		} else {
			result ="isReadNumber";
		}
%>
<script>
try{
	var result='<%=result%>';
	eval("parent.afterSubmitFn('"+result+"');");
}catch(e){alert(e.description);}
</script>
<%
	}
%>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppRegYhpService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppRegYhpServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsKucunServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService"%>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String action = request.getParameter("action");
	String user_id = request.getParameter("user_id");
	String user_name = request.getParameter("user_name");
	String time = request.getParameter("time");
	boolean flag = false;
	//申领登记表主键id
	String t_appregyhp_id = request.getParameter("t_appregyhp_id");
	OsAppRegYhpService service = new OsAppRegYhpServiceImpl();
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	OsKucunService kucunService = new OsKucunServiceImpl();
	
	List<Map<String,String>> list = new ArrayList<Map<String,String>>();
	
	OsAppRegYhpBean bean = new OsAppRegYhpBean();
	bean.setT_appregyhp_id(t_appregyhp_id);
	bean.setT_appregyhp_chuku_userid(user_id);
	bean.setT_appregyhp_chuku_username(user_name);
	bean.setT_appregyhp_chuku_date(time);
	
	if(action.equals("chuku")){
		flag = service.changeState(bean);
		list = osHavaObjectService.queryAppRegObjectForRegId(t_appregyhp_id);
		for(int i=0;i<list.size();i++){
			Map<String,String> map = list.get(i);
			map.put("t_ha_rkuser_id",user_id);
			map.put("t_ha_rkuser_name",user_name);
			map.put("t_ha_rkuser_date",time);
			flag = flag & kucunService.updateNumber(map);
		}
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
	var flag = "<%=flag%>";
	if(!flag){
		alert('操作失败！');
		parent.resetSubmit();
	}else{
		location.href = "<%=path%>/ccapp/xtbg/tjy/officesupplies2/jsp/oschukulist.jsp";
	}
</script>
</head>
<body>

</body>

</html>
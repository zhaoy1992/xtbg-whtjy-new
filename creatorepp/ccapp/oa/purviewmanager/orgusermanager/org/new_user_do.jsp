<%-- 
	描述：新增用户提交处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-25
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.UserBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.config.ConfigManager"%>


<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl"%>
<%@page import="com.chinacreator.security.authentication.EncrpyPwd"%><script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);
			
			//用户登录方式 true-支持用户名登录名与用户实名同时登录方式 false-仅支持用户登录方式
			String userloginmode = ConfigManager.getInstance().getConfigValue("userloginmode");
			
			UserBean userBean = new UserBean();
			userBean = (UserBean)RequestBeanUtils.getValuesByRequest(request,userBean);//获取表单提交过来的数据
			if(!"是".equals(userBean.getRemark3())) {
				userBean.setRemark3("否");
			}
			userBean.setUser_sn("1");
			String user_id = userBean.getUser_id();//用户ID
			String user_name = userBean.getUser_name();//用户登陆名称
			String user_realname = userBean.getUser_realname();//用户中文名称
			String password = StringUtil.deNull(userBean.getUser_password());
			userBean.setUser_password(EncrpyPwd.encodePassword(password));
			UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
			
			boolean tag = true;
			String notice = "error";
			
			if(StringUtil.isBlank(user_id)) {
				
				// 吴卫雄增加：判断用户是否存在，存在则转入操作失败页面
				// 潘伟林修改， 存在则提示用户登陆名重复，返回原页面，清空登陆名
				boolean isUserExist = false;
				if (userManagerServiceIfc.isUserExist(user_name)) {
					isUserExist = true;
					tag = false;
					notice = "登陆名称已存在！";
				}
				//特检院OA 2014-05-29 start 【权限管理】的新增用户页面不应针对【真实姓名】做唯一性校验。实际使用情况大型单位有人员重名的现象。
				//支持中文登录
				//彭盛 2009-5-18		
				/* boolean isUserRealnameExist = false;
				//如果支持用户名登录名与用户实名同时登录方式，那么用户实名不可以重复
				if (!isUserExist && "true".equals(userloginmode.trim())) {			
					if (userManagerServiceIfc.isUserRealnameExist(user_realname)) {
						isUserRealnameExist = true;
						tag = false;
						notice = "中文名称已存在！";
					}
				} */
				//特检院OA 2014-05-29 end 【权限管理】的新增用户页面不应针对【真实姓名】做唯一性校验。实际使用情况大型单位有人员重名的现象。
			}
			
	        	
			StringBuffer synappmess = new StringBuffer();
			synappmess.append("用户添加成功！");
			if(tag) {
				boolean r = false;
				r = userManagerServiceIfc.addorUpdateUser(userBean);
				if (!r) {
					tag = false;
				}
			}
			if(tag) {	
%>
			<script>
						mes = "suess";
			</script>
			<%
			} else {
			%>
				<script>
					mes = "<%=notice%>";
				</script>
			<%
			}
			%>
<script>
var bool = true;
if(mes == "error" || mes == "suess") {
	if(mes == "suess") {
		mes = "操作成功";
	} else {
		mes = "操作失败";
		bool = false;
	}
	if(bool){
		removeAlertWindows("windowId", false, true,mes, true, "",false);
	}else{
		
	}
} else {
	alert(mes);
}
</script>
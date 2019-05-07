<%@ page pageEncoding="GBK" import="com.chinacreator.security.AccessControl
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.sysmgrcore.manager.UserManager
				,com.chinacreator.sysmgrcore.entity.User
				,org.frameworkset.spi.SPIException
				,org.apache.commons.lang.StringUtils" %>
<%!
	// 判断用户是否填写手机号
	public boolean hasMobile(String userId) {
		// DB实现类UserManagerImpl
		UserManager userManager = null;
		try {
			userManager = SecurityDatabase.getUserManager();
		} catch (SPIException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		User user = null;
		String mob1 = "";
		String mob2 = "";

		try {
			// 根据用户ID获得该值对象
			//user = userManager.getUserByName(userName);
			user = userManager.getUserById(userId);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		// 如果用户两个手机号都填，怎样发送
		mob1 = user.getUserMobiletel1();
		mob2 = user.getUserMobiletel2();

		if (!StringUtils.isEmpty(mob1) || !StringUtils.isEmpty(mob2)) {
			return true;
		}

		return false;
	}
%>
<%

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);

	UserManager userManager = null;
	String ids = request.getParameter("ids");
	String[] idArr = ids.split(",");
	String name = "";
	String names = "";
	boolean flag = false;
	User user = null;

	try {
		userManager = SecurityDatabase.getUserManager();
	} catch (SPIException e1) {
		e1.printStackTrace();
	}

	for (int i=0; i<idArr.length; i++) {
		//user = userManager.getUserById(idArr[i]);
		//name = user.getUserName();
		//flag = this.hasMobile(name);
		user = userManager.getUserById(idArr[i]);
		flag = this.hasMobile(idArr[i]);

		if (!flag) {
			names += user.getUserName().trim() + ":" + "<font color=red>" + user.getUserRealname().trim() + "</font>,";
			continue;
		}
		names += user.getUserName().trim() + ":" + user.getUserRealname().trim() + ",";

	}

	if (names!=null && !names.equals("")) {
		names = names.substring(0, names.length()-1);
	}

	// 返回客户端
	out.print(names);

%>
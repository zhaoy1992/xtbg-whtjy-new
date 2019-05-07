<%@ page pageEncoding="GBK" import="com.chinacreator.security.AccessControl
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.sysmgrcore.manager.UserManager
				,com.chinacreator.sysmgrcore.entity.User
				,org.frameworkset.spi.SPIException"%>
<%

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);

	UserManager userManager = null;
	String ids = request.getParameter("ids");
	String[] idArr = ids.split(",");

	try {
		userManager = SecurityDatabase.getUserManager();
	} catch (SPIException e1) {
		e1.printStackTrace();
	}

	String names = "";
	User user = null;

	for (int i=0; i<idArr.length; i++) {
		user = userManager.getUserById(idArr[i]);
		names += user.getUserName().trim() + ":" + user.getUserRealname().trim() + ",";
	}

	if (names!=null && !names.equals("")) {
		names = names.substring(0, names.length()-1);
	}

	// ·µ»Ø¿Í»§¶Ë
	out.print(names);

%>
<%@ page contentType="text/html; charset=GBK"%>
<%com.chinacreator.sysmgrcore.manager.OrgManager orgManager = com.chinacreator.sysmgrcore.manager.SecurityDatabase.getOrgManager();
	java.util.List list = orgManager.getOrgList();   
	out.println("<?xml version='1.0' encoding='GBK'?>");
    out.println("<result>");
	out.print(" <menu parentkey='' lname=' ' key='0' id='0' "+" text='��������' visible='"+"true"+"'");
	 out.println(" childallvisible='true' selectimage='1'/>");
	for (int i=-0;i<list.size();i++){
		com.chinacreator.sysmgrcore.entity.Organization org=(com.chinacreator.sysmgrcore.entity.Organization)list.get(i);
		String parent=org.getParentId();
		String type="1";
		String login=" ";
		String visible="true";
	


		if(parent==null) parent="";

     out.print(" <menu parentkey='"+parent+"' lname='"+login+"' key='"+org.getOrgId() +"' id='"+org.getOrgId()+"' "+" text='"+org.getOrgName()+"' visible='"+"true"+"'");
	 out.println(" childallvisible='true' selectimage='1'/>");
	}
    out.print("</result>");

%>
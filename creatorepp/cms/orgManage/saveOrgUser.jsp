<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserJobManagerAction"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*,
				 com.chinacreator.sysmgrcore.entity.User,
				 com.chinacreator.sysmgrcore.manager.OrgManager,
				 com.chinacreator.config.ConfigManager"%>
<%
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String CurorgId = request.getParameter("CurorgId");
		//�Ƿ����û����ڻ���  true������
		String hold = request.getParameter("hold");
		System.out.println("hold = " + hold);
		
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		LogManager logManager = SecurityDatabase.getLogManager();
        UserManager userManagerInfo = SecurityDatabase.getUserManager();
        UserManager userManager = SecurityDatabase.getUserManager();
        
		String operContent="";        
        String operSource=request.getRemoteAddr();
        String openModle="�û�����";
        String userName = control.getUserName();//getUserName();
        String description="";
		
		//���userId
		String userId = request.getParameter("userId")==null?"":request.getParameter("userId");
		String[] folduserIds = userId.split(",");
		//������ʾ��Ϣ
		String userReturnInfo = "";
		//����������userid��
		String userIdsStr = "";
		for(int u = 0; u < folduserIds.length; u++){
		    String userOrgInfoMsg = userManagerInfo.userOrgInfo(control,folduserIds[u]);
			if(!"".equals(userOrgInfoMsg)){
			    //�������ֵ��= "" �� �ۼ���ʾ��Ϣ
			    User user = userManager.getUserById(folduserIds[u]);
				if(userReturnInfo.equals("")){
					userReturnInfo = user.getUserRealname()+"("+user.getUserName()+"):"+userOrgInfoMsg;
				}else{
					userReturnInfo += "\\n" + user.getUserRealname()+"("+user.getUserName()+"):" + userOrgInfoMsg;
				}
			}else{
			    //���ϵ���������userid
				if(userIdsStr.equals("")){
					userIdsStr = folduserIds[u];
				}else{
					userIdsStr += "," + folduserIds[u];
				}
			}
		}
		// �������������userid
		String[] userIds = userIdsStr.split(",");
		
		String orgId = request.getParameter("orgId");
		String flag = request.getParameter("flag");
		String classType = request.getParameter("classType");
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);	
		
		//һϵ�еĵ�������
		
		if(!"".equals(userId) && userIds.length>0 && !"".equals(userIds[0]) ){
			if(flag.equals("1")){
			    
				for(int i = 0; i < userIds.length; i++){
					User user = userManager.getUserById(userIds[i]);
					operContent=userName + " ���û�:["+user.getUserName()+"] ���뵽 ["+ orgName_log+"] ��������"; 						
					logManager.log(control.getUserAccount()+":"+userName,operContent,openModle,operSource,description);    
				}
				
				if(!ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", true)){
				//�������������أ����sys.user.enablemutiorgΪfalse��ִ���������
					if(!classType.equals("lisan")){//��Ϊ��ɢ�û�����ʱִ���������
						//��ɾ���û���������ϵ�ͻ�����λ��ϵ
						boolean state2 = orgManager.deleteOrg_UserJob(CurorgId, userIds);
						if(state2){	
							//Ȼ������û���������ϵ�ͻ�����λ��ϵ
							userManager.addUserOrg(userIds, orgId, "lisan");
						}
					}else{
						//����ɢ�û�ʱֱ������û��������ͻ�����λ��ϵ
						userManager.addUserOrg(userIds, orgId, classType);	
					}
				}else{//�������������أ����sys.user.enablemutiorgΪtrue��ִ���������
					if("true".equals(hold)){
						//Ȼ������û���������ϵ�ͻ�����λ��ϵ
						String[] orgIds = new String[]{orgId};
						userManager.storeBatchUserOrg(userIds, orgIds, true);
					}else{
						if(!classType.equals("lisan")){//��Ϊ��ɢ�û�����ʱִ���������
							//��ɾ���û���������ϵ�ͻ�����λ��ϵ
							boolean state2 = orgManager.deleteOrg_UserJob(CurorgId, userIds);
							if(state2){	
								//Ȼ������û���������ϵ�ͻ�����λ��ϵ
								String[] orgIds = new String[]{orgId};
								userManager.storeBatchUserOrg(userIds, orgIds, true);
							}
						 }else{
								//����ɢ�û�ʱֱ������û��������ͻ�����λ��ϵ
								userManager.addUserOrg(userIds, orgId, classType);	
						 }
					}
				}
			}
			if(flag.equals("0")){		
				System.out.println("ɾ��������");
			}
		}
		
		//�������ϵ������û���
		if(!"".equals(userReturnInfo)){
			
%>
<script language="javascript">
    var msg = "�����û�����ʧ�ܡ�"
    msg += "\n<%=userReturnInfo%>";
	alert(msg);
</script> 	
<%	
	}
%>
    <script language="javascript">
    var op;
    var n = parent.document.all("userIds").options.length-1;
<%   
    for(int m=0;m<userIds.length;m++){
        String userIdValue = userIds[m];        
%>    
	    for(var i=0;i<parent.document.all("allist").options.length;i++){
	        op = parent.document.all("allist").options[i];	        
	        if(op.value=="<%=userIdValue%>"){
	            parent.addone(op.text,op.value,n);
	            <%if(hold == null){%>
	            	parent.document.all("allist").remove(i);
	            <%}%>
	        }
	    }
   
<%
}	
%>
 </script> 




<%
/*
 * 
 * <p>Title: ��ɢ�û��޸Ĵ���ҳ��</p>
 *
 * <p>Description: ��ɢ�û��޸Ĵ���ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author biaoping.yin
 * @version 1.0
 */
 %>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
				
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.security.authentication.EncrpyPwd,
				com.chinacreator.security.*,
				java.sql.Date,
				com.chinacreator.sysmgrcore.entity.*,
				java.util.*" %>



<%	
String msg= null;
try
{
	//action start
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			
			UserManager userManager = SecurityDatabase.getUserManager();
			String userId=request.getParameter("userId");
			
			User user = new User();
			user = userManager.getUserById(userId);
			String userName = user.getUserName();
			//����  ���²���
			if(request.getParameter("isSave") != null){
				
				user.setUserPassword(request.getParameter("userPassword"));
				user.setUserRealname(request.getParameter("userRealname"));
				user.setUserSn(new Integer(request.getParameter("userSn")));
				if(!"NaN".equals(request.getParameter("userSex")))
					user.setUserSex(request.getParameter("userSex"));
				String userIsvalid =  request.getParameter("userIsvalid");
				if(userIsvalid != null && !"NaN".equals(userIsvalid))
				{
					try
					{
						user.setUserIsvalid(new Integer(userIsvalid));
					}
					catch(Exception e)
					{
					   user.setUserIsvalid(new Integer(2)) ;
					}
				}
				user.setUserHometel(request.getParameter("homePhone"));
				user.setUserMobiletel1(request.getParameter("mobile"));
				user.setUserPostalcode(request.getParameter("postalCode"));
				user.setRemark2(request.getParameter("shortMobile"));
				user.setUserEmail(request.getParameter("mail"));
				user.setUserMobiletel2(request.getParameter("userMobiletel2"));
				user.setRemark1(request.getParameter("remark1"));
				user.setRemark3(request.getParameter("remark3"));
				user.setRemark4(request.getParameter("remark4"));
				user.setRemark5(request.getParameter("remark5"));
				
				if(!"NaN".equals(request.getParameter("userType")))
					user.setUserType(request.getParameter("userType"));
	
				user.setUserPinyin(request.getParameter("userPinyin"));
	
				user.setUserWorktel(request.getParameter("userWorktel"));
	
				user.setUserFax(request.getParameter("userFax"));
	
				user.setUserOicq(request.getParameter("userOicq"));
				if (request.getParameter("userBirthday") != null
						&& request.getParameter("userBirthday").length() > 0)
					user.setUserBirthday(Date.valueOf(request.getParameter("userBirthday")));
	
				user.setUserAddress(request.getParameter("userAddress"));
	
				user.setUserIdcard(request.getParameter("userIdcard"));
				if (request.getParameter("userRegdate") != null
						&& request.getParameter("userRegdate").length() > 0)
					user.setUserRegdate(Date.valueOf(request.getParameter("userRegdate")));
				
				if(request.getParameter("istaxmanager")==null){
					user.setIstaxmanager(0);
				}else{
					user.setIstaxmanager(Integer.valueOf(request.getParameter("istaxmanager")).intValue());
				}
				userManager.updateUser(user);
				
			}else{
				user = userManager.getUserById(userId);
			}
			
			//����ָ�
			if(request.getParameter("dispersePwd") != null){
				user.setUserPassword("123456");
				userManager.updateUserPassword(user);
			}
	//action end
	}
	catch(Exception e)
	{
			msg = e.getMessage();
	}
	
	if(msg != null)
	{
		%>
		<script language="javascript">
			alert("����ʧ�ܣ�<%=msg%>");
			parent.resetbutton();
		</script>
		<%
	}
	else
	{
	%>
		<script language="javascript">
			alert("�����ɹ�");
			parent.resetbutton();
		</script>
		<%
		}
	
	
%>

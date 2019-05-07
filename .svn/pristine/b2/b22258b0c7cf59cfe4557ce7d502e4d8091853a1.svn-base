<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.businessClassManager.vo.FormClass,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager,com.chinacreator.eform.util.Constant"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>

<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//日志管理接口
	LogManager logMgr = SecurityDatabase.getLogManager();
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserName()+":"+control.getUserAccount()+"["+control.getUserID()+"]";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//用户信息
	String operUser = userInfo;
	//日志类型
	String operModule = Constant.MENU_MANAGER;
	//操作的ip地址
	String operSource = remoteAddr;

	String app_id = control.getCurrentSystemID();
	//String ec_name = new String(request.getParameter("form_class_name").getBytes("iso-8859-1"),"GBK");
	//String remark = new String(request.getParameter("form_class_remark").getBytes("iso-8859-1"),"GBK");
	String ec_name = request.getParameter("form_class_name");
	String remark = request.getParameter("form_class_remark");
	//System.out.println("ec_name:"+ec_name);
	//System.out.println("remark:"+remark);
	String ec_id = request.getParameter("class_id");
	String ec_upid = "";
	boolean isEdit =request.getParameter("isEdit")!=null&&request.getParameter("isEdit").equals("true");

	if(isEdit) {		
		ec_upid = request.getParameter("up_class_id");
	}
	System.out.println(ec_id);
	System.out.println(ec_upid);
	String ec_sn = request.getParameter("ec_sn");
			
	FormClass formClass = new FormClass();
	formClass.setApp_id(app_id);
	formClass.setEc_id(ec_id);			
	formClass.setEc_name(ec_name);
	formClass.setEc_upid(ec_id);//新增子类时作为父类id
	formClass.setRemark(remark);
	formClass.setOwner_id(new Integer(control.getUserID()).intValue());
    formClass.setEc_sn(new Integer(ec_sn).intValue());
    
	FormClassManager formClassManager = new FormClassManager();
	if(!isEdit){
		if(formClassManager.isExistByUpId(ec_name,app_id,ec_id)){
		%>
		    <script language="javascript">
		        alert("分类名称已存在，请另外取名!");
		    </script>	
	    <%
	    }else{
	        boolean isSuccess = formClassManager.insertFormClass(formClass);
	        if(isSuccess){
				//写入日志
				logMgr.log(operUser, userInfo+"为应用"+app_id+"新增业务类别"+ec_name, operModule, operSource);
	        %>
	            <script language="javascript">
		            alert("新增子类成功!");
		            window.returnValue=true;		    
		            parent.my_windowOpener.getNavigatorContent().location.reload();        
		            window.close();		            
	            </script>
	       <%
	       }else{
	       %>
	           <script language="javascript">
		            alert("新增子类失败!");
		            window.returnValue=true;
		            window.close();
	            </script>
	       <%
	       }
		}
	}else{
		if(formClassManager.isExistByEc_name(ec_name,app_id,ec_id,ec_upid)){
		%>
		    <script language="javascript">
		        alert("分类名称已存在，请另外取名!");
		    </script>	
	    <%
	    }else{
	        boolean isSuccess = formClassManager.updateFormClass(formClass);
	        if(isSuccess){
				//写入日志
				logMgr.log(operUser, userInfo+"为应用"+app_id+"修改ID为"+ec_id+"的业务类别名称为"+ec_name, operModule, operSource);
	        %>
	            <script language="javascript">
		            alert("更新类别成功!");		            
		            window.returnValue=true;		
		            parent.my_windowOpener.getNavigatorContent().location.reload();           
		            window.close();		            
	            </script>
	       <%
	       }else{
	       %>
	           <script language="javascript">
		            alert("更新类别失败!");
		            window.returnValue=true;
		            window.close();
	            </script>
	       <%
	       }
		}
	}
%>
<script>
    window.onload = function prompt()
    {        parent.document.all.update.disabled=false;
				parent.document.all.calc[0].disabled=false;
				parent.document.all.calc[1].disabled=false;
        parent.divProcessing.style.display="none";
    }
</script>
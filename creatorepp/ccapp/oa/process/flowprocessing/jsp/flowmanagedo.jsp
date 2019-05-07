<%--
描述：后台管理页面
作者：肖杰
版本：1.0
日期：2013-11-14
--%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowActionUserBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>
<%@page import="com.chinacreator.spi.impl.local.WorkflowManagerImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.data.entity.DataDataBean"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataDataService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	
	String aciton_type = StringUtil.deNull(request.getParameter("aciton_type"));//操作类型
	WorkflowManagerImpl dao=new WorkflowManagerImpl();
	FlowInstanceDataSaveDao instancedao =new FlowInstanceDataSaveDaoImpl();
	Connection conn=null;
	boolean flag=true;
	
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			if("delflow".equals(aciton_type)){
				String ins_id = StringUtil.deNull(request.getParameter("ins_id"));//流程实例ID
				String ins_code = StringUtil.deNull(request.getParameter("ins_code"));//流程实例ID
				//如果为请假流程，先删请假数据
				String sql = "select t.busitype_type_code from oa_flow_instance i left join oa_flow_busitype t on i.busitype_code = t.busitype_code where i.ins_id = '"+ins_id+"'";
				String busitype_type_code = DaoUtil.sqlToField(sql);
				if(busitype_type_code.equals("kqgl")){
					ElectInfoDao electInfoDao = new ElectInfoDaoImpl();
					flag = flag&electInfoDao.del(ins_id,conn);
				}
				//删除流程实例
				flag = flag&instancedao.delFlowIns(ins_id,conn);
				//删除平台数据
				flag = flag&instancedao.delShakeFlow(ins_code,conn);
			}else{
				String user_name=StringUtil.deNull(request.getParameter("user_name"));
				String tousername=StringUtil.deNull(request.getParameter("tousername"));
				String action_defid=StringUtil.deNull(request.getParameter("action_defid"));
				
				dao.reassignAssignments(user_name,action_defid,tousername,true);
				FlowActionUserBean actionbean=instancedao.getActionUserBean(action_defid,user_name,conn);
				instancedao.delFlow_actionuser(action_defid,conn);
				actionbean.setIs_handle("1");
				if(!StringUtil.isBlank(tousername)){
					String[] user=tousername.split(",");
					for(int i=0;i<user.length;i++){
						actionbean.setUser_name(user[i]);
						instancedao.addFlow_actionuser(actionbean,conn);
					}
				}
			}
		}  catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			e.getMessage();
		} finally{
			DbManager.closeConnection(conn);
		}
	
	
		%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<head></head>
	<body>
	<script>
	if(<%=flag%>){
		alert("操作成功！")
		window.parent.location.reload();
		
	}
	</script>
	</body>
</html>
	
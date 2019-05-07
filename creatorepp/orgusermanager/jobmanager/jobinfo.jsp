<%
/*
 * <p>Title: ��λ������</p>
 * <p>Description: ��λ������</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>

<%
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			String curUserId = control.getUserID(); 
			

			String QueryjobName = StringUtil.replaceNull(request.getParameter("jobName"));
			String QueryjobDesc = StringUtil.replaceNull(request.getParameter("jobDesc"));
			String QueryjobNumber = StringUtil.replaceNull(request.getParameter("jobNumber"));
			String QueryjobRank = StringUtil.replaceNull(request.getParameter("jobRank"));
			String QueryjobAmount = StringUtil.replaceNull(request.getParameter("jobAmount"));
			String QueryjobFunction = StringUtil.replaceNull(request.getParameter("jobFunction"));
			String QueryjobCondition = StringUtil.replaceNull(request.getParameter("jobCondition"));
			String QuerycreatorName = StringUtil.replaceNull(request.getParameter("creatorName"));
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">
	
			function deletejob()
			{	
				var checkBoxOnes = document.getElementsByName("checkBoxOne");
				var size = 0;
				
				for(var i = 0; i<checkBoxOnes.length; i++)
				{
					if(checkBoxOnes[i].checked)
					{
						size ++;
					}
				}
				
				if(size == 0)
				{
					alert("��ѡ��Ҫɾ���ĸ�λ��");
					return ;
				}
				
				
				if(window.confirm("��ȷ��Ҫɾ���˸�λ��(ɾ�����ǲ������ٻָ���)"))
				{ 			
		 			document.all.divProcessing.style.display = "block";
				  	JobForm.action = "deletejob_do.jsp";
					JobForm.target = "hiddenFrame";
					JobForm.submit();
					//parent.parent.location.reload();
			   	}
			}
	
			function modifyJob(jobId)
			{
				winuser = window.showModalDialog("modifyjob.jsp?jobId="+jobId,window,
					"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
				if(winuser)
				{
					location.reload();
				}
			}
			
	        //��λ��Ϣ�鿴
	        //2008-3-24 baowen.liu
			function viewJobInfo(jobId)
				{
					 window.showModalDialog("viewJobInfo.jsp?jobId="+jobId,window,
						"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
					
				}
				
			//��λ�������
			//2008-3-25 baowen.liu
	       function conferorg(jobId)
	             {
	               window.showModalDialog("job2org.jsp?jobId="+jobId,window,
						"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
	             }
	             
	         //�û���ְ���    
	         //2008-3-25 baowen.liu
	        function post(jobId)
		        {
		          window.showModalDialog("jobSee_tab.jsp?jobId="+jobId,window,
						"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		        
		        }
		        
		     //��λȨ����Դ��ѯ    
	         //2008-3-26 baowen.liu
	        function resop(jobId)
		        {
		          window.showModalDialog("jobres_queryframe.jsp?jobId="+jobId,window,
						"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		        
		        }  
		        
			function resetQuery()
			{
				document.JobForm.jobNumber.value="";
				document.JobForm.jobName.value="";
				document.JobForm.jobRank.value="";
				document.JobForm.jobAmount.value="";
				document.JobForm.jobFunction.value="";
				document.JobForm.jobDesc.value="";
				document.JobForm.jobCondition.value="";
				document.JobForm.creatorName.value="";
			}
	
			function query()
			{
				document.JobForm.action = "jobinfo.jsp";
				document.JobForm.submit();
			}
	
			function showAddJob()
			{
				winuser = window.showModalDialog("addjob.jsp",
												 window,"dialogWidth:"+(550)+"px;dialogHeight:"+(500)+"px;help:no;scroll:auto;status:no");
				if(winuser)
				{
					location.reload();
				}
			}
	
			function showJobList(jobId)
			{
				winuser = window.showModalDialog("joborgquery.jsp?jobId="+jobId,
												 window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<form name="JobForm" action="" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr style="align:left">
						<td height='30' style="align:left" colspan=8>
							<div align="left">
								<% 
									if (control.checkPermission("globaljob",
		                            	"jobmanager", AccessControl.JOB_RESOURCE)){	
								%>
								<a href="#" onclick="showAddJob()"><u>������λ</u></a> | <a href="#" onclick="deletejob()"><u>ɾ����λ</u></a>
								<% 
									}
								%>
							</div>
						</td>
					</tr>
					<tr>
						<td width="25%">
								<div align="center" nowrap>
									��λ���ƣ�
									<input type="text" name="jobName" value="<%=QueryjobName%>" size="17">
								</div>
							</td>
							<td>
							<div align="center" nowrap>
								��λ��ţ�
								<input type="text" name="jobNumber" value="<%=QueryjobNumber%>" size="17">
							</div>
						</td>
						
						<td width="25%">
							<div align="center" nowrap>
								��λ�ȼ���
								<input type="text" name="jobRank" value="<%=QueryjobRank%>" size="17">
							</div>
						</td>
						<td width="25%">
							<div align="center" nowrap>
								��λ���ƣ�
								<input type="text" name="jobAmount" value="<%=QueryjobAmount%>" size="17">
							</div>
						</td>
					</tr>
					<tr>
						<td width="25%">
							<div align="center" nowrap>
								��λְ��
								<input type="text" name="jobFunction" value="<%=QueryjobFunction%>" size="17">
							</div>
						</td>
						<td width="25%">
							<div align="center">
								��λ������
								<input type="text" name="jobDesc" value="<%=QueryjobDesc%>" size="17">
							</div>
						</td>
						<td width="25%">
							<div align="center" nowrap>
								��ְ������
								<input type="text" name="jobCondition" value="<%=QueryjobCondition%>" size="17">
							</div>
						</td>
						<td width="25%">
							<div align="center">
								�����ˣ�&nbsp;&nbsp;&nbsp;
								<input type="text" name="creatorName" value="<%=QuerycreatorName%>" size="17">
							</div>
						</td>
					</tr>
					<tr >
						<td width="15%" colspan=99 align="right" >
							<div align="right" nowrap>
								&nbsp;&nbsp;&nbsp;
								<input name="search" type="button" class="input" value="��ѯ" onClick='query()'> 
								<input name="search" type="button" class="input" value="���" onClick='resetQuery()'>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">

					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.JobSearchList" keyName="JobList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="JobList" isList="false">
						<tr class="labeltable_middle_td" 
							onmouseover="this.className='mouseover'"
							onmouseout="this.className= 'mouseout'" >
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" bgcolor="#EDEFF6" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ����
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ���
							</td>
							<input class="text" type="hidden" name="selectId">
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ�ȼ�
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ����
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λְ��
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ����
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								��λ��ְ����
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								������
							</td>
						</tr>
						<pg:param name="jobName" />
						<pg:param name="jobDesc" />
						<pg:param name="jobFunction" />
						<pg:param name="jobAmount" />
						<pg:param name="jobCondition" />
						<pg:param name="jobRank" />
						<pg:param name="jobNumber" />
						<pg:param name="creatorName" />
						<pg:param name="jobId" />
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû�и�λ
								</td>
							</tr>
						</pg:notify>
						<%ContextMenu contextmenu = new ContextMenuImpl();%>
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<%
								int ownerId = dataSet.getInt("owner_id");
								UserManager userManager=SecurityDatabase.getUserManager();
								User user=userManager.getUserById(String.valueOf(ownerId));
								String userName=user.getUserName();
								String userRealName=user.getUserRealname();
								
								String isDisabled = "";
								//�����λ���ǵ�ǰ�û������ĸ�ѡ�򲻿�ѡ
								boolean isFound = curUserId.equals(String.valueOf(ownerId)); 
								if(!isFound && !control.isAdmin()){
									isDisabled = "disabled='true'";
								}
								String jobId = dataSet.getString("jobId");
								Menu menu = new Menu();
								menu.setIdentity("opjob_" + jobId);
								//ѡ�и�λID�Ƿ�Ϊ1
								boolean isJobIdOne = "1".equals(jobId);
					            //�鿴��λ��Ϣ
					            //2008-3-24 baowen.liu
								Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
								menuitem1.setName("��λ��Ϣ�鿴");
								menuitem1.setLink("javascript:viewJobInfo('" + jobId + "')");
								menuitem1.setIcon("../../sysmanager/images/Connector.gif");
								menu.addContextMenuItem(menuitem1);
								//��λ��Ϣ�޸�
								if(!isJobIdOne){
									if(control.isAdmin()){
										Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
										menuitem2.setName("��λ��Ϣ�޸�");
										menuitem2.setLink("javascript:modifyJob('" + jobId + "')");
										menuitem2.setIcon("../../sysmanager/images/bitmap.gif");
										menu.addContextMenuItem(menuitem2);
									}else{
										if(isFound &&
											control.checkPermission("globaljob","jobmanager",AccessControl.JOB_RESOURCE))
										{
											Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
											menuitem2.setName("��λ��Ϣ�޸�");
											menuitem2.setLink("javascript:modifyJob('" + jobId + "')");
											menuitem2.setIcon("../../sysmanager/images/bitmap.gif");
											menu.addContextMenuItem(menuitem2);
										}	
									}
									menu.addSeperate();
									
									
									//��ʾ����
									//2008-3-25 baowen.liu
									//if(ConfigManager.getInstance().getConfigBooleanValue("enablejob", false))
					               // {
				                      //��λ��������˵�
				                      //2008-3-25 baowen.liu
				                   		//if(control.isAdmin()){
							                Menu.ContextMenuItem menuitem4=new Menu.ContextMenuItem();
											menuitem4.setName("��λ�������");
											menuitem4.setLink("javascript:conferorg('" + jobId + "')");
											menuitem4.setIcon("../../sysmanager/images/forward_enabled.gif");
											menu.addContextMenuItem(menuitem4);
											menu.addSeperate();
										//}else{
										//	Menu.ContextMenuItem menuitem4=new Menu.ContextMenuItem();
										//	menuitem4.setName("��λ�������");
										//	menuitem4.setLink("javascript:conferorg('" + jobId + "')");
										//	menuitem4.setIcon("../images/rightmenu_images/new.gif");
										//	menu.addContextMenuItem(menuitem4);
										//}
									
					                    //��������
									Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
									menuitem3.setName("����������ѯ");
									menuitem3.setLink("javascript:showJobList('" + jobId + "')");
									menuitem3.setIcon("../../sysmanager/images/gantt.gif");
									menu.addContextMenuItem(menuitem3);    
					                    //��λ�û���ְ����˵�
					                    //2008-3-25 baowen.liu
					                    if (control.checkPermission("globaljob","jobmanager",AccessControl.JOB_RESOURCE))
				                        {
					                         Menu.ContextMenuItem menuitem5=new Menu.ContextMenuItem();
											 menuitem5.setName("�û���ְ���");
											 menuitem5.setLink("javascript:post('" + jobId + "')");
											 menuitem5.setIcon("../../sysmanager/images/Host.gif");
											 menu.addContextMenuItem(menuitem5);
				                        }
			                        //}
					                        
			                        //��λȨ����Դ��ѯ
			                        //2008-3-26 baowen.liu
			                     
			                         //Menu.ContextMenuItem menuitem6=new Menu.ContextMenuItem();
									 //menuitem6.setName("��λȨ�޲�ѯ");
									 //menuitem6.setLink("javascript:resop('" + jobId + "')");
									 //menuitem6.setIcon("../../sysmanager/images/iconAction.GIF");
									 //menu.addContextMenuItem(menuitem6);
								 }
				              
								contextmenu.addContextMenu(menu);
								request.setAttribute("opjob", contextmenu);
							%>
							
							<tr class="labeltable_middle_td"  
								onmouseover="this.className='mouseover'"
								onmouseout="this.className= 'mouseout'">
								<td class="tablecells" nowrap="true">
									<P align="left">
										<pg:notequal colName="jobId" value="1">
											<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="jobId" defaultValue=""/>' <%=isDisabled %>>
										</pg:notequal>
										<pg:equal colName="jobId" value="1">
											<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" disabled="disabled">
										</pg:equal>
									</P>
								</td>
								<td id="opjob_<%=jobId%>"
									height='20' align=left class="tablecells" bgcolor="#F6FFEF">
									<pg:cell colName="jobName" defaultValue="����Ϊ��" />
									<pg:null colName="jobName">����Ϊ��</pg:null>
									<pg:equal colName="jobName" value="">����Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="jobNumber" defaultValue="���Ϊ��" />
									<pg:null colName="jobNumber">���Ϊ��</pg:null>
									<pg:equal colName="jobNumber" value="">���Ϊ��</pg:equal>
								</td>
								
								<td height='20' align=left class="tablecells">
									<pg:cell colName="jobRank" defaultValue="�ȼ�Ϊ��" />
									<pg:null colName="jobRank">�ȼ�Ϊ��</pg:null>
									<pg:equal colName="jobRank" value="">�ȼ�Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells" >
									<pg:cell colName="jobAmount" defaultValue="����Ϊ��" />
									<pg:null colName="jobAmount">����Ϊ��</pg:null>
									<pg:equal colName="jobAmount" value="">����Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="jobFunction" defaultValue="����Ϊ��" />
									<pg:null colName="jobFunction">ְ��Ϊ��</pg:null>
									<pg:equal colName="jobFunction" value="">����Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="jobDesc" defaultValue="����Ϊ��" />
									<pg:null colName="jobDesc">����Ϊ��</pg:null>
									<pg:equal colName="jobDesc" value="">����Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="jobCondition" defaultValue="��ְ����Ϊ��" />
									<pg:null colName="jobCondition">��ְ����Ϊ��</pg:null>
									<pg:equal colName="jobCondition" value="">��ְ����Ϊ��</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<%=userName%>��<%=userRealName%>��
								</td>
							</tr>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='center'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
							</td>
						</tr>
						<pg:contextmenu enablecontextmenu="true" context="opjob" scope="request" />
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);	
	String iconpath = request.getParameter("iconpath");
%>
<!-- 模态窗口刷新 -->
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/include/pager.js"
			type="text/javascript"></script>
		
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
		<!-- dwr end -->		
		
		<script>
			
			function setRadioSelect(){
			    var r = document.all.radioSelect;
			    var obj1=document.all.selectId;	
			    if(r==undefined){
			        alert("请先选择记录！");
			        return 0;
			    }
			    if(r.length==undefined){
			        if(r.checked){
			            obj1.value = r.value;			            		            
			            return 1; 
			        }else{
			            alert("请先选择记录！");
			            return 0;
			        }
			    }else{
			        var num = 0;
			        for(var i = 0;i<r.length;i++){
			            if(r[i].checked){			               
			                obj1.value = r[i].value;			                
			                num++;
			            }
			        }
			        if(num==0){
			            alert("请先选择记录！");
			            return 0;
			        }else{
			            return 1;
			        }
			    }	
			   		    
			}
			
			function cmd_ok(){
			    var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var obj1=document.all.selectId;			   		
			    parent.close();
			    window.returnValue=obj1.value;	    
			}	
			
		</script>
	</head>
 <tab:tabConfig/>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">

				
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">				
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>图片列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.menuconfigure.menu.ItemConfigIconList" keyName="itemConfigIconList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="itemConfigIconList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->							
							<input class="text" type="hidden" name="selectId" value="">
							<input name="delSingle" type="hidden" validator="string"
								maxlength="100" value="false">
							<td height='20' class="headercolor">
								
							</td>
							<td height='20' class="headercolor">
								 图片名称
							</td>							
							<td height='20' class="headercolor">
								 图片路径
							</td>
							<td height='20' class="headercolor">
								 图片预览
							</td>							
						</tr>

						<pg:param name="class_id" />
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有图片
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
						<pg:param name="iconpath" value="<%=iconpath %>"/>
								<tr class="labeltable_middle_tr_01"
									onMouseOver="this.className='mousestyle1'"
									onMouseOut="this.className= 'mousestyle2'">
									<td width="5" height='20' class="tablecells" nowrap="true" style="word-wrap:break-word;">
										<P align="left">
											<INPUT type="radio" name="radioSelect" id="radioSelect"												
												value='<pg:cell colName="fileCall" defaultValue=""/>'>
										</P>
									</td>									
									<td width="100" height='20' align=left class="tablecells" style="word-wrap:break-word;">
										<pg:cell colName="fileName" defaultValue="" />
									</td>
									<td width="550" height='20' align="center" class="tablecells" style="word-wrap:break-word;">
										<pg:cell colName="fileCall" defaultValue="" />
									</td>									
									<td width="550" height='20' align="center" class="tablecells" style="word-wrap:break-word;">
										<img src="<%=request.getContextPath()%>/<pg:cell colName="fileCall" defaultValue="" />" width="32" height="32">
									</td>
								</tr>
							

						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<input name="Submit" type="button" class="input" value="确定"
									onClick="cmd_ok()">
									<input name="Submit" type="button" class="input" value="关闭"
									onClick="window.close();">

							</td>
						</tr>
					</pg:pager>
				

				</table>

				<div align="center">
				</div>
		
		</div>
	</body>
	<%--<script type="text/javascript">
		applyChange.getApply("<%=app_id%>",showDate);
		
		function showDate(obj){			
			var r = document.all.radioSelect;
			var radio = "";
			if("<%=app_type%>"=="applyLogo"){
				radio = obj[10];				
			}else if("<%=app_type%>"=="applybackground"){
				radio = obj[9];	
			}
			for(var i = 0; i < r.length; i++){
   						if("<%=request.getContextPath()%>"+r[i].value == radio){
    							r[i].checked = true;
    							break;
   							}
						}
		}
	</script>--%>
	<script type="text/javascript">
		var r = document.all.radioSelect;
		for(var i = 0; i < r.length; i++){
			if(r[i].value == "<%=iconpath%>"){
					r[i].checked = true;
					break;
				}
		}
	</script>
</html>
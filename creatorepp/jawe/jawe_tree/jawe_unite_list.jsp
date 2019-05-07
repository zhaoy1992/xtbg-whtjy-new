<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
<head>  

	<script src="../../eformsys/fceform/js/fcpub.js"></script>

  <title>属性容器</title>
   <link rel="stylesheet" type="text/css" href="../../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
  <script type="text/javascript">  	
  	
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
			
			function cmd_ok()
			{
				var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var ec_id="0";
			    var mgrName=document.all.selectId.value;
				var tmp = escape(mgrName);
				//var url="jawe/xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp;			    
				var url=tmp;
			    parent.close();
			    window.returnValue=url;
			}
			
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ProcessForm" action="" method="post">

				
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=8>
							<b>流程列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.processmanage.dbmanager.PublishedUniteProcess" keyName="PublishedUniteProcess" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="PublishedUniteProcess"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
								</P>
							</td>
							<td height='20' class="headercolor">
								流程编号
							</td>
							<td height='20' class="headercolor">
								流程名称
							</td>
							<td height='20' class="headercolor">
								流程描述
							</td>
							<td height='20' class="headercolor">
								修改
							</td>
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>

						<pg:param name="ec_id" />
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有流程
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="radio" name="radioSelect"
											value='<pg:cell colName="pName" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="pId" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=dataSet.getString("pName").split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
								</td>

								<td height='20' align="left" class="tablecells">
									<input type="button" value="查看" onclick="openXpdl('<pg:cell colName="pName" defaultValue=""/>','<pg:cell colName="pId" defaultValue=""/>')"/>
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
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
	</body>

</html>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String ec_id = (String) request.getParameter("ec_id");
%>
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
		<script language="JavaScript" src="../../include/pager.js"
			type="text/javascript"></script>
		
		<script>
			
			//将选择的多选框的值赋给selectId
			function setSelectId()
			{
				
				var els=document.all.checkBoxOne;
				var obj1=document.all.selectId;		        
		        if(els==undefined){              //列表中没有一条记录的时候。
		        	alert("请先选择一个流程！");
		            return 0;
		        }
		        if(els.length==undefined){		 //列表中只有一条记录的时候，els的length就会为undefined				
					if(els.checked){
					    obj1.value=els.value;
					    return 1;
					}else{
					    alert("请先选择一个流程！");
		                return 0;
					}
				}else{                            //列表中有多条记录的时候。
					var num =0;
					for(var i=0;i<els.length;i++){		     
		            	if(els[i].checked){
		                	obj1.value=els[i].value;
		                	num++;		                
		            	}
		        	}
		        
		        	if(num>1){
		            	alert("只能选择一个流程！");
		            	return 0;
		        	}
		        
		        	if(num==0){
		           		alert("请先选择一个流程！");
		            	return 0;
		        	}
		        	return 1;
				}				
			}
			
			function setRadioSelect(){
			    var r = document.all.radioSelect;
			    var a = document.all.aaa;
			    var obj1=document.all.selectId;	
			    if(r==undefined){
			        alert("请先选择记录！");
			        return 0;
			    }
			    if(r.length==undefined){
			        if(r.checked){
			            obj1.value = r.value+"#"+a.value;			           
			            return 1; 
			        }else{
			            alert("请先选择记录！");
			            return 0;
			        }
			    }else{
			        var num = 0;
			        for(var i = 0;i<r.length;i++){
			            if(r[i].checked){			               
			                obj1.value = r[i].value+"#"+a[i].value;			                
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
				//alert(document.getElementsByName("aaa")[0].value);
				var check_num = setRadioSelect();
			    if(check_num==0){
			         return;
			    }
			    var ec_id="<%=ec_id%>";
			    var mgrName=document.all.selectId.value;
				var tmp = escape(mgrName);
				//var url="jawe/xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp;			    
				var url=tmp;
			    parent.close();
			    window.returnValue=url;
			}
			
			// 复选框全部选中
			function checkAll(totalCheck,checkName){	
	  	 		var selectAll = document.getElementsByName(totalCheck);
	   			var o = document.getElementsByName(checkName);
	   			if(selectAll[0].checked==true){
		   			for (var i=0; i<o.length; i++){
	      	  			if(!o[i].disabled){
	      	  				o[i].checked=true;
	      	  			}
		   			}
	   			}else{
		   			for (var i=0; i<o.length; i++){
	   	  	 	 		o[i].checked=false;
	   	   			}
	   			}
			}
	
			// 单个选中复选框
			function checkOne(totalCheck,checkName){
	   			var selectAll = document.getElementsByName(totalCheck);
	   			var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++){
					if(!o[i].disabled){
						if (o[i].checked==false){
							cbs=false;
						}
					}
				}
				if(cbs){
					selectAll[0].checked=true;
				}else{
					selectAll[0].checked=false;
				}
			} 
			
				function openXpdl(ec_id,mgrName)
				{
					var tmp = escape(mgrName);
					document.getElementById("divProcessing").style.display="block";
					document.getElementById("myFrame").src="<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=read&mgrName="+tmp;
				}   
		</script>
	</head>
 
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
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
					<pg:listdata dataInfo="com.chinacreator.epp.processmanage.dbmanager.PublishedProcess" keyName="PublishedProcess" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="PublishedProcess"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<!-- P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P -->
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
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
							</td>
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
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="pId" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=dataSet.getString("pName").split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
									<input type = "hidden" name = "aaa" id="aaa" value = '<pg:cell colName="remark" defaultValue="" />'>
								</td>

								<td height='20' align="left" class="tablecells">
									<input type="button" value="查看" onclick="openXpdl('<%=request.getParameter("ec_id") %>','<pg:cell colName="pName" defaultValue=""/>')"/>
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
		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
				<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
					<tr>
						<td bgcolor=#3A6EA5>
							<marquee align="middle" behavior="alternate" scrollamount="5">
								<font color=#FFFFFF>...处理中...请等待...</font>
							</marquee>
						</td>
					</tr>
				</table>
			</div>
		
		<iframe id="myFrame" scrolling="no" noresize frameborder="0"/>
	</body>
</html>
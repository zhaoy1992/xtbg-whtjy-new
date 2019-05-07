<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.AccessControl,
	com.chinacreator.epp.businessClassManager.businessManager.FormClassManager,
	com.chinacreator.epp.businessClassManager.vo.FormClass"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String eform_class = (String) request.getParameter("class_id");

	FormClassManager formClassManager = new FormClassManager();
	FormClass formClass = new FormClass();
	formClass = formClassManager.getFormClassByClassId(eform_class);
	String eform_class_name = formClass.getEc_name();

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
		<script language="JavaScript" src="../../../include/pager.js"
			type="text/javascript"></script>

		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcopendj.js"></script>
		<script src="../../fceform/js/fcselfuse.js"></script>	
		<script language="javascript">
			var djtype ="";
			function window_onload(){
				var sHtml=GetBillType(); //读取billtype.xml中的记录.
				djtype = sHtml.substring(sHtml.indexOf('value=')+7,sHtml.indexOf('value=')+9);
			}
		</script>
		<script>
			
			//将选择的多选框的值赋给selectId
			function setSelectId()
			{
				var els=document.all.checkBoxOne;
				var obj1=document.all.selectId;		        
		        if(els==undefined){              //列表中没有一条记录的时候。
		        	alert("请先选择一个表单！");
		            return 0;
		        }
		        if(els.length==undefined){		 //列表中只有一条记录的时候，els的length就会为undefined				
					if(els.checked){
					    obj1.value=els.value;
					    return 1;
					}else{
					    alert("请先选择一个表单！");
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
		            	alert("只能选择一个表单！");
		            	return 0;
		        	}
		        
		        	if(num==0){
		           		alert("请先选择一个表单！");
		            	return 0;
		        	}
		        	return 1;
				}				
			}
			
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
			    var url="/eformsys/fceform/common/djframe.htm?djsn="+obj1.value+"&djtype="+djtype;			    
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
					
			function showForm(e,djid)
			{
				//var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/common/djframe.htm?djsn="+djid+"&djtype="+djtype ;
				//open(sUrl);
				//DjOpen(djid,null,"展现","当前窗口","测试","");
				//var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/opendj.htm?djsn="+djid;
				var sUrl=location.protocol + "//"+location.host+fcpubdata.Path+"/fceform/design/design_show.htm?tbtype=3&djsn="+djid+"&eform_class=<%=eform_class%>";
				window.open(sUrl);
				//location.href=sUrl;
			}
		</script>
	</head>
   <%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onLoad="window_onload()">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">

				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
				<%if(eform_class_name==null){ %>
				    <tr>
				        <td height='30' class="detailtitle" align="center" colspan="9">
							<b>请选择左边的类别查看表单</b>				        
				        </td>
				    </tr>
			    <%}else{ %>
					<tr>
						<td height='30' class="detailtitle" align="center" colspan="9">
							<b>表单列表(<%=eform_class_name%>)</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.eform.formmanage.menu.PublishedFormList" keyName="PublishedFormList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="PublishedFormList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<!--  td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td-->
							<input class="text" type="hidden" name="selectId" value="">
							<input name="delSingle" type="hidden" validator="string"
								maxlength="100" value="false">
							<td height='20' class="headercolor">
								表单名称
							</td>
							<td height='20' class="headercolor">
								版本号
							</td>
							<td height='20' class="headercolor">
								创建日期
							</td>
							<td height='20' class="headercolor">
								创建人
							</td>
							<td height='20' class="headercolor">
								发布日期
							</td>
							<td height='20' class="headercolor">
								发布人
							</td>
							<td height='20' class="headercolor">
							    操作
							</td>
						</tr>

						<pg:param name="class_id" />

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有表单
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>

								<tr class="labeltable_middle_tr_01"
									onMouseOver="this.className='mousestyle1'"
									onMouseOut="this.className= 'mousestyle2'">
									<!-- td class="tablecells" nowrap="true">
										<P align="left">
											<INPUT type="radio" name="radioSelect"												
												value='<pg:cell colName="djid" defaultValue=""/>'>
										</P>
									</td-->
									<td height='20' align=left class="tablecells">
										<pg:cell colName="dj_name" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="dj_ver" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="creattime" defaultValue=""
											dateformat="yyyy-mm-dd hh24:mm:ss" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="creator" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="publishTime" defaultValue=""
											dateformat="yyyy-mm-dd hh24:mm:ss" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="publisher" defaultValue="" />
									</td>
									<td height="20" align="left" class="tablecells">
									    <input type="button" value="查看" onclick="showForm(this,'<pg:cell colName="djid" defaultValue=""/>')"/>
									</td>
								</tr>
							

						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01" >
							<td colspan=100 align='center'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<!-- input name="Submit" type="button" class="input" value="确定"
									onClick="cmd_ok()"-->
							</td>
						</tr>
					</pg:pager>
				<%} %>

				</table>

				<div align="center">
				</div>
			</form>
		</div>

	</body>
</html>
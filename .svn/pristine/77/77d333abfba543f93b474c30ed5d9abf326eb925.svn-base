<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<html>
<head>    
 <title>属性容器</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/opermanager/common.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");

function getOpergroupInfo(e,groupId)
{
	if (!basePropertiesContent)
	    basePropertiesContent = basePropertiesContainer.frames["base_properties_content"];
	if (jsAccessControl.setBackColor(e) && basePropertiesContent)
	{
		getPropertiesContent().location.href="<%=rootpath%>/sysmanager/opermanager/infoFrame.jsp?groupId="+groupId;
	}
}

function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;
	    
    for (var i=0;i<opergroupList.elements.length;i++) {
		var e = opergroupList.elements[i];
			
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		outMsg = "你确定要删除吗？(删除后是不可以再恢复的)。";
        	if (confirm(outMsg)){
				opergroupList.action="../opermanager/operManager.do?method=deleteOpergroup";
				opergroupList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("至少要选择一条记录！");
    	return false;
    }
	return false;
}

</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<center>
<%@ include file="/epp/css/cssControl.jsp"%><body  style="contentbodymargin" scroll="no">	
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_NAVIGATOR%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
    <form name = "opergroupList" method="post" action="">
	<table cellspacing="0" cellpadding="0" border="1" bordercolor="#EEEEEE" width=98% >
		<tr valign='middle'>
			<td height='30'align=center colspan=3><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>操作组列表</strong></td>
    	</tr>
		<pg:listdata dataInfo="OpergroupList" keyName="OpergroupList"/>
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="15"
				  scope="request"
				  data="OpergroupList"
				  isList="false">
			      <tr class="tabletop">
			      <!--设置分页表头-->
				  <th class="headercolor" align="center">操作组名称</th>
			      </tr>

				  <!--检测当前页面是否有记录-->
		       	  <pg:notify>
			      <tr height="18px" class="labeltable_middle_tr_01">
			      	<td colspan=100 align='center'>暂时没有操作组</td>
			      </tr>
			      </pg:notify>			      

			      <!--list标签循环输出每条记录-->		
 		          <pg:list>	
						<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getOpergroupInfo(this,'<pg:cell colName="groupId" defaultValue=""/>')" >
		      				<td class="tablecells" nowrap="nowrap"><pg:cell colName="groupName" defaultValue=""/></td>
					  	</tr>	
			      </pg:list>


			   
													
			      <input name="queryString" value="<pg:querystring/>" type="hidden">
		</pg:pager>
		
	</table>	

</form>	
   </div>
</div>
</body>
<center>
</html>

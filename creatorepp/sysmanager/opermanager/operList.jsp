<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<html>
<head>    
 <title>��������</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/opermanager/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");

function getOperInfo(e,opId)
{
	if (jsAccessControl.setBackColor(e) && basePropertiesContent)
	{
		parent.operInfo.operInfo.action="../opermanager/operManager.do?method=getOperInfo"+"&opId="+opId;
		parent.operInfo.operInfo.submit();	
	}
}

function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;
	    
    for (var i=0;i<operList.elements.length;i++) {
		var e = operList.elements[i];
			
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
        	if (confirm(outMsg)){
				operList.action="../opermanager/operManager.do?method=deleteOper";
				operList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("����Ҫѡ��һ����¼��");
    	return false;
    }
	return false;
}

	
</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<center>
<%@ include file="/epp/css/cssControl.jsp"%><body  style="contentbodymargin">	
    <form name = "operList" method="post" action="">
	<table cellspacing="0" cellpadding="0" border="1" bordercolor="#EEEEEE" width=98% >
		<tr valign='middle'>
			<td height='30'align=center colspan=4><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�����б�</strong></td>
    	</tr>
		<pg:listdata dataInfo="OperList" keyName="OperList"/>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="5"
				  scope="request"  
				  data="OperList" 
				  isList="false">
			      <tr class="tabletop">
			      <!--���÷�ҳ��ͷ-->
				    <th class="headercolor" width="10"><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')"></th>
				    <th class="headercolor">��������</th>
				    <th class="headercolor">��������</th>
				    <th class="headercolor">���ȼ�</th>
			      </tr>
			      <pg:param name="groupId"/>

				  <!--��⵱ǰҳ���Ƿ��м�¼-->
		       	  <pg:notify>
			      <tr height="18px" class="labeltable_middle_tr_01">
			      	<td colspan=100 align='center'>��ʱû�в���</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list��ǩѭ�����ÿ����¼-->			      
			      <pg:list>	
						<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getOperInfo(this,'<pg:cell colName="opId" defaultValue=""/>')" >
		      				<td class="tablecells" nowrap="nowrap"><input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="opId" defaultValue=""/>" ></td>
		      				<td class="tablecells" nowrap="nowrap"><pg:cell colName="opName" defaultValue=""/></td>
							<td class="tablecells" nowrap="nowrap"><pg:cell colName="opDes" defaultValue=""/></td>
							<td class="tablecells" nowrap="nowrap"><pg:cell colName="priority" defaultValue=""/></td>
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" class="labeltable_middle_tr_01">
			      	<td colspan=4 align='center'><pg:index/></td>
			      	<td align='left'>
					<input type="submit" value="ɾ��" class="input"
								onclick="javascript:dealRecord(1); return false;">
				</td>
			      </tr>   		
			      <input name="queryString" value="<pg:querystring/>" type="hidden">
		</pg:pager>
		
	</table>	
</form>	
<%@ include file="../sysMsg.jsp"%>
</body>
<center>
</html>

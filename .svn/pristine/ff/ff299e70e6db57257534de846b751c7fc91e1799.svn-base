
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
				 com.chinacreator.config.ConfigManager,
				 com.chinacreator.dictionary.DictAttachField"%>
<%@ page import="java.util.*"%>				 
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);	
	boolean isAdminFlag = accesscontroler.isAdmin();
	int i = 0;
	String currentOrgName = accesscontroler.getChargeOrg() != null ?accesscontroler.getChargeOrg().getRemark5():"";
    //机构编号
	String currentOrgIdNO = accesscontroler.getChargeOrgCode();
    //当前用户所属机构ID
    String currentOrgId = accesscontroler.getChargeOrgId();
	String did = (String)request.getAttribute("did");	
	if(did == null){
		did = request.getParameter("did");
	}
	//tab页
	//session.setAttribute("dictTabId", "2");
	//数据字典名称
	String dicttype_name = "";
	Data dtype = null;
	DictManager dictManager = null;
	if(did != null){
		dictManager = new DictManagerImpl();
		dtype = dictManager.getDicttypeById(did);
		dicttype_name = dtype.getName();
	}
	if(dtype == null){
		dtype = new Data();
	}	
	String dbname = dtype.getDataDBName();
    String tablename = dtype.getDataTableName();
    String dataNameField = dtype.getDataNameField();
    String dataValueField = dtype.getDataValueField();
    //新维护两个字段
    String data_name_cn = dtype.getField_name_cn()==""?"名称":dtype.getField_name_cn();
    String data_value_cn = dtype.getField_value_cn()==""?"真实值":dtype.getField_value_cn();
    
    //字典类型说明
    String description = dtype.getDescription();
    //数据项是否有效,在列表中体现,同时显示"停用/启用功能"
    boolean showDataValidate = false;
    String dataValidate = dtype.getData_validate_field();
    //数据项所属机构,可多个,缺省是登陆用户的机构,在新增的时候体现,在列表体现
    boolean showDataValueOrg = false;
    String dataValueOrg = dtype.getData_create_orgid_field();
    
    //是否有排序字段,决定是否显示排序按钮
    boolean showOrderButton = false;
    String dataOrderField = dtype.getDataOrderField();
    if(dataOrderField != null && dataOrderField.trim().length()>0){
        showOrderButton = true;
    }
    
    //字典数据:名称字段对象
    ColumnMetaData nameObj = DBUtil.getColumnMetaData(dbname,tablename,dataNameField);
    //字典数据:值字段对象
    ColumnMetaData valueObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueField);
    
    String nameValidType = dictManager.getValidatorTypeByColumnMetaData(nameObj);
    String valueValidType = dictManager.getValidatorTypeByColumnMetaData(valueObj);
    
    String dataValidateType = "";
    String dataValidateTypeName = "";
    String dataOrgType = "";
    String dataOrgTypeName = "";
    if(dataValidate != null && dataValidate.trim().length()>0){
        //字段数据:是否有效
        showDataValidate = true;
    	ColumnMetaData validateObj = DBUtil.getColumnMetaData(dbname,tablename,dataValidate);
        dataValidateType = dictManager.getValidatorTypeByColumnMetaData(validateObj);
        dataValidateTypeName = validateObj.getTypeName();
    }
    if(dataValueOrg != null && dataValueOrg.trim().length()>0){        
    	//字段数据:数据项所属机构
    	showDataValueOrg = true;
    	ColumnMetaData dataOrgObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueOrg);
        dataOrgType = dictManager.getValidatorTypeByColumnMetaData(dataOrgObj);
        dataOrgTypeName = dataOrgObj.getTypeName();
    }
	
    //查看采集的数据是否要过滤, 不是自己采集的,不能编辑修改删除....
    boolean needGatherFilter = dictManager.isDicttypeGatherMustFilter(dtype);
	
	List dictatts = dictManager.getDictdataAttachFieldList(did,-1);
	
	String rootpath = request.getContextPath();
	
	
	//处理高级字段查询条件 start  --highLevelColumni--advancedvaluei
	String isHeighlevel = request.getParameter("isHeighlevel");
	int numCount = 0;
	if(request.getParameter("numCount") != null){
		numCount = Integer.parseInt(request.getParameter("numCount"));
	}
	//System.out.println("numCount = " + numCount);
	StringBuffer attachFieldSql = new StringBuffer();
	if("highlevel".equals(isHeighlevel)){//是否为高级查询
		for(int count = 1; count <= numCount; count++){
			if(request.getParameter("highLevelColumn"+count) != null 
				&& !request.getParameter("highLevelColumn"+count).equals("")){//是否选择了高级字段  String<columnName|type>
				String columnNameorType = request.getParameter("highLevelColumn"+count);//String<columnName|type>
				String coulumnName = columnNameorType.split("\\|")[0];//高级字段名
				String type = columnNameorType.split("\\|")[1];//高级字段类型
				//System.out.println("columnNameorType = " + columnNameorType);
				//System.out.println("coulumnName = " + coulumnName);
				//System.out.println("type = " + type);
				if(type.equals("当前时间") || type.equals("选择时间")){
						String startDate = request.getParameter("startDate"+count);
						String endDate = request.getParameter("endDate"+count);
						if(startDate != null && !"".equals(startDate)){
							if(attachFieldSql.lastIndexOf("((a."+coulumnName) != -1){
								StringBuffer replaceStr = new StringBuffer();
								replaceStr.append("((a.");
								replaceStr.append(coulumnName).append(">=to_date('").append(startDate).append("'")
									.append(",'yyyy-mm-dd hh24:mi:ss')"); 
								if(endDate != null && !"".equals(endDate)){
									replaceStr.append(" and a.").append(coulumnName).append("<=to_date('").append(endDate)
										.append("','yyyy-mm-dd hh24:mi:ss'))");
								}
								replaceStr.append(" or (a.").append(coulumnName);
								String newStringBuffer = attachFieldSql.toString().replaceFirst("\\(\\(a."+coulumnName,
									replaceStr.toString());
								attachFieldSql.setLength(0);
								replaceStr.setLength(0);
								attachFieldSql.append(newStringBuffer);
							}else{
								attachFieldSql.append(" and ((a.");
								attachFieldSql.append(coulumnName).append(">=to_date('").append(startDate).append("'")
									.append(",'yyyy-mm-dd hh24:mi:ss')"); 
								if(endDate != null && !"".equals(endDate)){
									attachFieldSql.append(" and a.").append(coulumnName).append("<=to_date('").append(endDate)
										.append("','yyyy-mm-dd hh24:mi:ss')");
								}
								attachFieldSql.append("))");
							}
						}
				}else if(type.equals("选择机构") || type.equals("选择人员") || type.equals("当前用户") || type.equals("当前机构") || type.equals("选择字典")){
					String advancedvalue = request.getParameter("advancedvalue"+count);
					//System.out.println("attachFieldSql"+count+" = " + attachFieldSql.toString());
					if(advancedvalue != null && !"".equals(advancedvalue)){
						if(attachFieldSql.lastIndexOf("(a."+coulumnName) != -1){//条件成立说明选择了相同高级字段作为查询条件
							String newStringBuffer = attachFieldSql.toString().replaceFirst("\\(a."+coulumnName,
								"(a."+coulumnName+"='"+advancedvalue+"' or a."+coulumnName);
							attachFieldSql.setLength(0);
							attachFieldSql.append(newStringBuffer);
						}else{
							attachFieldSql.append(" and (a.").append(coulumnName).append("='")
								.append(advancedvalue).append("')");
						}
					}
				}else if(type.equals("文本类型") || type.equals("text")){
					String advancedvalue = request.getParameter("advancedvalue"+count);
					if(advancedvalue != null && !"".equals(advancedvalue)){
						if(attachFieldSql.lastIndexOf("(a."+coulumnName) != -1){//条件成立说明选择了相同高级字段作为查询条件
							String newStringBuffer = attachFieldSql.toString().replaceFirst("\\(a."+coulumnName,
								"\\(a."+coulumnName+" like \\'%"+advancedvalue+"%\\' or a."+coulumnName);
							attachFieldSql.setLength(0);
							attachFieldSql.append(newStringBuffer);
						}else{
							attachFieldSql.append(" and (a.").append(coulumnName).append(" like '%")
								.append(advancedvalue).append("%')");
						}
					}
				}
				//System.out.println("request.getParameter(highLevelColumn"+count+") = " + request.getParameter("highLevelColumn"+count));
				//System.out.println("request.getParameter(advancedvalue"+count+") = " + request.getParameter("advancedvalue"+count));
				
			}
		}
	}
	//System.out.println("attachFieldSql = " + attachFieldSql.toString());
	request.setAttribute("attachFieldSql",attachFieldSql.toString());
	//处理高级字段查询条件 end --highLevelColumni--advancedvaluei
%>
<html>
	<head>
		<title>属性容器</title>
		<link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<SCRIPT language="JavaScript" SRC="../user/validateForm.js"></SCRIPT>
		<script language="javascript" src="js/checkUnique.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >		
<div style="width:100%;height:430;overflow:auto"> 	
<table cellspacing="1" cellpadding="0" border="0" width=100%  class="thin">
<pg:listdata dataInfo="com.chinacreator.dictionary.tag.DictList" keyName="DictList" />
<!--分页显示开始,分页标签初始化-->
<pg:pager maxPageItems="9" scope="request" data="DictList" isList="false">
	<pg:param name="did" />
	<pg:param name="showdata" />
	<pg:param name="realitydata" />
	<pg:param name="occurOrg" />
	<pg:param name="isaVailability" />
	<pg:param name="numCount" />
	<pg:param name="isHeighlevel" />
	<% 
		for(int condition = 1; condition <= numCount; condition ++){
			String advancedvalue = "advancedvalue" + condition;
			String highLevelColumn = "highLevelColumn" + condition;
			String startDate = "startDate" + condition;
			String endDate = "endDate" + condition;
	%>
	<pg:param name="<%=advancedvalue %>" />
	<pg:param name="<%=highLevelColumn %>" />
	<pg:param name="<%=startDate %>" />
	<pg:param name="<%=endDate %>" />
	<%
		}
	%>
	<tr>
		<!--设置分页表头-->
		<td class="headercolor" >
			<input type="checkBox"  name="checkBoxAll" onClick="checkAll('checkBoxAll','dictDataId')">
		</td>						
		<td class="headercolor" nowrap ><%=data_name_cn%></td>								
		<td class="headercolor" colspan="2"  nowrap><%=data_value_cn%></td>
		<%
		    if(showDataValidate){
		%>
		    <td class="headercolor" colspan="1" nowrap  >是否启用</td>
		<%
		    }
		%>
		<%
		    if(showDataValueOrg){
		%>
		    <td class="headercolor" colspan="4" nowrap  >采集机构</td>
		<%
		    }
		%>
		<!--附加字段处理-->
			<%
			    for(int z=0;z<dictatts.size();z++){
			        DictAttachField dictatt = (DictAttachField)dictatts.get(z);
				//InputType inputType = dictatt.getInputType();	
		%>
			<td class="headercolor" nowrap ><%=dictatt.getDictFieldName()%></td>
		<%}%>
	</tr>

	
	<!--检测当前页面是否有记录-->
	<pg:notify>
		<tr height="18px" class="labeltable_middle_tr_01">
			<td colspan=100 align='center'>
				暂时没有数据
			</td>
		</tr>
	</pg:notify>

	<!--list标签循环输出每条记录-->
	<pg:list>
		<%
			String value = dataSet.getString("value");
			String name = dataSet.getString("name");
			Map primarykeys = dataSet.getMap("primarykeys");//得到主键信息;只包含高级字段的主键信息，字典定义中的主键信息不包含
			String primaryCondition = dictManager.getPrimarykeysCondition(primarykeys);
		%>
		<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
			<%
				String checkboxDisableFlag = "";
				if(needGatherFilter){
					//数据项保存的 所属机构
					String data_org = dataSet.getString("dataOrg");
                                
					//当前用户所属机构==数据项的所属机构, 可编辑修改删除数据项, 否则不行
					//超级管理员 能编辑修改删除 所有 数据项
					if(!isAdminFlag && !data_org.startsWith(currentOrgId)){
						checkboxDisableFlag = "disabled='true'";
					}
				}   
			%>
			<td class="tablecells" nowrap="nowrap" style="text-align:center">
				<input type="checkBox" <%=checkboxDisableFlag%> name="dictDataId" onClick="checkOne('checkBoxAll','dictDataId')" value="<pg:cell colName='value' defaultValue='' />:<pg:cell colName='name' defaultValue='' /><%if(primaryCondition != null && !"".equals(primaryCondition)) {%>:<%=primaryCondition %><%} %>" width="10">
				
			</td>							
			<td class="tablecells" nowrap="nowrap">
				<pg:cell colName="name" defaultValue="" />
			</td>									
			<td class="tablecells" nowrap="nowrap" colspan="2">
				<pg:cell colName="value" defaultValue="" />
			</td>
			<%
			    if(showDataValidate){
			%>
			    <td id="a<%=i++%>" class="tablecells" nowrap="nowrap" colspan="1" >
					<pg:equal colName="dataValidate" value="1">启用</pg:equal>	
							<pg:equal colName="dataValidate" value="0">停用</pg:equal>
				</td>
			<%
			    }
			%>
			<%
			    if(showDataValueOrg){
			%>
			    <td class="tablecells" nowrap="nowrap" colspan="4">
					<pg:cell colName="dataOrg" defaultValue="" />
				</td>
			<%
			    }
			%>
			<!--附加字段值处理-->
			<%
			    for(int j=0;j<dictatts.size();j++){
			        DictAttachField dictatt = (DictAttachField)dictatts.get(j);
				//InputType inputType = dictatt.getInputType();
				//张华俊2010-07-27日修改，传dictatt.getDictField()而非dictatt.getTable_column()
				String valueAttach = dictManager.getAttachValue(did,name,value,dictatt.getDictField(),primarykeys);	
			%>
			<td class="tablecells" nowrap="nowrap" ><%=valueAttach%></td>
			<%}%>
		</tr>
	</pg:list>
	<input name="dictTypeId" value="<%=did%>" type="hidden">
	<tr height="30" class="labeltable_middle_tr_01">
		<td colspan="100" align='center'>共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index />
		<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
	</tr>
</pg:pager>
</table>
</div>
</body>
</html>
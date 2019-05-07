<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri='/WEB-INF/dictionary.tld' prefix='dict'%>
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
<%@ page import="com.chinacreator.dictionary.input.InputType"%>
<%@ page import="com.chinacreator.dictionary.DictAttachField,
				com.chinacreator.dictionary.input.InputTypeScript,
				com.chinacreator.dictionary.input.InputTypeScriptImpl"%>
<%@ page import="java.util.*,com.chinacreator.sysmgrcore.entity.Organization,
                 com.chinacreator.sysmgrcore.manager.db.OrgCacheManager,
                 com.chinacreator.config.ConfigManager,
 				 com.chinacreator.dictionary.DictKeyWordManager,
 				 com.chinacreator.dictionary.DictKeyWordManagerImpl,
 				 com.chinacreator.dictionary.KeyWord,
 				 com.chinacreator.dictionary.input.InputTypeScript"%>
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	DictKeyWordManager dictKeyWordManager = new DictKeyWordManagerImpl();
	KeyWord keyWord = null;
	String currentOrgName = accesscontroler.getChargeOrg() != null ?accesscontroler.getChargeOrg().getRemark5():"";
	String currentOrgIdNO = accesscontroler.getChargeOrgCode();
    String ids = (String)request.getParameter("dicttypeId");
    String validateState = request.getParameter("validateState");
    String[] id = ids.split(":");
    String dicttypeId = "";
    String parent_id = "";
    if(id !=null && id.length>1){
        dicttypeId = id[0];
        parent_id = id[1];
    }else{
    	dicttypeId = ids;
    }
    DictManagerImpl dictManager = new DictManagerImpl();
    //为了获取上线信息,做初始化.
    dictManager.init(request,response);
    Data dicttype = dictManager.getDicttypeById(dicttypeId);
    String dbname = dicttype.getDataDBName();
    String tablename = dicttype.getDataTableName();
    String dataNameField = dicttype.getDataNameField();
    String dataValueField = dicttype.getDataValueField();
    String dataValidate = dicttype.getData_validate_field();
    //是否显示 显示数据,真实数据
    String dictName = dicttype.getDataNameField()==null?"":dicttype.getDataNameField().trim();
    String dictValue = dicttype.getDataValueField()==null?"":dicttype.getDataValueField().trim();
    boolean showDictName = false;
    boolean showDictValue = false;   

    if(!"".equals(dictName)){
        showDictName = true;
    }    
    if(!"".equals(dictValue)){
        showDictValue = true;
    }
    
    //新维护两个字段
    String data_name_cn = dicttype.getField_name_cn()==""?"名称":dicttype.getField_name_cn();
    String data_value_cn = dicttype.getField_value_cn()==""?"真实值":dicttype.getField_value_cn();
    
    //判断真实值是否可以修改
    boolean enableValeModify = dicttype.isEnableValueModify();
    
    //数据项所属机构,可多个,缺省是登陆用户的机构,在新增的时候体现,在列表体现
    boolean showDataValueOrg = false;
    String dataValueOrg = dicttype.getData_create_orgid_field();
    //表对象
    TableMetaData tableObj = DBUtil.getTableMetaData(dbname,tablename);
 //   String tableComments = tableObj.getRemarks();
 	String tableComments = dicttype.getDescription();//字典名称    
    String tableName = tableObj.getTableName();
    //字典数据:名称字段对象
    ColumnMetaData nameObj = DBUtil.getColumnMetaData(dbname,tablename,dataNameField);  
    
    //字典数据:值字段对象
    ColumnMetaData valueObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueField);    
    
    
    String nameValidType = dictManager.getValidatorTypeByColumnMetaData(nameObj);
    String valueValidType = dictManager.getValidatorTypeByColumnMetaData(valueObj);
    String nameNullable = nameObj==null?"":nameObj.getNullable();
    String valueNulable = valueObj==null?"":valueObj.getNullable();
    if("yes".equalsIgnoreCase(nameNullable)){
        nameNullable = "";
    }else{
        nameNullable = "<span style='color:red'>必填</span>";
    }
    
    if("yes".equalsIgnoreCase(valueNulable)){
        valueNulable = "";
    }else{
        valueNulable = "<span style='color:red'>必填</span>";
    }
    
    //数据项是否有效,在列表中体现,同时显示"停用/启用功能"
    boolean showDataValidate = false;
    String dataValidateType = "";
    String dataValidateTypeName = "";
    if(dataValidate != null && dataValidate.trim().length()>0){
        //字段数据:是否有效
        showDataValidate = true;
    	ColumnMetaData validateObj = DBUtil.getColumnMetaData(dbname,tablename,dataValidate);
        dataValidateType = dictManager.getValidatorTypeByColumnMetaData(validateObj);
        dataValidateTypeName = validateObj.getTypeName();
    }
    
    String dataOrgType = "";
    String dataOrgTypeName = "";
    ColumnMetaData dataOrgObj = null;
    if(dataValueOrg != null && dataValueOrg.trim().length()>0){        
    	//字段数据:数据项所属机构
    	showDataValueOrg = true;
    	dataOrgObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueOrg);
    	//所属机构的校验
        dataOrgType = dictManager.getValidatorTypeByColumnMetaData(dataOrgObj);
        dataOrgTypeName = dataOrgObj.getTypeName();
    }
    //处理附加字段
    String checkValue = request.getParameter("checkValue");
	String value = "";
	String name = "";
	String primaryCondition = "";//主键条件
    if(checkValue != null){
    	String[] checkValues = checkValue.split(":");
    	if(checkValues.length == 1)
    	{
	    	value = checkValues[0];
	    	name = "";
	    	primaryCondition = "";
	    }
	    else if(checkValues.length == 2)
	    {
	    	value = checkValues[0];
	    	name = checkValues[1];
	    	primaryCondition = "";
	    }
	    else if(checkValues.length == 3)
	    {
	    	value = checkValues[0];
	    	name = checkValues[1];
	    	primaryCondition = checkValues[2];
	    }
    }
    //字典对应的主键条件
    //System.out.println("primaryCondition = " + primaryCondition);
    List dictatts = dictManager.getAllDictdataAttachFieldList(dicttypeId, name, value, primaryCondition);
    String ownerOrgId = "";
    String ownerOrgName = "";
    if(dataValueOrg != null && !"".equals(dataValueOrg)){
	    ownerOrgId = dictManager.getDictDataPropertyValue(dicttypeId,  value,name,dataValueOrg,primaryCondition);
	    
	    Organization organization = OrgCacheManager.getInstance().getOrganization(ownerOrgId);
	    if(organization != null){
	        ownerOrgName = organization.getRemark5();
	    }
    }
    
    //启用停用开关
	boolean state = ConfigManager.getInstance().getConfigBooleanValue("enableDictButton", true);
	
	//高级关键字段
	//String attachKeyColumnNames = dictKeyWordManager.getDicattachfieldKey(dicttypeId);
	Map keywords = dictKeyWordManager.getAllKeyWords(dicttypeId);
	
	String rootpath = request.getContextPath();
%>  
<html>
    <head>
    <title>基础字典数据采集</title>
        <SCRIPT language="JavaScript" SRC="../../include/validateForm.js"></SCRIPT>
        <script language="javascript" src="../scripts/selectTime.js"></script>
        <script language="javascript" src="js/checkUnique.js"></script>
        <SCRIPT language="javascript">
			//var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
			var win;
			var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
			function unable(){
			    if(document.all.newbt) document.all.newbt.disabled = true;
				if(document.all.up) document.all.up.disabled = true;
		        if(document.all.down) document.all.down.disabled = true;        
		        if(document.all.top) document.all.top.disabled = true;
		        if(document.all.bottom) document.all.bottom.disabled = true;
		        if(document.all.save_order) document.all.save_order.disabled = true;
		        if(document.all.deletebt) document.all.deletebt.disabled = true;
		        if(document.all.changeState) document.all.changeState.disabled = true;
			}
			function closeWin(){
			    win.close();
			}
			function enable(){	  
			    if(document.all.newbt) document.all.newbt.disabled = false;
				if(document.all.up) document.all.up.disabled = false;
		        if(document.all.down) document.all.down.disabled = false;        
		        if(document.all.top) document.all.top.disabled = false;
		        if(document.all.bottom) document.all.bottom.disabled = false;
		        if(document.all.save_order) document.all.save_order.disabled = false;
		        if(document.all.deletebt) document.all.deletebt.disabled = false;
		        if(document.all.changeState) document.all.changeState.disabled = false;
			}
			function afterAddRefresh(){
			    document.location.href = document.location.href;
			}
			function afterDeleteRefresh(){
			    afterAddRefresh();
			}
			
			function orgSelectFinal(obj){
				var valueWin = window.showModalDialog("orgSelectTree.jsp?orgNames="+obj.value,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				if(valueWin!=null){
					obj.value = valueWin.split("^")[0];
					if(document.all.dictDataValueOrg){
						document.all.dictDataValueOrg.value = valueWin.split("^")[1];
					}
				}
			}
			
	</SCRIPT>
		<link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%><body > 
        <form name="form1" method="post">
            <input type="hidden" name="dicttypeId" value="<%=dicttypeId%>">
            <input type="hidden" name="keyName" value="<%=name%>">
            <input type="hidden" name="keyValue" value="<%=value%>">
            <table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>高级添加数据</strong></td>
 				</tr>
 				<tr >   					
   					<td height='30' colspan="1" style="width:20%;text-align:right">
						字典对应的表名:
					</td>
					<td height='30' colspan="1" valign='middle' style="text-align:left" >
					    <%=tableName%><br>
					    【<%=tableComments%>】
					</td>
				</tr >
				
			<%
			    if(showDictName){
			    
			%>
 				<tr>   					
   					<td height='30' colspan="1" style="width:20%;text-align:right">
						<%=data_name_cn%>:
					</td>
					<td height='30' colspan="1" valign='middle' style="text-align:left" >
					
					    <input type="text" name="dictDataName" style="width:150px" maxlength="<%=nameObj==null?0:nameObj.getColunmSize()%>" validator="<%=nameValidType%>" cnname="<%=data_name_cn%>"
					     value="<%=name.trim()%>"
					     <%
					     	keyWord = new KeyWord();
					     	keyWord.setDictypeId(dicttypeId);
							keyWord.setFieldName(nameObj.getColumnName());
								if(dictKeyWordManager.defineKeyField(keyWord)){
							%>
								readonly="true"
							<%
								}
							%>
					     ><%=nameNullable%>
					</td>
				</tr -->
			<%
			    }
			%>
			
			<%
			    if(showDictValue){
			%>
				<tr>
					<td height='30' colspan="1" style="width:20%;text-align:right">
						<%=data_value_cn%>:
					</td>
					<td height='30' colspan="1" style="text-align:left" >
						<input 
						<% 
							keyWord = new KeyWord();
					     	keyWord.setDictypeId(dicttypeId);
							keyWord.setFieldName(valueObj.getColumnName());
							boolean bl = false;
							if(dictKeyWordManager.defineKeyField(keyWord)){
								bl = true;
							}
						
						if(bl || !enableValeModify) out.print("readonly=true"); 
						%> type="text" name="dictDataValue" style="width:150px" maxlength="<%=valueObj==null?0:valueObj.getColunmSize()%>"  validator="<%=valueValidType%>" cnname="<%=data_value_cn%>" value="<%=value.trim()%>"><%=valueNulable%>
					</td>
				</tr>
			<%
			    }
			%>
			
				<%				
				    if(showDataValidate){				        
				%>
				    <tr>
				    <td height='30' colspan="1"  style="width:20%;text-align:right">
						是否启用:	
					</td>
				    <td align="left" style="text-align:left">
						<select class="select" style="width:150px" <%if(!state){%>disabled="true"<%}%> name="dictDataValidate<%if(!state){%>1<%}%>">
						    <option value="1" <%if(validateState.equals("启用")){%>selected<%}%>>启用</option>
						    <option value="0" <%if(validateState.equals("停用")){%>selected<%}%>>停用</option>
						</select>
						<%if(!state){%>
							<input name="dictDataValidate" type="hidden" value="1" />
						<%}%> 
					</td>
					</tr>
				<%       
				    }
				%>
				<%
				    if(showDataValueOrg){					        
				%>
				    <tr>
				    <td height='30' colspan="1" style="width:20%;text-align:right">
						采集机构:
					</td>
					<td height='30' colspan="1" style="text-align:left" >
					    <input type="hidden" name="dictDataValueOrg"  value="<%=ownerOrgId%>">
					    <input type='text' style='width:200px' name="dictDataValueOrg_name" readonly='true' value="<%=ownerOrgId%> <%=ownerOrgName%>"   >
					    <input type='hidden' name='ownOrgLenth' value="<%=dataOrgObj.getColunmSize()%>" >
					    
					</td>
					</tr>
				<%      
				    }
				%>
 				<!--附加字段处理-->
 				<%
 				    for(int i=0;i<dictatts.size();i++){
 				        DictAttachField dictatt = (DictAttachField)dictatts.get(i);
						InputTypeScript inputTypeScript = dictatt.getInputTypeScript();					
						
				%>
				    <tr>
				    <td height='30' colspan="1" style="width:20%;text-align:right">
						<%=dictatt.getDictFieldName()%>:
					</td>
					<td height='30' colspan="1" style="text-align:left" >
					    <%
					        if("text".equalsIgnoreCase(dictatt.getInputTypeName())
					           || "文本类型".equalsIgnoreCase(dictatt.getInputTypeName())){
					            //..
					        }else if("选择字典".equalsIgnoreCase(dictatt.getInputTypeName())){
					            //...
					        }else if("选择时间".equalsIgnoreCase(dictatt.getInputTypeName())){
					            //...
					        }else if("主键生成".equalsIgnoreCase(dictatt.getInputTypeName())){
					            //...
					        }else if("主键生成".equalsIgnoreCase(dictatt.getInputTypeName())){
					            //...
					        }else if("选择机构".equalsIgnoreCase(dictatt.getInputTypeName())
					        	|| "选择人员".equalsIgnoreCase(dictatt.getInputTypeName())){
					        	//..
					        }
					        String outputHtml = inputTypeScript.getEditExtendHtmlContent(request,response,keywords);
					       //System.out.println("dictatt.getDictFieldName() = " + dictatt.getDictFieldName());
					        //System.out.println("outputHtml = " + outputHtml);
					    %>
					    <!--输出的内容-->
					    <%=outputHtml%>
					</td>
					</tr>
				<%		
						
 				    }
 				%>
 				<tr>
 				    <td height='30' colspan="1"  >
 				    
					</td>
 				    <td height='30' colspan="1"  >  					
					    <input name="newbt" type="button" class="input" value="保存" onClick="saveit()">
					    <input name="advance_newbt" type="button" class="input" value="关闭" onClick="window.close()">
					</td>
 				</tr>
			</table>
		</form>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
	<script>
	    var win;
	    function saveit(){
	    	if("true"=="<%=showDictName%>"){
	    		var dictDataName = document.all("dictDataName").value;	    		
	    		if (trim(dictDataName).length == 0 ){
	    			alert("<%=data_name_cn%>不能为空");
	    			return false;
	    		}
	    	}
	    	
	    		var dictDataValue = document.all("dictDataValue").value;	    		
	    		if (trim(dictDataValue).length == 0 ){
	    			alert("<%=data_value_cn%>不能为空");
	    			return false;
	    		}	    
	    
	        var ownOrgLenth = 0;
	        var dictDataValueOrg = "";
	        if(document.all.dictDataValueOrg) dictDataValueOrg = document.all.dictDataValueOrg.value;
	        if(document.all("ownOrgLenth")) ownOrgLenth = document.all("ownOrgLenth").value;
	        if(dictDataValueOrg.length>ownOrgLenth){
	            alert("按要求必须输入 “所属机构”的数据！\n数据必须为：指定长度"+ownOrgLenth);
	            return false;
	        }
	        if (validateForm(form1) ){	
		        document.form1.action="dictAdvanceUpdatedata.jsp?parentValue=<%=parent_id%>&primaryCondition=<%=primaryCondition%>";
		        document.form1.target="hiddenFrame";
		        win = window.showModelessDialog("doing.jsp","",featrue);
				document.form1.submit();
		        
		    } 	
	    }
	    function afterSave(){	    	
 	        window.returnValue = "ok";
 	        window.close();
 	    }
 	    function saveFaild(){
 	    	
 	        //window.close();

 	    }
 	    //去除字符串空格
		function trim(string){
			var temp="";
			string = ''+string;
			splitstring = string.split(" ");
			for(i=0;i<splitstring.length;i++){
				temp += splitstring[i];
			} 
			return temp;
		}
	</script>
</html>
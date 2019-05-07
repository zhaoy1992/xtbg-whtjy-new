<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.TableMetaData"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);	
    String did = request.getParameter("did");
    did = did==null?"":did;
    
	List poollist = new ArrayList();
	DBUtil dbUtil = new DBUtil();
	Enumeration pools = dbUtil.getAllPoolnames();
	while(pools.hasMoreElements()){
		String poolname = (String)pools.nextElement();
		poollist.add(poolname);
	}
	List tlist = new ArrayList();
    
	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>创建字典类型</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
  <script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>

<script language="javascript">
	var sel = new Array();
    var win;	
    var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
	function getDbNames(e){
		var path = "select_dbName.jsp?dbname="+e.value;
	    win = window.showModalDialog(path,window,featrue);
	    e.value = win;
	}
    function getTables(e){
        var dbname = document.all.db_name.value;
        if(dbname!=""){
			var path = "select_tableName.jsp?dbname="+dbname+"&tablename="+e.value;
			win = window.showModalDialog(path,window,featrue);
			//e.value = win;
		}
	}	
    function getColumns(e){
        var selected_values = "";   
        //动态的字段处理
        if(document.all.attachfieldname){
            var arr = new Array();
	        arr = document.getElementsByName("attachfieldname");
	        for(var i=0;arr!=null&&i<arr.length;i++){
	            if(selected_values=="") selected_values = selected_values+arr[i].value;
	            else selected_values = selected_values+","+arr[i].value;
	        }
        }        
        var dbname = document.all.db_name.value;
        var tablename = document.all.table_name.value;
        if(dbname!="" && tablename!=""){
	        var path = "select_tableField.jsp?dbname="+dbname+"&tablename="+tablename+"&column="+e.value+"&otherSelected="+selected_values+"&fieldName="+e.name;
			win = window.showModalDialog(path,window,featrue);
			e.value = win;
		}
    }
	function addRow(){
		var etable = document.all("EWTable");
		var row1 = etable.insertRow();
		var td1 = document.createElement("td");
		var td2 = document.createElement("td");
		var td3 = document.createElement("td");
		var td4 = document.createElement("td");
		td1.innerHTML = "<td align='center'><input type='checkbox' name='id' onclick ='checkOne(\"checkBoxAll\",\"id\")'/></td>"
		td2.innerHTML = "<td align='center'><input type='text' name='attachfieldname' readonly='true' onclick='getColumns(this)'></td>";
		td3.innerHTML = "<td align='center'><input type='text' name='attachlabel' value='' /></td>";
		td4.innerHTML = "<td align='center'><input type='text' name='attachinputtype' class='select'></td>";
        row1.appendChild(td1);
		row1.appendChild(td2);
		row1.appendChild(td3);
		row1.appendChild(td4);		
	}
		
	function delRow(){
		var etable = document.all("EWTable");
		var isSlected = false;
		if(document.all("id")){
			var del = document.all("id");		
			for(var i=0;i<del.length;i++){
				if(del[i].checked){
					isSlected = true;
					etable.deleteRow(i+1);
					i=i-1;
				}
			}
		}
		if(!isSlected){
		    alert("请选择附加字段");
		}
	}

	//删除总按钮行为
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

	//各个删除按钮行为
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
	function unable(){
		if(document.all.saveButton) 	document.all.saveButton.disabled = true;
        if(document.all.deleteButton) 	document.all.resetButton.disabled = true;
	}
	function closeWin(){
	    win.close();
	}
	function enable(){	    
        if(document.all.saveButton) 	document.all.saveButton.disabled = false;
        if(document.all.deleteButton) 	document.all.resetButton.disabled = false;
	}
    function highLevel(){        
        if(document.all.highLevelButton.value == "高级选项"){
            document.all.highLevel.style.display = "block";
            //document.all.attFieldDiv.style.display = "block";
            document.all.highLevelButton.value = "普通选项"
        }else{
            document.all.highLevel.style.display = "none";
            //document.all.attFieldDiv.style.display = "none";
            document.all.highLevelButton.value = "高级选项"
        }
    }    
    
    function saveit(){
	    if(document.all.type_name.value==""){
	        alert("字典类型名称,必须填写!");
	        document.all.type_name.focus();
	        return false;
	    }
	    if(document.all.type_dsc.value==""){
	        alert("字典类型说明,必须填写!");
	        document.all.type_dsc.focus();
	        return false;
	    }
	    var arr = document.getElementsByName("is_tree");
	    var dicttypeUseTabelState = document.getElementsByName("dicttypeUseTabelState");
	    if(document.all.db_name && document.all.db_name.value !="" &&  
	      document.all.table_name && document.all.table_name.value !=""){
	        
	        if((document.all.field_name && document.all.field_name.value=="" ) ||  
	           (document.all.field_value && document.all.field_value.value=="") 
	          
	        ){
	            alert("必须指定的【名称字段】和【值字段】!");
		        return false;
	        }	    
		    	                    
            if(arr[0].checked==true && (document.all.field_parentid && document.all.field_parentid.value=="" ) ){
                alert("指定的字段必须填写完整!");
		        return false;
            }    
            if(dicttypeUseTabelState==1){
                alert("该数据库表已经被其他字典类型单独使用!");
                return false;
            }else if(dicttypeUseTabelState==2){
                if(document.all.field_typeid && document.all.field_typeid.value==""){
					alert("该表已经被其他字典共享使用,必须指定【字典类型字段】!");
	                return false;                    
                }
            }    
            //选了更新数据, 必须填写字典类型字段
            var update_dcitData_typeId;
            if(document.all.update_dcitData_typeId) update_dcitData_typeId = document.all.update_dcitData_typeId;
            if(update_dcitData_typeId.checked && document.all.field_typeid && document.all.field_typeid.value==""){
                alert("选中了【是否更新数据】,必须指定【字典类型字段】!");
	            return false;
            }    
	    }
	    var is_tree = 0;
	    if(arr[0].checked==true){
	        is_tree = 1;
	    }
		unable();
		var path = "dictSaveType.jsp?did=<%=did%>&opt=insert&is_tree="+is_tree;
		var updateTypeids = document.getElementsByName("update_dcitData_typeId");
		if(updateTypeids[0]){
		    if(updateTypeids[0].checked==true){
		        path = path + "&update_typeId=1"
		    }
		}
		win = window.showModelessDialog("doing.jsp","",featrue);
		document.createTypeForm.action = path;
		document.createTypeForm.submit();
		getNavigatorContent().location.reload();
	}
	function newDict(did){
        window.location.href = "newDict.jsp?did="+did;
    }
    window.onload = function initPage(){
        document.all.highLevelButton.value = "高级选项";
    }
    function afterAddRefresh(){
        newDict("<%=did%>");
        getNavigatorContent().location.href=getNavigatorContent().location.href;
    }
    /**
     * e 触发改变显示的对象
     * labelDiv 改变显示的label的DIV名称
     * filedDiv 改变显示的字段的DIV名称
     * changeFiled 改变显示的字段名称
     */
    function changeDisplay(e,labelDiv,filedDiv,changeFiled){ 
        var str = e.name;      
        if(document.getElementsByName(str)){        
            var arr = document.getElementsByName(str);
            if(arr[0].checked==true){
                if(document.getElementsByName(filedDiv)){
                    document.getElementsByName(labelDiv)[0].style.display="block";
                    document.getElementsByName(filedDiv)[0].style.display="block";
                }
            }else{
                if(document.getElementsByName(filedDiv)){
                    document.getElementsByName(changeFiled)[0].value="";
                    document.getElementsByName(labelDiv)[0].style.display="none";
                    document.getElementsByName(filedDiv)[0].style.display="none";
                }
            }
        }
    }  
    
    //如果选择缓冲字典数据，那么值字段就不允许选择修改。值字段允许修改，那么字典数据就不能缓冲。
    function onclikHiden(ck){
    	var evm = "enable_value_modify";
    	var nee = "needcache";
    	var ckName = ck.name;
    	if (ckName == evm) {
    		var ckOther = document.getElementsByName(nee)[0];
    		if(ck.checked){
    			ckOther.checked = false;
    			ckOther.disabled = "disabled";
    		}else{
    			ckOther.disabled = "";
    			
    		}
    	} else if (ckName == nee) {
    		var tree = document.getElementsByName("is_tree")[0];
    		if(tree.checked){
    			ck.checked = true;
    			alert("树型字典数据必须缓冲！");
    			return false;
    		}
    		
    		var ckOther = document.getElementsByName(evm)[0];
    		if(ck.checked){
    			ckOther.checked = false;
    			ckOther.disabled = "disabled";
    		}else{
    			ckOther.disabled = "";
    		}
    	} else {
    		//如果选择字典数据为树型，那么字典数据必须缓冲。
    		var ckOther1 = document.getElementsByName(nee)[0];
    		var ckOther2 = document.getElementsByName(evm)[0];
    		if(ck.checked){
	    		ckOther1.checked = true;
	    		ckOther2.checked = false;
	    		ckOther2.disabled = "disabled";
    		}else{
    			ckOther1.checked = false;
    			ckOther1.disabled = "";
    			ckOther2.disabled = "";
    		}
    	}
    }
    
    function resertdictfield(){
    	document.createTypeForm.action = "resertDictFieldTypeConfig.jsp";
		document.createTypeForm.submit();
    }
</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body >
<form name="createTypeForm" method="post" target="savetype">
<input type="hidden" name="dicttypeUseTabelState" value="">
<table  width="100%" border="0" style="border-bottom:0xp"  cellpadding="1" cellspacing="0">
    <tr valign='top'>
   		<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>创建字典类型</strong></td>
 	</tr>
</table>
<table  width="100%" border="0"   cellpadding="1" cellspacing="0" class="thin">
    <tr>
        <td  valign="center" align="right" width="140" nowrap>
		    <strong>字典类型名称*：</strong>
	    </td>
		<td valign="middle" width="230" align="left">
		    <input type="text" name="type_name"  style="WIDTH:150" size="25" />
		</td>
	    <td  valign="center" align="right" width="140" nowrap>
			<strong>字典类型说明*：</strong>	
		</td>
		<td valign="middle" width="230" align="left">
		    <textarea name="type_dsc"  style="WIDTH:150" row=2></textarea>
		    <!--input type="text" name="type_dsc"  style="WIDTH:150" size="25" /-->
		</td>
    </tr>
</table>
<table  width="100%" border="0"   cellpadding="1" cellspacing="0" >
    <tr>
        <td  valign="top" align="right" width="100" nowrap>
		    
	    </td>
	</tr>
</table>
<!--高级插入-->
<div id="highLevel" style="display:none">
	<table  width="100%" border="0"   cellpadding="1" cellspacing="0" class="thin">
	    <tr>
	        <td  valign="top" width="140" align="right" nowrap>
			    <strong>数据库*：</strong>	
		    </td>
		    <td valign="middle" width="230" align="left">
		        <input type="text" readonly="true" name="db_name"  class="select" style="WIDTH:150" onclick="getDbNames(this)">				    
		  	</td> 
		  	<td  valign="top" align="right" width="140" nowrap>
			    <strong>数据项表*：</strong>	
		    </td>
		    <td valign="middle" width="230" align="left">
		        <input type="text" readonly="true" id="table_name" name="table_name" style="WIDTH:150"  class="select" onclick="getTables(this)">
		    </td>
	    </tr>
	    
	    <tr>
		   
		    <td  valign="top" align="right" nowrap>
			    <strong>名称字段*：</strong>	
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text" readonly="true" id="field_name" name="field_name"  style="WIDTH:150" class="select" onclick="getColumns(this)">
			</td>
			 <td  valign="top" align="right" nowrap>
			    <strong>值字段*：</strong>	
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text" readonly="true" id="field_value" name="field_value"  style="WIDTH:100" class="select" onclick="getColumns(this)">
		        <strong>生成规则：</strong>
		        <select class="select" name="key_general_type"  style="width:50px">
			        <option value="0">录入</option>
			        <option value="1">自动</option>
			    </select>
			</td>
		    
		</tr>
		
		<tr>
		   
		    <td  valign="top" align="right" nowrap>
			    <strong>名称字段&nbsp;&nbsp;<br>采集中文名称：</strong>	
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text"  id="field_name_cn" name="field_name_cn" value="名称" style="WIDTH:150" class="select" >
			</td>
			 <td  valign="top" align="right" nowrap>
			    <strong>值字段&nbsp;&nbsp;<br>采集中文名称：</strong>	
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text"  id="field_value_cn" name="field_value_cn" value="真实值"  style="WIDTH:150" class="select" >
			</td>
		    
		</tr>
		
		<tr>		    
		   <td  valign="top" align="right" nowrap>
			    <strong>排序字段：</strong>	
		    </td>   
		    <td valign="middle" align="left"> 
	            <input type="text" readonly="true" id="field_order" name="field_order" style="WIDTH:150"   class="select" onclick="getColumns(this)">
			</td>	
	        <td  valign="top" align="right" nowrap>			    
				    <strong>字典类型字段：</strong>
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text" readonly="true" id="field_typeid" name="field_typeid" style="WIDTH:150"  class="select" onclick="getColumns(this)">
			</td>	   
	    </tr>
	    
	    <tr>		    
		   <td  valign="top" align="right" >
			    <strong>数据项启用&nbsp;&nbsp;</strong><br><strong>标示字段：</strong>	
		    </td>   
		    <td valign="middle" align="left"> 
	            <input type="text" readonly="true" id="field_data_validate" name="field_data_validate" style="WIDTH:150"   class="select" onclick="getColumns(this)">
			</td>	
	        <td  valign="top" align="right" >			    
				    <strong>数据项采集&nbsp;&nbsp;</strong><br><strong>机构字段：</strong>
		    </td>    
		    <td valign="middle" align="left">
		        <input type="text" readonly="true" id="field_create_orgId" name="field_create_orgId" style="WIDTH:150"  class="select" onclick="getColumns(this)">
			</td>	   
	    </tr>
	    
	    <tr>		    
		   <td  valign="top" align="right" nowrap>
			    <strong>是否树形：</strong>	
		    </td>   
		    <td valign="middle" align="left"> 
	            <INPUT type="checkbox" name="is_tree" onclick="changeDisplay(this,'parentIdLabel','parentIdField','field_parentid');onclikHiden(this);">
			</td>
			<td  valign="top" align="right" nowrap>
			    	<strong>值字段的值可改变：</strong>
		    </td>    
		    <td valign="middle" align="left">
		        <input type="checkbox" name="enable_value_modify" value="1" onclick="onclikHiden(this)" /> 
			</td>		
	    </tr>
	    
	    <tr>		    
		   <td  valign="top" align="right" nowrap>
			    <strong>是否更新数据：</strong>	
		    </td>   
		    <td valign="middle" align="left"> 
	            <input type="checkbox" name="update_dcitData_typeId" value="1" >
			</td>
			<td  valign="top" align="right" nowrap>
	            <strong>是否缓冲数据：</strong>
		    </td>    
		    <td valign="middle" align="left" nowrap="nowrap">
		       <input type="checkbox" name="needcache" value="1" onclick="onclikHiden(this)"/>
			</td> 
	    </tr>
	    
	    <tr>
	    	<td colspan="99" align="right">
	    		<input type="button" name="resrtdictfieldtype" value="重置字段类型缓存" class="input" onclick="resertdictfield();">
	    	</td>
	    </tr>
	    
	    <tr>		    
		   <td  valign="top" align="right" nowrap>
	            <div id="parentIdLabel" style="display:none">
			    	<strong>父类ID字段*：</strong>	
			    </div>
		    </td>    
		    <td valign="middle" align="left">
		        <div id="parentIdField" style="display:none">			        
	      			<input type="text" id="field_parentid" name="field_parentid" readonly="true" style="WIDTH:150"  class="select" onclick="getColumns(this)">
	      		</div>
			</td>
			<td  valign="top" align="right" nowrap>
		    </td>    
		    <td valign="middle" align="left">
			</td>
	    </tr>
		
	</table>	
</div>	
    <table  width="100%" border="0"   cellpadding="1" cellspacing="0" >
	    <tr>
	        <td  valign="top" align="right" width="140" nowrap>			    
		    </td>
		</tr>
	</table>

	<table  width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
		<tr>
	        <td  valign="top" align="right" width="140" nowrap>	
	            <strong>字典类型种类：</strong>	    
		    </td>
			<td valign="middle" width="230" align="left">
			    <select class="select" name="dicttype_type"  style="width:150px">
			        <option value="0">基础字典</option>
			        <option value="1">通用业务字典</option>
			        <option value="2">授权业务字典</option>
			        <option value="4">不维护数据授权业务字典</option>
			        <option value="5">不维护数据通用业务字典</option>
			    </select>		    
			</td>
		    <td  valign="top" align="right" width="140" nowrap>	
		        <input type="button" value="" id="highLevelButton" class="input" onclick="highLevel()"/>	
			</td>
			<td valign="middle" width="230" align="left">
			<%
				if(did.equals(""))//如果是新增字典，且有此新增字典的全局操作权限，就显示保存按钮
				{
					ResourceManager resManager = new ResourceManager();
					String resId = resManager.getGlobalResourceid(AccessControl.DICT_RESOURCE);
					if (resId != null && !resId.equals("") && accesscontroler.checkPermission(resId,
	   							"add", AccessControl.DICT_RESOURCE))
					{
					%>
				    <input type="button" value="保存" id="saveButton" class="input" onclick="saveit()"/>	
					<%
					}
				}
				else//如果是新增子字典，且有此字典的新增子字典的操作权限，就显示保存按钮
				{
					if (accesscontroler.checkPermission(did, "addson", AccessControl.DICT_RESOURCE))
					{
					%>
				    <input type="button" value="保存" id="saveButton" class="input" onclick="saveit()"/>	
					<%
					}
				}
			%>
				
				<input type="button" value="重置" id="resetButton" class="input" onclick="reset()"/>
			</td>
	    </tr>	
	</table>
    <br><br>
    <table cellspacing="1" cellpadding="0" border="0" width=100%  class="thin"> 	
	    <tr valign='top'>
   		    <td height='30'valign='middle' colspan="10">&nbsp;<strong>字典类型种类说明</strong></td>
 	    </tr>			
 		<tr>
			<!--设置分页表头-->
			<td class="headercolor" >字典类型种类</td>
			<td class="headercolor" >【字典高级字段配置】模块</td>

			<td class="headercolor" >【基础字典数据采集】模块</td> 
			<td class="headercolor" >【通用业务数据采集】模块</td>
			<td class="headercolor" >【授权业务数据采集】模块</td>
			<td class="headercolor" >【机构授权编码维护】模块</td>
			<td class="headercolor" >【机构常用编码维护】模块</td>
		</tr>
		<tr>
			<td class="tablecells" >基础字典</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>

			<td class="tablecells" ><span style="color:red">维护</span></td> 
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
		</tr>
		<tr>
			<td class="tablecells" >通用业务字典</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>

			<td class="tablecells" >不维护</td> 
			<td class="tablecells" ><span style="color:red">维护</span></td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
		</tr>
		<tr>
			<td class="tablecells" >授权业务字典</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>

			<td class="tablecells" >不维护</td> 
			<td class="tablecells" >不维护</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
		</tr>
		<tr>
			<td class="tablecells" >不维护数据授权业务字典</td>
			<td class="tablecells" >不维护</td>

			<td class="tablecells" >不维护</td> 
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
		</tr>
		<tr>
			<td class="tablecells" >不维护数据通用业务字典</td>
			<td class="tablecells" >不维护</td>

			<td class="tablecells" >不维护</td> 
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" >不维护</td>
			<td class="tablecells" ><span style="color:red">维护</span></td>
		</tr>
	</table>
</form>
</body>
<iframe id="getfields" name="getfields" border="0" width="0" height="0" src=""></iframe>
<iframe id="gettables" name="getfields" border="0" width="0" height="0" src=""></iframe>
<iframe id="savetype" name="savetype" border="0" width="0" height="0" src=""></iframe>

</html>

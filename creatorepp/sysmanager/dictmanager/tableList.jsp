<%
/**
 * 项目：系统管理 
 * 描述：对于没有指定类型ID的字典类型,只能对应一个表.对于指定了类型ID的字典类型,才能多个类型共存于一个表
 * 版本：1.0 
 * 日期：2007.12.13
 * 公司：科创信息
 * @author ge.tao
 */
%>
<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl"%>
<%@ page import="com.chinacreator.dictionary.DictManager,com.frameworkset.util.RegexUtil"%>
<%
	DictManager dictImpl = new DictManagerImpl();	
	String dbname = (String)request.getParameter("dbname");	
	String selected_tablename = request.getParameter("selected_tablename");
	String queryTableName = request.getParameter("queryTableName")==null?"":request.getParameter("queryTableName");
	String ustate = request.getParameter("ustate")==null?"0":request.getParameter("ustate");
	dbname = dbname==null?"":dbname;	
	selected_tablename = selected_tablename==null?"":selected_tablename;	
		
	List tableList = new ArrayList();	
	List tableComments = new ArrayList();
	Set set = DBUtil.getTableMetaDatas(dbname);	
	Iterator it = set.iterator();
	boolean searchNone = false;
	//查询的queryTableName放到第一位
	int similarCount = 0;
	while(it.hasNext()){
		TableMetaData  metaData = (TableMetaData )it.next();
		String tname = metaData.getTableName();
		
		//有查询匹配的表名 放到第一位
		boolean firstFlag = false;		
		
		if(RegexUtil.isContain(tname,queryTableName)){
		    firstFlag = true;
		    similarCount ++;
		}
		
		int state = dictImpl.getDictTypeUseTableStates(dbname,tname);
		if(state==DictManager.DICTTYPE_USE_TABLE_SHARE){//和其他类型公用 		    
		    tname = tname + ":" + DictManager.DICTTYPE_USE_TABLE_SHARE;
		}else if(state==DictManager.DICTTYPE_USE_TALBE_SINGLE){//被其他类型独占		    
		    if(selected_tablename.equalsIgnoreCase(tname)){//只有当编辑的时候,当前的表名==被独占的表名时,显示被选中,否则过滤,显示disabled
		        tname = tname + ":0";//被选中
		    }else{
		        tname = tname + ":" + DictManager.DICTTYPE_USE_TALBE_SINGLE;//不可选
		    }
		}else {//没有被其他类型使用
		    tname = tname + ":" + DictManager.DICTTYPE_USE_TABLE_FREE;
		}
		if(firstFlag){
		    tableList.add(0,tname);
		    tableComments.add(0,metaData.getRemarks());
		}else{		    
		   tableList.add(tname);
		   tableComments.add(metaData.getRemarks());
		}
	}
	
	if(similarCount==0){//没有一个匹配
	     searchNone = true;    
	}
	
%>
<html>
    <head>
        <title>选择数据库表</title>
        <link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">		
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
    </head>
    
    <%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" method="post" >
			<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr>
					<td class="headercolor" width="10">
						
					</td>
					<td class="headercolor" style="text-align:left">数据库表</td>
					<td class="headercolor" style="text-align:left">数据库表说明</td>
				</tr>
 			<%
 			    if(searchNone){
 			%>
 			    <tr>
 					<td class="tablecells" nowrap="nowrap">
						
					</td>
					<td class="tablecells" colspan="2" style="text-align:left" nowrap="nowrap">
					<span style="color:red">没有找到和查询条件匹配的数据库表</span>
					</td>
					
				</tr>
 			<%        
 			    searchNone = false;
 			    }
 			    for(int i=0;i<tableList.size();i++){
 			        String[] columnInfos = String.valueOf(tableList.get(i)).split(":");
 			        String name = "";
 			        String showStr = "";
 			        if(columnInfos.length==2){
 			            name = columnInfos[0];
 			            if(columnInfos[1].equalsIgnoreCase(String.valueOf(DictManager.DICTTYPE_USE_TALBE_SINGLE))){
 			                showStr = " disabled=true ";
 			            } 			           
 			        }else{
 			            name = String.valueOf(tableList.get(i));
 			        }
 			        
 			        String remarks = (String)tableComments.get(i);
 			%>	
	 			<tr>	
	 				<td class="tablecells" nowrap="nowrap">
						<input type="radio" name="tablename" style="text-align:left" onclick="selectOne('tablename',this)" <%=showStr%> value="<%=tableList.get(i)%>" width="10">
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=name%>
					</td>
					<td class="tablecells" style="text-align:left">
					    <%=remarks!=null&&!remarks.trim().equals("")&&!remarks.trim().equals("null")?remarks:""%>
					</td>
				</tr>
			<%
			    }
			%>
		    </table>
		    </table>
			
		</form>
 	</body>
 	<script> 	    
 	    window.onunload = function setValue(){
 	        
 	        
 	        
 	        
 	        
 	    }
 	    window.onload = function autoRun(){
 	        var selected_value = "<%=selected_tablename%>";
 	        var dicttypeUseTabelState = <%=ustate%>;
 	        if(dicttypeUseTabelState==1) {//如果是1,说明是独占的,编辑状态要变成0,以供选择.
 	            dicttypeUseTabelState=0;
 	        }
 	        selected_value = selected_value + ":" + dicttypeUseTabelState;
 	        
 	        var arr = new Array();
 	        arr = document.getElementsByName("tablename");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==selected_value){
 	                arr[i].checked = true;
 	                break;
 	            }
 	        }
 	    }
 	    function selectOne(checkbox_name,e){
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==e.value){
 	                arr[i].checked = true;
 	            }else{
 	                arr[i].checked = false;
 	            }
 	        }
 	    }
 	    function removeValue(checkbox_name){
 	        var arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){ 	            
 	            arr[i].checked = false; 	            
 	        }
 	    }
 	    //num=0返回表名 
 	    //num=1返回表名:状态
 	    function getRadioValue(num){
 	        var arr = new Array();
 	        arr = document.getElementsByName("tablename");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].checked == true){
 	                if(num==0){
	 	                var v = arr[i].value.split(":");
	 	                if(v.length==2){
	 	                    //返回表名
	 	                    return v[0];
	 	                }
 	                }else{
 	                    return arr[i].value;
 	                }
 	                  
 	            }
 	        }
 	        return "";
 	    }
 	</script>
</html>
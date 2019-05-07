<%--
支持:财政厅门户显示oa公文
参数列表：(门户.张秀才:我们只传了busi_id  和 template_id 两个参数)
template_id 模板ID
busi_id 业务ID
--%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%!
	public static final Logger logger = Logger.getLogger("iwebOffice2006.jsp文件:");
	String cebversion = OASystemCache.getContextProperty("cebversion");
%>
<%
  
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName = "OfficeServer.jsp";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/oa/resources/plug/iWebOffice2009/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/xtbg/resources/plug/iWebOffice2009/";

  String mRecordID=request.getParameter("RecordID");//word实例ID
  String template_id = request.getParameter("template_id");//模板ID
  String busi_id = request.getParameter("busi_id");//业务ID
  //查询业务表、公文ID存放字段、业务表主键、
  String sql = "select t.table_id, t.column_id, tt.table_pk from OA_WORD_TEXTINPUT t, oa_md_table tt " +
   				"where t.template_id = '"+template_id+"' and t.textinput_value_type = '2' and t.table_id = tt.table_code";
  try{
	String[][] arr = DaoUtil.sqlToFieldsArray(sql);
	if(arr.length > 0){
		String querySql = "select "+arr[0][1]+" from " +arr[0][0] + " where " + arr[0][2] + " = '" + busi_id +"'";
		mRecordID = DaoUtil.sqlToField(querySql);
	}
  } catch(Exception e){
  
  }
  
  //取得编号
  if (mRecordID==null)
  {
     mRecordID="";	//编号为空
  }
  
%>
<html>
<head>
<title>在线查看</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>

//作用：载入iWebOffice
function Load(){
  try{
    //以下属性必须设置，实始化iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>";			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件

    webform.WebOffice.RecordID="<%=mRecordID%>";		//RecordID:本文档记录编号
    webform.WebOffice.Template="";		//Template:模板编号
    webform.WebOffice.FileName="";		//FileName:文档名称
    webform.WebOffice.FileType=".doc";		//FileType:文档类型  .doc  .xls  .wps
    webform.WebOffice.UserName="";		//UserName:操作用户名，痕迹保留需要
    webform.WebOffice.EditType="0,0";		//EditType:编辑类型  方式一、方式二  <参考技术文档>  
														//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
														//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
    webform.WebOffice.MaxFileSize = 16 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。

    webform.WebOffice.WebOpen();							//打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
    webform.WebOffice.ShowType="1";				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿

	webform.WebOffice.ShowMenu="0"	//不显示下拉菜单
	webform.WebOffice.VisibleTools("新建文件",false);
    //webform.WebOffice.VisibleTools("打开文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);
    webform.WebOffice.VisibleTools("打开文件",false);
	webform.WebOffice.VisibleTools("保存文件",false);
	webform.WebOffice.VisibleTools("全屏",false);
	webform.WebOffice.AppendTools("25","打  印",7);
	//响应工具栏事件
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
	    if(vIndex==25){
	    	webform.WebOffice.WebOpenPrint();
	    };
	}); 
	ShowRevision(webform,false);
  }catch(e){
    //alert(e.description);									//显示出错误信息
  }
}

//作用：退出iWebOffice
function UnLoad(){
  try{
	  if (!webform.WebOffice.WebClose()){
	     StatusMsg(webform.WebOffice.Status);
	  }else{
		  
	     StatusMsg("关闭文档...");
	  }
  }catch(e){
  	//alert(e.description);
  }
}
function ShowRevision(webform,mValue){
  if (mValue){
	 webform.WebOffice.WebSetRevision(true,true,false,false);
     //webform.WebOffice.WebShow(true);
     StatusMsg("显示痕迹...");
  }else{
	 webform.WebOffice.WebSetRevision(false,true,false,false);
    // webform.WebOffice.WebShow(false);
     StatusMsg("隐藏痕迹...");
  }
}

</script>
</head>
<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()">  <!--引导和退出iWebOffice ../../../../iWebOffice2006/DocumentSave.jsp-->
  <form name="webform" id="webform" method="post" action="iwebOffice2009.jsp?submit_flag=1" onsubmit="return SaveDocument();">  <!--保存iWebOffice后提交表单信息-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
 	<div id="webofficDiv" >
 	<OBJECT id="WebOffice" height="100%" width="100%" classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../../../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
	</form>
</body> 
</html>
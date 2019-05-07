<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean" %>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>

<%@page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String windowsId = request.getParameter("windowsId");
	String path = request.getContextPath();
    //查询出表单的配置OA_WORD_TEXTINPUT 放入隐藏域里 。每次输入或者提交前，将WORD标签的值放入隐藏域。
   	String template_id = request.getParameter("template_id");
	String isStartAdd = request.getParameter("isStartAdd");//如果是流程中发起的流程
	String extParms = StringUtil.deNull(request.getParameter("extParms"));//扩展参数，如果有多个请在这个参数里拼接拆分
    WordTemplateServiceIfc service = new WordTemplateServiceImpl();
    List<WordRuleItemBean> wordRuleItemBeanList = service.getRuleItemBeanList(template_id);
    String text_table_code = "";
    String text_column_code = "";
    String attach_id_name =""; //此变量只是保存了附件ID对应到业务表中的ID 而不是具体的值。在WORD中操作附件用到。
    String number_local = ""; //公文编码生成的位置。
    String number_title = ""; //公文编码生成的位置。
    String titleName = "";//标题的ID名称
    String titleLocal = "";//标题的位置
    String attach_local = ""; //附件生成的位置。
    String attach_glzd="";//过滤字段
    String isPublic_local = ""; //是否公开的位置。
    String isPublic_glzd="";//过滤字段
    for(int i=0; i<wordRuleItemBeanList.size();i++){
    	if("2".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
    		  //如果是正文类型，赋值
    		  text_table_code =wordRuleItemBeanList.get(i).getTable_id();
    		  text_column_code = wordRuleItemBeanList.get(i).getColumn_id();
    	}
    	if("3".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
  		  //如果是正文类型，赋值
  		  attach_id_name =wordRuleItemBeanList.get(i).getTable_id()+"__"+wordRuleItemBeanList.get(i).getColumn_id();
  		}
    	if("4".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
    		number_local = wordRuleItemBeanList.get(i).getTable_cell();
    		number_title = wordRuleItemBeanList.get(i).getTextinput_help();
    	}
    	if("5".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
    		titleName = wordRuleItemBeanList.get(i).getTable_id()+"__"+wordRuleItemBeanList.get(i).getColumn_id();
    		titleLocal = wordRuleItemBeanList.get(i).getTable_cell();
    	}
    	if("7".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
    		attach_local = wordRuleItemBeanList.get(i).getTable_cell();
    		attach_glzd=wordRuleItemBeanList.get(i).getTextinput_help();
    	}
    	if("9".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){
    		isPublic_local = wordRuleItemBeanList.get(i).getTable_cell();
    		isPublic_glzd = wordRuleItemBeanList.get(i).getTextinput_help();
    	}
    } 
    //WORD控件的大小控制
    int w_height = 768;
	int w_width = 1024;
    String height = request.getParameter("height");
	String width =  request.getParameter("width");
	if(!StringUtil.isBlank(height) && !StringUtil.isBlank(width)){
		w_height = Integer.parseInt(height)-5;
		w_width =  Integer.parseInt(width)-5;
	}
%>

<!DOCTYPE html>
<html style="overflow-y:no;">
<head>
<script src="<%=path%>/ccapp/oa/process/wordtemplate/js/wordtemplateutil.js" type="text/javascript"></script>
<oa:init>
<title>测试WORD发文</title>
<script>
	if(""=="<%=text_table_code%>" ){
		alert("没有查到正文ID配置，可能无法正常保存正文，请检查是否配置了正文ID！")
	}
	var FINGERPRINT = "";
	var inputList = [
	<%
	for(int i = 0 ; i < wordRuleItemBeanList.size(); i ++){
		if(!"2".equals(wordRuleItemBeanList.get(i).getTextinput_value_type()) && !"3".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){//组装需要遍历的表格
		String bid = wordRuleItemBeanList.get(i).getTable_id()+Constant.SEPARATOR+ wordRuleItemBeanList.get(i).getColumn_id();%>
	"<%=wordRuleItemBeanList.get(i).getTable_cell()+"#"+bid+"#"+wordRuleItemBeanList.get(i).getTextinput_help()%>",
	<%
		}
	}
	%>
	""];
	inputList.length = inputList.length - 1;
	
	function initWord(){
		
	}	
	
	//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
		//jQuery("#webofficDiv").show();
	}
	
	//将页面的操作类型修改，比如暂存成功后，不关闭页面的情况下需要将操作类型修改为upadate
	function resetOptType(opt_type){
		jQuery("#opt_type").val(opt_type);
		var ins_id = parms.flowParmJson.ins_id;
		if(ins_id){
			var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/sendtoarchivedo.jsp";
			jQuery.ajax({//AJAX将WORD正文上传至公文传输
				url: ajaxurl,
				type: 'POST',
				dataType:'text',
				data: {
					"ins_id":ins_id,
					"optType":"getTempActionId"
				},
				success: function(data){
					if(data){
						parms.flowParmJson.status_code = "04";
						parms.flowParmJson.actInsId = trim(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
				}
			})
		}
	}
	
	//此方法用于在提交表单的时候将WORD标签里的值SET入隐藏域
	function setInputValue(){
		var iWebOffice = document.getElementsByName("WebOffice")[0];
		for(var i = 0 ; i < inputList.length ; i ++){
			var value ="";
			var inputDef = inputList[i].split("#");//第一位 表格位置定义，第二位对应隐藏域ID，第三位过滤字段
			var tbaleDef ;
			if(!IsSpace(inputDef[0])){ //取出表格定义
				inputDef[0].replaceAll("，",",");
				tbaleDef = inputDef[0].split(",");
			}
			if(tbaleDef.length == 3&&iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果是表格，行，列的格式，那么去取值
				var table = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
				if(table){
					value = getTableCellValue(table,tbaleDef[1],tbaleDef[2]);	
					value = value.replaceAll(inputDef[2],"");//替换字符，去掉原标题
					value = value.replaceAll(" ","");
					value = value.replaceAll("","");//WORD控件里获取掉空格，保存时会有乱码问题，将其去掉。
				}
			}
			if(!IsSpace(value)){//放入隐藏域
				jQuery("#"+inputDef[1]).val(value);
			} 
		}
	}
	
	//短信配置回填
	function msgConfigReset(isdxtx,isyj,isznxx,isjsxx,msg_txt){
		jQuery("#isdxtx").val(isdxtx);
		jQuery("#isyj").val(isyj);
		jQuery("#isznxx").val(isznxx);
		jQuery("#isjsxx").val(isjsxx);
		jQuery("#msg_txt").val(msg_txt);
	}
	
	//是否公开配置回填
	function isPublicConfigReset(is_open,info_type){
		jQuery("#is_open").val(is_open);
		jQuery("#info_type").val(info_type);
		//jQuery("#webofficDiv").show();
	}
	
	/* //是否信息分类
	function isInfoTypeConfigReset(info_type){
		jQuery("#info_type").val(info_type);
		//jQuery("#webofficDiv").show();
	} */
	//督办
	function isChiefConfigReset(chief_endtime){
		jQuery("#chief_endtime").val(chief_endtime);
		//jQuery("#webofficDiv").show();
	}
	//获取光标所在位置，并设值
	function setSelectionValue(txtValue){
		var iWebOffice = document.getElementsByName("WebOffice")[0];
		var i = iWebOffice.WebObject.Tables.Count;
		var tables = iWebOffice.WebObject.Tables.Item(1);
		var selection = tables.Application.selection;//获取光标单元格
		selection.Text = selection.Text.replace(/<\?.+?>/g,"").replace(/[\r\n]/g, "")+txtValue;
		
	}
	
	//根据位置设置值
	function selectTextInput(tabelCell,txtValue) {
		var tbaleDef = tabelCell.split(",");
		if(tbaleDef.length == 3){
			var iWebOffice = document.getElementsByName("WebOffice")[0];
			if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
					var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
					if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
						var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
						if(cell){
							cell.Range.Text = cell.Range.Text.replace(/<\?.+?>/g,"").replace(/[\r\n]/g, "")+txtValue;
						}
					}
			}
		}
	}
	
	//根据位置设置值（此方法会替换出去之前定义的默认值的所有值）
	function selectTextInputNoAdd(tabelCell,title,txtValue) {
		var tbaleDef = tabelCell.split(",");
		if(tbaleDef.length == 3){
			var iWebOffice = document.getElementsByName("WebOffice")[0];
			if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
					var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
					if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
						var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
						if(cell){
							cell.Range.Text = title.replace(/<\?.+?>/g,"").replace(/[\r\n]/g, "")+txtValue;
						}
					}
			}
		}
	}
	
	//公文编号赋值
	function setNumber(txtValue){
		var number_local = "<%=number_local%>";
		var number_title = "<%=number_title%>";
		if(!IsSpace(number_local)){
			if(!IsSpace(number_title)){
				selectTextInputNoAdd(number_local,number_title,txtValue);
			}else{
				selectTextInputNoAdd(number_local,"",txtValue);
			}
			
		}else{
			setSelectionValue(txtValue);
		}
	}
	
	//公文编号取值
	function getNumber(){
		var numberVal = ""
		var number_local = "<%=number_local%>";
		if(!IsSpace(number_local)){
			var tbaleDef = number_local.split(",");
			var iWebOffice = document.getElementsByName("WebOffice")[0];
			var table = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
			numberVal = getTableCellValue(table,tbaleDef[1],tbaleDef[2]);
		}
		return numberVal;
	}
	//判断标题是否为空
	function isTitleNull(){
		var titlename=jQuery("#titleName").val();
		if(!IsSpace(titlename)){
			var name=jQuery("#"+titlename).val();
			if(IsSpace(name)){
				return false;
			}else{
				if(IsSpace(name.replace(/^\s+$/,""))){
					return false;
				} else{
					return true;
				}
			}
		}else{
			return true;
		}
	}
	
	//关闭
	function closeAlertWindowFun(){
		parent.frames["mainFrame"].$("#webofficDiv").show();
	}
	
	<%if("Y".equals(isStartAdd)){%>
		function afterActionSuccessFn(){
			getParentWindow('newwindows').afterActionSuccessFn();
		};
	<%}%>
	<%--零时脚本2014-3-28:支持财政厅项目变更模块 begin 建议:使用oa自定义标签+jsp的url参数,利用代理模式,在JSP页面的几个点插入自定义代码--%>
	<%--最终解释权 涛哥--%>
	<%if("true".equals(StringUtil.deNull(request.getParameter("setafterActionSuccess")))){%>
		function afterActionSuccessFn(){
			opener = getParentWindow('newwindows');
			if(opener&&opener.afterActionSuccessFn){
				opener.afterActionSuccessFn();
			}
		};
	<%}%>
	<%--零时脚本:支持财政厅项目变更模块 end--%>
	function fetchAttachMess(data){
		var tabelCell = "<%=attach_local%>";
		var attach_glzd="<%=attach_glzd%>"
		if(!IsSpace(tabelCell)){
			var tbaleDef = tabelCell.split(",");
			if(tbaleDef.length == 3){
				var iWebOffice = document.getElementsByName("WebOffice")[0];
				if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
						var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
						if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
							var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
							if(cell){
								cell.Range.Text = attach_glzd+data;
							}
						}
				}
			}
		}
	}

	function selectIsPublicInPut(value){
		var tabelCell = "<%=isPublic_local%>";
		var isPublic_glzd="<%=isPublic_glzd%>"
		if(!IsSpace(tabelCell)){
			var tbaleDef = tabelCell.split(",");
			if(tbaleDef.length == 3){
				var iWebOffice = document.getElementsByName("WebOffice")[0];
				if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
						var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
						if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
							var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
							if(cell){
								cell.Range.Text = isPublic_glzd+value;
							}
						}
				}
			}
		}
	}
</script>
</head>
<body style="width:<%=w_width%>px;height:<%=w_height%>px;margin:0 auto; " onload = "initWord()">
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId %>"/>
<input id="template_id" name="template_id" type="hidden" value="<%=template_id%>"/>
<%for(int i=0; i<wordRuleItemBeanList.size();i++){
	if(!"2".equals(wordRuleItemBeanList.get(i).getTextinput_value_type())){//将定义的表格放入隐藏域
		 String bid = wordRuleItemBeanList.get(i).getTable_id()+Constant.SEPARATOR+ wordRuleItemBeanList.get(i).getColumn_id();%>
		 <oa:input type='hidden' column='<%=wordRuleItemBeanList.get(i).getColumn_id() %>' table='<%=wordRuleItemBeanList.get(i).getTable_id() %>' value='' />
	<%	}
 } %>
 <input id="attach_id_name" name="attach_id_name" type="hidden" value="<%=attach_id_name%>"/>
 <input id="titleName" name="titleName" type="hidden" value="<%=titleName%>"/>
 <input id="titleLocal" name="titleLocal" type="hidden" value="<%=titleLocal%>"/>
 <!-- 消息配置隐藏域 -->
 <input type='hidden' name='isdxtx' id="isdxtx" value ='0'> <!-- 短信通知 -->
 <input type='hidden' name='isjsxx' id="isjsxx" value ='0'> <!-- 即时消息 -->
 <input type='hidden' name='isyj' id="isyj" value ='0'> <!-- 邮件通知 -->
 <input type='hidden' name='isznxx' id="isznxx" value ='0'> <!-- 站内消息-->
 <input type='hidden' name='msg_txt' id="msg_txt" value =''> <!-- 短信内容-->
 <input type='hidden' name='is_open' id="is_open" value =''> <!-- 是否公开-->
 <input type='hidden' name='info_type' id="info_type" value =''> <!-- 信息公开类型-->
 <input type='hidden' name='chief_endtime' id="chief_endtime" value =''> <!-- 督办结束时间-->
 <input type='hidden' name='extParms' id="extParms" value ='<%=extParms %>'> <!-- 扩展参数，如果有多个请在这个参数里拼接拆分-->
 
 <!-- 消息配置隐藏域 -->
<div id="tabs1" style="width:100%;border: 0px;">
		<oa:flowstart flowType="1" />
		<!--<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:30px">
			</tr>
			<tr style="height:30px">
				<td style="display: inline;">
				</td>
			</tr>
		</table>
		<iframe style="position:absolute; visibility:inherit; top:0px; left:0px; width:150px; height:200px; z-index:-1; filter='Alpha(style=0,opacity=0)';"></iframe>
		-->
		<div id="tabs-2">
			<oa:archivegoldgridword column="<%=text_column_code %>" table="<%=text_table_code %>"  width="100%" height="658px"/>
		</div>	
</div>	    		
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>

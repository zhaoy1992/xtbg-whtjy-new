<%-- 
描述：签名管理
作者：shuqi.liu
版本：1.0
日期：2013-08-27
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	//表单版传来的参数
	String table =StringUtil.deNull(request.getParameter("table"));
	String column =StringUtil.deNull( request.getParameter("column"));
	String user_name = accesscontroler.getUserName(); //用户中文名
	String cntab = StringUtil.deNull(request.getParameter("cntab"));
	//特检院意见 固定格式 2014-09-04
	cntab = "uuuu,tt";
	//意见缩进处理，暂时只支持表单版本
	String ctab = "";
	String ntab = "";	
	if(!StringUtil.isBlank(cntab)){
		String[] cntabs = cntab.split(",");
		if(cntabs!=null && cntabs.length ==2){
			ctab = cntabs[0].replaceAll("u","\u0020").replaceAll("t","\t");
			ntab = cntabs[1].replaceAll("u","\u0020").replaceAll("t","\t");;
		}
	}
	
	//end
	
	String msg_txt = request.getParameter("msg_txt");
	String isdxtx = request.getParameter("isdxtx");
	String isjsxx = request.getParameter("isjsxx");
	String isyj = request.getParameter("isyj");
	String isznxx = request.getParameter("isznxx");

	String path = request.getContextPath();

	StringBuffer sql = new StringBuffer();
	sql.append("select Idea_Content,Idea_Content from OA_DOCUMENT_COMIDEA where user_id is null or user_id='"
			+ accesscontroler.getUserID() + "'");

	String commonIdeaList = DictDropDownList.buildSelect(
			sql.toString(), "common_idea", "", "", false, "",
			"width:300px;height:100px;margin: 2px 0 2px;' multiple='multiple'");
	
	String value[][]=DictDropDownList.queryDictData(sql.toString());
	//签字顺序。
	String viewOeder = OASystemCache.getContextProperty("viewOeder");
	//日期格式
	String signdateformat = OASystemCache.getContextProperty("signdateformat");
	if(StringUtil.isBlank(signdateformat)){
		signdateformat = "yyyy-MM-dd HH:mm:ss";
	}
	String signDate = DateUtil.getFormatDate(signdateformat);
	
%>
<title>签名管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/myfancyupload.js"></script>
<script type="text/javascript">
//表单版传来的参数
var table = '<%=table%>';
var column = '<%=column%>';
var ycidearid = "YJ<%=Constant.SEPARATOR %>"+table+"<%=Constant.SEPARATOR %>"+column;//意见隐藏域
var idearid = table+"<%=Constant.SEPARATOR %>"+column;//意见textarea
var hisidearid ="HIS<%=Constant.SEPARATOR %>"+table+"<%=Constant.SEPARATOR %>"+column;//历史数据
var ycidea_en="";
//end
jQuery(function() {
	if(IsSpace(table)){
		jQuery("#signTxt").focus();
		/* var content ="";
		jQuery("select[id*=common_idea]").change(function(){
			jQuery("#signTxt").val(jQuery("#common_idea").val());
		});  */
		jQuery("#common_idea").on("dblclick",function(){
			jQuery("#signTxt").val(jQuery("#common_idea").val());
		});
	}else{//不为空则是表单版的
		var content ="";
		jQuery("select[id*=common_idea]").change(function(){
			if(jQuery("#common_idea").val() == '只签名'){
				jQuery("#signTxt").val(content);
			}else{
				//特检院OA 2014-05-28 start 当自定义保存的常用意见中包括空格时，点击已保存的常用意见填充到意见框中的意见丢失了空格以后的内容。
				//jQuery("#signTxt").val(jQuery("#common_idea").val());
				jQuery("#signTxt").val(jQuery("#common_idea").find("option:selected").text());
				//特检院OA 2014-05-28 end 当自定义保存的常用意见中包括空格时，点击已保存的常用意见填充到意见框中的意见丢失了空格以后的内容。
			}
			if(jQuery("#signTxt").val() == content){
				jQuery("#signTxt").attr("disabled",true);
			}else{
				jQuery("#signTxt").attr("disabled",false);
			}
		}); 
		var idea = getParentWindow("").jQuery("[id='"+idearid+"']").val().replace(/\n.*/,"");
		//特检院
		//过滤前面4个空格的问题
		if(idea.length><%=ctab.length()%>){
			var strhead = idea.substr(0,<%=ctab.length()%>);
			if(strhead=="<%=ctab%>"){
				idea = strhead.substr(<%=ctab.length()%>,idea.length);
			}
		}
		jQuery("#signTxt").focus();
		var ycidea = getParentWindow("").jQuery("[id='"+ycidearid+"']").val();//.replace(/\n.*/,"");
		//过滤前面4个空格的问题
		if(ycidea.length><%=ctab.length()%>){
			var strychead = ycidea.substr(0,<%=ctab.length()%>);
			if(strychead=="<%=ctab%>"){
				ycidea = ycidea.substr(<%=ctab.length()%>,ycidea.length);
				ycidea_en=ycidea;
			}
		}
		jQuery("#signTxt").val(ycidea);
	}
});
/*
函数:  convertTo01
说明:  选择框checked属性为true时返回1，否则 返回0
作者：  黄海
日期： 2013-05-31
参数:  obj 选择框对象
返回值: 1或0
*/
var convertTo01 = function(obj){
	if (obj.attr("checked")){
		return 1;
	}
	return 0;
}

/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  saveSign
说明:  保存签名
参数:   无
返回值: 无
*/
function saveSign(){
	
	if(IsSpace(table)){
		var userName = jQuery("#userName").val();
		var signTxt = jQuery("#signTxt").val()+"\r\n";
		/* signTxt=signTxt.replace(/<\?.+?>/g,"");
		signTxt=signTxt.replace(/[\r\n]/g, ""); */
		var date = getNowDateTime();
		//TODO 此处做为可配置，签字人可选
		var signStr = signTxt+""+userName+" <%=signDate %>";
		getParentWindow("windowId1").setSelectionValue(signStr);
		getParentWindow("windowId1").closeAlertWindow();
		removeAlertWindows('windowId1',true);
	}else{//表单版 
		if(!IsSpace(jQuery("#signTxt").val())){
			if(IsSpace(getParentWindow("").jQuery("[id='"+hisidearid+"']").val())){
				getParentWindow("").jQuery("[id='"+idearid+"']").val("<%=ctab%>"+jQuery("#signTxt").val()+"\n<%=ntab%><%=user_name%>   <%=DateUtil.getFormatDate(signdateformat)%>");
			}else{
				if(<%= "newlast".equals(viewOeder)%>){
					getParentWindow("").jQuery("[id='"+idearid+"']").val(getParentWindow("").jQuery("[id='"+hisidearid+"']").val() +"\n\n"+ "<%=ctab%>"+jQuery("#signTxt").val()+"\n<%=ntab%><%=user_name%>  <%=DateUtil.getFormatDate(signdateformat)%>");
				}else{
					getParentWindow("").jQuery("[id='"+idearid+"']").val("<%=ctab%>"+jQuery("#signTxt").val()+"\n<%=ntab%><%=user_name%>  <%=DateUtil.getFormatDate(signdateformat)%>"+"\n\n"+getParentWindow("").jQuery("[id='"+hisidearid+"']").val());
				}
			}
		}else{
			getParentWindow("").jQuery("[id='"+idearid+"']").val(getParentWindow("").jQuery("[id='"+hisidearid+"']").val());
		}
		getParentWindow("").jQuery("[id='"+ycidearid+"']").val("<%=ctab%>"+jQuery("#signTxt").val()+"\n<%=ntab%><%=user_name%>   <%=DateUtil.getFormatDate(signdateformat)%>");
		//getParentWindow("").createIdeaInfo();
		removeAlertWindows('',true);
		}
}
/*
作者:  jie.xiao
时间:  2013-11-20
函数:  saveSignContent
说明:  保存到常用内容
参数:   无
返回值: 无
*/
function saveSignContent(){
	if(IsSpace(jQuery("#signTxt").val().trim())){
		alert("签字内容不能为空！");
		return;
	}
	var flag=false;
	jQuery("#common_idea option").each(function(){
		if(this.value==jQuery("#signTxt").val()){
			flag=true;
		}		
	});
	
	if(flag){
		alert("该内容在常用内容已经存在！");
		return;
	}
	var signTxt= trim(jQuery("#signTxt").val());
	var params = {'user_id':jQuery("#userid").val(),'idea_content':signTxt,'type':'save'};
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: 'wordsigndo.jsp',
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			jQuery("<option value="+signTxt+">"+signTxt+" </option>").appendTo("#common_idea");
		}
	});	
}
/*
作者:  jie.xiao
时间:  2013-12-23
函数:  deleteSignContent
说明:  删除到常用内容
参数:   无
返回值: 无
*/
function deleteSignContent(){
	var common_idea=jQuery("#common_idea option:selected").val();
	if(!common_idea){
		alert('请选择你要删除的常用内容！');
		return;
	}
	var okF = function(){	
		var params = {'common_idea':common_idea,'type':'del'};
		jQuery.ajax({//AJAX将WORD正文上传至公文传输
			url: 'wordsigndo.jsp',
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				if(data.result){
					jQuery("#common_idea option:selected").remove()
					alert("删除操作成功");
				}else{
					alert("删除操作失败");
				}
			}
		});	
	}
	var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
		cancelName:'取消'
	};
	alert("确定要删除吗？",p);
}
function leftmove(){
	if(jQuery("#common_idea").val()==""){
		alert("请先选择一条记录！");
		return;
	}
	jQuery("#signTxt").val(jQuery("#common_idea").val());
}
//关闭
function closew(){
	if(IsSpace(table)){
		getParentWindow("windowId1").closeAlertWindow();
		removeAlertWindows('windowId1',true);
	}else{
		getParentWindow("windowId").closeAlertWindow();
		removeAlertWindows('windowId',true);
	}
}
</script>

</head>
<body>
<button id="button4" class="but_y_01" onclick="saveSign()">保存</button>
<button id="button8" class="but_y_01" onclick="closew()">关闭</button>
<button id="button9" class="but_y_03" onclick="saveSignContent()">存到常用内容</button>
<button id="button9" class="but_y_03" onclick="deleteSignContent()">删除常用内容</button>
<form id="form1" action="" method="post">
<input type="hidden" id="userid" name="userid" value="<%=accesscontroler.getUserID()%>" />
<input type="hidden" id="action" name="action" value="insert" />

<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">填写人：</th>
			            <td  class="content_02_box_div_table_td" style="text-align:left;">
			                <select id="userName" style="width:180px;" onchange=""  >
								<option value="<%=accesscontroler.getUserName()%>"><%=user_name%></option>
							</select>
			            </td>
			            
					</tr>
				</table>
			</div>
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<td style="">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="content_02_box_div_table_02">
								<tr>
									<th valign="top" class="content_02_box_div_table_02_th">内容：</th>
								</tr>
								<tr>
									<td class="content_02_box_div_table_02_td"><textarea
											class="textarea_575" id="signTxt" name="signTxt"
											style="width: 300px; height: 100px; margin: 2px 0 2px;"></textarea>
									</td>
								</tr>
								
							</table>
						</td>
						<td style="width: 150px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="content_02_box_div_table_02">
							<tr>
							<th style="height: 136px" >
								<!-- <div align="center">
								<button id="button9" class="but_y_01" onclick="saveSignContent()" style="float: none;line-height: 23px">保存</button>
								</div> -->
								<div  align="center" style="padding-top: 10px;">
								<button id="button9" class="but_y_01" onclick="leftmove()" style="float: none;line-height: 23px">选定</button>
								</div>
							</th>
							</tr>
						</table>
						</td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="content_02_box_div_table_02">
								<tr>
									<th valign="top" class="content_02_box_div_table_02_th">常用内容：</th>
								</tr>
								<tr>
									<td class="content_02_box_div_table_02_td">
									<%-- <%=commonIdeaList%> --%>
									<select id="common_idea" name="common_idea" style="width:305px;height:110px;margin-bottom: -10px" size="10"  >
									<%if(value!=null && value.length>0){
										for (int i=0;i<value.length;i++){ %>
											<option value="<%=value[i][0] %>"><%=value[i][1] %></option>
										<%}
									 }%>
									</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
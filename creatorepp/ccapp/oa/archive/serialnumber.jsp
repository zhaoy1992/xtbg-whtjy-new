<%-- 
描述：公文编号页面
作者：shuqi.liu
版本：1.0
日期：2013-08-27
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userId = accesscontroler.getUserID();
	String busi_id = request.getParameter("busi_id");
	WordArchiveService service = new WordArchiveServiceImpl();
	//获取有权限的公文类型，年份
	Map<String, List<OaWordNumberBean>> numListMap = service.getWordNumber(accesscontroler.getChargeOrgId());
	
	OaWordNumberBean oaWordNumberBean = service.getNumber(busi_id);
	String number_type = "";
	String number_year = DateUtil.getCurrentYear();;
	String number_code = "";
	String archive_user = accesscontroler.getUserName();
	String archive_userid = accesscontroler.getUserID();
	String archive_date = DateUtil.getCurrentDate();//创建时间
	String optType = "save";
	if(oaWordNumberBean!= null){
		number_type = oaWordNumberBean.getNumber_type();
		number_year	= oaWordNumberBean.getNumber_year();
		number_code = oaWordNumberBean.getNumber_code();
		archive_user = oaWordNumberBean.getArchive_user();
		archive_userid=oaWordNumberBean.getArchive_userid();
		archive_date = oaWordNumberBean.getArchive_date();
		optType = "update";
	}
	//获取编号规则
	String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
	if(serialnumberchar==null || serialnumberchar.length!= 2){
		serialnumberchar[0] = "〔";
		serialnumberchar[1] = "〕";
	}
%>
<title>公文编号页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var map_ = new Object(); 
<%for (String key : numListMap.keySet()){
	for(int i=0;i<numListMap.get(key).size();i++){
	if(i==0){%>
	map_['<%=key%>'] = "<%=numListMap.get(key).get(i).getNumber_type()%>";
<%	}else{%>
	map_['<%=key%>'] = map_['<%=key%>']+","+"<%=numListMap.get(key).get(i).getNumber_type()%>";	
<%	}
	}}%>

jQuery(function() {
	jQuery("#number_year").val("<%=number_year%>");
	var number_year1 = jQuery("#number_year").val();
	//特检院OA  自动编号 特殊处理 start
	//yearChange(number_year1); 
	getType(number_year1);
	//特检院OA  自动编号 特殊处理 end
	jQuery("#number_type").val("<%=number_type%>");
	jQuery("#number_code").val("<%=number_code%>");
	jQuery("#archive_user").val("<%=archive_user%>");
	jQuery("#archive_date").val("<%=archive_date%>");
	getMaxNum();
});

/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  saveNumber
说明:  公文编号
参数:   无
返回值: 无
*/
function saveNumber(){
	var number_type = jQuery("#number_type").val();
	var number_year = jQuery("#number_year").val();
	var number_code = jQuery("#number_code").val();
	var archive_user = jQuery("#archive_user").val();
	var archive_userid = jQuery("#archive_userid").val();
	var archive_date = jQuery("#archive_date").val();
	var number_title = getNumber();
	var busi_id = jQuery("#busi_id").val();
	
	var jsonparam = "{'number_type':'"+number_type
					+"','number_year':'"+number_year
  				    +"','number_code':'"+number_code
  				 	+"','archive_user':'"+archive_user
  				 	+"','archive_userid':'"+archive_userid
  					+"','archive_date':'"+archive_date
  					+"','number_title':'"+number_title
   				    +"','busi_id':'"+busi_id+"'}";
   	jQuery("#jsonparam").val(descape(escape(jsonparam)));
	var fm = document.getElementById("form1");
	fm.action = "serialnumberdo.jsp";
	fm.target = "hiddenFrame";
	jQuery('#form1').submit();

	//getParentWindow("windowId").msgConfigReset(isdxtx,isyj,isznxx,isjsxx,msg_txt);
	removeAlertWindows('',true);
}

//根据编号类型，编号年度 获取最大的编号
function getMaxNum(){
	var number_type = jQuery("#number_type").val();
	var number_year = jQuery("#number_year").val();
	var optType = "getMax";
	var busi_id = jQuery("#busi_id").val();
	var url="serialnumberdo.jsp";
	var params = {'number_type':number_type,'number_year':number_year,'busi_id':busi_id,'optType':optType};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
				jQuery("#number_code").val(data);
		},
		error: function(jqXHR, textStatus, errorThrown){
		
		}
	})
}

//获取编号
function getNumber(){
	var number_type = jQuery("#number_type").val();
	var number_year = jQuery("#number_year").val();
	var number_code	= jQuery("#number_code").val();
	//TODO 此处需要配置编号
	var txtValue = number_type+"<%=serialnumberchar[0]%>"+number_year+"<%=serialnumberchar[1]%>"+number_code+"号";
	return txtValue;
}

//赋值公文编号
function setNumber(){
	var txtValue = getNumber();
	getParentWindow("windowIds").setNumber(txtValue);
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}

//年份更改
function yearChange(year){
	getType(year);
	getMaxNum();
}

//动态加载公文类型
function getType(year){
	jQuery("#number_type").empty();
	if(map_[year]!=null && map_[year].length>0){
		var typelist = map_[year].split(",")
  		for(var i=0; i<typelist.length; i++){
  			jQuery("#number_type").append("<option value='"+typelist[i]+"'>"+typelist[i]+"</option>");  
  		}
  	}
}
var chooseActUsers = function (){
    var s = new jQuery.z_tree();
    s.treeID = 'mianUser';
    s.treetypestr = "radio";
    s.isShowSeacher = true;
    s.treeName = "选取人员";
    s.headerName = "选取人员";
    s.type = "APERSON";
    s.selectedIds=jQuery("#archive_userid").val();
    s.returnFunction = function(userObj,o) {            
       try{
        if (!IsSpace(userObj)) {
            jQuery('#archive_user').val(userObj.name);
            jQuery('#archive_userid').val(userObj.id);
        } else {
            jQuery('#archive_user').val("");
            jQuery('#archive_userid').val("");
        }
       }catch(e){
         /**忽略客户端异常信息**/ 
       }
    }
    s.init();
}
//人员选择树
var chooseReportUnits = function(){
	 var s = new jQuery.z_tree_leftRigth();
	  s.treeID='mianUser';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps ){
			  	  jQuery('#archive_userid').val('');
			  	  jQuery('#archive_user').val('');
		  }else{
				  jQuery('#archive_userid').val(deemphasisStr(orgObj.ps.id,orgObj.rudata.id));
				  jQuery('#archive_user').val(deemphasisStr(orgObj.ps.name,orgObj.rudata.name));
		 }
	  }
	  s.treetypestr = 'radio'; //单选或复选
	  s.treeList=[{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#archive_userid').val(),
				  type: 'APERSON'
		},
		{
			  leftHeaderText:'按最近选择的人员选择',
			  isType:'person',
			  valueKey:'rudata',
			 // selectedIds:jQuery('#archive_userid').val(),
			  type: "AUSER",
			  user_ids:'<%=userId%>'
		}];
	  s.init();
}
//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="saveNumber()">保存</button>
<button id=button8 class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden" value ="<%=busi_id %>"/>
<input id="jsonparam" name="jsonparam" type="hidden" />
<input id="optType" name="optType" type="hidden" value="<%=optType %>"/>
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">编号年度：</th>
			            <td  class="content_02_box_div_table_td" style="width: 290px">
			            	<select name="number_year" id="number_year" onchange="yearChange(this.value)"  class="cms_select" style="width:187px;">
					       		<%for (String key : numListMap.keySet()){%>
					       		<option value="<%=key %>"><%=key %></option>
					       		<%} %>
					        </select>
			            </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号类型：</th>
			           <td class="content_02_box_div_table_td" style="width: 290px">
							<select name="number_type" id="number_type" onchange="getMaxNum()"  class="cms_select" style="width:187px;">
					       		
					        </select>
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号号码：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			            <input type="text" class="validate[maxSize[40]] input_160"  style="width:187px" name="number_code" id="number_code" value ="<%=number_code %>" />
			            </td>
				   </tr>
				   <tr>
						<th class="content_02_box_div_table_th">签发人：</th>
			           <td class="content_02_box_div_table_td" style="width: 290px">
							<%-- <input type="text"  id="archive_user" name="archive_user" style="width:187px"   class="input_160" value="<%=archive_user %>" /> --%>
					   		<input type="text" id="archive_user" name="archive_user" style="width:187px"  onmouseover="this.title=this.value" value="<%=archive_user %>"  class="input_160" onclick="chooseReportUnits()"/>
					    	<input type="hidden" id="archive_userid" name="archive_userid" style="width:187px"   value="<%=archive_userid %>"/>
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">签发时间：</th>
						<td class="content_02_box_div_table_td" style="width: 290px">
							<input type="text"  id="archive_date" name="archive_date" style="width:187px"   class="input_160 date_187" value="<%=archive_date %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					    </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
</body>
</html>
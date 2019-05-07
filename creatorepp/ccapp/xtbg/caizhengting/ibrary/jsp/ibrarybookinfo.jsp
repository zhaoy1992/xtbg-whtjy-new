<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBorrowInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBorrowInfoService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%

		String path = request.getContextPath();
		AccessControl accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(request, response);
		String user_id = accesscontroler.getUserID();
		String user_name = accesscontroler.getUserName();
		String user_orgid = accesscontroler.getChargeOrgId();
		String user_orgname = accesscontroler.getChargeOrgName();
		String logUserTime = DateUtil.getCurrentDateTime();//最近更新时间为录入时间
		UserCacheBean userBean= UserCache.getUserCacheBean(user_id);
		String dept_id = userBean.getUnit_id();
	    String dept_name = 	userBean.getUnit_name();	
		
		
		String sbook_tate ="";
		String attachment_id =""; //附件ID
		String actiontype = ""; //处理类型
		String tree_id = request.getParameter("tree_id"); //图书类型ID 
		String tree_name = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("tree_name")),"UTF-8"); //类型名称
		String tree_type_code = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("tree_type_code")),"UTF-8"); //分类代码
		String book_id = request.getParameter("book_id"); //图书I
		String readonly = request.getParameter("readonly");//只读属性
		String tree_type_no = request.getParameter("tree_type_no");//分类层次  如果是中间层(1) 不能添加图书
		String subid = request.getParameter("subid");
		String code ="";  //获取编号
		//获取当前年份
		Calendar cal = Calendar.getInstance();
	    int year = cal.get(Calendar.YEAR);
		
		//借阅历史 
		IbraryBorrowInfoService borrowservice =  new IbraryBorrowInfoServiceImpl();
		List<IbraryBorrowInfoBean> list = new ArrayList<IbraryBorrowInfoBean>();
		IbraryBookInfoService service = new IbraryBookInfoServiceImpl();
		IbraryBookInfoBean bean = new IbraryBookInfoBean();
		if(!StringUtil.nullOrBlank(book_id)){
			bean = service.getbookinfobyid(book_id);
			attachment_id =  StringUtil.deNull(bean.getAccessory());
		    list =borrowservice.getlistbybookid(book_id);
			actiontype = "update";
		}else{
			//初始化页面
			bean.setBook_state("0"); //在库
			bean.setBooker_dept_id(dept_id);//登记单位id
			bean.setBooker_dept_name(dept_name);//登记单位名
			//最底层 初始化 分类 和 图书编号
			if(!StringUtil.nullOrBlank(tree_type_no)&& "2".equals(tree_type_no)){
				code = service.getbookCode(tree_id);
				bean.setBook_no(tree_type_code+"-1-"+code); //图书编号初始化
				bean.setTree_id(tree_id);
				bean.setTree_name(tree_name);
			}
			
			bean.setBooker_date(logUserTime);
			bean.setBooker_id(user_id);
			bean.setBooker_name(user_name);
			book_id = UUID.randomUUID().toString();
			attachment_id = UUID.randomUUID().toString();
			actiontype = "insert";
		}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<script type="text/javascript">
	var readonly = "<%=readonly%>";//只读属性
	var subid = "<%=subid%>";
	var ajax_url = "<%=path%>"+"/ccapp/xtbg/caizhengting/ibrary/jsp/";
	jQuery(function(){
		//有效状态
		jQuery("#validstate option[value='<%=StringUtil.deNull(bean.getValidstate())%>']").removeAttr("selected");
	    jQuery("#validstate option[value='<%=StringUtil.deNull(bean.getValidstate())%>']").attr("selected","selected");
		
	    MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', true, '<%=attachment_id%>');
		if(readonly == "readonly"){
			jQuery("#btn_save").hide();
			jQuery("input").attr("readonly","readonly");//设置所有input控件为只读
			jQuery("textarea").attr("readonly","readonly");//设置所有input控件为只读
			jQuery("#accessory_id").hide();//隐藏附件上传
			jQuery("#chossepress").hide();//隐藏出版社选按钮
			//隐藏上传按钮 
			jQuery(".swiff-uploader-box").hide();
			//隐藏删除链接
			jQuery("#_fileshow li span").hide();
		} else {
			jQuery("#content_02_box_div_table_02").on("click","tr",function(){
				var borrow_id = jQuery(this).find(".borrow_id_class").val();//借阅id
				if(borrow_id != "" && borrow_id != null){
					openAlertWindows('windowId','../../../caizhengting/ibrary/jsp/ibraryborrowcomon.jsp?subid=bookadd&borrow_id='+borrow_id+'&canedit=false','借阅管理',780,250,'25%','25%');
				}
			});
		}
	});


	var savebean = function(){
		if(jQuery("#form1").validationEngine("validateform")){
			jQuery("#form1").submit();
		}
	}
	function more(o){  
		jQuery("#content_02_box_div_table_02").toggle();
	}
	var back = function(){
		if(readonly == "readonly"){
			removeWindows(subid,true);
		} else{
			var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:function(){
		        	removeWindows(subid,true);
		        },
		        cancelName:'取消'
			};
			alert("关闭后,数据将不会保存,确定关闭？",p);
		}
	
	
	}
	
var chooseDept = function (){
	var s = new jQuery.z_tree();
	s.treeID = 'mianDept';
	s.treetypestr = 'radio';
	s.isShowSeacher = true;
	s.treeName = "选取单位";
	s.headerName = "选取单位";
	s.type = "AUNIT";
	s.selectedIds = jQuery("#booker_dept_id").val(),
	s.returnFunction = function(orgObj,o) {
		if (!IsSpace(o)) {
			jQuery('#booker_dept_id').val(o[0].id);
			jQuery('#booker_dept_name').val(o[0].name);
		} else {
			jQuery('#booker_dept_id').val("");
			jQuery('#booker_dept_name').val("");
		}
	}
	s.init();
}	

</script>
<title>图书登记</title>
</head>
<body style=" overflow-y:auto; overflow-x: hidden;width: 100%" onload="adaptationWH('','tabs1',30)">
<div class="content_02_top" style="margin-bottom:10px;" id="divA">
	<input type="button" class="but_y_01" value="保存" onclick="savebean();" id="btn_save"/>
	<input type="button" class="but_y_01" value="返回" onclick="back();" id="btn_back"/>
</div>
<div id="tabs1">
<div class="content_02_box_title_bg"><span>图书登记信息</span></div>
<form id="form1" name="form1" method="post" target="hiddenFrame" action="ibrarybookinfoDo.jsp">
<input type="hidden" id="actiontype" name="actiontype" value="<%=actiontype%>">
<input type="hidden" id="book_id" name="book_id" value="<%=book_id%>">
<input type="hidden" id="accessory" name="accessory" value="<%=attachment_id%>">
<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
  <tr>
  	<th class="content_02_box_div_table_th"><span style="color: red;">*</span>图书名称:</th>
    <td colspan="5" class="content_02_box_div_table_td" >
    	<input type="text" class="validate[required,maxSize[100]] input_188" name="book_name" id="book_name" value="<%=StringUtil.deNull(bean.getBook_name())%>" >
    </td>
  </tr>
  <tr>
    <th class="content_02_box_div_table_th" style="width: 20%">图书编号:</th>
    <td class="content_02_box_div_table_td" style="width: 10%">
    	<input type="text" class="validate[maxSize[50]] input_188" name="book_no" id="book_no" title="选择分类 编号自动生成" value="<%=StringUtil.deNull(bean.getBook_no())%>">
    </td>
    <th class="content_02_box_div_table_th" style="width: 20%"><span style="color: red;">*</span>分类:</th>
    <td class="content_02_box_div_table_td" style="width: 10%" >
    	<input value="<%=StringUtil.deNull(bean.getTree_id())%>" type="hidden" name="tree_id" id="tree_id"/>
		<input onclick="chooseUNCType('图书分类','tree_id','tree_name','book_no')" readonly="readonly" value="<%=StringUtil.deNull(bean.getTree_name())%>" type="text" name="tree_name" id="tree_name" class="validate[required,maxSize[100]] input_title_text" />
			<script type="text/javascript">
			//如果为只读
			if("<%=readonly%>" == "readonly"){
				chooseUNCType = function(title,hiddenInputId,inputId,book_no){
					return ;
				}
			}else {
				chooseUNCType = function(title,hiddenInputId,inputId,book_no){
					TREE_WC_CONTRACT_UNC_FLAG="dfdwtreeeJSF";
					s = new jQuery.z_tree();
					s.treetypestr = 'radio';
					s.type='{"type":"TREE_CZT_IBRARY_TYPE"}';
					s.isShowSeacher=true;
					s.isType='dept';<%--必选--%>
					s.treeName=title;
					s.headerName=title;
					s.selectedIds=jQuery('#'+hiddenInputId).val();
					s.returnFunction=function(o,nodeObj){
						if(!IsSpace(nodeObj[0])){
							 jQuery('#'+hiddenInputId).val(nodeObj[0].id);
							 jQuery('#'+inputId).val(nodeObj[0].name);
							 if(nodeObj[0].name){
								 jQuery.ajax({
									url:ajax_url+'libraryinfohandle.jsp',
									type:'post',dataType:'json',
									data:{"method":"getCode","id":nodeObj[0].id},
									success:function(data){
										if(!IsSpace(data)){
											jQuery('#'+book_no).val(nodeObj[0].tree_type_code+"-1-"+data);	
										} else {
											
										}
									}
								})
									
							  }
						 }else{
							 jQuery('#'+hiddenInputId).val('');
							 jQuery('#'+inputId).val('');
							 jQuery('#'+book_no).val('');
						 }
					}
					s.init();
				};
			}
			</script>
    </td>
    <th class="content_02_box_div_table_th" style="width: 20%">作者:</th>
    <td class="content_02_box_div_table_td" style="width: 10%">
    	<input type="text" class="validate[maxSize[100]] input_188" name="book_author" id="book_author" value="<%=StringUtil.deNull(bean.getBook_author())%>">
    </td>
  </tr>
  <tr>
     <th class="content_02_box_div_table_th" >装订特征:</th>
     <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[40]] input_188" name="zdtz" id="zdtz" value="<%=StringUtil.deNull(bean.getZdtz())%>">
     </td>
     <th class="content_02_box_div_table_th" >来源:</th>
     <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[40]] input_188" name="whereform" id="whereform" value="<%=StringUtil.deNull(bean.getWhereform())%>">
     </td>
    <th class="content_02_box_div_table_th" >出版号:</th>
         <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[20]] input_188" name="book_pressno" id="book_pressno" value="<%=StringUtil.deNull(bean.getBook_pressno())%>">
     </td>
  </tr>
  <tr>
    <th class="content_02_box_div_table_th" >出版日期:</th>
    <td class="content_02_box_div_table_td" >
    	<%if("readonly".equals(readonly)){%>
    		<input type="text" class="input_188"  name="book_pressdate" id="book_pressdate"
				 value="<%=StringUtil.deNull(bean.getBook_pressdate())%>" readonly/>
		<%} else{ %>
		<input type="text" class="date_187"  name="book_pressdate" id="book_pressdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="<%=StringUtil.deNull(bean.getBook_pressdate())%>" readonly/>
		<%} %>
     </td>
     <th class="content_02_box_div_table_th" >版次:</th>
     <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[20]] input_188" name=book_pressbunver id="book_pressbunver" value="<%=StringUtil.deNull(bean.getBook_pressbunver())%>">
     </td>
     <th class="content_02_box_div_table_th" >页数:</th>
     <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[40],custom[integer]] input_188" name="book_page" id="book_page" value="<%=StringUtil.deNull(bean.getBook_page())%>">
     </td>
  </tr>
  <tr>
    <th class="content_02_box_div_table_th" >价格(元):</th>
     <td class="content_02_box_div_table_td" >
     	<input type="text" class="validate[maxSize[9],custom[number]] input_188" name="book_price" id="book_price" value="<%=StringUtil.deNull(bean.getBook_price())%>">
     </td>
    <th class="content_02_box_div_table_th" ><span style="color: red;">*</span>数量:</th>
    <td class="content_02_box_div_table_td" >
    	<input type="text" class="input_188 validate[required,custom[onlyNumberSp]]" name="book_number" id="book_number" value="<%=StringUtil.deNull(bean.getBook_number())%>">
    </td>
    <th class="content_02_box_div_table_th" ><span style="color: red;">*</span>有效状态:</th>
    <td class="content_02_box_div_table_td" >
    	<select name="validstate" id="validstate" style="width: 188px">
    		<option value="1">正常</option>
    		<option value="2">过期停用</option>
    	</select>
    </td>
    
  </tr>
  <tr>
     <th class="content_02_box_div_table_th" >登记人:</th>
    <td class="content_02_box_div_table_td">
    	<input type="text" class="input_188" readonly="readonly" value="<%=StringUtil.deNull(bean.getBooker_name())%>">
    	<input type="hidden" class="input_188" readonly="readonly" name="booker_id" id="booker_id" value="<%=StringUtil.deNull(StringUtil.deNull(bean.getBooker_id()))%>">
    </td>
     <th class="content_02_box_div_table_th" >登记时间:</th>
    <td class="content_02_box_div_table_td">
   		<input readonly="readonly" type="text" value="<%=StringUtil.deNull(bean.getBooker_date())%>"  class="input_title_text"/>
		<input type="hidden" name="booker_date" id="booker_date" value="<%=StringUtil.deNull(bean.getBooker_date())%>"  class="input_title_text"/>
	</td>
     <th class="content_02_box_div_table_th" >登记单位:</th>
    <td class="content_02_box_div_table_td" width="15%">
    	<input type="text" class="input_188" readonly="readonly" onclick="chooseDept();" name="booker_dept_name" id="booker_dept_name"  value="<%=StringUtil.deNull(bean.getBooker_dept_name())%>" >
    	<input type="hidden" class="input_188" readonly="readonly" name="booker_dept_id" id="booker_dept_id" value="<%=StringUtil.deNull(bean.getBooker_dept_id())%>" >
    </td>
  </tr>
  <tr>
    <th class="content_02_box_div_table_th" >内容说明:</th>
    <td colspan="5" class="content_02_box_div_table_td" >
    <textarea id="remark" name="remark" class="validate[maxSize[500]] textarea_575" rows="5"><%=StringUtil.deNull(bean.getRemark())%></textarea>
	</td>
  </tr>
  <tr id="accessory_id">
	<th class="content_02_box_div_table_th">附件：</th>
	<td class="content_02_box_div_table_td" colspan="5">
		<a href="#" id="_filebut">请选择文件</a>
	</td>
  </tr>
  <tr>
  <th class="content_02_box_div_table_th">附件列表：</th>
	<td class="content_02_box_div_table_td" colspan="5"><ul id="_fileshow"></ul></td>
  </tr>
</table>
</form>
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
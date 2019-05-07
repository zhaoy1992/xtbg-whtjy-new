<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="java.util.Map"%>  
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBorrowInfoService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBorrowInfoServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	UserCacheBean userBean= UserCache.getUserCacheBean(userid);
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	String sqtype=request.getParameter("sqtype");
	String org_id = accesscontroler.getChargeOrgId();
	String org_name = accesscontroler.getChargeOrgName();
	//单位ID
	String dept_id = userBean.getUnit_id();
	String dept_name = userBean.getUnit_name();
	
	String subid = request.getParameter("subid");
	String t_regb_id = request.getParameter("t_regb_id");
	
	String whereForm = request.getParameter("whereForm");
	
	String nowDateString = DateUtil.getCurrentDate();                    //当前日期
	String nextMothodString = DateUtil.getDateOffset(nowDateString, 15); //30天后的日期
	Date nextMothodDate = DateUtil.getDateObj(nextMothodString, "[/]");
	nextMothodString = DateUtil.getFormatDateTime(nextMothodDate, "yyyy-MM-dd");  //将'/'转化为'-'
	
	String T_REGB_DATE = nowDateString;                    //申请时间
	String T_REGB_JY_DATE = "";                    //借阅时间
	String T_REGB_AUDITOPINION = "";			   //审核意见
	String T_REGB_GH_DATE = "";                    //应归还时间
	long days = 0;                                 //相差天数 
	String t_regb_iskonw = "";                     //是否知悉
	String t_regb_isxj = "";                       //是否续借
	String nextNextMothodString = "";              //续期时间
	
	List<Map<String,String>> regBookList = new ArrayList<Map<String,String>>();     //申请表信息
	List<Map<String,String>> regBookBookList = new ArrayList<Map<String,String>>();  //申请图书信息
	IbraryBookInfoService ibraryBookInfoService = new IbraryBookInfoServiceImpl();
	
	if(!StringUtil.isBlank(t_regb_id)){    //不是新增 
		regBookList = ibraryBookInfoService.queryRegBookInfo(t_regb_id);
		T_REGB_DATE = regBookList.get(0).get("t_regb_date");
		if(!StringUtil.isBlank(regBookList.get(0).get("t_regb_jy_date"))){
			T_REGB_JY_DATE = regBookList.get(0).get("t_regb_jy_date");
			T_REGB_GH_DATE = regBookList.get(0).get("t_regb_gh_date");
			
			days = DateUtil.getIntervalDays(nowDateString,T_REGB_GH_DATE);
			nextNextMothodString = DateUtil.getDateOffset(T_REGB_GH_DATE, 15);   
			nextMothodDate = DateUtil.getDateObj(nextNextMothodString, "[/]");
			nextNextMothodString = DateUtil.getFormatDateTime(nextMothodDate, "yyyy-MM-dd");  //将'/'转化为'-'
		}
		T_REGB_AUDITOPINION = regBookList.get(0).get("t_regb_auditopinion");//审核意见
		userid = regBookList.get(0).get("t_regb_user_id");
		user_name = regBookList.get(0).get("t_regb_user_name");
		org_id = regBookList.get(0).get("t_regb_org_id");
		org_name = regBookList.get(0).get("t_regb_org_name");
		dept_id = regBookList.get(0).get("t_regb_dept_id");
		dept_name = regBookList.get(0).get("t_regb_dept_name");
		t_regb_iskonw = regBookList.get(0).get("t_regb_iskonw");
		t_regb_isxj = regBookList.get(0).get("t_regb_isxj");
		
		regBookBookList = ibraryBookInfoService.queryRegBookBookInfo(t_regb_id);
	}
	
	
	IbraryBorrowInfoService service = new IbraryBorrowInfoServiceImpl();
	String date = service.getAgreementExpireRemindTime();
	//System.out.println("T_REGB_AUDITOPINION======"+T_REGB_AUDITOPINION);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>借阅登记页面</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script language="javascript" src="../../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path%>/ccapp/xtbg/resources/plug/Lodop/install_lodop.exe"></embed>
</object>
<script type="text/javascript">

var whereForm = '<%=whereForm%>';
var days = <%=days%>;
var t_regb_isxj = '<%=t_regb_isxj%>';
var t_regb_iskonw = '<%=t_regb_iskonw%>';

jQuery(document).ready(function() {
	jQuery("#conferenceBase").validationEngine();
	jQuery("[name=dayrowhidden]").hide();
	jQuery("[name=dayrowhiddentwo]").hide();
});

//选择图书
function Add_Row4NewDay1(){
	var lastTrObject = jQuery("[name=dayrow]").last();
	var lastTr = jQuery("[name=dayrowhidden]").last().clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	
	
	var lastSelectId = lastTrObject.find("input[name=T_REG_BOOK_ID]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("T_REG_BOOK_ID");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}

	jQuery(lastTr).find("input[name=T_REG_BOOK_ID]").attr("id","T_REG_BOOK_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_ID]").attr("id","T_REG_BOOK_BOOK_ID"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_JG]").attr("id","T_REG_BOOK_BOOK_JG"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_NAME]").attr("id","T_REG_BOOK_BOOK_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_BH]").attr("id","T_REG_BOOK_BOOK_BH"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_NO]").attr("id","T_REG_BOOK_BOOK_NO"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_AUTER]").attr("id","T_REG_BOOK_BOOK_AUTER"+newlastSelectId);
	//有效状态
	jQuery(lastTr).find("input[name=T_REG_BOOK_VALID_STATE]").attr("id","T_REG_BOOK_VALID_STATE"+newlastSelectId);
	
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	
	lastTr.attr("style","");
	
	var dayTable = jQuery("#dayTable");
	
	lastTr.appendTo(dayTable);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
}

//已借阅图书
function Add_Row4NewDay1_two(){
	var lastTrObject = jQuery("[name=dayrowtwo]").last();
	var lastTr = jQuery("[name=dayrowhiddentwo]").last().clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	
	
	var lastSelectId = lastTrObject.find("input[name=T_REG_BOOK_IDtwo]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("T_REG_BOOK_IDtwo");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}

	jQuery(lastTr).find("input[name=T_REG_BOOK_IDtwo]").attr("id","T_REG_BOOK_IDtwo"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_IDtwo]").attr("id","T_REG_BOOK_BOOK_IDtwo"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_JGtwo]").attr("id","T_REG_BOOK_BOOK_JGtwo"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_NAMEtwo]").attr("id","T_REG_BOOK_BOOK_NAMEtwo"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_BHtwo]").attr("id","T_REG_BOOK_BOOK_BHtwo"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_NOtwo]").attr("id","T_REG_BOOK_BOOK_NOtwo"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_REG_BOOK_BOOK_AUTERtwo]").attr("id","T_REG_BOOK_BOOK_AUTERtwo"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_REG_BOOK_VALID_STATEtwo]").attr("id","T_REG_BOOK_VALID_STATEtwo"+newlastSelectId);//有效状态
	
	lastTr.attr("id","dayrowtwo");
	lastTr.attr("name","dayrowtwo");
	
	lastTr.attr("style","");
	
	var dayTabletwo = jQuery("#dayTabletwo");
	
	lastTr.appendTo(dayTabletwo);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
}

//删除物品
function deleteDay(tag,goodsId){
	
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
}

/* 返回 */
function backTo(){
	var okF = function(){
		removeWindows('<%=subid%>',true,false);
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}

//同步获取图书信息并填充表格信息
function loadBookInfo(bookIdsIds){
	var osapprowtr = jQuery("[name=dayrow]");
	var T_REG_BOOK_BOOK_ID_OLD = new Array();
	var T_REG_BOOK_BOOK_NO_OLD = new Array();
	for (var j = 0; j<osapprowtr.length; j++){
		if($(osapprowtr[j]).find("input[name=T_REG_BOOK_BOOK_ID]").val()){
			bookIdsIds = bookIdsIds+","+$(osapprowtr[j]).find("input[name=T_REG_BOOK_BOOK_ID]").val();
			T_REG_BOOK_BOOK_ID_OLD[j] = $(osapprowtr[j]).find("input[name=T_REG_BOOK_BOOK_ID]").val();
			T_REG_BOOK_BOOK_NO_OLD[j] = $(osapprowtr[j]).find("input[name=T_REG_BOOK_BOOK_NO]").val();
		}
	}
	var url = "<%=path %>/ccapp/xtbg/caizhengting/ibrary/jsp/getbackbookinfoajax.jsp";
	var params = {osappitem:bookIdsIds};
	var dayrowtr = jQuery("[name=dayrow]");
	var bookIdsNames = "";
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			dayrowtr.remove();
			for (var i = 0; i<data.length; i++){
				Add_Row4NewDay1();
				var objectidno = i+1;
				if(i>0){
					bookIdsNames += ",";
				}
				jQuery("#T_REG_BOOK_BOOK_ID"+objectidno).val(data[i].book_id);
				jQuery("#T_REG_BOOK_BOOK_JG"+objectidno).val(data[i].book_price);
				jQuery("#T_REG_BOOK_BOOK_NAME"+objectidno).val(data[i].book_name);
				jQuery("#T_REG_BOOK_BOOK_BH"+objectidno).val(data[i].book_no);
				jQuery("#T_REG_BOOK_BOOK_NO"+objectidno).val("1");
				jQuery("#T_REG_BOOK_BOOK_AUTER"+objectidno).val(data[i].book_author);
				jQuery("#T_REG_BOOK_VALID_STATE"+objectidno).val(data[i].validstate);//有效状态
				for(var j = 0; j<T_REG_BOOK_BOOK_ID_OLD.length; j++){
					if(jQuery("#T_REG_BOOK_BOOK_ID"+objectidno).val() == T_REG_BOOK_BOOK_ID_OLD[j]){   //如果选择了同样的书籍  则数量仍为之前的数量
						jQuery("#T_REG_BOOK_BOOK_NO"+objectidno).val(T_REG_BOOK_BOOK_NO_OLD[j]);
					}
				}
				
				bookIdsNames += data[i].book_name;
			}
			jQuery("#T_REGB_BOOKIDS").val(bookIdsIds);
			jQuery("#T_REGB_BOOKNAMES").val(bookIdsNames);
			jQuery("[name=dayrow]").show();
			jQuery("#T_REGB_USER_NAME").focus();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}

//同步获取图书信息并填充已借阅表格信息
function loadYJYBookInfo(user_id){
	var url = "<%=path %>/ccapp/xtbg/caizhengting/ibrary/jsp/getbackYJYbookinfoajax.jsp";
	var params = {osappitem:user_id};
	var dayrowtr = jQuery("[name=dayrowtwo]");
	var bookIdsNames = "";
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			dayrowtr.remove();
			for (var i = 0; i<data.length; i++){
				Add_Row4NewDay1_two();
				var objectidno = i+1;
				if(i>0){
					bookIdsNames += ",";
				}
				jQuery("#T_REG_BOOK_BOOK_IDtwo"+objectidno).val(data[i].t_reg_book_book_id);
				jQuery("#T_REG_BOOK_BOOK_JGtwo"+objectidno).val(data[i].t_reg_book_book_jg);
				jQuery("#T_REG_BOOK_BOOK_NAMEtwo"+objectidno).val(data[i].t_reg_book_book_name);
				jQuery("#T_REG_BOOK_BOOK_BHtwo"+objectidno).val(data[i].t_reg_book_book_bh);
				jQuery("#T_REG_BOOK_BOOK_NOtwo"+objectidno).val(data[i].t_reg_book_book_no);
				jQuery("#T_REG_BOOK_BOOK_AUTERtwo"+objectidno).val(data[i].t_reg_book_book_auter);
				//有效状态
				jQuery("#T_REG_BOOK_VALID_STATEtwo"+objectidno).val(data[i].validstate);
				
				bookIdsNames += data[i].t_reg_book_book_name;
			}
			jQuery("[name=dayrowtwo]").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}

//验证图书库存资料
function checkBookNum(){
	var dayrowArr = jQuery("input[name=T_REG_BOOK_BOOK_ID]");
	for(var i = 1;i<dayrowArr.size();i++){
		if(!checkHavaNo(dayrowArr[i])){
			return false;
		}
	}
	return true;
}

//检查输入的数量与库存数量对比
function checkHavaNo(T_REG_BOOK_BOOK_ID){
	var url = "<%=path %>/ccapp/xtbg/caizhengting/ibrary/jsp/getbackbookinfoajax.jsp";
	
	var T_REG_BOOK_BOOK_ID_ID = T_REG_BOOK_BOOK_ID.id;
	var T_REG_BOOK_BOOK_ID_IDArr = T_REG_BOOK_BOOK_ID_ID.split("T_REG_BOOK_BOOK_ID");
    var T_REG_BOOK_BOOK_NO = parseFloat(jQuery("#T_REG_BOOK_BOOK_NO"+T_REG_BOOK_BOOK_ID_IDArr[1]).val());  //页面填写数量
    
    var T_REG_BOOK_BOOK_ID_VALUE = T_REG_BOOK_BOOK_ID.value;    
    var T_REG_BOOK_BOOK_NO_NUM;                                              //库存数量
	
    var falg = true;
    
	var params = {osappitem:T_REG_BOOK_BOOK_ID_VALUE};
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if(data.length>0){
				for (var i = 0; i<data.length; i++){
					if(data[i].book_number==""){
						data[i].book_number = "0";
					}
					T_REG_BOOK_BOOK_NO_NUM = parseFloat(data[i].book_number);
				}
			}else{
				T_REG_BOOK_BOOK_NO_NUM = 0;
			}
			if(T_REG_BOOK_BOOK_NO > T_REG_BOOK_BOOK_NO_NUM){
				alert("第"+T_REG_BOOK_BOOK_ID_IDArr[1]+"行的书籍数量过大!库存数量为："+T_REG_BOOK_BOOK_NO_NUM+"。请与图书管理员联系。");
				falg = false;
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
	return falg;
}


/**
 *     添加图书
 */
function Add_Books(){
	openAlertWindows('windowId','../../../caizhengting/ibrary/jsp/ibrarychosebook.jsp?windowsId=windowId','选择图书',850,470,'25%','25%');
}

function savebean(whatButton){
    if(whatButton == 'save'){    //新增   
    	//我的【待借阅】点【保存】就清空审核意见。
    	jQuery("#T_REGB_AUDITOPINION").val("");
    	jQuery('#doWhat').val("save"); 
    	jQuery('#T_REGB_STATE').val("1");   //待借阅  
		if(checkBookNum()){   //在借阅做库存验证
    		
    	}else{
    		return;
    	}
    }
    if(whatButton == 'giveTY'){    //同意借阅      
    	jQuery('#doWhat').val("giveTY"); 
    	//【借阅管理】点【不同意】就保存审核意见。
    	//jQuery("#T_REGB_AUDITOPINION").val("");
    	jQuery('#T_REGB_STATE').val("2");   //已借阅  已借出    	
    	jQuery('#T_REGB_JY_DATE').val("<%=nowDateString%>");   //借阅时间
    	jQuery('#T_REGB_GH_DATE').val("<%=nextMothodString%>");   //应归还时间
    	if(checkBookNum()){   //只有在借出时才做库存验证
    		
    	}else{
    		return;
    	}	
    }
    if(whatButton == 'giveBTY'){    //不同意借阅      
    	jQuery('#doWhat').val("giveBTY"); 
    	jQuery('#T_REGB_STATE').val("3");   //不同意借阅   	
    }
    if(whatButton == 'xqYJX'){    //已知悉
    	jQuery('#doWhat').val("xqYJX"); 
    	jQuery('#T_REGB_STATE').val("2");   //已借阅    	
    	jQuery('#T_REGB_ISKONW').val("1");   //已知悉
    }
    if(whatButton == 'xq'){    //续借   
    	jQuery('#doWhat').val("xq"); 
    	jQuery('#T_REGB_STATE').val("6");   //带续借	
    	jQuery('#T_REGB_ISXJ').val("1");   //续借
    }
    if(whatButton == 'xqTY'){    //同意 续借    
    	jQuery('#doWhat').val("xqTY"); 
    	jQuery('#T_REGB_STATE').val("2");   //已借阅
    	jQuery('#T_REGB_ISXJ').val("");   //续借
    	jQuery('#T_REGB_GH_DATE').val("<%=nextNextMothodString%>");   //应归还时间
    }
    if(whatButton == 'xqBTY'){    //不同意 续借   
    	jQuery('#doWhat').val("xqBTY"); 
    	jQuery('#T_REGB_STATE').val("2");   //已借阅	
    	jQuery('#T_REGB_ISXJ').val("");   //续借
    }
    if(whatButton == 'tsGH'){    //归还
    	jQuery('#doWhat').val("tsGH"); 
    	jQuery('#T_REGB_ISXJ').val("");   //续借
    	jQuery('#T_REGB_STATE').val("4");   //已归还  
    	jQuery('#T_REGB_TRUEGH_DATE').val("<%=nowDateString%>");  //实际归还时间
    }
	     
	jQuery('#conferenceBase').attr("target","hiddenFrame");
	jQuery('#conferenceBase').submit();
}

function hiddenDocument(){
	<%if(!StringUtil.isBlank(t_regb_id)){%>
	    var t_regb_state = '<%=regBookList.get(0).get("t_regb_state")%>';  //申请表状态
	    if(t_regb_state == '1'){  //待借阅
	    	if(whereForm == '1'){  //从管理员入口进入
	    		jQuery("#btn_insert").hide();         //保存按钮
	    	    jQuery("#btn_xjyzx").hide();          //已知悉 
	    	    jQuery("#btn_xj").hide();             //续借按钮
	    	    jQuery("#btn_xjty").hide();           //续借同意按钮
	    	    jQuery("#btn_xjbty").hide();          //续借不同意按钮
	    	    jQuery("#btn_tsgh").hide();           //续借归还按钮
	    	    jQuery("#print").hide();           //续借归还按钮
	    	    jQuery("#aggerDate").hide();          //借阅时间和应归还时间  
	    	}else{
	    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
	    		jQuery("#btn_givety").hide();
	    	    jQuery("#btn_givebty").hide();
	    	    jQuery("#btn_xjyzx").hide();
	    	    jQuery("#btn_xj").hide();
	    	    jQuery("#btn_xjty").hide();
	    	    jQuery("#btn_xjbty").hide();
	    	    jQuery("#btn_tsgh").hide();
	    	    jQuery("#print").hide();
	    	    jQuery("#aggerDate").hide();
	    	}
	    }
	    if(t_regb_state == '2'){  //已借阅
	    	if(days>0 && days<=7){   //待续期
	    		if(whereForm == '1'){  //从管理员入口进入
	    			jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
		    	    if(t_regb_isxj == ''){              //没有续借申请
		    	    	jQuery("#btn_xjty").hide();
			    	    jQuery("#btn_xjbty").hide();
		    	    }
		    	    jQuery("#btn_xj").hide();
		    	    jQuery("#btn_xjyzx").hide();
		    	}else{
		    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
					if(t_regb_isxj == '1'){        //已经提交续借申请
						jQuery("#btn_xj").hide();
		    	    }
					if(t_regb_iskonw == '1'){      //已经知悉
						jQuery("#btn_xjyzx").hide();
					}
		    	    jQuery("#btn_xjty").hide();
		    	    jQuery("#btn_xjbty").hide();
		    	    jQuery("#btn_tsgh").hide();
		    	    jQuery("#print").hide();
		    	}
	    	}else if(days<0){              //已超期
	    		if(whereForm == '1'){  //从管理员入口进入
	    			jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
		    	    if(t_regb_isxj == ''){              //没有续借申请
		    	    	jQuery("#btn_xjty").hide();
			    	    jQuery("#btn_xjbty").hide();
		    	    }
		    	    jQuery("#btn_xj").hide();
		    	    jQuery("#btn_xjyzx").hide();
		    	}else{
		    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
		    	    if(t_regb_isxj == '1'){         //已经提交续借申请
						jQuery("#btn_xj").hide();
		    	    }
		    	    jQuery("#btn_xjyzx").hide();
		    	    jQuery("#btn_xjty").hide();
		    	    jQuery("#btn_xjbty").hide();
		    	    jQuery("#btn_tsgh").hide();
		    	    jQuery("#print").hide();
		    	}
	    	}else{
	    		if(whereForm == '1'){  //从管理员入口进入
	    			jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
		    	    if(t_regb_isxj == ''){              //没有续借申请
		    	    	jQuery("#btn_xjty").hide();
			    	    jQuery("#btn_xjbty").hide();
		    	    }
		    	    jQuery("#btn_xj").hide();
		    	    jQuery("#btn_xjyzx").hide();
		    	}else{
		    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
		    		jQuery("#btn_insert").hide();
		    	    jQuery("#btn_givety").hide();
		    	    jQuery("#btn_givebty").hide();
		    	    if(t_regb_isxj == '1'){         //已经提交续借申请
						jQuery("#btn_xj").hide();
		    	    }
		    	    jQuery("#btn_xjyzx").hide();
		    	    jQuery("#btn_xjty").hide();
		    	    jQuery("#btn_xjbty").hide();
		    	    jQuery("#btn_tsgh").hide();
		    	    jQuery("#print").hide();
		    	}
	    	}
	        jQuery('#addRow4NewDay').hide();
	        jQuery('#delImg').hide();
	        jQuery('input[name=T_REG_BOOK_BOOK_NO]').attr('readonly','readonly');
	    }
	    if(t_regb_state == '3'){  //借阅不同意
	    	if(whereForm == '1'){  //从管理员入口进入
	    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
	    		jQuery("#btn_insert").hide();         //保存按钮
	    		jQuery("#btn_givety").hide();             //借阅同意
	    		jQuery("#btn_givebty").hide();             //借阅不同意
	    	    jQuery("#btn_xjyzx").hide();          //已知悉 
	    	    jQuery("#btn_xj").hide();             //续借按钮
	    	    jQuery("#btn_xjty").hide();           //续借同意按钮
	    	    jQuery("#btn_xjbty").hide();          //续借不同意按钮
	    	    jQuery("#btn_tsgh").hide();           //续借归还按钮
	    	    jQuery("#print").hide();           	  //续借归还按钮
	    	    jQuery("#aggerDate").hide();          //借阅时间和应归还时间  
	    	}else{
	    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
	    		jQuery("#btn_givety").hide();
	    	    jQuery("#btn_givebty").hide();
	    	    jQuery("#btn_xjyzx").hide();
	    	    jQuery("#btn_xj").hide();
	    	    jQuery("#btn_xjty").hide();
	    	    jQuery("#btn_xjbty").hide();
	    	    jQuery("#btn_tsgh").hide();
	    	    jQuery("#print").hide();
	    	    jQuery("#aggerDate").hide();
	    	}
	    }
	    if(t_regb_state == '6'){  //带续借
	    	if(whereForm == '1'){  //从管理员入口进入
	    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
	    		jQuery("#btn_insert").hide();         //保存按钮
	    		jQuery("#btn_givety").hide();             //借阅同意
	    		jQuery("#btn_givebty").hide();             //借阅不同意
	    	    jQuery("#btn_xjyzx").hide();          //已知悉 
	    	    jQuery("#btn_xj").hide();             //续借按钮
	    	    jQuery("#btn_tsgh").hide();           //续借归还按钮
	    	    jQuery("#print").hide();           //续借归还按钮
	    	    jQuery("#aggerDate").hide();          //借阅时间和应归还时间  
	    	}else{
	    		jQuery("#T_REGB_AUDITOPINION").attr("readonly","true");
	    		jQuery("#btn_insert").hide();         //保存按钮
	    		jQuery("#btn_givety").hide();
	    	    jQuery("#btn_givebty").hide();
	    	    jQuery("#btn_xjyzx").hide();
	    	    jQuery("#btn_xj").hide();
	    	    jQuery("#btn_xjty").hide();
	    	    jQuery("#btn_xjbty").hide();
	    	    jQuery("#btn_tsgh").hide();
	    	    jQuery("#print").hide();
	    	    jQuery("#aggerDate").hide();
	    	}
	    }
	<%}else{%>
	    jQuery("#btn_givety").hide();
	    jQuery("#div_shyj").hide();//审核意见
	    jQuery("#btn_givebty").hide();
	    jQuery("#btn_xjyzx").hide();
	    jQuery("#btn_xj").hide();
	    jQuery("#btn_xjty").hide();
	    jQuery("#btn_xjbty").hide();
	    jQuery("#btn_tsgh").hide();
	    jQuery("#print").hide();
	    jQuery("#aggerDate").hide();
	<%}%>
}

jQuery(function(){
	var sqtype="<%=sqtype%>";
	if("领用申请"==sqtype){
		$("#btn_xj").hide();
	}
	hiddenDocument();
	loadYJYBookInfo('<%=userid%>');
	<%if(regBookList.size()>0){%>
	    loadBookInfo("<%=regBookList.get(0).get("t_regb_bookids")%>");
	<%}%>
	
	<%if(regBookBookList.size()>0){ 
	     for(int i = 0; i < regBookBookList.size(); i++){
	         Map<String,String> regBookBookMap = regBookBookList.get(i);
	         String index = ""+(i+1);
	%>
	            jQuery('#T_REG_BOOK_BOOK_NO<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_no")%>');
	            jQuery('#T_REG_BOOK_BOOK_ID<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_id")%>');
	            jQuery('#T_REG_BOOK_BOOK_NAME<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_name")%>');
	            jQuery('#T_REG_BOOK_BOOK_JG<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_jg")%>');
	            jQuery('#T_REG_BOOK_BOOK_BH<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_bh")%>');
	            jQuery('#T_REG_BOOK_BOOK_AUTER<%=index%>').val('<%=regBookBookMap.get("t_reg_book_book_auter")%>');
	            //有效状态
	            jQuery('#T_REG_BOOK_VALID_STATE<%=index%>').val('<%=regBookBookMap.get("validstate")%>');
	<%   }
	}%>
});
</script>
</head>
<body style="overflow-y: auto;overflow-x:hidden;"  class="vcenter" style="height: 100%;">
<div class="content_02_top" style="margin-bottom:10px;" id="divA">
	<input type="button" class="but_y_01" value="保存" onclick="savebean('save');" id="btn_insert"/>
	<input type="button" class="but_y_01" value="返回" onclick="backTo();" id="btn_update"/>
	<input type="button" class="but_y_01" value="借出" onclick="savebean('giveTY');" id="btn_givety"/>
	<input type="button" class="but_y_01" value="不同意" onclick="savebean('giveBTY');" id="btn_givebty"/>
	<input type="button" class="but_y_01" value="已知悉" onclick="savebean('xqYJX');" id="btn_xjyzx"/>
	<input type="button" class="but_y_01" value="续借" onclick="savebean('xq');" id="btn_xj"/>
	<input type="button" class="but_y_01" value="同意" onclick="savebean('xqTY');" id="btn_xjty"/>
	<input type="button" class="but_y_01" value="不同意" onclick="savebean('xqBTY');" id="btn_xjbty"/>
	<input type="button" class="but_y_01" value="归还" onclick="savebean('tsGH');" id="btn_tsgh"/>
	<input type="button" class="but_y_01" value="打印" onclick="prn1_preview()" id="print"/>
</div>
<form id="conferenceBase" name="conferenceBase" method="post" action="ibraryborrowDo.jsp" style="height: 100%;">
<div class="content_02_box_title_bg"><span>图书登记信息</span></div>
<input  type="hidden" name="subid" id="subid" value="<%=subid%>"/>
<input  type="hidden" name="actiontype" id="actiontype" value="save"/>
<input  type="hidden" name="doWhat" id="doWhat" value=""/>
<input type="hidden" id="T_REGB_ID" name="T_REGB_ID"  value="<%=t_regb_id%>"/>   <!-- 申请表主键 -->
<input type="hidden" id="T_REGB_TRUEGH_DATE" name="T_REGB_TRUEGH_DATE"  value=""/>   <!-- 实际归还时间 -->
<input type="hidden" id="T_REGB_BOOKIDS" name="T_REGB_BOOKIDS"  value=""/>   <!-- 借阅图书IDS -->
<input type="hidden" id="T_REGB_BOOKNAMES" name="T_REGB_BOOKNAMES"  value=""/>   <!-- 借阅图书名称 -->
<input type="hidden" id="T_REGB_STATE" name="T_REGB_STATE"  value=""/>   <!-- 申请状态 -->
<input type="hidden" id="T_REGB_ISKONW" name="T_REGB_ISKONW"  value="<%=t_regb_iskonw%>"/>   <!-- 是否知悉 -->
<input type="hidden" id="T_REGB_ISXJ" name="T_REGB_ISXJ"  value="<%=t_regb_isxj%>"/>   <!-- 是否续借 -->
<input type="hidden" id="T_REGB_SQTYPE" name="T_REGB_SQTYPE"  value="借阅申请"/>

<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>借阅人：</th>
		<td class="content_02_box_div_table_td">
			<input type="hidden" name="T_REGB_USER_ID" id="T_REGB_USER_ID" value="<%=userid%>"/>
			<input type="text" id="T_REGB_USER_NAME" readonly="readonly" name="T_REGB_USER_NAME" value="<%=user_name%>" class="validate[required] input_188"/>
		</td>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>申请时间：</th>
		<td class="content_02_box_div_table_td">
			<input class="validate[required] date_120 Wdate" type="text" id="T_REGB_DATE" name="T_REGB_DATE" value="<%=T_REGB_DATE%>"/>
		</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th" >登记部门:</th>
	    <td class="content_02_box_div_table_td" >
	    	<input type="text" class="input_188" readonly="readonly" name="T_REGB_ORG_NAME" id="T_REGB_ORG_NAME"  value="<%=org_name %>" >
	    	<input type="hidden" class="input_188" readonly="readonly" name="T_REGB_ORG_ID" id="T_REGB_ORG_ID" value="<%=org_id %>" >
	    	<input type="hidden" class="input_188" name="T_REGB_DEPT_ID" id="T_REGB_DEPT_ID" value="<%=dept_id %>" >       <!-- 所属单位ID -->
	    	<input type="hidden" class="input_188" name="T_REGB_DEPT_NAME" id="T_REGB_DEPT_NAME" value="<%=dept_name %>" >   <!-- 所属单位NAME --> 
	    </td>
	    <th class="content_02_box_div_table_th" >申请类型:</th>
	    <td class="content_02_box_div_table_td" >
	    	<input type="text" class="input_188" readonly="readonly" name="t_regb_sqtype" id="t_regb_sqtype"  value="<%=StringUtil.isBlank(sqtype)?"借阅申请":sqtype%>" >
	    </td>
    </tr>
    <tr  id="aggerDate">
        <th class="content_02_box_div_table_th">借阅时间：</th>
		<td class="content_02_box_div_table_td">
			<input type="text" name="T_REGB_JY_DATE" id="T_REGB_JY_DATE" readonly="readonly" value="<%=T_REGB_JY_DATE%>"/>
		</td>
        <th class="content_02_box_div_table_th">应归还时间：</th>
		<td class="content_02_box_div_table_td">
			<input type="text" name="T_REGB_GH_DATE" id="T_REGB_GH_DATE" readonly="readonly" value="<%=StringUtil.isBlank(sqtype)?"":T_REGB_GH_DATE%>"/>
		</td>
    </tr>
    
</table>
<div class="content_02_box_title_bg" style='height: 23%;' id="div_shyj">
    <div class="content_02_box_title_bg">
		<span>审核意见</span>
	</div>
	<div class="content_02_box_div">
		<table id="dayTableAudit" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" >
			 	<tr>
			 		<td>
			 			<textarea rows="5" cols="107" id="T_REGB_AUDITOPINION" name="T_REGB_AUDITOPINION"><%=StringUtil.deNull(T_REGB_AUDITOPINION) %></textarea>
			 		</td>
				</tr>
		</table>
	</div>
</div>	
<!-- 形成安排表 -->
<div class="content_02_box_title_bg" style="height: 100%;">
    <div class="content_02_box_title_bg">
		<span>借阅图书清单</span>
		<div class="content_02_box_add">
			<a onclick="Add_Books()" id="addRow4NewDay"><img src="../../../resources/images/add.gif"/>添加借阅的图书 </a>
		</div>
	</div>
	<div class="content_02_box_div">
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
 					<td class="content_02_box_div_table_th" style="text-align: center;width: 600px">图书名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 130px">图书编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 80px">有效状态</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 130px">数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 130px">作者</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">操作</td>
				</tr>
				<tr name="dayrowhidden" id="dayrowhidden"> 
					<td class="content_02_box_div_table_td"> 
						 <input type="hidden" id="T_REG_BOOK_ID" name="T_REG_BOOK_ID"  value=""/>              <!-- 申请图书表ID --> 
						  <input type="hidden" id="T_REG_BOOK_BOOK_ID" name="T_REG_BOOK_BOOK_ID"  value=""/>   <!-- 图书ID -->
						  <input type="hidden" id="T_REG_BOOK_BOOK_JG" name="T_REG_BOOK_BOOK_JG"  value=""/>   <!-- 图书价格 -->
						 <input type="text" id="T_REG_BOOK_BOOK_NAME" name="T_REG_BOOK_BOOK_NAME" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_BH" name="T_REG_BOOK_BOOK_BH" class="input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_VALID_STATE" name="T_REG_BOOK_VALID_STATE" class="input_title_text" readonly="readonly" style="text-align:center;"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_NO" name="T_REG_BOOK_BOOK_NO" class="input_title_text validate[custom[onlyNumberSp]]" style="text-align:center;"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_AUTER" name="T_REG_BOOK_BOOK_AUTER" class="input_title_text" style="text-align:center;" readonly="readonly" />
					</td>
					<td class="content_02_box_div_table_td"> 
						<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
								<a onClick="deleteDay(this,'')" id="delImg"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
						</div>
					</td>
				</tr>
		</table>
		</div>	
	<div class="content_02_box_title_bg">
	<span>已借阅图书清单</span>
	<div class="content_02_box_add">
	</div>
	</div>
	<div class="content_02_box_div">
	<table id="dayTabletwo" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
 					<td class="content_02_box_div_table_th" style="text-align: center;width: 607px">图书名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">图书编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 80px">有效状态</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">作者</td>
				</tr>
				<tr name="dayrowhiddentwo" id="dayrowhiddentwo"> 
					<td class="content_02_box_div_table_td"> 
						 <input type="hidden" id="T_REG_BOOK_IDtwo" name="T_REG_BOOK_IDtwo"  value=""/>              <!-- 申请图书表ID --> 
						  <input type="hidden" id="T_REG_BOOK_BOOK_IDtwo" name="T_REG_BOOK_BOOK_IDtwo"  value=""/>   <!-- 图书ID -->
						  <input type="hidden" id="T_REG_BOOK_BOOK_JGtwo" name="T_REG_BOOK_BOOK_JGtwo"  value=""/>   <!-- 图书价格 -->
						 <input type="text" id="T_REG_BOOK_BOOK_NAMEtwo" name="T_REG_BOOK_BOOK_NAMEtwo" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_BHtwo" name="T_REG_BOOK_BOOK_BHtwo" class="input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_VALID_STATEtwo" name="T_REG_BOOK_VALID_STATEtwo" class="input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_NOtwo" name="T_REG_BOOK_BOOK_NOtwo" class="input_title_text" style="text-align:center;" readonly="readonly"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_REG_BOOK_BOOK_AUTERtwo" name="T_REG_BOOK_BOOK_AUTERtwo" class="input_title_text" style="text-align:center;" readonly="readonly" />
					</td>
				</tr>
		</table>
		</div>
	
  </div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
<script type="text/javascript">
	var LODOP; //声明为全局变量 
	function prn1_preview() {
		//设置字体大小和显示位置
		//打字份数赋值		
		CreateOneFormPage();	
		LODOP.PREVIEW();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印图书借阅信息");
		LODOP.SET_PRINT_STYLE("FontSize",9);
		LODOP.SET_PRINT_STYLE("FontName","宋体");
        jQuery("#print_efficacy").text(jQuery("#sendEfficacy").val());
		LODOP.ADD_PRINT_TEXT(0,0,260,39,"");
		var newHtml="";
		var oldHtml = document.getElementById("conferenceBase").innerHTML+"";
		//添加样式
			newHtml = "<style type='text/css'>"
			newHtml +=".content_02_box_title_bg{ width:772px; height:31px; float:left; border-left:1px solid #fff;  border-right:1px solid #DFDFDF; font:bold 12px/31px '宋体'; color:#0c5daf;}"
			newHtml +=".content_02_box_div_table{ width:772px;}";
			newHtml +=".content_02_box_div_table_th{ border:1px solid; background:#F8F8F8; width:191px; height:29px; text-align:right;  font: normal 12px/29px '宋体'; border-color:#FFF #DFDFDF #DFDFDF #FFF;}"
			newHtml +=".content_02_box_div_table_td{ border-top:1px solid #fff; border-left:1px solid #fff; border-right:1px solid #DFDFDF; border-bottom:1px solid #DFDFDF; background:#fff;  height:29px; text-align:left;  font: normal 12px/29px '宋体'; }"
			newHtml +=".input_188{width:188px; height:24px; border:0; font:12px/24px ; display:block;overflow:hidden;  float:left; padding:0px 2px; display:inline; }"
			newHtml +=".content_02_box_div{ float:left; width:772px; overflow:hidden}"
			newHtml += "</style>"
			oldHtml = oldHtml.replaceAll("style=\"HEIGHT: 23%\"","style=\"height: 8%\"")
			newHtml += oldHtml;
		LODOP.ADD_PRINT_HTM(0,0,800,980,newHtml);
	};
</script>

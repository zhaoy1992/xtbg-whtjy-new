<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.ApplyinfoState"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoSearchBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.common.PagingBean"%>
<%@page import="java.util.List"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>车辆管理车辆申请查看页面</title>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	String subid= request.getParameter("subid");
	String apply_id= request.getParameter("apply_id");
	String shan= request.getParameter("shan");
	String subidpraent = request.getParameter("subidpraent");
	String urlpar = request.getParameter("urlpar");
	String sj = StringUtil.deNull(request.getParameter("sj")); //用车时间
	String car_id = "";
	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
	CarManageCarBean carManageCarBean = new CarManageCarBean();
	List<CarManageApplyinfoSearchBean> cmasList=new ArrayList<CarManageApplyinfoSearchBean>();
	List<CarManageCarBean> carManageCarBeanList = new ArrayList<CarManageCarBean>();
	CarManageCarDao carManageCarDao=null;
	if(!StringUtil.nullOrBlank(apply_id)){
		// 车辆申请基本信息
		CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
		carManageApplyinfoBean = carManageApplyinfoDao.findCarManageApplyinfoByApplyID(apply_id);
		// 车辆信息 carManageCarDaoImplymj
		carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
		int j=-1;
		if(!StringUtil.nullOrBlank(carManageApplyinfoBean.getCar_id())){
			car_id = StringUtil.deNull(carManageApplyinfoBean.getCar_id());
			carManageCarBean = carManageCarDao.findCarManageCarByCarID(carManageApplyinfoBean.getCar_id());
			
		}
			cmasList=carManageCarDao.findCarYuYueInfoList(sj);
	}
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">
/* 
 * 返回 
 
 */
 function back(){
	removeWindows('<%=subid%>',true);
	window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
}
 function back1(){
	 removeWindows('<%=subidpraent%>',true);
	window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
 }
</script>
<script type="text/javascript">
		var searchbytime = function(){
			var sj=jQuery("#use_starttime").val();
			window.location.href="carFpInfo.jsp?subid=<%=subid%>&sj="+sj+"&apply_id="+"<%=apply_id%>";
		}
		//roomlist.push({sn:'111'});
		var cmasList = <%=JSONObject.toJSON(cmasList).toString()%>
		//mettingroomList.push({room_id:'111',begin_time:'2012-11-8 11:30:00',end_tim:'2012-11-8 13:30:00'});
		var deltr;
		$(function(){
		var row = 1;
		var col = 18;
		var values = ['','','0:00-07:59','08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00-23:59'];
		var timeIDS = [759,859,959,1059,1159,1259,1359,1459,1559,1659,1759,1859,1959,2059,2359];

        var div = $("#tablediv");
		var table =	createTable();
		//初始化数据
		$(div).append($(table));
		for(var i=0;i<row;i++){
			var tr = createTr();
			for(var j=0;j<col;j++){
				var td = createTd();
				$(tr).append($(td));
				$(td).append(values[j]);
				if(j==1){
					$(td).attr("width","120px");
				}else if(j==0){
					$(td).attr("width","28px");
					$(td).attr("align","right");
				}
			}
			$(table).append($(tr));
		}
		//for(var i=0;i<roomlist.length;i++){
			$.each(cmasList,function(key, val) {
			if(!(document.getElementById(val.car_id))){
					var tr = createTr();
					tr.id=val.car_id;
					td = createTd();
					$(tr).append($(td));
					//var idName="day"+timeIDS[j-3]+val.car_id;
					var input = document.createElement("input");
					$(input).attr("type","checkbox");
					$(input).attr("name","radio");
					$(input).attr("id","checkbox"+val.car_id);
					$(input).attr("value",val.car_id+","+val.car_num);
					$(td).append($(input));
					var r = cmasList[i];
					var car_id ="";
					$(input).click(function(){
						/* car_id += cmasList[i].car_id;
						alert(car_id);
					    if($("input[name='radio']:checked")){
							
						}  */
						roomSgineClick(table,val);
					});
					td = createTd();
					$(tr).append($(td));
					$(td).append(val.car_num);
					
					//td = createTd();
					//$(tr).append($(td));
					//$(td).append(val.roomCapablity);
					 for(var j=3;j<col;j++){
						var td = createTd();
						$(tr).append($(td));
						$(td).attr("id","day"+timeIDS[j-3]+val.car_id);
					} 
					$(table).append($(tr));
			}
		});
			var sj=jQuery("#use_starttime").val(); //日期查询时间
			var now = new Date();
	        var year = now.getFullYear();       //年
	        var month = now.getMonth() + 1;     //月
	        var day = now.getDate();            //日
	        var CurrentDate="";  				//当前时间
	        var statetime;
  	        CurrentDate += year + "-";
	        if (month >= 10 )
	        {
	         CurrentDate += month + "-";
	        }
	        else
	        {
	         CurrentDate += "0" + month + "-";
	        }
	        if (day >= 10 )
	        {
	         CurrentDate += day ;
	        }
	        else
	        {
	         CurrentDate += "0" + day ;
	        }
	        var pageDate="";
	        if('<%=sj%>'==""){
	        	pageDate=CurrentDate;
			}else{
				 var pageDate="<%=sj%>";
			}
	       
		for(var i=0;i<cmasList.length;i++){
			if(cmasList[i].use_starttime==null||cmasList[i].use_starttime==""){
			}else{
				var st = cmasList[i].use_starttime;
				var begin = getRoomTime((cmasList[i].use_starttime));
				var end = getRoomTime((cmasList[i].use_endtime));
				var stime =cmasList[i].use_starttime;
				var etime =cmasList[i].use_endtime;
				stime=stime.substr(0,10);
				etime=etime.substr(0,10);
				if(Date.parse(stime.replace("-","/")) == Date.parse(pageDate.replace("-","/"))){
					if(Date.parse(etime.replace("-","/")) > Date.parse(pageDate.replace("-","/"))){
						//显示从开始时间到-23：59
						end = getRoomTime((etime+" "+"23:59"));
						for(var j =0;j<timeIDS.length;j++){
							if(begin <=timeIDS[j]&&end>=timeIDS[j]-59){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}else{
						//正常当天
						for(var j =0;j<timeIDS.length;j++){
							if(begin <=timeIDS[j]&&end>=timeIDS[j]-59){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}
				}else if(Date.parse(stime.replace("-","/")) < Date.parse(pageDate.replace("-","/"))){
					if(Date.parse(etime.replace("-","/")) > Date.parse(pageDate.replace("-","/"))){
						begin = getRoomTime((pageDate+" "+"0:00"));
						end = getRoomTime((etime+" "+"23:59"));
						for(var j =0;j<timeIDS.length;j++){
							if(begin <=timeIDS[j]&&end>=timeIDS[j]-59){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}
					if(Date.parse(etime.replace("-","/")) == Date.parse(pageDate.replace("-","/"))){
						begin = getRoomTime((pageDate+" "+"0:00"));
						for(var j =0;j<timeIDS.length;j++){
							if(begin <=timeIDS[j]&&end>=timeIDS[j]-59){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}
				}
				/*if(stime==etime)
				{
					if(CurrentDate==statetime||sj==statetime)
					{
						//var timeIDS = [759,859,959,1059,1159,1259,1359,1459,1559,1659,1759,1859,1959,2059,2359];
						for(var j =0;j<timeIDS.length;j++){
							if(begin <=timeIDS[j]&&end>=timeIDS[j]-59){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}
				}else{
					if(CurrentDate==statetime||sj==statetime)
					{
						for(var j =0;j<timeIDS.length;j++){
							if(end>=timeIDS[j]-59)
							{
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
							if(begin <=timeIDS[j]){
								$("#day"+timeIDS[j]+cmasList[i].car_id).css("background","red");
							}
						}
					}
				}*/
				
			}
		}
	});
		function isStartEndDate(startDate,endDate){   
			if(Date.parse(startDate.replace("-","/")) > Date.parse(endDate.replace("-","/"))){  
				return false; 
			}
	        return true;   
	    }  
					
		function getRoomTime(obj){
			var time= obj.split(" ");
			return time[1].replace(/:/g, "").replace("00", "");
		}
		
		function createTable(){
			var table = document.createElement("table");
			$(table).attr("border",0);
			$(table).attr("cellspacing",0);
			$(table).attr("cellpadding",0);
			$(table).attr("class","content_02_box_div_table");
				//$(table).attr("style","width:100%;");
			return table;
		}
		function createTr(){
			var tr = document.createElement("tr");
			return tr;
		}
		function createSelect(){
			var select = document.createElement("select");
			return select;
		}
		function createOption(){
			var option = document.createElement("option");
			return option;
		}
		function createTd(){
			var td = document.createElement("td");
			$(td).attr("class","");
			return td;
		}
		function roomSgineClick(table,obj){ 
			 if($("#checkbox"+obj.car_id).attr("checked")){
				//alert($("#checkbox"+obj.car_id).attr("id"));
				addtd(table,obj);
			 }else{
				// alert(2);
				 $("#deltr"+obj.car_id).remove(); 
			 }
			
		}
		
		function addtd(table,obj){
			 var tr = createTr();
			   $(tr).attr("id","deltr"+obj.car_id);
				deltr=tr;
				td1 = createTd();
				$(td1).attr("colspan","2");
				td2 = createTd();
				$(td2).attr("colspan","3");
				td3 = createTd();
				$(td3).attr("colspan","5");
				var select =createSelect();
				var sjid=obj.sjid.split(",");
				var sjnames=obj.sjname.split(",");
				$(select).attr("style","width:100px;");
				for(var i=0;i<sjnames.length;i++){
					if(i==0){
						$("#sjid").val(sjid[0]);
						$("#sjname").val(sjnames[0]);
					}
					var option =createOption();
					$(option).append(sjnames[i]);
					$(option).attr("value",sjid[i]);
					$(select).append($(option));
				}
				
						
				$(select).change(function(){
					selectClick(this);
				});
				$(td3).append("司机：");
				$(td3).append($(select));
				$(tr).append($(td1));
				$(tr).append($(td2));
				$(tr).append($(td3));
				$(td1).append("品牌："+obj.car_brand);
				$(td2).append("型号："+obj.car_type);
				$(table).append($(tr));	
		}


		function selectClick(obj){
			$("#sjid").val($(obj).val());
			$("#sjname").val($(obj).find("option:selected").text());
		}

		var passbtnMethod = function(){
			var radiovalue = "";
			$("input[name='radio']:checked").each(function (i,e){
				var v = "" != $(e).val()?$(e).val():"";
						if(i=0){
							radiovalue = v;
						}else{
							radiovalue +=v+"#";
						}
			})
			$("#selectCar_num").val(radiovalue);
			if(radiovalue=="")
			{
				return alert("未选择车辆");
			}else{
				var values=radiovalue.split(",");
				var spInfo = "{'apply_id':'"+<%=apply_id%>
					//+"','spyj':'"+ '同意'
					+"','car_id':'"+radiovalue
					//+"','car_num':'"+ values[1]
					+"','sjid':'"+ $("#sjid").val()
					+"','sjname':'"+ $("#sjname").val()
					+"','fpid':'"+ '<%=userid%>'
					+"','state':'"+ '<%=ApplyinfoState.APPLYINFO_SP_PASS%>'
					+"'}";
				
				$("#spInfo").val(descape(escape(spInfo)));
				
				var okF = function(){
					$("#form1").attr("target","hiddenFrame");
					$("#form1").submit();
				}
				var p={
						headerText:'提示',
						okName:'确认',
					    okFunction:okF,
					    cancelName:'取消'
					};
				alert("是否确定通过",p)
			}
		}
		
		/*
		函数:  directTocar
		说明:  直接派车
		参数:   无
		返回值: 无
		*/
		var directTocar = function(){
			var radiovalue = "";
			$("input[name='radio']:checked").each(function (i,e){
				var v = "" != $(e).val()?$(e).val():"";
						if(i=0){
							radiovalue = v;
						}else{
							radiovalue +=v+"#";
						}
			})
			$("#selectCar_num").val(radiovalue);
			if(radiovalue=="")
			{
				return alert("未选择车辆");
			} else {
				var values=radiovalue.split(",");
				var spInfo = "{'apply_id':'"+<%=apply_id%>
					+"','car_id':'"+radiovalue
					+"','sjid':'"+ $("#sjid").val()
					+"','sjname':'"+ $("#sjname").val()
					+"','fpid':'"+ '<%=userid%>'
					+"','directcar':'"+ '1'//直接派车
					+"','state':'"+ '<%=ApplyinfoState.APPLYINFO_SP_PASS%>'
					+"'}";
				
				$("#spInfo").val(descape(escape(spInfo)));
				
				var okF = function(){
					$("#form1").attr("target","hiddenFrame");
					$("#form1").submit();
				}
				var p={
						headerText:'提示',
						okName:'确认',
					    okFunction:okF,
					    cancelName:'取消'
					};
				alert("是否确定直接派车",p)
			}
		}
		
		var nopassbtnMethod = function(){
			var spInfo = "{'apply_id':'"+<%=apply_id%>
				+"','state':'"+ '<%=ApplyinfoState.APPLYINFO_NO_FP%>'
				+"','fpid':'"+ '<%=userid%>'
				+"'}";
			$("#spInfo").val(descape(escape(spInfo)));
			var okF = function(){
				$("#form1").attr("target","hiddenFrame");
				$("#form1").submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
					alert("是否确定不派车",p)
				}
		
	</script>


</head>

<body>
<form id="form1" name="form1" action="carspform.jsp" class="formular" method="post">
<input id="spInfo" name="spInfo" type="hidden" />
<input id="urlpar" name="urlpar" type="hidden" value="<%=urlpar %>"/>
<input id="sjid" name="sjid" type="hidden" />
<!-- 多加 id=apply_id id=shan    tl   2013-5-2  -->
<input id="spply_id" name="spply_id" type="hidden" value="<%=apply_id %>"/>
<input id="shan" name="shan" type="hidden" value="<%=shan %>"/>
<input id="selectCar_num" name="selectCar_num" type="hidden" value=""/>
<input id="sjname" name="sjname" type="hidden" />
 <div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="passbtnMethod();" value="确定" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="directTocar();" value="直接派车" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="nopassbtnMethod();" value="不派车" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width:100%; ">
 		<!--------------用车信息-------------->
 <div class="content_02_box_div" style=" width:100%; ">

 				<div class="content_02_box_title_bg" style=" width:100%; " >
					<span>用车预约状态</span>
				</div>
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style=" width:100%; ">
					<tr>
						<td width="16%" align="left">日期：</td>
						<td width="36%">
						<input type="text" class="validate[required] date_187" id="use_starttime" name="use_starttime"
					onfocus="WdatePicker({onpicked:function(){this.blur();},dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})" 
					value="<%=StringUtil.deNull(sj)%>"/>
					  </td>
						<td width="48%" align="left">
							<input id="backbtn" name="backbtn" type="button" class="but_y_01" onClick="searchbytime();" value="查询" />
					  </td>
					</tr>
				</table>
				<div id="tablediv" style=" width:100%; height:200px;overflow-x:hidden;  overflow-y:auto"  ></div>
				
		<!--  <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style=" width:100%; ">
			<tr>
				<td class="content_02_box_div_table_td" colspan="2">
				</td>
				<td class="content_02_box_div_table_td" colspan="2">
				</td>
			</tr>
			
		</table>-->
		
		<div class="content_02_box_title_bg" style=" width:100%; ">
			<span>用车信息</span>
		</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style=" width:100%; ">
			<tr >
				<th width="191" class="content_02_box_div_table_th">用车人：</th>
				<td class="content_02_box_div_table_td" >
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_name()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">用车事由：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_reason()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">用车时间：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_starttime()) %> 至 <%=StringUtil.deNull(carManageApplyinfoBean.getUse_endtime()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">目的地：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getDestination()) %>
				</td>
			</tr>
		</table>
</div>
 
 		<!--------------车辆信息-------------->
 <% if(!StringUtil.nullOrBlank(car_id)){ %>
<!--  <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>车辆信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="191" class="content_02_box_div_table_th">车辆：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_num()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">司机：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getDriver()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">品牌：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_brand()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">型号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_type()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">状态：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCurrent_state()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">审批意见：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getSpyj()) %>
				</td>
			</tr>
		</table>
</div>	 --> 
<% }%>
 
 </div>
</div>

<input id="" name="" type="hidden" value="" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
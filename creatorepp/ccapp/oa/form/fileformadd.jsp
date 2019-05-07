<%--
describe:表单添加页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaFormConfigBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String windowid = request.getParameter("windowid");
	String form_id = request.getParameter("form_id"); //表单ID
	String form_name = request.getParameter("form_name"); //表单名称
	String form_jsp_name = request.getParameter("form_jsp_name"); //表单JSP名称
	String form_background = request.getParameter("form_background"); //表单底色
	String form_width = request.getParameter("form_width"); //表单宽度
	String tag_width = request.getParameter("tag_width"); //元素宽度
	String tag_height = request.getParameter("tag_height"); //元素高度
	String tag_margins = request.getParameter("tag_margins"); //元素间隔PX
	//根据form_id查询出之前已经有的配置
	Formservice formservice = new FormserviceImpl();
	String formHtml = formservice.getFormHtml(form_id).replaceAll("\"","\\\"");
	//获取是否正文
	OaFormConfigBean bean = formservice.queryFormConfigInfo(form_id);
	String is_text = bean.getIs_text();
	if(StringUtil.nullOrBlank(bean.getFrom_ext_parm())){
		bean.setFrom_ext_parm("com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean");
	}
	
	boolean hasConfig = false;
	
	String margins = tag_margins;//元素间隔
	String dimensions = "30";//元素大小
	String widget_margins = "["+tag_margins+", "+tag_margins+"]";
	String widget_base_dimensions = "["+tag_width+","+tag_height+"]";
	int marginscolSize = (int)(Float.parseFloat(margins)*2);  //分割线宽度
	int maxColumn = (int)(Math.floor(Integer.parseInt(form_width)/(Integer.parseInt(tag_width)+marginscolSize))); //获取最大列数
	String txt_form_id = "txt_"+form_id; //正文ID
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;overflow-x:scroll;">
<head>
  <title>自定义表单</title>
  <script src="../resources/plug/jquery1.7/jquery-1.7.1.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="resources/gridster.js-master/js/jquery.gridster.js"></script>
  <link rel="stylesheet" type="text/css" href="resources/gridster.js-master/js/jquery.gridster.min.css">
  <script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
  <script type='text/javascript' src='../resources/util/public.js'></script>
  <script type='text/javascript' src='../resources/util/uuid.js'></script>
  <script src="../resources/util/public.js" type="text/javascript"></script>
  <script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
  <script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

  <script>
		//var ids = 1;
		var selectid = ""; 
		var margins = <%=margins%>;
		var dimensions = <%=dimensions%>;
		var widget_margins = <%=widget_margins%>;
		var widget_base_dimensions = <%=widget_base_dimensions%>;
		var tag_width = <%= tag_width%>;
		var tag_height = <%= tag_height%>;
		var gridster ;
		var rowcountmark = 20;
		jQuery(function(){ //DOM Ready
			jQuery(".gridster ul").gridster({
					widget_margins: widget_margins,//元素间隔
					widget_base_dimensions: widget_base_dimensions,//初始化宽度 
					avoid_overlapped_widgets: true,  //不可以重叠
					max_size_y: <%=maxColumn%>,				//最多可以添加行数
					max_size_x:  <%=maxColumn%>,				//最多可以添加列数
					max_cols:  <%=maxColumn%>
					//collision:{on_overlap_stop: function(collider_data){ }}
			  });
			gridster = jQuery(".gridster ul").gridster().data('gridster');
			
			//初始化Y轴刻度
			var pos = gridster.next_position(<%=maxColumn%>, 1); //获取定位
			if(pos.row >= rowcountmark){//动态添加行的时候动态添加刻度
				for(var i=rowcountmark+1; i<=pos.row;i++){
					jQuery("#t2").append("<tr><td><font size='1' color='black'>"+i+"</font></td></tr>");
				}
				rowcountmark = pos.row;
			}
		});
		//返回
		function back(){
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:function(){
			        	removeWindows('<%=windowid%>',true);
			        },
			        cancelName:'取消'
				};
				alert("返回后，将不会保存，确定返回？",p);
		}
		//添加元素
		function add(){
			var pos = gridster.next_position(rowcount, colcount); //获取定位
			if(pos.row > rowcountmark){//动态添加行的时候动态添加刻度
				for(var i=rowcountmark+1; i<=rowcountmark+10;i++){
					jQuery("#t2").append("<tr><td><font size='1' color='black'>"+i+"</font></td></tr>");
				}
				rowcountmark = rowcountmark+10;
			}
			var uuid = Math.uuidCompact();
			var rowcount = parseInt(jQuery("#rowcount").val());
			var colcount = parseInt(jQuery("#colcount").val());
			gridster.add_widget("<li id='"+uuid+"' onclick='onclickli(this)' ondblclick='setParm(this.id)'>请双击设置属性</li>",rowcount,colcount);
			//jQuery("#oatagHtml").append("<input id = 'oa_"+uuid+"' type='hidden' value='' />");
			//ids++;
			
		}
		
		//设置选中
		function onclickli(tag){
			if(selectid!=""){
				jQuery("#"+selectid).css("background","white"); 
			}
			jQuery(tag).css("background","#dde0e5"); 
			selectid= tag.id;
		}
		
		//设置属性
		function setParm(liid){
			var path =[
				'<%=path%>/ccapp/oa/form/configparm.jsp',
				'?liid='+liid,
				'&form_id=<%=form_id%>',
				'&from_ext_parm='+jQuery("#from_ext_parm").val()
			];
			openAlertWindows('',path.join(''),'配置属性',650,370,'25%','25%');
			 
		}
		
		//获取信息
		function get(){
			alert(jQuery(".gridster ul").html())
			var data = jQuery(".gridster ul").gridster().data('gridster').serialize();
			jQuery(".gridster ul li").each(function(){
				
			});
		}	
		
		//移除元素信息
		function removeLi(){
			//alert(jQuery("#oa_"+selectid).val())
			if(IsSpace(selectid)){
				alert("请选定要删除的元素。");
				return false;
			}
			//ajax方式提交数据
		    jQuery.ajax({
		        type: "post", 
		        url: "fileformadddo.jsp", 
		        contentType: "application/x-www-form-urlencoded; charset=utf-8",
		        data : {
		            action : 'delTag',
		            selectid : selectid 
		        },
		        dataType: "json", 
		        success: function (data) {
		        	if(data){
	                      //if(data.msg){
	                      //    alert(data.msg);
	                      // }
	                      //如果删除成功，刷新数据
	                      if(data.flag&&"true" == data.flag){
	                    	  gridster.remove_widget( jQuery("#"+selectid));
	  		    			   selectid="";
	                      }
	                  }
		        }, 
		        error: function (XMLHttpRequest, textStatus, errorThrown) { 
		            alert("出现异常，请稍后再试！");
		        } 
		     });     
		}
		
		//隐藏边框
		function hideMargin(direction){
			//var width = jQuery("#"+selectid).css("width");
			
			var sizex = jQuery("#"+selectid).attr("data-sizex");//获取宽度
			var sizey = jQuery("#"+selectid).attr("data-sizey");//获取高度
			var widths = (sizex-1)*(margins*2)+(tag_width*sizex);//计算出该控件的原始长度
			var heigths = (sizey-1)*(margins*2)+(tag_height*sizey);//计算出该控件的原始长度
			if(direction == "left"){
				jQuery("#"+selectid).width(widths+(margins*2));//控件加上边框宽度
				//jQuery("#"+selectid).css("margin-right",(margins*2));	  //边框影藏
				jQuery("#"+selectid).css("margin-left",-(margins*3));	  //边框影藏
			}else if(direction == "right"){
				jQuery("#"+selectid).width(widths+(margins*2));
				//jQuery("#"+selectid).css("margin-left",(margins*2));	  //边框影藏
				jQuery("#"+selectid).css("margin-right",-(margins*3));
			}else if(direction == "top"){
				jQuery("#"+selectid).height(heigths+(margins*2));
				jQuery("#"+selectid).css("margin-top",-(margins*3));
			}else if(direction == "bottom"){
				jQuery("#"+selectid).height(heigths+(margins*2));
				jQuery("#"+selectid).css("margin-bottom",-(margins*3));
			}
			
			//alert(width + "：测试："+widths);
			//jQuery("#"+selectid).width(widths+1);
			//jQuery("#"+selectid).css("marginLeft",-1);
			
		}
		
		//恢复边框线
		function reMargin(){
			var sizex = jQuery("#"+selectid).attr("data-sizex");//获取宽度
			var sizey = jQuery("#"+selectid).attr("data-sizey");//获取高度
			var widths = (sizex-1)*(margins*2)+(tag_width*sizex);//计算出该控件的原始长度
			var heigths = (sizey-1)*(margins*2)+(tag_height*sizey);//计算出该控件的原始长度
				jQuery("#"+selectid).width(widths);//控件加上边框宽度
				jQuery("#"+selectid).height(heigths);
				
				jQuery("#"+selectid).css("margin-left","");	  //边框影藏
				jQuery("#"+selectid).css("margin-right","");
				jQuery("#"+selectid).css("margin-top","");
				jQuery("#"+selectid).css("margin-bottom","");
			
		}
		
		//保存表单，生成页面
		function saveform(){
			jQuery("#"+selectid).css("background","white"); //取消选中
			selectid ="";
			var htmls = jQuery(".gridster ul").html();
			//jQuery("#paramJson").val(paramJson);//保存并更新填写状态
			jQuery(".gridster ul li").each(function(){ //
				var id = "oa_"+jQuery(this).attr("id");
				//var htmls = jQuery("#"+id).val();
				//alert(htmls);
				jQuery(this).html(id);
				jQuery(this).removeAttr("onclick");//移除相关事件
				jQuery(this).removeAttr("ondblclick");
				
			});
			var paramJson = jQuery(".gridster ul").html();
			//alert(paramJson);
			jQuery("#paramJson").val(paramJson);//此处是去除事件后的纯净HTML，用于生成HTML页面。
			jQuery("#confightmls").val(htmls);//此处是原HTML，用于保存修改表单。
			if(jQuery("#is_text").attr("checked")=="checked"){
				jQuery("#is_text_select").val("Y");
			}else{
				jQuery("#is_text_select").val("N");
			}
			
			document.all.formForm.target = "hiddenFrame";
			jQuery("#formForm").submit();
			jQuery(".gridster ul").html(htmls);
		}
		//配置正文
		function textConfig(){
			var checked = jQuery("#is_text").attr("checked");
			if("checked" == checked){
				var path = "<%=path%>/ccapp/oa/form/configtxt.jsp?txt_form_id=<%=txt_form_id%>&form_id=<%=form_id%>";
				openAlertWindows('',path,'配置正文属性',650,150,'25%','25%');
			}else{
				
			}
		}
		
		//配置隐藏域
		function addhideinput(){
			var path =  "<%=path%>/ccapp/oa/form/confighideinput.jsp?form_id=<%=form_id%>";
			openAlertWindows('',path,'配置隐藏域',820,240,'25%','25%');
		}
	</script>
	<style>
		body{
			font-family: Helvetica, arial, sans-serif;
			margin:10px auto;
			color: #fff;
			font-size: 12px;
			width:1024px;
			text-align:center;
		}
		ul{	
			background:<%=form_background%>;
			list-style:none;
			border: solid <%=marginscolSize%>px <%=form_background%>;
			height: 0px;
		}
		li{	
			background:white;
			border-collapse:collapse;
			color: black;
			margin:-0.5px;
			text-align: left;
			line-height: 100%;
			font: normal;
		}
		#t1 td{
		background-color: white;
		width: <%=Integer.parseInt(tag_width)-2%>px;
		height: 2px;
		}
		#t2 td{
		background-color: white;
		width: 2px;
		height: <%=Integer.parseInt(tag_height)-2%>px;
		}
	</style>

</head>
<body style="s">
<form id="formForm" name="formForm" action="fileformadddo.jsp" method="post">
	<input type="hidden" name="action" id="action" value="save">
	<input type="hidden" name="paramJson" id="paramJson" value="">
	<input type="hidden" name="form_id" id="form_id" value="<%=form_id %>">
	<input type="hidden" name="confightmls" id="confightmls" value="">
	<input type="hidden" name="is_text_select" id="is_text_select" value="">
	<article>
		<section>
		<%--row1--%>
		<div align="left" >
			<span style="color: black;">所占列数：</span><input type="text" id = "rowcount" value =" <%=maxColumn%>"/>	<span style="color: black;">所占行数：</span><input type="text" id = "colcount" value ="1"/>
			&nbsp;&nbsp;
				<input type="button" value="增加" class='but_y_01' style="float: none;" onclick="add()"/>
			&nbsp;&nbsp;
			<input type="button" value="删除" class='but_y_01' style="float: none;" onclick="removeLi()"/>
			<!-- <input type="button" value="获取数据" class='but_y_01' style="float: none;" onclick="get()"/> -->
			&nbsp;&nbsp;
			<input type="button" value="保存表单" class='but_y_01' style="float: none;" onclick="saveform()"/>
			&nbsp;&nbsp;
			<input type="button" value="返回" class='but_y_01' style="float: none;" onclick="back()"/>
			&nbsp;&nbsp;
	   </div>
	   <%--row2 left--%>
	   <div style="height: 30px;float:left;margin-top: 10px;">
	  		<input type="button" value="隐藏左边框" class='but_y_01' style="margin-left: 5px;" onclick="hideMargin('left')"/>
			&nbsp;&nbsp;
			<input type="button" value="隐藏右边框" class='but_y_01' style="margin-left: 5px;"  onclick="hideMargin('right')"/>
			&nbsp;&nbsp;
			<input type="button" value="隐藏上边框" class='but_y_01' style="margin-left: 5px;"  onclick="hideMargin('top')"/>
			&nbsp;&nbsp;
			<input type="button" value="隐藏下边框" class='but_y_01' style="margin-left: 5px;"  onclick="hideMargin('bottom')"/>
			&nbsp;&nbsp;
			<input type="button" value="恢复边框线" class='but_y_01' style="margin-left: 5px;"  onclick="reMargin()"/>
	    </div>
	    <%--row2 middle--%>
		<div style="float: left;height: 30px;margin-top: 10px;margin-left: 15px;">
			<div id="text_bottom" style="display:block;">
			<div style="float: left;line-height: 30px;">
				<input style='display: block;float:left;margin-top: 6px;' type="checkbox" name ="is_text" id="is_text" <%if("Y".equals(is_text)){%>checked="checked"  <%} %> onclick="textConfig()"/>
				<span style="display: block;float:left;margin-top: -3px;color: black;">&nbsp;&nbsp;是否有正文&nbsp;&nbsp;</span>
			</div>
			<input type="button" value="配置正文" class='but_y_01' style="margin-left: 5px;"  onclick="textConfig()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="配置隐藏域" class='but_y_01' style="margin-left: 5px;"  onclick="addhideinput()"/>
			</div>
		</div>
		<%--row2 right--%>
		<div style="float: left;height: 30px;margin-top: 10px;margin-left: 15px;">
			<div style="display:block;">
				<div style="float: left;line-height: 30px; display: none">
					<span style="display: block;float:left;margin-top: -3px;color: black;">页面初始化处理对象&nbsp;&nbsp;</span>
					<input title="后续该处理对象将自动生成,暂时手动配置" value="<%=bean.getFrom_ext_parm()%>" style='width:400px;display: block;float:left;margin-top: 6px;' type="text" name ="from_ext_parm" id="from_ext_parm" />
				</div>
			</div>
		</div>
		
		
		<table>
		<tr>
		<td></td>
		<td>
		<div style="width: <%=form_width%>px;">
				<table id="t1" cellspacing='<%= marginscolSize%>' style="border:0px;background: red;">
				<tr>
				<%for(int i=0; i<Math.floor(Integer.parseInt(form_width)/(Integer.parseInt(tag_width)+marginscolSize)); i++){ %>
				<td><font size="1" color="black"><%=i+1 %></font></td>
				<%} %>
				</tr>
				</table>
		</div>
		</td>
		</tr>
		<tr>
		<td valign="top">
		<div >
			<table id="t2" cellspacing='<%= marginscolSize%>' style="border:0px;background: red;">
			<%for(int i=0; i<20; i++){ %>
				<tr><td><font size="1" color="black"><%=i+1 %></font></td></tr>
				<%} %>
			</table>
		</div>
		</td>
		<td style="width: <%=form_width%>px;margin:0px" valign="top">
		<div class="gridster" >
			<ul >
			<%out.print(formHtml); %>
			</ul>
		</div>
		</td>
		</tr>
		</table>
		</section>
	</article>
	<div style="height:50px">
	</div>
</form>
<iframe name="hiddenFrame" height="0" width="0"></iframe>	
</body>
</html>

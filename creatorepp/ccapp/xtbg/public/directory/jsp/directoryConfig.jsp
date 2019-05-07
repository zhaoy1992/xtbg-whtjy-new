<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="../resources/css/style_config.css" rel="stylesheet" type="text/css">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
var orgid = '<%= request.getParameter("orgid")%>';
var nodes;
$(function(){
	var span = {
			url : window.top.getContextPath()+'/tree',
			success : function(ss) {
				if(window.top.json.returnValue !='none')
			    {
					nodes= window.top.json.returnValue;
					$.each(nodes, function(key, val) {
						var div =document.createElement("div");
						$("#mover_box").append($(div));
						$(div).attr("id","d"+key);
						$(div).attr("directoryid",val.directoryid);
						$(div).addClass("box_meun");
						$(div).html(val.directoryname);
						var flag = true;
						$(div).click(function(){
							$(div).removeClass();
							if(flag){
								$(div).addClass("box_meun_select");
								flag=false;
							}else{
								$(div).addClass("box_meun");
								flag = true;
							}
						});
					});

			    }
			},
			data : '{"orgid":"'+orgid+'"}',
			classID : 'config',
			method : 'findTypeList'
		}
		window.top.ajaxTools(span);
});


	function moverFunction(type) {
		var selectAll = $(".box_meun_select");
		if (type == 1) {
			for ( var i = selectAll.length - 1; i >= 0; i--) {
				var div = $("#mover_box").children().first();
				if($(selectAll[i]).attr("id") != $(div).attr("id"))
				$(selectAll[i]).insertBefore($(div));
			}
		}
		
		if (type == 2) {
			for ( var i = 0; i < selectAll.length; i++) {
				var div = $(selectAll[i]).prev();
				$(selectAll[i]).insertBefore($(div));
			}
		}


		if (type == 3) {
			for ( var i = selectAll.length - 1; i >= 0; i--) {
				var div = $(selectAll[i]).next();
				$(selectAll[i]).insertAfter($(div));
			}
		}
		
		if (type == 4) {
			for ( var i =  0; i < selectAll.length; i++) {
				var div = $("#mover_box").children().last();
				if($(selectAll[i]).attr("id") != $(div).attr("id"))
				$(selectAll[i]).insertAfter($(div));
			}
		}
	}
	
function save(){
	var div = $("#mover_box").children();
	var ids="";
	var orderIDs="";
	$.each(div, function(key, val) {
	   if(key!=0){
		   ids+=','+$(val).attr("directoryid");
		   orderIDs+=','+key;
	   }else{
		   ids=$(val).attr("directoryid");
		   orderIDs=key;
	   }
	});
	
	var span = {
			url : window.top.getContextPath()+'/tree',
			dataType:"text",
			success : function(ss) {
				var p = new Object();
				p.headerText='提示';
				p.okName='确认';
				p.okFunction=closewindow;
				window.top.alert("保存成功！",p);
			},
			data : '{"orgid":"'+orgid+'","userids":"'+ids+'","orderBys":"'+orderIDs+'"}',
			classID : 'config',
			method : 'insertUserOrderBy'
		}
		window.top.ajaxTools(span);
}
function closewindow(){
	window.top.getParentWindow("").userSearch();
	window.top.removeAlertWindows("", true);
	
}
</script>
</head>
<body>
<div class="mobile">
  <div class="mb_box">
    <div class="mover_herder">领导姓名</div>
    <div class="mover_box" >
      <div id="mover_box" class="mover_box_class">
      
      </div>
    </div>
  </div>
  <div class="mb_cet"><img src="../resources/images/mb_bg_cet.gif" /></div>
  <div class="mb_push">
   <ul>
    <li><input name="" type="button"  value="置 顶"/ onclick="moverFunction(1)" class="mb_input01" onmouseover="this.className='mb_input01_hover'"onmouseout="this.className='mb_input01'" ></li>
	<li><input name="" type="button" value="上 移"/ onclick="moverFunction(2)" class="mb_input02" onmouseover="this.className='mb_input02_hover'"onmouseout="this.className='mb_input02'"/></li>
	<li><input name="" type="button" value="下 移"/ onclick="moverFunction(3)" class="mb_input03" onmouseover="this.className='mb_input03_hover'"onmouseout="this.className='mb_input03'"/></li>
	<li><input name="" type="button" value="置 底"/ onclick="moverFunction(4)"  class="mb_input04" onmouseover="this.className='mb_input04_hover'"onmouseout="this.className='mb_input04'"/></li>
   </ul>
  </div>
</div>
<div class="cue_box_foot">
			<span><input name="Input" value="关闭" type="button"
				class="but_y_01" onclick="closewindow()"/> <input name="Input2" value=" 保存" type="button"
				class="but_y_01" onclick="save();" /></span>
</div>
</body>
</html>


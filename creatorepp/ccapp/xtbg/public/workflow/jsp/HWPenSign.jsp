<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String user_id = accesscontroler.getUserID(); //用户id
	String user_name = accesscontroler.getUserName(); //用户中文名
	String user_orgName =accesscontroler.getChargeOrgName();
	String send_id = request.getParameter("send_id");
	String ideatextid = request.getParameter("ideaid");
	String action_defid = request.getParameter("action_defid");
	
	String attachment_id = new Date().getTime()+"";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>汉王手写签批测试页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/js/util/jsonutil.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


    <style type="text/css">
        .style1
        {
            font-size: xx-large;
            font-family: 宋体, Arial, Helvetica, sans-serif;
            color: #FF3399;
        }
       .style2
        {
            font-size: 16px;
            font-family: 宋体, Arial, Helvetica, sans-serif;
            color: #FF3399;
        }
       .style3
        {
            font-size: 12px;
            font-family: 宋体, Arial, Helvetica, sans-serif;
            color: #000000;
        }
		.style4
        {
            font-size: 12px;
            font-family: 宋体, Arial, Helvetica, sans-serif;
            color: #FF0000;
        }
   </style>
<script language="javascript" type="text/javascript">

 penwidth = 3;
 var obj;

window.onload = function(){  
                  obj = document.getElementById("HWPenSign"); 
                  obj.HWSetBkColor(0xE0F8E0);  
		  		  obj.HWSetCtlFrame(2, 0x000000);
                  obj.HWSetFilePath("C:\\sign.gif"); 
             	  // 初始化设备
                  obj.HWInitialize();
}    


function Button1_onclick() {
   res = obj.HWInitialize();
}

function Button2_onclick() {
   var stream;
   stream = obj.HWFinalize();
}


function Button3_onclick() {
   obj.HWClearPenSign();
}

function Button6_onclick() {
   obj.HWSetPenColor(0x000000);   
}

function Button7_onclick() {
   obj.HWSetPenColor(0xFF0000);   
}

function Button8_onclick() {
   obj.HWSetPenColor(0x00FF00);   
}

function Button9_onclick() {
   obj.HWSetPenColor(0x0000FF);   
}

function Button10_onclick() {
    penwidth++;
    if(penwidth >5)
       penwidth = 5;
    obj.HWSetPenWidth(penwidth);   
}

function Button11_onclick() {
    penwidth--;
    if(penwidth < 1)
       penwidth = 1;
    obj.HWSetPenWidth(penwidth);   
}

function Button12_onclick() {
   obj.HWSetPenMode(1);
}

function Button13_onclick() {
   obj.HWSetPenMode(0);
}

//保存图片为Base64Stream
function Button14_onclick() {
   var stream;
   stream = obj.HWGetBase64Stream(3);
   alert(stream.length);
}

//保存图片
function Button15_onclick() {   
    obj.HWSaveFile();
   //保存图片到服务器上
    savePic();
}

//保存意见
function ok(){
	
	//保存图片到服务器上
    //savePic();
    //签名
    getParentWindow("").jQuery("#HwPenSignType").val("1");
	//保存到服务器图片
	getParentWindow("").jQuery('#imageUrl').val("<%=attachment_id %>.gif");
	getParentWindow("").jQuery('#userid').val(jQuery('#userid').val());
	getParentWindow("").jQuery('#username').val(jQuery('#username').val());
	getParentWindow("").jQuery('#orgid').val(jQuery('#orgid').val());
	getParentWindow("").jQuery('#orgname').val(jQuery('#orgname').val());
	getParentWindow("").createIdeaInfo();
	//关闭设备
	var stream;
	stream = obj.HWFinalize();
	removeAlertWindows('',true)
}

function Button16_onclick() {
   obj.HWSwitchMonitor(1,0);
}

function Button17_onclick() {
   obj.HWSwitchMonitor(0,0);
}


function PrePage_Event() {
    alert("PrePage_Event");
}

function NextPage_Event() {
    alert("NextPage_Event");
}

//设备中确认按钮
function Confirm_Event() {
	//保存图片
	Button15_onclick();
}

//设备中取消按钮
function Cancel_Event() {
	//重新签名
	Button3_onclick();
}
/*
 * 说明：文件上传事件 参数：无 返回值：无 作者：jichang.long
 */
function savePic(){
		jQuery("#form_up").submit(); 
}


</script>

</head>
<body >
    <table width="90%" border="0" align="center" cellpadding="3" cellspacing="0"> 
    	<tr>
	    	<td>
		    	<input type="hidden" id="userid" name="userid"/>
				<input type="hidden" id="username" name="username"/>
				<input type="hidden" id="orgid" name="orgid"/>
				<input type="hidden" id="orgname" name="orgname"/>  
			</td>     
		</tr>   
       <tr class="style7">
           <td  align="left">
              <object id="HWPenSign"
                    name="HWPenSign"
                    classid="clsid:72EB40AC-730B-4074-BE1B-1255E14F39AD"
                    width="700"
                    height="400">
              </object>
	   </td>
       </tr>                       
    </table>
    <div>
     <form action="uploadimage.jsp?attachment_ids=<%=attachment_id %>" target="hiddenFrame" method="post" enctype="multipart/form-data" name="form_up" id="form_up">
	<table>
		<tr>
			<td colspan="3" align="left">
				<div style="float: left;">意见签名选择：</div><input type="file" id="imgfile"  name="imgfile"  class="input_188"   style="margin-left:10px ;width: 250px" value="意见" /> 
			</td>
		</tr>
		<tr>
			<td align="left">
			      <div style="float: left;">签名控制： </div>
		          <input id = "button1" type ="button" class="but_y_01" value="初始化设备" style="margin-left:10px" onclick ="return Button1_onclick()" />
		          <input id = "button2" type ="button" style="margin-left:10px"  class="but_y_01" value="关闭设备" onclick ="return Button2_onclick()" />
		          <input id="Button3" type="button" style="margin-left:10px" class="but_y_01" value="重新签名" onclick="return Button3_onclick()" />
		           	
			</td>
		</tr>
	     <tr>
			<td align="left">
	         	<div style="float: left;">签名图像：</div>
		           <input id="Button15" type="button"  style="margin-left:10px" class="but_y_01" value="保存图像" onclick="return Button15_onclick()" /> 
		             &nbsp;&nbsp; 
		           <input id="Button15" type="button" style="margin-left:10px" class="but_y_01" value="保存意见" onclick="return ok()" /> 
		          	&nbsp;&nbsp;
		          	
	          <br/>
	      </td>
		</tr>
    </table>
    </form>
  	</div>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
       
        

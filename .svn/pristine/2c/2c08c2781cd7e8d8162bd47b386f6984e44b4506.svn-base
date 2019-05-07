<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/purviewmanager/css/treeview.css">
		<title>密码修改</title>
		
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
		<!-- dwr end -->
		
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			 src="<%=request.getContextPath()%>/epp/eppTemplate/pageGrey.js"></script>
		<script language="javascript" type="text/javascript">
		//
			//去除字符串空格
			function trim(string){
				var temp="";
				string = ''+string;
				splitstring = string.split(" ");
				for(i=0;i<splitstring.length;i++){
					temp += splitstring[i];
				} 
				return temp;
			}
			
			//验证数据、调用后台JAVA类方法
			function editpass(){
				var form = document.forms[0];
				var username = form.username.value;
				var oldpassword = form.oldpassword.value;
				var newpassword = form.newpassword.value;
				var repassword = form.repassword.value;
				
				if (trim(username).length == 0 ){
			    	document.getElementById("username_message").innerHTML = "请录入用户名！"; 
			    	return false;
			    }else{
			    	document.getElementById("username_message").innerHTML = "";
			    }
			    
			    if (trim(newpassword).length < 6 ){
			    	document.getElementById("newpassword_message").innerHTML = "密码不能少于 \"6\" 位有效字符！"; 
			    	return false;
			    }else{
			    	document.getElementById("newpassword_message").innerHTML = "";
			    }
			    
			    if (newpassword != repassword ){
			    	document.getElementById("repassword_message").innerHTML = "确认密码不一致！"; 
			    	return false;
			    }else{
			    	document.getElementById("repassword_message").innerHTML = "";
			    }
			    
			    //提交后页面变灰
			    popSignFlow(1);
			    
			    //修改密码
			    applyChange.editPassword(username,oldpassword,newpassword,result);
			} 	
			
			//回调函数，显示修改密码结果
			function result(obj){
				var message = obj.split(",");
				//页面变灰恢复正常
				cancelSign();
				if(message[0]=="result_message"){
					alert(message[1]);
					window.close();
					window.returnValue=true;
				}else{
					document.getElementById(message[0]).innerHTML = message[1];
				}
			}
		//
		</script>			 

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="form">
			
				<br/>
				<br/>
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">密码修改</FONT>
						</LEGEND>
				<br />
				<br />
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>用户名：
						</td>
						<td height="35">
							<input type="text" name="username" style="width=50%" maxlength="100" />
							<span id="username_message" style="color: #CC0000;" />
						</td>
					</tr>

					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>旧密码：
						</td>
						<td height="35">
							<input type="password" name="oldpassword" style="width=50%" maxlength="100" />
							<span id="oldpassword_message" style="color: #CC0000;" />
						</td>
					</tr>

					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>新密码：
						</td>
						<td height="35">
							<input type="password" name="newpassword" style="width=50%" maxlength="100" />
							<span id="newpassword_message" style="color: #CC0000;" />
						</td>
					</tr>

					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>确认密码：
						</td>
						<td height="35">
							<input type="password" name="repassword" style="width=50%" maxlength="100" />
							<span id="repassword_message" style="color: #CC0000;" />
						</td>
					</tr>
				</table>
				<br/><br/>
				</fieldset>
				
				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br/>
								<input name="update" type="button" onclick="editpass();"
									class="input" value="修改">
								<input name="calc" type="reset" class="input" value="重置">
								<input name="calc" type="button" class="input" value="返回"
									onClick="window.close();window.returnValue=true;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>		
	</body>	
</html>

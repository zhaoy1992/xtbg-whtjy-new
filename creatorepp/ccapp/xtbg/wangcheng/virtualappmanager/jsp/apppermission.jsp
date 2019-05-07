<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>

<script type="text/javascript">
<!--
	function togrant(orgid,orgname){
		document.getElementById("appcontrol").src="apppermissioncontrol.jsp?orgid="+orgid+"&orgname="+encodeURI(encodeURI(orgname));
	}
//-->
</script>

</head>
<body>

	<iframe id="orgtree" align="left" scrolling="no" marginheight="0" frameborder="1"  src="apporgtree.jsp?isnokeshi=false" width="30%" height="600px"></iframe>
	
	<iframe id="appcontrol" scrolling="yes" marginheight="0" frameborder="1"  src="" width="70%" height="600px"></iframe>	
	
</body>
</html>
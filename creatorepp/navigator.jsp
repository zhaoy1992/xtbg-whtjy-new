<%@ page contentType="text/html; charset=gbk" %>
<%@ page import ="java.util.*" %>

<html>
	<head>
		<link href="css/navigator.css" rel="stylesheet" type="text/css">
		<script language="javascript1.2" src="leftFrame.js"></script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#B9CEF0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onselectstart="return false" ondragstart="return false">
 
		<script language="JavaScript">
			init(3);
			addItem('0','ͼ��','mapLeft.jsp');
			addItem('1','�ͼ��','activeLayer.jsp');
			addItem('2','����','mapLeft.jsp');
			finishIt();
			clickItem(0);
		</script>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<HTML>
<HEAD>
<TITLE>展示测试页面</TITLE>
<%
	String busi_id = request.getParameter("busi_id");
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入其它 -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/testvo.js" type="text/javascript"></script>

<script type="text/javascript">
/*
	函数:   checkByDataset
	说明:   通用验证方法
	参数:   无
	返回值: true/false
*/
function checkByDataset() {
	return true;
}
/*
	函数:   getInputData
	说明:   获得页面要保存的元素
	参数:   无
	返回值: Json
*/
function getInputData() {
	var inputDatas = new Array();
	inputDatas[0] = "testFlowClass";
	//var testvo = getVoFromPage(new TestVo());
	var testvo = new TestVo();
	testvo.busi_data = $("#busi_data").val();
	testvo.busi_id = "<%=busi_id %>";
	inputDatas[1] = getJsonString(testvo);
	return inputDatas;
}

</script>
</HEAD>
<BODY>
<form name="form1" method="post" id="form1" action="">
	<div >
		<table >
			<tr>
				<td>
					测试页面元素
				</td>
				<td>
					<input type="text" id="busi_data" name="busi_data">
				</td>
			</tr>
		</table>
	</div>
</form>
</BODY>
</HTML>

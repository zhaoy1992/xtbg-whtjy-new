
<%@ page language="java" contentType="text/html; charset=GBK"%>
<HTML>
<HEAD>
<TITLE>չʾ����ҳ��</TITLE>
<%
	String busi_id = request.getParameter("busi_id");
%>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- �������� -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/testvo.js" type="text/javascript"></script>

<script type="text/javascript">
/*
	����:   checkByDataset
	˵��:   ͨ����֤����
	����:   ��
	����ֵ: true/false
*/
function checkByDataset() {
	return true;
}
/*
	����:   getInputData
	˵��:   ���ҳ��Ҫ�����Ԫ��
	����:   ��
	����ֵ: Json
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
					����ҳ��Ԫ��
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

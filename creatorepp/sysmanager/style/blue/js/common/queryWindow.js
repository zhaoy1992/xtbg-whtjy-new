/**
 * ��ѯ����
 * width ��ѯ���ڵĿ��
 * heigth ��ѯ���ڵĸ߶�
 * queryURL �����ѯ�����ļ���URL
 * iframeWinURL ��ѯ�����ļ���URL
 */
function openQuerys(width,height,queryURL,iframeWinURL) {
    var obj = new Object();
    obj.myStr = new Array(1);
    obj.myStr[0] = queryURL;//'../mgene/other/checkRegisterQuery.jsp';'../../../jsp/common/queryWindow.jsp

    var adjustWidthValue = 17;
    var adjustHeightValue = 22;
    var widthValue = width;
    var heightValue = height;
    var topValue = 200;
    var leftValue = 300;
    var strDlgFeather='dialogTop:'+topValue+';dialogLeft:'+leftValue+'px;dialogWidth:'+widthValue+'px;dialogHeight:'+heightValue+'px;center:yes;status:no;menu:no;help:0;history:noresizable:no;';
    var obj = window.showModalDialog(iframeWinURL,obj,strDlgFeather);
}

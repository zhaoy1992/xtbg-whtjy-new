/**
 * ��ģʽ���ڵķ�ʽ��word�ĵ���������
 * url word�ĵ�����ҳ������·�������磺��../../word/wordWindow.jsp��
 * labelName word�ĵ��ж���ı�ǩ���ƣ��ԡ������ָ�
 * labelValue �����滻word�ĵ��ж���ı�ǩ���Ƶ�ֵ���ԡ������ָҪ��labelName������������һ��
 * openFile �򿪵�word�ĵ����ļ�������������չ��
 * saveFile �����word�ĵ����ļ�������������չ��
 * templateFile �򿪵�wordģ����ļ�������������չ��
 * fileType �ļ����ͣ����ļ���չ��
 * fileStatus �Ժ�����ʽ���ļ���0��ģ����� 1��������ʽ���ĵ��� 2��ֻ����ʽ���ĵ���������ѡ�2������ʾ�����桿��ť
 * closeFlag �Ƿ���ʾ���رա���ť��0������ʾ��1����ʾ
 * printFlag �Ƿ���ʾ����ӡ����ť��0������ʾ��1����ʾ
 */
function openWord(url,labelName,labelValue,openFile,saveFile,templateFile,fileType,fileStatus,closeFlag,printFlag) {
    var obj = new Object();
    obj.myStr = new Array(9);
    obj.myStr[0] = labelName;
    obj.myStr[1] = labelValue;
    obj.myStr[2] = openFile;
    obj.myStr[3] = saveFile;
    obj.myStr[4] = templateFile;
    obj.myStr[5] = fileType;
    obj.myStr[6] = fileStatus;
    obj.myStr[7] = closeFlag
    obj.myStr[8] = printFlag;

    var adjustWidthValue = 17;
    var adjustHeightValue = 22;
    var widthValue = 1200;
    var heightValue = 740;
    var topValue = 1;
    var leftValue = 1;
    var strDlgFeather='dialogTop:'+topValue+';dialogLeft:'+leftValue+'px;dialogWidth:'+widthValue+'px;dialogHeight:'+heightValue+'px;center:yes;status:no;menu:no;help:0;history:noresizable:no;';
    var obj = window.showModalDialog(url,obj,strDlgFeather);
}

/**
 * ��ģʽ���ڵķ�ʽ��word�ĵ���������
 * url word�ĵ�����ҳ������·�������磺��../../word/wordWindow.jsp��
 * labelName word�ĵ��ж���ı�ǩ���ƣ��ԡ������ָ�
 * labelValue �����滻word�ĵ��ж���ı�ǩ���Ƶ�ֵ���ԡ������ָҪ��labelName������������һ��
 * openFile �򿪵�word�ĵ����ļ�������������չ��
 * saveFile �����word�ĵ����ļ�������������չ��
 * templateFile �򿪵�wordģ����ļ�������������չ��
 * fileType �ļ����ͣ����ļ���չ��
 * fileStatus �Ժ�����ʽ���ļ���0��ģ����� 1��������ʽ���ĵ��� 2��ֻ����ʽ���ĵ���������ѡ�2������ʾ�����桿��ť
 * closeFlag �Ƿ���ʾ���رա���ť��0������ʾ��1����ʾ
 * printFlag �Ƿ���ʾ����ӡ����ť��0������ʾ��1����ʾ
 * imageLabelName ͼƬ��ǩ��
 * imageLabelValue ͼƬ��ǩֵ
 * localFile �򿪵ı����ļ���
 */
function openWord(url,labelName,labelValue,openFile,saveFile,templateFile,fileType,fileStatus,closeFlag,printFlag,imageLabelName,imageLabelValue,localFile) {
    var obj = new Object();
    obj.myStr = new Array(12);
    obj.myStr[0] = labelName;
    obj.myStr[1] = labelValue;
    obj.myStr[2] = openFile;
    obj.myStr[3] = saveFile;
    obj.myStr[4] = templateFile;
    obj.myStr[5] = fileType;
    obj.myStr[6] = fileStatus;
    obj.myStr[7] = closeFlag
    obj.myStr[8] = printFlag;
    obj.myStr[9] = imageLabelName;
    obj.myStr[10] = imageLabelValue;
	obj.myStr[11] = localFile;

    var adjustWidthValue = 17;
    var adjustHeightValue = 22;
    var widthValue = 1200;
    var heightValue = 740;
    var topValue = 1;
    var leftValue = 1;
    var strDlgFeather='dialogTop:'+topValue+';dialogLeft:'+leftValue+'px;dialogWidth:'+widthValue+'px;dialogHeight:'+heightValue+'px;center:yes;status:no;menu:no;help:0;history:noresizable:no;';
    var obj = window.showModalDialog(url,obj,strDlgFeather);
}

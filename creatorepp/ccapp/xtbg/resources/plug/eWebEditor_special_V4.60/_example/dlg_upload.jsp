<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<title>eWebEditor �� ���������ϴ��ļ��Ի���ʾ��</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link rel='stylesheet' type='text/css' href='example.css'>
</head>
<body>

<p><b>���� �� <a href="default.jsp">ʾ����ҳ</a> &gt; ���������ϴ��ļ��Ի���ʾ��</b></p>
<p>ͨ��ʹ��������ܣ��������������������е��ñ༭���Դ����ϴ��ļ����ܣ��ϴ��ļ��������������ԭ���ϴ����ļ���������������ϴ��ļ���·���ļ�������������һ����ҳ���������ط����ã�֧�ַ������ϴ�������ͼ���ã������ڱ༭����̨���á�һ�е��ô��룬����Ϊ������վ�����ϴ��ļ����ܡ�</p>
<p>�������ġ��ϴ�����ť����һ��Ч������ͬ�İ�ť�����ϴ����ļ����ͼ��ļ���С��ͬ��</p>




<script language="javascript">

//����һ���༭��ʵ����ֻ�����ϴ��ӿڣ����Դ˴������ص�
function EWEBeditor_Create(s_ID, s_Style){
	document.write('<input type="hidden" name="'+s_ID+'" value="">'
		+'<iframe id="'+s_ID+'__Iframe" src="../ewebeditor.htm?id='+s_ID+'&style='+s_Style+'" width=0 height=0 style="display:none" frameborder="0" scrolling="no"></iframe>');
}

/*
����˵���� 
s_Type: �ϴ��ļ����ͣ�����ֵΪ"image","flash","media","file"
	image: ͼƬ
	media: ý��
	flash: Flash
	file: ����

s_Mode: �ϴ��ӿڶԻ���ģʽ
	0:����ģʽ
	1:��������+���ļ��ϴ�
	2:��������+���ļ��ϴ�(Ĭ��)

s_LinkID_SavePathFileName : �ļ��ϴ������ڽ����ϴ��ļ�·���ļ����ı��������ذ���·�����ļ���
s_LinkID_SaveFileName : �����ϴ��ļ����ļ���
s_LinkID_OriginalFileName : ����ԭ�ļ���

s_ReturnFlag : ����ֵ��ʽ��־
	1: �����ʼ��ֻ�����һ���ϴ����ļ���
	2: (Ĭ��)֧�ֶ���ļ�������ϴ����β�����������б�������ļ�������ļ��硰|���ָ���
*/

function EWEBeditor_ShowDialog(s_ID, s_Type, s_Mode, s_LinkID_SavePathFileName, s_LinkID_SaveFileName, s_LinkID_OriginalFileName, s_ReturnFlag){
	var editor = document.getElementById(s_ID+'__Iframe').contentWindow;
	editor.openUploadDialog(s_Type, s_Mode, s_LinkID_SavePathFileName, s_LinkID_SaveFileName, s_LinkID_OriginalFileName, s_ReturnFlag)
}

//����"coolblue",ֵ��������ʵ����Ҫ�޸�Ϊ������ʽ��,ͨ������ʽ�ĺ�̨�������ﵽ���������ϴ��ļ����ͼ��ļ���С
EWEBeditor_Create("eWebEditor1", "coolblue");


</script>


<form method="post" name="myform" action="">

1. ��ʾ�������ϴ�ͼƬ�����ļ���<br>
�ϴ��ļ���<input type="text" id="d_image_savepath" size="50"> 
�����ļ�����<input type="text" id="d_image_savefile" size="20"> 
Դ�ļ�����<input type="text" id="d_image_original" size="20"> 
<input type="button" value="�ϴ�ͼƬ..." onclick="EWEBeditor_ShowDialog('eWebEditor1', 'image', '2', 'd_image_savepath', 'd_image_savefile', 'd_image_original', '2')">
<br><br>

2. ��ʾ�������ϴ�Flash�����ļ���<br>
�ϴ��ļ���<input type="text" id="d_flash_savepath" size="50"> 
�����ļ�����<input type="text" id="d_flash_savefile" size="20"> 
Դ�ļ�����<input type="text" id="d_flash_original" size="20"> 
<input type="button" value="�ϴ�Flash..." onclick="EWEBeditor_ShowDialog('eWebEditor1', 'flash', '2', 'd_flash_savepath', 'd_flash_savefile', 'd_flash_original', '2')">
<br><br>

3. ��ʾ�������ϴ�ý�������ļ���<br>
�ϴ��ļ���<input type="text" id="d_media_savepath" size="50"> 
�����ļ�����<input type="text" id="d_media_savefile" size="20"> 
Դ�ļ�����<input type="text" id="d_media_original" size="20"> 
<input type="button" value="�ϴ�ý��..." onclick="EWEBeditor_ShowDialog('eWebEditor1', 'media', '2', 'd_media_savepath', 'd_media_savefile', 'd_media_original', '2')">
<br><br>

4. ��ʾ�������ϴ����������ļ���<br>
�ϴ��ļ���<input type="text" id="d_file_savepath" size="50"> 
�����ļ�����<input type="text" id="d_file_savefile" size="20"> 
Դ�ļ�����<input type="text" id="d_file_original" size="20"> 
<input type="button" value="�ϴ��ļ�..." onclick="EWEBeditor_ShowDialog('eWebEditor1', 'file', '2', 'd_file_savepath', 'd_file_savefile', 'd_file_original', '2')">
<br><br>

<input type=button value="�鿴Դ�ļ�" onclick="location.replace('view-source:'+location)"> 

</form>

</body>
</html>

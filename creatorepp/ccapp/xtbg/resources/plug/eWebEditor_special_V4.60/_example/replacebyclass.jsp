<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>
<html>
<head>
<title>eWebEditor �� ����ʽ�������ı����Զ��滻Ϊ�༭��</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script type="text/javascript" src="../ewebeditor.js"></script>
<link rel='stylesheet' type='text/css' href='example.css'>

<script type="text/javascript">
//������ʹ����������������ô�����ʽ
//EWEBEDITOR.ReplaceByClassName = "ewebeditor";		//ָ��ʹ�õ����ͣ�Ĭ����"ewebeditor"
//EWEBEDITOR.ReplaceByClassEnabled = false;			//ָ���Ƿ����ô˹��ܣ�Ĭ��������
</script>

</head>
<body>

<p><b>���� �� <a href="default.jsp">ʾ����ҳ</a> &gt; ����ʽ�������ı����Զ��滻Ϊ�༭��</b></p>
<p>������ʾ��������ͨ����ʽ�����ܼ򵥵İ�&lt;textarea&gt;�滻ΪeWebEditor�༭��ʵ�������´�����ʾ����ֻ��Ҫ��&lt;textarea&gt;�Ӹ�ָ����class���ɡ�������ָ���Լ����õ���ʽ��������ϸʹ�÷�������ο���ҳԴ�ļ�������˵�����û��ֲᡣ</p>
<div class=code>&lt;textarea class=&quot;ewebeditor&quot; name=&quot;content1&quot;&gt;&lt;/textarea&gt;</div>


<form action="retrieve.asp" method="post">
<p><b>ʾ��1��</b></p>
<textarea class="ewebeditor" name="content1" rows="10" cols="80">&lt;p&gt;����&lt;strong&gt;ʾ��1&lt;/strong&gt;�� ������ʹ�� &lt;a href=&quot;http://www.ewebeditor.net/&quot;&gt;eWebEditor&lt;/a&gt;.&lt;/p&gt;</textarea>

<p><b>ʾ��2��</b></p>
<textarea class="ewebeditor" name="content2" rows="10" cols="80">&lt;p&gt;����&lt;strong&gt;ʾ��2&lt;/strong&gt;�� ������ʹ�� &lt;a href=&quot;http://www.ewebeditor.net/&quot;&gt;eWebEditor&lt;/a&gt;.&lt;/p&gt;</textarea>


<p>
	<input type="submit" value="�ύ" />
</p>
</form>

</body>
</html>
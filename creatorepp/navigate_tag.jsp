<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/navigator.tld" prefix="navigator"%>
<!--
     ����˵����������ǩ
     @param String level:������εĸ� �ڼ��㿪ʼ ȱʡ��һ�� �������ò���
     @param String css_path:�ⲿ����CSS��ʽ·�� ȱʡ����Layout�Զ�������Ӧ��ʽ
     @param String levelDegree:������� ȱʡ����
     @param String column_num:��ͨ�������ֵ�һ����ʾ���� ȱʡʮ��
     @param String style:��������ʽ(text/image) ȱʡtext����
     @param String layout:��������(normal/left/top-down/top-left) ȱʡ��ͨ��������
 --> 

<html>
    <%@ include file="/epp/css/cssControl.jsp"%><body >
        <navigator:navigator   style="text"  layout="top-left"  level="1" levelDegree="2" />
    
</html>

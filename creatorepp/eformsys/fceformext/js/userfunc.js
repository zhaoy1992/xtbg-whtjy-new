
//2004-03-03 �û��Զ����ȫ�ֺ���,���ڷ�һЩ��ĳ��ģ����(����CRM JXC)���õ�ȫ�ֺ���.
function getuser() {
	return "fc";
}
function getusername() {
	return "fc";
}

/**
* ���ƴ�eform��Ƶı���Ȩ��
* �ڴ˺�������parent.Request.QueryString("djsn").toString() ��ʽ����?��Ĳ���.
*@return �� ��ʾ��Ȩ��.
*@date 2006-02-11
**/
function EformEnterStatus() {
/*
	var djtype = parent.Request.QueryString("djtype").toString();  //�������
	var djsn = parent.Request.QueryString("djsn").toString();	//��djsn

	if(djsn == "application_sub"){
		var name = GetSession('username=')['username'];
		if(name == "liuxm"){
			return "";
		}
	
	}
*/
	return "OK";
}
/**
* �ӱ����һ�ֱ���ģʽʱ�ĴӼ��ֶε����ɺ���
*@param iRowNo �кţ���0��ʼ��,����
*@param sSubKeyFieldName �Ӽ����ֶ���
**/
function IGetSubTableKeyValue(iRowNo,sSubKeyFieldName) {
	return iRowNo + 1 ;
}
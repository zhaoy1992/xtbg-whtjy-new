<%
/**
 * 
 * <p>Title: 关键字设置保存页面</p>
 *
 * <p>Description: 关键字保存处理页面</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
 <%@ page language="java" contentType="text/html; charset=GBK"%>
 <%@ page import="com.chinacreator.security.AccessControl,
 				com.chinacreator.dictionary.KeyWord,
 				com.chinacreator.dictionary.DictKeyWordManager,
 				com.chinacreator.dictionary.DictKeyWordManagerImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
 
 <%
 	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String dicttypeId = request.getParameter("dictTypeId");
	//String[] checkBoxOne = request.getParameterValues("checkBoxOne");
	//columnName#javaProperty*columnName[i...]#javaProperty[i...]
	String checkValues = request.getParameter("checkValues");
	//System.out.println(checkValues);
	String[] checkValue = null;
	if(!"".equals(checkValues)){
		checkValue = checkValues.split("-#-");
	}
	KeyWord keyWord = null;
	List list = new ArrayList();
	for(int i = 0; checkValue != null && i < checkValue.length; i++){
		//System.out.println(checkValue[i]);
		String[] arr = checkValue[i].split("#-#");
		//System.out.println(arr.length);
		keyWord = new KeyWord();
		keyWord.setDictypeId(dicttypeId);
		keyWord.setFieldName(arr[0]);
		keyWord.setJavaProperty(arr[1]);
		list.add(keyWord);
	}
	DictKeyWordManager dictKeyWordManager = new DictKeyWordManagerImpl();
	boolean state = dictKeyWordManager.defineKeyFields(list,dicttypeId);
	
 %>
 <%
 	if(state){
 %>
 <script language="Javascript">
 	alert("操作成功！");
 	parent.winClose();
 </script>
 <%
 	}else{
 %>
 <script language="Javascript">
 	alert("操作失败！");
 </script>
 <%
 	}
 %>
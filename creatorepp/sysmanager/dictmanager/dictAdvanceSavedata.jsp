<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.dictionary.DictManager"%>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl"%>
<%@ page import="com.frameworkset.dictionary.Data"%>
<%@ page import="com.frameworkset.dictionary.Item"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%  
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String did = (String)request.getParameter("dicttypeId");	
	String parentValue = (String)request.getParameter("parentValue");
	String dictDataName = (String)request.getParameter("dictDataName");
	String dictDataValue = (String)request.getParameter("dictDataValue");
	DictManager dictManager = new DictManagerImpl();
	Data dicttype = dictManager.getDicttypeById(did);
	if("�������ڱ���ʱ�Զ�����".equals(dictDataValue)){
	    dictDataValue = dicttype.getNextKeyValueStr();
	}
	String dictDataValueOrg = (String)request.getParameter("dictDataValueOrg");
	String dictDataValidate_ = request.getParameter("dictDataValidate")==null?"1":request.getParameter("dictDataValidate");	
	did = did==null?"":did;
	dictDataName = dictDataName==null?"":dictDataName;
	dictDataValue = dictDataValue==null?"":dictDataValue;
	parentValue = parentValue==null?"":parentValue;
	dictDataValueOrg = dictDataValueOrg==null?"":dictDataValueOrg;
	DictManagerImpl dicManager = new DictManagerImpl();
	dicManager.init(request,response);
	Item dictdata = new Item();
	dictdata.setDataId(did);
	dictdata.setName(dictDataName);
	dictdata.setValue(dictDataValue);
	dictdata.setParentId(parentValue);
	dictdata.setDataOrg(dictDataValueOrg);
	dictdata.setDataValidate(Integer.parseInt(dictDataValidate_));	 
	//����
	boolean saveResult = false;
	try{
		saveResult = dicManager.addAdvanceDictdata(dictdata,request);
	}catch(Exception e){
		e.printStackTrace();
		String message = e.getMessage();
		if(message != null){
			message.replaceAll("\\n","\\\\n");
			message.replaceAll("\\t","\\\\t");
		}
		%>
		<script type="text/javascript">
		<!--
			if(parent.win){			    	
	 	       parent.win.alert("����ʧ�ܣ�ԭ�����£�\n" + "<%=message%>");
	 	       parent.win.close();
 	        }
 	        parent.afterSave();	
		//-->
		</script>
		<%
	}
	
%>
	<script language="javascript">		
	    <%
	        if(saveResult){
	    %>
				if(parent.win){
					parent.win.alert("�����ɹ�!");
					parent.win.close();
				}
				parent.afterSave();					
		<%
		    }else{
		%>	
		    	//parent.win.alert("����ʾ���ݡ����ߡ���ʵֵ���Ѿ����� \n ");
		    	if(parent.win){
		    	    parent.win.alert("�ֶλ����ֶ������Ѿ���ʹ�� \n ���Ǹñ����������! \n  ���ݱ���ʧ��!");
			    	parent.win.close();	 	            
	 	        }
		    	parent.saveFaild();
		<%
		    }
		%>
		
	</script>


 


 


 


 


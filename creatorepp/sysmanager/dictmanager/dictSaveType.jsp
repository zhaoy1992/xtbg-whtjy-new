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

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();	
	String opt = (String)request.getParameter("opt");
	String did = (String)request.getParameter("did");
	String type_name = (String)request.getParameter("type_name");
	String type_dsc = (String)request.getParameter("type_dsc");	
	String db_name = (String)request.getParameter("db_name");
	String table_name = (String)request.getParameter("table_name");
	String field_name = (String)request.getParameter("field_name");
	String field_value = (String)request.getParameter("field_value");
	//add by ge.tao
	//date 2008-01-25
	String field_name_cn = (String)request.getParameter("field_name_cn");
	String field_value_cn = (String)request.getParameter("field_value_cn");
	
	String field_order = (String)request.getParameter("field_order");
	String field_typeid = (String)request.getParameter("field_typeid");
	String field_parentid = (String)request.getParameter("field_parentid");
	String is_tree_str = (String)request.getParameter("is_tree");
	String dicttype_type_ = (String)request.getParameter("dicttype_type");
	//�Ƿ����ԭ�����ݵ�����ID,ȱʡ�ǲ�����:0 ����:1
	String update_typeId_ = (String)request.getParameter("update_typeId");
	//ɾ���ֵ����͵�ʱ��,�Ƿ�ɾ���ֵ��Ӧ���ֵ�������
	String delete_dictdata_ = (String)request.getParameter("delete_dictdata");
	//�������Ƿ���Ч�ֶ�
	String data_validate_field = (String)request.getParameter("field_data_validate");
	//������Ĵ�������
	String data_create_orgid_field = (String)request.getParameter("field_create_orgId");
	//ֵ�ֶε����ɹ���
	String key_general_type_ = request.getParameter("key_general_type")==null?"":request.getParameter("key_general_type");
	
	//�����ֶ�
	String [] att_name = (String [])request.getParameterValues("attachfieldname");
	String [] att_label = (String [])request.getParameterValues("attachlabel");
	String [] att_type = (String [])request.getParameterValues("attachinputtype");
	
	int is_tree = 0;
	int update_typeId = 0;
	int delete_dictdata = 0;
	int dicttype_type = 0;
	int key_general_type = 0;
	int user_id = 1;
	try{
	    is_tree = Integer.parseInt(is_tree_str);	   
	}catch(Exception e1){
	    is_tree = 0;
	}
	try{	    
	    update_typeId = Integer.parseInt(update_typeId_);
	}catch(Exception e2){
	    update_typeId = 0;
	}
	try{
	    delete_dictdata = Integer.parseInt(delete_dictdata_);
	}catch(Exception e3){
	    delete_dictdata = 0;
	}
	try{
	    dicttype_type = Integer.parseInt(dicttype_type_);
	}catch(Exception e4){
	    dicttype_type = 0;
	}
	try{
	    key_general_type = Integer.parseInt(key_general_type_);
	}catch(Exception e5){
	    key_general_type = 0;
	}
	try{
	    user_id = Integer.parseInt(userId);
	}catch(Exception e6){
	    user_id = 1;
	    e6.printStackTrace();
	}
	
	//�������ݱ�ʶ
	String needcacheStr = request.getParameter("needcache");
	int needcache = 0;
	try{
		needcache = Integer.parseInt(needcacheStr);
	}catch(Exception e7){
		needcache = 0;
	}
	
	//ֵ�ֶε�ֵ�ɸı��ʶ
	String enable_value_modifyStr = request.getParameter("enable_value_modify");
	int enable_value_modify = 1;
	try{
		enable_value_modify = Integer.parseInt(enable_value_modifyStr);
	}catch(Exception e8){
		enable_value_modify = 0;
	}

	opt = opt==null?"":opt;
	did = did==null?"":did;
	type_name = type_name==null?"":type_name;
	type_dsc = type_dsc==null?"":type_dsc;
	db_name = db_name==null?"":db_name;
	table_name = table_name==null?"":table_name;
	field_name = field_name==null?"":field_name;
	field_value = field_value==null?"":field_value;
	field_order = field_order==null?"":field_order;
	field_typeid = field_typeid==null?"":field_typeid;
	field_parentid = field_parentid==null?"":field_parentid;
	
	DictManager dicManager = new DictManagerImpl();
	Data dicttype = new Data();
	//������ID, update��ʱ�򲻸���.

	dicttype.setUser_id(user_id);
	dicttype.setDescription(type_dsc);
	dicttype.setName(type_name);	
	//dicttype.setParent(dict_parent);
	dicttype.setDataDBName(db_name);
	dicttype.setDataTableName(table_name);
	dicttype.setDataNameField(field_name);
	dicttype.setDataValueField(field_value);
	dicttype.setDataOrderField(field_order);
	dicttype.setDataTypeIdField(field_typeid);
	dicttype.setUpdate_dcitData_typeId(update_typeId);
	dicttype.setDelete_DictData(delete_dictdata);
	dicttype.setDicttype_type(dicttype_type);
	//ֵ���ɹ���
	dicttype.setKey_general_type(key_general_type);
	//�Ƿ���Ч�ֶ�
	dicttype.setData_validate_field(data_validate_field);
	//�ֶ����������������ֶ�
	dicttype.setData_create_orgid_field(data_create_orgid_field);
	//�����ֵ����ͳɹ���־ true:�ɹ�; false:ʧ��	
	String addFlag = "";
	boolean deleteFlag = true;
	//��ά�������ֶ�
	//add by ge.tao
	//date 2008-01-24
	dicttype.setField_name_cn(field_name_cn);
	dicttype.setField_value_cn(field_value_cn);
	
	//��ά���ֶΣ�ֵ�ֶε�ֵ�ɸı��ʶ���������ݱ�ʶ
	//peng.yang 2008-04-08
	dicttype.setEnable_value_modify(enable_value_modify);
	dicttype.setNeedcache(needcache);
	
	if(is_tree==1){
	    dicttype.setDataParentIdFild(field_parentid);
	    dicttype.setIsTree(is_tree);
	}else{
	    dicttype.setDataParentIdFild("");
	    dicttype.setIsTree(is_tree);
	}	  
	if("".equals(did)){//������ID,insert,parentΪ0   	    
	    dicttype.setParent("0");
		addFlag = dicManager.addDicttype(dicttype);  
	}else{//������ID,update/delete/insert insertʱ,parentΪdid
	    if("update".equals(opt)){	    
	        dicttype.setDataId(did);
	    	addFlag = dicManager.updateDicttype(dicttype); 
	    }else if("delete".equals(opt)){
	    	dicttype.setDataId(did);
	        deleteFlag = dicManager.deletedicttype(dicttype); 
	    }else{
	        dicttype.setParent(did);
	        addFlag = dicManager.addDicttype(dicttype); 
	    }
	}
	
%>
	<script language="javascript">	
	var msgs = "�����ɹ�!";
<%
		
		if("".equals(addFlag) && deleteFlag){
%>	
		msgs = "�����ɹ�!";
		//if(parent.win) parent.win.alert("�����ɹ�!");
<%
		}else{
		    if("-1".equals(addFlag)){//���ظ���¼
%>		
				//if(parent.win) parent.win.alert("����ʧ��\n�ֵ������Ѿ����ڡ�<%=type_name%>��!");
				msgs = "����ʧ��\n�ֵ������Ѿ����ڡ�<%=type_name%>��!";
<%
		    }else if("-2".equals(addFlag)){//�����������, ����û��ָ���ֵ������ֶ�
%>		    
		        //if(parent.win) parent.win.alert("����ʧ��\n�ֵ�ָ�������ݿ��������ֵ乲��, \n����ָ�����ֵ������ֶΡ�!");
		        msgs = "����ʧ��\n�ֵ�ָ�������ݿ��������ֵ乲��, \n����ָ�����ֵ������ֶΡ�!";
<%		        
		    }else if(addFlag.startsWith("-4")){//�ñ������ֵ����Ͷ�ռ, ����������
		        String sigleTableName = "";
		        String[] temps = addFlag.split(":");
		        if(temps.length>1){
		            sigleTableName = temps[1];
		        }		        
%>		    
		        var sigleTableName = "<%=sigleTableName%>"
		        //if(parent.win) 
		        //parent.win.alert("����ʧ��\n���ݿ��"+sigleTableName+"������ռ, \n����������!");
		        msgs = "����ʧ��\n���ݿ��"+sigleTableName+"������ռ, \n����������!";
<%		        
		    }else if(addFlag.startsWith("-3")){//�����������, ����û��ָ������������ͬ���ֶ������ֶ�
		        String sameColumnName = "";
		        String[] temps = addFlag.split(":");
		        if(temps.length>1){
		            sameColumnName = temps[1];
		        }		        
%>		    
		        var sameColumnName = "<%=sameColumnName%>"
		        //if(parent.win) 
		        //parent.win.alert("����ʧ��\n�ֵ�ָ�������ݿ��������ֵ乲��, \n�����"+sameColumnName+"ָ�����ֵ������ֶΡ�!");
		        msgs = "����ʧ��\n�ֵ�ָ�������ݿ��������ֵ乲��, \n�����"+sameColumnName+"ָ�����ֵ������ֶΡ�!";
<%		        
		    }else if(addFlag.length()>0 && !"-1".equals(addFlag)&& !"-2".equals(addFlag) && 
		             !addFlag.startsWith("-3") && !addFlag.startsWith("-4")){//ָ���ı��в���Ϊ�յ��ֶ�,������Щ�ֶ�û�����õ��ֵ����͵�������
%>
				//var msg = "�����ɹ�! \n";
				//msg = msg + "����<%=addFlag%>�ֶ��ǲ���Ϊ�յ��ֶ�,\n ";
				//msg = msg + "�����ڡ��ֵ�߼��ֶ����á�ģ��������Ϊ�����ֶ�!"
		        //if(parent.win) parent.win.alert(msg);
		        
		        msgs = "�����ɹ�! \n";
		        msgs = msgs + "����<%=addFlag%>�ֶ��ǲ���Ϊ�յ��ֶ�,\n ";
				msgs = msgs + "�����ڡ��ֵ�߼��ֶ����á�ģ��������Ϊ�����ֶ�!"
<%		        
		    }
		    if(!deleteFlag){
%>		
				//parent.win.alert("�ֵ������Ѿ������������ϵ����,\n���ܱ�ɾ��!");
				msgs = "�ֵ������Ѿ������������ϵ����,\n���ܱ�ɾ��!";
<%		    
		    }
		}
%>
		if(parent.win)
		{
			parent.win.alert(msgs);
			parent.enable();
			parent.win.close();
		}
		else
		{
			alert(msgs);
		}
<%
        if("insert".equals(opt)){
            if("".equals(did)) did = "0";
            if("-1".equals(addFlag) || "-2".equals(addFlag)){
                //no fresh
            }else{
            	out.print("parent.afterAddRefresh()");
            }
        }else if("update".equals(opt)) {
            out.print("parent.afterUpdateRefresh('"+did+"')");
        }else if("delete".equals(opt)){
            out.print("parent.afterDeleteRefresh()");
        }
%>
		
	</script>

 


 


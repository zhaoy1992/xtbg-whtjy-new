package com.chinacreator.xtbg.core.codegenerator.util;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;



public class CodeConstant {
	//生成的文件名后缀
	public final static String CLASS_SUFFIX_ENTITY = "Bean";
	public final static String CLASS_SUFFIX_LIST = "List";
	public final static String CLASS_SUFFIX_DAO = "Dao";
	public final static String CLASS_SUFFIX_DAOIMPL = "DaoImpl";
	public final static String CLASS_SUFFIX_SERVICE = "Service";
	public final static String CLASS_SUFFIX_SERVICEIMPL = "ServiceImpl";
	public final static String CLASS_SUFFIX_JSP_LIST = "list";
	public final static String CLASS_SUFFIX_JSP_INFO = "info";
	public final static String CLASS_SUFFIX_JSP_DO = "do";
	
	//方法名
	public final static String METHOD_INSERT = "insert";
	public final static String METHOD_UPDATE = "update";
	public final static String METHOD_DELETE = "delete";
	public final static String METHOD_GETBYID = "getById";
	public final static String METHOD_LISTWITHPAGE = "list";
	public final static String METHOD_LISTWITHOUTPAGE = "list";
	
	//包名
	public final static String PACKAGE_ENTITY = "entity";
	public final static String PACKAGE_DAO = "dao";
	public final static String PACKAGE_DAO_IMPL = "impl";
	public final static String PACKAGE_LIST = "list";
	public final static String PACKAGE_SERVICE = "service";
	public final static String PACKAGE_SERVICE_IMPL = "impl";
	public final static String PACKAGE_JSP = "jsp";
	
	//dao 方法名称
	public static String dao_method_insert(String beanName){
		return "public void "+METHOD_INSERT+"("+beanName+" bean,Connection con) throws Exception";
	}
	public static String dao_method_getById(String beanName){
		return "public "+beanName+" "+METHOD_GETBYID+"("+beanName+" bean,Connection con) throws Exception";
	}
	public static String dao_method_delete(){
		return "public void "+METHOD_DELETE+"(String ids,Connection con) throws Exception";
	}
	public static String dao_method_listWithOutPage(String beanName){
		return "public List<"+beanName+"> " +METHOD_LISTWITHOUTPAGE+" ("+beanName+" bean,Connection con) throws Exception";
	}
	public static String dao_method_listWithPage(String beanName){
		return "public PagingBean "+METHOD_LISTWITHPAGE+"("+beanName+" bean, String sortname, String sortOrder, long offset, int maxPagesize,Connection con)throws Exception";
	}
	public static String dao_method_update(String beanName){
		return "public void "+METHOD_UPDATE+"("+beanName+" bean,Connection con) throws Exception";
	}
	
	//service 方法名称
	public static String service_method_insert(String beanName){
		return "public ResultMap<ResultCode, "+beanName+"> "+METHOD_INSERT+"("+beanName+" bean)";
	}
	public static String service_method_getById(String beanName){
		return "public ResultMap<ResultCode, "+beanName+"> "+METHOD_GETBYID+"("+beanName+" bean)";
	}
	public static String service_method_delete(String beanName){
		return "public ResultMap<ResultCode, "+beanName+"> "+METHOD_DELETE+"(String ids)";
	}
	public static String service_method_listWithOutPage(String beanName){
		return "public ResultMap<ResultCode, List<"+beanName+">> " +METHOD_LISTWITHOUTPAGE+" ("+beanName+" bean)";
	}
	public static String service_method_update(String beanName){
		return "public ResultMap<ResultCode, "+beanName+"> "+METHOD_UPDATE+"("+beanName+" bean)";
	}
	//根据录入的jsp path 得到jsp在项目中的路径
	public static String getJspUrl(String jspPath){
		if(jspPath.contains("ccapp")){
			return jspPath.substring(jspPath.indexOf("/ccapp"));
		} else {
			return "";
		}
	}
	//得到类 jsp名称
	public static String getClassNameForDao(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_DAO;
	}
	public static String getClassNameForDaoImpl(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_DAOIMPL;
	}
	public static String getClassNameForEntity(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_ENTITY;
	}
	public static String getClassNameForList(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_LIST;
	}
	public static String getClassNameForService(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_SERVICE;
	}
	public static String getClassNameForServiceImpl(ClassProperty c){
		return c.getClassName()+CLASS_SUFFIX_SERVICEIMPL;
	}
	public static String getClassNameForJspList(ClassProperty c){
		return c.getClassNameByLower()+CLASS_SUFFIX_JSP_LIST;
	}
	public static String getClassNameForJspInfo(ClassProperty c){
		return c.getClassNameByLower()+CLASS_SUFFIX_JSP_INFO;
	}
	public static String getClassNameForJspDo(ClassProperty c){
		return c.getClassNameByLower()+CLASS_SUFFIX_JSP_DO;
	}
	
}

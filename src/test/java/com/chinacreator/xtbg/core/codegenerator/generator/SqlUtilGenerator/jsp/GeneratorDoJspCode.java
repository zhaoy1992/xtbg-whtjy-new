package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.JspPageGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;


public class GeneratorDoJspCode implements JspPageGenerator {
	@Override
	public String generateJava(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\r\n");
		code.append("<%@page import=\"com.alibaba.fastjson.JSON\"%>\r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.util.ResultCode\"%>\r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.util.ResultMap\"%>\r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.util.BeanUtil\"%>\r\n");
		code.append("<%@ page import=\"com.chinacreator.security.AccessControl\"%>\r\n");
		code.append("<%@page import=\""+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+CodeConstant.getClassNameForEntity(classProperty)+"\"%>\r\n");
		code.append("<%@page import=\""+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_SERVICE+"."+CodeConstant.getClassNameForService(classProperty)+"\"%>\r\n");
		code.append("<%@page import=\""+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_SERVICE+"."+CodeConstant.PACKAGE_SERVICE_IMPL+"."+CodeConstant.getClassNameForServiceImpl(classProperty)+"\"%>\r\n");
		return code.toString();
	}
	@Override
	public String generateHeader(ClassProperty classProperty) {
		return "";
	}
	@Override
	public String generateScript(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<%\r\n");
		code.append("AccessControl accesscontroler = AccessControl.getAccessControl();\r\n");
		code.append("accesscontroler.checkAccess(request, response);\r\n");
		code.append("//对服务器的所有操作，具体调用后台的哪个方法操作用method来判断执行\r\n");
		code.append("String method = request.getParameter(\"method\");\r\n");
		code.append("BeanUtil<"+CodeConstant.getClassNameForEntity(classProperty)+"> beanUtil = new BeanUtil<"+CodeConstant.getClassNameForEntity(classProperty)+">();\r\n");
		code.append(""+CodeConstant.getClassNameForEntity(classProperty)+" bean = beanUtil.requestToBean(request,"+CodeConstant.getClassNameForEntity(classProperty)+".class);\r\n");
		code.append("\r\n");
		code.append(""+CodeConstant.getClassNameForService(classProperty)+" service = new "+CodeConstant.getClassNameForServiceImpl(classProperty)+"();\r\n");
		code.append("if(method != null || \"\".equals(method)){\r\n");
		code.append("	if(method.equals(\""+CodeConstant.METHOD_INSERT+"\")){\r\n");
		code.append("		response.setContentType(\"application/x-json\");\r\n");
		code.append("		ResultMap<ResultCode,"+CodeConstant.getClassNameForEntity(classProperty)+"> result = service."+CodeConstant.METHOD_INSERT+"(bean);\r\n");
		code.append("		out.write(JSON.toJSONString(result,true));\r\n");
		code.append("	} else if(method.equals(\""+CodeConstant.METHOD_UPDATE+"\")){\r\n");
		code.append("		response.setContentType(\"application/x-json\");\r\n");
		code.append("		ResultMap<ResultCode,"+CodeConstant.getClassNameForEntity(classProperty)+"> result = service."+CodeConstant.METHOD_UPDATE+"(bean);\r\n");
		code.append("		out.write(JSON.toJSONString(result,true));\r\n");
		code.append("	} else if(method.equals(\""+CodeConstant.METHOD_GETBYID+"\")){\r\n");
		code.append("		response.setContentType(\"application/x-json\");\r\n");
		code.append("		ResultMap<ResultCode,"+CodeConstant.getClassNameForEntity(classProperty)+"> result = service."+CodeConstant.METHOD_GETBYID+"(bean);\r\n");
		code.append("		out.write(JSON.toJSONString(result,true));\r\n");
		code.append("	} else if(method.equals(\""+CodeConstant.METHOD_LISTWITHOUTPAGE+"\")){\r\n");
		code.append("		response.setContentType(\"application/x-json\");\r\n");
		code.append("		ResultMap<ResultCode,List<"+CodeConstant.getClassNameForEntity(classProperty)+">> result = service."+CodeConstant.METHOD_LISTWITHOUTPAGE+"(bean);\r\n");
		code.append("		out.write(JSON.toJSONString(result,true));\r\n");
		code.append("	} else if(method.equals(\""+CodeConstant.METHOD_DELETE+"\")){\r\n");
		code.append("		response.setContentType(\"application/x-json\");\r\n");
		code.append("		ResultMap<ResultCode,"+CodeConstant.getClassNameForEntity(classProperty)+"> result = service."+CodeConstant.METHOD_DELETE+"(bean.get"+CodeUtil.upperCaseFirst(classProperty.getPrimaryKey())+"());\r\n");
		code.append("		out.write(JSON.toJSONString(result,true));\r\n");
		code.append("	}\r\n");
		code.append("}\r\n");
		code.append("%>\r\n");
		return code.toString();
	}
	@Override
	public String generateBody(ClassProperty classProperty) {
		return "";
	}
}

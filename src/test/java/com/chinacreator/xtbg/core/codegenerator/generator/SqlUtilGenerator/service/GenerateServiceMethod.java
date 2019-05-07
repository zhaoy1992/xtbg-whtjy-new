package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.service;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ServiceMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;


public class GenerateServiceMethod implements ServiceMethodGenerator {
	@Override
	public String delete(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>根据id删除数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.service_method_delete(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String insert(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>保存数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.service_method_insert(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String listWithOutPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>查询列表数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.service_method_listWithOutPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String update(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>更新数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.service_method_update(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String getById(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("    * <p>根据id获取数据</p>\r\n");
		code.append("    */\r\n");
		code.append("    "+CodeConstant.service_method_getById(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}
}

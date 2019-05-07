package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.dao;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.DAOMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
/**
 *<p>Title:GenerateDaoMethod.java</p>
 *<p>Description:生成dao方法的类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class GenerateDaoMethod implements DAOMethodGenerator {
	@Override
	public String delete(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>根据id删除数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.dao_method_delete()+";\r\n");
		return code.toString();
	}

	@Override
	public String insert(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>保存数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.dao_method_insert(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String listWithOutPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>查询列表数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.dao_method_listWithOutPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String listWithPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>分页查询列表数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.dao_method_listWithPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String update(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("     * <p>更新数据</p>\r\n");
		code.append("     */\r\n");
		code.append("    "+CodeConstant.dao_method_update(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}

	@Override
	public String getById(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    /**\r\n");
		code.append("    * <p>根据id获取数据</p>\r\n");
		code.append("    */\r\n");
		code.append("    "+CodeConstant.dao_method_getById(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+";\r\n");
		return code.toString();
	}
}

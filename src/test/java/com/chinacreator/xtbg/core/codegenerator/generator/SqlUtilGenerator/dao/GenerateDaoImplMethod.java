package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.dao;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.entity.ColumnProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.DAOMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
/**
 *<p>Title:GenerateDaoImplMethod.java</p>
 *<p>Description:生成dao实现的方法的类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class GenerateDaoImplMethod implements DAOMethodGenerator {

	@Override
	public String delete(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_delete()+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"delete "+classProperty.getTableName()+" where "+classProperty.getPrimaryKey()+" in (\"+ ids +\")\");\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        sqlUtil.executeDelete(sql.toString(), new "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"(), con);\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String insert(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_insert(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"insert into "+classProperty.getTableName()+"(\");\r\n");
		String mark = "";
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(i != classProperty.getColumnProperty().size()-1){
				code.append("        sql.append(\" "+column.getCode()+",\");\r\n");
				if((i+1) % 4 == 0){
					mark += "  ?,";		//每四个？空两个字符	
				} else {
					mark += "?,";
				}
			} else {
				code.append("        sql.append(\" "+column.getCode()+"\");\r\n");
				mark += "?";
			}
		}
		code.append("        sql.append(\") values \");\r\n");
		code.append("        sql.append(\" ( "+mark+")\" );\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        sqlUtil.executeInsert(sql.toString(), bean, con);\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String listWithOutPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_listWithOutPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"select \");\r\n");
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(i != classProperty.getColumnProperty().size()-1){
				code.append("        sql.append(\" "+column.getCode()+",\");\r\n");
			} else {
				code.append("        sql.append(\" "+column.getCode()+"\");\r\n");
			}
		}
		code.append("        sql.append(\" from "+classProperty.getTableName()+"\");\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        List<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> list = sqlUtil.executeForList(sql.toString(), bean, con);\r\n");
		code.append("        return list;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String listWithPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_listWithPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"select \");\r\n");
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(i != classProperty.getColumnProperty().size()-1){
				code.append("        sql.append(\" "+column.getCode()+",\");\r\n");
			} else {
				code.append("        sql.append(\" "+column.getCode()+"\");\r\n");
			}
		}
		code.append("        sql.append(\" from "+classProperty.getTableName()+"\");\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortname, sortOrder, offset, maxPagesize, con);\r\n");
		code.append("        return pb;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String update(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_update(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"update "+classProperty.getTableName()+" set \");\r\n");
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(i != classProperty.getColumnProperty().size()-1){
				code.append("        sql.append(\" "+column.getCode()+" = ? ,\");\r\n");
			} else {
				code.append("        sql.append(\" "+column.getCode()+" = ?\");\r\n");
			}
		}
		code.append("        sql.append(\" where "+classProperty.getPrimaryKey()+" = ? \");\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        sqlUtil.executeUpdate(sql.toString(), bean, con);\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String getById(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.dao_method_getById(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        StringBuffer sql = new StringBuffer();\r\n");
		code.append("        sql.append(\"select \");\r\n");
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(i != classProperty.getColumnProperty().size()-1){
				code.append("        sql.append(\" "+column.getCode()+",\");\r\n");
			} else {
				code.append("        sql.append(\" "+column.getCode()+"\");\r\n");
			}
		}
		code.append("        sql.append(\" from "+classProperty.getTableName()+"\");\r\n");
		code.append("        sql.append(\" where "+classProperty.getPrimaryKey()+" = ? \");\r\n");
		code.append("        SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> sqlUtil = new SqlUtil<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+" b = sqlUtil.executeForObject(sql.toString(), bean , con);\r\n");
		code.append("        return b;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}
}

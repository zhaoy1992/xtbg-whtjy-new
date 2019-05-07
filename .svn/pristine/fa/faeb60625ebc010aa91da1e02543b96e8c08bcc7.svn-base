package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.dao;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.generator.DAOMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;

public class GenerateDao implements ClassGenerator {
	private ClassProperty classProperty;
	private DAOMethodGenerator generateDaoMethod;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
		generateDaoMethod = new GenerateDaoMethod(); 
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+";\r\n");
		code.append("\r\n");
		code.append("import java.sql.Connection;\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+";\r\n");
		code.append("import com.chinacreator.xtbg.core.common.commonlist.PagingBean;\r\n");
		code.append("import java.util.List;\r\n");
		code.append("\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"Dao</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author AutoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public interface "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+" { \r\n");
	}
	@Override
	public void generating() {
		code.append(generateDaoMethod.insert(classProperty));
		code.append(generateDaoMethod.getById(classProperty));
		code.append(generateDaoMethod.update(classProperty));
		code.append(generateDaoMethod.listWithPage(classProperty));
		code.append(generateDaoMethod.listWithOutPage(classProperty));
		code.append(generateDaoMethod.delete(classProperty));
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
									CodeConstant.PACKAGE_DAO+File.separator+
									CodeConstant.getClassNameForDao(classProperty)+".java");
			FileUtils.writeStringToFile(file,code.toString(),"UTF-8");
			System.out.println("    ##"+CodeUtil.getLogTime()+" AutoGenrator Log: "+file.getName()+" 生成完成...");
		} catch (IOException e) {
			e.printStackTrace();
		}
		code.setLength(0);
	}
	@Override
	public void run(ClassProperty classProperty) {
		if(classProperty.getColumnProperty().size() == 0 || null == classProperty.getJavaPath() || "".equals(classProperty.getJavaPath())){
			return;
		} else {
			this.init(classProperty);
			this.before();
			this.generating();
			this.after();
		}
	}
}

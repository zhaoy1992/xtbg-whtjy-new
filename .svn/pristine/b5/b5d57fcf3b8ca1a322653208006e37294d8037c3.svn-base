package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.generator.ServiceMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;


public class GenerateService implements ClassGenerator{
	private ClassProperty classProperty;
	private ServiceMethodGenerator generateServiceMethod;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
		generateServiceMethod = new GenerateServiceMethod();
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_SERVICE+";\r\n");
		code.append("\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+";\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.ResultCode;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.ResultMap;\r\n");
		code.append("import java.util.List;\r\n");
		code.append("\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICE+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"服务层</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author AutoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public interface "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICE+" { \r\n");
	}
	@Override
	public void generating() {
		code.append(generateServiceMethod.insert(classProperty));
		code.append(generateServiceMethod.delete(classProperty));
		code.append(generateServiceMethod.update(classProperty));
		code.append(generateServiceMethod.getById(classProperty));
		code.append(generateServiceMethod.listWithOutPage(classProperty));
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
							CodeConstant.PACKAGE_SERVICE+File.separator+
							classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICE+".java");
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

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


public class GenerateServiceImpl implements ClassGenerator {
	private ClassProperty classProperty;
	private ServiceMethodGenerator generateServiceImplMethod;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
		generateServiceImplMethod = new GenerateServiceImplMethod();
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_SERVICE+"."+CodeConstant.PACKAGE_SERVICE_IMPL+";\r\n");
		code.append("\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+";\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+CodeConstant.PACKAGE_DAO_IMPL+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+";");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+";\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_SERVICE+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICE+";\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.ResultCode;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.ResultMap;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.DaoUtil;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.DbManager;\r\n");
		code.append("import java.sql.Connection;\r\n");
		code.append("import org.apache.log4j.Logger;\r\n");
		code.append("import java.util.List;\r\n");
		code.append("\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICEIMPL+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"服务层实现</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author autoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public class "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICEIMPL+" implements "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICE+" { \r\n");
		code.append("    private static final Logger LOG = Logger.getLogger("+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICEIMPL+".class);\r\n");
		code.append("	"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+" dao = new "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+"();\r\n");
	}
	@Override
	public void generating() {
		code.append(generateServiceImplMethod.insert(classProperty));
		code.append(generateServiceImplMethod.delete(classProperty));
		code.append(generateServiceImplMethod.update(classProperty));
		code.append(generateServiceImplMethod.getById(classProperty));
		code.append(generateServiceImplMethod.listWithOutPage(classProperty));
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
								CodeConstant.PACKAGE_SERVICE+File.separator+
								CodeConstant.PACKAGE_SERVICE_IMPL+File.separator+
								classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_SERVICEIMPL+".java");
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

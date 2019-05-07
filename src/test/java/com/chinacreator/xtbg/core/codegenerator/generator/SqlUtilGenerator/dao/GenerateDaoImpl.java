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

public class GenerateDaoImpl implements ClassGenerator {
	private ClassProperty classProperty;
	private DAOMethodGenerator generateDaoImplMethod;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
		generateDaoImplMethod = new GenerateDaoImplMethod();
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+CodeConstant.PACKAGE_DAO_IMPL+";\r\n");
		code.append("\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+";\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+";\r\n");
		code.append("import com.chinacreator.xtbg.core.common.commonlist.PagingBean;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.SqlUtil;\r\n");
		code.append("import java.sql.Connection;\r\n");
		code.append("import java.util.List;\r\n");
		code.append("\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"DaoImpl</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author AutoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public class "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+" implements "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+" { \r\n");
	}
	@Override
	public void generating() {
		code.append(generateDaoImplMethod.insert(classProperty));
		code.append(generateDaoImplMethod.getById(classProperty));
		code.append(generateDaoImplMethod.update(classProperty));
		code.append(generateDaoImplMethod.listWithPage(classProperty));
		code.append(generateDaoImplMethod.listWithOutPage(classProperty));
		code.append(generateDaoImplMethod.delete(classProperty));
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
									CodeConstant.PACKAGE_DAO+File.separator+
									CodeConstant.PACKAGE_DAO_IMPL+File.separator+
									CodeConstant.getClassNameForDaoImpl(classProperty)+".java");
			FileUtils.writeStringToFile(file, code.toString(),"UTF-8");
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

package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.entity;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.entity.ColumnProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;

/**
 *<p>Title:GenerateEntity.java</p>
 *<p>Description:生成实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class GenerateEntity implements ClassGenerator {
	private ClassProperty classProperty;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+";\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"bean</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author AutoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public class "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+" { \r\n");
	}
	@Override
	public void generating() {
		List<ColumnProperty> list = classProperty.getColumnProperty();
		if(list != null && list.size() > 0){
			//生成私有成员变量
			for(ColumnProperty column : list){
				code.append("    private "+CodeUtil.columnTypeParse(column.getType())+" "+column.getCode()+";    //"+column.getComments()+"\r\n");
			}
			code.append("\r\n");
			//生成get set
			for(ColumnProperty column : list){
				code.append(CodeUtil.createGetAndSetMethod(column.getCode(), column.getComments(), CodeUtil.columnTypeParse(column.getType())));
			}
		}
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
								CodeConstant.PACKAGE_ENTITY+File.separator+
								CodeConstant.getClassNameForEntity(classProperty)+".java");
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
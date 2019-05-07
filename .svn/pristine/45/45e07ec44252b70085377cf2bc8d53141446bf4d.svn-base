package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.list;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;


public class GenerateList implements ClassGenerator {
	private ClassProperty classProperty;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
	}
	@Override
	public void before() {
		code.append("package "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_LIST+";\r\n");
		code.append("\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+";\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_DAO+"."+CodeConstant.PACKAGE_DAO_IMPL+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+";\r\n");
		code.append("import "+classProperty.getClassPackage()+"."+CodeConstant.PACKAGE_ENTITY+"."+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+";\r\n");
		code.append("import java.sql.Connection;\r\n");
		code.append("import org.apache.log4j.Logger;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.commonlist.PagingBean;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.DbManager;\r\n");
		code.append("import com.chinacreator.xtbg.core.common.util.StringUtil;\r\n");
		code.append("\r\n");
		code.append("/**\r\n");
		code.append(" *<p>Title:"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_LIST+".java</p>\r\n");
		code.append(" *<p>Description:"+classProperty.getTableChiName()+"List</p>\r\n");
		code.append(" *<p>Copyright:Copyright (c) 2014</p>\r\n");
		code.append(" *<p>Company:湖南科创</p>\r\n");
		code.append(" *@author AutoGenerator\r\n");
		code.append(" *@version 1.0\r\n");
		code.append(" *"+new Date()+"\r\n");
		code.append(" */\r\n");
		code.append("public class "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_LIST+" extends DataInfoImpl { \r\n");
	}
	@Override
	public void generating() {
		code.append("   private static final Logger LOG = Logger.getLogger("+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+".class);\r\n");
		code.append("	@Override\r\n");
		code.append("	public PagingBean getDataList(String parmjson, String sortName,\r\n");
		code.append("			String sortOrder, long offset, int maxPagesize) {\r\n");
		code.append("		"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+" bean = new "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"();\r\n");
		code.append("		PagingBean pb = null;\r\n");
		code.append("		bean =  StringUtil.convertStringToBean(parmjson, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+".class);\r\n");
		code.append("		"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAO+" dao = new "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_DAOIMPL+"();\r\n");
		code.append("		Connection con = null;\r\n");
		code.append("		try {\r\n");
		code.append("			con = DbManager.getInstance().getConnection();\r\n");
		code.append("			pb = dao.list(bean, sortName, sortOrder, offset, maxPagesize, con);\r\n");
		code.append("		} catch (Exception e) {\r\n");
		code.append("			LOG.error(e.getMessage(),e);\r\n");
		code.append("		} finally {\r\n");
		code.append("			DbManager.closeConnection(con);\r\n");
		code.append("		}\r\n");
		code.append("		return pb;\r\n");
		code.append("	}\r\n");
		code.append("\r\n");
		code.append("	@Override\r\n");
		code.append("	public PagingBean getDataList(String parmjson, String sortName,\r\n");
		code.append("			String sortOrder) {\r\n");
		code.append("		return null;\r\n");
		code.append("	}\r\n");
	}
	@Override
	public void after() {
		code.append("}");
		try {
			File file = new File(classProperty.getJavaPath()+File.separator+
								CodeConstant.PACKAGE_LIST+File.separator+
								classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_LIST+".java");
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

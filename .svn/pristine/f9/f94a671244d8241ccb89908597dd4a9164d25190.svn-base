package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.generator.JspPageGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;


public class GeneratorListJsp implements ClassGenerator {
	private JspPageGenerator jspPageGenerator;
	private ClassProperty classProperty;
	private StringBuffer code = new StringBuffer();
	@Override
	public void init(ClassProperty classProperty) {
		this.classProperty = classProperty;
		jspPageGenerator = new GeneratorListJspCode();
	}
	@Override
	public void before() {
		code.append("<%--\r\n");
		code.append("  Description："+classProperty.getTableChiName()+"列表页面\r\n");
		code.append("  Author：AutoGenerator\r\n");
		code.append("  Version：1.0\r\n");
		code.append("  Date："+new Date()+"\r\n");
		code.append("--%>\r\n");
	}
	@Override
	public void generating() {
		code.append(jspPageGenerator.generateJava(classProperty));
		code.append(jspPageGenerator.generateHeader(classProperty));
		code.append(jspPageGenerator.generateScript(classProperty));
		code.append(jspPageGenerator.generateBody(classProperty));
	}
	@Override
	public void after() {
		try {
			File file = new File(classProperty.getJspPath()+File.separator+
								CodeConstant.PACKAGE_JSP+File.separator+
								classProperty.getClassNameByLower()+CodeConstant.CLASS_SUFFIX_JSP_LIST+".jsp");
			FileUtils.writeStringToFile(file,code.toString(),"UTF-8");
			System.out.println("    ##"+CodeUtil.getLogTime()+" AutoGenrator Log: "+file.getName()+" 生成完成...");
		} catch (IOException e) {
			e.printStackTrace();
		}
		code.setLength(0);
	}
	@Override
	public void run(ClassProperty classProperty) {
		if(classProperty.getColumnProperty().size() == 0 || null == classProperty.getJspPath() || "".equals(classProperty.getJspPath())){
			return;
		} else {
			this.init(classProperty);
			this.before();
			this.generating();
			this.after();
		}
	}
}
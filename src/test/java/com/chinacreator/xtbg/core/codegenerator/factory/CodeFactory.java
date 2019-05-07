package com.chinacreator.xtbg.core.codegenerator.factory;

import java.util.List;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.dao.GenerateDao;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.dao.GenerateDaoImpl;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.entity.GenerateEntity;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp.GeneratorDoJsp;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp.GeneratorInfoJsp;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp.GeneratorListJsp;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.list.GenerateList;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.service.GenerateService;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.service.GenerateServiceImpl;

/**
 *<p>Title:CodeFactory.java</p>
 *<p>Description:代码生成工厂</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class CodeFactory {
	public static void generatorCode(List<ClassProperty> newClassList){
		System.out.println(newClassList);
		GeneratorFactory classGenerator = new GeneratorFactory(new GenerateEntity(),new GenerateDao(),
																new GenerateDaoImpl(),new GenerateList(),
																new GenerateService(),new GenerateServiceImpl(),
																new GeneratorInfoJsp(),new GeneratorListJsp(),
																new GeneratorDoJsp());
		classGenerator.initClassPropertyList(newClassList);
		classGenerator.run();
	}
}
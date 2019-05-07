package com.chinacreator.xtbg.core.codegenerator.factory;

import java.util.List;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ClassGenerator;
import com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp.GeneratorDoJsp;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;

/**
 *<p>Title:GeneratorFactory.java</p>
 *<p>Description:将代码生成器接口工厂，可以利用Spring注入各种代码生成器的实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class GeneratorFactory {
	private List<ClassProperty> listClassProperty;
	private ClassGenerator generateEntity;	//生成实体类
	private ClassGenerator generateDao;		//生成Dao
	private ClassGenerator generateDaoImpl;	//生成dao实现
	private ClassGenerator generateList;	//生成List
	private ClassGenerator generateService;	//生成service
	private ClassGenerator generateServiceImpl;//生成service实现
	private ClassGenerator generatorInfoJsp;//生成详细页面
	private ClassGenerator generatorListJsp;//生成list页面
	private ClassGenerator generatorDoJsp;//生成list页面
	
	public GeneratorFactory() {
		super();
	}
	public GeneratorFactory(ClassGenerator generateEntity,
			ClassGenerator generateDao, ClassGenerator generateDaoImpl,
			ClassGenerator generateList, ClassGenerator generateService,
			ClassGenerator generateServiceImpl,
			ClassGenerator generatorInfoJsp, ClassGenerator generatorListJsp,
			GeneratorDoJsp generatorDoJsp) {
		this.generateEntity = generateEntity;
		this.generateDao = generateDao;
		this.generateDaoImpl = generateDaoImpl;
		this.generateList = generateList;
		this.generateService = generateService;
		this.generateServiceImpl = generateServiceImpl;
		this.generatorInfoJsp = generatorInfoJsp;
		this.generatorListJsp = generatorListJsp;
		this.generatorDoJsp = generatorDoJsp;
	}
	/**
	*<b>Summary:初始化列list </b>
	* initClassPropertyList()
	* @param listClassProperty
	 */
	public void initClassPropertyList(List<ClassProperty> listClassProperty){
		this.listClassProperty = listClassProperty;
	}
	
	public void before(ClassProperty classProperty) {
		System.out.println("  ##"+CodeUtil.getLogTime()+" AutoGenrator Log: "+classProperty.getTableChiName()+"模块开始生成...");
	}

	public void generating(ClassProperty classProperty) {
		if(generateEntity != null){
			generateEntity.run(classProperty);
		}
		if(generateDao != null){
			generateDao.run(classProperty);
		}
		if(generateDaoImpl != null){
			generateDaoImpl.run(classProperty);
		}
		if(generateList != null){
			generateList.run(classProperty);
		}
		if(generateService != null){
			generateService.run(classProperty);
		}
		if(generateServiceImpl != null){
			generateServiceImpl.run(classProperty);
		}
		if(generatorInfoJsp != null){
			generatorInfoJsp.run(classProperty);
		}
		if(generatorListJsp != null){
			generatorListJsp.run(classProperty);
		}
		if(generatorDoJsp != null){
			generatorDoJsp.run(classProperty);
		}
	}
	public void after(ClassProperty classProperty) {
		System.out.println("  ##"+CodeUtil.getLogTime()+" AutoGenrator Log: "+classProperty.getTableChiName()+"模块生成完成...");
		System.out.println("");
	}
	public void run() {
		System.out.println("##"+CodeUtil.getLogTime()+" AutoGenrator Log: 代码生成开始，将会生成"+listClassProperty.size()+"个模块...");
		for(ClassProperty classProperty : listClassProperty){
			this.before(classProperty);
			this.generating(classProperty);
			this.after(classProperty);
		}
		System.out.println("##"+CodeUtil.getLogTime()+" AutoGenrator Log: 代码生成完成...");
	}
	
	public void setGenerateEntity(ClassGenerator generateEntity) {
		this.generateEntity = generateEntity;
	}
	public void setGenerateDao(ClassGenerator generateDao) {
		this.generateDao = generateDao;
	}
	public void setGenerateDaoImpl(ClassGenerator generateDaoImpl) {
		this.generateDaoImpl = generateDaoImpl;
	}
	public void setGenerateList(ClassGenerator generateList) {
		this.generateList = generateList;
	}
	public void setGenerateService(ClassGenerator generateService) {
		this.generateService = generateService;
	}
	public void setGenerateServiceImpl(ClassGenerator generateServiceImpl) {
		this.generateServiceImpl = generateServiceImpl;
	}
	public void setGeneratorInfoJsp(ClassGenerator generatorInfoJsp) {
		this.generatorInfoJsp = generatorInfoJsp;
	}
	public void setGeneratorListJsp(ClassGenerator generatorListJsp) {
		this.generatorListJsp = generatorListJsp;
	}
}
package com.chinacreator.xtbg.core.codegenerator.generator;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;


/**
 *<p>Title:Generator.java</p>
 *<p>Description:类代码生成器接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public interface ClassGenerator {
	/**
	*<b>Summary: 初始化</b>
	* init()
	 */
	public void init(ClassProperty classProperty);
	/**
	*<b>Summary:代码生成前 </b>
	* before()
	 */
	public void before();
	/**
	*<b>Summary: 生成代码</b>
	* generating()
	 */
	public void generating();
	
	/**
	*<b>Summary:代码生成后 </b>
	* after()
	 */
	public void after();
	
	/**
	*<b>Summary:运行（这个方法主要是为了约束这个接口的行为动作的执行顺序的，并不是必须的）</b>
	* run()
	 */
	public void run(ClassProperty classProperty);
}
package com.chinacreator.xtbg.core.codegenerator.entity;

import java.util.List;

/**
 *<p>Title:ClassProperty.java</p>
 *<p>Description:类属性</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 19, 2014
 */
public class ClassProperty {
    private String tableName;		//表英文名称
    private String tableChiName;	//表中文名称
	private String className;		//类名称
	private String javaPath;		//java代码文件生成主路径(绝对路径)
	private String jspPath;			//jsp代码文件生成主路径(绝对路径)
	private String classPackage;	//类包路径
	private String primaryKey;		//主键
	private List<ColumnProperty> columnProperty; //类关联的数据库字段
	
	/**
	  * <b>Summary: </b>
	  *     构造一个 ClassProperty  
	   * <b>Remarks: </b>
	  *     构造类 ClassProperty 的构造函数 ClassProperty
	  * @param tableName 表名
	  * @param className 类名	
	  * @param javaPath	 java生成主路径(绝对路径)
	  * @param jspPath   jsp生成主路径(绝对路径)
	 */
	public ClassProperty(String tableName, String className, String javaPath,String classPackage,
							String jspPath) {
		this.tableName = tableName;
		this.className = className;
		this.javaPath = javaPath;
		this.classPackage = classPackage;
		this.jspPath = jspPath;
	}
	
	public String getClassPackage() {
		return classPackage;
	}
	public void setClassPackage(String classPackage) {
		this.classPackage = classPackage;
	}

	/**
	*<b>Summary:获取表中文名称</b>
	* getTableChiName()
	* @return
	 */
	public String getTableChiName() {
		return tableChiName;
	}
	/**
	*<b>Summary: 设置表中文名称</b>
	* setTableChiName()
	* @param tableChiName
	 */
	public void setTableChiName(String tableChiName) {
		this.tableChiName = tableChiName;
	}

	/**
	 * <b>Summary: </b>
	 *     获取tableName的值
	 * @return tableName 
	 */
	public String getTableName() {
		return tableName;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 tableName 的值 
	 * @param tableName 
	 */
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	/**
	 * <b>Summary: </b>
	 *     获取columnProperty的值
	 * @return columnProperty 
	 */
	public List<ColumnProperty> getColumnProperty() {
		return columnProperty;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 columnProperty 的值 
	 * @param columnProperty 
	 */
	public void setColumnProperty(List<ColumnProperty> columnProperty) {
		this.columnProperty = columnProperty;
	}
	/**
	 * <b>Summary: </b>
	 *     获取className的值
	 * @return className 
	 */
	public String getClassName() {
		return className;
	}
	public String getClassNameByLower(){
		return className.toLowerCase();
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 className 的值 
	 * @param className 
	 */
	public void setClassName(String className) {
		this.className = className;
	}
	/**
	 * <b>Summary: </b>
	 *     获取javaPath的值
	 * @return javaPath 
	 */
	public String getJavaPath() {
		return javaPath;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 javaPath 的值 
	 * @param javaPath 
	 */
	public void setJavaPath(String javaPath) {
		this.javaPath = javaPath;
	}
	/**
	 * <b>Summary: </b>
	 *     获取jspPath的值
	 * @return jspPath 
	 */
	public String getJspPath() {
		return jspPath;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 jspPath 的值 
	 * @param jspPath 
	 */
	public void setJspPath(String jspPath) {
		this.jspPath = jspPath;
	}
	/**
	 * <b>Summary: </b>
	 *     获取primaryKey的值
	 * @return primaryKey 
	 */
	public String getPrimaryKey() {
		return primaryKey;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 primaryKey 的值 
	 * @param primaryKey 
	 */
	public void setPrimaryKey(String primaryKey) {
		this.primaryKey = primaryKey;
	}
	@Override
	public String toString() {
		return "[tableName:"+tableName+",className:"+className+",javaPath:"+javaPath+",jspPath:"+jspPath+",primaryKey:"+primaryKey+",columnProperty:"+columnProperty+"]";
	}
}

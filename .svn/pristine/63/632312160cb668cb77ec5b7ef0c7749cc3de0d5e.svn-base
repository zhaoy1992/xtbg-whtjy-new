package com.chinacreator.xtbg.pub.dbbase.entity;

import java.util.ArrayList;
import java.util.List;

public class XtDbBaseBean {
	/**
	 * 该bean对应的表名
	 */
	protected String tableName = "";
	
	/**
	 * 更新语句要指定的主key
	 */
	protected List<String> pKey = new ArrayList<String>();
	
	/**
	 * 更新语句要指定的主key
	 */
	protected List<String> updateKey = new ArrayList<String>();

	/**
	 * 删除语句要指定的主key
	 */
	protected List<String> deleteKey = new ArrayList<String>();

	public XtDbBaseBean(String tableName) {
		super();
		this.tableName = tableName;
	}
	/**
	 * 
	  * <b>Summary: 一次设置完所有key，有很多表的操作，都只依赖于主键</b>
	  *     构造一个 XtDbBaseBean  
	   * <b>Remarks: </b>
	  *     构造类 XtDbBaseBean 的构造函数 XtDbBaseBean
	  * @param tableName
	  * @param allKey
	 */
	public XtDbBaseBean(String tableName, List<String> allKey) {
		this.tableName = tableName;
		this.updateKey = allKey;
		this.deleteKey = allKey;
		this.pKey = allKey;
	}

	/**
	 * 
	  * <b>Summary: 一次设置完所有key，有很多表的操作，都只依赖于主键,所以三个key集合应该都是一致的</b></br>
	  *     构造一个 XtDbBaseBean  </br>
	   * <b>Remarks: 一次性设置完 主键，更新key，删除key</b></br>
	  *     构造类 XtDbBaseBean 的构造函数 XtDbBaseBean
	  * @param tableName
	  * @param allKey
	 */
	public XtDbBaseBean(String tableName, String... allKey) {
		this.tableName = tableName;
		for(String key : allKey){
			this.updateKey.add(key);
		}
		for(String key : allKey){
			this.deleteKey.add(key);
		}
		for(String key : allKey){
			this.pKey.add(key);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 XtDbBaseBean  
	   * <b>Remarks: </b>
	  *     构造类 XtDbBaseBean 的构造函数 XtDbBaseBean
	  * @param tableName 表名
	  * @param updateKey 更新key集合
	  * @param deleteKey 删除key集合
	 */
	public XtDbBaseBean(String tableName, List<String> updateKey, List<String> deleteKey) {
		this.tableName = tableName;
		this.updateKey = updateKey;
		this.deleteKey = deleteKey;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 XtDbBaseBean  
	   * <b>Remarks: </b>
	  *     构造类 XtDbBaseBean 的构造函数 XtDbBaseBean
	  * @param tableName 表名
	  * @param updateKey 更新key数组
	  * @param deleteKey 删除key数组
	 */
	public XtDbBaseBean(String tableName, String[] updateKey, String[] deleteKey) {
		this.tableName = tableName;
		for(String key : updateKey){
			this.updateKey.add(key);
		}
		for(String key : deleteKey){
			this.deleteKey.add(key);
		}
	}
	
	public XtDbBaseBean(String tableName, List<String> updateKey, List<String> deleteKey, List<String> pKey) {
		this.tableName = tableName;
		this.updateKey = updateKey;
		this.deleteKey = deleteKey;
		this.pKey = pKey;
	}
	public XtDbBaseBean(String tableName, String[] updateKey, String[] deleteKey, String[] pKey) {
		this.tableName = tableName;
		for(String key : updateKey){
			this.updateKey.add(key);
		}
		for(String key : deleteKey){
			this.deleteKey.add(key);
		}
		for(String key : pKey){
			this.pKey.add(key);
		}
	}

	/**
	*<b>Summary: 清空表的主键的集合</b>
	 */
	public XtDbBaseBean clearPKey(){
		pKey.clear();
		return this;
	}

	/**
	*<b>Summary: 清空更新语句要指定的主key的集合</b>
	 */
	public XtDbBaseBean clearUpdateKey(){
		updateKey.clear();
		return this;
	}
	/**
	*<b>Summary: 清空删除语句要指定的主key的集合</b>
	 */
	public XtDbBaseBean clearDeleteKey(){
		deleteKey.clear();
		return this;
	}
	/**
	*<b>Summary: 设置表的要指定的主键</b>
	* @param key
	 */
	public XtDbBaseBean setPKey(String... keys){
		pKey.clear();
		for(String key : keys){
			pKey.add(key);
		}
		return this;
	}

	/**
	*<b>Summary: 设置更新语句要指定的主key</b>
	* @param key
	 */
	public XtDbBaseBean setUpdateKey(String... keys){
		updateKey.clear();
		for(String key : keys){
			updateKey.add(key);
		}
		return this;
	}
	/**
	*<b>Summary: 设置删除语句要指定的主key</b>
	* @param key
	 */
	public XtDbBaseBean setDeleteKey(String... keys){
		deleteKey.clear();
		for(String key : keys){
			deleteKey.add(key);
		}
		return this;
	}
	/**
	*<b>Summary: 添加表的要指定的主键</b>
	* @param key
	 */
	public XtDbBaseBean addPKey(String... keys){
		for(String key : keys){
			pKey.add(key);
		}
		return this;
	}

	/**
	*<b>Summary: 添加更新语句要指定的主key</b>
	* @param key
	 */
	public XtDbBaseBean addUpdateKey(String... keys){
		for(String key : keys){
			updateKey.add(key);
		}
		return this;
	}
	/**
	*<b>Summary: 添加删除语句要指定的主key</b>
	* @param key
	 */
	public XtDbBaseBean addDeleteKey(String... keys){
		for(String key : keys){
			deleteKey.add(key);
		}
		return this;
	}	

	/**
	 * 
	 *<b>Summary:获取更新语句中的更新主key ，即为 where 后面的条件字段 </b>
	 */
	public String getTableName() {
		return tableName;
	}

	/**
	 * 
	 *<b>Summary:设置更新语句中的更新主key ，即为 where 后面的条件字段 </b>
	 */
	public XtDbBaseBean setTableName(String tableName) {
		this.tableName = tableName;
		return this;
	}

	/**
	 * 
	 *<b>Summary:获取表中的主键 </b>
	 */
	public List<String> getpKey() {
		return pKey;
	}
	/**
	 * 
	 *<b>Summary:设置表中的主键</b>
	 */
	public XtDbBaseBean setpKey(List<String> pKey) {
		this.pKey = pKey;
		return this;
	}

	/**
	 * 
	 *<b>Summary:获取更新语句中的更新主key ，即为 where 后面的条件字段 </b>
	 */
	public List<String> getUpdateKey() {
		return updateKey;
	}

	/**
	 * 
	 *<b>Summary:获取更新语句中的更新主key ，即为 where 后面的条件字段</b>
	 */
	public XtDbBaseBean setUpdateKey(List<String> updateKey) {
		this.updateKey = updateKey;
		return this;
	}

	/**
	 * 
	 *<b>Summary:设置更新语句中的更新主key ，即为 where 后面的条件字段 </b>
	 * 
	 * @return
	 */
	public List<String> getDeleteKey() {
		return deleteKey;
	}

	/**
	 * 
	 *<b>Summary:设置更新语句中的更新主key ，即为 where 后面的条件字段 </b>
	 * 
	 * @param deleteKey
	 */
	public XtDbBaseBean setDeleteKey(List<String> deleteKey) {
		this.deleteKey = deleteKey;
		return this;
	}

}

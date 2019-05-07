package com.chinacreator.xtbg.core.common.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:SqlUtil.java</p>
 *<p>Description:Sql工具类，为预编译sql赋值，也可以执行sql，自动赋值，并返回Bean或list</p>
 *<p>为sql赋值，要求bean里的属性和字段名一致，自动组装bean也需要bean里的属性和字段名一致，后期可以考虑注解实现解决这个问题</p>
 *<p>请使用泛型约束传入及返回的数据类型</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Aug 23, 2013
 */
public class SqlUtil<T> {
	private static final Logger LOG = Logger.getLogger(SqlUtil.class);
	public SqlUtil(){
		
	}
	
	/**
	 * 
	*<b>Summary: 解析sql，并为预编译sql自动赋值，返回PreparedDBUtil</b>
	*<b>能解析的sql语句模型有：columnName = ? 或 columnName like ? </b>
	*<b>或 columnName = to_xxx(?,"yyyy-mm-dd")模式
	* parseSql()
	* @param sql
	* @param pdb
	* @param T
	* @return
	* @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public PreparedDBUtil parseSql(String sql,PreparedDBUtil pdb,T bean) throws Exception{
		Class<T> c = (Class<T>) bean.getClass();
		Method m = null;
		
		if(sql != null){
			if(sql.trim().toLowerCase().startsWith("insert")){
				String[] fieldStr = getInsertField(sql.toString());
				if( fieldStr != null ){
					int nextNum = 1;
					for(int i = 0;i<fieldStr.length;i++){
						String mName = getMethodName(c,fieldStr[i]);
						if(!"".equals(mName)){
							m = c.getDeclaredMethod(mName);
							pdb.setObject(nextNum++, m.invoke(bean));
						}
					}
				}
			} else {
				List<String> list = getFields(sql);
				if(list.size() > 0){
					int nextNum = 1;
					for(String field : list ){
						String mName = getMethodName(c,field);
						if(!"".equals(mName)){
							m = c.getDeclaredMethod(mName);
//System.out.println(m.invoke(bean));
							pdb.setObject(nextNum++, m.invoke(bean));
						}
					}
				}
			}
		}
		return pdb;
	}
	
	/**
	 * 
	*<b>Summary: 执行insert操作，自动赋值</b>
	* insert()
	* @param sql
	* @param T
	* @return
	* @throws Exception
	 */
	public boolean executeInsert(String sql , T bean) throws Exception {
		return executeInsert(sql , bean , null);
	}
	
	/**
	 * 
	*<b>Summary: 执行insert操作，自动赋值</b>
	* insert()
	* @param sql
	* @param T
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean executeInsert(String sql ,  T bean , Connection con) throws Exception {
		boolean flag = false;
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		pdb.preparedInsert(sql);
		
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				pdb.executePrepared();	
			} else {
				pdb.executePrepared(con);
			}
			flag = true;
		}
		return flag;
	}
	
	/**
	*<b>Summary: 执行update操作，自动赋值</b>
	* update()
	* @param sql
	* @param T
	* @return
	* @throws Exception
	 */
	public boolean executeUpdate(String sql ,  T bean) throws Exception {
		return executeUpdate(sql , bean,null) ;
	}
	
	/**
	*<b>Summary: 执行update操作，自动赋值</b>
	* update()
	* @param sql
	* @param T
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean executeUpdate(String sql ,  T bean,Connection con) throws Exception {
		boolean flag = false;
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		pdb.preparedUpdate(sql);
		
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				pdb.executePrepared();	
			} else {
				pdb.executePrepared(con);
			}
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 
	*<b>Summary:执行删除操作，自动赋值（注意：该方法不提供 in 语句的赋值） </b>
	* executeDelete()
	* @param sql
	* @param bean
	* @return
	* @throws Exception
	 */
	public boolean executeDelete(String sql ,  T bean) throws Exception {
		return executeDelete(sql ,  bean,null);
	}
	
	/**
	 * 
	*<b>Summary:执行删除操作，自动赋值（注意：该方法不提供 in 语句的赋值） </b>
	* executeDelete()
	* @param sql
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean executeDelete(String sql ,  T bean,Connection con) throws Exception {
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		pdb.preparedDelete(sql);
		
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				pdb.executePrepared();
			} else {
				pdb.executePrepared(con);
			}
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 
	*<b>Summary: 执行查询操作，自动组装bean</b>
	* executeForObject()
	* @param sql
	* @param T
	* @return
	* @throws Exception
	 */
	public Object executeForObject(String sql ,  T bean ) throws Exception {
		return executeForObject(sql , bean , null);
	}
	
	/**
	 * 
	*<b>Summary: 执行查询操作，自动组装bean</b>
	* executeForObject()
	* @param sql
	* @param T
	* @param con
	* @return
	* @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public T executeForObject(String sql ,  T bean , Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		Class<T> c = (Class<T>)bean.getClass();
		T returnBean = null;
		
		pdb.preparedSelect(sql);
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				returnBean = (T) pdb.executePreparedForObject(c);
			} else {
				returnBean = (T) pdb.executePreparedForObject(con, c);
			}
		}
		return returnBean;
	}
	
	/**
	 * 
	*<b>Summary: 执行查询操作，自动组装list</b>
	* executeForList()
	* @param sql
	* @param con
	* @return
	* @throws Exception
	 */
	public List<T> executeForList(String sql,  T bean) throws Exception {
		return executeForList(sql, bean,null);
	}
	
	/**
	 * 
	*<b>Summary: 执行查询操作，自动组装list</b>
	* executeForList()
	* @param sql
	* @param T
	* @param con
	* @return
	* @throws Exception
	 */
	@SuppressWarnings({ "unchecked"})
	public List<T> executeForList(String sql,  T bean,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		Class<T> c = (Class<T>) bean.getClass();
		List<T> beanList = new ArrayList<T>();
		
		pdb.preparedSelect(sql);
		
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				beanList = pdb.executePreparedForList(c);
			} else {
				beanList = pdb.executePreparedForList(con, c);
			}
		}
		return beanList;
	}
	
	/**
	 * 
	*<b>Summary:执行分页查询操作，自动组装list </b>
	* executeForListWithPage()
	* @param sql
	* @param T
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean executeForListWithPage(String sql, T T,String sortName, String sortOrder, long offset, int maxPagesize) throws Exception {
		return executeForListWithPage(sql,T,sortName, sortOrder, offset, maxPagesize, null);
	}
	
	/**
	 * 
	*<b>Summary: 执行分页查询操作，自动组装list</b>
	* executeForListWithPage()
	* @param sql
	* @param T
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @param con
	* @return
	* @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public PagingBean executeForListWithPage(String sql, T bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		Class<T> c = (Class<T>) bean.getClass();
		PagingBean pageBean = new PagingBean();
		List<T> beanList = new ArrayList<T>();
		
		pdb.preparedSelect(sql.toString(), offset, maxPagesize);
		
		pdb = parseSql(sql,pdb,bean);
		if(pdb != null){
			if(con == null ){
				beanList = pdb.executePreparedForList(c);
			} else {
				beanList = pdb.executePreparedForList(con, c);
			}
			pageBean.setList(beanList);
			pageBean.setRecords((long)pdb.getTotalSize());
		}
		return pageBean;
	}
	
	/**
	 * 
	*<b>Summary: 得到update操作及select操作的所有将要赋值的字段</b>
	* getFields()
	* @param sql
	* @return
	 */
	public List<String> getFields(String sql){
		List<String> list = new ArrayList<String>();
		//匹配 xxx =|like ( to_xxx( ) ?
		Pattern pattern = Pattern.compile("(\\w+\\s*(=|like|>=|<=|>|<|!=)\\s*(to_\\w+\\(\\s*)?\\?)",Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(sql.toString());
		while(matcher.find()){
			String matcherStr = matcher.group(0);
			if(matcherStr != null && !"".equals(matcherStr)){
				String field = "";
				if(matcherStr.contains("=")){
					if(matcherStr.contains(">=")){
						field = matcherStr.substring(0,matcherStr.indexOf(">=")).trim();	//去掉>=，得到列名
					} else if(matcherStr.contains("<=")){
						field = matcherStr.substring(0,matcherStr.indexOf("<=")).trim();	//去掉<=，得到列名
					} else if(matcherStr.contains("!=")){
						field = matcherStr.substring(0,matcherStr.indexOf("!=")).trim();	//去掉!=，得到列名
					} else {
						field = matcherStr.substring(0,matcherStr.indexOf("=")).trim();	//去掉=，得到列名	
					}
				} else if(matcherStr.contains(">")){
					field = matcherStr.substring(0,matcherStr.indexOf(">")).trim();	//去掉>，得到列名
				} else if(matcherStr.contains("<")){
					field = matcherStr.substring(0,matcherStr.indexOf("<")).trim();	//去掉<，得到列名
				} else {
					field = matcherStr.substring(0,matcherStr.indexOf("like")).trim();	//去掉like，得到列名
				}
				list.add(field);
			}
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: 得到insert语句的所有赋值字段</b>
	* getInsertField()
	* @param sql
	* @return
	 */
	public String[] getInsertField(String sql){
		String[] fields = null;
		if(sql == null ){
			return fields;
		} else {
			String fieldStr = sql.toLowerCase().substring(sql.indexOf("(")+1,sql.indexOf(")"));
			if(fieldStr != null && !"".equals(fieldStr)){
				return fieldStr.split(",");	
			} else {
				return fields;
			}
		}
	}
	
	/**
	 * 
	*<b>Summary: 得到实体类中的get方法</b>
	* getMethodName()
	* @param f
	* @return
	 */
	private String getMethodName(Class<T> _class, String fieldName) {
		Field f = null;
		String methodNames = "";
		if(fieldName != null && !"".equals(fieldName)){
			try {
				if(fieldName.contains(".")){
					fieldName = fieldName.substring(fieldName.lastIndexOf("."));//解析带别名的字段，例如（user.username）,只解析列名username 
				}
				f = _class.getDeclaredField(fieldName.trim());
			} catch (SecurityException e) {
				LOG.error(e.getMessage(),e);
			} catch (NoSuchFieldException e) {
				LOG.error("实体对象["+_class.getName()+"]中，未找到属性："+fieldName+"，请确保数据库中字段和实体对象属性名一致");
				LOG.error("the field["+fieldName+"] is not found in "+_class.getName()+"! please check column name and fieldName!",e);
			}
		}
		if(f != null){
			String fn = f.getName();	
			char ch = (char) (fn.charAt(0) - 32);
			methodNames = "get" + ch + fn.substring(1);
		}
		return methodNames;
	}
}

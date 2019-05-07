package com.chinacreator.xtbg.core.common.dbbase.entity;

import java.util.HashMap;

import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:封装HashMap,以扩展HashMap的功能</p>
 *<p>Description:继承自HashMap 信息展示bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-18
 */
public class XtShowInfoHashMap extends HashMap<String,String> {

	
	 /** 
	  * serialVersionUID:TODO（请用一句话描述这个变量表示什么） 
	  */
	private static final long serialVersionUID = 2831512538196889917L;

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 get
	  * @param key
	  * @return 
	  * @see java.util.HashMap#get(java.lang.Object)
	 */
	public String get(Object key) {
		// TODO Auto-generated method stub
		return StringUtil.deNull(super.get(key));
	}

	
	
	
	
}

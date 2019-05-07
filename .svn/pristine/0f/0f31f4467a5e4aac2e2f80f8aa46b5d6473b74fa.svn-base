package com.chinacreator.xtbg.pub.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.ReadServletClass;
import com.chinacreator.xtbg.pub.common.ServletClassBean;

/**
 *<p>Title:ServletClassUtil.java</p>
 *<p>Description:Servlet实例bean工具类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-1-13
 */
public class ServletClassUtil {
	
protected static final Logger log = Logger.getLogger(ServletClassUtil.class.getName());
	
	private static ServletClassUtil instance = null;
	
	private ServletClassUtil(){
		
	}
	
	
	public static ServletClassUtil getInstance() {
		synchronized (instance) {
			if(instance == null) {
				instance = new ServletClassUtil();
			}
		}
		return instance;
	}
	
	/**
	 * @Description  获得servlet类对象
	 * @param id
	 * @return  Object
	 * @exception IllegalAccessException, InstantiationException, ClassNotFoundException
	 */
	public static Object getServletClass(String id) throws Exception {
		List<ServletClassBean> list = new ArrayList<ServletClassBean>();
		list = ReadServletClass.getServletList();
		String daoImplClassName = "";
		Object obj = null;
		for(int i = 0; i < list.size(); i++) {
			ServletClassBean servletClassBean = list.get(i);
			if(id.equals(servletClassBean.getId())) {
				daoImplClassName = servletClassBean.getClassName();
				obj = Class.forName(daoImplClassName).newInstance();
				break;
			}
		}
		if (StringUtil.isBlank(daoImplClassName)) {
			log.info("没有找到配置的Servlet实例类,请检查配置文件");
		}
		return obj;
	}
}

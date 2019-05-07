package com.chinacreator.xtbg.pub.util;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.pub.common.DaoImplClassBean;
import com.chinacreator.xtbg.pub.common.ReadDaoImplClass;
import org.apache.log4j.Logger;

/**
 *<p>Title:DaoImplClassUtil.java</p>
 *<p>Description:DaoImpl实例工具类</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2011-12-26
 */
public class DaoImplClassUtil {

	protected static final Logger log = Logger.getLogger(DaoImplClassUtil.class.getName());
	
	private static DaoImplClassUtil instance = null;
	
	private DaoImplClassUtil() {
		
	}
	
	public static DaoImplClassUtil getInstance() {
		synchronized (instance) {
			if(instance == null) {
				instance = new DaoImplClassUtil();
			}
		}
		return instance;
	}
	
	/**
	 * @Description  获得DaoImpl类对象
	 * @param id
	 * @return  Object
	 * @exception IllegalAccessException, InstantiationException, ClassNotFoundException
	 */
	public static Object getDaoImplClass(String id) throws Exception {
		List<DaoImplClassBean> list = new ArrayList<DaoImplClassBean>();
		list = ReadDaoImplClass.getDaoImplList();
		String daoImplClassName = "";
		Object obj = null;
		for(int i = 0; i < list.size(); i++) {
			DaoImplClassBean daoImplClassBean = list.get(i);
			if(id.equals(daoImplClassBean.getId())) {
				
				daoImplClassName = daoImplClassBean.getClassName();
				obj = Class.forName(daoImplClassName).newInstance();
				break;
			}
		}
		if (StringUtil.isBlank(daoImplClassName)) {
			log.info("没有找到配置的DaoImpl实例类,请检查配置文件");
		}
		return obj;
	}
}

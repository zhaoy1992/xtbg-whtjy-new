package com.chinacreator.xtbg.pub.tree.dao;

import java.util.Map;


/**
 *<p>Title:TestZtreeDao.java</p>
 *<p>Description:测试Ztree的dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-12
 */
public interface TreeDao {
/*
	 * 查询在线人数
	 */
	String getViewOlineTreeMessage(Map<String, String> map)throws Exception;
}

package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
/**
 * 
 *<p>Title:FlowBusiDataSaveDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Aug 22, 2013
 */
public interface FlowBusiDataSaveDao {
	/**
	 * 流程需要订制个性化的增删改
	 * 在request增加CUSTOM_CRUD_CLASSNAME=类名[FlowBusiDataSaveDao的实现类]
	 */
	public static final String CUSTOM_CRUD_CLASSNAME_FLAG = "CUSTOM_CRUD_CLASSNAME";
	/**
	 * 
	 *<b>Summary: </b>
	 * saveBusiInfo(在处理流程环节时,订制个性化的数据修改,服务于ArchiveServiceImpl.handler())
	 * @param request
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn) throws Exception;
}

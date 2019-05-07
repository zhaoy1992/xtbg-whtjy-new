package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:FileProgramPageDao.java</p>
 *<p>Description:档案程序界面Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-10
 */
public interface FileProgramPageDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* selNoticeViewList(查看档案程序界面列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selFileProgramPageList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getNoticeBaseInfoBean(查询程序界面基本信息)
	* @param f_program_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFileProgramPageBean(String f_program_id, Connection conn) throws Exception;
}

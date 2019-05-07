package com.chinacreator.xtbg.core.file.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;

/**
 * 统计
 *<p>Title:FileTJDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 23, 2013
 */
public interface FileTJDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList1(统计 按分类)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryList1(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize,String type) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList2(统计 按文档)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryList2(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize,String type) throws Exception;
	
}

package com.chinacreator.xtbg.core.file.dao;



import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;

/**
 * 
 *<p>Title:FileDocQueryDao.java</p>
 *<p>Description:档案查询dao,开发结束后,整合到FileDocDao中去</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 23, 2013
 */
public interface FileFilesQueryDao{
	
	/**
	 * 查询文件管理列表,为档案查询功能
	 *<b>Summary: </b>
	 * queryFileDocListOther(查询文件管理列表,为档案查询功能)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileFilesListOther(FileFilesQueryBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	 * 按部门查询档案
	 *<b>Summary: </b>
	 * queryFileFilesListByDept(按部门查询档案)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileFilesListByDept(FileFilesBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	public PagingBean queryFileFilesDevolveInfoAddFilesList(FileFilesBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	

}

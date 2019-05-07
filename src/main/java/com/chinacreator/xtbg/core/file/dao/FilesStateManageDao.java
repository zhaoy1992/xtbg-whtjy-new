package com.chinacreator.xtbg.core.file.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;

/**
 * 新需求管理档案的 提交状态,
 * 防止一个java类中出现多个代码风格
 * 拖出来专门处理，
 *<p>Title:FilesStateManageDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-5-5
 */
public interface FilesStateManageDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileDocBeforeArchiveList(请用一句话描述这个方法的作用)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFilesSubmitList(FileFilesBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * tijiaoFiles(请用一句话描述这个方法的作用)
	 * @param ids
	 * @return
	 */
	public boolean  tijiaoFiles(String[] ids,String userId,String userName);
	public boolean  jieshouFiles(String[] ids);
}

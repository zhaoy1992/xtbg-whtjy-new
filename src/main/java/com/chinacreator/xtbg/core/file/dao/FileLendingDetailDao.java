package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;

/**
 * 
 *<p>Title:FileLendingDetailDao.java</p>
 *<p>Description:借阅明细Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public interface FileLendingDetailDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList(查询本人借阅)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryList(FileFilesQueryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getDocIdByUserId(查询某用户加入借阅篮的文件)
	 * @param userId
	 * @param conn
	 * @param flag true:sql加了for update
	 * @return
	 * @throws Exception
	 */
	public Set<String> getDocIdByUserId(String userId,Connection conn,boolean flag)
			throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getDAGLYWithJYL(查看某一用户借阅篮关联的文档关联的档案管理员)
	 * @param userId
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<String[]> getDAGLYWithJYL(String userId,Connection conn)
			throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileLendingDetailForJYSQ(为借阅申请查询借阅文件集合)
	 * @param beanIds
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getFileLendingDetailForJYSQ(String[] beanIds,Connection conn)
			throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFileFondsnoBean(请用一句话描述这个方法的作用)
	* @param beanId
	* @return
	 */
	public Map<String, String> getFileLendingDetailBean(String beanId,Connection conn)
			throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getFilelendingBeanList(档案借阅管理查询)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean getFilelendingBeanList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileLendingDetailById(依据借阅申请ID，查询出明细)
	 * @param beanId
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getFileLendingDetailById(String beanId,Connection conn)
			throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList(档案管理员给用户做借阅登记时查询)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryListByAdmin(FileFilesQueryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * checkKC(检查库存数量)
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> checkKC(List<FileLendingDetailBean> list,Connection conn)throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateKC(检查库存)
	 * @param list
	 * @param conn
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public boolean updateKC(List<FileLendingDetailBean> list,Connection conn,String type)throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryMyFileLendingBeforeList(档案借阅管理--待借阅)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryMyFileLendingBeforeList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
	throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileLendingFlowDoList(档案借阅申请-审核中)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getFileLendingFlowDoList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
	throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * MyFileLendingForMeBeforeList(我借阅的档案-待借阅)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean MyFileLendingForMeBeforeList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
	throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * MyFileLendingForMeNowList(我借阅的档案-借阅中)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean MyFileLendingForMeNowList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * MyFileLendingForMeBackList(我借阅的档案-借阅归还后)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean MyFileLendingForMeBackList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileLendingDetailListByIds(通过IDS,获得多个对象)
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getFileLendingDetailListByIds(String ids,Connection conn)throws Exception;
	/**
	 * 
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean deleteFlow(String ids,Connection conn)throws Exception;
}

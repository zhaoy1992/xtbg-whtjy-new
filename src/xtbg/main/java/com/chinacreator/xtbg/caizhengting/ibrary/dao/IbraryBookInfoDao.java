package com.chinacreator.xtbg.caizhengting.ibrary.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean;
import com.chinacreator.xtbg.pub.common.PagingBean;

/**
 *<p>Title:IbraryBookInfoDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryBookInfoDao {
	/**
	 * 
	*<b>Summary: </b>
	* addIbraryTree(增加图书分类信息)
	* @param bean
	* @return
	 */
	public String addbean(IbraryBookInfoBean bean,Connection con)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* delIbraryTree(删除图书分类信息)
	* @param id
	* @return
	 */
	public String delbean(String[] id,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getbeanbyid(根据ID查询分类详细)
	* @param id
	* @return
	 */
	public IbraryBookInfoBean getbeanbyid(String id,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebean(更新)
	* @param bean
	* @return
	 */
	public String updatebean(IbraryBookInfoBean bean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* copybookinfo(复制)
	* @param id
	* @return
	 */
	public String copybookinfo(IbraryBookInfoBean bean,Connection con)throws Exception;
	
	public PagingBean list(IbraryBookInfoBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;  
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebookstate(请用一句话描述这个方法的作用)
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public String updatebookstate(IbraryBookInfoBean bean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delteBookBorrowinfobyBookId(删除图书时 同时删除借阅历史)
	* @param id
	* @return
	 */
	public String getbookCode(String tree_id,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertRegBookInfo(插入申请表信息)
	* @param iBraryRegBookInfoBean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean insertRegBookInfo(IBraryRegBookInfoBean iBraryRegBookInfoBean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateRegBookInfo(更新申请表信息)
	* @param iBraryRegBookInfoBean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean updateRegBookInfo(IBraryRegBookInfoBean iBraryRegBookInfoBean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertRegBookBookInfo(插入申请图书表信息)
	* @param ibraryRegBookBookInfoBean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean insertRegBookBookInfo(IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateRegBookBookInfo(更新申请图书表信息)
	* @param ibraryRegBookBookInfoBean
	* @param con
	* @return
	* @throws Exception
	 */
	public boolean updateRegBookBookInfo(IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean ,Connection con)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteRegBookBookInfo(根据申请表ID删除申请图书表信息)
	* @param regBookBookIds
	* @return
	* @throws Exception
	 */
	public boolean deleteRegBookBookInfo(String regBookBookIds,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateBookNumber(更新图书库存数量)
	* @param ibraryBookInfoBean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateBookNumber(IbraryBookInfoBean ibraryBookInfoBean,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryBookInfo(查询图书信息)
	* @param bookIds
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryBookInfo(String bookIds,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegBookInfo(查询图书申请表信息)
	* @param bookRegIds
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryRegBookInfo(String bookRegId,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegBookBookInfo(查询申请表申请图书信息)
	* @param bookBookRegIds
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryRegBookBookInfo(String bookRegId,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findRegBookInfoList(查询申请表列表)
	* @param iBraryRegBookInfoBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findRegBookInfoList(IBraryRegBookInfoBean iBraryRegBookInfoBean, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findRegBookInfoYJYList(查询已超期图书)
	* @param iBraryRegBookInfoBean
	* @return
	* @throws Exception
	 */
	public List<IBraryRegBookInfoBean> findRegBookInfoYJYList(IBraryRegBookInfoBean iBraryRegBookInfoBean)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegYJYBookBookInfo(查询用户已借阅图书)
	* @param user_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryRegYJYBookBookInfo(String user_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findBookInfoTree(查询所有图书分类)
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> findBookInfoTree() throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegBookInfoByBookId(根据图书id查询借出的记录条数)
	* @param book_id
	* @return
	* @throws Exception
	 */
	public String queryRegBookInfoByBookId(String book_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteRegBookInfo(根据申请表IDs删除申请表信息)
	* @param t_regb_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteRegBookInfo(String t_regb_id,Connection conn) throws Exception;
}

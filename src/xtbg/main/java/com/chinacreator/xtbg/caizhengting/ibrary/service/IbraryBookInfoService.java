package com.chinacreator.xtbg.caizhengting.ibrary.service;



import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean;

/**
 *<p>Title:IbraryBookInfoService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryBookInfoService {
	/**
	 * 
	*<b>Summary: </b>
	* addbookinfo(新增)
	* @param bean
	* @return
	 */
	public String addbookinfo(IbraryBookInfoBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* addbookinfo(删除)
	* @param bean
	* @return
	 */
	public String delbookinfo(String[] id);
	/**
	 * 
	*<b>Summary: </b>
	* addbookinfo(更新)
	* @param bean
	* @return
	 */
	public String updatebookinfo(IbraryBookInfoBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* addbookinfo(根据ID 查询详细)
	* @param bean
	* @return
	 */
	public IbraryBookInfoBean getbookinfobyid(String id);
	/**
	 * 
	*<b>Summary: </b>
	* addbookinfo(复制)
	* @param bean
	* @return
	 */
	public String copybookinfo(IbraryBookInfoBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebookstate(修改图书借阅状态)
	* @param bean
	* @return
	 */
	public String updatebookstate(IbraryBookInfoBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getbookCode(根据节点ID 获取该节点下图书最大编号)
	* @param tree_id
	* @return
	 */
	public String getbookCode(String tree_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateRegBookInfo(增加和更新申请表信息)
	* @param iBraryRegBookInfoBean
	* @return
	 */
	public String insertOrUpdateRegBookInfo(IBraryRegBookInfoBean iBraryRegBookInfoBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateRegBookBookInfo(增加和更新申请图书表信息)
	* @param ibraryRegBookBookInfoBean
	* @return
	 */
	public String insertOrUpdateRegBookBookInfo(IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteRegBookBookInfo(根据申请表ID删除申请图书表信息)
	* @param regBookIds
	* @return
	 */
	public boolean deleteRegBookBookInfo(String[] regBookIds);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteRegBookInfo(根据申请表IDs删除申请表信息)
	* @param t_regb_id
	* @return
	 */
	public boolean deleteRegBookInfo(String t_regb_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateBookNumber(更新图书库存数量)
	* @param ibraryBookInfoBean
	* @return
	 */
	public boolean updateBookNumber(IbraryBookInfoBean ibraryBookInfoBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryBookInfo(查询图书信息)
	* @param bookIds
	* @return
	 */
	public List<Map<String, String>> queryBookInfo(String bookIds);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegBookInfo(查询图书申请表信息)
	* @param bookRegId
	* @return
	 */
	public List<Map<String, String>> queryRegBookInfo(String bookRegId);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegBookBookInfo(查询申请表申请图书信息)
	* @param bookRegId
	* @return
	 */
	public List<Map<String, String>> queryRegBookBookInfo(String bookRegId);
	
	/**
	 * 
	*<b>Summary: </b>
	* findRegBookInfoYJYList(是否存在已超期图书)
	* @param iBraryRegBookInfoBean
	* @return
	 */
	public boolean isHavaYCQBook(IBraryRegBookInfoBean iBraryRegBookInfoBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryRegYJYBookBookInfo(查询用户已借阅图书)
	* @param user_id
	* @return
	 */
	public List<Map<String, String>> queryRegYJYBookBookInfo(String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* findBookInfoTree(查询所有图书分类)
	* @return
	 */
	public List<Map<String, String>> findBookInfoTree();
	
	/**
	 * 
	*<b>Summary: </b>
	* isHavaNoGuiHuanBook(该图书是否存在未归还的)
	* @param book_id
	* @return
	 */
	public String isHavaNoGuiHuanBook(String book_id);
}

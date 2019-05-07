package com.chinacreator.xtbg.core.file.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;
import com.chinacreator.xtbg.core.file.entity.FilelendingBean;

/**
 * 
 *<p>Title:FileLendingServiceIfc.java</p>
 *<p>Description:借阅管理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public interface FileLendingServiceIfc {
	/**
	 * 
	 *<b>Summary: </b>
	 * add(在查询档案页面,临时增加文件进入借阅篮,数据待审核状态)
	 * @param fileDocBeanIds
	 * @param userId
	 * @return
	 */
	public boolean addFileLendingDetailAfterQueryFileFiles(String[] fileDocBeanIds,String userId);
	/**
	 * 
	 *<b>Summary: </b>
	 * delete(删收藏)
	 * @param beanId
	 * @return
	 */
	public boolean delete(String[] beanId);
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileLendingDetailForJYSQ(为借阅申请查询借阅文件明细)
	 * @param beanIds
	 * @return
	 */
	public List<Map<String,String>> getFileLendingDetailForJYSQ(String[] beanIds);
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getFileFondsnoBean(根据借阅ID 查询借阅文件详细 
	* @param f_fonds_id
	* @return
	 */
	public Map<String, String> getFileLendingDetailBean(String beanId);
	
	/**
	 * 
	*<b>Summary: </b>
	* addFileFondsno(添加借阅信息
	* @param bean
	* @param detailbean
	* @return
	 */
	public boolean addFileFondsno(FilelendingBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* updatedetalbean(更新借阅详细 关联借阅ID 
	* @param detailbean
	* @return
	 */
	public boolean updatedetalbean(FileLendingDetailBean detailbean);
	
	/**
	 * 
	*<b>Summary: </b>
	* givebackDetail(归还借阅文件
	* @param detailbean
	* @return
	 */
	public boolean givebackDetail(FileLendingDetailBean detailbean);
	/**
	 * 查询一借阅申请的明细集合
	 *<b>Summary: </b>
	 * getFileLendingDetailByKey(请用一句话描述这个方法的作用)
	 * @param key
	 * @return
	 */
	public List<Map<String,String>> getFileLendingDetailByKey(String key);
	/**
	 * 
	 *<b>Summary: </b>
	 * saveFileFondsno(档案借阅登记:addFileFondsno+updatedetalbean+1个事务内)
	 * @param bean
	 * @param list
	 * @return
	 */
	public String saveFileFondsno(FilelendingBean bean,List<FileLendingDetailBean> list);
	
	/**
	 * 归还
	 *<b>Summary: </b>
	 * givebackDetail(归还)
	 * @param list
	 * @return
	 */
	public boolean givebackDetail(List<FileLendingDetailBean> list);
	/**
	 * 
	 *<b>Summary: </b>
	 * borrowOut(请用一句话描述这个方法的作用)
	 * @return
	 */
	public String borrowOut(String idList,String docList,String userId,String userName,String dateList);
	/**
	 * 场馆内阅读
	 *<b>Summary: </b>
	 * borrowOutAndBack(请用一句话描述这个方法的作用)
	 * @return
	 */
	public String borrowOutAndBack(String idList,String docList,String userId,String userName);
	/**
	 * 
	 *<b>Summary: </b>
	 * callUserForFileBackById(催还)手机短信，消息
	 * @param ids
	 * @param contentStr
	 * @param sendUserName
	 * @return
	 */
	public boolean callUserForFileBackById(String ids,String contentStr,String sendUserId,String sendUserName,boolean isDX,boolean isXX);
	
	/**
	 * 删除明细
	 *<b>Summary: </b>
	 * delDetailBeanByIds(删除明细)
	 * @param bean
	 * @return
	 */
	public boolean deleteFlow(String ids);
}

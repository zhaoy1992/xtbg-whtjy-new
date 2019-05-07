package com.chinacreator.xtbg.core.vote.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean;
import com.chinacreator.xtbg.core.vote.entity.VoteUserContorlBean;

/**
 * 
 *<p>
 * Title:VotePaperDao.java
 * </p>
 *<p>
 * Description:网上投票管理dao
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-13
 */
public interface VotePaperDao {
	/**
	 * 
	 *<b>Summary: 根据条件查询得到问卷的的分页对象</b> findPaginBean(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            查询条件
	 * @param sortName
	 *            排序字段名
	 * @param sortOrder
	 *            升序或降序
	 * @param offset
	 *            每页记录数
	 * @param maxPagesize
	 *            最大页数
	 * @return 分页对象
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public PagingBean findPaginBean(OAVotePaperBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

	/**
	 * 
	 *<b>Summary: 获得所有试卷类型</b> findListPaperType(请用一句话描述这个方法的作用)
	 * 
	 * @return List数据集合
	 * @throws Exception
	 */
	public List<?> findListPaperType() throws Exception;

	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个XtDbBaseBean,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean
	 *            底层持久对象
	 * @return XtDbBaseBean
	 * @throws Exception
	 */
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean) throws Exception;

	/**
	 * 
	 *<b>Summary:根据试卷id列表删除回答表数据 </b> deleteAnswerByPaper(请用一句话描述这个方法的作用)
	 * 
	 * @param ids
	 *            试卷id以,拼接
	 * @throws Exception
	 */
	public void deleteAnswerByPaper(String ids,Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: 根据试卷id列表删除选项表</b> deleteOptionByPaper(请用一句话描述这个方法的作用)
	 * 
	 * @param ids
	 *            试卷id以,拼接
	 * @throws Exception
	 */
	public void deleteOptionByPaper(String ids,Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:根据问卷id和userId列表批量插入被评测人员信息 </b> insert(请用一句话描述这个方法的作用)
	 * 
	 * @param paperId
	 *            问卷id
	 * @param userIds
	 *            用户id列表
	 * @throws SQLException
	 */
	public void insertEvalList(String paperId, String userIds,Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:根据问卷id和userId列表批量插入答题人员信息 </b> insert(请用一句话描述这个方法的作用)
	 * 
	 * @param paperId
	 *            问卷id
	 * @param userIds
	 *            用户id列表
	 * @throws SQLException
	 */
	public void insertUserContorlList(String paperId, String userIds,
			Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary: 根据条件查询得到问卷对应的问题列表数据</b> findPaginBean(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            查询条件
	 * @param sortName
	 *            排序字段名
	 * @param sortOrder
	 *            升序或降序
	 * @param offset
	 *            每页记录数
	 * @param maxPagesize
	 *            最大页数
	 * @return 分页对象
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public PagingBean findQuestionPaginBean(OAVoteQuestionBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 获得所有问题题型</b> findListQuestionType(请用一句话描述这个方法的作用)
	 * 
	 * @return List数据集合
	 * @throws Exception
	 */
	public List<?> findListQuestionType() throws Exception;

	/**
	 * 
	 *<b>Summary: 根据问题id查询问题选项</b> queryToListBean(请用一句话描述这个方法的作用)
	 * 
	 * @param questionId
	 *            问题id
	 * @return
	 * @throws Exception
	 */
	public List<? extends XtDbBaseBean> queryOptionById(String questionId)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 试卷答题情况统计</b> findAnswerPaginBean(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findAnswerPaginBean(VoteUserContorlBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 根据问卷id复制问卷</b> copyPaper(请用一句话描述这个方法的作用)
	 * 
	 * @param paperId
	 *            要复制的问卷id
	 * @param userId
	 *            要复制的问卷创建人id
	 * @param userName问卷创建人名
	 * @param orgId
	 *            问卷创建人机构id
	 * @param orgName
	 *            问卷创建人所属机构名
	 * @return 新的问卷id
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public String copyPaper(String paperId, String userId, String userName,
			String orgId, String orgName, Connection conn) throws SQLException;
	/**
	 * 
	 *<b>Summary: 根据问卷id查看出问答题的所回答的问题</b> copyPaper(请用一句话描述这个方法的作用)
	 * 
	 * @param paperId
	 *           问卷id
	 * @return 
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public Map<String,List<String>> getAnswerById(String paperId) throws SQLException;
	
	
}

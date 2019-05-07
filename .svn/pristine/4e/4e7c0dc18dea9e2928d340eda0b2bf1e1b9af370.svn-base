package com.chinacreator.xtbg.core.vote.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean;
import com.chinacreator.xtbg.core.vote.entity.VoteOptionBean;
import com.chinacreator.xtbg.core.vote.entity.VotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean;

/**
 * 
 *<p>Title:VoteViewDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-8
 */
public interface VoteViewDao {
	/**
	 * 
	*<b>Summary: </b>
	* getPaperInfo(根据PID获取问卷内容)
	* @param pID
	* @return
	 */
	public VotePaperBean getPaperInfo(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getQuestionList(根据PID获取该问卷的问题集合)
	* @param pID
	* @return
	 */
	public List<VoteQuestionBean> getQuestionList(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOptionBean(根据PID获取该问卷的问题选项集合)
	* @param pID
	* @return
	 */
	public List<VoteOptionBean> getOptionBean(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveQuesttionAnswer(保存答案信息)
	* @param answerList
	* @return
	* @throws Exception
	 */
	public boolean saveQuesttionAnswer(List<VoteQuestionAnswerBean> answerList, Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getVoteUserList(查询人员测评投票的被测评人员)
	* @param pID
	* @return
	* @throws Exception
	 */
	public List<VoteEvalUserBean> getVoteUserList(String pID)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getQuestionAnswerList(获取改问卷的用户答案信息)
	* @param pID
	* @param user_id
	* @return
	* @throws Exception
	 */
	public List<VoteQuestionAnswerBean> getQuestionAnswerList(String pID,String user_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delQuesttionAnswer(根据问卷ID，用户ID删除答案信息)
	* @param paper_id
	* @param user_id
	* @return
	 */
	public boolean delQuesttionAnswer(String paper_id, String user_id,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOptionBean(根据PID获取该问卷的问题选项统计信息)
	* @param pID
	* @return
	 */
	public List<VoteOptionBean> getOptionTotalBean(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getQuestionList(根据PID获取该问卷的问题统计集合)
	* @param pID
	* @return
	 */
	public List<VoteQuestionBean> getQuestionTotalList(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findPaginBean(查询可以填写的问卷测评列表)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findPaginBean(VotePaperBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateComplete(更新oa_vote_user_contorl表的状态位)
	* @param string
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean updateComplete(String status,String pid, String user_id, Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getQuestionAnswerList(获取改问卷的用户答案信息统计)
	* @param pID
	* @param user_id
	* @return
	* @throws Exception
	 */
	public List<VoteQuestionAnswerBean> getQuestionAnswerCountList(String pID) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findCompletePaginBean(查询已经完成的调查问卷信息列表)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findCompletePaginBean(VotePaperBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
}

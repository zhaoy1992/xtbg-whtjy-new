package com.chinacreator.xtbg.core.vote.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean;
import com.chinacreator.xtbg.core.vote.entity.VotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean;

/**
 * 
 *<p>Title:VoteViewService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-8
 */
public interface VoteViewService {
	/**
	 * 
	*<b>Summary: </b>
	* getPaperInfo(根据pID获取该问卷的题目，选项，配置信息。)
	* @return
	 */
	public VotePaperBean getPaperInfo(String pID,String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveVote(保存问卷信息)
	* @param request
	* @return
	 */
	public boolean saveVote(HttpServletRequest request);
	
	/**
	 * 
	*<b>Summary: </b>
	* getVoteUserList(查询人员测评投票的被测评人员，及其答案)
	* @param pID
	* @return
	 */
	public Map<VoteEvalUserBean,List<VoteQuestionAnswerBean>>  getVoteUserList(String pID, String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveVote(保存人员测评投票信息)
	* @param request
	* @return
	 */
	public boolean saveEvalVote(HttpServletRequest request);
	
	/**
	 * 
	*<b>Summary: </b>
	* getPaperInfo(根据pID获取该问卷的题目，选项，统计信息。)
	* @return
	 */
	public VotePaperBean getPaperTotalInfo(String pID,String user_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getEvalPaperTotalInfo(根据pID获取该测评的题目，选项，统计信息。)
	* @param pID
	* @return
	 */
	public VotePaperBean getEvalPaperTotalInfo(String pID);
	
	/**
	 * 
	*<b>Summary: </b>
	* getVoteUserList(获取人员评测的人员选项统计)
	* @param pID
	* @return
	 */
	public  Map<VoteEvalUserBean,List<VoteQuestionAnswerBean>>  getVoteUserCountList(String pID); 
}

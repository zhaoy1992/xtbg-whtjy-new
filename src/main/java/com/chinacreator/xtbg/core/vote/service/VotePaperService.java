package com.chinacreator.xtbg.core.vote.service;

import java.util.List;

import com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean;

/**
 * 
 *<p>
 * Title:VotePaperService.java
 * </p>
 *<p>
 * Description:问卷管理
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
public interface VotePaperService {
	/**
	 * 
	 *<b>Summary: 获得所有试卷类型</b> findListPaperType(请用一句话描述这个方法的作用)
	 * 
	 * @return List
	 */
	public List<?> findListPaperType();

	/**
	 * 
	 *<b>Summary: 根据id查询问卷信息</b> queryToOAVotePaperBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 * @return
	 */
	public OAVotePaperBean queryToOAVotePaperBean(String id);

	/**
	 * 
	 *<b>Summary: 插入问卷信息</b> insertOAVotePaper(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            问卷对象json字符串
	 * @return 是否插入成功
	 */
	public boolean insertOAVotePaper(String json);

	/**
	 * 
	 *<b>Summary: 更新问卷信息</b> updateOAVotePaper(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 *            问卷json字符串
	 * @return 是否更新成功标志
	 */
	public boolean updateOAVotePaper(String json);

	/**
	 * 
	 *<b>Summary:批量删除问卷信息 </b> deleteListByIds(请用一句话描述这个方法的作用)
	 * 
	 * @param paperIds
	 *            问卷id
	 * @return
	 */
	public boolean deleteListPaper(String paperIds);

	/**
	 * 
	 *<b>Summary:批量删除问题信息 </b> deleteListQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param paperIds
	 *            问题id字符串
	 * @return
	 */
	public boolean deleteListQuestion(String questionIds);

	/**
	 * 
	 *<b>Summary: 获得所有问题题型</b> findListQuestionType(请用一句话描述这个方法的作用)
	 * 
	 * @return List数据集合
	 * @throws Exception
	 */
	public List<?> findListQuestionType();

	/**
	 * 
	 *<b>Summary: 根据id查询问题对象</b> queryToQuestionBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            问题id
	 * @return 问题bean对象
	 */
	public OAVoteQuestionBean queryToQuestionBean(String id);

	/**
	 * 
	 *<b>Summary:插入问题 </b> insertQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 * @return
	 */
	public boolean insertQuestion(String json);

	/**
	 * 
	 *<b>Summary:更新问题 </b> insertQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 * @return
	 */
	public boolean updateQuestion(String json);

	/**
	 * 
	 *<b>Summary:复制问卷 </b> copyPaper(请用一句话描述这个方法的作用)
	 * 
	 * @param paperId
	 *            要被复制的问卷id
	 * @param userId
	 *            执行复制操作的人员id
	 * @param userName
	 *            执行复制操作的人员名
	 * @return 复制后新的问卷的id
	 */
	public String copyPaper(String paperId, String userId, String userName,
			String orgId, String orgName);
}

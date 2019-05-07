package com.chinacreator.xtbg.core.vote.service.impl;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.VoteViewDao;
import com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean;
import com.chinacreator.xtbg.core.vote.entity.VoteOptionBean;
import com.chinacreator.xtbg.core.vote.entity.VotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean;
import com.chinacreator.xtbg.core.vote.service.VoteViewService;

/**
 * 
 *<p>
 * Title:VoteViewServiceImpl.java
 * </p>
 *<p>
 * Description:
 * </p>
 *<p>
 * Copyright:Copyright (c) 2010
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author shuqi.liu
 *@version 1.0 2013-5-8
 */
public class VoteViewServiceImpl implements VoteViewService {
	private static final Logger LOG = Logger
			.getLogger(VoteViewServiceImpl.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getPaperInfo
	 * 
	 * @param pID
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#getPaperInfo(java.lang.String)
	 */
	@Override
	public VotePaperBean getPaperInfo(String pID, String user_id) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
		.getApplicationContext().getBean("voteViewDaoImpl"); 
		VotePaperBean votePaperBean = new VotePaperBean();
		try {
			votePaperBean = dao.getPaperInfo(pID);// 查询出问卷信息
			List<VoteQuestionBean> voteQuestionBeanList = dao
					.getQuestionList(pID);// 查询出问卷的所有问题
			List<VoteOptionBean> voteOptionBeanList = dao.getOptionBean(pID);// 查询出问卷所有问题的所有选项
			List<VoteQuestionAnswerBean> VoteQuestionAnswerList = dao
					.getQuestionAnswerList(pID, user_id);
			List<VoteQuestionBean> voteQuestionBeanLists = new ArrayList<VoteQuestionBean>();
			for (VoteQuestionBean voteQuestionBean : voteQuestionBeanList) { // 上面将选项一并查出，减少数据库访问次数，在这里将问卷>问题>选项进行重新封装。
				String questionId = voteQuestionBean.getId();
				List<VoteOptionBean> voteOptionBeanLists = new ArrayList<VoteOptionBean>();
				for (VoteOptionBean voteOptionBean : voteOptionBeanList) {
					if (voteOptionBean.getQuestion_id().equals(questionId)) {
						voteOptionBeanLists.add(voteOptionBean);
					}
				}
				if (VoteQuestionAnswerList.size() > 0) {// 如果查询出了答案，就将该用户填写过的答案封装到BEAN里
					List<String> answer = new ArrayList<String>();
					for (VoteQuestionAnswerBean voteQuestionAnswerBean : VoteQuestionAnswerList) {
						if (voteQuestionAnswerBean.getQuestion_id().equals(
								questionId)) {
							if (Constant.DUOXUANTI.equals(voteQuestionBean
									.getType_id())
									|| Constant.DANXUANTI
											.equals(voteQuestionBean
													.getType_id())) {
								answer
										.add(voteQuestionAnswerBean
												.getSelectid());
							} else {
								answer.add(voteQuestionAnswerBean
										.getAnswer_content());
							}
						}
					}
					if (answer.size() > 0) {
						voteQuestionBean.setAnswerList(answer);
					}
				}

				voteQuestionBean.setVoteOptionBeanList(voteOptionBeanLists);
				voteQuestionBeanLists.add(voteQuestionBean);
			}
			votePaperBean.setVoteQuestionBeanList(voteQuestionBeanLists);
		} catch (Exception e) {
			LOG.error("获取问卷配置信息失败" + e.getMessage(), e);
		}
		return votePaperBean;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveVote
	 * 
	 * @param request
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#saveVote(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public boolean saveVote(HttpServletRequest request) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
				.getApplicationContext().getBean("voteViewDaoImpl");
		List<VoteQuestionAnswerBean> answerList = new ArrayList<VoteQuestionAnswerBean>();
		Connection conn = null;
		boolean flag = true;

		try {
			conn = DbManager.getInstance().getTransactionConnection();
			request.setCharacterEncoding("UTF-8");
			String paper_id = request.getParameter("paper_id");
			String user_id = request.getParameter("user_id");
			String action = request.getParameter("action");
			String question_id = "";

			VotePaperBean votePaperBean = this.getPaperInfo(paper_id, user_id);// 获取配置信息
			for (VoteQuestionBean voteQuestionBean : votePaperBean
					.getVoteQuestionBeanList()) {
				question_id = voteQuestionBean.getId();
				if (Constant.DANXUANTI.equals(voteQuestionBean.getType_id())) {// 如果是单选
					VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean(
							user_id, paper_id, question_id);
					String value = request.getParameter(voteQuestionBean
							.getId());
					if (StringUtil.isBlank(value)) {
						continue;
					}
					voteQuestionAnswerBean.setSelectid(value);
					answerList.add(voteQuestionAnswerBean);
				} else if (Constant.DUOXUANTI.equals(voteQuestionBean
						.getType_id())) {// 多选
					String[] values = request
							.getParameterValues(voteQuestionBean.getId());
					if (values == null || values.length <= 0) {
						continue;
					}
					for (String value : values) {
						VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean(
								user_id, paper_id, question_id);
						voteQuestionAnswerBean.setSelectid(value);
						answerList.add(voteQuestionAnswerBean);
					}
				} else {// 其他
					VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean(
							user_id, paper_id, question_id);
					String value = request.getParameter(voteQuestionBean
							.getId());
					if (StringUtil.isBlank(value)) {
						continue;
					}
					voteQuestionAnswerBean.setAnswer_content(value);
					answerList.add(voteQuestionAnswerBean);
				}
			}
			flag = flag & dao.delQuesttionAnswer(paper_id, user_id,conn);// 删除信息
			flag = flag & dao.saveQuesttionAnswer(answerList, conn);// 保存信息
			if (Constant.TIJIAO.equals(action)) {// 如果是提交，那么还将该用户的填写状态改变
				flag = flag
						& dao.updateComplete("1", votePaperBean.getId(),
								user_id, conn);// 将用户是否提交状态改为已提交
			}
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("保存问卷信息失败：" + e.getMessage(), e);
		}
		return flag;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getVoteUserList
	 * 
	 * @param pID
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#getVoteUserList(java.lang.String)
	 */
	@Override
	public Map<VoteEvalUserBean, List<VoteQuestionAnswerBean>> getVoteUserList(
			String pID, String user_id) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
				.getApplicationContext().getBean("voteViewDaoImpl");
		List<VoteEvalUserBean> voteEvalUserList = null;
		List<VoteQuestionAnswerBean> voteQuestionAnswerList = null;
		Map<VoteEvalUserBean, List<VoteQuestionAnswerBean>> userQuestionList = new LinkedHashMap<VoteEvalUserBean, List<VoteQuestionAnswerBean>>();
		try {
			voteEvalUserList = dao.getVoteUserList(pID);// 用户列表
			if (!StringUtil.isBlank(user_id)) {
				voteQuestionAnswerList = dao
						.getQuestionAnswerList(pID, user_id);// 答案列表
				for (VoteEvalUserBean voteEvalUserBean : voteEvalUserList) {
					List<VoteQuestionAnswerBean> voteUserAnswerList = new ArrayList<VoteQuestionAnswerBean>();
					if (voteQuestionAnswerList != null
							&& voteQuestionAnswerList.size() > 0) {
						for (VoteQuestionAnswerBean voteUserQuestionBean : voteQuestionAnswerList) {
							if (voteUserQuestionBean.getEval_user_id().equals(
									voteEvalUserBean.getUser_id())) {
								voteUserAnswerList.add(voteUserQuestionBean);
							}
						}
					}
					userQuestionList.put(voteEvalUserBean, voteUserAnswerList);
				}
			}
		} catch (Exception e) {
			LOG.error("获取用户信息失败：" + e.getMessage(), e);
		}
		return userQuestionList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveEvalVote
	 * 
	 * @param request
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#saveEvalVote(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public boolean saveEvalVote(HttpServletRequest request) {
		
		List<VoteQuestionAnswerBean> answerList = new ArrayList<VoteQuestionAnswerBean>();
		Connection conn = null;
		boolean flag = true;
		try {			
			conn = DbManager.getInstance().getTransactionConnection();
			VoteViewDao dao = (VoteViewDao) LoadSpringContext
			.getApplicationContext().getBean("voteViewDaoImpl");
			request.setCharacterEncoding("UTF-8");
			String paper_id = request.getParameter("paper_id");// 问卷ID
			String user_id = request.getParameter("user_id");
			String action = request.getParameter("action");
			String question_id = "";
			String eval_user_id = "";
			VotePaperBean votePaperBean = this.getPaperInfo(paper_id, user_id);// 获取配置信息
			List<VoteEvalUserBean> VoteEvalUserList = dao
					.getVoteUserList(paper_id);

			for (VoteEvalUserBean voteEvalUserBean : VoteEvalUserList) {
				eval_user_id = voteEvalUserBean.getUser_id();
				for (VoteQuestionBean voteQuestionBean : votePaperBean
						.getVoteQuestionBeanList()) {
					question_id = voteQuestionBean.getId();
					VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean(
							user_id, paper_id, question_id);
					String value = request.getParameter(eval_user_id + "#"
							+ question_id);
					if (StringUtil.isBlank(value)) {

						continue;
					}
					voteQuestionAnswerBean.setSelectid(value);
					voteQuestionAnswerBean.setEval_user_id(eval_user_id);
					answerList.add(voteQuestionAnswerBean);
				}
			}
			flag = flag & dao.delQuesttionAnswer(paper_id, user_id,conn);// 删除信息
			flag = flag & dao.saveQuesttionAnswer(answerList, conn);// 保存答案信息
			if (Constant.TIJIAO.equals(action)) {// 如果是提交，那么还将该用户的填写状态改变
				flag = flag
						& dao.updateComplete("1", votePaperBean.getId(),
								user_id, conn);// 将用户是否提交状态改为已提交
			}
			DbManager.closeTransactionConnection(conn, true);
			
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("保存人员测评投票信息失败：" + e.getMessage(), e);
		}
		return flag;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getPaperTotalInfo
	 * 
	 * @param pID
	 * @param user_id
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#getPaperTotalInfo(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public VotePaperBean getPaperTotalInfo(String pID, String user_id) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
				.getApplicationContext().getBean("voteViewDaoImpl");
		VotePaperBean votePaperBean = new VotePaperBean();
		DecimalFormat format = new DecimalFormat("#0.0");
		try {
			votePaperBean = dao.getPaperInfo(pID);// 查询出问卷信息
			List<VoteQuestionBean> voteQuestionBeanList = dao
					.getQuestionTotalList(pID);// 查询出问卷的所有问题
			List<VoteOptionBean> voteOptionBeanList = dao
					.getOptionTotalBean(pID);// 查询出问卷所有问题的所有选项
			List<VoteQuestionBean> voteQuestionBeanLists = new ArrayList<VoteQuestionBean>();
			for (VoteQuestionBean voteQuestionBean : voteQuestionBeanList) { // 上面将选项一并查出，减少数据库访问次数，在这里将问卷>问题>选项进行重新封装。
				String questionId = voteQuestionBean.getId();
				List<VoteOptionBean> voteOptionBeanLists = new ArrayList<VoteOptionBean>();
				StringBuffer columnXmlStr = new StringBuffer(
				"<graph decimalPrecision='1' numberSuffix='%25'>");// 此处定义统计柱状图XMLSTR
		StringBuffer pieXmlStr = new StringBuffer(
				"<graph decimalPrecision='1' numberSuffix='%25'>");// 此处定义统计饼状图XMLSTR
		for (VoteOptionBean voteOptionBean : voteOptionBeanList) {
			if (voteOptionBean.getQuestion_id().equals(questionId)) {
				if("0".equals(voteQuestionBean.getAnswerCount())){
					
				}else{
					double baifenbi = ((Double.parseDouble(voteOptionBean
							.getSelectCount()) / Double
							.parseDouble(voteQuestionBean.getAnswerCount())) * 100);
					String baifenbiStr = format.format(baifenbi).toString();
					columnXmlStr.append("<set name='").append(
							voteOptionBean.getContent())
							.append("' value='").append(baifenbiStr)
							.append("' color='AFD8F8'/>");
					pieXmlStr.append("<set name='").append(
							voteOptionBean.getContent())
							.append("' value='").append(baifenbiStr)
							.append("'/>");
					
				}
				voteOptionBeanLists.add(voteOptionBean);
					}
				}
				columnXmlStr.append("</graph>");
				pieXmlStr.append("</graph>");
				voteQuestionBean.setColumnXmlStr(columnXmlStr.toString());
				voteQuestionBean.setPieXmlStr(pieXmlStr.toString());
				voteQuestionBean.setVoteOptionBeanList(voteOptionBeanLists);
				voteQuestionBeanLists.add(voteQuestionBean);
			}
			votePaperBean.setVoteQuestionBeanList(voteQuestionBeanLists);
		} catch (Exception e) {
			LOG.error("获取问卷配置信息失败" + e.getMessage(), e);
		}
		return votePaperBean;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getEvalPaperTotalInfo
	 * 
	 * @param pID
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#getEvalPaperTotalInfo(java.lang.String)
	 */
	@Override
	public VotePaperBean getEvalPaperTotalInfo(String pID) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
				.getApplicationContext().getBean("voteViewDaoImpl");
		VotePaperBean votePaperBean = new VotePaperBean();
		try {
			votePaperBean = dao.getPaperInfo(pID);// 查询出问卷信息
			List<VoteQuestionBean> voteQuestionBeanList = dao
					.getQuestionTotalList(pID);// 查询出问卷的所有问题
			List<VoteOptionBean> voteOptionBeanList = dao
					.getOptionTotalBean(pID);// 查询出问卷所有问题的所有选项
			List<VoteQuestionBean> voteQuestionBeanLists = new ArrayList<VoteQuestionBean>();
			for (VoteQuestionBean voteQuestionBean : voteQuestionBeanList) { // 上面将选项一并查出，减少数据库访问次数，在这里将问卷>问题>选项进行重新封装。
				String questionId = voteQuestionBean.getId();
				List<VoteOptionBean> voteOptionBeanLists = new ArrayList<VoteOptionBean>();
				for (VoteOptionBean voteOptionBean : voteOptionBeanList) {
					if (voteOptionBean.getQuestion_id().equals(questionId)) {
						voteOptionBeanLists.add(voteOptionBean);
					}
				}
				voteQuestionBean.setVoteOptionBeanList(voteOptionBeanLists);
				voteQuestionBeanLists.add(voteQuestionBean);
			}
			votePaperBean.setVoteQuestionBeanList(voteQuestionBeanLists);
		} catch (Exception e) {
			LOG.error("获取人员测评配置信息失败" + e.getMessage(), e);
		}
		return votePaperBean;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getVoteUserCountList
	 * 
	 * @param pID
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VoteViewService#getVoteUserCountList(java.lang.String)
	 */
	@Override
	public Map<VoteEvalUserBean, List<VoteQuestionAnswerBean>> getVoteUserCountList(
			String pID) {
		VoteViewDao dao = (VoteViewDao) LoadSpringContext
				.getApplicationContext().getBean("voteViewDaoImpl");
		List<VoteEvalUserBean> voteEvalUserList = null;
		List<VoteQuestionAnswerBean> voteQuestionAnswerList = null;
		Map<VoteEvalUserBean, List<VoteQuestionAnswerBean>> userCountList = new LinkedHashMap<VoteEvalUserBean, List<VoteQuestionAnswerBean>>();
		try {
			voteEvalUserList = dao.getVoteUserList(pID);// 用户列表

			voteQuestionAnswerList = dao.getQuestionAnswerCountList(pID);// 答案列表
			for (VoteEvalUserBean voteEvalUserBean : voteEvalUserList) {
				List<VoteQuestionAnswerBean> voteUserAnswerMapList = new ArrayList<VoteQuestionAnswerBean>();
				if (voteQuestionAnswerList != null
						&& voteQuestionAnswerList.size() > 0) {
					for (VoteQuestionAnswerBean voteUserQuestionBean : voteQuestionAnswerList) {
						if (voteUserQuestionBean.getEval_user_id().equals(
								voteEvalUserBean.getUser_id())) {
							voteUserAnswerMapList.add(voteUserQuestionBean);
						}
					}
				}
				userCountList.put(voteEvalUserBean, voteUserAnswerMapList);
			}

		} catch (Exception e) {
			LOG.error("获取用户信息失败：" + e.getMessage(), e);
		}
		return userCountList;
	}

}

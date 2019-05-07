package com.chinacreator.xtbg.core.vote.service.impl;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.MessageSendDao;
import com.chinacreator.xtbg.core.vote.dao.VotePaperDao;
import com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean;
import com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean;
import com.chinacreator.xtbg.core.vote.entity.VoteOptionBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean;
import com.chinacreator.xtbg.core.vote.entity.VoteUserContorlBean;
import com.chinacreator.xtbg.core.vote.service.VotePaperService;

/**
 * 
 *<p>
 * Title:VotePaperServiceImpl.java
 * </p>
 *<p>
 * Description:问卷管理service接口实现
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
public class VotePaperServiceImpl implements VotePaperService {
	private static final Logger LOG = Logger
			.getLogger(VotePaperServiceImpl.class);
	// 公用的dao接口
	private BaseDao dao;
	// 网上投票的dao接口
	private VotePaperDao paperDao;

	public VotePaperServiceImpl() {
		try {
			dao = (BaseDao) LoadSpringContext.getApplicationContext().getBean(
					"votePaperDaoImpl");

			paperDao = (VotePaperDao) dao;

		} catch (Exception e) {
			LOG.error("构造器出现异常", e);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findListPaperType
	 * 
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VotePaperService#findListPaperType()
	 */
	@Override
	public List<?> findListPaperType() {
		try {
			return paperDao.findListPaperType();
		} catch (Exception e) {
			LOG.error("查询问卷类型信息出现异常", e);
			return null;
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 queryToOAVotePaperBean
	 * 
	 * @param id
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VotePaperService#queryToOAVotePaperBean(java.lang.String)
	 */
	@Override
	public OAVotePaperBean queryToOAVotePaperBean(String id) {
		// 创建问卷bean对象，必须设置主键及表名
		OAVotePaperBean paper = new OAVotePaperBean(id);
		try {
			paper = (OAVotePaperBean) paperDao.queryToBean(paper);
			return paper;
		} catch (Exception e) {
			LOG.error("根据id查询问卷对象出现异常", e);
			return paper;
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 insertOAVotePaper
	 * 
	 * @param json
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VotePaperService#insertOAVotePaper(java.lang.String)
	 */
	@Override
	public boolean insertOAVotePaper(String json) {
		Connection conn = null;		
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为bean
			OAVotePaperBean bean = convertToBean(json, OAVotePaperBean.class);
			// id赋初值
			// bean.setId(StringUtil.getUUID());
			// 将字符串时间转换为Timestamp
			bean.setCreatdate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getCreatdate())));
			bean.setStartdate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getStartdate())));
			bean.setEnddate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getEnddate())));
			// 插入问卷
			dao.insert(bean, conn);

			// 批量插入答题人员信息
			insertVoteUserContorlBean(bean, conn);

			// 插入被测评人员信息
			insertEvalList(bean, conn);

			// 只有是发布，才发送短信
			if (Constant.YIFABU.equals(bean.getStauts())
					&& Constant.SEND.equals(StringUtil
							.deNull(bean.getIs_send()))){
				// 发送短信
				sendMessage(bean, conn);
				//发送站内消息
				sendMessage4sys(bean, conn);
			}

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("插入问卷信息出现异常", e);
			return false;
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateOAVotePaper
	 * 
	 * @param json
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VotePaperService#updateOAVotePaper(java.lang.String)
	 */
	public boolean updateOAVotePaper(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为bean
			OAVotePaperBean bean = convertToBean(json, OAVotePaperBean.class);

			// 将字符串时间转换为Timestamp
			bean.setCreatdate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getCreatdate())));
			bean.setStartdate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getStartdate())));
			bean.setEnddate(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getEnddate())));
			
			// 执行插入语句
			dao.update(bean, conn);

			// 批量插入答题人员信息
			insertVoteUserContorlBean(bean, conn);

			// 插入被测评人员信息
			insertEvalList(bean, conn);

			// 只有是发布，才发送短信
			if (Constant.YIFABU.equals(bean.getStauts())&& Constant.SEND.equals(StringUtil
					.deNull(bean.getIs_send()))) {
				// 发送短信
				sendMessage(bean, conn);
				//发送站内消息
				sendMessage4sys(bean, conn);
			}
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("更新问卷信息出现异常", e);
			
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary:批量插入答题人员信息 </b> insertVoteUserContorlBean(请用一句话描述这个方法的作用)
	 * 
	 * @param paper
	 *            问卷
	 * @throws Exception
	 */
	private void insertVoteUserContorlBean(OAVotePaperBean paper,
			Connection conn) throws Exception {
		if (null == paper || StringUtil.nullOrBlank(paper.getId())) {
			return;
		}

		// 插入前先删除数据相应的对答题人员数据
		dao.deleteListById(new VoteUserContorlBean().setDeleteKey("PAPER_ID"),
				conn, paper.getId());

		// 插入
		paperDao.insertUserContorlList(paper.getId(), paper.getPeople_ids(),
				conn);

	}

	/**
	 * 
	 *<b>Summary:批量插入被测评人员信息 </b> insertVoteUserContorlBean(请用一句话描述这个方法的作用)
	 * 
	 * @param paper
	 *            问卷
	 * @throws Exception
	 */
	private void insertEvalList(OAVotePaperBean paper, Connection conn)
			throws Exception {

		if (null == paper || StringUtil.nullOrBlank(paper.getId())) {
			return;
		}
		// 插入前先删除数据相应的对答题人员数据
		dao.deleteListById(new VoteEvalUserBean().setDeleteKey("paper_id"),
				conn, paper.getId());
		// 如果问卷是人员测评，则进行批量插入操作
		if (Constant.RYCPID.equals(paper.getPapaer_type())) {
			// 插入
			paperDao.insertEvalList(paper.getId(), paper.getEval_userids(),
					conn);
		}
	}

	/**
	 * 
	 *<b>Summary:批量删除问卷信息 </b> deleteListByIds(请用一句话描述这个方法的作用)
	 * 
	 * @param paperIds
	 *            问卷id
	 * @return
	 */
	public boolean deleteListPaper(String paperIds) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 由于存在外键关联，第一步删除回答表数据
			paperDao.deleteAnswerByPaper(paperIds, conn);

			// 第二步删除选项表数据
			paperDao.deleteOptionByPaper(paperIds, conn);

			// 第三步删除问题表数据
			dao.deleteListById(new OAVoteQuestionBean()
					.setDeleteKey("paper_id"), conn, paperIds);

			// 删除人员权限表数据（投票人员）
			dao.deleteListById(new VoteUserContorlBean()
					.setDeleteKey("paper_id"), conn, paperIds);

			// 删除问卷对应的被测评人员信息
			dao.deleteListById(new VoteEvalUserBean().setDeleteKey("paper_id"),
					conn, paperIds);

			// 删除问卷
			dao.deleteListById(new OAVotePaperBean(), conn, paperIds);
			
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("批量删除问卷信息出现异常", e);
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary:批量删除问题信息 </b> deleteListQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param paperIds
	 *            问题id字符串
	 * @return
	 */
	public boolean deleteListQuestion(String questionIds) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 由于存在外键关联，第一步删除回答表数据
			dao.deleteListById(new VoteQuestionAnswerBean()
					.setDeleteKey("question_id"), conn, questionIds);

			// 第二步删除选项表数据
			dao.deleteListById(
					new VoteOptionBean().setDeleteKey("question_id"), conn,
					questionIds);

			// 第三步删除问题表数据
			dao.deleteListById(new OAVoteQuestionBean().setDeleteKey("id"),
					conn, questionIds);

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("批量删除问题出现异常", e);
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary: 获得所有问题题型</b> findListQuestionType(请用一句话描述这个方法的作用)
	 * 
	 * @return List数据集合
	 * @throws Exception
	 */
	public List<?> findListQuestionType() {
		try {
			return paperDao.findListQuestionType();
		} catch (Exception e) {
			LOG.error("查询问题题型出现异常", e);
			return null;
		}
	}

	/**
	 * 
	 *<b>Summary: 根据id查询问题对象</b> queryToQuestionBean(请用一句话描述这个方法的作用)
	 * 
	 * @param id
	 *            问题id
	 * @return 问题bean对象
	 */
	@SuppressWarnings("unchecked")
	public OAVoteQuestionBean queryToQuestionBean(String id) {
		// 创建问卷bean对象，必须设置主键及表名
		OAVoteQuestionBean bean = new OAVoteQuestionBean(id);
		try {
			// 根据id查询问题
			bean = (OAVoteQuestionBean) paperDao.queryToBean(bean);
			// 根据id查询问题选项
			bean.setOptionList((List<VoteOptionBean>) paperDao
					.queryOptionById(id));
			return bean;
		} catch (Exception e) {
			LOG.error("根据id查询问题对象出现异常", e);
			return bean;
		}
	}

	/**
	 * 
	 *<b>Summary:插入问题 </b> insertQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 * @return
	 */
	public boolean insertQuestion(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 将字符串转换为bean
			OAVoteQuestionBean bean = convertToBean(json,
					OAVoteQuestionBean.class);

			// 插入问卷
			dao.insert(bean,conn);

			// 删除所有选项
			dao.deleteListById(
					new VoteOptionBean().setDeleteKey("question_id"),conn, bean
							.getId());
			// 插入问题选项
			if (null != bean.getOptionList() && !bean.getOptionList().isEmpty()) {
				for (VoteOptionBean optionBean : bean.getOptionList()) {
					// id不存在则生成一个id
					if (StringUtil.nullOrBlank(optionBean.getId())) {
						optionBean.setId(StringUtil.getUUID());
					}
					dao.insert(optionBean,conn);
				}
			}

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("插入问题出现异常", e);
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary:更新问题 </b> insertQuestion(请用一句话描述这个方法的作用)
	 * 
	 * @param json
	 * @return
	 */
	public boolean updateQuestion(String json) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 将字符串转换为bean
			OAVoteQuestionBean bean = convertToBean(json,
					OAVoteQuestionBean.class);

			// 插入问卷
			dao.update(bean,conn);

			// 删除所有选项
			dao.deleteListById(
					new VoteOptionBean().setDeleteKey("question_id"),conn, bean
							.getId());
			// 插入问题选项
			if (null != bean.getOptionList() && !bean.getOptionList().isEmpty()) {
				for (VoteOptionBean optionBean : bean.getOptionList()) {
					// id不存在则生成一个id
					if (StringUtil.nullOrBlank(optionBean.getId())) {
						optionBean.setId(StringUtil.getUUID());
					}
					dao.insert(optionBean,conn);
				}
			}

			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary:处理json字符串，最后转换为bean </b> convertToBean(请用一句话描述这个方法的作用)
	 * 
	 * @param <T>
	 *            bean
	 * @param json
	 *            json字符串
	 * @param c
	 *            class对象
	 * @return T的实例对象
	 */
	private <T> T convertToBean(String json, Class<T> clazz) {
		json = DataControlUtil.replaceStr(json);
		json = Escape.unescape(json);
		// 将json数据转换成bean
		return JSONObject.parseObject(json, clazz);
	}

	/**
	 * 
	 *<b>Summary: 发送短信</b> sendMessage(请用一句话描述这个方法的作用)
	 * 
	 * @param bean
	 *            问卷
	 */
	@SuppressWarnings("unchecked")
	private void sendMessage(OAVotePaperBean bean, Connection conn) {
		try {
			// 短信接口
			MessageSendDao<OAVotePaperBean> sendDao = (MessageSendDao<OAVotePaperBean>) LoadSpringContext
					.getApplicationContext().getBean("messageSendDaoImplYMJ");

			// 用户选择了发送短信，且相应的接口实现类存在，则发送短信
			if (Constant.SEND.equals(StringUtil.deNull(bean.getIs_send()))
					&& null != sendDao) {
				// 发送短信操作
				sendDao.sendMsg(bean, conn);
			}
		} catch (Exception e) {
			// 不管短信发送是否成功，但是要保存问卷新建成功,处理掉异常
			LOG.error("发送短信失败", e);
		}
	}
	/**
	 * 
	*<b>Summary:发送站内消息 </b>
	* sendMessage4sys()
	 */
	private void sendMessage4sys(OAVotePaperBean bean, Connection conn){
		try {			
			// 发送消息
			MessageCenterService mservice = new MessageCenterServiceImpl();
			//前台强制要求了必须选择投票人员，故暂时不需要考虑未选择投票人员则所有人都要投票的情况
			mservice.sendMessage(bean.getUser_id(), Arrays
					.asList(bean.getPeople_ids().split("\\,")), bean
					.getMessage_content(),conn);	
		} catch (Exception e) {
			// 不管短信发送是否成功，但是要保存问卷新建成功,处理掉异常
			LOG.error("发送站内消息失败", e);					
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 copyPaper
	 * 
	 * @param paperId
	 * @param userId
	 * @param userName
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.service.VotePaperService#copyPaper(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public String copyPaper(String paperId, String userId, String userName,
			String orgId, String orgName) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String id = paperDao.copyPaper(paperId, userId, userName, orgId,
					orgName, conn);
			// 提交事务，关闭连接
			DbManager.closeTransactionConnection(conn, true);
			return id;
		} catch (Exception e) {
			// 回滚事务，关闭连接
			DbManager.closeTransactionConnection(conn, false);
			LOG.error("复制问卷失败", e);
			return "";
		}
	}
}

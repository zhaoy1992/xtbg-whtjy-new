package com.chinacreator.xtbg.core.vote.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.VoteViewDao;
import com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean;
import com.chinacreator.xtbg.core.vote.entity.VoteOptionBean;
import com.chinacreator.xtbg.core.vote.entity.VotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean;
import com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:VoteViewDaoImpl.java
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
public class VoteViewDaoImpl implements VoteViewDao {

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getPaperInfo
	 * 
	 * @param pID
	 * @return
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getPaperInfo(java.lang.String)
	 */
	@Override
	public VotePaperBean getPaperInfo(String pID) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql
				.append(" select id,title,fu_title,stauts,direction,to_char(creatdate,'YYYY-MM-DD') creatdate,to_char(startdate,'YYYY-MM-DD') startdate,to_char(enddate,'YYYY-MM-DD') enddate,istop,org_id,org_name,user_id,user_name,papaer_type");
		sql.append(" from oa_vote_paper ");
		sql.append(" where id =?");
		PreparedDBUtil db = new PreparedDBUtil();
		VotePaperBean votePaperBean = new VotePaperBean();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			votePaperBean.setId(db.getString(i, "id"));
			votePaperBean.setTitle(db.getString(i, "title"));
			votePaperBean.setFu_title(db.getString(i, "fu_title"));
			votePaperBean.setStauts(db.getString(i, "stauts"));
			votePaperBean.setDirection(db.getString(i, "direction"));
			votePaperBean.setCreatdate(db.getString(i, "creatdate"));
			votePaperBean.setStartdate(db.getString(i, "startdate"));
			votePaperBean.setEnddate(db.getString(i, "enddate"));
			votePaperBean.setIstop(db.getString(i, "istop"));
			votePaperBean.setOrg_id(db.getString(i, "org_id"));
			votePaperBean.setOrg_name(db.getString(i, "org_name"));
			votePaperBean.setUser_id(db.getString(i, "user_id"));
			votePaperBean.setUser_name(db.getString(i, "user_name"));
			votePaperBean.setPapaer_type(db.getString(i, "papaer_type"));
		}
		return votePaperBean;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getQuestionList
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getQuestionList(java.lang.String)
	 */
	@Override
	public List<VoteQuestionBean> getQuestionList(String pID) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteQuestionBean> voteQuestionBeanList = new ArrayList<VoteQuestionBean>();

		sql
				.append(" select t.id,t.title,question_number,t.direction,t.answer,t.paper_id,s.code,t.order_no ");
		sql.append(" from oa_vote_question t ");
		sql.append(" left join oa_vote_question_type s on t.type_id = s.id ");
		sql.append(" where t.status='1' and t.paper_id =? order by t.order_no");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteQuestionBean voteQuestionBean = new VoteQuestionBean();
			voteQuestionBean.setId(db.getString(i, "id"));
			voteQuestionBean.setTitle(db.getString(i, "title"));
			voteQuestionBean.setDirection(db.getString(i, "direction"));
			voteQuestionBean.setAnswer(db.getString(i, "answer"));
			voteQuestionBean.setPaper_id(db.getString(i, "paper_id"));
			voteQuestionBean.setType_id(db.getString(i, "code"));
			voteQuestionBean.setOrder_no(db.getString(i, "order_no"));
			voteQuestionBean.setQuestion_number(db.getString(i, "question_number"));
			voteQuestionBeanList.add(voteQuestionBean);
		}
		return voteQuestionBeanList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getOptionBean
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getOptionBean(java.lang.String)
	 */
	@Override
	public List<VoteOptionBean> getOptionBean(String pID) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteOptionBean> voteOptionBeanList = new ArrayList<VoteOptionBean>();

		sql.append(" select id,question_id,option_code,content,check_max");
		sql
				.append(" from oa_vote_question_option where question_id in (select id from oa_vote_question where status='1' and  paper_id = ? ) order by option_code");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteOptionBean voteQuestionBean = new VoteOptionBean();
			voteQuestionBean.setId(db.getString(i, "id"));
			voteQuestionBean.setContent(db.getString(i, "content"));
			voteQuestionBean.setQuestion_id(db.getString(i, "question_id"));
			voteQuestionBean.setOption_code(db.getString(i, "option_code"));
			voteQuestionBean.setCheck_max(db.getString(i, "check_max"));
			voteOptionBeanList.add(voteQuestionBean);
		}
		return voteOptionBeanList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 saveQuesttionAnswer
	 * 
	 * @param answerList
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#saveQuesttionAnswer(java.util.List)
	 */
	@Override
	public boolean saveQuesttionAnswer(List<VoteQuestionAnswerBean> answerList,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i = 0;
		for (VoteQuestionAnswerBean voteQuestionAnswerBean : answerList) {
			String insertSql = "insert into oa_vote_question_answer(id,uesr_id,paper_id,question_id,eval_user_id,selectid,answer_content) values (?,?,?,?,?,?,?)";
			pdb.preparedInsert(insertSql);
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, voteQuestionAnswerBean.getUesr_id());
			pdb.setString(3, voteQuestionAnswerBean.getPaper_id());
			pdb.setString(4, voteQuestionAnswerBean.getQuestion_id());
			pdb.setString(5, voteQuestionAnswerBean.getEval_user_id());
			pdb.setString(6, voteQuestionAnswerBean.getSelectid());
			pdb.setString(7, voteQuestionAnswerBean.getAnswer_content());
			pdb.addPreparedBatch();
			i++;
		}
		// 批处理执行
		if (i > 0) {
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getVoteUserList
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getVoteUserList(java.lang.String)
	 */
	@Override
	public List<VoteEvalUserBean> getVoteUserList(String pID) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteEvalUserBean> voteEvalUserList = new ArrayList<VoteEvalUserBean>();

		sql
				.append(" select paper_id,user_id,user_name from oa_vote_eval_list where paper_id = ? order by order_no ");
		// TODO 加排序
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteEvalUserBean voteEvalUserBean = new VoteEvalUserBean();
			voteEvalUserBean.setUser_id(db.getString(i, "user_id"));
			voteEvalUserBean.setUser_name(db.getString(i, "user_name"));
			voteEvalUserList.add(voteEvalUserBean);
		}
		return voteEvalUserList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getQuestionAnswerList
	 * 
	 * @param pID
	 * @param user_id
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getQuestionAnswerList(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public List<VoteQuestionAnswerBean> getQuestionAnswerList(String pID,
			String user_id) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteQuestionAnswerBean> VoteQuestionAnswerList = new ArrayList<VoteQuestionAnswerBean>();
		sql
				.append(" select t.question_id, t.selectid, t.answer_content, t.eval_user_id from oa_vote_question_answer t where t.paper_id = ? and t.uesr_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.setString(2, user_id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean();
			voteQuestionAnswerBean.setQuestion_id(db
					.getString(i, "question_id"));
			voteQuestionAnswerBean.setSelectid(db.getString(i, "selectid"));
			voteQuestionAnswerBean.setAnswer_content(db.getString(i,
					"answer_content"));
			voteQuestionAnswerBean.setEval_user_id(db.getString(i,
					"eval_user_id"));
			VoteQuestionAnswerList.add(voteQuestionAnswerBean);
		}
		return VoteQuestionAnswerList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 delQuesttionAnswer
	 * 
	 * @param paper_id
	 * @param user_id
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#delQuesttionAnswer(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public boolean delQuesttionAnswer(String paper_id, String user_id,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql
				.append(" delete from oa_vote_question_answer where paper_id = ? and uesr_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedDelete(sql.toString());
		db.setString(1, paper_id);
		db.setString(2, user_id);
		db.executePrepared(conn);
		return true;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getOptionTotalBean
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getOptionTotalBean(java.lang.String)
	 */
	@Override
	public List<VoteOptionBean> getOptionTotalBean(String pID) throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteOptionBean> voteOptionBeanList = new ArrayList<VoteOptionBean>();

		sql
				.append(" select t.id,t.question_id,t.option_code,t.content,(select count(1) from oa_vote_question_answer v where v.selectid = t.id) as selectCount");
		sql
				.append(" from oa_vote_question_option t where t.question_id in (select id from oa_vote_question where status='1' and  paper_id = ?) order by t.option_code ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteOptionBean voteQuestionBean = new VoteOptionBean();
			voteQuestionBean.setId(db.getString(i, "id"));
			voteQuestionBean.setContent(db.getString(i, "content"));
			voteQuestionBean.setQuestion_id(db.getString(i, "question_id"));
			voteQuestionBean.setOption_code(db.getString(i, "option_code"));
			voteQuestionBean.setSelectCount(db.getString(i, "selectCount"));
			voteOptionBeanList.add(voteQuestionBean);
		}
		return voteOptionBeanList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getQuestionTotalList
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getQuestionTotalList(java.lang.String)
	 */
	@Override
	public List<VoteQuestionBean> getQuestionTotalList(String pID)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteQuestionBean> voteQuestionBeanList = new ArrayList<VoteQuestionBean>();

		sql.append(" select t.id,t.title,t.direction,t.answer,t.paper_id,s.code,t.order_no,(select count(1) from  oa_vote_question_answer v where v.question_id = t.id ) as answerCount ");
		sql.append(" from oa_vote_question t ");
		sql.append(" left join oa_vote_question_type s on t.type_id = s.id ");
		sql.append(" where t.status='1' and t.paper_id =? order by t.order_no");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteQuestionBean voteQuestionBean = new VoteQuestionBean();
			voteQuestionBean.setId(db.getString(i, "id"));
			voteQuestionBean.setTitle(db.getString(i, "title"));
			voteQuestionBean.setDirection(db.getString(i, "direction"));
			voteQuestionBean.setAnswer(db.getString(i, "answer"));
			voteQuestionBean.setPaper_id(db.getString(i, "paper_id"));
			voteQuestionBean.setType_id(db.getString(i, "code"));
			voteQuestionBean.setOrder_no(db.getString(i, "order_no"));
			voteQuestionBean.setAnswerCount(db.getString(i, "answerCount"));
			voteQuestionBeanList.add(voteQuestionBean);
		}
		return voteQuestionBeanList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPaginBean
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#findPaginBean(com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findPaginBean(VotePaperBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"select p.id, p.title, p.fu_title, p.stauts, p.direction, p.creatdate,to_char(p.startdate,'yyyy-mm-dd') as startdate,")
				.append(
						" to_char(p.enddate,'yyyy-MM-dd HH24:mi:ss') as enddate, p.istop, p.org_id, p.org_name, p.user_id, p.user_name,t.name as papaer_type,t.code as papaer_type_code, v.complete, decode(v.complete,'1','已完成','未完成') complete_name ")
				.append(
						" from oa_vote_paper p left join oa_vote_paper_type t on t.id = p.papaer_type ")
				.append(
						"left join oa_vote_user_contorl v on v.paper_id = p.id ")
				.append(
						" where p.stauts = '1' and v.user_id = ? and v.complete = '0' and sysdate between p.startdate and p.enddate");

		// 查询条件不为空则拼接查询条件
		if (!StringUtil.nullOrBlank(bean.getTitle())) {
			sql.append(" and p.title like '%" + bean.getTitle().trim() + "%'");
		}
		// 发起人
		if (!StringUtil.nullOrBlank(bean.getUser_name())) {
			sql.append(" and p.user_name like '%" + bean.getUser_name().trim()
					+ "%'");
		}
		// 发起时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStartdate()))) {
			sql.append(" and p.startdate  >= to_date('" + bean.getStartdate()
					+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");

		}
		// 发起时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnddate()))) {
			sql.append(" and p.startdate  <= to_date('" + bean.getEnddate()
					+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");

		}
		
		//问卷类型
		if(!StringUtil.nullOrBlank(bean.getPapaer_type())){
			sql.append(" and p.papaer_type='"+bean.getPapaer_type()+"'");
		}
		// 排序字段不为空，则将排序拼接到sql
		if (!StringUtil.nullOrBlank(sortName)
				&& !StringUtil.nullOrBlank(sortOrder)) {
			sql.append(" order by " + sortName + " " + sortOrder);
		}
		PreparedDBUtil db = new PreparedDBUtil();
		List<VotePaperBean> votePaperList = new ArrayList<VotePaperBean>();
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.setString(1, bean.getUser_id());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VotePaperBean votePaperBean = new VotePaperBean();
			votePaperBean.setId(db.getString(i, "id"));
			votePaperBean.setTitle(db.getString(i, "title"));
			votePaperBean.setFu_title(db.getString(i, "fu_title"));
			votePaperBean.setStauts(db.getString(i, "stauts"));
			votePaperBean.setDirection(db.getString(i, "direction"));
			votePaperBean.setCreatdate(db.getString(i, "creatdate"));
			votePaperBean.setStartdate(db.getString(i, "startdate"));
			votePaperBean.setEnddate(db.getString(i, "enddate"));
			votePaperBean.setIstop(db.getString(i, "istop"));
			votePaperBean.setOrg_id(db.getString(i, "org_id"));
			votePaperBean.setOrg_name(db.getString(i, "org_name"));
			votePaperBean.setUser_id(db.getString(i, "user_id"));
			votePaperBean.setUser_name(db.getString(i, "user_name"));
			votePaperBean.setPapaer_type(db.getString(i, "papaer_type"));
			votePaperBean.setPapaer_type_code(db.getString(i,
					"papaer_type_code"));
			votePaperBean.setComplete(db.getString(i, "complete"));
			votePaperBean.setComplete_name(db.getString(i, "complete_name"));
			votePaperList.add(votePaperBean);
		}
		pb.setList(votePaperList);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 updateComplete
	 * 
	 * @param string
	 * @param conn
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#updateComplete(java.lang.String,
	 *      java.sql.Connection)
	 */
	@Override
	public boolean updateComplete(String status, String pid, String user_id,
			Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "update oa_vote_user_contorl t set t.complete = ? , ANSWERTIME = sysdate where t.paper_id =? and t.user_id = ?";
		pdb.preparedUpdate(sql);
		pdb.setString(1, status);
		pdb.setString(2, pid);
		pdb.setString(3, user_id);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getQuestionAnswerCountList
	 * 
	 * @param pID
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#getQuestionAnswerCountList(java.lang.String)
	 */
	public List<VoteQuestionAnswerBean> getQuestionAnswerCountList(String pID)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<VoteQuestionAnswerBean> VoteQuestionAnswerList = new ArrayList<VoteQuestionAnswerBean>();
		sql
				.append(" select  t.eval_user_id  ,t.selectid, count(1) answercount from oa_vote_question_answer t where t.paper_id = ?  group by t.eval_user_id ,t.selectid ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1, pID);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VoteQuestionAnswerBean voteQuestionAnswerBean = new VoteQuestionAnswerBean();
			voteQuestionAnswerBean.setSelectid(db.getString(i, "selectid"));
			voteQuestionAnswerBean.setEval_user_id(db.getString(i,
					"eval_user_id"));
			voteQuestionAnswerBean.setAnswerCount(db
					.getString(i, "answercount"));
			VoteQuestionAnswerList.add(voteQuestionAnswerBean);
		}
		return VoteQuestionAnswerList;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findCompletePaginBean
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VoteViewDao#findCompletePaginBean(com.chinacreator.xtbg.core.vote.entity.VotePaperBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findCompletePaginBean(VotePaperBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"select t.title,t.org_name,t.user_name,to_char(v.answertime,'yyyy-MM-dd hh24-mi-ss') as adate, v.user_id, t.id, s.code from oa_vote_paper  t ")
				.append(
						" left join oa_vote_user_contorl v on t.id = v.paper_id")
				.append(
						" left join oa_vote_paper_type s on s.id = t.papaer_type")
				.append(" where t.id = ?  and v.complete = '1'");

		// 发起时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStartdate()))) {
			sql.append(" and v.answertime  >= to_date('" + bean.getStartdate()
					+ "','yyyy-mm-dd hh24:mi:ss') ");

		}
		// 发起时间
		if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnddate()))) {
			sql.append(" and v.answertime  <= to_date('" + bean.getEnddate()
					+ "','yyyy-mm-dd hh24:mi:ss') ");

		}
		// 排序字段不为空，则将排序拼接到sql
		if (!StringUtil.nullOrBlank(sortName)
				&& !StringUtil.nullOrBlank(sortOrder)) {
			sql.append(" order by " + sortName + " " + sortOrder);
		}
		PreparedDBUtil db = new PreparedDBUtil();
		List<VotePaperBean> votePaperList = new ArrayList<VotePaperBean>();
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.setString(1, bean.getId());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			VotePaperBean votePaperBean = new VotePaperBean();
			votePaperBean.setId(db.getString(i, "user_id"));
			votePaperBean.setTitle(db.getString(i, "title"));
			votePaperBean.setOrg_name(db.getString(i, "org_name"));
			votePaperBean.setUser_name(db.getString(i, "user_name"));
			votePaperBean.setUser_id(db.getString(i, "user_id"));// 此处是填报人ID
			votePaperBean.setCreatdate(db.getString(i, "adate"));// 此处是填报日期
			votePaperBean.setPapaer_type_code(db.getString(i, "code"));
			votePaperList.add(votePaperBean);
		}
		pb.setList(votePaperList);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
}

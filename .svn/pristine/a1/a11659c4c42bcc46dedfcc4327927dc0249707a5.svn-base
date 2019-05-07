package com.chinacreator.xtbg.core.vote.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.VotePaperDao;
import com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean;
import com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean;
import com.chinacreator.xtbg.core.vote.entity.VoteOptionBean;
import com.chinacreator.xtbg.core.vote.entity.VoteUserContorlBean;
import com.frameworkset.common.poolman.CallableDBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:VotePaperDaoImpl.java
 * </p>
 *<p>
 * Description:网上投票管理dao接口实现类
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
public class VotePaperDaoImpl<T> extends XtDbBaseDao implements VotePaperDao,
		BaseDao {

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
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#findPaginBean(com.chinacreator.xtbg.core.vote.entity.OAVotePaperBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findPaginBean(OAVotePaperBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 创建sql语句
			StringBuffer sql = new StringBuffer();
			sql
					.append("select p.id, p.title, p.fu_title,"
							+ "decode(p.stauts,'0','未发布','1','已发布') as stautsname,"
							+ " p.stauts, p.direction, "
							+ "to_char(p.creatdate,'yyyy-mm-dd hh24:mi:ss') as creatdate,"
							+ " to_char(p.startdate,'yyyy-mm-dd hh24:mi:ss') as startdate, "
							+ " to_char(p.enddate,'yyyy-mm-dd hh24:mi:ss') as enddate, p.istop,"
							+ " decode(p.istop,'0','是','1','否') as istopname ,"
							+ " p.org_id, p.org_name, p.user_id, p.user_name,"
							+ " p.papaer_type,t.name as type_name ,"
							+ " (select decode(sum(complete),null,'0',sum(complete))||'/'||count(complete) from "
							+ " oa_vote_user_contorl  c where c.paper_id= p.id) as voterate "
							+ " from oa_vote_paper p left join oa_vote_paper_type t "
							+ "on p.papaer_type=t.id where p.id is not null  ");
			// 查询条件不为空则拼接查询条件
			if (!StringUtil.nullOrBlank(bean.getTitle())) {
				sql.append(" and p.title like '%" + bean.getTitle().trim() + "%'");
			}
			// 状态
			if (!StringUtil.nullOrBlank(bean.getStauts())) {
				sql.append(" and p.stauts = '" + bean.getStauts().trim() + "'");
			}
			// 发起人
			if (!StringUtil.nullOrBlank(bean.getUser_name())) {
				sql.append(" and p.user_name like '%" + bean.getUser_name().trim()
						+ "%'");
			}
			// 发起时间
			if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getStartdate()))) {
				sql.append(" and p.creatdate  >= to_date('" + bean.getStartdate()
						+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
			}
			// 发起时间
			if (!StringUtil.nullOrBlank(StringUtil.deNull(bean.getEnddate()))) {
				sql.append(" and p.creatdate  <= to_date('" + bean.getEnddate()
						+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
			}
			// 试卷类型
			if (!StringUtil.nullOrBlank(bean.getPapaer_type())) {
				sql.append(" and p.papaer_type  = '" + bean.getPapaer_type() + "'");
			}
			// 当前查询的用户id，用户职能看到别人已发布的问卷和自己的草稿
			if (!StringUtil.nullOrBlank(bean.getUser_id())) {
				sql.append(" and ( p.user_id='" + bean.getUser_id()
						+ "' or p.stauts='1' ) ");
			}
			// 置顶的数据排在前面
			sql.append(" order by istop asc ");
	
			// 排序字段不为空，则将排序拼接到sql
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ," + sortName + " " + sortOrder);
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findListPaperType
	 * 
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#findListPaperType()
	 */
	public List<?> findListPaperType() throws Exception {
		String sql = " select id,name,code from oa_vote_paper_type order by code";
		return queryToListMap(sql);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteAnswerByPaper
	 * 
	 * @param ids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#deleteAnswerByPaper(java.lang.String)
	 */
	public void deleteAnswerByPaper(String ids,Connection conn) throws Exception {
		if (StringUtil.nullOrBlank(ids)) {
			return;
		}
		String sql = "delete from oa_vote_question_answer where question_id in (select id from oa_vote_question where  instr (',"
				+ ids.replaceAll("'", "") + ",',','||paper_id||',')>0 )";
		delete(sql,conn);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deleteOptionByPaper
	 * 
	 * @param ids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#deleteOptionByPaper(java.lang.String)
	 */
	public void deleteOptionByPaper(String ids,Connection conn) throws Exception {
		if (StringUtil.nullOrBlank(ids)) {
			return;
		}
		String sql = "delete from oa_vote_question_option where question_id in (select id from oa_vote_question where  instr (',"
				+ ids.replaceAll("'", "") + ",',','||paper_id||',')>0 )";
		delete(sql,conn);
	}

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
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		if (StringUtil.nullOrBlank(paperId) || StringUtil.nullOrBlank(userIds)) {
			return;
		}
		// 批量插入语句
		// StringBuffer sql = new StringBuffer("insert into oa_vote_eval_list  "
		// + " (paper_id, user_id, user_name, order_no) select '"
		// + paperId + "' as paper_id,"
		// + " user_id,user_realname,user_sn "
		// + "from td_sm_user where user_id is not null ");
		/**
		 * 插入数据时，增加排序字段 2013.05.22 戴连春修改
		 */
		StringBuffer sql = new StringBuffer(
				" insert into oa_vote_eval_list (paper_id, user_id, user_name, order_no) "
						+ " select '"
						+ paperId
						+ "',g.user_id,g.user_realname,rownum from ( "
						+ "  select  u.user_id, "
						+ "              u.user_realname "
						+ "         from (select rownum index_sn, org.org_id, org.org_name "
						+ "                 from td_sm_organization org "
						+ "                start with org.org_id in "
						+ "                           (select org_id "
						+ "                              from td_sm_organization cd "
						+ "                             where cd.parent_id = '0') "
						+ "               connect by prior org.org_id = org.parent_id "
						+ "                order siblings by org.org_sn) o "
						+ "         left join td_sm_orguser ou "
						+ "           on ou.org_id = o.org_id "
						+ "         left join td_sm_user u "
						+ "           on u.user_id = ou.user_id "
						+ "         left join td_sm_userjoborg a "
						+ "          on a.user_id = u.user_id and o.org_id = a.org_id "
						+ "        where u.user_id is not null ");
		// 传入了用户id列表，则插入传入了的id列表
		if (!StringUtil.nullOrBlank(userIds)) {

			String[] idArray = userIds.split(",");
			if (idArray.length < 1000) {
				sql.append(" and u.user_id in (" + userIds + ") ");
			} else {
				// 避免in语句包含的id过多，拼接多个"或"关系的in语句
				sql.append(joinSql(idArray, "u.user_id"));
			}

		}
		sql.append(" order by to_number(index_sn) ,a.same_job_user_sn   ) g");

		pdb.preparedInsert(sql.toString());
		pdb.executePrepared(conn);
	}

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
	public void insertUserContorlList(String paperId, String userIds,Connection conn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		if (StringUtil.nullOrBlank(paperId)) {
			return;
		}

		// 批量插入语句
		StringBuffer sql = new StringBuffer(
				"insert into  oa_vote_user_contorl(id, user_id, paper_id, messages, complete, user_name, answertime) "
						+ " select sys_guid() as id,user_id,'"
						+ paperId
						+ "' as paper_id,'','0' , user_realname,null  from td_sm_user where "
						+ " user_id is not null ");
		// 传入了用户id列表，则插入传入了的id列表
		if (!StringUtil.nullOrBlank(userIds)) {

			String[] idArray = userIds.split(",");
			if (idArray.length < 1000) {
				sql.append(" and user_id in (" + userIds + ") ");
			} else {
				// 避免in语句包含的id过多，拼接多个或关系的in语句
				sql.append(joinSql(idArray, "user_id"));
			}

		}

		pdb.preparedInsert(sql.toString());
		pdb.executePrepared(conn);
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findQuestionPaginBean
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#findQuestionPaginBean(com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findQuestionPaginBean(OAVoteQuestionBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		// 创建sql语句
		try {
			StringBuffer sql = new StringBuffer();
			sql
					.append("select q.id, "
							+ " q.title, "
							+ " q.direction, "
							+ " q.answer, "
							+ " q.paper_id, "
							+ " q.type_id, "
							+ " q.order_no, "
							+ " q.status, "
							+ " decode(q.status,'1','已发布','0','未发布') as statusname, "
							+ " t.name, "
							+ " p.title as paper_title "
							+ " from oa_vote_question q left join  oa_vote_paper p on  q.paper_id = p.id , oa_vote_question_type t "
							+ " where q.type_id = t.id ");
			// 查询条件不为空则拼接查询条件
			if (!StringUtil.nullOrBlank(bean.getPaper_id())) {
				sql.append(" and q.paper_id = '" + bean.getPaper_id() + "' ");
			}
	
			// 排序字段不为空，则将排序拼接到sql
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findListQuestionType
	 * 
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#findListQuestionType()
	 */
	public List<?> findListQuestionType() throws Exception {
		String sql = " select id, name, code from oa_vote_question_type ";
		return queryToListMap(sql);
	}

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
			throws Exception {

		String sql = "select id, question_id, question_number , content, option_code,check_max from oa_vote_question_option where question_id='"
				+ questionId + "' order by option_code ";
		return queryToListBean(new VoteOptionBean(), sql);

	}

	/**
	 * 
	 *<b>Summary: in 语句最多一次只能存在1000条记录，避免报错，拼接or连接多个in </b>
	 * joinSql(请用一句话描述这个方法的作用)
	 * 
	 * @param idArray
	 *            id数据
	 * @param column
	 *            执行in查询的列
	 * @return
	 */
	private String joinSql(String[] idArray, String column) {

		StringBuffer sql = new StringBuffer();

		sql.append(" and( " + column + " in ( ");
		// 拼接sql
		for (int i = 0; i < idArray.length; i++) {

			// 第一千条或最后一条不拼接分隔符","
			if ((i + 1) % 1000 == 0 || i == idArray.length - 1) {
				sql.append(idArray[i]);
			} else {
				sql.append(idArray[i] + ",");
			}
			// 超过1000条，则拼接 or 语句
			if ((i + 1) % 1000 == 0) {
				sql.append(" ) or " + column + " in ( ");
			}
		}

		sql.append(" ) )");

		return sql.toString();
	}

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
			throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		// 创建sql语句
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql
					.append("select u.id, "
							+ "u.user_id, "
							+ " u.paper_id, "
							+ "u.messages, "
							+ "u.complete, "
							+ " s.user_realname, "
							+ " u.answertime, "
							+ " s.user_sn, "
							+ "  s.org_name, "
							+ " s.org_id, "
							+ " s.user_mobiletel1 "
							+ " from (select u.user_id, "
							+ "             u.user_mobiletel1, "
							+ "             o.org_id, "
							+ "             o.org_name, "
							+ "             u.user_realname, "
							+ "            u.user_sn , o.index_sn,a.same_job_user_sn"
							+ "        from (select rownum index_sn, org.org_id, org.org_name "
							+ "                from td_sm_organization org "
							+ "               start with org.org_id in "
							+ "                          (select org_id "
							+ "                             from td_sm_organization cd "
							+ "                            where cd.parent_id = '0') "
							+ "              connect by prior org.org_id = org.parent_id "
							+ "               order siblings by org.org_sn) o "
							+ "        left join td_sm_orguser ou "
							+ "          on ou.org_id = o.org_id "
							+ "        left join td_sm_user u "
							+ "          on u.user_id = ou.user_id  "
							+ "left join td_sm_userjoborg a "
							+ " on a.user_id = u.user_id and o.org_id = a.org_id "
							+ "       where u.user_id is not null "
							+ "       order by to_number(index_sn), u.user_sn) s "
							+ " right join oa_vote_user_contorl u "
							+ "  on u.user_id = s.user_id"
							+ "						 where u.paper_id is not null ");
			// 查询条件不为空则拼接查询条件
			if (!StringUtil.nullOrBlank(bean.getComplete())) {
				sql.append(" and u.complete = '" + bean.getComplete().trim() + "'");
			}
			if (!StringUtil.nullOrBlank(bean.getPaper_id())) {
				sql.append(" and u.paper_id = '" + bean.getPaper_id() + "'");
			}
	
			// 排序字段不为空，则将排序拼接到sql
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			} else {
				sql
						.append(" order by  to_number(s.index_sn),s.same_job_user_sn,s.user_sn");
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
		
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 copyPaper
	 * 
	 * @param paperId
	 * @param userId
	 * @param userName
	 * @param orgId
	 * @param orgName
	 * @return
	 * @throws SQLException
	 * @see com.chinacreator.xtbg.core.vote.dao.VotePaperDao#copyPaper(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String,
	 *      java.lang.String)
	 */
	public String copyPaper(String paperId, String userId, String userName,
			String orgId, String orgName,Connection conn) throws SQLException {
		CallableDBUtil cdb = new CallableDBUtil();
		if (!StringUtil.nullOrBlank(paperId) && !StringUtil.nullOrBlank(userId)
				&& !StringUtil.nullOrBlank(userName)) {
			// 调用存储过程执行复制操作
			cdb.prepareCallable("{call copyPaper(?,?,?,?,?,?)}");
			cdb.setString(1, paperId);
			cdb.setString(2, userId);
			cdb.setString(3, userName);
			cdb.setString(4, StringUtil.nullOrBlank(orgId)?" ":orgId);
			cdb.setString(5, StringUtil.nullOrBlank(orgName)?" ":orgName);
			// 注册输出参数
			cdb.registerOutParameter(6, java.sql.Types.VARCHAR);
			cdb.executeCallable(conn);

			String id = cdb.getString(6);
			return id;
		}
		return "";
	}

	@Override
	public Map<String, List<String>> getAnswerById(String paperId
			) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		PreparedDBUtil db = new PreparedDBUtil();
		Connection conn = null;
		Map<String , List<String>> map = new HashMap<String,List<String>>();
			try {
				conn = DbManager.getInstance().getConnection();
				// 创建sql语句
				StringBuffer sql = new StringBuffer();
				
				
				StringBuffer sqlone = new StringBuffer();
				sqlone.append(" select s.title,s.id ");
				sqlone.append(" from oa_vote_question s ");
				sqlone.append("  where ");
				sqlone.append("  s.paper_id = ? ");
				sqlone.append("   and s.type_id = '2579A194AF044FDE9D270C0BED70511F'");
				
				db.preparedSelect(sqlone.toString());
				db.setString(1, paperId);
				db.executePrepared();
				for(int i = 0 ; i < db.size(); i ++){
					List<String> list  = new ArrayList<String>();
					map.put(db.getString(i,"title"),list);
				}
				
				sql.append(" select AA.QUESTION_ID , ANSWER_CONTENT, ");
				sql.append(" (select Q.TITLE from oa_vote_question Q WHERE ");
				sql.append(" Q.ID=AA.QUESTION_ID)AS TITLE ");
				sql.append(" from oa_vote_question_answer AA ");
				sql.append(" WHERE AA.paper_id = ? ");
				sql.append("  AND AA.ANSWER_CONTENT IS NOT NULL ");
				sql.append(" order by AA.QUESTION_ID ");
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, paperId);
				pdb.executePrepared();
				for(int i = 0 ; i < pdb.size(); i ++){
					//TODO 根据tilte 取key　
					if(map.containsKey(pdb.getString(i,"title"))){
						List list= map.get(pdb.getString(i,"title"));
						list.add(pdb.getString(i,"ANSWER_CONTENT"));
					}
					/*else{
						List<String> list  = new ArrayList<String>();
						list.add(pdb.getString(i,"ANSWER_CONTENT"));
						map.put(pdb.getString(i,"title"),list);
					}*/
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return map;
	}

}

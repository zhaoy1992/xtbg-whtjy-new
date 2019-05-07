package com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.GetInfoUserBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportSearchBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class InfoReportManagerDaoImpl implements InfoReportManagerDao{

	private static final Logger LOG = Logger.getLogger(InfoReportManagerDaoImpl.class);
	@Override
	public PagingBean findAlternateList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();

		sql.append("select * ");
		sql.append("  from (select t.submittedinfo_id, ");
		sql.append("   t.submittedinfo_title, ");
		sql.append("   t.input_date, ");
		sql.append("   t.inputuser_id, ");
		sql.append("   t.inputuser_name, ");
		sql.append("   t.department_id, ");
		sql.append("   o.org_name, ");
		sql.append("   (select case when count(*)>0 then 'Y' else 'N' end ");
		sql.append("from ta_oa_infre_audit a ");
		sql.append("where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and a.andit_state = '4') isaudited, ");
		sql.append("(select a.andit_time ");
		sql.append("from ta_oa_infre_audit a ");
		sql.append("     where a.audit_id = ");
		sql.append("           (select max(to_number(aa.audit_id)) ");
		sql.append("              from ta_oa_infre_audit aa ");
		sql.append("             where aa.submittedinfo_id = t.submittedinfo_id ");
		sql.append("             group by aa.submittedinfo_id)) andit_time ");
		sql.append("from ta_oa_infre_submitted_info t ");
		sql.append("inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("where t.is_alternate = 'Y' and t.submittedinfo_typecode not in (5,6)) tt ");
		sql.append("where 1 = 1 ");
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_id())){
			sql.append("	and tt.department_id = '"+infoReportSearchBean.getOrg_id()+"'");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.andit_time > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.andit_time < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setAndit_time(DateUtil.GetTimeString(db.getTimestamp(i, "andit_time")));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setOrg_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setIs_release("Y".equals(db.getString(i, "isaudited"))?"已审核":"未审核");
	    		list.add(infoReportBaseInfoBean);
	    	}
	    } catch (SQLException e) {
			LOG.error("执行备用列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findRecommendedList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select * ");
		sql.append("  from (select t.submittedinfo_id, ");
		sql.append("   t.submittedinfo_title, ");
		sql.append("   t.submittedinfo_typecode, ");
		sql.append("   t.input_date, ");
		sql.append("   t.department_id, ");
		sql.append("   o.org_name, ");
		sql.append("   t.is_recommend, ");
		sql.append("    (select case when count(*)>0 then 'Y' else 'N' end ");
		sql.append("from ta_oa_infre_audit a ");
		sql.append("where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and a.andit_state = '6') ispublished, ");
		sql.append("    t.recommend_username, ");
		sql.append("     t.recommend_time ");
		sql.append("from ta_oa_infre_submitted_info t ");
		sql.append("inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("where t.is_recommend = 'Y') tt ");
		sql.append("where 1 = 1 ");
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_id())){
			sql.append("	and tt.department_id = '"+infoReportSearchBean.getOrg_id()+"'");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setRecommend_time(DateUtil.GetTimeString(db.getTimestamp(i, "recommend_time")));
	    		infoReportBaseInfoBean.setRecommend_username(db.getString(i, "recommend_username"));
	    		infoReportBaseInfoBean.setOrg_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setIs_release("Y".equals(db.getString(i, "is_published"))?"已发布":"未发布");
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "submittedinfo_typecode"));
	    		infoReportBaseInfoBean.setIs_recommend(db.getString(i, "is_recommend"));
	    		list.add(infoReportBaseInfoBean);
	    	}
	    } catch (SQLException e) {
			LOG.error("执行推荐列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findPublishedList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		
		sql.append("select * ");
		sql.append("from (select distinct (t.submittedinfo_id), ");
		sql.append("            t.submittedinfo_title, ");
		sql.append("            t.input_date, ");
		sql.append("            t.inputuser_id, ");
		sql.append("            t.inputuser_name, ");
		sql.append("            t.department_id, ");
		sql.append("            o.org_name, ");
		sql.append("            t.is_recommend, ");
		sql.append("            u.andit_state, ");
		sql.append("            '已存稿' submittedinfo_typename, ");
		sql.append("            (select max(a.andit_time) ");
		sql.append("               from ta_oa_infre_audit a ");
		sql.append("              where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                and a.andit_state = '15' ");
		sql.append("              group by a.submittedinfo_id) release_time, ");
		sql.append("            (select a.andit_person ");
		sql.append("               from ta_oa_infre_audit a ");
		sql.append("              where a.audit_id = ");
		sql.append("                    (select max(a1.audit_id) ");
		sql.append("                       from ta_oa_infre_audit a1 ");
		sql.append("                      where a1.submittedinfo_id = ");
		sql.append("                            t.submittedinfo_id ");
		sql.append("                        and a1.andit_state = '15' ");
		sql.append("                      group by a1.submittedinfo_id)) audit_person ");
		sql.append("from ta_oa_infre_submitted_info t ");
		sql.append("inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                               t.submittedinfo_id ");
		sql.append("inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                            to_number(u.andit_state) ");
		sql.append("inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("where (u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("and u.andit_state = '"+InfoType.HAS_BE_SAVEINFO+"') or ");
		sql.append("( u.submittedinfo_id in ");
		sql.append("   (select distinct (t1.submittedinfo_id) ");
		sql.append("      from ta_oa_infre_audit t1 ");
		sql.append("     where t1.andit_state = '"+InfoType.HAS_BE_SAVEINFO+"' ) and u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' and u.andit_state = '"+InfoType.HAS_BE_SAVEINFO+"')) tt ");
		sql.append("where 1 = 1 ");
		

		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
			sql.append("	and tt.org_name like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
	    		db.setString(j++, "%"+infoReportSearchBean.getOrg_name()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setRelease_time(DateUtil.GetTimeStringNos(db.getTimestamp(i, "release_time")));
	    		infoReportBaseInfoBean.setAndit_person(db.getString(i, "audit_person"));
	    		infoReportBaseInfoBean.setOrg_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "andit_state"));
	    		list.add(infoReportBaseInfoBean);
	    	}
	    } catch (SQLException e) {
			LOG.error("执行发布列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findPendingList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select * ");
		sql.append("  from (select distinct (t.submittedinfo_id), ");
		sql.append("                        t.submittedinfo_title, ");
		sql.append("                        t.input_date, ");
		sql.append("                        t.inputuser_id, ");
		sql.append("                        t.inputuser_name, ");
		sql.append("                        t.department_id, ");
		sql.append("                        o.org_name, ");
		sql.append("                        t.is_recommend, ");
		sql.append("                        u.andit_state, ");
		sql.append("                        t.leadedit_state, ");//是否是领导报送
		sql.append("                        b.submittedinfo_typename, ");
		sql.append("                        (select max(a.andit_time) ");
		sql.append("                           from ta_oa_infre_audit a ");
		sql.append("                          where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                            and a.andit_state = '"+InfoType.HAS_BE_REPORTED+"' ");
		sql.append("                          group by a.submittedinfo_id) release_time ");
		sql.append("          from ta_oa_infre_submitted_info t ");
		sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                                           t.submittedinfo_id ");
		sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                                        to_number(u.andit_state) ");
		sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("         where u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("           and u.andit_state in ('"+InfoType.NOT_BE_DEALWITH+"', '"+InfoType.NOT_BE_DEALWITH_REAUDIT+"'");
		sql.append(", '"+InfoType.NOT_BE_DEALWITH_LEADER+"', '"+InfoType.HAS_BE_REJECTION_REAUDIT+"')) tt ");
		sql.append(" where 1 = 1 ");


		

		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
			sql.append("	and tt.org_name like ? ");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_typecode())){
			sql.append("	and tt.andit_state = '"+infoReportSearchBean.getSubmittedinfo_typecode().trim()+"'");
		}

		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
	    		db.setString(j++, "%"+infoReportSearchBean.getOrg_name()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setRelease_time(DateUtil.GetTimeStringNos(db.getTimestamp(i, "release_time")));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setReleaseunit_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "andit_state"));
	    		infoReportBaseInfoBean.setIs_recommend(db.getString(i, "is_recommend"));
	    		infoReportBaseInfoBean.setLeadedit_state(db.getString(i,"leadedit_state"));//是否是领导报送
	    		list.add(infoReportBaseInfoBean);
	    	}
		  
	    } catch (SQLException e) {
			LOG.error("执行已处理列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	@Override
	public PagingBean findAllReportInfoList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select * ");
		sql.append("  from (select distinct (t.submittedinfo_id), ");
		sql.append("                        t.submittedinfo_title, ");
		sql.append("                        t.input_date, ");
		sql.append("                        t.inputuser_id, ");
		sql.append("                        t.inputuser_name, ");
		sql.append("                        t.department_id, ");
		sql.append("                        o.org_name, ");
		sql.append("                        t.is_recommend, ");
		sql.append("                        t.ssusername, ");
		sql.append("                        t.fbusername, ");
		sql.append("                        u.andit_state, ");
		sql.append("                        b.submittedinfo_typename, ");
		sql.append("                        (select max(a.andit_time) ");
		sql.append("                           from ta_oa_infre_audit a ");
		sql.append("                          where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                            and a.andit_state = '2' ");
		sql.append("                          group by a.submittedinfo_id) release_time ");
		sql.append("          from ta_oa_infre_submitted_info t ");
		sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                                           t.submittedinfo_id ");
		sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                                        to_number(u.andit_state) ");
		sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("         where u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("           and u.andit_state in ('"+InfoType.HAS_BE_SAVEINFO+"','"+InfoType.HAS_BE_SUBMITTED+"', '"+InfoType.HAS_BE_AUDIT+"', '"+InfoType.HAS_BE_PUBLISHED+"','"+InfoType.HAS_BE_REJECTION+"'");
		sql.append(",'"+InfoType.HAS_BE_SUBMITTED_REAUDIT+"','"+InfoType.HAS_BE_REJECTION+"','"+InfoType.HAS_BE_REJECTION_REAUDIT+"')) tt ");
		sql.append(" where 1 = 1 ");

		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
			sql.append("	and tt.org_name like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_typecode())){
			sql.append("	and tt.andit_state = '"+infoReportSearchBean.getSubmittedinfo_typecode().trim()+"'");
		}

		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
	    		db.setString(j++, "%"+infoReportSearchBean.getOrg_name()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setRelease_time(DateUtil.GetTimeStringNos(db.getTimestamp(i, "release_time")));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setReleaseunit_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "andit_state"));
	    		infoReportBaseInfoBean.setIs_recommend(db.getString(i, "is_recommend"));
	    		infoReportBaseInfoBean.setSsusername(db.getString(i, "ssusername"));
	    		infoReportBaseInfoBean.setFbusername(db.getString(i, "fbusername"));
	    		
	    		list.add(infoReportBaseInfoBean);
	    	}
		  
	    } catch (SQLException e) {
			LOG.error("执行已处理列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findBeRejectionList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();

		sql.append("select * ");
		sql.append("  from (select t.submittedinfo_id, ");
		sql.append("   t.submittedinfo_title, ");
		sql.append("   t.input_date, ");
		sql.append("   t.inputuser_id, ");
		sql.append("   t.inputuser_name, ");
		sql.append("   t.is_recommend, ");
		sql.append("   (select a.andit_person ");
		sql.append("      from ta_oa_infre_audit a ");
		sql.append("     where a.audit_id = ");
		sql.append("           (select max(to_number(aa.audit_id)) ");
		sql.append("              from ta_oa_infre_audit aa ");
		sql.append("             where aa.submittedinfo_id = t.submittedinfo_id ");
		sql.append("             group by aa.submittedinfo_id)) andit_person, ");
		sql.append("   (select a.andit_time ");
		sql.append("      from ta_oa_infre_audit a ");
		sql.append("     where a.audit_id = ");
		sql.append("           (select max(to_number(aa.audit_id)) ");
		sql.append("              from ta_oa_infre_audit aa");
		sql.append("             where aa.submittedinfo_id = t.submittedinfo_id ");
		sql.append("             group by aa.submittedinfo_id)) andit_time, ");
		sql.append("   (select a.andit_opinion ");
		sql.append("      from ta_oa_infre_audit a ");
		sql.append("     where a.audit_id = ");
		sql.append("           (select max(to_number(aa.audit_id)) ");
		sql.append("              from ta_oa_infre_audit aa ");
		sql.append("             where aa.submittedinfo_id = t.submittedinfo_id ");
		sql.append("             group by aa.submittedinfo_id)) andit_opinion ");
		sql.append(" from ta_oa_infre_submitted_info t ");
		sql.append(" where t.submittedinfo_typecode = '5') tt where 1=1");

		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and tt.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and tt.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInputuser_id())){
			sql.append("	and tt.inputuser_id = '"+infoReportSearchBean.getInputuser_id()+"'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setInput_date(DateUtil.GetTimeString(db.getTimestamp(i, "input_date")));
	    		infoReportBaseInfoBean.setAndit_person(db.getString(i, "andit_person"));
	    		infoReportBaseInfoBean.setAndit_time(DateUtil.GetTimeString(db.getTimestamp(i, "andit_time")));
	    		infoReportBaseInfoBean.setAndit_opinion(db.getString(i, "andit_opinion"));

	    		list.add(infoReportBaseInfoBean);
	    	}
		  
	    } catch (SQLException e) {
			LOG.error("执行已退稿列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findHasBeenReportedList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();

		
		sql.append("select * ");
		sql.append("  from (select distinct (t.submittedinfo_id), ");
		sql.append("                        t.submittedinfo_title, ");
		sql.append("                        t.input_date, ");
		sql.append("                        t.relese_time, ");
		sql.append("                        t.inputuser_id, ");
		sql.append("                        t.inputuser_name, ");
		sql.append("                        t1.infotype_name, ");
		sql.append("                        t1.infotype_id, ");
		sql.append("                        t.department_id, ");
		sql.append("                        o.org_name, ");
		sql.append("                        t.is_recommend, ");
		sql.append("                        t.sbusername as sbusername ,");
		sql.append("                        u.andit_state, ");
		sql.append("                        b.submittedinfo_typename, ");
		sql.append("                        (select max(a.andit_time) ");
		sql.append("                           from ta_oa_infre_audit a ");
		sql.append("                          where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                            and a.andit_state = '2' ");
		sql.append("                          group by a.submittedinfo_id) release_time ");
		sql.append("          from ta_oa_infre_submitted_info t ");
		sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                                           t.submittedinfo_id ");
		sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                                        to_number(u.andit_state) ");
		sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("         inner join ta_oa_infre_info_type t1 on t1.infotype_id = t.infotype_id ");
		sql.append("         where u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("           and u.andit_state in ('"+InfoType.HAS_BE_REPORTED+"')) t ");
		sql.append(" where 1 = 1 ");
		
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and t.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and t.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and t.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInfotype_id())){
			sql.append(" and  t.infotype_id = '"+infoReportSearchBean.getInfotype_id()+"'");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInputuser_id())){
			sql.append("	and t.inputuser_id = '"+infoReportSearchBean.getInputuser_id()+"'");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_typename()) && !"信息状态".endsWith(infoReportSearchBean.getSubmittedinfo_typename()))
		{
			sql.append("	and submittedinfo_typename = '"+infoReportSearchBean.getSubmittedinfo_typename()+"'");
			
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setInput_date(DateUtil.GetTimeStringNos(db.getTimestamp(i, "input_date")));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setInfotype_name(db.getString(i, "infotype_name"));
	    		infoReportBaseInfoBean.setRelese_time(DateUtil.GetTimeString(db.getTimestamp(i, "relese_time")));
	    		infoReportBaseInfoBean.setSbusername(db.getString(i, "sbusername"));
	    		list.add(infoReportBaseInfoBean);
	    	}
		  
	    } catch (SQLException e) {
			LOG.error("执行已上报列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findMyDraftsList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		

		sql.append(" select distinct (t.submittedinfo_id), ");
		sql.append("                        t.submittedinfo_title, ");
		sql.append("                        t.input_date, ");
		sql.append("                        t.inputuser_id, ");
		sql.append("                        t.inputuser_name, ");
		sql.append("                        t1.infotype_name, ");
		sql.append("                        t.department_id, ");
		sql.append("                        o.org_name, ");
		sql.append("                        t.is_recommend, ");
		sql.append("                        (select count(*) ");
		sql.append("                          from ta_oa_infre_getinfo_user a ");
		sql.append("                         where a.submittedinfo_id = t.submittedinfo_id "); 
		sql.append("                           and a.submittedinfo_typecode = '"+InfoType.REPORTED_TEMPORARY+"' ");
		sql.append("                        ) view_num, ");
		sql.append("                        u.andit_state, ");
		sql.append("                        b.submittedinfo_typename, ");
		sql.append("                        (select max(a.andit_time) ");
		sql.append("                           from ta_oa_infre_audit a ");
		sql.append("                          where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                            and a.andit_state = '6' ");
		sql.append("                          group by a.submittedinfo_id) release_time ");
		sql.append("          from ta_oa_infre_submitted_info t ");
		sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                                           t.submittedinfo_id ");
		sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                                        to_number(u.andit_state) ");
		sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("         inner join ta_oa_infre_info_type t1 on t1.infotype_id = t.infotype_id ");
		sql.append("         where u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("           and u.andit_state in ( '"+InfoType.HAS_BE_TEMPORARY+"', '"+InfoType.HAS_BE_REJECTION+"') ");
		
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and t.submittedinfo_title like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and t.input_date > to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd ')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and t.input_date < to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInfotype_id())){
			sql.append("	and t.infotype_id = '"+infoReportSearchBean.getInfotype_id()+"'");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInputuser_id())){
			sql.append("	and t.inputuser_id = '"+infoReportSearchBean.getInputuser_id()+"'");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setInput_date(DateUtil.GetTimeStringNos(db.getTimestamp(i, "input_date")));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setInfotype_name(db.getString(i, "infotype_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "andit_state"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setView_num(db.getString(i, "view_num"));
	    		list.add(infoReportBaseInfoBean);
	    	}
	    	
	    } catch (SQLException e) {
			LOG.error("执行我的草稿箱列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public PagingBean findOnlyReadList(
			InfoReportSearchBean infoReportSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<InfoReportBaseInfoBean> list = new ArrayList<InfoReportBaseInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select * ");
		sql.append("  from (select distinct (t.submittedinfo_id), ");
		sql.append("                        t.submittedinfo_title, ");
		sql.append("                        t.input_date, ");
		sql.append("                        t.inputuser_id, ");
		sql.append("                        t.inputuser_name, ");
		sql.append("                        t.department_id, ");
		sql.append("                        o.org_name, ");
		sql.append("                        t.is_recommend, ");
		sql.append("                        u.andit_state, ");
		sql.append("                        b.submittedinfo_typename, ");
		sql.append("                        (select max(a.andit_time) ");
		sql.append("                           from ta_oa_infre_audit a ");
		sql.append("                          where a.submittedinfo_id = t.submittedinfo_id ");
		sql.append("                            and a.andit_state = '6' ");
		sql.append("                          group by a.submittedinfo_id) release_time, ");
		sql.append("                          t.infotype_id                               ");
		sql.append("          from ta_oa_infre_submitted_info t ");
		sql.append("         inner join ta_oa_infre_audit u on u.submittedinfo_id = ");
		sql.append("                                           t.submittedinfo_id ");
		sql.append("         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode = ");
		sql.append("                                                        to_number(u.andit_state) ");
		sql.append("         inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("         where u.andit_person_id = '");
		sql.append(infoReportSearchBean.getInputuser_id());
		sql.append("' ");
		sql.append("           and u.andit_state in ( '"+InfoType.NOT_BE_VIEW+"', '"+InfoType.HAS_BE_VIEW+"', '"+InfoType.HAS_BE_PISHI+"')) tt ");
		sql.append(" where 1 = 1 ");

		
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
			sql.append("	and tt.submittedinfo_title like ?");
		}
		
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
			sql.append("	and tt.org_name like ?");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_starttime())){
			sql.append(" and input_date >= to_date('").append(infoReportSearchBean.getInput_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInput_endtime())){
			sql.append(" and input_date <= to_date('").append(infoReportSearchBean.getInput_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getInfotype_id())){
			sql.append("	and tt.infotype_id = '"+infoReportSearchBean.getInfotype_id()+"'");
		}
		//if(!StringUtil.nullOrBlank(infoReportSearchBean.getInfostate())){
		//	sql.append(" and	 tt.submittedinfo_typename= '"+infoReportSearchBean.getInfostate()+"'");
		//}
		if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_typename()) && !"信息状态".endsWith(infoReportSearchBean.getSubmittedinfo_typename()))
		{
			sql.append("	and submittedinfo_typename = '"+infoReportSearchBean.getSubmittedinfo_typename()+"'");
			
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {

	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getSubmittedinfo_title())){
	    		db.setString(j++, "%"+infoReportSearchBean.getSubmittedinfo_title()+"%");
	    	}
	    	
	    	if(!StringUtil.nullOrBlank(infoReportSearchBean.getOrg_name())){
	    		db.setString(j++, "%"+infoReportSearchBean.getOrg_name()+"%");
	    	}
	    	
	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	    		infoReportBaseInfoBean.setSubmittedinfo_id(db.getString(i, "submittedinfo_id"));
	    		infoReportBaseInfoBean.setSubmittedinfo_title(db.getString(i, "submittedinfo_title"));
	    		infoReportBaseInfoBean.setInput_date(DateUtil.GetTimeStringNos(db.getTimestamp(i, "input_date")));
	    		infoReportBaseInfoBean.setInputuser_id(db.getString(i, "inputuser_id"));
	    		infoReportBaseInfoBean.setInputuser_name(db.getString(i, "inputuser_name"));
	    		infoReportBaseInfoBean.setInfotype_name(db.getString(i, "infotype_name"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typename(db.getString(i, "submittedinfo_typename"));
	    		infoReportBaseInfoBean.setSubmittedinfo_typecode(db.getString(i, "andit_state"));
	    		infoReportBaseInfoBean.setReleaseunit_name(db.getString(i, "releaseunit_name"));
	    		infoReportBaseInfoBean.setOrg_name(db.getString(i, "org_name"));
	    		infoReportBaseInfoBean.setRelease_time(DateUtil.GetTimeStringNos(db.getTimestamp(i, "release_time")));
	    		list.add(infoReportBaseInfoBean);
	    		
	    	}

		  
	    } catch (SQLException e) {
			LOG.error("执行可查看列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public void saveAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean,Connection con) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("insert into ta_oa_infre_audit");
		sql.append("  (audit_id,");
		sql.append("   submittedinfo_id,");
		sql.append("   andit_source,");
		sql.append("   andit_person,");
		sql.append("   andit_opinion,");
		sql.append("   andit_state,");
		sql.append("   andit_time,");
		sql.append("   andit_person_id)");
		sql.append(" values");
		sql.append("  (seq_infre_audit.nextval, ?, ?, ?, ?, ?, ?, ?)");
		try{
			
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, infoReportAuditIdeaBean.getSubmittedinfo_id());
			pdb.setString(2, infoReportAuditIdeaBean.getAndit_source());
			pdb.setString(3, infoReportAuditIdeaBean.getAndit_person());
			pdb.setString(4, infoReportAuditIdeaBean.getAndit_opinion());
			pdb.setString(5, infoReportAuditIdeaBean.getAndit_state());
			pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pdb.setString(7, infoReportAuditIdeaBean.getAndit_person_id());
			pdb.executePrepared(con);
			  
			/** android end */
			//pdb.executePreparedBatch();
		}catch(Exception e){
			throw e;
		}
		
	}
	
	


	@Override
	public void saveAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_infre_audit");
		sql.append("  (audit_id,");
		sql.append("   submittedinfo_id,");
		sql.append("   andit_source,");
		sql.append("   andit_person,");
		sql.append("   andit_opinion,");
		sql.append("   andit_state,");
		sql.append("   andit_time,");
		sql.append("   andit_person_id)");
		sql.append("values");
		sql.append("  (seq_infre_audit.nextval, ?, ?, ?, ?, ?, ?, ?)");
		try{
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, infoReportAuditIdeaBean.getSubmittedinfo_id());
			pdb.setString(2, infoReportAuditIdeaBean.getAndit_source());
			pdb.setString(3, infoReportAuditIdeaBean.getAndit_person());
			pdb.setString(4, infoReportAuditIdeaBean.getAndit_opinion());
			pdb.setString(5, infoReportAuditIdeaBean.getAndit_state());
			pdb.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pdb.setString(7, infoReportAuditIdeaBean.getAndit_person_id());
			pdb.executePrepared();
			
			/** android end */
			pdb.executePreparedBatch();
		}catch(Exception e){
			throw e;
		}
		
	}
	

	@Override
	public void deleteAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete ta_oa_infre_audit");
		sql.append("  where andit_state = ? and andit_person_id = ?");

		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, infoReportAuditIdeaBean.getAndit_state());
			pdb.setString(2, infoReportAuditIdeaBean.getAndit_person_id());
			pdb.executePrepared();
		}catch(Exception e){
			throw e;
		}
		
	}
	
	@Override
	public void deleteAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean,Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete ta_oa_infre_audit");
		sql.append("  where andit_state = ? and submittedinfo_id = ? and andit_person_id=? ");

		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, infoReportAuditIdeaBean.getAndit_state());
			pdb.setString(2, infoReportAuditIdeaBean.getSubmittedinfo_id());
			pdb.setString(3, infoReportAuditIdeaBean.getAndit_person_id());
			pdb.executePrepared(con);
		}catch(Exception e){
			throw e;
		}
	}
	

	@Override
	public void deleteAuditIdeaByUser(
			InfoReportAuditIdeaBean infoReportAuditIdeaBean, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete ta_oa_infre_audit");
		sql.append("  where andit_state = ? and submittedinfo_id = ? and andit_person_id = ?");

		try{
			pdb.preparedDelete(sql.toString());
			pdb.setString(1, infoReportAuditIdeaBean.getAndit_state());
			pdb.setString(2, infoReportAuditIdeaBean.getSubmittedinfo_id());
			pdb.setString(3, infoReportAuditIdeaBean.getAndit_person_id());
			pdb.executePrepared(con);
		}catch(Exception e){
			throw e;
		}
		
	}

	public String saveInfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean,Connection con) throws Exception{
		TransactionManager tm = new TransactionManager();	
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		String submittedinfo_id = infoReportBaseInfoBean.getSubmittedinfo_id();
		boolean isUpdate = true;
		try{
			tm.begin();
			if(StringUtil.nullOrBlank(submittedinfo_id)){
				isUpdate = false;
				sql1.append("select seq_infre_submitted_info.nextval submittedinfo_id from dual ");
				pdb.preparedSelect(sql1.toString());
				pdb.executePrepared();
				submittedinfo_id = pdb.getString(0, "submittedinfo_id");
				
				sql.append("insert into ta_oa_infre_submitted_info");
				sql.append("  (submittedinfo_id,");
				sql.append("   infotype_id,");
				sql.append("   submittedinfo_typecode,");
				sql.append("   submittedinfo_title,");
				sql.append("   inputuser_id,");
				sql.append("   inputuser_name,");
				sql.append("   org_id,");
				sql.append("   department_id,");
				sql.append("   keyword,");
				sql.append("   submit_content,");
				sql.append("   is_recommend,");
				sql.append("   is_alternate,");
				sql.append("   input_date,");
				sql.append("   submit_content_phone,");
				sql.append("   relese_time,leadedit_state,sbuserid,sbusername)");
				sql.append("values");
				sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?)");
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, submittedinfo_id);
				pdb.setString(2, infoReportBaseInfoBean.getInfotype_id());
				pdb.setString(3, infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
				pdb.setString(4, infoReportBaseInfoBean.getSubmittedinfo_title());
				pdb.setString(5, infoReportBaseInfoBean.getInputuser_id());
				pdb.setString(6, infoReportBaseInfoBean.getInputuser_name());
				pdb.setString(7, infoReportBaseInfoBean.getOrg_id());
				pdb.setString(8, infoReportBaseInfoBean.getDepartmentid());
				pdb.setString(9, infoReportBaseInfoBean.getKeyword());
				pdb.setString(10, infoReportBaseInfoBean.getSubmit_content());
				pdb.setString(11, "N");
				pdb.setString(12, "N");
				pdb.setTimestamp(13, new Timestamp(System.currentTimeMillis()));
				pdb.setString(14, infoReportBaseInfoBean.getSubmit_content_phone());
				pdb.setTimestamp(15, new Timestamp(System.currentTimeMillis()));
				pdb.setString(16, infoReportBaseInfoBean.getLeadedit_state());
				pdb.setString(17, infoReportBaseInfoBean.getReportunits());
				pdb.setString(18, infoReportBaseInfoBean.getReportunitsname());
			}else{
				isUpdate = true;
				sql.append("update ta_oa_infre_submitted_info");
				sql.append("  set ");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getInfotype_id()))
					sql.append("  infotype_id = '"+infoReportBaseInfoBean.getInfotype_id()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode()))
					sql.append("  submittedinfo_typecode = '"+infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_title()))
					sql.append("  submittedinfo_title = '"+infoReportBaseInfoBean.getSubmittedinfo_title()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getIs_alternate()))
					sql.append("  is_alternate = '"+infoReportBaseInfoBean.getIs_alternate()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getKeyword()))
					sql.append("  keyword = '"+infoReportBaseInfoBean.getKeyword()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmit_content()))
					sql.append("  submit_content = ? ,");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSendauditusers()))
					sql.append("  ssuserid = '"+infoReportBaseInfoBean.getSendauditusers()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSendauditusersname()))
					sql.append("  ssusername = '"+infoReportBaseInfoBean.getSendauditusersname()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getPartunits()))
					sql.append("  fbuserid = '"+infoReportBaseInfoBean.getPartunits()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getPartunitsname()))
					sql.append("  fbusername = '"+infoReportBaseInfoBean.getPartunitsname()+"',");
				pdb.preparedUpdate(sql.substring(0, sql.length()-1) + " where submittedinfo_id = ?");
				
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmit_content())){
					pdb.setString(1, infoReportBaseInfoBean.getSubmit_content());
					pdb.setString(2, submittedinfo_id);
				}else{
					pdb.setString(1, submittedinfo_id);
				}
				/*
				sql.append("   submittedinfo_typecode = ?,");
				sql.append("   submittedinfo_title = ?,");
				sql.append("   keyword = ?,");
				sql.append("   submit_content = ?");
				sql.append("where submittedinfo_id = ?");
				pdb.setString(1, infoReportBaseInfoBean.getInfotype_id());
				pdb.setString(2, infoReportBaseInfoBean.getSubmittedinfo_typecode());
				pdb.setString(3, infoReportBaseInfoBean.getSubmittedinfo_title());
				pdb.setString(4, infoReportBaseInfoBean.getKeyword());
				pdb.setString(5, infoReportBaseInfoBean.getSubmit_content());
				pdb.setString(6, submittedinfo_id);*/
			}
			pdb.executePrepared(con);
//			if(isUpdate){//更新在此更新记录表，新增操作是在发送人中处理
//				/** modify by android haibo.wang 2012/7/14
//				 *  插入android数据记录表 begin */
//				String useridsql = "select distinct andit_person_id from ta_oa_infre_audit t where t.submittedinfo_id='"+submittedinfo_id+"' ";
//				pdb.preparedSelect(useridsql);
//				pdb.executePrepared();
//				String userids = "";
//				for(int i = 0 ; i < pdb.size() ; i ++){
//					if("".equals(userids)){
//						userids += pdb.getString(i,"andit_person_id");
//					}else{
//						userids += ","+pdb.getString(i,"andit_person_id");
//					}
//				}
//				/** android end */
//				pdb.executePreparedBatch();
//			}
			tm.commit();
	
		}catch(Exception e){
			try {
				tm.rollback();
			} catch (RollbackException a) {
				a.printStackTrace();
			}
			System.out.println(e);
			throw e;
		}
		return submittedinfo_id;
	}
	
	public String saveInfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception{
		TransactionManager tm = new TransactionManager();	
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		String submittedinfo_id = infoReportBaseInfoBean.getSubmittedinfo_id();
		boolean isUpdate = true;
		try{
			tm.begin();
			if(StringUtil.nullOrBlank(submittedinfo_id)){
				isUpdate = false;
				sql1.append("select seq_infre_submitted_info.nextval submittedinfo_id from dual ");
				pdb.preparedSelect(sql1.toString());
				pdb.executePrepared();
				submittedinfo_id = pdb.getString(0, "submittedinfo_id");
				
				sql.append("insert into ta_oa_infre_submitted_info");
				sql.append("  (submittedinfo_id,");
				sql.append("   infotype_id,");
				sql.append("   submittedinfo_typecode,");
				sql.append("   submittedinfo_title,");
				sql.append("   inputuser_id,");
				sql.append("   inputuser_name,");
				sql.append("   org_id,");
				sql.append("   department_id,");
				sql.append("   keyword,");
				sql.append("   submit_content,");
				sql.append("   is_recommend,");
				sql.append("   is_alternate,");
				sql.append("   input_date)");
				sql.append("values");
				sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, submittedinfo_id);
				pdb.setString(2, infoReportBaseInfoBean.getInfotype_id());
				pdb.setString(3, infoReportBaseInfoBean.getSubmittedinfo_typecode());
				pdb.setString(4, infoReportBaseInfoBean.getSubmittedinfo_title());
				pdb.setString(5, infoReportBaseInfoBean.getInputuser_id());
				pdb.setString(6, infoReportBaseInfoBean.getInputuser_name());
				pdb.setString(7, infoReportBaseInfoBean.getOrg_id());
				pdb.setString(8, infoReportBaseInfoBean.getDepartmentid());
				pdb.setString(9, infoReportBaseInfoBean.getKeyword());
				pdb.setString(10, infoReportBaseInfoBean.getSubmit_content());
				pdb.setString(11, "N");
				pdb.setString(12, "N");
				pdb.setTimestamp(13, StringUtil.nullOrBlank(infoReportBaseInfoBean.getInput_date())?new Timestamp(System.currentTimeMillis()):DateUtil.parseTimeString(infoReportBaseInfoBean.getInput_date()));
			}else{
				isUpdate = true;
				sql.append("update ta_oa_infre_submitted_info");
				sql.append("  set ");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getInfotype_id()))
					sql.append("  infotype_id = '"+infoReportBaseInfoBean.getInfotype_id()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode()))
					sql.append("  submittedinfo_typecode = '"+infoReportBaseInfoBean.getSubmittedinfo_typecode()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_title()))
					sql.append("  submittedinfo_title = '"+infoReportBaseInfoBean.getSubmittedinfo_title()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getIs_alternate()))
					sql.append("  is_alternate = '"+infoReportBaseInfoBean.getIs_alternate()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getKeyword()))
					sql.append("  keyword = '"+infoReportBaseInfoBean.getKeyword()+"',");
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmit_content()))
					sql.append("  submit_content = ? ,");

				pdb.preparedUpdate(sql.substring(0, sql.length()-1) + " where submittedinfo_id = ?");
				
				if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmit_content())){
					pdb.setString(1, infoReportBaseInfoBean.getSubmit_content());
					pdb.setString(2, submittedinfo_id);
				}else{
					pdb.setString(1, submittedinfo_id);
				}
				/*
				sql.append("   submittedinfo_typecode = ?,");
				sql.append("   submittedinfo_title = ?,");
				sql.append("   keyword = ?,");
				sql.append("   submit_content = ?");
				sql.append("where submittedinfo_id = ?");
				pdb.setString(1, infoReportBaseInfoBean.getInfotype_id());
				pdb.setString(2, infoReportBaseInfoBean.getSubmittedinfo_typecode());
				pdb.setString(3, infoReportBaseInfoBean.getSubmittedinfo_title());
				pdb.setString(4, infoReportBaseInfoBean.getKeyword());
				pdb.setString(5, infoReportBaseInfoBean.getSubmit_content());
				pdb.setString(6, submittedinfo_id);*/
				
			}
			
			pdb.executePrepared();
			if(isUpdate){//更新在此更新记录表，新增操作是在发送人中处理
				/** modify by android haibo.wang 2012/7/14
				 *  插入android数据记录表 begin */
				String useridsql = "select distinct andit_person_id from ta_oa_infre_audit t where t.submittedinfo_id='"+submittedinfo_id+"' ";
				pdb.preparedSelect(useridsql);
				pdb.executePrepared();
				String userids = "";
				for(int i = 0 ; i < pdb.size() ; i ++){
					if("".equals(userids)){
						userids += pdb.getString(i,"andit_person_id");
					}else{
						userids += ","+pdb.getString(i,"andit_person_id");
					}
				}
				/** android end */
				pdb.executePreparedBatch();
			}
			
			tm.commit();
		}catch(Exception e){
			try {
				tm.rollback();
			} catch (RollbackException a) {
				a.printStackTrace();
			}
			throw e;
		}
		return submittedinfo_id;
	}
	
	
	
	@Override
	public void onlyReportInfo(String submittedinfoId,String state,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try{
			sql.append("update ta_oa_infre_submitted_info");
			sql.append("  set ");
			sql.append("   submittedinfo_typecode = ? ");
			sql.append("where submittedinfo_id = ?");
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, state);
			pdb.setString(2, submittedinfoId);
			
			pdb.executePrepared(con);
		}catch(Exception e){
			throw e;
		}
	}

	@Override
	public void saveInfoRecommend(String submittedinfoId, String isRecommend,String userid,String username)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_infre_submitted_info ");
		sql.append(" set is_recommend = '"+isRecommend+"',") ;
		sql.append(" recommend_userid = '"+userid+"',") ;
		sql.append(" recommend_username = '"+username+"',") ;
		sql.append(" recommend_time = sysdate ") ;
		sql.append(" where submittedinfo_id = '"+submittedinfoId+"'");
		//sql.append("update ta_oa_infre_submitted_info set is_recommend = ? where submittedinfo_id = ?");
		try{
			pdb.preparedUpdate(sql.toString());
			//pdb.setString(1,submittedinfoId);
			//pdb.setString(2,isRecommend+" ");
			pdb.executePrepared();
		}catch(Exception e){
			throw e;
		}
		
	}
	
	

	@Override
	public void saveInfoRecommend4List(String submittedinfoIds,
			String isRecommend, String userid, String username)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();

		try{
			if(!StringUtil.nullOrBlank(submittedinfoIds)){
				String[] submittedinfoIdArry = submittedinfoIds.split(",");
				for(String submittedinfoId : submittedinfoIdArry){
					sql.setLength(0);
					sql.append("update ta_oa_infre_submitted_info ");
					sql.append(" set is_recommend = '"+isRecommend+"',") ;
					sql.append(" recommend_userid = '"+userid+"',") ;
					sql.append(" recommend_username = '"+username+"',") ;
					sql.append(" recommend_time = sysdate ") ;
					sql.append(" where submittedinfo_id = '"+submittedinfoId+"'");
					pdb.preparedUpdate(sql.toString());
					pdb.addPreparedBatch();
				}
			}
			
			pdb.executePreparedBatch();
		}catch(Exception e){
			throw e;
		}
	}

	@Override
	public InfoReportBaseInfoBean findInfoReportBaseInfo(String submittedinfoId)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String state = "";
		
		sql.append("select trim(submittedinfo_typecode) submittedinfo_typecode from ta_oa_infre_submitted_info where submittedinfo_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, submittedinfoId);
		pdb.executePrepared();
		if(pdb.size() > 0){
			state = pdb.getString(0, "submittedinfo_typecode");
		}
		
		sql.setLength(0);
		sql.append("select t.submittedinfo_title, ");
		sql.append("t.inputuser_name, ");
		sql.append("o.org_name, ");
		sql.append("t.keyword, ");
		sql.append("t.submit_content, ");
		sql.append("t.infotype_id, ");
		//是否是领导报送
		sql.append("t.leadedit_state,");
		sql.append("e.infotype_name, ");
		sql.append("to_char(t.input_date,'yyyy-mm-dd hh24:mi') as input_date, ");
		sql.append("t.is_recommend, ");
		sql.append("(select to_char(wmsys.wm_concat(u.user_id)) ");
		sql.append("          from ta_oa_infre_getinfo_user u ");
		sql.append("         where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("           and u.submittedinfo_typecode = '").append(InfoType.REPORTED_TEMPORARY).append("') reportunits, ");
		sql.append("       (select to_char(wmsys.wm_concat(s.user_realname)) ");
		sql.append("          from ta_oa_infre_getinfo_user u ");
		sql.append("          left join td_sm_user s on s.user_id = u.user_id ");
		sql.append("         where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("           and u.submittedinfo_typecode = '").append(InfoType.REPORTED_TEMPORARY).append("') reportunitsname, ");
		sql.append("  (select to_char(wmsys.wm_concat(u.user_id)) ");
		sql.append("from ta_oa_infre_getinfo_user u ");
		sql.append("where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and u.submittedinfo_typecode = '").append(InfoType.SENDAUDIT_TEMPORARY).append("') sendauditusers, ");
		sql.append("(select to_char(wmsys.wm_concat(s.user_realname)) ");
		sql.append("from ta_oa_infre_getinfo_user u ");
		sql.append("left join td_sm_user s on s.user_id = u.user_id ");
		sql.append("where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and u.submittedinfo_typecode = '").append(InfoType.SENDAUDIT_TEMPORARY).append("') sendauditusersname, ");
		sql.append("(select to_char(wmsys.wm_concat(u.user_id)) ");
		sql.append("from ta_oa_infre_getinfo_user u ");
		sql.append("where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and u.submittedinfo_typecode = '").append(InfoType.PUBLISHED_TEMPORARY).append("') partunits, ");
		sql.append("(select to_char(wmsys.wm_concat(s.user_realname)) ");
		sql.append("from ta_oa_infre_getinfo_user u ");
		sql.append("left join td_sm_user s on s.user_id = u.user_id ");
		sql.append("where u.submittedinfo_id = t.submittedinfo_id ");
		sql.append("and u.submittedinfo_typecode = '").append(InfoType.PUBLISHED_TEMPORARY).append("') partunitsname, ");
		sql.append("(select max(a.andit_time) ");
		sql.append("from ta_oa_infre_audit a ");
		sql.append("where a.submittedinfo_id = t.submittedinfo_id ");
		//sql.append("and a.andit_state = ? ");
		sql.append("group by a.submittedinfo_id) release_time ");
		sql.append("from ta_oa_infre_submitted_info t ");
		sql.append("  left join ta_oa_infre_info_type e on e.infotype_id = t.infotype_id ");
		sql.append("  inner join td_sm_organization o on o.org_id = t.department_id ");
		sql.append("where ");
		sql.append(" t.submittedinfo_id = ? ");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, submittedinfoId);
		pdb.executePrepared();
		
		InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
		if(pdb.size() > 0){
			infoReportBaseInfoBean.setSubmittedinfo_id(submittedinfoId);
			infoReportBaseInfoBean.setSubmittedinfo_title(pdb.getString(0, "submittedinfo_title"));
			infoReportBaseInfoBean.setInputuser_name(pdb.getString(0, "inputuser_name"));
			infoReportBaseInfoBean.setOrg_name(pdb.getString(0, "org_name"));
			infoReportBaseInfoBean.setKeyword(pdb.getString(0, "keyword"));
			infoReportBaseInfoBean.setSubmit_content(pdb.getString(0, "submit_content"));
			infoReportBaseInfoBean.setInfotype_id(pdb.getString(0, "infotype_id"));
			infoReportBaseInfoBean.setInfotype_name(pdb.getString(0, "infotype_name"));
			infoReportBaseInfoBean.setInput_date(pdb.getString(0, "input_date"));
			infoReportBaseInfoBean.setIs_recommend(pdb.getString(0, "is_recommend"));
			infoReportBaseInfoBean.setReportunits(pdb.getString(0, "reportunits"));
			infoReportBaseInfoBean.setReportunitsname(pdb.getString(0, "reportunitsname"));
			infoReportBaseInfoBean.setSendauditusers(pdb.getString(0, "sendauditusers"));
			infoReportBaseInfoBean.setSendauditusersname(pdb.getString(0, "sendauditusersname"));
			infoReportBaseInfoBean.setPartunits(pdb.getString(0, "partunits"));
			infoReportBaseInfoBean.setPartunitsname(pdb.getString(0, "partunitsname"));
			infoReportBaseInfoBean.setRelease_time(DateUtil.GetTimeString(pdb.getTimestamp(0, "release_time")));
			infoReportBaseInfoBean.setAndit_infos(findInfoReportAuditList(submittedinfoId,state));
			//是否是领导报送
			infoReportBaseInfoBean.setLeadedit_state(pdb.getString(0, "leadedit_state"));
		}
		
		return infoReportBaseInfoBean;
	}

	@Override
	public List<InfoReportAuditIdeaBean> findInfoReportAuditList(
			String submittedinfoId,String state) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.andit_person, t.andit_opinion, o.submittedinfo_typename, t.andit_time ");
		sql.append("  from ta_oa_infre_audit t ");
		sql.append(" inner join ta_oa_infre_submittedinfo_type o on to_number(t.andit_state) = ");
		sql.append("                                                to_number(o.submittedinfo_typecode) ");
		sql.append(" where t.submittedinfo_id = ? ");
		if(!StringUtil.nullOrBlank(state)){
			sql.append(" and t.andit_state = ? ");
		}
		sql.append(" order by t.andit_time desc ");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, submittedinfoId);
		if(!StringUtil.nullOrBlank(state)){
			pdb.setString(2, state);
		}
		pdb.executePrepared();
		List<InfoReportAuditIdeaBean> list = new ArrayList<InfoReportAuditIdeaBean>();
		for(int i = 0 ; i < pdb.size() ; i ++){
			InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
			infoReportAuditIdeaBean.setAndit_person(pdb.getString(i, "andit_person"));
			infoReportAuditIdeaBean.setAndit_opinion(pdb.getString(i, "andit_opinion"));
			infoReportAuditIdeaBean.setAndit_time(DateUtil.GetTimeStringFull(pdb.getTimestamp(i, "andit_time")));
			infoReportAuditIdeaBean.setAndit_state(pdb.getString(i, "submittedinfo_typename"));
			list.add(infoReportAuditIdeaBean);
		}
		return list;
	}
	
	@Override
	public List<InfoReportAuditIdeaBean> findInfoReportAuditListByUser(
			String submittedinfoId,String state,String userid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.andit_person, t.andit_opinion, o.submittedinfo_typename, t.andit_time ");
		sql.append("  from ta_oa_infre_audit t ");
		sql.append(" inner join ta_oa_infre_submittedinfo_type o on to_number(t.andit_state) = ");
		sql.append("                                                to_number(o.submittedinfo_typecode) ");
		sql.append(" where t.submittedinfo_id = ? and t.andit_opinion is not null");
		if(!StringUtil.nullOrBlank(state)){
			sql.append(" and t.andit_state in ("+state+") ");
		}
		if(!StringUtil.nullOrBlank(userid)){
			sql.append(" and t.andit_person_id = ? ");
		}
		sql.append(" order by t.andit_time desc ");
		
		pdb.preparedSelect(sql.toString());
		int j = 1;
		pdb.setString(j++, submittedinfoId);
		
		//if(!StringUtil.nullOrBlank(state)){
		//	pdb.setString(j++, state);
		//}
		if(!StringUtil.nullOrBlank(userid)){
			pdb.setString(j++, userid);
		}
		pdb.executePrepared();
		List<InfoReportAuditIdeaBean> list = new ArrayList<InfoReportAuditIdeaBean>();
		for(int i = 0 ; i < pdb.size() ; i ++){
			InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
			infoReportAuditIdeaBean.setAndit_person(pdb.getString(i, "andit_person"));
			infoReportAuditIdeaBean.setAndit_opinion(pdb.getString(i, "andit_opinion"));
			infoReportAuditIdeaBean.setAndit_time(DateUtil.GetTimeStringFull(pdb.getTimestamp(i, "andit_time")));
			infoReportAuditIdeaBean.setAndit_state(pdb.getString(i, "submittedinfo_typename"));
			list.add(infoReportAuditIdeaBean);
		}
		return list;
	}

	@Override
	public List<InfoReportAuditIdeaBean> findInfoReportAuditListByUserNotinstate(
			String submittedinfoId, String state, String userid)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.andit_person, t.andit_opinion, o.submittedinfo_typename, t.andit_time ");
		sql.append("  from ta_oa_infre_audit t ");
		sql.append(" inner join ta_oa_infre_submittedinfo_type o on to_number(t.andit_state) = ");
		sql.append("                                                to_number(o.submittedinfo_typecode) ");
		sql.append(" where t.submittedinfo_id = ? and t.andit_opinion is not null");
		if(!StringUtil.nullOrBlank(state)){
			sql.append(" and t.andit_state not in ("+state+") ");
		}
		if(!StringUtil.nullOrBlank(userid)){
			sql.append(" and t.andit_person_id = ? ");
		}
		sql.append(" order by t.andit_time desc ");
		
		pdb.preparedSelect(sql.toString());
		int j = 1;
		pdb.setString(j++, submittedinfoId);
		
		//if(!StringUtil.nullOrBlank(state)){
		//	pdb.setString(j++, state);
		//}
		if(!StringUtil.nullOrBlank(userid)){
			pdb.setString(j++, userid);
		}
		pdb.executePrepared();
		List<InfoReportAuditIdeaBean> list = new ArrayList<InfoReportAuditIdeaBean>();
		for(int i = 0 ; i < pdb.size() ; i ++){
			InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
			infoReportAuditIdeaBean.setAndit_person(pdb.getString(i, "andit_person"));
			infoReportAuditIdeaBean.setAndit_opinion(pdb.getString(i, "andit_opinion"));
			infoReportAuditIdeaBean.setAndit_time(DateUtil.GetTimeStringFull(pdb.getTimestamp(i, "andit_time")));
			infoReportAuditIdeaBean.setAndit_state(pdb.getString(i, "submittedinfo_typename"));
			list.add(infoReportAuditIdeaBean);
		}
		return list;
	}

	@Override
	public void saveInfoGetUser(String submittedinfoId, String getusers, String submittedinfo_typecode,Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		String submittedinfoTypecodeTemp = getSubmittedinfoTypecodeTemp(submittedinfo_typecode);//用于记录对应的暂存记录状态
		
		sql.append("delete from ta_oa_infre_getinfo_user t where t.submittedinfo_id = ? and t.submittedinfo_typecode in ('");
		sql.append(submittedinfo_typecode).append("','").append(submittedinfoTypecodeTemp).append("')");
		sql1.append("insert into ta_oa_infre_getinfo_user (id,submittedinfo_id,user_id,submittedinfo_typecode) values (seq_infre_getinfo_user.nextval,?,?,?)");
		
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, submittedinfoId);
		pdb.executePrepared(con);
		
		if(!StringUtil.nullOrBlank(getusers)){
			String[] partunitsArry = getusers.split(",");
			for(String partunit : partunitsArry){
				pdb.preparedInsert(sql1.toString());
				pdb.setString(1, submittedinfoId);
				pdb.setString(2, partunit);
				pdb.setString(3, submittedinfo_typecode);
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(con);

		}

		
	}

	@Override
	public List<GetInfoUserBean> findgetInfoUserList(String submittedinfoId,
			String submittedinfoTypecode) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		List<GetInfoUserBean> list = new ArrayList<GetInfoUserBean>();
		
		sql.append("select t.user_id, u.user_realname ");
		sql.append("from ta_oa_infre_getinfo_user t ");
		sql.append("inner join td_sm_user u on u.user_id = t.user_id ");
		sql.append("where t.submittedinfo_id = ? and t.submittedinfo_typecode = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, submittedinfoId);
		pdb.setString(2, getSubmittedinfoTypecodeTemp(submittedinfoTypecode));
		pdb.executePrepared();
		
		for(int i = 0 ; i < pdb.size() ; i ++){
			GetInfoUserBean giuBean = new GetInfoUserBean();
			giuBean.setGetinfouserid(pdb.getString(i, "user_id"));
			giuBean.setGetinfousername(pdb.getString(i, "user_realname"));
			
			list.add(giuBean);
		}

		return list;
	}

	
	@Override
	public GetInfoUserBean findUser4InfoReport(String submittedinfoId,
			String submittedinfTypecode) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select  a.andit_person,a.andit_person_id ");
		sql.append(" from ta_oa_infre_audit a  ");
		sql.append("where a.submittedinfo_id = ? ");
		sql.append("and a.andit_state = ? ");
		sql.append("order by a.andit_time desc ");
		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, submittedinfoId);
		pdb.setString(2, submittedinfTypecode);
		pdb.executePrepared();
		
		GetInfoUserBean bean = new GetInfoUserBean();
		if(pdb.size() > 0){
			bean.setGetinfouserid(pdb.getString(0, "andit_person_id"));
			bean.setGetinfousername(pdb.getString(0, "andit_person"));
		}
		
		
		return bean;
	}

	@Override
	public void setInfoGetUser4List(String submittedinfoId,
			String submittedinfoTypecode, Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		String submittedinfoTypecodeTemp = getSubmittedinfoTypecodeTemp(submittedinfoTypecode);//用于记录对应的暂存记录状态
		String submittedinfoTypecode4getuserinfo = submittedinfoTypecode;//当前操作状态对应的接收人状态
		
		sql.append(" update ta_oa_infre_getinfo_user t ");
		sql.append(" set t.submittedinfo_typecode = ? where t.submittedinfo_id = ? and t.submittedinfo_typecode = ?");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, submittedinfoTypecode4getuserinfo);
		pdb.setString(2, submittedinfoId);
		pdb.setString(3, submittedinfoTypecodeTemp);
		pdb.executePrepared();
	}
	
	public String getSubmittedinfoTypecodeTemp(String submittedinfoTypecode){
		String submittedinfoTypecodeTemp = "";//用于记录对应的暂存记录状态
		if(InfoType.NOT_BE_DEALWITH.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.REPORTED_TEMPORARY;
		if(InfoType.NOT_BE_DEALWITH_REAUDIT.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.SENDAUDIT_TEMPORARY;
		if(InfoType.NOT_BE_VIEW.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.PUBLISHED_TEMPORARY;
		return submittedinfoTypecodeTemp;
	}
	
	
	public String getSubmittedinfoTypecode4getuserinfo(String submittedinfoTypecode){
		String submittedinfoTypecodeTemp = "";//用于记录对应的暂存记录状态
		if(InfoType.HAS_BE_REPORTED.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.NOT_BE_DEALWITH;
		if(InfoType.HAS_BE_SUBMITTED.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.NOT_BE_DEALWITH;
		if(InfoType.HAS_BE_PUBLISHED.equals(submittedinfoTypecode))
			submittedinfoTypecodeTemp = InfoType.NOT_BE_VIEW;
		return submittedinfoTypecodeTemp;
	}
	
	/**
	 * 删除信息上报草稿信息 退稿回来的信息也允许删除。
	 * @param submittedinfoIds
	 * @param infoReportBaseInfoBean
	 */
	public void DeleteDrafInfo(String submittedinfo_id, InfoReportBaseInfoBean infoReportBaseInfoBean,Connection con) throws Exception{
		//政务信息报送审核表
		StringBuffer sqlAudit = new StringBuffer();
		sqlAudit.append(" delete from ta_oa_infre_audit ");
		sqlAudit.append(" where submittedinfo_id in ");
		sqlAudit.append("       (?)");
		PreparedDBUtil pdbAudit = new PreparedDBUtil();
		pdbAudit.preparedUpdate(sqlAudit.toString());
		pdbAudit.setString(1, submittedinfo_id);
		pdbAudit.executePrepared(con);
		
		//信息接收人员表
		StringBuffer sqlUser = new StringBuffer();
		sqlUser.append(" delete from ta_oa_infre_getinfo_user ");
		sqlUser.append(" where submittedinfo_id in ");
		sqlUser.append("       (?)");
		PreparedDBUtil pdbUser = new PreparedDBUtil();
		pdbUser.preparedUpdate(sqlUser.toString());
		pdbUser.setString(1, submittedinfo_id);
		pdbUser.executePrepared(con);
		
		
		//信息上报主表
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_infre_submitted_info ");
		sql.append(" where submittedinfo_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, submittedinfo_id);
		pdb.executePrepared(con);
		
	}
}

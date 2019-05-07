package com.chinacreator.xtbg.core.news.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.news.dao.newsDao;
import com.chinacreator.xtbg.core.news.entity.archiveBean;
import com.chinacreator.xtbg.core.news.entity.newsBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class newsDaoImpl extends XtDbBaseDao implements newsDao {
	@Override
	public PagingBean findNewsReleaseListPageBean(newsBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("  select t.*, to_char(h.cyrq,'yyyy-mm-dd') cyrq,");
			sql.append("  case h.sfcy when 'value2' then '是' when 'value3' then '否' end sfcy,(select count(*) from oa_news n where t.ins_id=n.ins_id ) as is_replys,");
			sql.append(" s.org_name from oa_flow_instance t,td_sm_organization s,hbtj_xxfbspd h where t.org_id=s.org_id and h.t_id=t.busi_id ");
			sql.append(" and t.status_code ='02' and t.busitype_code='XXFBSP'  ");
			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getN_title())) {
				sql.append("and t.ins_name like '%"+bean.getN_title()+"%' ");
			}
			sql.append(" order by " + sortName + " " + sortOrder);

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	@Override
	public PagingBean findNewsReleaseListPageBeanforIndex(newsBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)throws Exception {
	Connection conn = null;
	try {
		conn = DbManager.getInstance().getConnection();
		List<String> conditionValues = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select n_id,n_title,n_org_name,to_char(b.n_date,'yyyy-mm-dd hh24:mi') n_date from oa_news b where 1=1");
		// 拼接的值
		if (!StringUtil.nullOrBlank(bean.getN_title())) {
			sql.append("and n_title like '%"+bean.getN_title()+"%' ");
		}
		sql.append(" order by " + sortName + " " + sortOrder);

		// 调父类的方法
		return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
				conditionValues);
	} finally {
		DbManager.closeConnection(conn);
	}
	}
	
	@Override
	public PagingBean findNewsCountListPageBean(newsBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("select distinct (accept_time), ");
			sqlStr.append("                ins_id, ");
			sqlStr.append("                busi_id, ");
			sqlStr.append("                busitype_name, ");
			sqlStr.append("                busitype_type_name, ");
			sqlStr.append("                ins_name, ");
			sqlStr.append("                accepter, ");
			sqlStr.append("                act_name, ");
			sqlStr.append("                action_form, ");
			sqlStr.append("                busitype_code, ");
			sqlStr.append("                status_name, ");
			sqlStr.append("                act_insid, ");
			sqlStr.append("                flow_id, ");
			sqlStr.append("                template_id, ");
			sqlStr.append("                def_id, ");
			sqlStr.append("                processid, ");
			sqlStr.append("                action_handername, ");
			sqlStr.append("                busitype_order, ");
			sqlStr.append("                act_index, ");
			sqlStr.append("                xxfb_sqsj, ");
			sqlStr.append("                cyrq, ");
			sqlStr.append("                xxfb_ngdw, ");
			sqlStr.append("                sfcy_name,sfcy,send_type_name, ");
			sqlStr.append("                send_type ");
			sqlStr.append("  from (select distinct (i.accept_time) accept_time, ");
			sqlStr.append("                        i.ins_id, ");
			sqlStr.append("                        i.busi_id, ");
			sqlStr.append("                        i.busitype_name, ");
			sqlStr.append("                        b_type.busitype_type_name, ");
			sqlStr.append("                        i.ins_name, ");
			sqlStr.append("                        i.accepter, ");
			sqlStr.append("                        i.action_name as act_name, ");
			sqlStr.append("                        i.action_form, ");
			sqlStr.append("                        i.busitype_code, ");
			sqlStr.append("                        s.status_name, ");
			sqlStr.append("                        i.act_insid, ");
			sqlStr.append("                        i.flow_id, ");
			sqlStr.append("                        i.template_id, ");
			sqlStr.append("                        i.def_id, ");
			sqlStr.append("                        i.processid, ");
			sqlStr.append("                        i.action_handername, ");
			sqlStr.append("                        f_type.busitype_order busitype_order, ");
			sqlStr.append("                        ROW_NUMBER() OVER(partition by ins_id ORDER BY TACHE_END_TIME DESC) act_index, ");
			//sqlStr.append("                        sp.xxfb_sqsj, ");
			//sqlStr.append("                        sp.cyrq, ");
			sqlStr.append("                        decode(sp.xxfb_sqsj,null,i.ACCEPT_TIME,sp.xxfb_sqsj)as xxfb_sqsj,");
			sqlStr.append("                        decode(sp.cyrq,null,i.TACHE_END_TIME,sp.cyrq)as cyrq,");
			sqlStr.append("                        sp.xxfb_ngdw, ");
			sqlStr.append("                        case sp.sfcy when  'value2' then '是' else '否' end as sfcy_name, ");
			sqlStr.append("                        sp.sfcy as sfcy, ");
			sqlStr.append("                         case sp.xxfb_ymhwz ");
			sqlStr.append("                          when 'value1' then  '院门户网站' ");
			sqlStr.append("                         when 'value2' then  '省局门户网站'  ");
			sqlStr.append("                        when 'value3' then  '其他网站'  ");
			sqlStr.append("                        when 'value4' then  '内部信息发布' ");
			sqlStr.append("                        when 'value5' then  '院微博发布' else '' end as send_type_name, ");
			sqlStr.append("                        sp.xxfb_ymhwz as send_type ");
			sqlStr.append("          from view_oa_instance      i, ");
			sqlStr.append("               oa_flow_status        s, ");
			sqlStr.append("               oa_flow_busitype      f_type, ");
			sqlStr.append("               oa_flow_busitype_type b_type, ");
			sqlStr.append("               hbtj_xxfbspd sp ");
			sqlStr.append("         where i.status_code = s.status_code ");
			sqlStr.append("           and i.busitype_code = f_type.busitype_code ");
			sqlStr.append("           and f_type.busitype_type_code = b_type.busitype_type_code ");
			sqlStr.append("           and i.is_valid = 'Y' ");
			sqlStr.append("           and sp.t_id = i.BUSI_ID ");
			sqlStr.append("           and i.action_handername is not null  and i.status_code = '02'");
			sqlStr.append("           ) t ");
			sqlStr.append(" where 1 = 1 ");
			sqlStr.append("   and t.act_index = 1 ");
			sqlStr.append("   and BUSITYPE_CODE='XXFBSP' ");

			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getN_title())) {
				sqlStr.append("and ins_name like '%"+bean.getN_title()+"%' ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_username())) {
				sqlStr.append("and accepter like '%"+bean.getN_username()+"%' ");
			}
			//所属部门
			if (!StringUtil.nullOrBlank(bean.getN_org_name())) {
				sqlStr.append("and xxfb_ngdw like '%"+bean.getN_org_name()+"%' ");
			}
			//采用日期
			if (!StringUtil.nullOrBlank(bean.getN_date())) {
				sqlStr.append("and cyrq >= to_date('"+bean.getN_date()+"','yyyy-mm-dd') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_date_end())) {
				sqlStr.append("and cyrq <= to_date('"+bean.getN_date_end()+"','yyyy-mm-dd hh24:mi') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_apply_date())) {
				sqlStr.append("and xxfb_sqsj >= to_date('"+bean.getN_apply_date()+"','yyyy-mm-dd') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_apply_date_end())) {
				sqlStr.append("and xxfb_sqsj <= to_date('"+bean.getN_apply_date_end()+"','yyyy-mm-dd hh24:mi') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_release_type())) {
				sqlStr.append("and send_type = '"+bean.getN_release_type()+"' ");
			}
			if (!StringUtil.nullOrBlank(bean.getIs_reply())) {
				sqlStr.append("and sfcy = '"+bean.getIs_reply()+"' ");
			}
			sqlStr.append(" order by " + sortName + " " + sortOrder);

			// 调父类的方法
			return queryToPagingBean(sqlStr.toString(), offset, maxPagesize, conn,conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	@Override
	public ResultMap<ResultCode, archiveBean> getLook(String ins_id) {
			StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("select distinct (accept_time), ");
			sqlStr.append("                ins_id, ");
			sqlStr.append("                busi_id, ");
			sqlStr.append("                busitype_name, ");
			sqlStr.append("                busitype_type_name, ");
			sqlStr.append("                ins_name, ");
			sqlStr.append("                accepter, ");
			sqlStr.append("                act_name, ");
			sqlStr.append("                action_form, ");
			sqlStr.append("                busitype_code, ");
			sqlStr.append("                status_name, ");
			sqlStr.append("                act_insid, ");
			sqlStr.append("                flow_id, ");
			sqlStr.append("                template_id, ");
			sqlStr.append("                def_id, ");
			sqlStr.append("                processid, ");
			sqlStr.append("                action_handername, ");
			sqlStr.append("                busitype_order, ");
			sqlStr.append("                act_index, ");
			sqlStr.append("                xxfb_sqsj, ");
			sqlStr.append("                cyrq, ");
			sqlStr.append("                xxfb_ngdw, ");
			sqlStr.append("                sfcy_name,sfcy,send_type_name, ");
			sqlStr.append("                send_type ");
			sqlStr.append("  from (select distinct (i.accept_time) accept_time, ");
			sqlStr.append("                        i.ins_id, ");
			sqlStr.append("                        i.busi_id, ");
			sqlStr.append("                        i.busitype_name, ");
			sqlStr.append("                        b_type.busitype_type_name, ");
			sqlStr.append("                        i.ins_name, ");
			sqlStr.append("                        i.accepter, ");
			sqlStr.append("                        i.action_name as act_name, ");
			sqlStr.append("                        i.action_form, ");
			sqlStr.append("                        i.busitype_code, ");
			sqlStr.append("                        s.status_name, ");
			sqlStr.append("                        i.act_insid, ");
			sqlStr.append("                        i.flow_id, ");
			sqlStr.append("                        i.template_id, ");
			sqlStr.append("                        i.def_id, ");
			sqlStr.append("                        i.processid, ");
			sqlStr.append("                        i.action_handername, ");
			sqlStr.append("                        f_type.busitype_order busitype_order, ");
			sqlStr.append("                        ROW_NUMBER() OVER(partition by ins_id ORDER BY TACHE_END_TIME DESC) act_index, ");
			sqlStr.append("                        sp.xxfb_sqsj, ");
			sqlStr.append("                        sp.cyrq, ");
			sqlStr.append("                        sp.xxfb_ngdw, ");
			sqlStr.append("                        case sp.sfcy when  'value2' then '是' else '否' end as sfcy_name, ");
			sqlStr.append("                        sp.sfcy as sfcy, ");
			sqlStr.append("                         case sp.xxfb_ymhwz ");
			sqlStr.append("                          when 'value1' then  '院门户网站' ");
			sqlStr.append("                         when 'value2' then  '省局门户网站'  ");
			sqlStr.append("                        when 'value3' then  '其他网站'  ");
			sqlStr.append("                        when 'value4' then  '内部信息发布' ");
			sqlStr.append("                        when 'value5' then  '院微博发布' else '' end as send_type_name, ");
			sqlStr.append("                        sp.xxfb_ymhwz as send_type ");
			sqlStr.append("          from view_oa_instance      i, ");
			sqlStr.append("               oa_flow_status        s, ");
			sqlStr.append("               oa_flow_busitype      f_type, ");
			sqlStr.append("               oa_flow_busitype_type b_type, ");
			sqlStr.append("               hbtj_xxfbspd sp ");
			sqlStr.append("         where i.status_code = s.status_code ");
			sqlStr.append("           and i.busitype_code = f_type.busitype_code ");
			sqlStr.append("           and f_type.busitype_type_code = b_type.busitype_type_code ");
			sqlStr.append("           and i.is_valid = 'Y' ");
			sqlStr.append("           and sp.t_id = i.BUSI_ID ");
			sqlStr.append("           and i.action_handername is not null  and i.status_code = '02'");
			sqlStr.append("           ) t ");
			sqlStr.append(" where 1 = 1 ");
			sqlStr.append("   and t.act_index = 1 ");
			sqlStr.append("   and BUSITYPE_CODE='XXFBSP' ");
			sqlStr.append("   and ins_id='"+ins_id+"'  ");
			PreparedDBUtil pb = new PreparedDBUtil();
			archiveBean bean = new archiveBean();
			ResultMap<ResultCode, archiveBean> result = new ResultMap<ResultCode, archiveBean>();
			try {
				pb.preparedSelect(sqlStr.toString());
				pb.executePrepared();
				for(int i=0;i<pb.size();i++){
					bean.setAct_name(pb.getString(i, "act_name"));
					bean.setAction_form(pb.getString(i, "action_form"));
					bean.setTemplate_id(pb.getString(i, "template_id"));
					bean.setBusi_id(pb.getString(i, "busi_id"));
					bean.setBusiTypeCode(pb.getString(i, "busitype_code"));
					bean.setIns_id(pb.getString(i, "ins_id"));
					bean.setIns_name(pb.getString(i, "ins_name"));
				}
				result.setCode(ResultCode.OK);
				result.setResult(bean);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
	}
	
	@Override
	public boolean insertNews(newsBean bean) {
		PreparedDBUtil pb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		boolean flag = false;
		sql.append("insert into OA_NEWS values( ");
		sql.append(" ?,?,?,?,sysdate,?,?,1)");
		try {
			pb.preparedInsert(sql.toString());
			pb.setString(1, StringUtil.getUUID());
			pb.setString(2, bean.getN_title());
			pb.setString(3, bean.getN_org_id());
			pb.setString(4, bean.getN_org_name());
			pb.setString(5, bean.getN_content());
			pb.setString(6, bean.getIns_id());
			pb.executePrepared();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	@Override
	public Map<String, String> queryNews(String id) {
		Map<String, String> map = new HashMap<String, String>();
		PreparedDBUtil pb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select b.n_title,b.n_id,b.n_org_id,b.n_org_name,");
		sql.append("  to_char(b.n_date,'yyyy-mm-dd hh24:mi') n_date,b.n_content from oa_news b ");
		sql.append("  where b.n_id = '"+id+"' ");
		try {
			pb.preparedSelect(sql.toString());
			pb.executePrepared();
			for(int i=0;i<pb.size();i++){
				map.put("n_title", pb.getString(i, "n_title"));
				map.put("n_id", pb.getString(i, "n_id"));
				map.put("n_content", pb.getString(i, "n_content"));
				map.put("n_org_id", pb.getString(i, "n_org_id"));
				map.put("n_org_name", pb.getString(i, "n_org_name"));
				map.put("n_date", pb.getString(i, "n_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}
	@Override
	public boolean deleteNews(String id) {
		PreparedDBUtil pb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		boolean flag = false;
		sql.append(" delete  from oa_news b ");
		sql.append("  where b.n_id = '"+id+"' ");
		try {
			pb.preparedDelete(sql.toString());
			pb.executePrepared();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	@Override
	public String queryNewsCount(newsBean bean) {
		String result = "";
			StringBuffer sqlStr = new StringBuffer();
			StringBuffer sqlIsP = new StringBuffer();
			sqlIsP.append("select count(t.t_id)  from hbtj_xxfbspd t,oa_flow_instance t1 where t.t_id=t1.busi_id and t1.status_code='02' ");
			sqlIsP.append(" and t.sfcy ='value2' ");
			
			sqlStr.append(" select count(t.t_id) from hbtj_xxfbspd t,oa_flow_instance t1 where t.t_id=t1.busi_id and t1.status_code='02'  ");
			// 拼接的值
			if (!StringUtil.nullOrBlank(bean.getN_title())) {
				sqlIsP.append( " and t.xxfb_gjbt like '%"+bean.getN_title()+"%' ");
				sqlStr.append( " and t.xxfb_gjbt like '%"+bean.getN_title()+"%' ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_username())) {
				sqlIsP.append(" and  t.xxfb_ngr like '%"+bean.getN_username()+"%' ");
				sqlStr.append(" and  t.xxfb_ngr like '%"+bean.getN_username()+"%' ");
			}
			//所属部门
			if (!StringUtil.nullOrBlank(bean.getN_org_name())) {
				sqlIsP.append(" and t.xxfb_ngdw like '%"+bean.getN_org_name()+"%' ");
				sqlStr.append(" and t.xxfb_ngdw like '%"+bean.getN_org_name()+"%' ");
			}
			//采用日期
			if (!StringUtil.nullOrBlank(bean.getN_date())) {
				sqlIsP.append("and t.cyrq >= to_date('"+bean.getN_date()+"','yyyy-mm-dd') ");
				sqlStr.append("and t.cyrq >= to_date('"+bean.getN_date()+"','yyyy-mm-dd') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_date_end())) {
				sqlIsP.append("and t.cyrq <= to_date('"+bean.getN_date_end()+"','yyyy-mm-dd hh24:mi') ");
				sqlStr.append("and t.cyrq <= to_date('"+bean.getN_date_end()+"','yyyy-mm-dd hh24:mi') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_apply_date())) {
				sqlIsP.append("and t.xxfb_sqsj >= to_date('"+bean.getN_apply_date()+"','yyyy-mm-dd') ");
				sqlStr.append("and t.xxfb_sqsj >= to_date('"+bean.getN_apply_date()+"','yyyy-mm-dd') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_apply_date_end())) {
				sqlIsP.append("and t.xxfb_sqsj <= to_date('"+bean.getN_apply_date_end()+"','yyyy-mm-dd hh24:mi') ");
				sqlStr.append("and t.xxfb_sqsj <= to_date('"+bean.getN_apply_date_end()+"','yyyy-mm-dd hh24:mi') ");
			}
			if (!StringUtil.nullOrBlank(bean.getN_release_type())) {
				sqlIsP.append("and t.xxfb_ymhwz = '"+bean.getN_release_type()+"' ");
				sqlStr.append("and t.xxfb_ymhwz = '"+bean.getN_release_type()+"' ");
			}
			if (!StringUtil.nullOrBlank(bean.getIs_reply())) {
				sqlIsP.append("and t.sfcy = '"+bean.getIs_reply()+"' ");
				sqlStr.append("and t.sfcy = '"+bean.getIs_reply()+"' ");
			}

			try {
				String isp = DaoUtil.SqlToField(sqlIsP.toString());
				String count = DaoUtil.SqlToField(sqlStr.toString());
				int a =Integer.parseInt(count);
				int b =Integer.parseInt(isp);
				int c = a-b;
				result = count+","+isp+","+c;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
	}
}

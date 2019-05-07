package com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoStaDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoStaBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.DictDropDownList;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>
 * Title:InfoTypeDaoImpl.java
 * </p>
 *<p>
 * Description:信息类型Dao接口实现类
 * </p>
 *<p>
 * Copyright:Copyright (c) 2012
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author weiwei.liu
 *@version 1.0
 *@date 2012-2-24
 */
public class InfoStaDaoImpl implements InfoStaDao {

	private static final Logger LOG = Logger.getLogger(InfoStaDaoImpl.class);

	/**
	 * @Description 根据条件查询信息类型 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findInfoStaList(InfoStaBean infoStaBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<InfoStaBean> list = new ArrayList<InfoStaBean>();
		StringBuffer sql = new StringBuffer();
		
		
		sql.append("select * ");
		sql.append("  from (select o.org_name,o.org_id, ");
		sql.append("    (select count(*) ");
		sql.append("       from ta_oa_infre_audit a ");
		sql.append("      inner join td_sm_orguser u on a.andit_person_id = u.user_id ");
		sql.append("      inner join ta_oa_infre_submitted_info i on i.submittedinfo_id = ");
		sql.append("                                                 a.submittedinfo_id ");
		sql.append("      where u.org_id = o.org_id ");
		sql.append("        and a.andit_state = '2' ");
		if (!StringUtil.nullOrBlank(infoStaBean.getInfotype_id())) {
			sql.append("        and i.infotype_id = '"+infoStaBean.getInfotype_id()+"'");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getInput_date())) {
			sql.append("  a.andit_time > to_date('").append(infoStaBean.getInput_date()).append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getEnd_date())) {
			sql.append("  a.andit_time < to_date('").append(infoStaBean.getEnd_date() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append("    ) as upNum, ");
		sql.append("    (select count(*) ");
		sql.append("       from ta_oa_infre_audit a ");
		sql.append("      inner join td_sm_orguser u on a.andit_person_id = u.user_id ");
		sql.append("      inner join ta_oa_infre_submitted_info i on i.submittedinfo_id = ");
		sql.append("                                                 a.submittedinfo_id ");
		sql.append("      where u.org_id = o.org_id ");
		sql.append("        and a.andit_state = '6' ");
		if (!StringUtil.nullOrBlank(infoStaBean.getInfotype_id())) {
			sql.append("        and i.infotype_id = '"+infoStaBean.getInfotype_id()+"'");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getInput_date())) {
			sql.append("  a.andit_time > to_date('").append(infoStaBean.getInput_date()).append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getEnd_date())) {
			sql.append("  a.andit_time < to_date('").append(infoStaBean.getEnd_date() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append("     ) as publishNum, ");
		if (!StringUtil.nullOrBlank(infoStaBean.getInfotype_id())) {
			sql.append("    (select t.infotype_name ");
			sql.append("       from ta_oa_infre_info_type t ");
			sql.append("      where t.infotype_id = '"+infoStaBean.getInfotype_id()+"') as infotype ");
		}else{
			sql.append("      '所有类型' as infotype ");
		}
		sql.append("from td_sm_organization o  where 1=1 ");
		if (!StringUtil.nullOrBlank(infoStaBean.getOrg_name())) {
			sql.append("and o.org_name like ? ");
		}
		sql.append(") ");
		sql.append("where upNum > 0 ");
		sql.append("or publishNum > 0 ");

		sql.append(" order by " + sortName + " " + sortOrder);

		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			int j = 1;
			if (!StringUtil.nullOrBlank(infoStaBean.getOrg_name())) {
				db.setString(j++, "%"+infoStaBean.getOrg_name()+"%");
			}
			
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				InfoStaBean ifs = new InfoStaBean();
				ifs.setInfotype(db.getString(i, "infotype"));
				ifs.setUpNum(db.getString(i, "upNum"));
				ifs.setPublishNum(db.getString(i, "publishNum"));
				ifs.setOrg_name(db.getString(i, "org_name"));
				list.add(ifs);
			}
		} catch (SQLException e) {
			LOG.error("执行信息类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;

	}

	/**
	 * 详细统计列表
	 * 
	 * @param infoStaBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findInfoStaDetailList(InfoStaBean infoStaBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<InfoStaBean> list = new ArrayList<InfoStaBean>();
		StringBuffer sql = new StringBuffer();

		sql.append(" select o.org_name,");
		sql.append("  i.submittedinfo_title,");
		sql.append("  to_date(i.input_date) as input_date ,");
		sql.append("  t.infotype_name,");
		sql.append("  i.submittedinfo_typecode,");
		sql.append("  decode(i.submittedinfo_typecode, 5, '已采用', '未采用') as usetype");
		sql.append("  from ta_oa_infre_submitted_info i");
		sql.append("  left join td_sm_organization o on i.org_id = o.org_id");
		sql.append("  left join ta_oa_infre_info_type t on i.infotype_id = t.infotype_id");
		sql.append("  where ( i.submittedinfo_typecode='2'");
		sql.append("  or i.submittedinfo_typecode='5' ) ");
		if (!StringUtil.nullOrBlank(infoStaBean.getOrg_id())) {
			sql.append(" and i.org_id = '" + infoStaBean.getOrg_id() + "'");
		}
		if ("all".equals(infoStaBean.getStatus())) {
			sql.append("  ");
		}else if("used".equals(infoStaBean.getStatus())) {
			sql.append(" and i.submittedinfo_typecode=5 ");
		}else if("unused".equals(infoStaBean.getStatus())) {
			sql.append(" and i.submittedinfo_typecode != 5 ");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getInfotype_id())) {
			sql.append(" and i.infotype_id = '" + infoStaBean.getInfotype_id() + "'");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getInput_date())) {
			sql.append(" and i.input_date > to_date('").append(infoStaBean.getInput_date()).append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(infoStaBean.getEnd_date())) {
		
			sql.append(" and i.input_date < to_date('").append(infoStaBean.getEnd_date() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				InfoStaBean ifs = new InfoStaBean();
				ifs.setTitle(db.getString(i, "submittedinfo_title"));
				ifs.setInput_date(DateUtil.GetTimeString(db.getTimestamp(i, "input_date")));
				ifs.setInfotype(db.getString(i, "infotype_name"));
				ifs.setOrg_name(db.getString(i, "org_name"));
				ifs.setUsetype(db.getString(i, "usetype"));
				list.add(ifs);
			}
		} catch (SQLException e) {
			LOG.error("执行信息类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

	/**
	 * @Description 添加信息类型
	 * @param InfoTypeBean
	 *            信息类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void addInfoType(InfoTypeBean infoTypeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ta_oa_infre_info_type");
		buf
				.append("                (infotype_id, infotype_name, infotype_source, infotype_desc)");
		buf.append(" values(seq_infre_info_type.nextval, ");
		buf.append("	    ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, infoTypeBean.getInfotype_name());
		db.setString(2, infoTypeBean.getInfotype_source());
		db.setString(3, infoTypeBean.getInfotype_desc());
		db.executePrepared();
	}

	/**
	 * @Description 删除信息类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean delInfoType(String infotype_id) throws SQLException {
		String sql = "delete from ta_oa_infre_info_type where infotype_id in ("
				+ infotype_id + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;

	}

	/**
	 * @Description 修改信息类型
	 * @param InfoTypeBean
	 *            信息类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void updateInfoType(InfoTypeBean infoTypeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();

		buf.append(" update ta_oa_infre_info_type ");
		buf.append("        set infotype_name = ?, infotype_desc = ?");
		buf.append("  where infotype_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, infoTypeBean.getInfotype_name());
		db.setString(2, infoTypeBean.getInfotype_desc());
		db.setString(3, infoTypeBean.getInfotype_id());
		db.executePrepared();

	}

	/**
	 * @Description 根据用户ID获得信息类型
	 * @param userBean
	 *            用户Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public InfoTypeBean getInfoTypeBeanById(String id) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		infotype_id,");
		sql.append(" 		infotype_name,");
		sql.append(" 		infotype_source,");
		sql.append(" 		infotype_desc");
		sql.append(" from ta_oa_infre_info_type ");
		sql.append("      where infotype_id= ?");
		PreparedDBUtil db = new PreparedDBUtil();
		InfoTypeBean infoTypeBean = new InfoTypeBean();
		db.preparedSelect(sql.toString());
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			infoTypeBean.setInfotype_id(db.getString(i, "infotype_id"));
			infoTypeBean.setInfotype_name(db.getString(i, "infotype_name"));
			infoTypeBean.setInfotype_source(db.getString(i, "infotype_source"));
			infoTypeBean.setInfotype_desc(db.getString(i, "infotype_desc"));
		}
		return infoTypeBean;

	}

	/**
	 * 获得信息类型select
	 */
	public String getTypeSelectHtml() throws Exception {
		StringBuffer sql = new StringBuffer();
		sql
				.append(" select infotype_id,infotype_name from ta_oa_infre_info_type ");
		String sceneTypeList = DictDropDownList.buildSelect(sql.toString(),
				"cbox2", "", "", true, "");
		return sceneTypeList;
	}

}

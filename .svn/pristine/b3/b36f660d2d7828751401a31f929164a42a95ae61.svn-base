package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.dao.SplitLogDao;
import com.chinacreator.xtbg.core.archive.entity.SplitLogBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:SplitLogDaoImpl.java</p>
 *<p>Description:拆分记录接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class SplitLogDaoImpl implements SplitLogDao {

	@Override
	public void insert(SplitLogBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_split_log");
		sql.append("  (split_log_id, buss_id, parent_id, unit_id, file_name, file_path, file_size, created, user_id)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-mm-dd'), ?)");
		
		SqlUtil<SplitLogBean> sqlUtil = new SqlUtil<SplitLogBean>();
		sqlUtil.executeInsert(sql.toString(), bean, con);
	}

	@Override
	public PagingBean list(SplitLogBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select c.split_log_id,");
		sql.append("       c.buss_id,");
		sql.append("       c.parent_id,");
		sql.append("       c2.file_name parent_name,");
		sql.append("       c.unit_id,");
		sql.append("       c1.unit_name unit_name,");
		sql.append("       c1.gwcs_org_id gwcs_org_id,");
		sql.append("       o.org_name gwcs_org_name,");
		sql.append("       c.file_name,");
		sql.append("       c.file_path,");
		sql.append("       c.file_size,");
		sql.append("       to_char(c.created,'yyyy-mm-dd') created,");
		sql.append("       c.user_id,");
		sql.append("       u.user_realname user_name");
		sql.append("  from oa_split_log c");
		sql.append("  left join oa_split_unit c1 on c.unit_id = c1.unit_id");
		sql.append("  left join oa_gwcs_org o on c1.gwcs_org_id = o.org_id");
		sql.append("  left join oa_split_log c2 on c.parent_id = c2.split_log_id");
		sql.append("  left join td_sm_user u on c.user_id = u.user_id where 1=1");
		if(!StringUtil.isBlank(bean.getFile_name())){
			sql.append(" and c.file_name like ? ");
			bean.setFile_name("%"+bean.getFile_name()+"%");
		}
		if(!StringUtil.isBlank(bean.getParent_id())){
			sql.append(" and c.parent_id = ? ");
		} else {
			sql.append(" and c.parent_id is null ");
		}
		sql.append("  order by c.created desc ");
		SqlUtil<SplitLogBean> sqlUtil = new SqlUtil<SplitLogBean>();
		PagingBean pageBean = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		
		return pageBean;
	}

	@Override
	public void deleteByBussidAndFileName(SplitLogBean bean, Connection con) throws Exception {
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete ");
		sql.append(" oa_split_log c");
		sql.append(" where (c.buss_id  ");
		if(!StringUtil.isBlank(bean.getBuss_id())){
			sql.append(" = ? ");
		} else {
			sql.append(" is null ");
		}
		sql.append(" and c.file_name = ?)");
		sql.append("    or c.parent_id in (select c2.split_log_id");
		sql.append("                         from oa_split_log c2");
		sql.append("                        where c2.buss_id ");
		if(!StringUtil.isBlank(bean.getBuss_id())){
			sql.append(" = ? ");
		} else {
			sql.append(" is null ");
		}
		sql.append("                          and c2.file_name = ?)");
		
		SqlUtil<SplitLogBean> sqlUtil = new SqlUtil<SplitLogBean>();
		sqlUtil.executeDelete(sql.toString(), bean, con);
	}

	@Override
	public List<SplitLogBean> getGwcsOrg(SplitLogBean bean,Connection con ) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select s.split_log_id,");
		sql.append("               s.unit_id,");
		sql.append("               s.buss_id,");
		sql.append("               s.parent_id,");
		sql.append("               s.file_name,");
		sql.append("               s.file_path,");
		sql.append("               s.file_size,");
		sql.append("               to_char(s.created,'yyyy-mm-dd') created,");
		sql.append("               s.user_id");
		sql.append("          from oa_split_log s");
		sql.append("          left join oa_split_unit u1 on s.unit_id = u1.unit_id");
		sql.append("         where u1.gwcs_org_id is not null");
		sql.append("         and s.buss_id = ?");
		SqlUtil<SplitLogBean> sqlUtil = new SqlUtil<SplitLogBean>();
		List<SplitLogBean> list = sqlUtil.executeForList(sql.toString(), bean, con);
		return list;
	}
}

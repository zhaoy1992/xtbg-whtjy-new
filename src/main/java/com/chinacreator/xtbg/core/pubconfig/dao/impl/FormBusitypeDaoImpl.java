package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao;
import com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FormBusitypeDapImpl.java</p>
 *<p>Description:表单业务类型接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-29
 */
public class FormBusitypeDaoImpl extends XtDbBaseDao implements FormBusitypeDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selFormBusitypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao#selFormBusitypeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selFormBusitypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		FormBusitypebean formBusitypebean= new FormBusitypebean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				formBusitypebean = (FormBusitypebean) JSONObject.parseObject(parmjson, FormBusitypebean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select * ");
			sql.append("  from oa_form_busitype b");
			sql.append("  where 1=1");
			
			if(formBusitypebean!=null){
				if (!StringUtil.nullOrBlank(formBusitypebean.getBusitype_name())) {
					//sql.append(" and b.f_program_page like '%" + fileProgramPageBean.getF_program_page() + "%'");
					sql.append(" and b.busitype_name like '%'||?||'%'");
					condition.add(formBusitypebean.getBusitype_name());
				}
				
				sql.append(" order by " + sortName + " " + sortOrder);
				}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFormBusitypeInfoById
	  * @param busitype_code
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao#findFormBusitypeInfoById(java.lang.String)
	 */
	public FormBusitypebean findFormBusitypeInfoById(String busitype_code)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		t.busitype_code,");
		sql.append(" 		t.busitype_name,");
		sql.append(" 		t.type_desc,");
		sql.append(" 		t.is_valid,");
		sql.append(" 		o.table_name,");
		sql.append(" 		t.table_id ");
		sql.append(" from oa_form_busitype t ");
		sql.append(" left join oa_md_table o on o.table_id = t.table_id ");
		sql.append(" where t.busitype_code = ?  ");
		FormBusitypebean fbb = new FormBusitypebean();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, busitype_code);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fbb.setBusitype_code(StringUtil.deNull(pdb.getString(0, "busitype_code")));
			fbb.setBusitype_name(StringUtil.deNull(pdb.getString(0, "busitype_name")));
			fbb.setType_desc(StringUtil.deNull(pdb.getString(0, "type_desc")));
			fbb.setIs_valid(StringUtil.deNull(pdb.getString(0, "is_valid")));
			fbb.setTable_name(pdb.getString(0, "table_name"));
			fbb.setTable_id(pdb.getString(0, "table_id"));
		}
		return fbb;
	}

}

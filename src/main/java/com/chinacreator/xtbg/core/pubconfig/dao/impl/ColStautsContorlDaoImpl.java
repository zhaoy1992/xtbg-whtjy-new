package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.pubconfig.dao.ColStautsContorlDao;
import com.chinacreator.xtbg.core.pubconfig.entity.ColStautsContorlBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:ColStautsContorlDaoImpl.java</p>
 *<p>Description:表单元素状态接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-30
 */
public class ColStautsContorlDaoImpl extends XtDbBaseDao implements
		ColStautsContorlDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findActColStatusList
	  * @param action_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.ColStautsContorlDao#findActColStatusList(java.lang.String)
	 */
	public List<ColStautsContorlBean> findColStatusList(String action_id)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		List<ColStautsContorlBean> list = new ArrayList<ColStautsContorlBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		t.id,");
		sql.append(" 		t.action_id,");
		sql.append(" 		t.table_id,");
		sql.append(" 		t.table_code,");
		sql.append(" 		t.column_id,");
		sql.append(" 		t.column_code,");
		sql.append(" 		t.readonly,");
		sql.append("        t.hidden,");
		sql.append("        t.disable,");
		sql.append("        t.required,");
		sql.append("        decode(t.readonly,'1','checked','') ckd1,");// chk1字段用于是否选中选择框
		sql.append("        decode(t.hidden  ,'1','checked','') ckd2,");
		sql.append("        decode(t.disable ,'1','checked','') ckd3,");
		sql.append("        decode(t.required ,'1','checked','') ckd4");
		sql.append("  from oa_col_stauts_contorl t ");
		sql.append(" where 1=1 and t.action_id=?  order by t.table_id");
		db.preparedSelect(sql.toString());
		db.setString(1, action_id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			ColStautsContorlBean model = new ColStautsContorlBean();
			model.setId(db.getString(i, "id"));
			model.setAction_id(db.getString(i, "action_id"));
			model.setTable_id(db.getString(i, "table_id"));
			model.setTable_code(db.getString(i, "table_code"));
			model.setColumn_id(db.getString(i, "column_id"));
			model.setColumn_code(db.getString(i, "column_code"));
			model.setReadonly(db.getString(i, "readonly"));
			model.setHidden(db.getString(i, "hidden"));
			model.setDisable(db.getString(i, "disable"));
			model.setRequired(db.getString(i, "required"));
			model.setCkd1(db.getString(i, "ckd1"));
			model.setCkd2(db.getString(i, "ckd2"));
			model.setCkd3(db.getString(i, "ckd3"));
			model.setCkd4(db.getString(i, "ckd4"));
			list.add(model);
		}
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateColStatusForm
	  * @param colStautsContorlBean
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.ColStautsContorlDao#updateColStatusForm(com.chinacreator.xtbg.core.pubconfig.entity.ColStautsContorlBean)
	 */
	public void updateColStatusForm(ColStautsContorlBean colStautsContorlBean)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE oa_col_stauts_contorl t SET ");
		sql.append(" t.readonly = ?, ");
		sql.append(" t.hidden   = ?, ");
		sql.append(" t.disable  = ?, ");
		sql.append(" t.required = ?  ");
		sql.append(" WHERE t.id = ? ");
		db.preparedUpdate(sql.toString());
		db.setString(1, colStautsContorlBean.getReadonly());
		db.setString(2, colStautsContorlBean.getHidden());
		db.setString(3, colStautsContorlBean.getDisable());
		db.setString(4, colStautsContorlBean.getRequired());
		db.setString(5, colStautsContorlBean.getId());
		db.executePrepared();
	}

	

}

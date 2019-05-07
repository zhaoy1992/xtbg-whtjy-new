package com.chinacreator.xtbg.core.process.dbmanager.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.entity.MdColumnBean;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;


/**
 *<p>Title:MdDaoImpl.java</p>
 *<p>Description:数据元数据访问层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-6
 */
public class MdDaoImpl extends XtDbBaseDao  implements MdDao {
	

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertMdTable
	  * @param conn
	  * @param model
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#insertMdTable(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdTableBean) 
	  */
	public String insertMdTable(Connection conn, MdTableBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String uuid = StringUtil.getUUID();
		sql.append(" insert into oa_md_table (table_id,table_code,table_name,table_pk,table_sn) ");//暂时没处理parent_table_id
		sql.append(" select ");
		sql.append(" '" + uuid + "',");//主键
		sql.append(" '" + model.getTable_code().toUpperCase() + "',");//表名
		sql.append(" '" + model.getTable_name() + "',");//表注释
		sql.append(" '" + model.getTable_pk()   + "',");//key字段
		sql.append(" max(table_sn)+1 ");//表序号
		sql.append(" from oa_md_table ");
		db.executeSql(sql.toString(), conn);
		return uuid;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 createMdTable
	  * @param conn
	  * @param list
	  * @param pkname
	  * @param pk
	  * @param havepk
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#createMdTable(java.sql.Connection, java.util.List, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public void createMdTable(Connection conn, List<MdColumnBean> list,MdTableBean mdTableBean) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String havepk=StringUtil.deNull(mdTableBean.getHavepk());
		String pkname=StringUtil.deNull(mdTableBean.getPkname());//中文注释
		String pk=StringUtil.deNull(mdTableBean.getTable_pk());//主键字段
		String table_code=StringUtil.deNull(mdTableBean.getTable_code());
		int i = 0;
		String datalength = "";
		sql.append("create table  "+table_code);
		sql.append(" ( ");
		for (MdColumnBean model : list) {// 拼装 “,table_id varchar2(50) not null”
			if (!StringUtil.nullOrBlank(model.getData_length())) {
				datalength = " (" + model.getData_length() + ") ";
			}
			if (i == 0) {
				sql.append("  " + model.getColumn_code() + " "
						+ model.getData_type() + datalength + " "
						+ model.getNullable());
			} else {
				sql.append("  ," + model.getColumn_code() + " "
						+ model.getData_type() + datalength + " "
						+ model.getNullable());
			}
			datalength="";
			i++;
		}
		if ("1".equalsIgnoreCase(havepk)) {
			sql.append("  ,constraint " + pkname + " primary key (" + pk + ")");
		}
		sql.append(" ) ");
		db.executeSql(sql.toString(), conn);
		StringBuffer sql1 = new StringBuffer();
		sql1.append("comment on table "+table_code+" is '"+StringUtil.deNull(mdTableBean.getTable_name())+"'");
		db.executeSql(sql1.toString());
		for (MdColumnBean model : list) {
			addColumnName(model, table_code);
			i++;
		}
		
	}
	
	public void addColumnName(MdColumnBean bean,String table_code) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append(" comment on column "+table_code+"."+StringUtil.deNull(bean.getColumn_code())+" is '"+StringUtil.deNull(bean.getColumn_name())+"'");
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeSql(sql.toString());
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertMdColumn
	  * @param conn
	  * @param model
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#insertMdColumn(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdColumnBean) 
	  */
	public void insertMdColumn(Connection conn, MdColumnBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into oa_md_columns (column_id,table_id,column_code,column_name,column_sn,ISVIEW)");
		sql.append(" select ");
		sql.append(" '" + StringUtil.getUUID() + "',");
		sql.append(" '" + model.getTable_id() + "',");
		sql.append(" '" + model.getColumn_code().toUpperCase() + "'   ,");
		sql.append(" '" + model.getColumn_name().toUpperCase() + "'   ,");
		sql.append("  " + model.getColumn_sn() + "   ,");
		sql.append(" '0'");
		sql.append(" from dual ");
		db.executeSql(sql.toString(), conn);
	}

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 addMdColumn
	  * @param conn
	  * @param model
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#addMdColumn(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdColumnBean) 
	  */
	public void addMdColumn(Connection conn, MdColumnBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String datalength = "";
		if (!StringUtil.nullOrBlank(model.getData_length())){
			datalength = " (" + model.getData_length() + ") ";
		}
		String sql = "alter table " + model.getTable_name() + " add ("
				+ model.getColumn_code() + " " + model.getData_type()
				+ datalength + " null )";
		db.executeSql(sql, conn);
		
		addColumnName(model, model.getTable_name());
		
		
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateMdColumn
	  * @param conn
	  * @param model
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#updateMdColumn(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdColumnBean) 
	  */
	public void updateMdColumn(Connection conn, MdColumnBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_md_columns ");
		sql.append(" set ");
		sql.append(" column_code = '" + model.getColumn_code() + "'   ,");
		sql.append(" column_name = '" + model.getColumn_name() + "'   ,");
		sql.append(" column_sn = " + model.getColumn_sn() + "       ");
		sql.append(" where column_id = '" + model.getColumn_id() + "'");
		db.executeSql(sql.toString(), conn);
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 modifyMdColumn
	  * @param conn
	  * @param model
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#modifyMdColumn(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdColumnBean) 
	  */
	public void modifyMdColumn(Connection conn, MdColumnBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String datalength = "";
		if (!StringUtil.nullOrBlank(model.getData_length())){
			datalength = " (" + model.getData_length() + ") ";
		}
		String sql = "alter table " + model.getTable_name() + " modify ("
				+ model.getColumn_code() + "  " + model.getData_type() + "  "
				+ datalength + " )";
		db.executeSql(sql, conn);
		
		addColumnName(model, model.getTable_name());
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMdColumnById
	  * @param column_id
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#findMdColumnById(java.lang.String) 
	  */
	public MdColumnBean findMdColumnById(String column_id)throws SQLException{
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.column_id,t.column_sn,t.table_id,t.column_code,t.column_name,c.TABLE_NAME,c.DATA_TYPE,decode(c.CHAR_LENGTH,'0','',c.CHAR_LENGTH) DATA_LENGTH ,c.NULLABLE ");
		sql.append(",(select 'Y' from  user_constraints con,user_cons_columns col where con.table_name = c.table_name and col.column_name=t.column_code and con.constraint_name=col.constraint_name and con.constraint_type='P') ispk ");
		sql.append("from oa_md_columns t,oa_md_table tab,user_tab_columns c ");
		sql.append(" where t.table_id=tab.table_id and tab.table_code=c.TABLE_NAME and t.column_code=c.COLUMN_NAME");
		sql.append(" and t.column_id = ? ");
		sql.append(" order by t.column_sn ");
    	db.preparedSelect(sql.toString());
		db.setString(1, column_id);
    	db.executePrepared();
    	db.preparedSelect(sql.toString());
    	MdColumnBean model = new MdColumnBean();
    	if(db.size()>0){
	    	model.setTable_id(StringUtil.deNull(db.getString(0, "table_id")));
	    	model.setColumn_id(StringUtil.deNull(db.getString(0, "column_id")));
	    	model.setColumn_code(StringUtil.deNull(db.getString(0, "column_code")));
	    	model.setColumn_sn(StringUtil.deNull(db.getString(0, "column_sn")));
	    	model.setColumn_name(StringUtil.deNull(db.getString(0, "column_name")));
	    	model.setTable_name(StringUtil.deNull(db.getString(0, "table_name")));
	    	model.setData_type(StringUtil.deNull(db.getString(0, "data_type")));
	    	model.setData_length(StringUtil.deNull(db.getString(0, "data_length")));
	    	model.setNullable(StringUtil.deNull(db.getString(0, "nullable")));
	    	model.setIspk(StringUtil.deNull(db.getString(0, "ispk")));
    	}
		return model;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMdTable 2
	  * @param conn 
	  * @param table_id
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#deleteMdTable(java.sql.Connection, java.lang.String) 
	  */
	public void deleteMdTable(Connection conn, String table_id) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "delete oa_md_table where table_id ='" + table_id+"'";
		db.executeSql(sql, conn);
	};
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 dropMdTable 3
	  * @param conn
	  * @param table_name
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#dropMdTable(java.sql.Connection, java.lang.String) 
	  */
	public void dropMdTable(Connection conn, String table_name) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "drop table " + table_name;
		db.executeSql(sql, conn);
	};
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMdColumnByTableId 1
	  * @param conn
	  * @param table_id
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#deleteMdColumnByTableId(java.sql.Connection, java.lang.String) 
	  */
	public void deleteMdColumnByTableId(Connection conn, String table_id)
			throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "delete oa_md_columns where table_id ='" + table_id+"'";
		db.executeSql(sql, conn);
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteMdColumn
	  * @param conn
	  * @param column_id
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#deleteMdColumn(java.sql.Connection, java.lang.String) 
	  */
	public void deleteMdColumn(Connection conn, String column_id)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "delete oa_md_columns where 1=2 or column_id ='" + column_id+"'";
		db.executeSql(sql, conn);
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 dropTableColumn
	  * @param conn
	  * @param model
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#dropTableColumn(java.sql.Connection, com.chinacreator.xtbg.core.dssave.entity.MdColumnBean) 
	  */
	public void dropTableColumn(Connection conn, MdColumnBean model)
			throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "alter table "+model.getTable_name()+" drop ( "+ model.getColumn_code()+" )";
		db.executeSql(sql, conn);
	}
	
	/** 
	  * <b>Summary: </b>
	  *     复写方法 findMdTableList
	  * @param mdTableBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#findMdTableList(com.chinacreator.xtbg.core.dssave.entity.MdTableBean) 
	  */
	public List<MdTableBean> findMdTableList(MdTableBean mdTableBean) throws SQLException {
		List<MdTableBean> list = new ArrayList<MdTableBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.table_id,t.table_code,t.table_name from oa_md_table t where 1=1");
		sql.append(" order by t.table_code");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0;i<db.size();i++){
			MdTableBean model = new MdTableBean();
			model.setTable_id(StringUtil.deNull(db.getString(i,"table_id")));
			model.setTable_code(StringUtil.deNull(db.getString(i,"table_code")));
			model.setTable_name(StringUtil.deNull(db.getString(i,"table_name")));
			list.add(model);
		}
		return list;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findMdColumnList
	  * @param mdTableBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#findMdColumnList(com.chinacreator.xtbg.core.dssave.entity.MdColumnBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean findMdColumnList(MdColumnBean mdTableBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws SQLException {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<MdColumnBean> list = new ArrayList<MdColumnBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.column_id,t.table_id,t.column_code,t.column_name,t.column_sn,c.TABLE_NAME,c.DATA_TYPE,decode(c.CHAR_LENGTH,'0','',c.CHAR_LENGTH) DATA_LENGTH,c.NULLABLE ");
		sql.append(",(select 'Y' from  user_constraints con,user_cons_columns col where con.table_name = c.table_name and col.column_name=t.column_code and con.constraint_name=col.constraint_name and con.constraint_type='P') ispk ");
		sql.append("from oa_md_columns t,oa_md_table tab,user_tab_columns c ");
		sql.append(" where t.table_id=tab.table_id and tab.table_code=c.TABLE_NAME and t.column_code=c.COLUMN_NAME");
		sql.append(" and t.table_id = ? ");
		sql.append(" order by t.column_sn ");
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.setString(1, mdTableBean.getTable_id());
    	db.executePrepared();
    	db.preparedSelect(sql.toString());
		for(int i = 0;i < db.size();i++){
			MdColumnBean model = new MdColumnBean();
	    	model.setTable_id(StringUtil.deNull(db.getString(i, "table_id")));
	    	model.setColumn_id(StringUtil.deNull(db.getString(i, "column_id")));
	    	model.setColumn_code(StringUtil.deNull(db.getString(i, "column_code")));
	    	model.setColumn_name(StringUtil.deNull(db.getString(i, "column_name")));
	    	model.setColumn_sn(StringUtil.deNull(db.getString(i, "column_sn")));
	    	model.setTable_name(StringUtil.deNull(db.getString(i, "table_name")));
	    	model.setData_type(StringUtil.deNull(db.getString(i, "data_type")));
	    	model.setData_length(StringUtil.deNull(db.getString(i, "data_length")));
	    	model.setNullable(StringUtil.deNull(db.getString(i, "nullable")));
	    	model.setIspk(StringUtil.deNull(db.getString(i, "ispk")));
	    	list.add(model);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findPkNameList
	  * @param mdTableBean
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.process.dbmanager.dao.MdDao#findPkNameList(com.chinacreator.xtbg.core.dssave.entity.MdTableBean)
	 */
	public List<Map<String, String>> findPkNameList(MdTableBean mdTableBean)
			throws SQLException {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select constraint_name from user_constraints t where t.constraint_type='P'");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0;i<db.size();i++){
			Map<String, String> map=new HashMap<String, String>();
			map.put("constraint_name",StringUtil.deNull(db.getString(i,"constraint_name")));
			list.add(map);
		}
		return list;
	}
}

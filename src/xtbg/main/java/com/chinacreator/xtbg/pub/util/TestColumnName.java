package com.chinacreator.xtbg.pub.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.common.poolman.SQLParams;


/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2008</p>
 *<p>Company:湖南科创</p>
 *@author jun.zhang
 *@version 3.0
 *@date 2009-2-6
 */
public class TestColumnName {
	 
	
	public void printColumnName(String tableName) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
//		td_sm_organization
		String insertSQL = "insert into "+tableName.toLowerCase()+"(";		
		String updateSQL = "update "+tableName.toLowerCase()+" set ";
		String tempColumn = "";
		String temp = "";
		try {
			conn = DBUtil.getConection("");//数据源名称
			String sql = "select NLS_LOWER(COLUMN_NAME) as column_name ,NLS_LOWER(DATA_TYPE) as data_type  from USER_TAB_COLS  where Table_Name = NLS_UPPER(?)";
		    
			ps = conn.prepareStatement(sql);
			ps.setString(1, tableName);
			rs = ps.executeQuery();
			while (rs.next()) {
				if ("date".equals(rs.getString("data_type"))){
					System.out.println("private Timestamp "+rs.getString("column_name")+";");
				} else {
					System.out.println("private String "+rs.getString("column_name")+";");
				}
				updateSQL += rs.getString("column_name") + " = ?, ";
				tempColumn += rs.getString("column_name")+",";
			}
			System.out.println("updateSQL:"+updateSQL.substring(0, updateSQL.length()-2));
			
			insertSQL = insertSQL + tempColumn.substring(0, tempColumn.length()-1) + ") values (";
			
			int i = tempColumn.split(",").length;
			
			for (int k = 0; k < i; k ++){
				temp += "?,";
			}
			insertSQL = insertSQL + temp.substring(0, temp.length()-1) + ")";
			
			System.out.println("insertSQL:"+insertSQL);
		} finally {
			//rs.close();
			//ps.close();
			conn.close();
		}
	}
	
//	public void testExecuteSqlForObj(){
//		String dsName ="app5";
//		String sql = "select t.id,t.businessid,t.msg_content,t.user_id,t.msgtype,t.send_time,t.org_id,t.org_code from td_note_buffer t" +
//		" where rownum < 2 order by t.send_time asc";
//		PreparedDBUtil pdb = new PreparedDBUtil();
//		try {
//			pdb.preparedSelect(dsName,sql);
//			pdb.executePrepared();
//			NoteBufferBean nbb = (NoteBufferBean)DaoUtil.getBean(pdb,NoteBufferBean.class);
//			System.out.println(pdb.size());
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	public void testSqlParams(){
		String dsName ="app5";
		String sql = "select * from td_note_bufferfail where id =#[id]";
		PreparedDBUtil pdb = new PreparedDBUtil();
		SQLParams params = new SQLParams();
		try {
			params.addSQLParam("id", "68", SQLParams.STRING);
			params.addSQLParam("businessid", "68", SQLParams.STRING);
			pdb.preparedSelect(params, dsName, sql);
			pdb.executePrepared();
			if(pdb.size()>0){
				System.out.println(pdb.getString(0, "id"));
			}
		} catch (SQLException e) {
			
		}
		
	}
	
	public void testexecuteBatchSqlForObj(){
		String dsName ="app5";
		StringBuffer sql = new StringBuffer();
		StringBuffer batchSql = new StringBuffer();
		sql.append("delete from td_note_buffer where id = ");
			
		String[] ids = {"70","71"};
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.setBatchDBName(dsName);
			pdb. setAutoCommit(false);
			for(int i=0;i<ids.length;i++){
				batchSql.append(sql).append("'").append(ids[i]).append("'");
				pdb.addBatch(batchSql.toString());
				batchSql.setLength(0);
			}
			pdb.executeBatch();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String...strings) throws SQLException{
		TestColumnName test = new TestColumnName();

		test.printColumnName("ta_oa_electss");
		//test.testSqlParams();
		//test.printColumnName("TA_SP_BULLETIN_WEB");

		
	}
}

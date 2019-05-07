package com.chinacreator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.frameworkset.common.poolman.DBUtil;

/**
 *<p>
 * Title: 辅助生成工具
 *</p>
 *<p>
 * Description: 生成库表对应的 bean属性 及get set 方法（带注释） 及该库表的 insert语句 和 update语句
 * 
 *</p>
 *<p>
 * Copyright:Copyright (c) 2008
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author jun.zhang
 *@version 1.0
 *@date 2010-12-1
 */
public class TestColumnName {

	/**
	 * 
	 *<b>Summary:*生成库表对应的 bean属性 及get set 方法（带注释） 及该库表的 insert语句 和 update语句
	 * </b> printColumnName(请用一句话描述这个方法的作用)
	 * 
	 * @param tableName
	 *            表名
	 * @param getSetFlag
	 *            是否要有getset方法
	 * @throws SQLException
	 */
	public void printColumnName(String tableName, boolean getSetFlag)
			throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// td_sm_organization
		String insertSQL = "insert into " + tableName.toLowerCase() + "(";
		String updateSQL = "update " + tableName.toLowerCase() + " set ";
		StringBuffer getAndSetBeanMethodStr = new StringBuffer();// get set
																	// 方法字符串
		String tempColumn = "";
		String temp = "";
		try {
			conn = DBUtil.getConection();
			String sql = "select NLS_LOWER(t.column_name) as column_name ,NLS_LOWER(r.data_type) as data_type,t.comments  from user_col_comments t "
					+ " left join user_tab_columns r on t.table_name=r.table_name and t.column_name=r.column_name where t.table_name = NLS_UPPER(?) order by r.COLUMN_ID";

			ps = conn.prepareStatement(sql);
			ps.setString(1, tableName);
			rs = ps.executeQuery();
			while (rs.next()) {
				// TODO 暂时只把date类型独立出来为 Timestamp类型 其余类型都作为string类型
				// TODO 如果需要增加其他支持类型 ，修改一下判断代码

				String column_type = columnTypeParse(rs.getString("data_type"));

				System.out.println("private " + column_type + " "
						+ rs.getString("column_name") + ";		//"
						+ rs.getString("comments"));

				if (getSetFlag) {
					getAndSetBeanMethodStr.append(createGetAndSetMethod(rs
							.getString("column_name"),
							rs.getString("comments"), column_type));
				}
				updateSQL += rs.getString("column_name") + " = ?, ";
				tempColumn += rs.getString("column_name") + ",";
			}
			if (getSetFlag) {
				System.out.println(getAndSetBeanMethodStr.toString());
			}

			System.out.println("updateSQL:"
					+ updateSQL.substring(0, updateSQL.length() - 2));

			insertSQL = insertSQL
					+ tempColumn.substring(0, tempColumn.length() - 1)
					+ ") values (";

			int i = tempColumn.split(",").length;

			for (int k = 0; k < i; k++) {
				temp += "?,";
			}
			insertSQL = insertSQL + temp.substring(0, temp.length() - 1) + ")";

			System.out.println("insertSQL:" + insertSQL);
		} finally {
			// rs.close();
			// ps.close();
			conn.close();
		}
	}

	/**
	 * 
	 *<b>Summary:创建get set 方法 </b> createGetAndSetMethod(请用一句话描述这个方法的作用)
	 * 
	 * @param column_name
	 *            字段名
	 * @param comments
	 *            字段注释
	 * @param comment_type
	 *            字段类型
	 * @return 形成的get set 方法字符串
	 */
	private String createGetAndSetMethod(String column_name, String comments,
			String comment_type) {

		StringBuffer sql = new StringBuffer();
		sql.append("/**\n*<b>Summary: 获取" + comments + "</b>\n*/\n");
		sql.append("public " + comment_type + " get"
				+ firstCodeToUpperCase(column_name) + "() {\n");
		sql.append("	return " + column_name + ";\n");
		sql.append("}\n");
		sql.append("/**\n*<b>Summary: 设置" + comments + "</b>\n*/\n");
		sql.append("public void set" + firstCodeToUpperCase(column_name) + "("
				+ comment_type + " " + column_name + ") {\n");
		sql.append("	this." + column_name + " = " + column_name + ";\n");
		sql.append("}\n");
		return sql.toString();
	}

	/**
	 * 
	 *<b>Summary:字符串首字母变大写 </b> firstCodeToUpperCase(请用一句话描述这个方法的作用)
	 * 
	 * @param str
	 * @return
	 */
	private String firstCodeToUpperCase(String str) {
		return str.replaceFirst(str.substring(0, 1), str.substring(0, 1)
				.toUpperCase());
	}

	/**
	 * 
	 *<b>Summary:数据库字段类型转换器(如果需要其他类型的转换，请自行扩展) </b>
	 * 
	 * @param comment_type
	 * @return
	 */
	private String columnTypeParse(String comment_type) {
		if ("date".equals(comment_type)) {
			//comment_type = "Timestamp";
			comment_type = "Object";
		} else {
			comment_type = "String";
		}
		return comment_type;
	}
	
	

	public static void main(String... strings) throws SQLException {
		TestColumnName test = new TestColumnName();
		test.printColumnName("ta_oa_personholder", true);
	}
}

package com.chinacreator.xtbg.core.codegenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.entity.ColumnProperty;
import com.chinacreator.xtbg.core.codegenerator.factory.CodeFactory;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;
import com.frameworkset.common.poolman.DBUtil;

/**
 *<p>Title:CodeGenerator.java</p>
 *<p>Description:代码生成器</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Mar 21, 2014
 */
public class CodeGenerator {
	public static void main(String[] args) {
		CodeGenerator c = new CodeGenerator();
		List<ClassProperty> newClassList = new ArrayList<ClassProperty>();
		//ClassProperty参数分别为 ：
		//1-表名  
		//2-业务类前缀(生成后的文件名为：xxxEntity.java,xxxDao.java,xxxDaoImpl.java,xxxList.java,
		//                            xxxService.java,xxxServiceImpl.java,xxxlist.jsp,xxxinfo.jsp,xxxdo.jsp)
		//3-生成的java文件的绝对路径 （为了一致性 路径分割符请用 " / " 可以为空，为空 将不会生成java文件）
		//4-包路径
		//5-生成的jsp文件的绝对路径（为了一致性 路径分割符请用 " / "。可以为空，为空 将不会生成jsp文件）
		newClassList.add(new ClassProperty(
				"ta_oa_devsubjectrecord",
				"DevSubjectRecord",
				"D:/workspace/xtbg-tjy/src/xtbg/main/java/com/chinacreator/xtbg/tjy/device",
				"com.chinacreator.xtbg.tjy.device",
				"D:/workspace/xtbg-tjy/creatorepp/ccapp/xtbg/tjy/device/type"));
//		newClassList.add(new ClassProperty(
//				"ay_info_receiver",
//				"ExchangReceiver",
//				"D:/workspace/xtbg-base/src/xtbg/main/java/com/chinacreator/xtbg/anyang/exchange2",
//				"com.chinacreator.xtbg.anyang.exchange2",
//				"D:/workspace/xtbg-base/creatorepp/ccapp/xtbg/anyang/exchange2"));
		CodeFactory.generatorCode(c.getClassProperty(newClassList));
//		System.out.println(c.getClassProperty(newClassList));
	}
	/**
	*<b>Summary:获取字段 类 信息 </b>
	* getClassProperty()
	* @param classList
	* @return
	 */
	public List<ClassProperty> getClassProperty(List<ClassProperty> classList){
		List<ClassProperty> newClassList = new ArrayList<ClassProperty>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		for(ClassProperty classProperty : classList){
			try {
				conn = DBUtil.getConection();
				StringBuffer sql = new StringBuffer();
				sql.append("select distinct NLS_LOWER(t.column_name) as column_name,");
				sql.append("                NLS_LOWER(r.data_type) as column_type,");
				sql.append("                r.DATA_LENGTH column_length,");
				sql.append("                t.comments column_comments,");
				sql.append("                (select decode(a.column_name, '', 'C', 'P')");
				sql.append("                   from user_cons_columns a, user_constraints b");
				sql.append("                  where a.constraint_name = b.constraint_name");
				sql.append("                    and a.table_name = b.table_name");
				sql.append("                    and b.constraint_type = 'P'");
				sql.append("                    and b.table_name = r.TABLE_NAME");
				sql.append("                    and a.column_name = r.COLUMN_NAME) constraint_type,");
				sql.append("                c.comments table_comments,");
				sql.append("                r.COLUMN_ID");
				sql.append("  from user_tab_columns r, user_col_comments t, user_tab_comments c");
				sql.append(" where t.table_name = NLS_UPPER(?)");
				sql.append("   and t.table_name = r.table_name");
				sql.append("   and t.column_name = r.column_name");
				sql.append("   and r.TABLE_NAME = c.table_name");
				sql.append(" order by r.COLUMN_ID");
				ps = conn.prepareStatement(sql.toString());
				ps.setString(1, classProperty.getTableName());
				rs = ps.executeQuery();
				
				List<ColumnProperty> columnList = new ArrayList<ColumnProperty>();
				while (rs.next()) {
					classProperty.setTableChiName(rs.getString("table_comments"));
					ColumnProperty column = new ColumnProperty();
					column.setCode(rs.getString("column_name"));
					column.setComments(rs.getString("column_comments"));
					
					String length = rs.getString("column_length");
					column.setLength(length==null || "".equals(length) ? 0 : Integer.parseInt(length));
					
					column.setName(rs.getString("column_name"));
					
					String constraint_type = rs.getString("constraint_type");
					column.setPrimarykey(constraint_type !=null && "P".equalsIgnoreCase(constraint_type) ? true : false);
					
					column.setType(rs.getString("column_type"));
					
					//如果是主键 不重复添加 因为查询出来的字段主键会有重复
					if(column.isPrimarykey()){
						classProperty.setPrimaryKey(column.getCode());
					}
					columnList.add(column);	
				}
				if(classProperty.getPrimaryKey() == null || "".equals(classProperty.getPrimaryKey())){
					System.out.println("##"+CodeUtil.getLogTime()+" AutoGenrator Log: "+classProperty.getTableName()+"+表没主键，将不会生成代码！...");
				} else {
					classProperty.setColumnProperty(columnList);
					newClassList.add(classProperty);
				}
			} catch(Exception e){
				e.printStackTrace();
			} finally {
				 try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return classList;
	}
}

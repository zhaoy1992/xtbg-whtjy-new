package com.chinacreator.xtbg.core.file.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 	COPY:[http://blog.csdn.net/sunhuaquan/article/details/6201739]
 *<p>Title:AccessUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Nov 14, 2013
 */
public class AccessDataBaseManager {
	
	private static final Log LOG = LogFactory.getLog(AccessDataBaseManager.class);
	/**
	 * 数据库文件
	 */
	private String dataBaseFileURL;
	
	public String getDataBaseFileURL() {
		return dataBaseFileURL;
	}
	public AccessDataBaseManager(String dataBaseFileURL){
		this.dataBaseFileURL = dataBaseFileURL;
	}
	private Connection openConnection() throws Exception{
		int syscode = this.checkSys();
		switch (syscode) {
		case AccessDataBaseManager.OS_WINDOW_32:
			return openConnectionA();
		case AccessDataBaseManager.OS_WINDOW_64:
			return openConnectionB();
		case AccessDataBaseManager.OS_LINUX:
			return openConnectionC();
		}
		return openConnectionA();
	}
	/**
	 * jdbcodbc桥连接
	 *<b>Summary: </b>
	 * openConnection(win32)
	 * @return
	 * @throws Exception
	 */
	private Connection openConnectionA() throws Exception{
		/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		String database = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ="
				+ this.getDataBaseFileURL() + ";DriverID=22;READONLY=true}";
		Properties prop = new Properties();    //只要添加这几句话就可以
        prop.put("charSet", "gb2312");
		return DriverManager.getConnection(database,prop);*/
		Class.forName("com.hxtt.sql.access.AccessDriver").newInstance();   
		String database = "jdbc:access:/"+this.getDataBaseFileURL();
		Properties prop = new Properties();    //只要添加这几句话就可以
		prop.put("charSet", "gb2312");
		return DriverManager.getConnection(database,"","");
	}
	/**
	 * mdb
	 *<b>Summary: </b>
	 * openConnection1
	 * @return
	 * @throws Exception
	 */
	private Connection openConnectionB() throws Exception{
		Class.forName("com.hxtt.sql.access.AccessDriver").newInstance();   
		String database = "jdbc:access:/"+this.getDataBaseFileURL();
		Properties prop = new Properties();    //只要添加这几句话就可以
		prop.put("charSet", "gb2312");
		return DriverManager.getConnection(database,"","");
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * openConnectionC(win32)
	 * @return
	 * @throws Exception
	 */
	private Connection openConnectionC() throws Exception{
		Class.forName("com.hxtt.sql.access.AccessDriver").newInstance();   
		String database = "jdbc:access:///"+this.getDataBaseFileURL();
		Properties prop = new Properties();    //只要添加这几句话就可以
		prop.put("charSet", "gb2312");
		return DriverManager.getConnection(database,"","");
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * closeConnection(close)
	 * @param con
	 * @throws Exception
	 */
	private void closeConnection(Connection con)throws Exception {
		con.close();
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * insert(批量添加)
	 * @param sql
	 * @param dataList
	 * @return
	 * @throws Exception
	 */
	public boolean insert(String sql,List<Map<Integer,String>> dataList) throws Exception{
		Connection con = null;
		boolean flag = false;
		try{
			con = this.openConnection();
			con.setAutoCommit(false);
			PreparedStatement ps = con.prepareStatement(sql);
			for (Map<Integer, String> map : dataList) {
				for (Integer key : map.keySet()) {
					ps.setObject(key.intValue(), map.get(key));
				}
				ps.executeUpdate();
			}
			con.commit();
			flag = true;
		}catch(Exception e){
			if(con!=null){
				con.rollback();
			}
			
			throw e;
		}finally{
			if(con!=null){
				closeConnection(con);
			}
		}
		return flag;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * insert(批量添加)
	 * @param sql
	 * @param dataList
	 * @return
	 * @throws SQLException 
	 * @throws Exception
	 */
	public boolean insert(List<String> sqlList) throws Exception{
		Connection con = null;
		boolean flag = false;
		try{
			con = this.openConnection();
			con.setAutoCommit(false);
			Statement s = con.createStatement();
			for (String sql : sqlList) {
				LOG.info("添加数据:"+sql);
				s.execute(sql);
			}
			con.commit();
			flag = true;
		}catch(Exception e){
			if(con!=null){
				con.rollback();
			}
			LOG.info("添加数据失败", e);
			e.printStackTrace();
		}finally{
			if(con!=null){
				closeConnection(con);
			}
		}
		return flag;
	}
	
	public final static int OS_WINDOW_32 = 1;
	public final static int OS_WINDOW_64 = 2;
	public final static int OS_LINUX = 3;
	
	private int checkSys(){
		String os = System.getProperty("os.name").toLowerCase();
		String arch = System.getProperty("os.arch");
		LOG.info("系统检测:["+os+"]["+arch+"]");
		if(os.indexOf("win")!=-1){
		}else if(os.indexOf("mac")!=-1){
			LOG.info("不支持mac系统");
		}else{
			return OS_LINUX;
		}
		if(arch.contains("64")){
			return OS_WINDOW_64;
		}else{
			return OS_WINDOW_32;
		}
	}
	public static void main(String[] args) throws Exception {
//		AccessDataBaseManager a = new AccessDataBaseManager("D:\\aaa.mdb");
//		List<String> sqlList = new ArrayList<String>();
//		sqlList.add("INSERT INTO FILE_CATALOG(QZH,HH,JH,ND,ZRZ,BGQX,WH,WT,TM,CWSJ,YS,XXLX,BZ,DZWJM) VALUES('192','20131226002','33','2013','政府行业事业部','永久','字号11 [2013]1226002号','政府行业事业部','文书（我将被移交）1226003','20131226','1226002','文本','1226002','E:\\档案移交[2013-12-26]\\2013\\十二月\\192-2013-普通-政府行业事业部-20131226002_33')");
//		//	sqlList.add("INSERT INTO FILE_CATALOG(QZH,HH,JH,ND,ZRZ,BGQX,WH,WT,TM,CWSJ,YS,XXLX,BZ,DZWJM) VALUES('192','1224001','8','2013','政府行业事业部','永久','字号11 [2013]1218001号','政府行业事业部','文书1218001-入卷后复制1','20131218','1218001','文本','1218001','E:\\档案移交[2013-12-26]\\2013\\十二月\\192-2013-普通-政府行业事业部-1224001_8')");
////		sqlList.add("INSERT INTO FILE_CATALOG(QZH,HH,JH,ND,ZRZ,BGQX,WH,WT,TM,CWSJ,YS,XXLX,BZ,DZWJM) VALUES('192','1224001','8','2013','部2221','3','3','3','3','3','3','3','2','1')");
//		//sqlList.add("INSERT INTO FILE_CATALOG(QZH,HH,JH,ND,ZRZ,BGQX,WH,WT,TM,CWSJ,YS,XXLX,BZ,DZWJM) VALUES('192','1','阿斯顿发生地发斯蒂芬案事发时对','2013','政府行业事业部','1','2 [2013]2号','政府行业事业部','测试归档1','20131011','','文本','','2222/2013/十月/[无档号]原文.doc')");
//		a.insert(sqlList);

		String arch = System.getProperty("os.arch");
		String os = System.getProperty("os.name");
		System.out.println(arch);//amd64  //x86
		System.out.println(os);//Windows Server 2008 R2  //Windows XP
	}
}
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.PinyinUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import = "com.frameworkset.common.poolman.DBUtil"%>
<%@ page import = "java.sql.*"%>
<%
	  boolean falg = true;
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.user_realname, t.user_pinyin,t.user_id  from TD_SM_USER t ");
		String user_pinyin = "";
		String user_id="";
		String user_realname="";
		DBUtil db = new DBUtil();
		DBUtil db1 = new DBUtil();
		try {
		     db.executeSelect(sql.toString());
		     for(int i=0;i<db.size();i++){
		    	 user_pinyin = db.getString(i,"user_pinyin") ;
		    	 user_id = db.getString(i,"user_id") ;
		         if(StringUtil.isBlank(user_pinyin)){
		        	 user_realname = db.getString(i,"user_realname") ;
		        	 String pingyin = PinyinUtil.hanziToPinyin(user_realname);
		        	 StringBuffer sql1 = new StringBuffer();
		        	 sql1.append("update TD_SM_USER t set t.user_pinyin ='"+pingyin+"' where t.user_id='"+user_id+"'");
		        	 db1.execute(sql1.toString());
		         }
		         
		     }
		} catch (SQLException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		    falg = false;
		} catch(Exception e){
			e.printStackTrace();
			falg = false;
		}
		
		out.println("转换拼音  ture 表示成功 false:表示失败:========"+falg);
%>



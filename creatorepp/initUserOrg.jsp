<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import = "com.frameworkset.common.poolman.DBUtil"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>
<%
    StringBuffer sql = new StringBuffer();
    sql.append("select  ujo.user_id as user_id ,min(ujo.org_id) as org_id from td_sm_userjoborg ujo inner join ");
    sql.append("(     select uu.user_id from td_sm_user uu");
    sql.append(" minus ");
    sql.append(" select ou.user_id from td_sm_orguser ou  ");
    sql.append(" ) abc on abc.user_id = ujo.user_id group by ujo.user_id,ujo.org_id ");
    
    String user_id = "";
    String org_id = "";
    DBUtil db = new DBUtil();
    OrgManagerImpl orgManager = new OrgManagerImpl();
    try {
         db.executeSelect(sql.toString());
         for(int i=0;i<db.size();i++){
             user_id = db.getString(i,"user_id") ;
             org_id = db.getString(i,"org_id");
             orgManager.addMainOrgnazitionOfUser(user_id,org_id);
         }
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
    
    
%>

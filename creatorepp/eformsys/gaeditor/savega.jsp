<%@ page language="java" pageEncoding="GBK"%>
<%@page import="java.io.*,
                org.jdom.*,
                org.jdom.input.*,
                org.jdom.output.*,
                java.sql.*,
                oracle.sql.*,
                oracle.jdbc.driver.OracleResultSet,
                com.frameworkset.common.poolman.DBUtil,
                com.chinacreator.eform.business.FormRunManager,
				com.chinacreator.eform.business.InstanceIdManager"%>
<%!
   public Element loadXml(InputStream is)
    {
            SAXBuilder docBuild = new SAXBuilder();
            Document doc = null;
            try
            {
                 doc = docBuild.build( is );
            }
            catch( Exception e )
            {
                 System.out.print( e.getMessage() );
                 return null;
            }            
            return doc.getRootElement();
    }
    
	public boolean isexis(String ctrl_insid){
		try{
		    DBUtil util = new DBUtil();		 
            util.executeSelect("SELECT ctrl_insid FROM TD_FORM_GAEDITDATA where ctrl_insid='"+ctrl_insid+"'");
			if(util!=null && util.size()>0){			   
			   return true;
			}
			else{			   
			   return false;
			}
		}catch(Exception e){
            return false;
		}
	}
%>
<%
  String currentSystemID = (String)session.getAttribute("subsystem_id_nouse");
  String appUserName = "";
  if(currentSystemID == null || "".equals(currentSystemID.trim()) || "module".equalsIgnoreCase(currentSystemID)){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }
  
  Element root=loadXml(request.getInputStream());
  if( root != null ){
	   Element url=(Element)root.getChild("url");
	   Element data=(Element)root.getChild("data");
	   String strurl=url.getText();
	   String strdata=data.getText();
	   String ctrl_insid = strurl.substring(1,strurl.indexOf("."));
	   OutputStream outStream = null;
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
	   try{
			DBUtil util = new DBUtil();
			conn = util.getConection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			
			if(!isexis(ctrl_insid)){				
				stmt.execute("insert into "+appUserName+"TD_FORM_GAEDITDATA(uri,gadata,ctrl_insid) values ('"+strurl+"',empty_blob(),'"+ctrl_insid+"')");
			}
			
			rs = stmt.executeQuery("SELECT gadata FROM "+appUserName+"TD_FORM_GAEDITDATA where ctrl_insid='"+ctrl_insid+"' FOR UPDATE");
			oracle.sql.BLOB blob = null;
			if (rs.next()) {
				blob = (oracle.sql.BLOB)rs.getBlob("gadata");
		        outStream = blob.getBinaryOutputStream();
				byte[] buffer = strdata.getBytes();
				int len = buffer.length;
		        //data是传入的byte数组，定义：byte[] data
		        outStream.write(buffer, 0, len);  //写入数据库的blob字段！
			}

			outStream.flush();
			outStream.close();
			conn.commit();
			out.println("yes"); //返回值
	   } 
	   catch (Exception e) {
	        out.println("no");
			System.out.println(e.toString());
	   }finally{		   
		    rs.close();
			stmt.close();
			conn.close();
	   }
   }
%>
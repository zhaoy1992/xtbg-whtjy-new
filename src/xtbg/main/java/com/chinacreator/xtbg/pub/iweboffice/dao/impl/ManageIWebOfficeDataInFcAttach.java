package com.chinacreator.xtbg.pub.iweboffice.dao.impl;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import org.apache.log4j.Logger;

import oracle.sql.BLOB;

import com.chinacreator.iWebOffice2006.iDBManager2000;
import com.chinacreator.xtbg.pub.directory.dao.imploracle.DirectoryDaoImpl;
import com.chinacreator.xtbg.pub.iweboffice.IWebOffice;
import com.chinacreator.xtbg.pub.iweboffice.IWebOfficeDBManager;
import com.chinacreator.xtbg.pub.iweboffice.dao.IWebOfficeDataManageDao;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;

public class ManageIWebOfficeDataInFcAttach extends IWebOfficeDBManager implements IWebOfficeDataManageDao{
	private static final Logger LOG = Logger.getLogger(ManageIWebOfficeDataInFcAttach.class);
	
	public ManageIWebOfficeDataInFcAttach(IWebOffice iWebOffice,
			iDBManager2000 DbaObj) {
		super(iWebOffice, DbaObj);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean LoadFile(Map<String, String> params) {
		/*获取iWebOffice参数*/
		String mRecordID = iWebOffice.getmRecordID();
		 boolean mResult = false;
		    String Sql = "SELECT AttachContent as FileBody,length(AttachContent) as FileSize FROM Fc_Attach WHERE DJSN='" + mRecordID + "'";
		    try {
		      if (DbaObj.OpenConnection()) {
		        try {
		          ResultSet result = DbaObj.ExecuteQuery(Sql);
		          if (result.next()) {
		            try {
		             iWebOffice.setmFileSize(result.getInt("FileSize"));
			         //GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
		             iWebOffice.GetAtBlob((BLOB)result.getObject("FileBody"),iWebOffice.getmFileSize());
		              mResult = true ;
		            }
		            catch (IOException ex) {
		              System.out.println(ex.toString());
		            }
		          }
		          result.close();
		        }
		        catch (SQLException e) {
		          System.out.println(e.getMessage());
		          mResult = false;
		        }
		      }
		    }
		    finally {
		      DbaObj.CloseConnection();
		    }
		    return (mResult);
	}

	@Override
	public boolean SaveFile(Map<String, String> params) {
		/*获取iWebOffice参数*/
		String mRecordID = iWebOffice.getmRecordID();
		String mFileName = iWebOffice.getmFileName();
		String mFileType = iWebOffice.getmFileType();
		int mFileSize = iWebOffice.getmFileSize();
		String mFilePath = iWebOffice.getmFilePath();
		String mUserName = iWebOffice.getmUserName();

		FiletransferServiceImpl ft=new FiletransferServiceImpl();
		
		boolean mResult = false;
	    String iFileId = "";
	    String busiId = "";
	    String Sql = "SELECT * FROM Fc_Attach WHERE DJSN='" + mRecordID + "'";
	    try{
	      if (DbaObj.OpenConnection()) {
	        try {
	          ResultSet result = DbaObj.ExecuteQuery(Sql);
	          if (result.next()) {
	            Sql="update Fc_Attach set Djsn=?,Extend=?,Djbh=?,FileName=?,AttachId=?,AttachContent=EMPTY_BLOB(),Filepos=?,Upload_Mode=?,Creator=? WHERE Djsn='" + mRecordID + "'";
	            iFileId=result.getString("Djsn");
	            busiId = result.getString("Djbh");
	            mFileName = result.getString("FileName");
	          }
	          else {
	            Sql="insert into Fc_Attach (Djsn,Extend,Djbh,FileName,AttachId,AttachContent,Filepos,Upload_Mode,Creator) values (?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
	            
	            iFileId= FileUtils.randomUUID();
	          }
	          result.close();
	        }
	        catch (SQLException e) {
	          System.out.println(e.toString());
	          mResult = false;
	        }
	        java.sql.PreparedStatement prestmt=null;
	        try {
	          prestmt =DbaObj.Conn.prepareStatement(Sql);
	          int p = 1;
	          prestmt.setString(p++,iFileId);
	          prestmt.setString(p++, mFileType);
	          prestmt.setString(p++, busiId);
	          prestmt.setString(p++, mFileName);
	          try {
				prestmt.setString(p++, ft.getAttachId());
			} catch (Exception e1) {
				LOG.error(e1.getMessage());
			}
	          prestmt.setString(p++, mFilePath);
	          prestmt.setString(p++, "1");
	          prestmt.setString(p++, mUserName);                                          //"通用版本"
	          DbaObj.Conn.setAutoCommit(true) ;
	          prestmt.execute();
	          DbaObj.Conn.commit();
	          prestmt.close();
	          Statement stmt=null;
	          DbaObj.Conn.setAutoCommit(false) ;
	          stmt = DbaObj.Conn.createStatement();
	          //OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Document_File where Fileid=" + String.valueOf(iFileId)+ " for update");
	          ResultSet rs = stmt.executeQuery("select AttachContent as FileBody from Fc_Attach where DJSN='" + String.valueOf(mRecordID)+ "' for update");
	          if (rs.next()){
	            try
	            {
	              //PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
	              iWebOffice.PutAtBlob((BLOB)rs.getObject("FileBody"),mFileSize);
	            }
	            catch (IOException e) {
	               System.out.println(e.toString());
	               mResult = false;
	            }
	          }
	          rs.close();
	          stmt.close();

	          DbaObj.Conn.commit();
	          iWebOffice.setmFileBody(null);
	          mResult=true;
	        }
	        catch (SQLException e) {
	          System.out.println(e.toString());
	          mResult = false;
	        }
	      }
	    }
	    finally {
	      DbaObj.CloseConnection();
	    }
		return (mResult);
	}
	
}

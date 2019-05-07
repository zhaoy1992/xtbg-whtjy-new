package com.chinacreator.xtbg.pub.iweboffice.dao.impl;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import oracle.sql.BLOB;

import com.chinacreator.iWebOffice2006.iDBManager2000;
import com.chinacreator.xtbg.pub.iweboffice.IWebOffice;
import com.chinacreator.xtbg.pub.iweboffice.IWebOfficeDBManager;
import com.chinacreator.xtbg.pub.iweboffice.dao.IWebOfficeDataManageDao;

public class ManageIWebOfficeDataInDocumentFile extends IWebOfficeDBManager implements IWebOfficeDataManageDao {
	
	public ManageIWebOfficeDataInDocumentFile(IWebOffice iWebOffice,
			iDBManager2000 DbaObj) {
		super(iWebOffice, DbaObj);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean LoadFile(Map<String, String> params) {
		/*获取iWebOffice参数*/
		String mRecordID = iWebOffice.getmRecordID();
		 boolean mResult = false;
		    String Sql = "SELECT FileBody,FileSize FROM oa_document_File WHERE RecordID='" + mRecordID + "'";
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
		String mDescript = iWebOffice.getmDescript();
		
		boolean mResult = false;
	    int iFileId = -1;
	    String Sql = "SELECT * FROM Document_File WHERE RecordID='" + mRecordID + "'";
	    try{
	      if (DbaObj.OpenConnection()) {
	        try {
	          ResultSet result = DbaObj.ExecuteQuery(Sql);
	          if (result.next()) {
	            Sql="update Document_File set FileID=?,RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=EMPTY_BLOB(),FilePath=?,UserName=?,Descript=? WHERE RecordID='" + mRecordID + "'";
	            iFileId=result.getInt("FileId");
	          }
	          else {
	            Sql="insert into Document_File (FileID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
	            iFileId=DbaObj.GetMaxID("Document_File","FileId");
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
	          prestmt.setInt(1,iFileId);
	          prestmt.setString(2, mRecordID);
	          prestmt.setString(3, mFileName);
	          prestmt.setString(4, mFileType);
	          prestmt.setInt(5, mFileSize);
	          prestmt.setDate(6 ,DbaObj.GetDate());
	          prestmt.setString(7, mFilePath);
	          prestmt.setString(8, mUserName);
	          prestmt.setString(9, mDescript);                                          //"通用版本"
	          DbaObj.Conn.setAutoCommit(true) ;
	          prestmt.execute();
	          DbaObj.Conn.commit();
	          prestmt.close();
	          Statement stmt=null;
	          DbaObj.Conn.setAutoCommit(false) ;
	          stmt = DbaObj.Conn.createStatement();
	          //OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Document_File where Fileid=" + String.valueOf(iFileId)+ " for update");
	          ResultSet rs = stmt.executeQuery("select FileBody from Document_File where Fileid=" + String.valueOf(iFileId)+ " for update");
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

package com.chinacreator.xtbg.pub.iweboffice.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import oracle.sql.BLOB;

import org.apache.log4j.Logger;

import com.chinacreator.iWebOffice2006.iDBManager2000;
import com.chinacreator.xtbg.core.upload.util.UploadConstants;
import com.chinacreator.xtbg.pub.iweboffice.IWebOffice;
import com.chinacreator.xtbg.pub.iweboffice.IWebOfficeDBManager;
import com.chinacreator.xtbg.pub.iweboffice.dao.IWebOfficeDataManageDao;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class ManageIWebOfficeDataInFileUploadKBM extends IWebOfficeDBManager implements IWebOfficeDataManageDao{
	private static final Logger LOG = Logger.getLogger(ManageIWebOfficeDataInFileUploadKBM.class);
	
	public ManageIWebOfficeDataInFileUploadKBM(IWebOffice iWebOffice,
			iDBManager2000 DbaObj) {
		super(iWebOffice, DbaObj);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean LoadFile(Map<String, String> params) {
		/*获取iWebOffice参数*/
		String mRecordID = iWebOffice.getmRecordID();
		boolean mResult = false;
		String file_name = "";
		String file_extra = "";
		String file_size = "";
		String yearfolder = "";
		String monthfolder = "";
		String attach_id = "";
		String file_id = "";
		String old_server_filepath = "";//老路径
		String new_server_filepath = "";//新的路径（后来产品里面讲知识库的附件名修改成了以id命名
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql1 = new StringBuffer();
		sql1.append("select file_id,file_name,file_extra,file_size,attach_id,yearfolder,monthfolder from OA_FILEUPLOAD_KBM o where o.file_id = ?");
		try {
			pdb.preparedSelect(sql1.toString());
			pdb.setString(1, mRecordID);
			pdb.executePrepared();
			if(pdb.size() > 0){
				file_id = pdb.getString(0,"file_id");
				file_name = pdb.getString(0,"file_name");
				file_extra = pdb.getString(0,"file_extra");
				file_size = pdb.getString(0,"file_size");
				attach_id = pdb.getString(0, "attach_id");
				yearfolder = pdb.getString(0,"yearfolder");
				monthfolder = pdb.getString(0,"monthfolder");
				String appRootPath = ManageIWebOfficeDataInFileUploadKBM.class.getResource("/").getPath();
				String dirPath = appRootPath.split("WEB-INF/classes/")[0]+UploadConstants.UPLOADSAVEPATH+
						"OA_FILEUPLOAD_KBM/"+yearfolder+"/"+monthfolder+"/"+attach_id;
				old_server_filepath = dirPath+"/"+file_name+"."+file_extra;
				new_server_filepath = dirPath+"/"+file_id+"."+file_extra;
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		 if("" != old_server_filepath ){

            try {
             
	         //GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
             File wordFile = new File(old_server_filepath);
             if(!wordFile.exists()){//如果按老的路径取文件未取到，则按新的路径取文件
            	 wordFile = new File(new_server_filepath);
             }
             System.out.println(wordFile.getPath());
             FileInputStream fis = new FileInputStream(wordFile);
             iWebOffice.setmFileSize((int)wordFile.length());
             iWebOffice.GetAtByte(fis,(int)wordFile.length());
              mResult = true ;
            }
            catch (IOException ex) {
              System.out.println(ex.toString());
              mResult = false;
            }

			       

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

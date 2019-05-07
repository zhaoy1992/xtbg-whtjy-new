<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="oracle.sql.BLOB" %>
<%@ page import="oracle.jdbc.OracleDriver" %>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="DBstep.iMsgServer2000.*" %>
<%@ page import="com.chinacreator.iWebOffice2006.iDBManager2000" %>
<%!
public class iWebOffice {
 private int mFileSize;
 private byte[] mFileBody;
 private String mFileName;
 private String mFileType;
 private String mFileDate;
 private String mFileID;
 private int mTemplateId;

 private String mRecordID;
 private String mTemplate;
 private String mDateTime;
 private String mOption;
 private String mMarkName;
 private String mPassword;
 private String mMarkList;
 private String mBookmark;
 private String mDescript;
 private String mHostName;
 private String mMarkGuid;
 private String mCommand;
 private String mContent;
 private String mHtmlName;
 private String mDirectory;
 private String mFilePath;

 private String mUserName;
 private int mColumns;
 private int mCells;
 private String mMyDefine1;
 private String mLocalFile;
 private String mRemoteFile;
 private String mLabelName;
 private String mImageName;
 private String mTableContent;
 
 private String Sql;
 
 //�����ĵ��ĸ�����Ϣ�������ӵı�����
 private String mSaveStatus;
 private String mSubject;
 private String mHTMLPath;

 //��ӡ����
 private String mOfficePrints;
 private int mCopies; 

 //�Զ�����Ϣ����
 private String mInfo;

 private DBstep.iMsgServer2000 MsgObj;
 private iDBManager2000 DbaObj ;


// ************* Bolb�ֶδ������    ��ʼ  *******************************
 private void PutAtBlob(BLOB vField,int vSize) throws IOException
 {
   try{
	   int blobsize = (int)vField.length();
  	   System.out.println("PutAtBlob,vSize:"+vSize);
	   System.out.println("PutAtBlob,blobsize:"+blobsize);   
	   OutputStream outstream=vField.getBinaryOutputStream();
       outstream.write(mFileBody,0, vSize);
       outstream.close();
   }
   catch(SQLException e){
	   e.printStackTrace();
   }
 }

 private void GetAtBlob(BLOB vField,int vSize) throws IOException
 {
   try{
     	int blobsize = (int)vField.length();
     	System.out.println("GetAtBlob,vSize:"+vSize);
     	System.out.println("GetAtBlob,blobsize:"+blobsize);    
     	mFileBody = new byte[vSize];
     	InputStream instream=vField.getBinaryStream();
     	instream.read(mFileBody,0,vSize);
     	instream.close();
   }
   catch(SQLException e){
   		e.printStackTrace();
   }
 }

  /**
   * ���ܻ����ã���ʽ������ʱ��
   * @param DateValue �������ڻ�ʱ��
   * @param DateType ��ʽ�� EEEE������, yyyy����, MM����, dd����, HH��Сʱ, mm�Ƿ���,  ss����
   * @return ����ַ���
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }

// ************* Bolb�ֶδ���    ����  *******************************


// ************* �ĵ���ģ��������    ��ʼ  *******************************
 //�����ĵ������ĵ����ݱ�����mFileBody��Ա���д��
  private boolean LoadFile()
  {
    boolean mResult = false;
    String Sql = "SELECT FileBody,FileSize FROM Document_File WHERE RecordID='" + mRecordID + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileSize=result.getInt("FileSize");
	         //GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
	         GetAtBlob((BLOB)result.getObject("FileBody"),mFileSize);
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

 //�����ĵ�������ĵ����ڣ��򸲸ǣ������ڣ������
  private boolean SaveFile()
  {
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
          prestmt.setString(9, mDescript);                                          //"ͨ�ð汾"
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
              PutAtBlob((BLOB)rs.getObject("FileBody"),mFileSize);
            }
            catch (IOException e) {
               System.out.println(e.toString());
               mResult = false;
            }
          }
          rs.close();
          stmt.close();

          DbaObj.Conn.commit();
          mFileBody=null;
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
  
	
	//����word�ĵ��ĸ�����Ϣ�������Document
	
	private boolean saveToTableDocument(){
	
	  	System.out.println("mSubject:"+mSubject);
	    System.out.println("mFileDate:"+mFileDate);
	    System.out.println("mSaveStatus:"+mSaveStatus);
	    System.out.println("mHTMLPath:"+mHTMLPath);
	    System.out.println("mUserName:"+mUserName);
	    System.out.println("mRecordID:"+mRecordID);
	    System.out.println("mFileType:"+mFileType);
	    System.out.println("mTemplate:"+mTemplate);
	    
	    int mDocumentId=0;
	
		iDBManager2000 DbaObj=new iDBManager2000();
		if (DbaObj.OpenConnection()){
	  		String mysql="SELECT DocumentID,RecordID from  Document Where RecordID='" + mRecordID + "'";
	  		//String mFileDate=DbaObj.GetDateTime() ;
		  	try{
		    	ResultSet result=DbaObj.ExecuteQuery(mysql) ;
		    	if (result.next()){
		        	mysql="update Document set DocumentID=?,RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"+mRecordID+"'";
		      		mDocumentId=result.getInt("DocumentID");
		    	}else{
		      		mysql="insert into Document (DocumentID,RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?,?)";
		      		mDocumentId=DbaObj.GetMaxID("Document","DocumentID");
		    	}
		    	result.close();
		  	}catch(Exception e){
		      	System.out.println(e.toString());
		  	}
		  	
		  	java.sql.PreparedStatement prestmt=null;
		  	try{
				prestmt=DbaObj.Conn.prepareStatement(mysql);
		      	prestmt.setInt(1,mDocumentId);
		      	prestmt.setString(2,mRecordID);
		      	prestmt.setString(3,mTemplate);
		      	prestmt.setString(4,mSubject);
		      	prestmt.setString(5,mUserName);
		      	prestmt.setDate(6,DbaObj.GetDate());
		      	prestmt.setString(7,mFileType);
		      	prestmt.setString(8,mHTMLPath);
		      	prestmt.setString(9,"READ");
		
		      	DbaObj.Conn.setAutoCommit(true) ;
		      	prestmt.executeUpdate();
		      	DbaObj.Conn.commit();
		
			}catch(Exception e){
		    	System.out.println(e.toString());
		  	}finally{
		      	try{
		      		prestmt.close();
		      	}catch(Exception ex){
		      		System.out.println(ex.toString());
		      	}
		  	}
		  	DbaObj.CloseConnection() ;
		}else{
	  		System.out.println("OpenDatabase Error") ;
		}
	  	return true;
	}

 //����ģ���ĵ�����ģ���ĵ����ݱ�����mFileBody��Ա���д��
  private boolean LoadTemplate()
  {
    boolean mResult = false;
    String Sql = "SELECT FileBody,FileSize FROM Template_File WHERE RecordID='" + mTemplate + "'";
    try {
      if (DbaObj.OpenConnection()) {        
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);         
          if (result.next()) {
            try {
              mFileSize=result.getInt("FileSize");                            
	          //GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
	          GetAtBlob((oracle.sql.BLOB)result.getObject("FileBody"),mFileSize);              
              mResult = true ;
            }
            catch (Exception ex) {
              ex.printStackTrace();
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

 //����ģ���ĵ������ģ���ĵ����ڣ��򸲸ǣ������ڣ������
  private boolean SaveTemplate()
  {
    boolean mResult = false;
    String Sql = "SELECT * FROM Template_File WHERE RecordID='" + mTemplate + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            Sql="update Template_File set TemplateID=?,RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=EMPTY_BLOB(),FilePath=?,UserName=?,Descript=? WHERE RecordID='" + mTemplate + "'";
            mTemplateId=result.getInt("TemplateId");
          }
          else {
            Sql="insert into Template_File (TemplateID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
            mTemplateId=DbaObj.GetMaxID("Template_File","TemplateId");
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
          prestmt.setInt(1,mTemplateId);
          prestmt.setString(2, mTemplate);
          prestmt.setString(3, mFileName);
          prestmt.setString(4, mFileType);
          prestmt.setInt(5, mFileSize);
          prestmt.setDate(6 ,DbaObj.GetDate());
          prestmt.setString(7, mFilePath);
          prestmt.setString(8, mUserName);
          prestmt.setString(9, mDescript);                                          //"ͨ�ð汾"
          DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();
          Statement stmt=null;
          DbaObj.Conn.setAutoCommit(false) ;
          stmt = DbaObj.Conn.createStatement();          
          //OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Template_File where TEMPLATEID=" + String.valueOf(mTemplateId)+ " for update");
          ResultSet rs = stmt.executeQuery("select FileBody from Template_File where TEMPLATEID=" + String.valueOf(mTemplateId)+ " for update");
          if (rs.next()){
            try
            {
	          mFileSize=mFileBody.length;
              //PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
              PutAtBlob((BLOB)rs.getObject("FileBody"),mFileSize);
            }
            catch (IOException e) {
               System.out.println(e.toString());
               mResult = false;
            }
          }
          rs.close();
          stmt.close();

          DbaObj.Conn.commit();
          mFileBody=null;
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
// ************* �ĵ���ģ��������    ����  *******************************


//************* �汾�������    ��ʼ  *******************************
//�г����а汾��Ϣ
private boolean ListVersion()
{
   boolean mResult=false;
   String mDesc="";
   String Sql= "SELECT FileID,FileDate,UserName,Descript FROM Version_File WHERE RecordID='" + mRecordID + "'";

   mFileID="\r\n";
   mDateTime="����ʱ��\r\n";
   mUserName="�û���\r\n";
   mDescript="�汾˵��\r\n";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
               mFileID+=String.valueOf(result.getInt("FileID"))+"\r\n";                  //�ļ����б�
               mDateTime+=result.getString("FileDate")+"\r\n";                           //�����б�
               mUserName+=result.getString("UserName")+"\r\n";                           //�û����б�
               mDesc=result.getString("Descript");                                       //���˵����Ϣ���лس����򽫻س����>����
               mDesc=mDesc.replace('\r','>');
               mDesc=mDesc.replace('\n','>');
               mDescript+=mDesc +"\r\n";
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
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

//����ѡ�а汾��ͨ���ļ��ŵ���mFileID,�����ļ�����mFileBody��Ա���д��
private boolean LoadVersion(String mFileID)
{
    boolean mResult = false;
    String Sql= "SELECT FileBody,FileSize FROM Version_File WHERE RecordID='" + mRecordID + "' and  FileID=" + mFileID;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileSize=result.getInt("FileSize");
	          //GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
	          GetAtBlob((BLOB)result.getObject("FileBody"),mFileSize);
              mResult = true ;
            }
            catch (Exception ex) {
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

//����汾�����ð汾�ļ����̣�����˵����ϢҲ��������
private boolean SaveVersion()
{
    boolean mResult = false;
    int iFileId = -1;
    String Sql="insert into Version_File (FileID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
    if (mFileID.equalsIgnoreCase("")){
       iFileId=DbaObj.GetMaxID("Version_File","FileId");
    }
    else
    {
       iFileId = Integer.getInteger(mFileID.toString()).intValue();
    }
    try {
      if (DbaObj.OpenConnection()) {
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
          prestmt.setString(9, mDescript);                                          //"ͨ�ð汾"
          DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();
          Statement stmt=null;
          DbaObj.Conn.setAutoCommit(false) ;
          stmt = DbaObj.Conn.createStatement();
          //OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Version_File where Fileid=" + String.valueOf(iFileId)+ " for update");
          ResultSet rs = stmt.executeQuery("select FileBody from Version_File where Fileid=" + String.valueOf(iFileId)+ " for update");
          if (rs.next()){
            try
            {
              //PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
              PutAtBlob((BLOB)rs.getObject("FileBody"),mFileSize);
            }
            catch (IOException e) {
               System.out.println(e.toString());
               mResult = false;
            }
          }
          rs.close();
          stmt.close();

          DbaObj.Conn.commit();
          mFileBody=null;
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
// ************* �汾�������    ����  *******************************


//************ ��ǩ�������   ��ʼ  *******************************
//ȡ����ǩ�б�
private boolean ListBookmarks()
{
    boolean mResult=false;
    String Sql= "SELECT * FROM Bookmarks ";
    mBookmark="";
    mDescript="";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
               mBookmark+=result.getString("BookMarkName")+"\r\n";   //�û����б�
               mDescript+=result.getString("BookMarkDesc")+"\r\n";   //���˵����Ϣ���лس����򽫻س����>����
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
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

//װ����ǩ
private boolean LoadBookMarks()
{
   boolean mResult=false;
   String Sql=" select b.BookMarkName,b.BookMarkText from Template_BookMarks a,BookMarks b where a.BookMarkname=b.BookMarkName and a.RecordID='"+ mTemplate +"'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                //˵�������ǲ��Գ����SQL���ֱ��д���滻��ǩ����
                //ʵ��ʹ���У������ǩ������ͨ��Sql���õ��ġ�
                //����SQL��ѯ���  result.getString("BookMarkText") & "����"
                //��ǰ��¼��λ mRecordID
               //BookMarkValue=����SQL���н��
               String mBookMarkName=result.getString("BookMarkName");
               String mBookMarkValue=result.getString("BookMarkText");
               MsgObj.SetMsgByName(mBookMarkName,mBookMarkValue);
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
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

//������ǩ
private boolean SaveBookMarks()
{
  boolean mResult=false;
  String mBookMarkName;
  int mBookMarkId;
  int mIndex;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          java.sql.PreparedStatement prestmt=null;
          String Sql = "DELETE FROM Template_BookMarks Where RecordID='"+ mTemplate+"'";
          prestmt =DbaObj.Conn.prepareStatement(Sql);
          DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();

          for (mIndex=7;mIndex<=MsgObj.GetFieldCount()-1;mIndex++)
          {
             java.sql.PreparedStatement prestmtx=null;
             mBookMarkName=MsgObj.GetFieldName(mIndex);
             mBookMarkId=DbaObj.GetMaxID("Template_BookMarks","BookMarkId");
             Sql="insert into Template_BookMarks (BookMarkId,RecordId,BookMarkName) values ('" + String.valueOf(mBookMarkId)+ "','"+ mTemplate +"','"+ mBookMarkName +"')";
             prestmtx =DbaObj.Conn.prepareStatement(Sql);
             DbaObj.Conn.setAutoCommit(true) ;
             prestmtx.execute();
             DbaObj.Conn.commit();
             prestmtx.close();
          }
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
  return(mResult);
}
//************ ��ǩ�������   ����  *******************************


//************ ǩ�¹������    ��ʼ  *******************************
//ȡ��ǩ���б�
private boolean LoadMarkList()
{
   String Sql= "SELECT MarkName FROM Signature";
   mMarkList="";
   boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                mMarkList+=result.getString("MarkName")+"\r\n";
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
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

//����ǩ����¼
private boolean LoadMarkImage(String vMarkName,String vPassWord)
{
  String  Sql= "SELECT MarkBody,MarkType,MarkSize FROM Signature WHERE MarkName='" + vMarkName + "' and PassWord='" + vPassWord + "'";
  boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileSize=result.getInt("MarkSize");
              //GetAtBlob(((OracleResultSet)result).getBLOB("MarkBody"),mFileSize);
              GetAtBlob((BLOB)result.getObject("MarkBody"),mFileSize);
              mFileType=result.getString("MarkType");
              mResult=true;
            }
            catch (Exception ex) {
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

 //����ǩ��
 private boolean SaveSignature()
 {
  boolean mResult=false;
  int iSignatureID;
  String Sql="insert into Document_Signature (SignatureID,RecordID,MarkName,UserName,DateTime,HostName,MarkGuid) values (?,?,?,?,to_date('"+mDateTime+"','yyyy-mm-dd hh24:mi:ss'),?,? ) ";
  iSignatureID=DbaObj.GetMaxID("Document_Signature","SignatureID");
  if (DbaObj.OpenConnection())
  {
    java.sql.PreparedStatement prestmt=null;
    try
    {
      prestmt =DbaObj.Conn.prepareStatement(Sql);
      prestmt.setInt(1, iSignatureID);
      prestmt.setString(2, mRecordID);
      prestmt.setString(3, mMarkName);
      prestmt.setString(4, mUserName);
      prestmt.setString(5, mHostName);
      prestmt.setString(6, mMarkGuid);
      DbaObj.Conn.setAutoCommit(true);
      prestmt.execute();
      DbaObj.Conn.commit();
      prestmt.close();
      mResult=true;
    }
    catch(SQLException e)
    {
      System.out.println(e.toString()+Sql);
      mResult=false;
    }
    DbaObj.CloseConnection();
  }
  return (mResult);
 }

 //�г�����ǩ��
 private boolean LoadSignature()
 {
   boolean mResult=false;

   String Sql= "SELECT MarkName,UserName,DateTime,HostName,MarkGuid FROM Document_Signature WHERE RecordID='" + mRecordID + "'";
   mMarkName="ӡ������\r\n";
   mUserName="ǩ����\r\n";
   mDateTime="ǩ��ʱ��\r\n";
   mHostName="�ͻ���IP\r\n";
   mMarkGuid="���к�\r\n";

   if (DbaObj.OpenConnection())
   {
     try
     {
         mResult=true;
         ResultSet result=DbaObj.ExecuteQuery(Sql);
         while (result.next())
         {
           mMarkName+=result.getString("MarkName")+"\r\n";                  	     //�ļ����б�
           mUserName+=result.getString("UserName")+"\r\n";                           //�����б�
           mDateTime+=FormatDate(result.getString("DateTime"),"yyyy-MM-dd HH:mm:ss")+"\r\n";
           mHostName+=result.getString("HostName")+"\r\n";
           mMarkGuid+=result.getString("MarkGuid")+"\r\n";
         }
         result.close();
     }
     catch(Exception e)
     {
       System.out.println(e.toString());
       mResult=false;
     }
     DbaObj.CloseConnection();
   }
   return (mResult);
 }
// ************ ǩ�¹������    ����  *******************************


//************ ��չ���ܴ���    ��ʼ  *******************************
 //��������Ӧ���ı�
 private boolean LoadContent()
 {
   boolean mResult=false;
   //�����ݿ�
   //���� mRecordID �� mFileName ����Ϣ
   //��ȡ�ı���Ϣ����mContent���ɡ�
   //����ʾ����ȡ�õ��ı���Ϣ���£�
   mContent="";
   mContent+="���ĵļ�¼�ţ�"+mRecordID+"\n";
   mContent+="���ĵ��ļ�����"+mFileName+"\n";
   mContent+="    ����������Լ����룬�����ǵ����ݿ��������Ϳ�����\n";
   mResult=true;
   return (mResult);
 }

 //��������Ӧ���ı�
 private boolean SaveContent()
 {
   boolean mResult=false;
   //�����ݿ�
   //���� mRecordID �� mFileName ����Ϣ
   //�����ı���Ϣ mContent����ı������ݿ��м��ɡ�
   mResult=true;
   return (mResult);
 }

 //�����в����������
 private boolean GetWordTable()
 {
   int i,n;
   String strI,strN;
   boolean mResult;
   mColumns=3; mCells=8;
   MsgObj.MsgTextClear();
   MsgObj.SetMsgByName("COLUMNS",String.valueOf(mColumns));  		     //���ñ����
   MsgObj.SetMsgByName("CELLS",String.valueOf(mCells));      		     //���ñ����
   //�ò������ݿ��Դ����ݿ��ж�ȡ
   try{
     for (i=1;i<=mColumns;i++)
     {
       strI = String.valueOf(i);
       for (n=1;n<=mCells;n++)
       {
         MsgObj.SetMsgByName( String.valueOf(i)+String.valueOf(n),"����" + DbaObj.GetDateTime());
       }
     }
     mResult=true;
   }
   catch(Exception e)
   {
     System.out.println(e.toString());
     mResult=false;
   }
   return (mResult);
 }

 //���´�ӡ����
 private boolean UpdataCopies(int mLeftCopies)
 {
   boolean mResult=true;

   //�ú������԰Ѵ�ӡ���ٵĴ�����¼�����ݿ�

   //�����Լ���ϵͳ������չ�ù���
   return mResult;
 }
//************ ��չ���ܴ���    ����  *******************************


// *************��������д��������    ��ʼ  *******************************
//ȡ�ÿͻ��˷��������ݰ�
private byte[] ReadPackage(HttpServletRequest request)
{
  byte mStream[]=null;
  int totalRead = 0;
  int readBytes = 0;
  int totalBytes = 0;
  try
  {
    totalBytes = request.getContentLength();
    mStream = new byte[totalBytes];
    while(totalRead < totalBytes)
    {
      request.getInputStream();
      readBytes = request.getInputStream().read(mStream, totalRead, totalBytes - totalRead);
      totalRead += readBytes;
      continue;
    }
  }
  catch (Exception e)
  {
    System.out.println(e.toString());
  }
  return (mStream);
}

//���ʹ��������ݰ�
  private void SendPackage(HttpServletResponse response)
  {
    try
    {
      ServletOutputStream OutBinarry=response.getOutputStream() ;
      OutBinarry.write(MsgObj.MsgVariant()) ;
      OutBinarry.flush();
      OutBinarry.close();
    }
    catch(IOException e)
    {
      System.out.println(e.toString());
    }
  }
// *************��������д��������    ����  *******************************

public void ExecuteRun(HttpServletRequest request,HttpServletResponse response){
  DbaObj=new iDBManager2000();      //�������ݿ����
  MsgObj=new DBstep.iMsgServer2000();      //������Ϣ������

  mOption="";
  mRecordID="";
  mTemplate="";
  mFileBody=null;
  mFileName="";
  mFileType="";
  mFileSize=0;
  mFileID="";
  mDateTime="";
  mMarkName="";
  mPassword="";
  mMarkList="";
  mBookmark="";
  mMarkGuid="";
  mDescript="";
  mCommand="";
  mContent="";
  mLabelName="";
  mImageName="";
  mTableContent="";
  mMyDefine1="";
  mOfficePrints="0";

  mFilePath = request.getSession().getServletContext().getRealPath("") ;  //ȡ�÷�����·��

  System.out.println("ReadPackage") ;

  try{
    if (request.getMethod().equalsIgnoreCase("POST")){
      MsgObj.MsgVariant(ReadPackage(request));
      if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")){	//����ǺϷ�����Ϣ��
        mOption=MsgObj.GetMsgByName("OPTION") ;							//ȡ�ò�����Ϣ
        mUserName=MsgObj.GetMsgByName("USERNAME") ;						//ȡ��ϵͳ�û�
        System.out.println(mOption);									//��ӡ��������Ϣ
          
        if(mOption.equalsIgnoreCase("LOADFILE")){						//����Ĵ���Ϊ�򿪷��������ݿ�����ļ�
		  mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
		  mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
		  mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
		  MsgObj.MsgTextClear();										//����ı���Ϣ
		  //if (MsgObj.MsgFileLoad(mFilePath+"\\"+mFileName))			//���ļ��е����ĵ�
		  if (LoadFile()){												//�����ݿ�����ĵ�
            MsgObj.MsgFileBody(mFileBody);								//���ļ���Ϣ���
            MsgObj.SetMsgByName("STATUS","�򿪳ɹ�!");					//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("��ʧ��!");								//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEFILE")){					//����Ĵ���Ϊ�����ļ��ڷ����������ݿ���
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          //mMyDefine1=MsgObj.GetMsgByName("mMyDefine1");				//ȡ�ÿͻ��˴��ݱ���ֵ MyDefine1="�Զ������ֵ1"
          mFileSize=MsgObj.MsgFileSize();								//ȡ���ĵ���С
          mFileDate=DbaObj.GetDateTime();								//ȡ���ĵ�ʱ��
          mFileBody=MsgObj.MsgFileBody();								//ȡ���ĵ�����
          mFilePath="";													//�������Ϊ�ļ�������д�ļ�·��
          mUserName=mUserName;											//ȡ�ñ����û�����
          mDescript="ͨ�ð汾";											//�汾˵��
		  MsgObj.MsgTextClear();										//����ı���Ϣ
		  //if (MsgObj.MsgFileSave(mFilePath+"\\"+mFileName))			//�����ĵ����ݵ��ļ�����
          
          if (SaveFile())												//�����ĵ����ݵ����ݿ���
          {
            MsgObj.SetMsgByName("STATUS", "����ɹ�!");					//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else {
            MsgObj.MsgError("����ʧ��!");								//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();										//����ĵ�����
        }

        else if(mOption.equalsIgnoreCase("LOADTEMPLATE")){				//����Ĵ���Ϊ�򿪷��������ݿ����ģ���ļ�
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//ȡ��ģ���ĵ�����
          //���δ����Ƿ�����ĵ�ʱ��ģ�棬��������ģ��ʱ��ģ�档
          mCommand=MsgObj.GetMsgByName("COMMAND");						//ȡ�ÿͻ��˶���ı���COMMANDֵ
          if (mCommand.equalsIgnoreCase("INSERTFILE")) {
            if (MsgObj.MsgFileLoad(mFilePath+"\\Document\\"+mTemplate)){//�ӷ������ļ����е���ģ���ĵ�
              MsgObj.SetMsgByName("STATUS","��ģ��ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");										//���������Ϣ
            }
            else{
              MsgObj.MsgError("��ģ��ʧ��!");							//���ô�����Ϣ
            }
          }
          else{
            MsgObj.MsgTextClear();										//����ı���Ϣ
            if (LoadTemplate()){										//����ģ���ĵ�
              MsgObj.MsgFileBody(mFileBody);							//���ļ���Ϣ���
              MsgObj.SetMsgByName("STATUS","��ģ��ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");										//���������Ϣ
            }
            else{
              MsgObj.MsgError("��ģ��ʧ��!");							//���ô�����Ϣ
            }
          }
        }

        else if(mOption.equalsIgnoreCase("SAVETEMPLATE")){				//����Ĵ���Ϊ����ģ���ļ��ڷ����������ݿ���
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//ȡ���ĵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");				//ȡ�ÿͻ��˴��ݱ���ֵ MyDefine1="�Զ������ֵ1"
          mFileSize=MsgObj.MsgFileSize();								//ȡ���ĵ���С
          mFileDate=DbaObj.GetDateTime();								//ȡ���ĵ�ʱ��
          mFileBody=MsgObj.MsgFileBody();								//ȡ���ĵ�����
          mFilePath="";													//�������Ϊ�ļ�������д�ļ�·��
          mUserName=mUserName;											//ȡ�ñ����û�����
          mDescript="ͨ��ģ��"; 										//�汾˵��
          MsgObj.MsgTextClear();
          if (SaveTemplate()){											//����ģ���ĵ�����
            MsgObj.SetMsgByName("STATUS", "����ģ��ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ģ��ʧ��!");							//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("LISTVERSION")){				//����Ĵ���Ϊ�򿪰汾�б�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          MsgObj.MsgTextClear();
          if (ListVersion()){											//���ɰ汾�б�
            MsgObj.SetMsgByName("FILEID",mFileID);						//���ĵ����б���
            MsgObj.SetMsgByName("DATETIME",mDateTime);		            //������ʱ���б���
            MsgObj.SetMsgByName("USERNAME",mUserName);					//���û����б���
            MsgObj.SetMsgByName("DESCRIPT",mDescript);					//��˵����Ϣ�б���
            MsgObj.SetMsgByName("STATUS","�汾�б�ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�汾�б�ʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("LOADVERSION")){				//����Ĵ���Ϊ�򿪰汾�ĵ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileID=MsgObj.GetMsgByName("FILEID");					    //ȡ�ð汾�ĵ���
          MsgObj.MsgTextClear();
          if (LoadVersion(mFileID)){									//����ð汾�ĵ�
            MsgObj.MsgFileBody(mFileBody);								//���ĵ���Ϣ���
            MsgObj.SetMsgByName("STATUS","�򿪰汾�ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�򿪰汾ʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEVERSION")){				//����Ĵ���Ϊ����汾�ĵ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileID=MsgObj.GetMsgByName("FILEID");					    //ȡ�ð汾�ĵ���   ��:WebSaveVersionByFileID����FileIDֵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");				    //ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          mFileSize=MsgObj.MsgFileSize();							    //ȡ���ĵ���С
          mFileDate=DbaObj.GetDateTime();								//ȡ���ĵ�ʱ��
          mFileBody=MsgObj.MsgFileBody();								//ȡ���ĵ�����
          mFilePath="";													//�������Ϊ�ļ�������д�ļ�·��
          mUserName=mUserName;											//ȡ�ñ����û�����
          mDescript=MsgObj.GetMsgByName("DESCRIPT");				    //ȡ��˵����Ϣ
          MsgObj.MsgTextClear();
          if (SaveVersion()){ 				        				    //����汾�ĵ�
            MsgObj.SetMsgByName("STATUS", "����汾�ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����汾ʧ��!");							//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();										//����ĵ�����
        }

        else if(mOption.equalsIgnoreCase("LOADBOOKMARKS")){				//����Ĵ���Ϊȡ���ĵ���ǩ
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//ȡ��ģ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          MsgObj.MsgTextClear();
          if (LoadBookMarks()){
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("װ���ǩ��Ϣʧ��!");						//���ô�����Ϣ
          }
        }

        else if (mOption.equalsIgnoreCase("SAVEBOOKMARKS")){			//����Ĵ���Ϊȡ�ñ�ǩ�ĵ�����
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//ȡ��ģ����
          if (SaveBookMarks()){
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�����ǩ��Ϣʧ��!");						//���ô�����Ϣ
          }
          MsgObj.MsgTextClear();										//����ı���Ϣ
        }

        else if(mOption.equalsIgnoreCase("LISTBOOKMARKS")){				//����Ĵ���Ϊ��ʾ��ǩ�б�
          MsgObj.MsgTextClear();										//����ı���Ϣ
          if (ListBookmarks()){
            MsgObj.SetMsgByName("BOOKMARK",mBookmark);					//���û����б���
            MsgObj.SetMsgByName("DESCRIPT",mDescript);					//��˵����Ϣ�б���
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�����ǩʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("LOADMARKLIST")){				//����Ĵ���Ϊ����ӡ���б�
          MsgObj.MsgTextClear();										//����ı���Ϣ
          if (LoadMarkList()){
            MsgObj.SetMsgByName("MARKLIST",mMarkList);					//��ʾǩ���б�
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ӡ���б�ʧ��!");						//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("LOADMARKIMAGE")){				//����Ĵ���Ϊ��ӡ���ļ�
          mMarkName=MsgObj.GetMsgByName("IMAGENAME");					//ȡ��ǩ������
          mUserName=MsgObj.GetMsgByName("USERNAME");					//ȡ���û�����
          mPassword=MsgObj.GetMsgByName("PASSWORD");					//ȡ���û�����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          if (LoadMarkImage(mMarkName,mPassword)){						//����ǩ����Ϣ
            MsgObj.SetMsgByName("IMAGETYPE",mFileType);					//����ǩ������
            MsgObj.MsgFileBody(mFileBody);								//��ǩ����Ϣ���
            MsgObj.SetMsgByName ("POSITION","Manager");					//����λ��  ���ĵ��б�ǩ"Manager"
            MsgObj.SetMsgByName ("ZORDER","5");							//4:�������Ϸ� 5:�������·�
            MsgObj.SetMsgByName("STATUS","�򿪳ɹ�!");					//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("ǩ�����������!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("SAVESIGNATURE")){				//����Ĵ���Ϊ����ǩ�»�����Ϣ
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ļ�����
          mMarkName=MsgObj.GetMsgByName("MARKNAME");					//ȡ��ǩ������
          mUserName=MsgObj.GetMsgByName("USERNAME");					//ȡ���û�����
          mDateTime=MsgObj.GetMsgByName("DATETIME");				    //ȡ��ǩ��ʱ��
          mHostName=request.getRemoteAddr();							//ȡ���û�IP
          mMarkGuid=MsgObj.GetMsgByName("MARKGUID");					//ȡ��Ψһ���
          MsgObj.MsgTextClear();										//����ı���Ϣ
          if (SaveSignature()){											//����ǩ��
            MsgObj.SetMsgByName("STATUS","����ӡ�³ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ӡ��ʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("LOADSIGNATURE")){				//����Ĵ���Ϊ����ǩ�»�����Ϣ
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          if (LoadSignature()){											//����ǩ��
            MsgObj.SetMsgByName("MARKNAME",mMarkName);					//��ǩ�������б���
            MsgObj.SetMsgByName("USERNAME",mUserName);					//���û����б���
            MsgObj.SetMsgByName("DATETIME",mDateTime);					//��ʱ���б���
            MsgObj.SetMsgByName("HOSTNAME",mHostName);					//������IP��ַ�б���
            MsgObj.SetMsgByName("MARKGUID",mMarkGuid);					//��Ψһ����б���
            MsgObj.SetMsgByName("STATUS","����ӡ�³ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ӡ��ʧ��!");							//���ô�����Ϣ
          }
        }

        else if (mOption.equalsIgnoreCase("SAVEASHTML")){				//����Ĵ���Ϊ��OFFICE��ΪHTMLҳ��
          mHtmlName=MsgObj.GetMsgByName("HTMLNAME");					//ȡ���ļ�����
          mDirectory=MsgObj.GetMsgByName("DIRECTORY");					//ȡ��Ŀ¼����
          MsgObj.MsgTextClear();
          if (mDirectory.trim().equalsIgnoreCase("")){
            mFilePath=mFilePath + "\\HTML";
          }
          else{
            mFilePath=mFilePath + "\\HTML\\" + mDirectory;
          }
          MsgObj.MakeDirectory(mFilePath);								//����·��
          if (MsgObj.MsgFileSave(mFilePath+"\\"+mHtmlName)){			//����HTML�ļ�
            MsgObj.MsgError("");										//���������Ϣ
            MsgObj.SetMsgByName("STATUS","����HTML�ɹ�!");				//����״̬��Ϣ
          }
          else{
            MsgObj.MsgError("����HTMLʧ��!");							//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();
        }

        else if (mOption.equalsIgnoreCase("SAVEIMAGE"))	{				//����Ĵ���Ϊ��OFFICE��ΪHTMLͼƬҳ��
          mHtmlName=MsgObj.GetMsgByName("HTMLNAME");					//ȡ���ļ�����
          mDirectory=MsgObj.GetMsgByName("DIRECTORY");					//ȡ��Ŀ¼����
          MsgObj.MsgTextClear();
          if (mDirectory.trim().equalsIgnoreCase("")){
            mFilePath=mFilePath + "\\HTMLIMAGE";
          }
          else{
            mFilePath=mFilePath + "\\HTMLIMAGE\\" + mDirectory;
          }
          MsgObj.MakeDirectory(mFilePath);								//����·��
          if (MsgObj.MsgFileSave(mFilePath+"\\"+mHtmlName)){			//����HTML�ļ�
            MsgObj.MsgError("");										//���������Ϣ
            MsgObj.SetMsgByName("STATUS","����HTMLͼƬ�ɹ�!");			//����״̬��Ϣ
          }
          else{
            MsgObj.MsgError("����HTMLͼƬʧ��!");						//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();
        }

        else if (mOption.equalsIgnoreCase("SAVEASPAGE")){				//����Ĵ���Ϊ����д��ע��ΪHTMLͼƬҳ��
          mHtmlName=MsgObj.GetMsgByName("HTMLNAME");					//ȡ���ļ�����
          mDirectory=MsgObj.GetMsgByName("DIRECTORY");					//ȡ��Ŀ¼����
          MsgObj.MsgTextClear();
          if (mDirectory.trim().equalsIgnoreCase("")){
            mFilePath=mFilePath + "\\HTML";
          }
          else{
            mFilePath=mFilePath + "\\HTML\\" + mDirectory;
          }
          MsgObj.MakeDirectory(mFilePath);								//����·��
          if (MsgObj.MsgFileSave(mFilePath+"\\"+mHtmlName)){			//����HTML�ļ�
            MsgObj.MsgError("");										//���������Ϣ
            MsgObj.SetMsgByName("STATUS","������עHTMLͼƬ�ɹ�!");		//����״̬��Ϣ
          }
          else{
            MsgObj.MsgError("������עHTMLͼƬʧ��!");					//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("INSERTFILE")){				//����Ĵ���Ϊ�����ļ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          MsgObj.MsgTextClear();
          if (LoadFile()){												//�����ĵ�
            MsgObj.MsgFileBody(mFileBody);								//���ļ���Ϣ���
            MsgObj.SetMsgByName("POSITION","Content");					//���ò����λ��[��ǩ]
            MsgObj.SetMsgByName("STATUS","�����ļ��ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�����ļ��ɹ�!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("UPDATEFILE")){				//����Ĵ���Ϊ���±����ļ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          mFileSize=MsgObj.MsgFileSize();								//ȡ���ĵ���С
          mFileDate=DbaObj.GetDateTime();								//ȡ���ĵ�ʱ��
          mFileBody=MsgObj.MsgFileBody();								//ȡ���ĵ�����
          mFilePath="";													//�������Ϊ�ļ�������д�ļ�·��
          mUserName=mUserName;											//ȡ�ñ����û�����
          mDescript="����汾";											//�汾˵��
          MsgObj.MsgTextClear();
          if (SaveVersion()){											//�����ĵ�����
            MsgObj.SetMsgByName("STATUS", "���涨��汾�ɹ�!");			//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("���涨��汾ʧ��!");						//���ô�����Ϣ
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("INSERTIMAGE")){				//����Ĵ���Ϊ���������ͼƬ
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mLabelName=MsgObj.GetMsgByName("LABELNAME");					//��ǩ��
          mImageName=MsgObj.GetMsgByName("IMAGENAME");					//ͼƬ��
          mFilePath=mFilePath+"\\Document\\"+mImageName;				//ͼƬ�ڷ�����������·��
          mFileType=mImageName.substring(mImageName.length()-4).toLowerCase() ;	//ȡ���ļ�������
          MsgObj.MsgTextClear();
          if (MsgObj.MsgFileLoad(mFilePath)){							//����ͼƬ
            MsgObj.SetMsgByName("IMAGETYPE",mFileType);					//ָ��ͼƬ������
            MsgObj.SetMsgByName("POSITION",mLabelName);					//���ò����λ��[��ǩ������]
            MsgObj.SetMsgByName("STATUS","����ͼƬ�ɹ�!");				//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ͼƬʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("PUTFILE")){					//����Ĵ���Ϊ�����ϴ��ļ�����
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileBody=MsgObj.MsgFileBody();								//ȡ���ĵ�����
          mLocalFile=MsgObj.GetMsgByName("LOCALFILE");					//ȡ�ñ����ļ�����
          mRemoteFile=MsgObj.GetMsgByName("REMOTEFILE");				//ȡ��Զ���ļ�����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          mFilePath=mFilePath+"\\Document\\"+mRemoteFile;
          if (MsgObj.MsgFileSave(mFilePath)){							//�����ĵ�
            MsgObj.SetMsgByName("STATUS","�����ϴ��ļ��ɹ�!");			//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�ϴ��ļ�ʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("GETFILE")){					//����Ĵ���Ϊ���������ļ�����
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mLocalFile=MsgObj.GetMsgByName("LOCALFILE");					//ȡ�ñ����ļ�����
          mRemoteFile=MsgObj.GetMsgByName("REMOTEFILE");				//ȡ��Զ���ļ�����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          mFilePath=mFilePath+"\\Document\\"+mRemoteFile;
          if (MsgObj.MsgFileLoad(mFilePath)){							//�����ĵ�����
            MsgObj.SetMsgByName("STATUS","���������ļ��ɹ�!");			//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("�����ļ�ʧ��!");							//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("DATETIME")){					//����Ĵ���Ϊ����ȡ�÷�����ʱ��
          MsgObj.MsgTextClear();										//����ı���Ϣ
          MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//��׼���ڸ�ʽ�ִ����� 2005-8-16 10:20:35
        }

        else if(mOption.equalsIgnoreCase("SENDMESSAGE")){				//����Ĵ���ΪWebҳ��������Ϣ[��չ�ӿ�]
          
          mFileName=MsgObj.GetMsgByName("FILENAME");					//ȡ���ĵ�����
          mCommand=MsgObj.GetMsgByName("COMMAND");						//ȡ�ò������� InportText or ExportText
          mContent=MsgObj.GetMsgByName("CONTENT");						//ȡ���ı���Ϣ Content
          mOfficePrints=MsgObj.GetMsgByName("OFFICEPRINTS");			//ȡ��Office�ĵ��Ĵ�ӡ����
		  mInfo = MsgObj.GetMsgByName("TESTINFO");						//ȡ�ÿͻ��˴������Զ�����Ϣ
		  
		  //ȡ���ĵ��������Ϣ��
		  mSubject = MsgObj.GetMsgByName("Subject");         
          mFileDate = MsgObj.GetMsgByName("FileDate");
          mSaveStatus = MsgObj.GetMsgByName("SaveStatus");
          mHTMLPath = MsgObj.GetMsgByName("HTMLPath");
          
          mUserName = MsgObj.GetMsgByName("USERNAME");                  //ȡ��ǰ�Ĳ����û�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//ȡ���ĵ�����
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");                    //ȡ���ĵ�ģ����
           
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
          System.out.println(mCommand);
          
          if(mCommand.equalsIgnoreCase("saveToTableDocument")){
            if(saveToTableDocument()){
            	MsgObj.SetMsgByName("STATUS","�ɹ������ĵ��������Ϣ���档");
                MsgObj.MsgError("");
            }else{
            	MsgObj.MsgError("�ĵ������Ϣ����ʧ�ܣ�");
            }          
          }else if (mCommand.equalsIgnoreCase("INPORTTEXT")){
			if (LoadContent()){
			  MsgObj.SetMsgByName("CONTENT",mContent);
			  MsgObj.SetMsgByName("STATUS", "����ɹ�!");				//����״̬��Ϣ
			  MsgObj.MsgError("");										//���������Ϣ
            }else{
			  MsgObj.MsgError("����ʧ��!");								//���ô�����Ϣ
            }
          }else if (mCommand.equalsIgnoreCase("EXPORTTEXT")){
			if (SaveContent()){
			  MsgObj.SetMsgByName("STATUS", "�����ɹ�!");				//����״̬��Ϣ
			  MsgObj.MsgError("");										//���������Ϣ
			}else{
			  MsgObj.MsgError("����ʧ��!");								//���ô�����
			}
          }else if (mCommand.equalsIgnoreCase("WORDTABLE")){
			if (GetWordTable()){
			  MsgObj.SetMsgByName("COLUMNS",String.valueOf(mColumns));	//��
			  MsgObj.SetMsgByName("CELLS",String.valueOf(mCells));		//��
			  MsgObj.SetMsgByName("WORDCONTENT",mTableContent);			//�������
			  MsgObj.SetMsgByName("STATUS", "���Ӻ����ɹ��ɹ�!");		//����״̬��Ϣ
			  MsgObj.MsgError("");										//���������Ϣ
			}else{
			  MsgObj.MsgError("���ӱ����ʧ��!");						//���ô�����Ϣ
			}
          }else if (mCommand.equalsIgnoreCase("COPIES")){				//��ӡ����
            System.out.println(mOfficePrints);
            mCopies=Integer.parseInt(mOfficePrints);					//��ÿͻ���Ҫ��ӡ�ķ���
            if (mCopies<=2){											//�Ƚϴ�ӡ�������ⶨ���ĵ������ӡ������Ϊ2�ݣ�ע�����������ݿ������ú��ĵ������ӡ�ķ���
              if (UpdataCopies(2-mCopies)){								//���´�ӡ����
                MsgObj.SetMsgByName("STATUS", "1");						//����״̬��Ϣ�������ӡ
                MsgObj.MsgError("");									//���������Ϣ
              }
            }
            else{
              MsgObj.SetMsgByName("STATUS", "0");						//�������ӡ
              MsgObj.MsgError("������ӡ�޶Ȳ������ӡ!");				//���ô�����Ϣ
            }
          }else if (mCommand.equalsIgnoreCase("SELFINFO")){
			mInfo = "���������յ��ͻ��˴�������Ϣ����" + mInfo + "�� | " ;
            //��Ϸ��ظ��ͻ��˵���Ϣ
			mInfo = mInfo + "�������˷��ص�ǰ������ʱ�䣺" + DbaObj.GetDateTime();
			MsgObj.SetMsgByName("RETURNINFO",mInfo);					//�����ص���Ϣ���õ���Ϣ����
		  }else{
            MsgObj.MsgError("�ͻ���Web�������ݰ�����û�к��ʵĴ�����!["+mCommand+"]");
            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEPAGE")){					//����Ĵ���Ϊ����Ϊȫ����ע��ʽ�ļ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          mFilePath=mFilePath+"\\Document\\"+mRecordID+".pgf";			//ȫ����ע�ļ�������·��
          if (MsgObj.MsgFileSave(mFilePath)){							//����ȫ����ע�ļ�
            MsgObj.SetMsgByName("STATUS","����ȫ����ע�ɹ�!");			//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("����ȫ����עʧ��!");						//���ô�����Ϣ
          }
        }

        else if(mOption.equalsIgnoreCase("LOADPAGE")){					//����Ĵ���Ϊ����ȫ����ע��ʽ�ļ�
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//ȡ���ĵ����
          MsgObj.MsgTextClear();										//����ı���Ϣ
          mFilePath=mFilePath+"\\Document\\"+mRecordID+".pgf";			//ȫ����ע�ļ�������·��
          if (MsgObj.MsgFileLoad(mFilePath)){							//�����ĵ�����
            MsgObj.SetMsgByName("STATUS","��ȫ����ע�ɹ�!");			//����״̬��Ϣ
            MsgObj.MsgError("");										//���������Ϣ
          }
          else{
            MsgObj.MsgError("��ȫ����עʧ��!");						//���ô�����Ϣ
          }
        }
      }
      else{
        MsgObj.MsgError("�ͻ��˷������ݰ�����!");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
    }
    else
    {
      MsgObj.MsgError("��ʹ��Post����");
      MsgObj.MsgTextClear();
      MsgObj.MsgFileClear();
    }
    System.out.println("SendPackage") ;
    System.out.println("") ;
    SendPackage(response);
  }
  catch(Exception e){
    System.out.println(e.toString()) ;
  }
  }
}
%>
<%
iWebOffice officeServer = new iWebOffice();
officeServer.ExecuteRun(request,response);
%>
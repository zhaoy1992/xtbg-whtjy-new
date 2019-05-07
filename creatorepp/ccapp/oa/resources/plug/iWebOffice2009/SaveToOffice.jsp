<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.sql.BLOB" %>
<%@ page import="oracle.jdbc.OracleDriver" %>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="DBstep.iMsgServer2000.*" %>
<%@ page import="DBstep.iDBManager2000.*" %>
<%!
 private byte[] mFileBody;
 private String mFileName;
 private String mFilePath;
 private int mFileSize;
 private String Sql;

 private DBstep.iMsgServer2000 MsgObj;
 private DBstep.iDBManager2000 DbaObj ;

 //��ȡ���ֶ�
 private void GetAtBlob(BLOB vField,int vSize) throws IOException
 {
   try
   {
     mFileBody = new byte[vSize];
     InputStream instream=vField.getBinaryStream();
     instream.read(mFileBody,0,vSize);
     instream.close();
   }
   catch(SQLException e)
   {
     System.out.println(e.getMessage());
   }
 }

 //�����ĵ������ĵ����ݱ�����mFileBody��Ա���д��
  private boolean LoadFile()
  {
    boolean mResult = false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileSize=result.getInt("FileSize");
              mFileName = result.getString("FileName");
	      GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
              if (result.wasNull()) {
                mFileBody = null;
              }
              mResult = true ;
            }
            catch (IOException ex) {
              System.out.println(ex.toString());
            }
          }
          else{
            System.out.println("û�ҵ��ĵ���¼");
            mResult = false ;
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

%>

<%
  String mRecordID=request.getParameter("RecordID");      //1141208427234
  if (mRecordID==null)
  {
    Sql = "SELECT FileName,FileBody FROM Document_File";  //ȡ�õ�һ����¼
  }else{
    Sql = "SELECT FileName,FileBody FROM Document_File WHERE RecordID='" + mRecordID + "'";
  }
  mFileBody=null;
  mFileName="";
  mFileSize=0;

  mFilePath=application.getRealPath("") ;  //ȡ�÷�����·��
  DbaObj=new DBstep.iDBManager2000();      //������Ϣ������
  MsgObj=new DBstep.iMsgServer2000();      //�������ݿ����

  try
  {
	if (LoadFile())					        //�����ĵ�
	{
	  MsgObj.MsgFileBody(mFileBody);			//���ļ���Ϣ���
	  mFileBody=MsgObj.ToDocument(MsgObj.MsgFileBody());    //ͨ��iMsgServer200 ��pgf�ļ���ת��Ϊ��ͨOffice�ļ���
	  MsgObj.MsgFileBody(mFileBody);			//�����ļ�������
	  MsgObj.MsgFileSave(mFilePath+"/"+mFileName);		//����doc�ļ�
          out.println("�ɹ����ڷ���������OFFICE�ĵ�"+mFilePath+"/"+mFileName);
	}
	else
	{
          out.println("ʧ�ܣ��ڷ���������OFFICE�ĵ�");
	}
        MsgObj.MsgFileClear();
  }
  catch(IOException e)
  {
    out.println("�����쳣");
    System.out.println(e.toString());
  }
%>

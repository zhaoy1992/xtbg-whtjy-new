package com.chinacreator.xtbg.core.common.iweboffice;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.sql.BLOB;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.iWebOffice2006.iDBManager2000;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.iweboffice.dao.IWebOfficeDataManageDao;
import com.chinacreator.xtbg.core.common.iweboffice.util.Doc2Pdf2SwfUtil;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

public class IWebOffice {

	private int mFileSize;
	private byte[] mFileBody;
	private String mFileName;
	private String mFileType;
	private String mFileDate;
	private String mFileID;
	private String mTemplateId;

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
	private String mDBType;

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

	// 保存文档的附加信息，所增加的变量。
	private String mSaveStatus;
	private String mSubject;
	private String mHTMLPath;

	// 打印控制
	private String mOfficePrints;
	private int mCopies;

	// 自定义信息传递
	private String mInfo;

	private IWebOfficeMsgServer MsgObj;
	private iDBManager2000 DbaObj;

	public String getmDBType() {
		return mDBType;
	}

	public void setmDBType(String mDBType) {
		this.mDBType = mDBType;
	}

	public int getmFileSize() {
		return mFileSize;
	}

	public void setmFileSize(int mFileSize) {
		this.mFileSize = mFileSize;
	}

	public byte[] getmFileBody() {
		return mFileBody;
	}

	public void setmFileBody(byte[] mFileBody) {
		this.mFileBody = mFileBody;
	}

	public String getmFileName() {
		return mFileName;
	}

	public void setmFileName(String mFileName) {
		this.mFileName = mFileName;
	}

	public String getmFileType() {
		return mFileType;
	}

	public void setmFileType(String mFileType) {
		this.mFileType = mFileType;
	}

	public String getmFileDate() {
		return mFileDate;
	}

	public void setmFileDate(String mFileDate) {
		this.mFileDate = mFileDate;
	}

	public String getmFileID() {
		return mFileID;
	}

	public void setmFileID(String mFileID) {
		this.mFileID = mFileID;
	}

	public String getmTemplateId() {
		return mTemplateId;
	}

	public void setmTemplateId(String mTemplateId) {
		this.mTemplateId = mTemplateId;
	}

	public String getmRecordID() {
		return mRecordID;
	}

	public void setmRecordID(String mRecordID) {
		this.mRecordID = mRecordID;
	}

	public String getmTemplate() {
		return mTemplate;
	}

	public void setmTemplate(String mTemplate) {
		this.mTemplate = mTemplate;
	}

	public String getmDateTime() {
		return mDateTime;
	}

	public void setmDateTime(String mDateTime) {
		this.mDateTime = mDateTime;
	}

	public String getmOption() {
		return mOption;
	}

	public void setmOption(String mOption) {
		this.mOption = mOption;
	}

	public String getmMarkName() {
		return mMarkName;
	}

	public void setmMarkName(String mMarkName) {
		this.mMarkName = mMarkName;
	}

	public String getmPassword() {
		return mPassword;
	}

	public void setmPassword(String mPassword) {
		this.mPassword = mPassword;
	}

	public String getmMarkList() {
		return mMarkList;
	}

	public void setmMarkList(String mMarkList) {
		this.mMarkList = mMarkList;
	}

	public String getmBookmark() {
		return mBookmark;
	}

	public void setmBookmark(String mBookmark) {
		this.mBookmark = mBookmark;
	}

	public String getmDescript() {
		return mDescript;
	}

	public void setmDescript(String mDescript) {
		this.mDescript = mDescript;
	}

	public String getmHostName() {
		return mHostName;
	}

	public void setmHostName(String mHostName) {
		this.mHostName = mHostName;
	}

	public String getmMarkGuid() {
		return mMarkGuid;
	}

	public void setmMarkGuid(String mMarkGuid) {
		this.mMarkGuid = mMarkGuid;
	}

	public String getmCommand() {
		return mCommand;
	}

	public void setmCommand(String mCommand) {
		this.mCommand = mCommand;
	}

	public String getmContent() {
		return mContent;
	}

	public void setmContent(String mContent) {
		this.mContent = mContent;
	}

	public String getmHtmlName() {
		return mHtmlName;
	}

	public void setmHtmlName(String mHtmlName) {
		this.mHtmlName = mHtmlName;
	}

	public String getmDirectory() {
		return mDirectory;
	}

	public void setmDirectory(String mDirectory) {
		this.mDirectory = mDirectory;
	}

	public String getmFilePath() {
		return mFilePath;
	}

	public void setmFilePath(String mFilePath) {
		this.mFilePath = mFilePath;
	}

	public String getmUserName() {
		return mUserName;
	}

	public void setmUserName(String mUserName) {
		this.mUserName = mUserName;
	}

	public int getmColumns() {
		return mColumns;
	}

	public void setmColumns(int mColumns) {
		this.mColumns = mColumns;
	}

	public int getmCells() {
		return mCells;
	}

	public void setmCells(int mCells) {
		this.mCells = mCells;
	}

	public String getmMyDefine1() {
		return mMyDefine1;
	}

	public void setmMyDefine1(String mMyDefine1) {
		this.mMyDefine1 = mMyDefine1;
	}

	public String getmLocalFile() {
		return mLocalFile;
	}

	public void setmLocalFile(String mLocalFile) {
		this.mLocalFile = mLocalFile;
	}

	public String getmRemoteFile() {
		return mRemoteFile;
	}

	public void setmRemoteFile(String mRemoteFile) {
		this.mRemoteFile = mRemoteFile;
	}

	public String getmLabelName() {
		return mLabelName;
	}

	public void setmLabelName(String mLabelName) {
		this.mLabelName = mLabelName;
	}

	public String getmImageName() {
		return mImageName;
	}

	public void setmImageName(String mImageName) {
		this.mImageName = mImageName;
	}

	public String getmTableContent() {
		return mTableContent;
	}

	public void setmTableContent(String mTableContent) {
		this.mTableContent = mTableContent;
	}

	public String getSql() {
		return Sql;
	}

	public void setSql(String sql) {
		Sql = sql;
	}

	public String getmSaveStatus() {
		return mSaveStatus;
	}

	public void setmSaveStatus(String mSaveStatus) {
		this.mSaveStatus = mSaveStatus;
	}

	public String getmSubject() {
		return mSubject;
	}

	public void setmSubject(String mSubject) {
		this.mSubject = mSubject;
	}

	public String getmHTMLPath() {
		return mHTMLPath;
	}

	public void setmHTMLPath(String mHTMLPath) {
		this.mHTMLPath = mHTMLPath;
	}

	public String getmOfficePrints() {
		return mOfficePrints;
	}

	public void setmOfficePrints(String mOfficePrints) {
		this.mOfficePrints = mOfficePrints;
	}

	public int getmCopies() {
		return mCopies;
	}

	public void setmCopies(int mCopies) {
		this.mCopies = mCopies;
	}

	public String getmInfo() {
		return mInfo;
	}

	public void setmInfo(String mInfo) {
		this.mInfo = mInfo;
	}

/*	public DBstep.iMsgServer2000 getMsgObj() {
		return MsgObj;
	}

	public void setMsgObj(DBstep.iMsgServer2000 msgObj) {
		MsgObj = msgObj;
	}*/
	
	public iDBManager2000 getDbaObj() {
		return DbaObj;
	}

	/**
	 * <b>Summary: </b>
	 *     获取msgObj的值
	 * @return msgObj 
	 */
	public IWebOfficeMsgServer getMsgObj() {
		return MsgObj;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 msgObj 的值 
	 * @param msgObj 
	 */
	public void setMsgObj(IWebOfficeMsgServer msgObj) {
		MsgObj = msgObj;
	}

	public void setDbaObj(iDBManager2000 dbaObj) {
		DbaObj = dbaObj;
	}

	// ************* Bolb字段处理代码 开始 *******************************
	public void PutAtBlob(BLOB vField, int vSize) throws IOException {
		try {
			int blobsize = (int) vField.length();
			System.out.println("PutAtBlob,vSize:" + vSize);
			System.out.println("PutAtBlob,blobsize:" + blobsize);
			OutputStream outstream = vField.getBinaryOutputStream();
			outstream.write(mFileBody, 0, vSize);
			outstream.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void GetAtBlob(BLOB vField, int vSize) throws IOException {
		try {
			int blobsize = (int) vField.length();
			System.out.println("GetAtBlob,vSize:" + vSize);
			System.out.println("GetAtBlob,blobsize:" + blobsize);
			mFileBody = new byte[vSize];
			InputStream instream = vField.getBinaryStream();
			instream.read(mFileBody, 0, vSize);
			instream.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 功能或作用：格式化日期时间
	 * 
	 * @param DateValue
	 *            输入日期或时间
	 * @param DateType
	 *            格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟, ss是秒
	 * @return 输出字符串
	 */
	public String FormatDate(String DateValue, String DateType) {
		String Result;
		SimpleDateFormat formatter = new SimpleDateFormat(DateType);
		try {
			Date mDateTime = formatter.parse(DateValue);
			Result = formatter.format(mDateTime);
		} catch (Exception ex) {
			Result = ex.getMessage();
		}
		if (Result.equalsIgnoreCase("1900-01-01")) {
			Result = "";
		}
		return Result;
	}

	// ************* Bolb字段处理 结束 *******************************

	// ************* 文档、模板管理代码 开始 *******************************
	// 调出文档，将文档内容保存在mFileBody里，以便进行打包
	private boolean LoadFile(String textType) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("textType", textType);
		return ((IWebOfficeDataManageDao) IWebOfficeDBManager.getInstance(this,
				DbaObj)).LoadFile(params);
	}

	// 保存文档，如果文档存在，则覆盖，不存在，则添加
	private boolean SaveFile(String textType) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("textType", textType);
		return ((IWebOfficeDataManageDao) IWebOfficeDBManager.getInstance(this,
				DbaObj)).SaveFile(params);
	}

	// 保存word文档的附加信息，存入表Document

	private boolean saveToTableDocument() {

		System.out.println("mSubject:" + mSubject);
		System.out.println("mFileDate:" + mFileDate);
		System.out.println("mSaveStatus:" + mSaveStatus);
		System.out.println("mHTMLPath:" + mHTMLPath);
		System.out.println("mUserName:" + mUserName);
		System.out.println("mRecordID:" + mRecordID);
		System.out.println("mFileType:" + mFileType);
		System.out.println("mTemplate:" + mTemplate);

		int mDocumentId = 0;

		iDBManager2000 DbaObj = new iDBManager2000();
		if (DbaObj.OpenConnection()) {
			String mysql = "SELECT DocumentID,RecordID from  Document Where RecordID='"
					+ mRecordID + "'";
			// String mFileDate=DbaObj.GetDateTime() ;
			try {
				ResultSet result = DbaObj.ExecuteQuery(mysql);
				if (result.next()) {
					mysql = "update Document set DocumentID=?,RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"
							+ mRecordID + "'";
					mDocumentId = result.getInt("DocumentID");
				} else {
					mysql = "insert into Document (DocumentID,RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?,?)";
					mDocumentId = DbaObj.GetMaxID("Document", "DocumentID");
				}
				result.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			java.sql.PreparedStatement prestmt = null;
			try {
				prestmt = DbaObj.Conn.prepareStatement(mysql);
				prestmt.setInt(1, mDocumentId);
				prestmt.setString(2, mRecordID);
				prestmt.setString(3, mTemplate);
				prestmt.setString(4, mSubject);
				prestmt.setString(5, mUserName);
				prestmt.setDate(6, DbaObj.GetDate());
				prestmt.setString(7, mFileType);
				prestmt.setString(8, mHTMLPath);
				prestmt.setString(9, "READ");

				DbaObj.Conn.setAutoCommit(true);
				prestmt.executeUpdate();
				DbaObj.Conn.commit();

			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				try {
					prestmt.close();
				} catch (Exception ex) {
					System.out.println(ex.toString());
				}
			}
			DbaObj.CloseConnection();
		} else {
			System.out.println("OpenDatabase Error");
		}
		return true;
	}

	// 调出模板文档，将模板文档内容保存在mFileBody里，以便进行打包
	private boolean LoadTemplate() {
		boolean mResult = false;
		String Sql = "SELECT FileBody,FileSize FROM oa_octl_template_file WHERE RecordID='"
				+ mTemplate + "'";
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					if (result.next()) {
						try {
							mFileSize = result.getInt("FileSize");
							// GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
							GetAtBlob((oracle.sql.BLOB) result
									.getObject("FileBody"), mFileSize);
							mResult = true;
						} catch (Exception ex) {
							ex.printStackTrace();
						}
					}
					result.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 保存模板文档，如果模板文档存在，则覆盖，不存在，则添加
	private boolean SaveTemplate() {
		boolean mResult = false;
		String Sql = "SELECT * FROM oa_octl_template_file WHERE RecordID='" + mTemplate
				+ "'";
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					if (result.next()) {
						Sql = "update oa_octl_template_file set TemplateID=?,RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=EMPTY_BLOB(),FilePath=?,UserName=?,Descript=? WHERE RecordID='"
								+ mTemplate + "'";
						mTemplateId = result.getString("TemplateId");
					} else {
						Sql = "insert into oa_octl_template_file (TemplateID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
						mTemplateId = StringUtil.getUUID();
					}
					result.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
					mResult = false;
				}
				java.sql.PreparedStatement prestmt = null;
				try {
					prestmt = DbaObj.Conn.prepareStatement(Sql);
					prestmt.setString(1, mTemplateId);
					prestmt.setString(2, mTemplate);
					prestmt.setString(3, mFileName);
					prestmt.setString(4, mFileType);
					prestmt.setInt(5, mFileSize);
					prestmt.setDate(6, DbaObj.GetDate());
					prestmt.setString(7, mFilePath);
					prestmt.setString(8, mUserName);
					prestmt.setString(9, mDescript); // "通用版本"
					DbaObj.Conn.setAutoCommit(true);
					prestmt.execute();
					DbaObj.Conn.commit();
					prestmt.close();
					Statement stmt = null;
					DbaObj.Conn.setAutoCommit(false);
					stmt = DbaObj.Conn.createStatement();
					// OracleResultSet
					// update=(OracleResultSet)stmt.executeQuery("select FileBody from Template_File where TEMPLATEID="
					// + String.valueOf(mTemplateId)+ " for update");
					ResultSet rs = stmt
							.executeQuery("select FileBody from oa_octl_template_file where TEMPLATEID='"
									+ mTemplateId
									+ "' for update");
					if (rs.next()) {
						try {
							mFileSize = mFileBody.length;
							// PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
							PutAtBlob((BLOB) rs.getObject("FileBody"),
									mFileSize);
						} catch (IOException e) {
							System.out.println(e.toString());
							mResult = false;
						}
					}
					rs.close();
					stmt.close();

					DbaObj.Conn.commit();
					mFileBody = null;
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.toString());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// ************* 文档、模板管理代码 结束 *******************************

	// ************* 版本管理代码 开始 *******************************
	// 列出所有版本信息
	private boolean ListVersion() {
		boolean mResult = false;
		String mDesc = "";
		String Sql = "SELECT FileID,FileDate,UserName,Descript FROM OA_VERSION_FILE WHERE RecordID='"
				+ mRecordID + "'";

		mFileID = "\r\n";
		mDateTime = "保存时间\r\n";
		mUserName = "用户名\r\n";
		mDescript = "版本说明\r\n";
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					while (result.next()) {
						try {
							mFileID += String.valueOf(result.getInt("FileID"))
									+ "\r\n"; // 文件号列表
							mDateTime += result.getString("FileDate") + "\r\n"; // 日期列表
							mUserName += result.getString("UserName") + "\r\n"; // 用户名列表
							mDesc = result.getString("Descript"); // 如果说明信息里有回车，则将回车变成>符号
							mDesc = mDesc.replace('\r', '>');
							mDesc = mDesc.replace('\n', '>');
							mDescript += mDesc + "\r\n";
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 调入选中版本，通过文件号调用mFileID,并把文件放入mFileBody里，以便进行打包
	private boolean LoadVersion(String mFileID) {
		boolean mResult = false;
		String Sql = "SELECT FileBody,FileSize FROM OA_VERSION_FILE WHERE RecordID='"
				+ mRecordID + "' and  FileID=" + mFileID;
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					if (result.next()) {
						try {
							mFileSize = result.getInt("FileSize");
							// GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
							GetAtBlob((BLOB) result.getObject("FileBody"),
									mFileSize);
							mResult = true;
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 保存版本，将该版本文件存盘，并将说明信息也保存起来
	private boolean SaveVersion() {
		boolean mResult = false;
		int iFileId = -1;
		String Sql = "insert into OA_VERSION_FILE (FileID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
		if (mFileID.equalsIgnoreCase("")) {
			iFileId = DbaObj.GetMaxID("OA_VERSION_FILE", "FileId");
		} else {
			iFileId = Integer.getInteger(mFileID.toString()).intValue();
		}
		try {
			if (DbaObj.OpenConnection()) {
				java.sql.PreparedStatement prestmt = null;
				try {
					prestmt = DbaObj.Conn.prepareStatement(Sql);
					prestmt.setInt(1, iFileId);
					prestmt.setString(2, mRecordID);
					prestmt.setString(3, mFileName);
					prestmt.setString(4, mFileType);
					prestmt.setInt(5, mFileSize);
					prestmt.setDate(6, DbaObj.GetDate());
					prestmt.setString(7, mFilePath);
					prestmt.setString(8, mUserName);
					prestmt.setString(9, mDescript); // "通用版本"
					DbaObj.Conn.setAutoCommit(true);
					prestmt.execute();
					DbaObj.Conn.commit();
					prestmt.close();
					Statement stmt = null;
					DbaObj.Conn.setAutoCommit(false);
					stmt = DbaObj.Conn.createStatement();
					// OracleResultSet
					// update=(OracleResultSet)stmt.executeQuery("select FileBody from OA_VERSION_FILE where Fileid="
					// + String.valueOf(iFileId)+ " for update");
					ResultSet rs = stmt
							.executeQuery("select FileBody from OA_VERSION_FILE where Fileid="
									+ String.valueOf(iFileId) + " for update");
					if (rs.next()) {
						try {
							// PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
							PutAtBlob((BLOB) rs.getObject("FileBody"),
									mFileSize);
						} catch (IOException e) {
							System.out.println(e.toString());
							mResult = false;
						}
					}
					rs.close();
					stmt.close();

					DbaObj.Conn.commit();
					mFileBody = null;
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.toString());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// ************* 版本管理代码 结束 *******************************

	// ************ 标签管理代码 开始 *******************************
	// 取得书签列表
	private boolean ListBookmarks() {
		boolean mResult = false;
		String Sql = "SELECT * FROM Bookmarks ";
		mBookmark = "";
		mDescript = "";
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					while (result.next()) {
						try {
							mBookmark += result.getString("BookMarkName")
									+ "\r\n"; // 用户名列表
							mDescript += result.getString("BookMarkDesc")
									+ "\r\n"; // 如果说明信息里有回车，则将回车变成>符号
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 装入书签
	private boolean LoadBookMarks() {
		boolean mResult = false;
		String Sql = " select b.BookMarkName,b.BookMarkText from Template_BookMarks a,BookMarks b where a.BookMarkname=b.BookMarkName and a.RecordID='"
				+ mTemplate + "'";
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					while (result.next()) {
						try {
							// 说明：我们测试程序把SQL语句直接写到替换标签内容
							// 实际使用中，这个标签内容是通过Sql语句得到的。
							// 生成SQL查询语句 result.getString("BookMarkText") & "条件"
							// 当前纪录号位 mRecordID
							// BookMarkValue=生成SQL运行结果
							String mBookMarkName = result
									.getString("BookMarkName");
							String mBookMarkValue = result
									.getString("BookMarkText");
							MsgObj.SetMsgByName(mBookMarkName, mBookMarkValue);
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 保存书签
	private boolean SaveBookMarks() {
		boolean mResult = false;
		String mBookMarkName;
		int mBookMarkId;
		int mIndex;
		try {
			if (DbaObj.OpenConnection()) {
				try {
					java.sql.PreparedStatement prestmt = null;
					String Sql = "DELETE FROM Template_BookMarks Where RecordID='"
							+ mTemplate + "'";
					prestmt = DbaObj.Conn.prepareStatement(Sql);
					DbaObj.Conn.setAutoCommit(true);
					prestmt.execute();
					DbaObj.Conn.commit();
					prestmt.close();

					for (mIndex = 7; mIndex <= MsgObj.GetFieldCount() - 1; mIndex++) {
						java.sql.PreparedStatement prestmtx = null;
						mBookMarkName = MsgObj.GetFieldName(mIndex);
						mBookMarkId = DbaObj.GetMaxID("Template_BookMarks",
								"BookMarkId");
						Sql = "insert into Template_BookMarks (BookMarkId,RecordId,BookMarkName) values ('"
								+ String.valueOf(mBookMarkId)
								+ "','"
								+ mTemplate + "','" + mBookMarkName + "')";
						prestmtx = DbaObj.Conn.prepareStatement(Sql);
						DbaObj.Conn.setAutoCommit(true);
						prestmtx.execute();
						DbaObj.Conn.commit();
						prestmtx.close();
					}
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.toString());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// ************ 标签管理代码 结束 *******************************

	// ************ 签章管理代码 开始 *******************************
	// 取得签名列表
	private boolean LoadMarkList() {
		String Sql = "SELECT utl_encode.text_encode(markname,'AL32UTF8', 1) MarkName FROM oa_Signature";
		mMarkList = "";
		boolean mResult = false;
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					while (result.next()) {
						try {
							mMarkList += result.getString("MarkName") + "DQo=";
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
					mResult = true;
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 调入签名纪录
	private boolean LoadMarkImage(String vMarkName, String vPassWord) {
		String Sql = "SELECT MarkBody,MarkType,MarkSize FROM oa_signature WHERE MarkName='"
				+ vMarkName + "' and PassWord='" + vPassWord + "'";
		boolean mResult = false;
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					if (result.next()) {
						try {
							mFileSize = result.getInt("MarkSize");
							// GetAtBlob(((OracleResultSet)result).getBLOB("MarkBody"),mFileSize);
							GetAtBlob((BLOB) result.getObject("MarkBody"),
									mFileSize);
							mFileType = result.getString("MarkType");
							mResult = true;
						} catch (Exception ex) {
							System.out.println(ex.toString());
						}
					}
					result.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					mResult = false;
				}
			}
		} finally {
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 保存签名
	private boolean SaveSignature() {
		boolean mResult = false;
		int iSignatureID;
		String Sql = "insert into oa_document_Signature (SignatureID,RecordID,MarkName,UserName,DateTime,HostName,MarkGuid) values (?,?,?,?,to_date('"
				+ mDateTime + "','yyyy-mm-dd hh24:mi:ss'),?,? ) ";
		iSignatureID = DbaObj.GetMaxID("oa_document_Signature", "SignatureID");
		if (DbaObj.OpenConnection()) {
			java.sql.PreparedStatement prestmt = null;
			try {
				prestmt = DbaObj.Conn.prepareStatement(Sql);
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
				mResult = true;
			} catch (SQLException e) {
				System.out.println(e.toString() + Sql);
				mResult = false;
			}
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// 列出所有签名
	private boolean LoadSignature() {
		boolean mResult = false;

		String Sql = "SELECT MarkName,UserName,DateTime,HostName,MarkGuid FROM oa_document_Signature WHERE RecordID='"
				+ mRecordID + "'";
		mMarkName = "印章名称\r\n";
		mUserName = "签名人\r\n";
		mDateTime = "签章时间\r\n";
		mHostName = "客户端IP\r\n";
		mMarkGuid = "序列号\r\n";

		if (DbaObj.OpenConnection()) {
			try {
				mResult = true;
				ResultSet result = DbaObj.ExecuteQuery(Sql);
				while (result.next()) {
					mMarkName += result.getString("MarkName") + "\r\n"; // 文件号列表
					mUserName += result.getString("UserName") + "\r\n"; // 日期列表
					mDateTime += FormatDate(result.getString("DateTime"),
							"yyyy-MM-dd HH:mm:ss")
							+ "\r\n";
					mHostName += result.getString("HostName") + "\r\n";
					mMarkGuid += result.getString("MarkGuid") + "\r\n";
				}
				result.close();
			} catch (Exception e) {
				System.out.println(e.toString());
				mResult = false;
			}
			DbaObj.CloseConnection();
		}
		return (mResult);
	}

	// ************ 签章管理代码 结束 *******************************

	// ************ 扩展功能代码 开始 *******************************
	// 调出所对应的文本
	private boolean LoadContent() {
		boolean mResult = false;
		// 打开数据库
		// 根据 mRecordID 或 mFileName 等信息
		// 提取文本信息付给mContent即可。
		// 本演示假设取得的文本信息如下：
		mContent = "";
		mContent += "本文的纪录号：" + mRecordID + "\n";
		mContent += "本文的文件名：" + mFileName + "\n";
		mContent += "    这个部分请自己加入，和你们的数据库结合起来就可以了\n";
		mResult = true;
		return (mResult);
	}

	// 保存所对应的文本
	private boolean SaveContent() {
		boolean mResult = false;
		// 打开数据库
		// 根据 mRecordID 或 mFileName 等信息
		// 插入文本信息 mContent里的文本到数据库中即可。
		mResult = true;
		return (mResult);
	}

	// 增加行并填充表格内容
	private boolean GetWordTable() {
		int i, n;
		String strI, strN;
		boolean mResult;
		mColumns = 3;
		mCells = 8;
		MsgObj.MsgTextClear();
		MsgObj.SetMsgByName("COLUMNS", String.valueOf(mColumns)); // 设置表格行
		MsgObj.SetMsgByName("CELLS", String.valueOf(mCells)); // 设置表格列
		// 该部分内容可以从数据库中读取
		try {
			for (i = 1; i <= mColumns; i++) {
				strI = String.valueOf(i);
				for (n = 1; n <= mCells; n++) {
					MsgObj.SetMsgByName(String.valueOf(i) + String.valueOf(n),
							"内容" + DbaObj.GetDateTime());
				}
			}
			mResult = true;
		} catch (Exception e) {
			System.out.println(e.toString());
			mResult = false;
		}
		return (mResult);
	}

	// 更新打印份数
	private boolean UpdataCopies(int mLeftCopies) {
		boolean mResult = true;

		// 该函数可以把打印减少的次数记录到数据库

		// 根据自己的系统进行扩展该功能
		return mResult;
	}

	// ************ 扩展功能代码 结束 *******************************

	// *************接收流、写回流代码 开始 *******************************
	// 取得客户端发来的数据包
	private byte[] ReadPackage(HttpServletRequest request) {
		byte mStream[] = null;
		int totalRead = 0;
		int readBytes = 0;
		int totalBytes = 0;
		try {
			totalBytes = request.getContentLength();
			mStream = new byte[totalBytes];
			while (totalRead < totalBytes) {
				request.getInputStream();
				readBytes = request.getInputStream().read(mStream, totalRead,
						totalBytes - totalRead);
				totalRead += readBytes;
				continue;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return (mStream);
	}

	// 发送处理后的数据包
	private void SendPackage(HttpServletResponse response) {
		try {
			ServletOutputStream OutBinarry = response.getOutputStream();
			OutBinarry.write(MsgObj.MsgVariant());
			OutBinarry.flush();
			OutBinarry.close();
		} catch (IOException e) {
			System.out.println(e.toString());
		}
	}

	private void loadExtParam(String ExtParam) {
		if(!"true".equalsIgnoreCase(ExtParam) && !"false".equalsIgnoreCase(ExtParam)){//edit by huanghai 2013-10-12 信息报送的传参值绕过这2句
			JSONObject jsonObj = JSONObject.parseObject(ExtParam);
			mDBType = jsonObj.getString("_DBType"); // 底层数据库处理类型
		}
	}

	// *************接收流、写回流代码 结束 *******************************

	public void ExecuteRun(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/*AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String user_id = control.getUserID();
	    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息
	    String loginIP = control.getMachinedID();
		//获取用户信息
	    String mUserName = userBean.getUser_realname();//control.getUserName();//request.getParameter("UserName");
	    
	    String user_name_IP = mUserName+" "+loginIP;
	    this.setmUserName(user_name_IP);*/
		
		DbaObj = new iDBManager2000(); // 创建数据库对象
		MsgObj = new IWebOfficeMsgServer(); // 创建信息包对象

		mOption = "";
		mRecordID = "";
		mTemplate = "";
		mFileBody = null;
		mFileName = "";
		mFileType = "";
		mFileSize = 0;
		mFileID = "";
		mDateTime = "";
		mMarkName = "";
		mPassword = "";
		mMarkList = "";
		mBookmark = "";
		mMarkGuid = "";
		mDescript = "";
		mCommand = "";
		mContent = "";
		mLabelName = "";
		mImageName = "";
		mTableContent = "";
		mMyDefine1 = "";
		mOfficePrints = "0";
		mDBType = "";

		mFilePath = request.getSession().getServletContext().getRealPath(""); // 取得服务器路径

		System.out.println("ReadPackage");

		try {
			if (request.getMethod().equalsIgnoreCase("POST")) {
				MsgObj.MsgVariant(ReadPackage(request));
				if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) { // 如果是合法的信息包
					mOption = MsgObj.GetMsgByName("OPTION"); // 取得操作信息
					//modify by shuqi.liu 将用户信息改为后台缓存获取，而不是前台传值，解决了中文乱码问题。
					System.out.println(MsgObj.GetMsgByName("USERNAME"));
					mUserName = MsgObj.GetMsgByName("USERNAME"); // 取得系统用户 user_name_IP;//
					System.out.println(mOption); // 打印出调试信息
					
					boolean isFromPaper = false;
					if(MsgObj.GetMsgByName("EXTPARAM")!=null 
							&& !StringUtil.isBlank(MsgObj.GetMsgByName("EXTPARAM")) 
							&& StringUtil.deNull(MsgObj.GetMsgByName("EXTPARAM")).equalsIgnoreCase("true")){
						isFromPaper = true;
					}
					//TODO modify by shuqi.liu 
					if(MsgObj.GetMsgByName("EXTPARAM")!=null && !StringUtil.isBlank(MsgObj.GetMsgByName("EXTPARAM")) 
							&& !StringUtil.deNull(MsgObj.GetMsgByName("EXTPARAM")).equalsIgnoreCase("true")){//modify by hai.huang 2013-09-27
						loadExtParam(MsgObj.GetMsgByName("EXTPARAM"));
					}
					
					String strfilepath = "";
					String strEXTPARAM= MsgObj.GetMsgByName("EXTPARAM");
					String openType = "";
					String insertBookMark = ""; //插入标签
					String textType = ""; //打开类型，正文面签跟正文是一个RecordID 用 TEXT_TYPE区别是正文，或者是面签
					if(!StringUtil.nullOrBlank(strEXTPARAM) && !"true".equalsIgnoreCase(strEXTPARAM) && !"false".equalsIgnoreCase(strEXTPARAM)){
						JSONObject jsonObj = JSONObject.parseObject(strEXTPARAM);
						openType = StringUtil.deNull(jsonObj.getString("openType")); // 底层数据库处理类型
						insertBookMark = StringUtil.deNull(jsonObj.getString("insertBookMark")); //插入正文书签名称
						strfilepath  = StringUtil.deNull(jsonObj.getString("strfilepath")); 
						textType  = StringUtil.deNull(jsonObj.getString("textType")); 
					}

					
					if (mOption.equalsIgnoreCase("LOADFILE")) { // 
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						if ("onlinebyupload".equalsIgnoreCase(openType) && MsgObj.MsgFileLoad(strfilepath)){
							MsgObj.MsgFileBody(MsgObj.MsgFileBody()); // 将文件信息打包
							MsgObj.SetMsgByName("STATUS", "打开成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						}else if (LoadFile(textType)){//下面的代码为打开服务器数据库里的文件
							MsgObj.MsgFileBody(mFileBody); // 将文件信息打包
							MsgObj.SetMsgByName("STATUS", "打开成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("打开失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("SAVEFILE")) { // 下面的代码为保存文件在服务器的数据库里
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						// mMyDefine1=MsgObj.GetMsgByName("mMyDefine1");
						// //取得客户端传递变量值 MyDefine1="自定义变量值1"
						mFileSize = MsgObj.MsgFileSize(); // 取得文档大小
						mFileDate = DbaObj.GetDateTime(); // 取得文档时间
						mFileBody = MsgObj.MsgFileBody(); // 取得文档内容
						// mFilePath=""; //如果保存为文件，则填写文件路径
						mUserName = mUserName; // 取得保存用户名称
						mDescript = "通用版本"; // 版本说明
						MsgObj.MsgTextClear(); // 清除文本信息

						if ("onlinebyupload".equalsIgnoreCase(openType)){
							boolean f = MsgObj.MsgFileSave(strfilepath);
							if(f) // 保存文档内容到数据库中
							{
								MsgObj.SetMsgByName("STATUS", "保存成功!"); // 设置状态信息
								MsgObj.MsgError("");// 清除错误信息
							} else {
								MsgObj.MsgError("保存失败!"); // 设置错误信息
							}
						}else{
							// 将文件保存到数据库，同时上传文件到服务器
							boolean saveData = SaveFile(textType);
							boolean saveFile = true;
							if (saveData && saveFile) {
								if(isFromPaper){
									MsgObj.MsgFileSave(mFilePath+ "//uploadDocument//" + mFileName);
								}
							} else {
								MsgObj.MsgError("保存失败!"); // 设置错误信息
							}
							if (saveData && saveFile) // 保存文档内容到数据库中
							{
								MsgObj.SetMsgByName("STATUS", "保存成功!"); // 设置状态信息
								MsgObj.MsgError("");// 清除错误信息
							} else {
								MsgObj.MsgError("保存失败!"); // 设置错误信息
							}
						}
						
						MsgObj.MsgFileClear(); // 清除文档内容
					}

					else if (mOption.equalsIgnoreCase("LOADTEMPLATE")) { // 下面的代码为打开服务器数据库里的模板文件
						mTemplate = MsgObj.GetMsgByName("TEMPLATE"); // 取得模板文档类型
						// 本段处理是否调用文档时打开模版，还是套用模版时打开模版。
						mCommand = MsgObj.GetMsgByName("COMMAND"); // 取得客户端定义的变量COMMAND值
						if (mCommand.equalsIgnoreCase("INSERTFILE")) {
							if (MsgObj.MsgFileLoad(mFilePath + "\\Document\\"
									+ mTemplate)) {// 从服务器文件夹中调入模板文档
								MsgObj.SetMsgByName("STATUS", "打开模板成功!"); // 设置状态信息
								MsgObj.MsgError(""); // 清除错误信息
							} else {
								MsgObj.MsgError("打开模板失败!"); // 设置错误信息
							}
						} else {
							MsgObj.MsgTextClear(); // 清除文本信息
							if (LoadTemplate()) { // 调入模板文档
								MsgObj.MsgFileBody(mFileBody); // 将文件信息打包
								MsgObj.SetMsgByName("STATUS", "打开模板成功!"); // 设置状态信息
								MsgObj.MsgError(""); // 清除错误信息
							} else {
								MsgObj.MsgError("打开模板失败!"); // 设置错误信息
							}
						}
					}

					else if (mOption.equalsIgnoreCase("SAVETEMPLATE")) { // 下面的代码为保存模板文件在服务器的数据库里
						mTemplate = MsgObj.GetMsgByName("TEMPLATE"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						// mMyDefine1=MsgObj.GetMsgByName("MyDefine1");
						// //取得客户端传递变量值 MyDefine1="自定义变量值1"
						mFileSize = MsgObj.MsgFileSize(); // 取得文档大小
						mFileDate = DbaObj.GetDateTime(); // 取得文档时间
						mFileBody = MsgObj.MsgFileBody(); // 取得文档内容
						mFilePath = ""; // 如果保存为文件，则填写文件路径
						mUserName = mUserName; // 取得保存用户名称
						mDescript = "通用模板"; // 版本说明
						MsgObj.MsgTextClear();
						if (SaveTemplate()) { // 保存模板文档内容
							MsgObj.SetMsgByName("STATUS", "保存模板成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存模板失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear();
					}

					else if (mOption.equalsIgnoreCase("LISTVERSION")) { // 下面的代码为打开版本列表
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						MsgObj.MsgTextClear();
						if (ListVersion()) { // 生成版本列表
							MsgObj.SetMsgByName("FILEID", mFileID); // 将文档号列表打包
							MsgObj.SetMsgByName("DATETIME", mDateTime); // 将日期时间列表打包
							MsgObj.SetMsgByName("USERNAME", mUserName); // 将用户名列表打包
							MsgObj.SetMsgByName("DESCRIPT", mDescript); // 将说明信息列表打包
							MsgObj.SetMsgByName("STATUS", "版本列表成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("版本列表失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("LOADVERSION")) { // 下面的代码为打开版本文档
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileID = MsgObj.GetMsgByName("FILEID"); // 取得版本文档号
						MsgObj.MsgTextClear();
						if (LoadVersion(mFileID)) { // 调入该版本文档
							MsgObj.MsgFileBody(mFileBody); // 将文档信息打包
							MsgObj.SetMsgByName("STATUS", "打开版本成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("打开版本失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("SAVEVERSION")) { // 下面的代码为保存版本文档
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileID = MsgObj.GetMsgByName("FILEID"); // 取得版本文档号
																	// 如:WebSaveVersionByFileID，则FileID值存在
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						mFileSize = MsgObj.MsgFileSize(); // 取得文档大小
						mFileDate = DbaObj.GetDateTime(); // 取得文档时间
						mFileBody = MsgObj.MsgFileBody(); // 取得文档内容
						mFilePath = ""; // 如果保存为文件，则填写文件路径
						mUserName = mUserName; // 取得保存用户名称
						mDescript = MsgObj.GetMsgByName("DESCRIPT"); // 取得说明信息
						MsgObj.MsgTextClear();
						if (SaveVersion()) { // 保存版本文档
							MsgObj.SetMsgByName("STATUS", "保存版本成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存版本失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear(); // 清除文档内容
					}

					else if (mOption.equalsIgnoreCase("LOADBOOKMARKS")) { // 下面的代码为取得文档标签
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mTemplate = MsgObj.GetMsgByName("TEMPLATE"); // 取得模板编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						MsgObj.MsgTextClear();
						if (LoadBookMarks()) {
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("装入标签信息失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("SAVEBOOKMARKS")) { // 下面的代码为取得标签文档内容
						mTemplate = MsgObj.GetMsgByName("TEMPLATE"); // 取得模板编号
						if (SaveBookMarks()) {
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存标签信息失败!"); // 设置错误信息
						}
						MsgObj.MsgTextClear(); // 清除文本信息
					}

					else if (mOption.equalsIgnoreCase("LISTBOOKMARKS")) { // 下面的代码为显示标签列表
						MsgObj.MsgTextClear(); // 清除文本信息
						if (ListBookmarks()) {
							MsgObj.SetMsgByName("BOOKMARK", mBookmark); // 将用户名列表打包
							MsgObj.SetMsgByName("DESCRIPT", mDescript); // 将说明信息列表打包
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("调入标签失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("LOADMARKLIST")) { // 下面的代码为创建印章列表
						MsgObj.MsgTextClear(); // 清除文本信息
						if (LoadMarkList()) {
							MsgObj.SetMsgByName("MARKLIST", mMarkList); // 显示签章列表
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("创建印章列表失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("LOADMARKIMAGE")) { // 下面的代码为打开印章文件
						mMarkName = MsgObj.GetMsgByName("IMAGENAME"); // 取得签名名称
						mUserName = MsgObj.GetMsgByName("USERNAME"); // 取得用户名称
						mPassword = MsgObj.GetMsgByName("PASSWORD"); // 取得用户密码
						MsgObj.MsgTextClear(); // 清除文本信息
						if (LoadMarkImage(mMarkName, mPassword)) { // 调入签名信息
							MsgObj.SetMsgByName("IMAGETYPE", mFileType); // 设置签名类型
							MsgObj.MsgFileBody(mFileBody); // 将签名信息打包
							MsgObj.SetMsgByName("POSITION", "Manager"); // 插入位置
																		// 在文档中标签"Manager"
							MsgObj.SetMsgByName("ZORDER", "4"); // 4:在文字上方
																// 5:在文字下方
							MsgObj.SetMsgByName("STATUS", "打开成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("签名或密码错误!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("SAVESIGNATURE")) { // 下面的代码为保存签章基本信息
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文件名称
						mMarkName = MsgObj.GetMsgByName("MARKNAME"); // 取得签名名称
						mUserName = MsgObj.GetMsgByName("USERNAME"); // 取得用户名称
						mDateTime = MsgObj.GetMsgByName("DATETIME"); // 取得签名时间
						mHostName = request.getRemoteAddr(); // 取得用户IP
						mMarkGuid = MsgObj.GetMsgByName("MARKGUID"); // 取得唯一编号
						MsgObj.MsgTextClear(); // 清除文本信息
						if (SaveSignature()) { // 保存签章
							MsgObj.SetMsgByName("STATUS", "保存印章成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存印章失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("LOADSIGNATURE")) { // 下面的代码为调出签章基本信息
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						MsgObj.MsgTextClear(); // 清除文本信息
						if (LoadSignature()) { // 调出签章
							MsgObj.SetMsgByName("MARKNAME", mMarkName); // 将签名名称列表打包
							MsgObj.SetMsgByName("USERNAME", mUserName); // 将用户名列表打包
							MsgObj.SetMsgByName("DATETIME", mDateTime); // 将时间列表打包
							MsgObj.SetMsgByName("HOSTNAME", mHostName); // 将盖章IP地址列表打包
							MsgObj.SetMsgByName("MARKGUID", mMarkGuid); // 将唯一编号列表打包
							MsgObj.SetMsgByName("STATUS", "调入印章成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("调入印章失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("SAVEASHTML")) { // 下面的代码为将OFFICE存为HTML页面
						mHtmlName = MsgObj.GetMsgByName("HTMLNAME"); // 取得文件名称
						mDirectory = MsgObj.GetMsgByName("DIRECTORY"); // 取得目录名称
						MsgObj.MsgTextClear();
						if (mDirectory.trim().equalsIgnoreCase("")) {
							mFilePath = mFilePath
									+ "//ccapp//xtbg//resources//plug//iWebOffice2009//HTML";
						} else {
							mFilePath = mFilePath
									+ "//ccapp//xtbg//resources//plug//iWebOffice2009//HTML//"
									+ mDirectory;
						}
						MsgObj.MakeDirectory(mFilePath); // 创建路径
						if (MsgObj.MsgFileSave(mFilePath + "//" + mHtmlName)) { // 保存HTML文件
							MsgObj.MsgError(""); // 清除错误信息
							MsgObj.SetMsgByName("STATUS", "保存HTML成功!"); // 设置状态信息
						} else {
							MsgObj.MsgError("保存HTML失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear();
					}

					else if (mOption.equalsIgnoreCase("SAVEIMAGE")) { // 下面的代码为将OFFICE存为HTML图片页面
						mHtmlName = MsgObj.GetMsgByName("HTMLNAME"); // 取得文件名称
						mDirectory = MsgObj.GetMsgByName("DIRECTORY"); // 取得目录名称
						MsgObj.MsgTextClear();
						if (mDirectory.trim().equalsIgnoreCase("")) {
							mFilePath = mFilePath + "//HTMLIMAGE//";
						} else {
							mFilePath = mFilePath + "//HTMLIMAGE//"
									+ mDirectory;
						}
						MsgObj.MakeDirectory(mFilePath); // 创建路径
						if (MsgObj.MsgFileSave(mFilePath + "//" + mHtmlName)) { // 保存HTML文件
							MsgObj.MsgError(""); // 清除错误信息
							MsgObj.SetMsgByName("STATUS", "保存HTML图片成功!"); // 设置状态信息
						} else {
							MsgObj.MsgError("保存HTML图片失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear();
					}

					else if (mOption.equalsIgnoreCase("SAVEASPAGE")) { // 下面的代码为将手写批注存为HTML图片页面
						mHtmlName = MsgObj.GetMsgByName("HTMLNAME"); // 取得文件名称
						mDirectory = MsgObj.GetMsgByName("DIRECTORY"); // 取得目录名称
						MsgObj.MsgTextClear();
						if (mDirectory.trim().equalsIgnoreCase("")) {
							mFilePath = mFilePath + "\\HTML";
						} else {
							mFilePath = mFilePath + "\\HTML\\" + mDirectory;
						}
						MsgObj.MakeDirectory(mFilePath); // 创建路径
						if (MsgObj.MsgFileSave(mFilePath + "\\" + mHtmlName)) { // 保存HTML文件
							MsgObj.MsgError(""); // 清除错误信息
							MsgObj.SetMsgByName("STATUS", "保存批注HTML图片成功!"); // 设置状态信息
						} else {
							MsgObj.MsgError("保存批注HTML图片失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear();
					}

					else if (mOption.equalsIgnoreCase("INSERTFILE")) { // 下面的代码为插入文件
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						MsgObj.MsgTextClear();
						if (LoadFile(textType)) { // 调入文档
							if(StringUtil.isBlank(insertBookMark)){
								//如果没有传书签位置，那么默认为Content；
								insertBookMark = "Content";
							}
							MsgObj.MsgFileBody(mFileBody); // 将文件信息打包
							MsgObj.SetMsgByName("POSITION", insertBookMark); // 设置插入的位置[书签]
							MsgObj.SetMsgByName("STATUS", "插入文件成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("插入文件成功!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("UPDATEFILE")) { // 下面的代码为更新保存文件
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						mFileSize = MsgObj.MsgFileSize(); // 取得文档大小
						mFileDate = DbaObj.GetDateTime(); // 取得文档时间
						mFileBody = MsgObj.MsgFileBody(); // 取得文档内容
						mFilePath = ""; // 如果保存为文件，则填写文件路径
						mUserName = mUserName; // 取得保存用户名称
						mDescript = "定稿版本"; // 版本说明
						MsgObj.MsgTextClear();
						if (SaveVersion()) { // 保存文档内容
							MsgObj.SetMsgByName("STATUS", "保存定稿版本成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存定稿版本失败!"); // 设置错误信息
						}
						MsgObj.MsgFileClear();
					}

					else if (mOption.equalsIgnoreCase("INSERTIMAGE")) { // 下面的代码为插入服务器图片
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mLabelName = MsgObj.GetMsgByName("LABELNAME"); // 标签名
						mImageName = MsgObj.GetMsgByName("IMAGENAME"); // 图片名
						String upload_To_SeverPath  = OASystemCache.getContextProperty("upload_To_SeverPath");//配置文件设置服务器路径
						mFilePath = mFilePath + upload_To_SeverPath + mImageName; // 图片在服务器的完整路径
						mFileType = mImageName.substring(
								mImageName.length() - 4).toLowerCase(); // 取得文件的类型
						MsgObj.MsgTextClear();
						if (MsgObj.MsgFileLoad(mFilePath)) { // 调入图片
							MsgObj.SetMsgByName("IMAGETYPE", mFileType); // 指定图片的类型
							MsgObj.SetMsgByName("POSITION", mLabelName); // 设置插入的位置[书签对象名]
							MsgObj.SetMsgByName("STATUS", "插入图片成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("插入图片失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("PUTFILE")) { // 下面的代码为请求上传文件操作
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileBody = MsgObj.MsgFileBody(); // 取得文档内容
						mLocalFile = MsgObj.GetMsgByName("LOCALFILE"); // 取得本地文件名称
						mRemoteFile = MsgObj.GetMsgByName("REMOTEFILE"); // 取得远程文件名称
						MsgObj.MsgTextClear(); // 清除文本信息
						mFilePath = mRemoteFile;
						if (MsgObj.MsgFileSave(mFilePath)) { // 调入文档
							MsgObj.SetMsgByName("STATUS", "保存上传文件成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("上传文件失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("GETFILE")) { // 下面的代码为请求下载文件操作
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mLocalFile = MsgObj.GetMsgByName("LOCALFILE"); // 取得本地文件名称
						mRemoteFile = MsgObj.GetMsgByName("REMOTEFILE"); // 取得远程文件名称
						MsgObj.MsgTextClear(); // 清除文本信息
						mFilePath =  mRemoteFile;
						if (MsgObj.MsgFileLoad(mFilePath)) { // 调入文档内容
							MsgObj.SetMsgByName("STATUS", "保存下载文件成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("下载文件失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("DATETIME")) { // 下面的代码为请求取得服务器时间
						MsgObj.MsgTextClear(); // 清除文本信息
						MsgObj.SetMsgByName("DATETIME", "2006-01-01 10:24:24"); // 标准日期格式字串，如
																				// 2005-8-16
																				// 10:20:35
					}

					else if (mOption.equalsIgnoreCase("SENDMESSAGE")) { // 下面的代码为Web页面请求信息[扩展接口]

						mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
						mCommand = MsgObj.GetMsgByName("COMMAND"); // 取得操作类型
																	// InportText
																	// or
																	// ExportText
						mContent = MsgObj.GetMsgByName("CONTENT"); // 取得文本信息
																	// Content
						mOfficePrints = MsgObj.GetMsgByName("OFFICEPRINTS"); // 取得Office文档的打印次数
						mInfo = MsgObj.GetMsgByName("TESTINFO"); // 取得客户端传来的自定义信息

						// 取得文档的相关信息。
						mSubject = MsgObj.GetMsgByName("Subject");
						mFileDate = MsgObj.GetMsgByName("FileDate");
						mSaveStatus = MsgObj.GetMsgByName("SaveStatus");
						mHTMLPath = MsgObj.GetMsgByName("HTMLPath");

						mUserName = MsgObj.GetMsgByName("USERNAME"); // 取当前的操作用户
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						mFileType = MsgObj.GetMsgByName("FILETYPE"); // 取得文档类型
						mTemplate = MsgObj.GetMsgByName("TEMPLATE"); // 取得文档模板编号

						MsgObj.MsgTextClear();
						MsgObj.MsgFileClear();
						System.out.println(mCommand);

						if (mCommand.equalsIgnoreCase("saveToTableDocument")) {
							if (saveToTableDocument()) {
								MsgObj.SetMsgByName("STATUS", "成功将该文档的相关信息保存。");
								MsgObj.MsgError("");
							} else {
								MsgObj.MsgError("文档相关信息保存失败！");
							}
						} else if (mCommand.equalsIgnoreCase("INPORTTEXT")) {
							if (LoadContent()) {
								MsgObj.SetMsgByName("CONTENT", mContent);
								MsgObj.SetMsgByName("STATUS", "导入成功!"); // 设置状态信息
								MsgObj.MsgError(""); // 清除错误信息
							} else {
								MsgObj.MsgError("导入失败!"); // 设置错误信息
							}
						} else if (mCommand.equalsIgnoreCase("EXPORTTEXT")) {
							if (SaveContent()) {
								MsgObj.SetMsgByName("STATUS", "导出成功!"); // 设置状态信息
								MsgObj.MsgError(""); // 清除错误信息
							} else {
								MsgObj.MsgError("导出失败!"); // 设置错误信
							}
						} else if (mCommand.equalsIgnoreCase("WORDTABLE")) {
							if (GetWordTable()) {
								MsgObj.SetMsgByName("COLUMNS", String
										.valueOf(mColumns)); // 列
								MsgObj.SetMsgByName("CELLS", String
										.valueOf(mCells)); // 行
								MsgObj.SetMsgByName("WORDCONTENT",
										mTableContent); // 表格内容
								MsgObj.SetMsgByName("STATUS", "增加和填充成功成功!"); // 设置状态信息
								MsgObj.MsgError(""); // 清除错误信息
							} else {
								MsgObj.MsgError("增加表格行失败!"); // 设置错误信息
							}
						} else if (mCommand.equalsIgnoreCase("COPIES")) { // 打印限制
							System.out.println(mOfficePrints);
							mCopies = Integer.parseInt(mOfficePrints); // 获得客户需要打印的份数
							if (mCopies <= 2) { // 比较打印份数，拟定该文档允许打印的总数为2份，注：可以在数据库中设置好文档允许打印的份数
								if (UpdataCopies(2 - mCopies)) { // 更新打印份数
									MsgObj.SetMsgByName("STATUS", "1"); // 设置状态信息，允许打印
									MsgObj.MsgError(""); // 清除错误信息
								}
							} else {
								MsgObj.SetMsgByName("STATUS", "0"); // 不允许打印
								MsgObj.MsgError("超过打印限度不允许打印!"); // 设置错误信息
							}
						} else if (mCommand.equalsIgnoreCase("SELFINFO")) {
							mInfo = "服务器端收到客户端传来的信息：“" + mInfo + "” | ";
							// 组合返回给客户端的信息
							mInfo = mInfo + "服务器端发回当前服务器时间："
									+ DbaObj.GetDateTime();
							MsgObj.SetMsgByName("RETURNINFO", mInfo); // 将返回的信息设置到信息包中
						} else {
							MsgObj.MsgError("客户端Web发送数据包命令没有合适的处理函数!["
									+ mCommand + "]");
							MsgObj.MsgTextClear();
							MsgObj.MsgFileClear();
						}
					}

					else if (mOption.equalsIgnoreCase("SAVEPAGE")) { // 下面的代码为保存为全文批注格式文件
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						MsgObj.MsgTextClear(); // 清除文本信息
						mFilePath = mFilePath + "\\Document\\" + mRecordID
								+ ".pgf"; // 全文批注文件的完整路径
						if (MsgObj.MsgFileSave(mFilePath)) { // 保存全文批注文件
							MsgObj.SetMsgByName("STATUS", "保存全文批注成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存全文批注失败!"); // 设置错误信息
						}
					}

					else if (mOption.equalsIgnoreCase("LOADPAGE")) { // 下面的代码为调入全文批注格式文件
						mRecordID = MsgObj.GetMsgByName("RECORDID"); // 取得文档编号
						MsgObj.MsgTextClear(); // 清除文本信息
						mFilePath = mFilePath + "\\Document\\" + mRecordID
								+ ".pgf"; // 全文批注文件的完整路径
						if (MsgObj.MsgFileLoad(mFilePath)) { // 调入文档内容
							MsgObj.SetMsgByName("STATUS", "打开全文批注成功!"); // 设置状态信息
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("打开全文批注失败!"); // 设置错误信息
						}
					}
				} else {
					MsgObj.MsgError("客户端发送数据包错误!");
					MsgObj.MsgTextClear();
					MsgObj.MsgFileClear();
				}
			} else {
				MsgObj.MsgError("请使用Post方法");
				MsgObj.MsgTextClear();
				MsgObj.MsgFileClear();
			}
			System.out.println("SendPackage");
			System.out.println("");
			SendPackage(response);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

}

package com.chinacreator.xtbg.core.upload.util;

import java.io.*;
import java.net.URLDecoder;
import java.text.*;
import java.util.*;

import javax.servlet.http.*;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.upload.entity.UploadModel;
import com.chinacreator.xtbg.core.upload.util.UploadConstants;
import com.chinacreator.xtbg.core.upload.service.UploadService;
import com.chinacreator.xtbg.core.upload.service.impl.UploadServiceImpl;

public class iWebFile {
	
	private static final Logger LOG = Logger.getLogger(iWebFile.class);
	String mOption;
	String mFilePath;
	String mFileName;
	String mCommand;
	String mIndex;
	String mTotal;
	String mFilePoint;
	String mA;
	String mB;
	DBstep.iMsgServer2000 MsgObj;
	DBstep.iDBManager2000 DbaObj;
	
	String uuid;
	String newFN;

	public String GetDateTime() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String mDateTime = formatter.format(cal.getTime());
		return (mDateTime);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getMFilePath(获得根路径)
	 * @return
	 */
	private String getMFilePath(){
		try{
			Map<String,Object> configMap = AttachmentConfigBean.getConfigMap();
			if("true".equals(configMap.get("canUpload"))){
				String url = AttachmentConfigBean.getBaseUrl();
				if(url!=null){
					return url;
				}
			}
		}catch(Exception e){
			
		}
		return MsgObj.GetMsgByName("rootPath")+UploadConstants.UPLOADSAVEPATH;
		
	}
	
	public void ExecuteRun(HttpServletRequest request,
			HttpServletResponse response) {
		mOption = "";
		try {
			MsgObj = new DBstep.iMsgServer2000();
			MsgObj.ReadPackage(request);
			mFilePath = this.getMFilePath();
			File mFilePathFile = new File(mFilePath);
			if (!mFilePathFile.exists()) {
				mFilePathFile.mkdirs();
			}
				
			if (!StringUtil.nullOrBlank(MsgObj.GetMsgByName("attach_id"))) {
				mFilePath+=MsgObj.GetMsgByName("tableName")+"/";
				mFilePathFile = new File(mFilePath);
				if (!mFilePathFile.exists()) {
					mFilePathFile.mkdir();
				}
				mFilePath+=DateUtil.getCurrentYear()+"/";
				mFilePathFile = new File(mFilePath);
				if (!mFilePathFile.exists()) {
					mFilePathFile.mkdir();
				}
				mFilePath+=DateUtil.getCurrentMonth()+"/";
				mFilePathFile = new File(mFilePath);
				if (!mFilePathFile.exists()) {
					mFilePathFile.mkdir();
				}
				mFilePathFile = new File(mFilePath+MsgObj.GetMsgByName("attach_id"));
				if (!mFilePathFile.exists()) {
					mFilePathFile.mkdir();
				}
			}
			
			

			

			if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {
				mOption = MsgObj.GetMsgByName("OPTION");
				// 以分段下载方式请求调用文档
				if (mOption.equalsIgnoreCase("WEBGETFILE")) {
					mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
					mCommand = MsgObj.GetMsgByName("COMMAND");

					if (mCommand.equalsIgnoreCase("BEGIN")) {
						MsgObj.SetMsgByName(
								"FILESIZEBP",
								String.valueOf(MsgObj.FileSizeByName(mFilePath
										+ "/" + mFileName)));
						MsgObj.MsgError(""); // 清除错误信息
					} else if (mCommand.equalsIgnoreCase("LOADFILE")) {
						mIndex = MsgObj.GetMsgByName("INDEX");
						if (!MsgObj.LoadStreamFromFile(mFilePath + "/"
								+ mFileName, Integer.parseInt(mIndex))) {
							MsgObj.MsgError("加载文件失败!");
						} else {
							MsgObj.MsgError(""); // 清除错误信息
						}
					} else if (mCommand.equalsIgnoreCase("END")) {
						MsgObj.MsgError(""); // 清除错误信息
						MsgObj.MsgFileClear();
					}
				}

				// 请求保存文档
				else if (mOption.equalsIgnoreCase("WEBPUTFILE")) {
					uuid = MsgObj.GetMsgByName("uuid");
					newFN = MsgObj.GetMsgByName("newFN");
					mFileName = MsgObj.GetMsgByName("FILENAME"); // 取得文档名称
					String filerealname = URLDecoder.decode(MsgObj.GetMsgByName("FILE_REALNAME"), "utf-8");
					mCommand = MsgObj.GetMsgByName("COMMAND");
					if (mCommand.equalsIgnoreCase("BEGIN")) {    
						iWebFileUploadManager manager = iWebFileUploadManager.begin(request.getSession(), filerealname, newFN,uuid);
						MsgObj.SetMsgByName("FILEPOINT", manager.getOldMFilePoint());
						MsgObj.MsgError(""); // 清除错误信息
					} else if (mCommand.equalsIgnoreCase("SAVEFILE")) {
						mIndex = MsgObj.GetMsgByName("INDEX");
						iWebFileUploadManager manager = iWebFileUploadManager.runCheck(request.getSession(), filerealname, newFN, mIndex);
						if (MsgObj.SaveFromStream(mFilePath + "/"
								+ manager.getRightFN(), Integer.parseInt(mIndex))) { // 保存临时文档
							manager.setOldMFilePoint(mIndex);
							MsgObj.MsgError(""); // 清除错误信息
						} else {
							MsgObj.MsgError("保存断点文件失败!"); // 设置错误信息
						}
					} else if (mCommand.equalsIgnoreCase("END")) {
						iWebFileUploadManager manager = iWebFileUploadManager.end(request.getSession(), filerealname);
						if(!manager.isSuccess()){
							LOG.info("info：文件["+mFilePath + "/"+ manager.getRightFN()+"]找不到,上传结束之后,再次续点上传");
							return;
						}
						//附件信息分表保存 begin =============================================================
						AccessControl accesscontroler = AccessControl.getAccessControl();
						accesscontroler.checkAccess(request, response);
						String userid = accesscontroler.getUserID();
						UploadService uploadService = new UploadServiceImpl();
						String tableName = MsgObj.GetMsgByName("tableName");//分表名
						String filename  = URLDecoder.decode(MsgObj.GetMsgByName("FILE_REALNAME"), "utf-8");
		              	String departid  = MsgObj.GetMsgByName("departid");
		              	String attach_id = MsgObj.GetMsgByName("attach_id");
		              	String uuid = manager.getRightUUID();
		                int filesize = MsgObj.FileSizeByName(mFilePath+"\\"+filerealname);
		                UploadModel uploadModel = new UploadModel();
						if(!attach_id.equals("") && attach_id != null)
						{
							uploadModel.setAttach_id(attach_id);
						}
						uploadModel.setFile_id(uuid);//确保数据库字段和存入磁盘的文件名一致
						uploadModel.setDepart_id(departid);
						uploadModel.setFile_extra(FilenameUtils.getExtension(filerealname));

						uploadModel.setFile_name(FilenameUtils.getBaseName(filename));
						uploadModel.setFile_size(String.valueOf(filesize));
						uploadModel.setFile_type(UploadConstants.FILETYPE_FILE);
						uploadModel.setServerfile_name(FilenameUtils.getBaseName(filerealname));
						uploadModel.setUpload_time(DateUtil.getCurrentDateTime());
						uploadModel.setUser_id(userid);
						
						uploadModel.setTableName(tableName);
						JSONObject json = new JSONObject();
						json = uploadService.uploadFile(uploadModel);
						if(!json.getBooleanValue("flag")){
							MsgObj.MsgError(json.getString("info")); //设置错误信息
	                      	MsgObj.SetMsgByName("RESULT", "文件上传失败!");
						}else{

	                      	MsgObj.SetMsgByName("RESULT", "ok");
	                      	MsgObj.SetMsgByName("UPLOADSAVEPATH", UploadConstants.UPLOADSAVEPATH);
	                      	MsgObj.SetMsgByName("yearfolder", DateUtil.getCurrentYear());
	                      	MsgObj.SetMsgByName("monthfolder", DateUtil.getCurrentMonth());
	                      	MsgObj.SetMsgByName("fileid", json.getString("fileid"));
						}
						//附件信息分表保存 end     =============================================================
					}
					MsgObj.MsgFileClear(); // 清除文档内容
				}

				else if (mOption.equalsIgnoreCase("MSGSEND")) { // 请求调用正文文档
					mCommand = MsgObj.GetMsgByName("FUNCTION");
					if (mCommand.equalsIgnoreCase("GETSERVERTIME")) {
						MsgObj.SetMsgByName("SERVERTIME", GetDateTime());
						MsgObj.MsgError(""); // 清除错误信息
					} else if (mCommand.equalsIgnoreCase("RUNCOUNT")) {
						mA = MsgObj.GetMsgByName("NOA");
						mB = MsgObj.GetMsgByName("NOB");
						try {
							String mMultiplication = String.valueOf(Integer
									.parseInt(mA) * Integer.parseInt(mB));
							MsgObj.SetMsgByName("RESULT", mMultiplication);
						} catch (Exception e) {
							MsgObj.SetMsgByName("RESULT", "只能计算整数相乘");
						}
					} else if (mCommand.equalsIgnoreCase("DELFILE")) {
						mFileName = MsgObj.GetMsgByName("DELFILENAME");
						MsgObj.DelFile(mFilePath + "/" + mFileName);
					}
				} else {
					MsgObj.MsgError("客户端发送数据包错误!");
					MsgObj.MsgTextClear();
					MsgObj.MsgFileClear();
				}
			} else {
				MsgObj.MsgError("客户端发送数据包错误!");
				MsgObj.MsgTextClear();
				MsgObj.MsgFileClear();
			}
			MsgObj.SendPackage(response);
		} catch (Exception e) {
			System.out.println("Last Error:" + e.toString());

		}
	}
}

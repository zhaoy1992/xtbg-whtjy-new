package com.chinacreator.xtbg.yimingju.fileUpload.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoInfoBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoManageConstant;
import com.chinacreator.xtbg.yimingju.fileUpload.service.VideoManageServiceIfc;
import com.chinacreator.xtbg.yimingju.fileUpload.service.impl.VideoManageServiceImpl;
  public class iWebFile {
	 


    public String GetDateTime() {
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String mDateTime = formatter.format(cal.getTime());
      return (mDateTime);
    }

    public void ExecuteRun(HttpServletRequest request, HttpServletResponse response) {
    		String mOption;
    	    String mFilePath;
    	    String mFileName;
    	    String mCommand;
    	    String mIndex;
    	    String mFilePoint;
    	    String mA;
    	    String mB;
    	    DBstep.iMsgServer2000 MsgObj;
    	
      AccessControl accesscontroler = AccessControl.getAccessControl();
      accesscontroler.checkAccess(request, response);
    	    
      String userid = accesscontroler.getUserID();
  	  String username = accesscontroler.getUserName();

  	  
  	  
      
      
      mOption = "";
      mFilePath = request.getSession().getServletContext().getRealPath("");
      //mFilePath="";
      MsgObj = new DBstep.iMsgServer2000();

      //System.out.println("[INFORM]: START(iWebFile)");
      //System.out.println("[INFORM]: Time=" + GetDateTime());
      
      try {
        MsgObj.ReadPackage(request);

       
        mFilePath += VideoManageConstant.VIDEOFILE_ROOTPATH;
       
        
        if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {
          mOption = MsgObj.GetMsgByName("OPTION");
          //System.out.println("[INFORM]: OPTION=" + mOption);
          
          //以分段下载方式请求调用文档
          if (mOption.equalsIgnoreCase("WEBGETFILE")) {
            mFileName=MsgObj.GetMsgByName("FILENAME");		//取得文档名称
            mCommand=MsgObj.GetMsgByName("COMMAND");
            //System.out.println("[INFORM]: COMMAND=" + mCommand);
            if (mCommand.equalsIgnoreCase("BEGIN")){
              MsgObj.SetMsgByName("FILESIZEBP", String.valueOf(MsgObj.FileSizeByName(mFilePath + "/" + mFileName)));
              MsgObj.MsgError("");							//清除错误信息
            }
            else if (mCommand.equalsIgnoreCase("LOADFILE")){
              mIndex=MsgObj.GetMsgByName("INDEX");
              if (!MsgObj.LoadStreamFromFile(mFilePath + "/" + mFileName, Integer.parseInt(mIndex))){
                MsgObj.MsgError("加载文件失败!");
              }else{
                MsgObj.MsgError("");							//清除错误信息
              }
            }
            else if (mCommand.equalsIgnoreCase("END")){
              MsgObj.MsgError("");							//清除错误信息
              MsgObj.MsgFileClear();
            }
          }
          
          //请求保存文档
          else if (mOption.equalsIgnoreCase("WEBPUTFILE")) {
        	 
        	  
            mFileName = MsgObj.GetMsgByName("FILENAME"); //取得文档名称
            String filerealname = MsgObj.GetMsgByName("FILE_REALNAME");
            mCommand = MsgObj.GetMsgByName("COMMAND");
            if (mCommand.equalsIgnoreCase("BEGIN")) {
            	 
              if (request.getSession().getAttribute(request.getSession().getId() + filerealname) == null) {
                mFilePoint = "-1";
                request.getSession().setAttribute(request.getSession().getId() + filerealname, "-1");
              }
              else {
                mFilePoint = request.getSession().getAttribute(request.getSession().getId() + filerealname).toString();
              }
              //System.out.println("[INFORM]: BEGIN:" + request.getSession().getId() + mFileName);
              MsgObj.SetMsgByName("FILEPOINT", mFilePoint);
              MsgObj.MsgError(""); //清除错误信息
            }
            else if (mCommand.equalsIgnoreCase("SAVEFILE")) {
              mIndex = MsgObj.GetMsgByName("INDEX");
              

              //System.out.println("[INFORM]: INDEX:" + mIndex);
              if (MsgObj.SaveFromStream(mFilePath + "/" + filerealname, Integer.parseInt(mIndex))) { //保存临时文档
                request.getSession().setAttribute(request.getSession().getId() + filerealname, mIndex);
                MsgObj.MsgError(""); //清除错误信息
              }
              else {
                MsgObj.MsgError("保存断点文件失败!"); //设置错误信息
              }
            }
            else if (mCommand.equalsIgnoreCase("END")) {
            	 /**************************文件信息保存到数据库*****************************/
                
                String filename = MsgObj.GetMsgByName("FILENAME");
            	String departid = MsgObj.GetMsgByName("departid");
                int filesize = MsgObj.FileSizeByName(mFilePath+"\\"+filerealname);
                    VideoManageServiceIfc videoManageServiceIfc = new VideoManageServiceImpl();
                    VideoInfoBean videoInfoBean = new VideoInfoBean();
                    videoInfoBean.setDepart_id(departid);
                    videoInfoBean.setFile_extra(FilenameUtils.getExtension(filerealname));
                    videoInfoBean.setFile_name(FilenameUtils.getBaseName(filename));
                    videoInfoBean.setFile_size(String.valueOf(filesize));
                    videoInfoBean.setFile_type(VideoManageConstant.FILETYPE_FILE);
                    videoInfoBean.setServerfile_name(FilenameUtils.getBaseName(filerealname));
                    videoInfoBean.setUpload_time(DateUtil.getCurrentDateTime());
                    videoInfoBean.setUser_id(userid);
                    try{
                    	videoManageServiceIfc.uploadFile(videoInfoBean);
                    }catch(Exception e){
                    	MsgObj.MsgError("文件上传失败!"); //设置错误信息
                    	MsgObj.SetMsgByName("RESULT", "文件上传失败!");
                    }
                /*************************文件信息保存到数据库*****************************/ 
              //System.out.println("[INFORM]: END:" + request.getSession().getId() + mFileName);
              request.getSession().setAttribute(request.getSession().getId() + mFileName, "-1");
              MsgObj.MsgError(""); //清除错误信息
            }
            MsgObj.MsgFileClear(); //清除文档内容
          }
          
          else if (mOption.equalsIgnoreCase("MSGSEND")) { //请求调用正文文档
            mCommand = MsgObj.GetMsgByName("FUNCTION");
            //System.out.println("[INFORM]: FUNCTION=" + mCommand);

            if (mCommand.equalsIgnoreCase("GETSERVERTIME")) {
              MsgObj.SetMsgByName("SERVERTIME", GetDateTime());
              MsgObj.MsgError(""); //清除错误信息
            }
            else if (mCommand.equalsIgnoreCase("RUNCOUNT")) {
              mA = MsgObj.GetMsgByName("NOA");
              mB = MsgObj.GetMsgByName("NOB");
              //System.out.println("[INFORM]: A=" + mA + " | B=" + mB);
              try {
                String mMultiplication = String.valueOf(Integer.parseInt(mA) * Integer.parseInt(mB));
                MsgObj.SetMsgByName("RESULT", mMultiplication);
              }
              catch (Exception e) {
                MsgObj.SetMsgByName("RESULT", "只能计算整数相乘");
              }
            }
            else if (mCommand.equalsIgnoreCase("DELFILE")) {
              mFileName = MsgObj.GetMsgByName("DELFILENAME");
              MsgObj.DelFile(mFilePath+"/"+mFileName);
            }
          }
          else {
            MsgObj.MsgError("客户端发送数据包错误!");
            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
          }
        }
        else {
          MsgObj.MsgError("客户端发送数据包错误!");
          //System.out.println("[ERROR]: 客户端发送数据包错误!");
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        }
        MsgObj.SendPackage(response);
        //System.out.println("[INFORM]: END(iWebFile)");
        //System.out.println("");
      }
      catch (Exception e) {
        System.out.println("Last Error:" + e.toString());
        
      }
    }
  }
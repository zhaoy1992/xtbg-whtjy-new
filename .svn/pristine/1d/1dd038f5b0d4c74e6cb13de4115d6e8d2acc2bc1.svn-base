<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="java.io.FileInputStream,java.io.FileOutputStream" %>
<%@ page import="com.chinacreator.epp.reportmanage.service.ReportManage"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<%!
//写文件
public void writeFile(byte[] context,String fileName)
{
	java.io.File fileSave = new java.io.File(fileName);
	//保存到服务器指定的目录
	try
	{
		if(fileSave.exists())
			fileSave.delete();
		fileSave.createNewFile();
		FileOutputStream fos = new FileOutputStream(fileSave);
		fos.write(context);
		fos.flush();
		fos.close();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
	}
}
%>

<%
	//参数报表上传文件,要同时上传两个文件，第一个文件是主文件
	AccessControl control = AccessControl.getInstance();

	//日志管理接口
	LogManager logMgr = SecurityDatabase.getLogManager();
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserName()+":"+control.getUserAccount()+"["+control.getUserID()+"]";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//用户信息
	String operUser = userInfo;
	//日志类型
	String operModule = "report";
	//操作的ip地址
	String operSource = remoteAddr;
	ReportManage rm = ReportBeanFactory.getReportManager();
	String uploadMessage = "上传失败";
	boolean isEdit=((request.getParameter("isEdit")!=null)&&(request.getParameter("isEdit").equals("true")));
	String repId = null;
	String repId2 = null;
	String oldId = null;
	boolean isCreateNew = false;

	if(isEdit)
	{
		oldId = request.getParameter("repId");
		isCreateNew = ((request.getParameter("isCreateNew")!=null)&&(request.getParameter("isCreateNew").equals("true")))?true:false;
		repId2 = rm.getReport(oldId).getRep_id2();
	}
	if(control.checkAccess(request, response))
	{
		String ec_id = request.getParameter("ec_id");
		String repName = request.getParameter("repName");
		String ver = request.getParameter("repVer");
		String desc = request.getParameter("repDesc");
		String repSType = request.getParameter("repSType");
		String filesource = request.getParameter("filesource");
		//报表文件要保存到的位置
		String filePath = request.getRealPath("")+"\\report\\reportFiles\\";

		//上传文件名
		String filename="";
		String filename2="";
		//文件内容
		byte[] bytes=new byte[0];
		byte[] bytes2=new byte[0];
		//上传文件类型
		final String UpFileType="raq,rpg";

		if(filesource.equals("localfile"))
		{
			//上传文件大小限制
			final int MaxFileSize=5*1024*1024;
			//错误标识
			boolean err = false;
			SmartUpload su = new SmartUpload();
			//上传初始化
			su.initialize(pageContext);
			su.upload();

			//取文件
			File file = su.getFiles().getFile(0);
			File file2 = su.getFiles().getFile(1);
			 //文件效验
			 //判断用户是否选择了文件
			  // 取得文件并保存
			if(!file.isMissing()&&!file2.isMissing())
			{
				//得到文件扩展名
				String FileType=file.getFileExt();
				String fileType2=file2.getFileExt().toLowerCase();
				//将扩展名转换成小写
				FileType=FileType.toLowerCase();
				if (UpFileType.indexOf(FileType)==-1||UpFileType.indexOf(fileType2)==-1)
				{
					//文件格式不对
					uploadMessage = "文件格式不对";
					err = true;
				}
				//得到文件大小
				int FileSize=file.getSize();
				int file2Size=file2.getSize();
				if (!err&&(FileSize>MaxFileSize||file2Size>MaxFileSize))
				{
					//文件太大
					uploadMessage = "文件太大";
					err = true;
				}
				if(!err)
				{
					//如果正确，开始读文件
					//取文件名
					filename=file.getFileName();
					//将文件读入数组中
					bytes = new byte[file.getSize()];
					for(int i=0;i<file.getSize();i++)
					{
						bytes[i]=file.getBinaryData(i);
					}

					//第二个文件
					filename2=file2.getFileName();
					//将文件读入数组中
					bytes2 = new byte[file2.getSize()];
					for(int i=0;i<file2.getSize()-1;i++)
					{
						bytes2[i]=file2.getBinaryData(i);
					}
				}

			}else{
				//文件错误
				uploadMessage = "未选择文件";
				err = true;
			}



			try{
				//新增，如果文件正确则上传
				if (!err&&!file.isMissing()&&!file2.isMissing()&&!isEdit)
				{
					//主报表
					repId = rm.addReportFile(bytes);
					rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);

					//保存报表文件，名为报表ID
					filename=repId+".raq";
					file.saveAs(filePath+filename);


  					//保存副报表
					repId2 = rm.addReportFile(bytes2);
					//修改报表信息，添加rep_id2的信息
					rm.updateReportId2(repId2,repId); 
					//保存报表文件2，名为报表ID
					filename2=repId2+".raq";
					file2.saveAs(filePath+filename2);


					uploadMessage = "上传成功";

					//写入日志
					logMgr.log(operUser, userInfo+"新增参数报表"+filename, operModule, operSource);
				}
				//修改的时候上传了文件
				else if (!err&&!file.isMissing()&&!file2.isMissing()&&isEdit)
				{
					if(isCreateNew)
					{
						repId = rm.addReportFile(bytes);
						rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
						repId2 = rm.addReportFile(bytes2);
						rm.updateReportId2(repId2,repId);
						//写入日志
						logMgr.log(operUser, userInfo+"新增参数报表"+filename, operModule, operSource);
					}
					else
					{
						//repId = rm.addReportFile(bytes);
						//修改报表文件
						repId=rm.updateReportFile(oldId,bytes);

						rm.updateReport(oldId,oldId,ec_id,repName,ver,desc,oldId,repSType);
						rm.updateReportId1(repId,oldId); 

						//repId2 = rm.addReportFile(bytes2);
						rm.updateReportFile(repId2,bytes2);

						rm.updateReportId2(repId2,repId);
						//写入日志
						logMgr.log(operUser, userInfo+"修改参数报表"+oldId+"为："+repId, operModule, operSource);
					}

					//保存报表文件，名为报表ID
					filename=repId+".raq";
					file.saveAs(filePath+filename);
					//保存报表文件2，名为报表ID
					filename2=repId2+".raq";
					file2.saveAs(filePath+filename2);

					uploadMessage = "修改成功";
				}
				//修改的时候没上传文件
				else if (isEdit&&file.isMissing())
				{
					Tb_report reportOld=rm.getReport(oldId);
					if(isCreateNew)
					{
						bytes = rm.getReportFileBytes(oldId);
						repId = rm.addReportFile(bytes);

						bytes2 = rm.getReportFileBytes(reportOld.getRep_id2());
						repId2 = rm.addReportFile(bytes2);

						rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
						rm.updateReportId2(repId2,repId);
					}
					else
					{
						rm.updateReport(reportOld.getRep_id(),reportOld.getRep_id2(),ec_id,repName,ver,desc,oldId,repSType);
					}
					uploadMessage = "修改成功";
				}
			}catch (Exception e){
				//上传有误
				e.printStackTrace();
				uploadMessage = "上传失败";
			}
		}
		else
		{
			//如果选择了服务器的文件
			String servfileName = request.getParameter("server_file");
			String servfileName2 = request.getParameter("server_file2");
			try
			{
				if(servfileName!=null&&servfileName.length()>3&&servfileName2!=null&&servfileName2.length()>3)
				{
					//临时上传到服务器的报表路径
					//String tmpfilePath = request.getRealPath("")+"\\WEB-INF\\repository\\report\\tmp\\";
					//String tmpfilePath = request.getRealPath("")+"\\app_"+control.getCurrentSystemID()+"\\report\\";
					String appId = control.getCurrentSystemID();
					String tmpfilePath = ConfigManager.getInstance().getConfigValue("appFilePath")
					+ "ccapp/app_"+appId+"/report/";
					java.io.File file = new java.io.File(tmpfilePath+servfileName.replaceFirst("/",""));
					java.io.File file2 = new java.io.File(tmpfilePath+servfileName2.replaceFirst("/",""));
					bytes = new byte[0];
					bytes2 = new byte[0];
					//如果要上传文件
					if(file.exists()&&file2.exists())
					{
						try
						{
							FileInputStream fis = new FileInputStream(file);
							bytes = new byte[fis.available()];
							fis.read(bytes);
							fis.close();

							FileInputStream fis2 = new FileInputStream(file2);
							bytes2 = new byte[fis2.available()];
							fis2.read(bytes2);
							fis2.close();
						}
						catch(Exception ee)
						{
							uploadMessage = "文件错误";
							ee.printStackTrace();
						}
						//新增
						if(!isEdit)
						{
							//保存到数据库
							//repId = rm.addReportAndReportFile(ec_id,repName,ver,desc,control.getUserName(),bytes);
							repId = rm.addReportFile(bytes);
							rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
							repId2 = rm.addReportFile(bytes2);
							rm.updateReportId2(repId2,repId);
							uploadMessage = "保存成功";

							//写入日志
							logMgr.log(operUser, userInfo+"新增参数报表"+repId, operModule, operSource);
						}
						//修改
						else
						{
							//修改时创建新版本
							Tb_report reportOld = rm.getReport(oldId);
							if(isCreateNew)
							{
								repId = rm.addReportFile(bytes);
								rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
								repId2 = rm.addReportFile(bytes2);
								rm.updateReportId2(repId2,repId);

								//写入日志
								logMgr.log(operUser, userInfo+"新增参数报表"+repId, operModule, operSource);
							}
							//修改老版本
							else
							{
								//repId = rm.addReportFile(bytes);
								//修改报表文件
								repId=rm.updateReportFile(oldId,bytes);
								//更新repId
								rm.updateReport(repId,reportOld.getRep_id2(),ec_id,repName,ver,desc,oldId,repSType);
								//repId2 = rm.addReportFile(bytes2);
								rm.updateReportFile(repId2,bytes2);
								//修改repId2
								rm.updateReportId2(repId2,repId);
								//写入日志
								logMgr.log(operUser, userInfo+"修改参数报表"+oldId+"为"+repId, operModule, operSource);
							}
							uploadMessage = "修改成功";
						}

						writeFile(bytes,filePath+repId+".raq");
						//删除临时文件
						file.delete();

						writeFile(bytes2,filePath+repId2+".raq");
						//删除临时文件
						file2.delete();

					}
					//指定的文件不存在
					else
					{
						uploadMessage = "文件不存在！";
					}
				}
				//如果修改的时候没输入文件名
				else
				{
					if(isEdit)
					{
						Tb_report repOld = rm.getReport(oldId);
						bytes = rm.getReportFileBytes(repOld.getRep_id());
						bytes2 = rm.getReportFileBytes(repOld.getRep_id2());
						if(isCreateNew)
						{
							repId = rm.addReportFile(bytes);
							rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
							repId2 = rm.addReportFile(bytes2);
							rm.updateReportId2(repId2,repId);

							//创建新版本的时候，要生成一个对应ID的报表文件
							writeFile(bytes,filePath+repId+".raq");

							writeFile(bytes2,filePath+repId2+".raq");
						}
						else
						{
							//repId = rm.addReportFile(bytes);
							//修改报表文件
							repId=rm.updateReportFile(oldId,bytes);
							//更新repId
							rm.updateReport(repId,repOld.getRep_id2(),ec_id,repName,ver,desc,oldId,repSType);
							//repId2 = rm.addReportFile(bytes2);
							rm.updateReportFile(repId2,bytes2);
							//修改repId2
							rm.updateReportId2(repId2,repId);
						}
						uploadMessage = "修改成功,但没有上传新文件";
					}
					else
					{
						uploadMessage = "没有指定文件！";
					}
				}
			}
			catch(Exception eex)
			{
				uploadMessage = "操作失败！";
				eex.printStackTrace();
			}
		}
	}
%>
<script language="javascript">
		alert("<%=uploadMessage%>");
		window.close();
		window.returnValue="refresh";
</script>
<script>
    window.onload = function prompt()
    {
        //parent.divProcessing.style.display="none";
        //parent.location.reload();
    }
</script>

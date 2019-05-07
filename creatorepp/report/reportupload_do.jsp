<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="java.io.FileInputStream,java.io.FileOutputStream" %>
<%@ page import="com.chinacreator.epp.reportmanage.service.ReportManage"%>
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
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
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

	//普通报表上传文件
	String uploadMessage = "上传失败";
	boolean isEdit=((request.getParameter("isEdit")!=null)&&(request.getParameter("isEdit").equals("true")));
	String repId = null;
	String oldId = null;
	//是否创建新版本
	boolean isCreateNew = false;

	if(isEdit)
	{
		oldId = request.getParameter("repId");
		isCreateNew = ((request.getParameter("isCreateNew")!=null)&&(request.getParameter("isCreateNew").equals("true")))?true:false;
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
		ReportManage rm = ReportBeanFactory.getReportManager();
		if(filesource.equals("localfile"))
		{
			//上传文件类型
			final String UpFileType="raq,rpg";
			//上传文件大小限制
			final int MaxFileSize=5*1024*1024;
			//错误标识
			boolean err = false;
			//新建一个SmartUpload对象
			SmartUpload su = new SmartUpload();
			//上传初始化
			su.initialize(pageContext);
			su.upload();

			//取文件
			File file = su.getFiles().getFile(0);

			 //文件效验
			 //判断用户是否选择了文件
			  // 取得文件并保存
			if(!file.isMissing())
			{
				//得到文件扩展名
				String FileType=file.getFileExt();
				//将扩展名转换成小写
				FileType=FileType.toLowerCase();
				if (UpFileType.indexOf(FileType)==-1)
				{
					//文件格式不对
					uploadMessage = "文件格式不对";
					err = true;
				}
				//得到文件大小
				int FileSize=file.getSize();
				if (!err&&FileSize>MaxFileSize)
				{
					//文件太大
					uploadMessage = "文件太大";
					err = true;
				}

			}else{
				//文件错误
				uploadMessage = "未选择文件";
				err = true;
			}

			//上传文件
			String filename="";

			try{
				//新增
				//如果文件正确则上传
				if (!err&&!file.isMissing()&&!isEdit)
				{
					//取文件名
					filename=file.getFileName();
					Date date=new Date();
					long time=date.getTime();
					String title=String.valueOf(time);
					String extn=filename.substring(filename.lastIndexOf('.'),filename.length());
					//将文件读入数组中
					byte[] bytes = new byte[file.getSize()];
					for(int i=0;i<file.getSize();i++)
					{
						bytes[i]=file.getBinaryData(i);
					}
					repId = rm.addReportFile(bytes);
					rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
					//保存报表文件，名为报表ID
					filename=repId+extn;
					file.saveAs(filePath+filename);
					uploadMessage = "上传成功";

					//写入日志
					logMgr.log(operUser, userInfo+"新增报表文件"+filename, operModule, operSource);
				}
				//修改
				//修改的时候上传了文件
				else if (!err&&!file.isMissing()&&isEdit)
				{
					//取文件名
					filename=file.getFileName();
					Date date=new Date();
					long time=date.getTime();
					String title=String.valueOf(time);
					String extn=filename.substring(filename.lastIndexOf('.'),filename.length());
					//将文件读入数组中
					byte[] bytes = new byte[file.getSize()];
					for(int i=0;i<file.getSize();i++)
					{
						bytes[i]=file.getBinaryData(i);
					}
					if(isCreateNew)
					{
						repId = rm.addReportFile(bytes);
						rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
						//repId = rm.addReportAndReportFile(ec_id,repName,ver,desc,control.getUserName(),bytes);
						//写入日志
						logMgr.log(operUser, userInfo+"新增报表文件"+filename, operModule, operSource);
					}
					else
					{
						//repId = rm.addReportFile(bytes);
						//修改报表文件
						repId=rm.updateReportFile(oldId,bytes);
						//rm.updateReportId1(repId,oldId);
						rm.updateReport(repId,repId,ec_id,repName,ver,desc,oldId,repSType); 
						//rm.updateReportAndReportFile(ec_id,repName,ver,desc,bytes,repId);
						//写入日志
						logMgr.log(operUser, userInfo+"修改报表文件"+oldId+extn+"为"+repId+extn, operModule, operSource);
					}
					//保存报表文件，名为报表ID
					filename=repId+extn;
					file.saveAs(filePath+filename);
					uploadMessage = "修改成功";
				}
				//修改的时候没上传文件
				else if (isEdit&&file.isMissing())
				{
					if(isCreateNew)
					{
						byte[] bytes = rm.getReportFileBytes(oldId);
						repId = rm.addReportFile(bytes);
						rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
						//rm.createReportVer(ec_id,repName,ver,desc,control.getUserName(),repId);
					}
					else
					{
						rm.updateReport(oldId,oldId,ec_id,repName,ver,desc,oldId,repSType);
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
			try
			{
				if(servfileName!=null&&servfileName.length()>0)
				{
					//临时上传到服务器的报表路径
					//String tmpfilePath = request.getRealPath("")+"\\WEB-INF\\repository\\report\\tmp\\";
					//String tmpfilePath = request.getRealPath("")+"\\app_"+control.getCurrentSystemID()+"\\report\\";
					String appId = control.getCurrentSystemID();
					String tmpfilePath = ConfigManager.getInstance().getConfigValue("appFilePath")
					+ "ccapp/app_"+appId+"/report/";
					java.io.File file = new java.io.File(tmpfilePath+servfileName.replaceFirst("/",""));
					byte[] bytes = new byte[0];
					//如果要上传文件
					if(file.exists())
					{
						try
						{
							FileInputStream fis = new FileInputStream(file);
							bytes = new byte[fis.available()];
							fis.read(bytes);
							fis.close();
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
							writeFile(bytes,filePath+repId+".raq");
							//删除临时文件
							file.delete();
							uploadMessage = "上传成功";
							//写入日志
							logMgr.log(operUser, userInfo+"新增普通报表文件"+repId+".raq", operModule, operSource);
						}
						//修改
						else
						{
							//修改时创建新版本
							if(isCreateNew)
							{
								//repId = rm.addReportAndReportFile(ec_id,repName,ver,desc,control.getUserName(),bytes);
								repId = rm.addReportFile(bytes);
								rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
								//写入日志
								logMgr.log(operUser, userInfo+"新增普通报表文件"+repId+".raq", operModule, operSource);
							}
							//修改老版本
							else
							{
								//repId = rm.addReportFile(bytes);
								//修改报表文件
								repId=rm.updateReportFile(oldId,bytes);
								rm.updateReport(repId,repId,ec_id,repName,ver,desc,oldId,repSType);
								//rm.updateReportAndReportFile(ec_id,repName,ver,desc,bytes,repId);
								//写入日志
								logMgr.log(operUser, userInfo+"修改报表文件"+oldId+".raq为"+repId+".raq", operModule, operSource);
							}
							writeFile(bytes,filePath+repId+".raq");
							//删除临时文件
							file.delete();
							uploadMessage = "修改成功";
						}
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
						if(isCreateNew)
						{
							byte[] bytes = rm.getReportFileBytes(oldId);
							repId = rm.addReportFile(bytes);
							rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);

							writeFile(bytes,filePath+repId+".raq");
						}
						else
						{
							rm.updateReport(oldId,ec_id,repName,ver,desc,oldId,repSType);
						}
						uploadMessage = "修改成功";
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
    	//alert(window.document.getElementById("divProcessing"));
    	//var parent=window.dialogArguments;
        //parent.divProcessing.style.display="none";
        //parent.location.reload();
    }
</script>

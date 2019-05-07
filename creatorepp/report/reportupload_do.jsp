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
//д�ļ�
public void writeFile(byte[] context,String fileName)
{
	java.io.File fileSave = new java.io.File(fileName);
	//���浽������ָ����Ŀ¼
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
	//��־����ӿ�
	LogManager logMgr = SecurityDatabase.getLogManager();
	//�û���Ϣ���û���ʵ���ƣ��û��ʺ�[�û�ID]��
	String userInfo = control.getUserName()+":"+control.getUserAccount()+"["+control.getUserID()+"]";
	//������ip��ַ
	String remoteAddr = request.getRemoteAddr();
	//�û���Ϣ
	String operUser = userInfo;
	//��־����
	String operModule = "report";
	//������ip��ַ
	String operSource = remoteAddr;

	//��ͨ�����ϴ��ļ�
	String uploadMessage = "�ϴ�ʧ��";
	boolean isEdit=((request.getParameter("isEdit")!=null)&&(request.getParameter("isEdit").equals("true")));
	String repId = null;
	String oldId = null;
	//�Ƿ񴴽��°汾
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
		//�����ļ�Ҫ���浽��λ��
		String filePath = request.getRealPath("")+"\\report\\reportFiles\\";
		ReportManage rm = ReportBeanFactory.getReportManager();
		if(filesource.equals("localfile"))
		{
			//�ϴ��ļ�����
			final String UpFileType="raq,rpg";
			//�ϴ��ļ���С����
			final int MaxFileSize=5*1024*1024;
			//�����ʶ
			boolean err = false;
			//�½�һ��SmartUpload����
			SmartUpload su = new SmartUpload();
			//�ϴ���ʼ��
			su.initialize(pageContext);
			su.upload();

			//ȡ�ļ�
			File file = su.getFiles().getFile(0);

			 //�ļ�Ч��
			 //�ж��û��Ƿ�ѡ�����ļ�
			  // ȡ���ļ�������
			if(!file.isMissing())
			{
				//�õ��ļ���չ��
				String FileType=file.getFileExt();
				//����չ��ת����Сд
				FileType=FileType.toLowerCase();
				if (UpFileType.indexOf(FileType)==-1)
				{
					//�ļ���ʽ����
					uploadMessage = "�ļ���ʽ����";
					err = true;
				}
				//�õ��ļ���С
				int FileSize=file.getSize();
				if (!err&&FileSize>MaxFileSize)
				{
					//�ļ�̫��
					uploadMessage = "�ļ�̫��";
					err = true;
				}

			}else{
				//�ļ�����
				uploadMessage = "δѡ���ļ�";
				err = true;
			}

			//�ϴ��ļ�
			String filename="";

			try{
				//����
				//����ļ���ȷ���ϴ�
				if (!err&&!file.isMissing()&&!isEdit)
				{
					//ȡ�ļ���
					filename=file.getFileName();
					Date date=new Date();
					long time=date.getTime();
					String title=String.valueOf(time);
					String extn=filename.substring(filename.lastIndexOf('.'),filename.length());
					//���ļ�����������
					byte[] bytes = new byte[file.getSize()];
					for(int i=0;i<file.getSize();i++)
					{
						bytes[i]=file.getBinaryData(i);
					}
					repId = rm.addReportFile(bytes);
					rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
					//���汨���ļ�����Ϊ����ID
					filename=repId+extn;
					file.saveAs(filePath+filename);
					uploadMessage = "�ϴ��ɹ�";

					//д����־
					logMgr.log(operUser, userInfo+"���������ļ�"+filename, operModule, operSource);
				}
				//�޸�
				//�޸ĵ�ʱ���ϴ����ļ�
				else if (!err&&!file.isMissing()&&isEdit)
				{
					//ȡ�ļ���
					filename=file.getFileName();
					Date date=new Date();
					long time=date.getTime();
					String title=String.valueOf(time);
					String extn=filename.substring(filename.lastIndexOf('.'),filename.length());
					//���ļ�����������
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
						//д����־
						logMgr.log(operUser, userInfo+"���������ļ�"+filename, operModule, operSource);
					}
					else
					{
						//repId = rm.addReportFile(bytes);
						//�޸ı����ļ�
						repId=rm.updateReportFile(oldId,bytes);
						//rm.updateReportId1(repId,oldId);
						rm.updateReport(repId,repId,ec_id,repName,ver,desc,oldId,repSType); 
						//rm.updateReportAndReportFile(ec_id,repName,ver,desc,bytes,repId);
						//д����־
						logMgr.log(operUser, userInfo+"�޸ı����ļ�"+oldId+extn+"Ϊ"+repId+extn, operModule, operSource);
					}
					//���汨���ļ�����Ϊ����ID
					filename=repId+extn;
					file.saveAs(filePath+filename);
					uploadMessage = "�޸ĳɹ�";
				}
				//�޸ĵ�ʱ��û�ϴ��ļ�
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
					uploadMessage = "�޸ĳɹ�";
				}
			}catch (Exception e){
				//�ϴ�����
				e.printStackTrace();
				uploadMessage = "�ϴ�ʧ��";
			}
		}
		else
		{
			//���ѡ���˷��������ļ�
			String servfileName = request.getParameter("server_file");
			try
			{
				if(servfileName!=null&&servfileName.length()>0)
				{
					//��ʱ�ϴ����������ı���·��
					//String tmpfilePath = request.getRealPath("")+"\\WEB-INF\\repository\\report\\tmp\\";
					//String tmpfilePath = request.getRealPath("")+"\\app_"+control.getCurrentSystemID()+"\\report\\";
					String appId = control.getCurrentSystemID();
					String tmpfilePath = ConfigManager.getInstance().getConfigValue("appFilePath")
					+ "ccapp/app_"+appId+"/report/";
					java.io.File file = new java.io.File(tmpfilePath+servfileName.replaceFirst("/",""));
					byte[] bytes = new byte[0];
					//���Ҫ�ϴ��ļ�
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
							uploadMessage = "�ļ�����";
							ee.printStackTrace();
						}
						//����
						if(!isEdit)
						{
							//���浽���ݿ�
							//repId = rm.addReportAndReportFile(ec_id,repName,ver,desc,control.getUserName(),bytes);
							repId = rm.addReportFile(bytes);
							rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
							writeFile(bytes,filePath+repId+".raq");
							//ɾ����ʱ�ļ�
							file.delete();
							uploadMessage = "�ϴ��ɹ�";
							//д����־
							logMgr.log(operUser, userInfo+"������ͨ�����ļ�"+repId+".raq", operModule, operSource);
						}
						//�޸�
						else
						{
							//�޸�ʱ�����°汾
							if(isCreateNew)
							{
								//repId = rm.addReportAndReportFile(ec_id,repName,ver,desc,control.getUserName(),bytes);
								repId = rm.addReportFile(bytes);
								rm.addReportInfo(repId,ec_id,repName,ver,desc,control.getUserAccount(),repSType);
								//д����־
								logMgr.log(operUser, userInfo+"������ͨ�����ļ�"+repId+".raq", operModule, operSource);
							}
							//�޸��ϰ汾
							else
							{
								//repId = rm.addReportFile(bytes);
								//�޸ı����ļ�
								repId=rm.updateReportFile(oldId,bytes);
								rm.updateReport(repId,repId,ec_id,repName,ver,desc,oldId,repSType);
								//rm.updateReportAndReportFile(ec_id,repName,ver,desc,bytes,repId);
								//д����־
								logMgr.log(operUser, userInfo+"�޸ı����ļ�"+oldId+".raqΪ"+repId+".raq", operModule, operSource);
							}
							writeFile(bytes,filePath+repId+".raq");
							//ɾ����ʱ�ļ�
							file.delete();
							uploadMessage = "�޸ĳɹ�";
						}
					}
					//ָ�����ļ�������
					else
					{
						uploadMessage = "�ļ������ڣ�";
					}
				}
				//����޸ĵ�ʱ��û�����ļ���
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
						uploadMessage = "�޸ĳɹ�";
					}
					else
					{
						uploadMessage = "û��ָ���ļ���";
					}
				}
			}
			catch(Exception eex)
			{
				uploadMessage = "����ʧ�ܣ�";
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

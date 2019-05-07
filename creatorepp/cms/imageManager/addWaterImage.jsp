<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.chinacreator.cms.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.imagemanager.*"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp"/>

<%
	AccessControl control = AccessControl.getInstance();	
	control.checkAccess(request, response);
    ImageManagerImpl impl = new ImageManagerImpl();
    //���_templateĿ¼����·��
    String basePath = "";
    String rootPath = "";
    String rootPath_1 = "";
    CMSManager cmsmanager = new CMSManager();
    cmsmanager.init(request,session,response,control);
    String siteId =  cmsmanager.getSiteID();
    String sitepath = "";
    if(siteId!=null && siteId.trim().length()!=0){
        sitepath = (new SiteManagerImpl()).getSiteAbsolutePath(siteId);
        if(sitepath!=null && sitepath.trim().length()!=0){
            rootPath = new java.io.File(sitepath,"_template").getAbsolutePath();
            rootPath_1 = new java.io.File(sitepath,"_webprj").getAbsolutePath();
        }
    }
    /* replaceAll()������ʽ,��ת�������� */
    rootPath = rootPath.replaceAll("\\\\","/");
    rootPath_1 = rootPath_1.replaceAll("\\\\","/");
    //��������ĸ�·�� D:\workspace\CMS\creatorcms\cms
    basePath = config.getServletContext().getRealPath("/");
    basePath = basePath.replaceAll("\\\\","/"); 
    String fileName = "";
    int isbackup = 0;
    //ˮӡͼƬ�Ŀ���������
    //String fontFamily = "";
    //Color Color.red ;
    //String fontSize = "";
	try{		
		//���ļ�
		//SmartUpload up = new SmartUpload();
		//��ʼ���ϴ����
		//up.initialize(pageContext);
		//�����ϴ��ļ���С
		//up.setMaxFileSize(5000*1024);
		//�����ϴ��ļ�����
		//String setExt=sAllowExt.replace('|',',');
		//up.setAllowedFilesList(setExt);
		//up.upload();		
        //request��������
        //com.jspsmart.upload.Request uploadRequest = up.getRequest();
        String backup = request.getParameter("backup");
        String srcimg = request.getParameter("srcimg"); 
        String waterStr = request.getParameter("waterStr"); 
        waterStr = waterStr==null?"":waterStr;
        String waterimage = request.getParameter("waterimage");  
        String position = request.getParameter("position");
        //��ˮӡ ���� ���¼�ˮӡ
        String opt = request.getParameter("opt");
        opt = opt==null?"":opt;
        int p = 0;
        try{
            p = Integer.parseInt(position);
        }catch(Exception ee){
            p = 0;
        }   
        // Select each file
		
		fileName = waterimage;
        //����ˮӡͼƬ�ļ���
        String srcFilename = srcimg.substring(srcimg.lastIndexOf("/"));
        
        //����ˮӡͼƬ·��        
        String srcPath = CMSUtil.getPath(rootPath_1+"/"+srcimg.substring(0,srcimg.lastIndexOf("/")+1), srcFilename);      
        //����ͼƬ�ļ���
        String backupForld = impl.getNORMALIMAGE_FORDER();   
        //����ͼƬ·��       
        String backupPath = CMSUtil.getPath(CMSUtil.getPath(rootPath , backupForld) , srcFilename+".bak");
        //ˮӡͼƬ·��             
        String waterPath = CMSUtil.getPath(CMSUtil.getPath(rootPath , impl.getWATERIMAGE_FORDER() ), waterimage);        
        
        if("readd".equals(opt)){//���¼�ˮӡ
            //��ɾ������ͼƬ   
            impl.deleteFile(srcPath);                     
            /* �ָ� ����ͼƬ */  
            if(!"".equals(backup) && backup != null){//���� �Ϳ���
                impl.copyFile(backupPath,srcPath);
                //impl.ReName(srcPath,".bak");
            }else{//�����ݾ��ƶ�
                //�ƶ�ͼƬ ������
                boolean flag = impl.moveFile(backupPath,srcPath);
            }     
            impl.logWaterImageMsg("�ĵ�����","���¼�ˮӡ",request,response);    
        }else{//�¼�ˮӡ
            /* ����ԭʼͼƬ */
            if(!"".equals(backup) && backup != null){
                java.io.File parentFile = new java.io.File(CMSUtil.getPath(rootPath ,backupForld));
                if(!parentFile.exists()) parentFile.mkdir();
                impl.copyFile(srcPath,backupPath);
                isbackup = 1;
            }            
            /* ��¼�����ݿ� */
            srcPath =  srcPath.toLowerCase();
            
            StringBuffer insert = new StringBuffer()
                .append("insert into TD_CMS_ADDWATERIMAGE(url,isbackup) ")
                .append("(select '").append(srcPath).append("' as url, ")
                .append(isbackup).append(" as isbackup from dual where ")
                .append("not exists (select * from TD_CMS_ADDWATERIMAGE where ")
                .append("url='").append(srcPath).append("' and ")
                .append("isbackup=")
                .append(isbackup).append("))");
            impl.execute(insert.toString()); 
            
        }
        /**
        * ���ɼ�ͼƬˮӡͼƬ
        * @param String img ����ˮӡͼƬ·��
        * @param String watermark ˮӡͼƬ·��
        * @param String waterStr ˮӡ��������
        * @param String fontType ˮӡ������������
        * @param Color fontColor ˮӡ����������ɫ
        * @param int fontSize ˮӡ���������С
        * @param int position ˮӡ����/ͼƬճ��λ��
        * ImageManagerImpl.java
        * @author: �ո�
        */
        impl.genWaterImage(srcPath,waterPath,waterStr,"����",Color.red,23,p);
        impl.logWaterImageMsg("�ĵ�����","���ˮӡ",request,response);
		
%>
<SCRIPT LANGUAGE="JavaScript">
	//���ø����ڵĽ�������
	var fname = "<%=fileName%>";
    window.returnValue='True'
	window.close();
    //parent.UploadLoaded(fname);
</SCRIPT>
<%
	}catch(Exception e)
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("�ϴ��ļ�ʧ�ܣ�");
	window.close();
</SCRIPT>
<%
	e.printStackTrace();
	}
%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.GraphUtils"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page contentType="text/html; charset=utf-8" isErrorPage="true"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String htmldata = StringUtil.deNull(request.getParameter("htmldata"));//html界面数据
	String attachId = StringUtil.deNull(request.getParameter("attachId"));//附件ID
	String title = StringUtil.deNull(request.getParameter("title"));//标题
	title = title.replace("\n","");
	if(title.length()>100){
		title = title.substring(0,100);
	}
	//1,将html文本转成图片文件 
	String tempPath = OASystemCache.getContextProperty("upload_To_SeverPath");
	String imgPath = LoadSpringContext.getApplicationContext().getServletContext().getRealPath("") + tempPath;
	String returnname = GraphUtils.toImages(htmldata, imgPath, 1400, 1000);//"D:\\creatorepp\\ccapp\\Upload\\"
	returnname = returnname.substring(0,returnname.length()-4);
	File lastFile = new File(imgPath + returnname +".jpg");//文件
	FileInputStream ins = null;
	boolean sucess = false;
	JSONObject jsonObj = new JSONObject();
	if(lastFile.exists()){
		try{
			ins = new FileInputStream(lastFile);
			//保存附件信息
			FiletransferService filetransferservice = new FiletransferServiceImpl();
			ArrayList<FileInfoBean> lists = new ArrayList<FileInfoBean>();
			FileInfoBean fileInfoBean = new FileInfoBean();
			fileInfoBean.setExtend(".jpg");
			fileInfoBean.setDjbh(attachId);
			fileInfoBean.setFilename(title+".jpg");
			fileInfoBean.setAttachid(filetransferservice.getAttachId());
			fileInfoBean.setDjsn(StringUtil.getUUID());
			fileInfoBean.setFilepos(imgPath + returnname +".jpg");
			fileInfoBean.setAttachcontent(htmldata.getBytes());
			fileInfoBean.setUpload_mode("1");
			fileInfoBean.setFileInput(ins);
			fileInfoBean.setCreator("formTojpg");//区别其它附件的问题
			lists.add(fileInfoBean);
			sucess = filetransferservice.saveFile(lists);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	jsonObj.put("result",sucess);
	response.getWriter().print(jsonObj);
%>
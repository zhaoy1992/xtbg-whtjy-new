package com.chinacreator.xtbg.pub.jqueryupload.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.FileDownLoadHandler;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.util.DataControlUtil;


public class FileDownloadServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String djsn = DataControlUtil.replaceStr(req.getParameter("djsn"));
		//文件下载名称
	    resp.reset();
	    String onlineEdit = DataControlUtil.replaceStr(req.getParameter("onlineEdit"));//在线编辑(支持word,excel) 
	    String getFileData = DataControlUtil.replaceStr(req.getParameter("getFileData"));//在线编辑(支持word,excel) 
	   
	    String  mFilePath = req.getSession().getServletContext().getRealPath("") ;  //取得服务器路径

		OutputStream output = null;
		FileInputStream fis = null;
		InputStream obis = null;
		FileInfoBean fib = null;
		FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
		File file = null;
		
		
		
		try {
			fib = fsd.getFileByDjsn(djsn);
			boolean iFOnlineEdit = FileDownLoadHandler.ifOnlineEdit(onlineEdit,fib.getExtend());
			if("true".equals(getFileData)){
				resp.getWriter().write("{\"iFOnlineEdit\":\""+iFOnlineEdit+"\"}");
			}else if(iFOnlineEdit){//允许在线编辑 并且 符合指定的类型

				String send_Url = req.getContextPath()+FileDownLoadHandler.getOnlineEditUrl(fib);
				resp.sendRedirect(send_Url);

			}else{
				output = resp.getOutputStream();
				//财政厅项目的附件迁移过来的upload_mode为4，并且附件路径和原来的不一致
				if("4".equals(fib.getUpload_mode())){
					file = new File(FiletransferServiceImpl.upload_To_SeverPath_czt+fib.getFilepos());
				} else {
					file = new File(mFilePath+FiletransferServiceImpl.upload_To_SeverPath+fib.getDjsn()+fib.getExtend());	
				}
				resp.setContentType("application/octet-stream;charset=gb2312");
				String filename = fib.getFilename().replaceAll(";","；").replaceAll("·","`");
				filename = new String(filename.getBytes("GB2312"), "ISO8859-1");
				resp.addHeader("Content-disposition", "attachment; filename="+filename);
				
				if(file.exists()){
					obis = new FileInputStream(file);
				}else{
					obis = (InputStream)fib.getFileInput();
				}
				byte[] b = new byte[1024];
				int i = 0;
				while ((i = obis.read(b)) > 0) {
					output.write(b, 0, i);
				}
			
				output.flush();
				output.close();
			}
			

		} catch (Exception e) {
		    e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
				fis = null;
			}
			if(obis != null) {
				obis.close();
				obis = null;
			}
			if (output != null) {
				output.close();
				output = null;
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}

}

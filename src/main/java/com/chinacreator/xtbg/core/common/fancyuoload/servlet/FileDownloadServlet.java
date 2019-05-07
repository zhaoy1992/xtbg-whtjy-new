package com.chinacreator.xtbg.core.common.fancyuoload.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;


/**
 *<p>Title:FileDownloadServlet.java</p>
 *<p>Description:文件下载 servlet</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-10
 */
public class FileDownloadServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOG = Logger.getLogger(FileDownloadServlet.class);
	
	private final static String onlineEditType = ".xls|.xlsx|.doc|.docx|";//允许在线修改的文档类型
	//TODO 引入iwebOffice后修改路径
	private final static String onlineEditUrl = "/ccapp/oa/resources/plug/iWebOffice2009/iweboffice2009.jsp?RecordID=%DJSN%&fileType=%fileType%&EditType=1,1&ShowType=1&DBType=fc_attach&tittleName=%tittleName%&showBtn=7,8";
	private final static String onlineEditUrlbyupload = "/ccapp/oa/resources/plug/iWebOffice2009/iweboffice2009byupload.jsp?openType=onlinebyupload&RecordID=&fileType=&EditType=1,1&ShowType=1&DBType=fc_attach";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String djsn = replaceAll(req.getParameter("djsn"));//文件唯一编号
		//modify by shuqi.liu 获取文件名称将 fib = fsd.getFileByDjsn(djsn);//从附件数据库表中查询数据 后移，避免每次下载都去查询数据库，如果文件存在，则直接读取文件。
		
		String fileName = replaceAll(req.getParameter("fileName"));//文件名称
		fileName = new String(fileName.getBytes("ISO-8859-1"),"UTF-8");
		String filetype = FileUtils.getFiletype(fileName);//文件类型
		//文件下载名称
	    resp.reset();
	    //String onlineEdit = replaceAll(req.getParameter("onlineEdit"));//在线编辑(支持word,excel) 
	    String getFileData = replaceAll(req.getParameter("getFileData"));//在线编辑(支持word,excel) 
	    String openType = replaceAll(req.getParameter("openType"));//在线编辑(支持word,excel) 
	    String  mFilePath = req.getSession().getServletContext().getRealPath("");  //取得服务器路径
	    
	    String tittleName = replaceAll((req.getParameter("tittleName"))+"");
	    
		OutputStream output = null;
		//FileInputStream fis = null;
		InputStream obis = null;
		FileInfoBean fib = null;
		FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
		File file = null;
		try {
			boolean iFOnlineEdit = ifOnlineEdit(openType,filetype);
			if("true".equals(getFileData)){
				resp.getWriter().write("{\"iFOnlineEdit\":\""+iFOnlineEdit+"\"}");
			}else if(iFOnlineEdit){//允许在线编辑 并且 符合指定的类型
				String send_Url = req.getContextPath()+getOnlineEditUrl(djsn,filetype,tittleName); 
				//req.getRequestDispatcher(send_Url).forward(req, resp);
				resp.sendRedirect(send_Url);
			}else if("onlinebyupload".equalsIgnoreCase(openType)){//编辑上传的word文档
				String send_Url = req.getContextPath()+onlineEditUrlbyupload+"&strfilepath="+StringUtil.deNull(req.getParameter("strfilepath"));
				resp.sendRedirect(send_Url);
			}else{
				if ((".pdf".equals(filetype)) && "online".equals(openType)) {//modify by 2016-03-31,增加pdf在线预览功能
					String send_Url = req.getContextPath() + "/ccapp/oa/archive/viewpdf.jsp?djsn=" + djsn;
					resp.sendRedirect(send_Url);
				} else if((".gif".equals(filetype) || ".jpg".equals(filetype) || ".jpeg".equals(filetype) 
						|| ".png".equals(filetype) || ".bmp".equals(filetype)) && "online".equals(openType)) {
					String send_Url = req.getContextPath() + "/ccapp/oa/archive/viewimg.jsp?djsn=" + djsn;
					resp.sendRedirect(send_Url);
				} else {
					//如果没有配置,或者配置无效,则使用原来的下载处理
					Map<String,Object> configMap = AttachmentConfigBean.getConfigMap();
					if("true".equals(configMap.get("canUpload"))){
						this.doDownLoad(configMap,fsd,req,resp);
						return;
					}
					LOG.info("警告:oa.properties中附件配置找不到或不正确,按照老代码下载");
					output = resp.getOutputStream();
					file = new File(mFilePath+FiletransferServiceImpl.upload_To_SeverPath+djsn+filetype);
					resp.setContentType("application/octet-stream;charset=gb2312");
					String filename = fileName.replaceAll(";","；").replaceAll("·","`");
					filename = new String(filename.getBytes("GB2312"), "ISO8859-1");
					resp.addHeader("Content-disposition", "attachment; filename="+filename);
					if(file.exists()){//磁盘文件存在
						obis = new FileInputStream(file);
					}else{//否则从磁盘读取 
						fib = fsd.getFileByDjsn(djsn);//从附件数据库表中查询数据
						if("4".equals(fib.getUpload_mode())){
							//begin update by shixing.he in 2014-04-09 财政厅历史公文正文附件从磁盘读取
							String tempFilePathString = FiletransferServiceImpl.upload_To_SeverPath_czt+fib.getFilepos();
							file = new File(tempFilePathString);
							//end update by shixing.he in 2014-04-09 财政厅历史公文正文附件从磁盘读取
						} else {
							String  filePath = mFilePath+FiletransferServiceImpl.upload_To_SeverPath ;
							//modif fy by shuqi.liu 每次读取数据库后将文件保存到磁盘。
							List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
							listFileInfoBean.add(fib);
							FiletransferService ft = new FiletransferServiceImpl();
							FileUtils.mkDirectory(filePath);//创建文件夹
							ft.uploadFileToServer(filePath, listFileInfoBean);//将文件保存到磁盘文件中					
						}
						obis = new FileInputStream(file);
						//obis = (InputStream)fib.getFileInput();
						//db connection is close now, can not read to byte
					}
					byte[] b = new byte[1024];
					int i = 0;
					while ((i = obis.read(b)) > 0) {
						output.write(b, 0, i);
					}
					output.flush();
					output.close();
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			/*if (fis != null) {
				fis.close();
				fis = null;
			}*/
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
	
	/**
	 * 允许在线编辑 并且 符合指定的类型
	 * @param onlineEdit
	 * @param fileExtend
	 * @return
	 */
	private boolean ifOnlineEdit(String onlineEdit,String fileExtend){
		return ("online".equals(onlineEdit) && onlineEditType.indexOf(fileExtend.trim()+"|") != -1);
	}
	
	/**
	 * 获取在线编辑路径
	 * @param djsn
	 * @return
	 */
	private String getOnlineEditUrl(String djsn,String fileType,String tittleName){
		String url = onlineEditUrl.replace("%DJSN%", djsn);
		url= url.replace("%fileType%", fileType);
		url= url.replace("%tittleName%", tittleName);
		return url;
	}
	
	/**
	*<b>Summary: </b>
	* replaceAll(字符串转义)
	* @param str
	* @return
	*/
	private String replaceAll(String str) {
		if(str==null) {
			return null;
		}
		str = str.replace("chr(41)", "{'");
		str = str.replace("chr(42)", "'}");
		str = str.replace("chr(43)", "','");
		str = str.replace("chr(44)", "':'");
		str = str.replace("chr(39)", "\\'");
		str = str.replace("chr(38)", "&");
		str = str.replace("chr(60)", "<");
		str = str.replace("chr(62)", ">");
		str = str.replace("chr(37)", "%");
		str = str.replace("chr(50)", "#");
		str = str.replace("chr(40)", "\\\\");
		str = str.replace("chr(64)", "\\\r\\\n");
		return str;
	}	
	/**
	 * 
	 *<b>Summary: </b>
	 * doDownLoad(依据oa.properties文件中的配置attachmentConfig下载)
	 * @param req
	 * @param resp
	 * @throws Exception 
	 */
	private void doDownLoad(Map<String,Object> configMap,
			FiletransfersSysDao fsd,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		String djsn = replaceAll(req.getParameter("djsn"));//文件唯一编号
		FileInfoBean fib = fsd.getFileByDjsn(djsn);//从附件数据库表中查询数据
		if(fib.getDjbh()!=null){
			File file = AttachmentConfigBean.getRealFile(fib.getFilepos());
			InputStream obis = null;
			OutputStream output = null;
			try{
				if(file==null||!file.exists()){
					if(AttachmentConfigBean.UPLOAD_MODE_DB.equals(fib.getUpload_mode())){
						obis = fib.getFileInput();
					}
				}else{
					obis = new FileInputStream(file);
				}
				if(obis!=null){
					resp.setContentType("application/octet-stream;charset=gb2312");
					String filename = fib.getFilename().replaceAll(";","；").replaceAll("·","`");
					filename = new String(filename.getBytes("GB2312"), "ISO8859-1");
					resp.addHeader("Content-disposition", "attachment; filename="+filename);
					output = resp.getOutputStream();
					try{
						byte[] b = new byte[1024];
						int i = 0;
						while ((i = obis.read(b)) > 0) {
							output.write(b, 0, i);
						}
						output.flush();
						output.close();
					}catch(Exception e){
						LOG.info("下载过程出现异常");
					}finally{
						if(obis != null) {
							obis.close();
							obis = null;
						}
						if (output != null) {
							output.close();
							output = null;
						}
					}
				}else{
					LOG.info("找不到文件:[djsn="+djsn+"]");
				}
			}catch(Exception e){
				LOG.info("下载过程出现异常:[djsn="+djsn+"]");
			}finally{
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
	}
}

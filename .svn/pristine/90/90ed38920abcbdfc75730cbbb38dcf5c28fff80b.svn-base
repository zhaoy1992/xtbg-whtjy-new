package com.chinacreator.xtbg.pub.jqueryupload.upload.swf;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.pub.jqueryupload.constant.Constant;
import com.chinacreator.xtbg.pub.jqueryupload.upload.core.DefaultFileRenamePolicy;
import com.chinacreator.xtbg.pub.jqueryupload.upload.core.ISwfUploadServlet;
import com.chinacreator.xtbg.pub.jqueryupload.utils.BlankUtil;
import com.chinacreator.xtbg.pub.jqueryupload.vo.ConstantParameterVo;
import com.oreilly.servlet.MultipartRequest;

@SuppressWarnings("serial")
public class SwfUploadServlet extends HttpServlet implements ISwfUploadServlet {
	
	protected final Log logger =  LogFactory.getLog(getClass());
	
	private ConstantParameterVo parameters = null;
	public void init(ServletConfig config) throws ServletException {
		logger.info("--- init Parameter begin---");
		if(BlankUtil.isBlank(parameters)){
			parameters = new ConstantParameterVo(config);
		}
		logger.info("--- init Parameter end---");
	}

	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("--- BEGIN SwfUpload DOPOST ---");
		request.setCharacterEncoding(parameters.getEncoding());
		response.setCharacterEncoding(parameters.getEncoding());
		logger.info("--- do somthing before upload in doBeforeUpload method begin---");
		doBeforeUpload(request, response);
		logger.info("--- do somthing before upload in doBeforeUpload method end---");
		
		parameters.init(request);
		DefaultFileRenamePolicy rename = generateFileRenamePolicy();
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, parameters.getSaveDirectory(), parameters.getMaxPostSize(),parameters.getEncoding(), rename);
			renderJson(response,Constant.UPLOAD_SUCCESS);
		} catch (IOException e) {
			if(!BlankUtil.isBlank(e.getMessage())){
				int index = e.getMessage().indexOf("Posted content length of");
				if(index>-1){
					renderJson(response,Constant.FILE_OVERSETSIZE);
				}else{
					if(e instanceof IOException){
						renderJson(response,Constant.IO_ERROR);
					}else{
						renderJson(response,Constant.UPLOAD_FAILED);
					}
				}
				logger.error(e.getMessage(),e.getCause());
			}else{
				logger.info("--- upload file upload error ---");
				deleteErrorFile(parameters.getSaveDirectory()+rename.getFileSaveName());
			}
			return;
		}
		// 输出
		Enumeration files = multi.getFileNames();
		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			File f = multi.getFile(name);
			if (f != null) {
				String fileName = multi.getFilesystemName(name);
				String lastFileName = parameters.getSaveDirectory() + File.separatorChar + fileName;
				String fileSavePath = parameters.getUploadDir() + parameters.getAutoCreatedDateDir() + fileName;
				logger.info("file address:" + lastFileName);
				logger.info("save path:" + fileSavePath);
			}
		}
		logger.info("--- do somthing after upload in doAfterUpload method begin---");
		doAfterUpload(multi);
		logger.info("--- do somthing after upload in doAfterUpload method end---");
		logger.info("--- END SwfUpload DOPOST ---");
	}

	private void deleteErrorFile(String errorFilePath) {
		logger.info("errorFilePath:"+errorFilePath);
		logger.info("--- delete error file begin---");
		File file = new File(errorFilePath);
		file.delete();
		logger.info("--- delete error file end---");
	}

	public DefaultFileRenamePolicy generateFileRenamePolicy(){
		return new DefaultFileRenamePolicy();
	}
	
	public void doAfterUpload(MultipartRequest multi) {
	}

	public void doBeforeUpload(HttpServletRequest request,
			HttpServletResponse response) {
	}
	
	public void renderJson(HttpServletResponse response,String msgKey) {
		try {
			response.setContentType("text/x-json;charset=UTF-8");
			response.getWriter().write(msgKey);
			response.flushBuffer();
		} catch (IOException e) {
			logger.error(e.getMessage(),e.getCause());
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	public void destroy() {
		this.parameters = null;
		super.destroy();
	}

}

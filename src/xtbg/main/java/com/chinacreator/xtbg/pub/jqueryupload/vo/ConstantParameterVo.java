package com.chinacreator.xtbg.pub.jqueryupload.vo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.pub.jqueryupload.constant.Constant;
import com.chinacreator.xtbg.pub.jqueryupload.utils.BlankUtil;

public class ConstantParameterVo {
	protected final Log logger =  LogFactory.getLog(getClass());
	public String fileSizeLimit = "100";//以M为单位
	public String fileCountLimit = "10";
	
	public String encoding = "UTF-8";
	public boolean useCustomDir = false;
	public String rootUploadDir = "defaultFiles";
	
	public String ctxDir = null;
	public String uploadDir = null;
	public String autoCreatedDateDir = null;
	public String saveDirectory = null;
	
	 //每个文件最大100M,最多3个,所以总文件大小为(以字节为单位)
	public int maxPostSize = 100*10*1024;
		
	public ConstantParameterVo(String fileSizeLimit, String encoding,
			boolean useCustomDir, String rootUploadDir) {
		super();
		this.fileSizeLimit = fileSizeLimit;
		this.encoding = encoding;
		this.useCustomDir = useCustomDir;
		this.rootUploadDir = rootUploadDir;
	}
	
	public ConstantParameterVo(ServletConfig config) {
		//系统允许的每个文件最大大小,默认100M
		String fileSizeLimitStr = config.getInitParameter(Constant.FILE_SIZE_LIMIT_KEY);
		if(!BlankUtil.isBlank(fileSizeLimitStr)){
			setFileSizeLimit(fileSizeLimitStr);
		}
		
		//系统允许的最大一次性上传文件数量,默认10
		String fileCountLimitStr = config.getInitParameter(Constant.FILE_COUNT_LIMIT_KEY);
		if(!BlankUtil.isBlank(fileCountLimitStr)){
			setFileCountLimit(fileCountLimitStr);
		}
		
		//servlet请求、响应编码格式,默认:UTF-8
		String encodingStr = config.getInitParameter(Constant.ENCODING_KEY);
		if(!BlankUtil.isBlank(encodingStr)){
			setEncoding(encodingStr);
		}
		//servlet请求、响应编码格式,默认:UTF-8
		String useCustomDirStr = config.getInitParameter(Constant.USE_CUSTOMDIR_KEY);
		if(!BlankUtil.isBlank(useCustomDirStr)){
			setUseCustomDir(Boolean.valueOf(useCustomDirStr).booleanValue());
		}
		
		if(isUseCustomDir()){
			//用户自定义的保持路径
			String rootUploadDir = config.getInitParameter(Constant.ROOT_UPLOADDIR_KEY);
			if(!BlankUtil.isBlank(rootUploadDir)){
				setRootUploadDir(rootUploadDir);
			}
		}
	}
	
	public void init(HttpServletRequest request){
	   int fileSize =  Integer.valueOf(getFileSizeLimit()).intValue();
	   int fileLimit =  Integer.valueOf(getFileCountLimit()).intValue();
	   //每个文件最大fileSize M,最多fileLimit个,所以总文件大小为(以字节为单位)
		setMaxPostSize(fileSize * 1024*fileLimit* 1024);
		setUploadDir(getRootUploadDir() + File.separatorChar);
		String autoCreatedDateDirByParttern = "yyyy" + File.separatorChar + "MM" + File.separatorChar + "dd"+ File.separatorChar;
		setAutoCreatedDateDir(DateFormatUtils.format(new java.util.Date(), autoCreatedDateDirByParttern));
		String ctxDirTemp = request.getSession().getServletContext().getRealPath("");
		if (!ctxDirTemp.endsWith(String.valueOf(File.separatorChar))) {
			ctxDirTemp = ctxDirTemp + File.separatorChar;
		}
		setCtxDir(ctxDirTemp);
		if(isUseCustomDir()){
			File savePath = new File(getCtxDir() + getRootUploadDir());
			if (!savePath.exists()) {
				savePath.mkdirs();
			}
			setSaveDirectory(savePath.getAbsolutePath());
		}else{
			File savePath = new File(getCtxDir() + getUploadDir() + getAutoCreatedDateDir());
			if (!savePath.exists()) {
				savePath.mkdirs();
			}
			setSaveDirectory(savePath.getAbsolutePath());
		}
	}

	public ConstantParameterVo(HttpServletRequest request) {
		String ctxDirTemp = request.getSession().getServletContext().getRealPath("");
		if (!ctxDirTemp.endsWith(String.valueOf(File.separatorChar))) {
			ctxDirTemp = ctxDirTemp + File.separatorChar;
		}
		setCtxDir(ctxDirTemp);
		String uploadx_properties = getCtxDir()+"WEB-INF"+File.separatorChar+"uploadx.properties";
		Properties uploadPs =  new Properties();
		try {
			uploadPs.load(new FileInputStream(uploadx_properties));
		} catch (FileNotFoundException e) {
			logger.error("not find Properties file on path :"+uploadx_properties);
			logger.error(e.getMessage(), e.getCause());
		} catch (IOException e) {
			logger.error(e.getMessage(), e.getCause());
		}
		if(uploadPs != null&& !uploadPs.isEmpty()){
			//系统允许的每个文件最大大小,默认100M
			String fileSizeLimitStr = uploadPs.getProperty(Constant.FILE_SIZE_LIMIT_KEY);
			if(!BlankUtil.isBlank(fileSizeLimitStr)){
				setFileSizeLimit(fileSizeLimitStr);
			}
			
			//系统允许的最大一次性上传文件数量,默认10
			String fileCountLimitStr = uploadPs.getProperty(Constant.FILE_COUNT_LIMIT_KEY);
			if(!BlankUtil.isBlank(fileCountLimitStr)){
				setFileCountLimit(fileCountLimitStr);
			}
			
			//servlet请求、响应编码格式,默认:UTF-8
			String encodingStr = uploadPs.getProperty(Constant.ENCODING_KEY);
			if(!BlankUtil.isBlank(encodingStr)){
				setEncoding(encodingStr);
			}
			//servlet请求、响应编码格式,默认:UTF-8
			String useCustomDirStr = uploadPs.getProperty(Constant.USE_CUSTOMDIR_KEY);
			if(!BlankUtil.isBlank(useCustomDirStr)){
				setUseCustomDir(Boolean.valueOf(useCustomDirStr).booleanValue());
			}
			if(isUseCustomDir()){
				//用户自定义的保持路径
				String rootUploadDir = uploadPs.getProperty(Constant.ROOT_UPLOADDIR_KEY);
				if(!BlankUtil.isBlank(rootUploadDir)){
					setRootUploadDir(rootUploadDir);
				}
			}
		}
		init(request);
	}

	public String getFileSizeLimit() {
		return fileSizeLimit;
	}
	public void setFileSizeLimit(String fileSizeLimit) {
		this.fileSizeLimit = fileSizeLimit;
	}
	public String getEncoding() {
		return encoding;
	}
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}
	public boolean isUseCustomDir() {
		return useCustomDir;
	}
	public void setUseCustomDir(boolean useCustomDir) {
		this.useCustomDir = useCustomDir;
	}
	public String getRootUploadDir() {
		return rootUploadDir;
	}
	public void setRootUploadDir(String rootUploadDir) {
		this.rootUploadDir = rootUploadDir;
	}

	public String getCtxDir() {
		return ctxDir;
	}

	public void setCtxDir(String ctxDir) {
		this.ctxDir = ctxDir;
	}

	public String getUploadDir() {
		return uploadDir;
	}

	public void setUploadDir(String uploadDir) {
		this.uploadDir = uploadDir;
	}

	public String getAutoCreatedDateDir() {
		return autoCreatedDateDir;
	}

	public void setAutoCreatedDateDir(String autoCreatedDateDir) {
		this.autoCreatedDateDir = autoCreatedDateDir;
	}

	public String getSaveDirectory() {
		return saveDirectory;
	}

	public void setSaveDirectory(String saveDirectory) {
		this.saveDirectory = saveDirectory;
	}

	public int getMaxPostSize() {
		return maxPostSize;
	}

	public void setMaxPostSize(int maxPostSize) {
		this.maxPostSize = maxPostSize;
	}

	public String getFileCountLimit() {
		return fileCountLimit;
	}

	public void setFileCountLimit(String fileCountLimit) {
		this.fileCountLimit = fileCountLimit;
	}
	
}

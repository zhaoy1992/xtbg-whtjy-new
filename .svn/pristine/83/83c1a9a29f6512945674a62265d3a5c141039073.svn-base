package com.chinacreator.xtbg.core.common.fancyuoload.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.upload.util.UploadConstants;
/**
 * 附件处理的配置类
 * 支持FileUploadSecondServlet和FileDownloadServlet
 * 依赖oa.properties
 *<p>Title:AttachmentConfigBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-4-11
 */
public class AttachmentConfigBean {

	private static final Logger LOG = Logger.getLogger(AttachmentConfigBean.class);
	
	private static AttachmentConfigBean bean;
	private AttachmentConfigBean(){
		init();
	}
	public static AttachmentConfigBean getInstance(){
		if(bean==null){
			bean = new AttachmentConfigBean();
		}
		return bean;
	} 
	
	private static boolean canUsed = false;
	public boolean canUsed(){
		return canUsed;
	}
	private static Map<String,Object> configMap;
	public static Map<String,Object> getConfigMap(){
		if(configMap==null){
			bean = new AttachmentConfigBean();
		}
		return configMap;
	}
	public static final String UPLOAD_MODE_DB_AND_COMPUTER = "0";
	
	public static final String UPLOAD_MODE_DB = "1";

	public static final String UPLOAD_MODE_COMPUTER = "2";
	
	public void init(){
		try{
			String configStr = OASystemCache.getContextProperty("attachmentConfig");
			JSONObject arr = JSONObject.parseObject(configStr);
			configMap = (Map<String, Object>)arr;
			if(configMap==null){
				configMap = new HashMap<String,Object>();
				configMap.put("canUpload", "false");
				canUsed = false;
				LOG.error("初始化上传配置错误:"+"找不到配置信息");
			}else{
				String os = System.getProperty("os.name");
				if(os!= null && os.startsWith("Windows")){
					configMap.put("isWindows", "true");
				}else{
					configMap.put("isWindows", "false");
				}
				if(!UPLOAD_MODE_COMPUTER.equals(configMap.get("uploadMode"))
						&&!UPLOAD_MODE_DB.equals(configMap.get("uploadMode"))
						&&!UPLOAD_MODE_DB_AND_COMPUTER.equals(configMap.get("uploadMode"))){
					throw new Exception("上传模式uploadMode配置错误");
				}
				this.getRealBaseUrl(configMap);
				configMap.put("canUpload", "true");
				canUsed = true;
			}
		}catch(Exception e){
			LOG.error("初始化上传配置错误:"+e.getMessage(),e);
			configMap.put("canUpload", "false");
		}
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getRealBaseUrl(解析BaseUrl)
	 * @param configMap
	 * @throws Exception
	 */
	private void getRealBaseUrl(Map<String,Object> configMap) throws Exception{
		String[] baseUrl= configMap.get("baseUrl").toString().split(",");
		List<String> baseUrlList = new ArrayList<String>();//所有根目录
		List<String> baseUrlListCanUpload = new ArrayList<String>();//支持上传的根目录
		if("true".equals(configMap.get("isWindows"))){
			for (String url : baseUrl) {
				if(Pattern.matches("^[a-zA-Z]:[\\\\|/].*", url)){
					baseUrlList.add(url.replaceAll("//", "\\\\"));
					if(this.checkFreeSpace(url, configMap)){
						if(checkAndCreateUrl(url)){
							baseUrlListCanUpload.add(url.replaceAll("//", "\\\\"));
						}
					}
				}else{
					LOG.error("非法路径:"+url);
				}
			}
		}else{
			for (String url : baseUrl) {
				if(Pattern.matches("^[/].*", url)){
					baseUrlList.add(url);
					if(this.checkFreeSpace(url, configMap)){ //linux环境检查空间是否足够的代码暂无
						if(checkAndCreateUrl(url)){
							baseUrlListCanUpload.add(url);
						}
					}
				}else{
					LOG.error("非法路径:"+url);
				}
			}
		}
		if(baseUrlList.isEmpty()){
			throw new Exception("找不到有效的上传根目录");
		}else{
			configMap.put("baseUrlList",baseUrlList);
			configMap.put("baseUrlListCanUpload",baseUrlListCanUpload);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * checkFreeSpace(检查某路径是否有空闲空间)
	 * @param url
	 * @param configMap
	 * @return
	 */
	private boolean checkFreeSpace(String url,Map<String,Object> configMap){
		if(configMap==null){
			configMap = AttachmentConfigBean.configMap;
		}
		boolean flag = false;
		try{
			String dirName = null;
			if("true".equals(configMap.get("isWindows"))){
				dirName = url.charAt(0) + ":/";
			}else{
				dirName = url;
			}
			File win = new File(dirName);
			if (win.exists()){
				long realFreeSpace = win.getFreeSpace();
				//1
				String minFreeSpace = configMap.get("minFreeSpace").toString();
				if(StringUtil.nullOrBlank(minFreeSpace)){
					minFreeSpace = "10";
				}
				if(realFreeSpace>=Long.parseLong(minFreeSpace)*1024*1024.0){
					flag=true;
				}else{
					LOG.error("磁盘["+dirName+"]的空间为["+(float)realFreeSpace /(1024 * 1024)+"MB],小于配置的最小空间");
				}
				//2
				String warningFreeSpace = configMap.get("warningFreeSpace").toString();
				if(StringUtil.nullOrBlank(warningFreeSpace)){
					warningFreeSpace = "50";
				}
				if(realFreeSpace<Long.parseLong(warningFreeSpace)*1024*1024){
					LOG.error("磁盘["+dirName+"]的空间为["+(float)realFreeSpace /(1024 * 1024)+"MB],小于配置的警戒空间,请修改配置或扩展磁盘");
				}
			}else{
				LOG.error("磁盘["+dirName+"] 去哪儿了!");
			}
		}catch(Exception e){
			LOG.error(e);
		}
		return flag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * checkAndCreateUrl(检查或创建文件夹)
	 * @param url
	 * @return
	 */
	public static boolean checkAndCreateUrl(String url){
		boolean flag = false;
		try{
			File filePath = new File(url);
			if(!filePath.exists()){
				filePath.mkdirs();
				LOG.error("创建目录:"+url);
			}
			flag = true;
		}catch(Exception e){
			LOG.error("创建目录失败:"+e);
		}
		return flag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getMiddelUrl(获得中间路径)
	 * @param request
	 * @return
	 */
	public static String getMiddelUrlStr(HttpServletRequest request){
		if("byDate".equals(configMap.get("MiddleUrlType"))){
			Calendar thisTime = Calendar.getInstance();
			int year = thisTime.get(Calendar.YEAR);
			int month = thisTime.get(Calendar.MONTH)+1;
			int date = thisTime.get(Calendar.DATE);
			return year+File.separator+month+File.separator+date;
		}else if("byRequest".equals(configMap.get("MiddleUrlType"))){
			String MiddleUrl = request.getParameter("MiddleUrlType");
			return MiddleUrl!=null?MiddleUrl:"MiddleUrl";
		}else{
			return "";
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getBaseUrl(从baseUrlListCanUpload中获得get(0)作为上传更目录)
	 * @return
	 */
	public static String getBaseUrl(){
		List<String> baseUrlList = (List<String>)configMap.get("baseUrlListCanUpload");
		if(baseUrlList.size()>0){
			String baseUrl = baseUrlList.get(0);
			if(getInstance().checkFreeSpace(baseUrl, configMap)){
				return baseUrl;
			}else{
				baseUrlList.remove(0);
				configMap.put("baseUrlListCanUpload",baseUrlList);
				return AttachmentConfigBean.getBaseUrl();
			}
		}else{
			configMap.put("canUpload", "false");
			return null;
		}
	}
	
	public static void main(String[] args) throws IOException {
		File a = new File("D:\\1\\2\\3.TXT");
		System.out.println(a.getParent());
		System.out.println(a.getPath());
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileRealFullName()
	 * @param fileName
	 * @return
	 */
	public static File getRealFile(String fileName){
		//如果是绝对路径
		File file = new File(fileName);
		if(file.exists()&&file.isFile()){
			LOG.error("附件定位成功:"+file.getPath());
			return file;
		}
		//如果是相对路径
		if(AttachmentConfigBean.getInstance().canUsed()){
			List<String> baseUrlList = (List<String>)configMap.get("baseUrlList");
			if(baseUrlList!=null&&baseUrlList.size()>0){
				for (String baseUrl : baseUrlList) {
					file = new File(baseUrl + fileName);
					if(file.exists()&&file.isFile()){
						//LOG.error("附件定位成功:"+file.getPath());
						return file;
					}
				}
			}
		}
		LOG.error("附件定位失败:[fileName="+fileName+"]");
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getRealFileForOther(为大附件下载获得文件的真实路径)
	 * @param fileFullName
	 * @return
	 */
	public File getRealFileForDaFuJianXiaZai(String fileFullName,HttpServletRequest request){
		//1:如果是绝对路径
		File file = new File(fileFullName);
		String fileName = file.getName();
		if(file.exists()&&file.isFile()){
			LOG.error("附件定位成功:"+file.getPath());
			return file;
		}
		//2
		String strPath = UploadConstants.UPLOADSAVEPATH;
		
		String realPath1 = request.getSession().getServletContext().getRealPath("/");
		String realPath2 = request.getSession().getServletContext().getRealPath("");
		String oldRootPath= realPath1.replaceAll("\\\\", "/") + strPath;//支持download.jsp webLogic下
		String oldRootPath1= realPath2.replaceAll("\\\\", "/") + strPath;//支持download.jsp tomcat下
	
		fileFullName = fileFullName.replaceAll("\\\\", "/");//为了支持 delete.jsp删除页面
		String xiangDuiPath = fileFullName.replaceAll(oldRootPath, "").replaceAll(oldRootPath1, "");
		
		List<String> baseUrlList = (List<String>)getConfigMap().get("baseUrlList");
		if(baseUrlList!=null&&baseUrlList.size()>0){
			for (String baseUrl : baseUrlList) {
				file = new File(baseUrl + xiangDuiPath.replaceAll("/", "\\\\"));
				if(file.exists()&&file.isFile()){
					//LOG.error("附件定位成功:"+file.getPath());
					return file;
				}
			}
		}
		//3
		String RealFileName= DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("RealFileName")));
		fileFullName =fileFullName.replace(fileName,RealFileName);// path是指欲下载的文件的路径。
		file = new File(fileFullName);
		if(file.exists()&&file.isFile()){
			LOG.error("附件定位成功:"+file.getPath());
			return file;
		}
		LOG.error("附件定位失败:[fileName="+fileName+",oldRootPath="+oldRootPath+"]");
		return null;
	}
}

package com.chinacreator.xtbg.core.common.util;


import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * 
 * 支持WordUtil的配置对象
 *<p>Title:WordToPDFConf.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-10-15
 */
public class WordToPDFConf{
	
	private static final Log LOG = LogFactory.getLog(WordToPDFConf.class);
	/**
	 * 过程:openoffice服务开启后的对象
	 */
	Process openOfficPro;
	
	/**
	 * 是否已经开启
	 */
	private boolean opened;
	
	
	public boolean isOpened() {
		return opened;
	}

	public void setOpened(boolean opened) {
		this.opened = opened;
	}

	/**
	 * 
	 *<b>Summary: </b>
	 * startOpenOfficeServer
	 * 启动openofficeServer服务
	 */
	@PostConstruct
	public void startOpenOfficeServer(){
		if(this.isHandOpen()){//如果已经手动启动了,这里就不需要启动了
			this.setIsOpen(true);
		}else{
			if(this.getIsOpen()){
				String order = "program\\soffice.exe -headless -accept=\"socket,host=127.0.0.1,port="+this.getOpenOfficePort()+";urp;\"";
				String command = this.getOpenOfficeHome()+order;
				try {
					openOfficPro = Runtime.getRuntime().exec(command);
					LOG.error("openOffice服务开启");
					this.setOpened(true);
				} catch (Exception e){
					LOG.error("警告:openOffice开启失败,如果安装了openOffice,调整 bean-wordtopdf.xml中配置[OpenOfficeHome],没安装就设置[isOpen=false]",e);
					this.setOpened(false);
				}catch (Error e) {
					LOG.error("警告:openOffice开启失败,如果安装了openOffice,调整 bean-wordtopdf.xml中配置[OpenOfficeHome],没安装就设置[isOpen=false]",e);
					this.setOpened(false);
				}
			}
		}
		
	}

	/**
	 * 
	 *<b>Summary: </b>
	 * reStartOpenOffice(重启)
	 */
	public void reStartOpenOffice(){
		if(this.getIsOpen()){
			LOG.error("定时重启 openOffice");
			this.closeOpenOfficeServer();
			this.startOpenOfficeServer();
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * closeOpenOfficeServer(关闭openofficeServer服务)
	 */
	@PreDestroy
	public void closeOpenOfficeServer(){
		if(this.getIsOpen()){
			if(this.openOfficPro!=null){
				openOfficPro.destroy();
			}
		}
	}
	
	/**
	 * 是否已经手动启动
	 */
	private boolean handOpen;
	/**
	 * openoffice安装位置
	 */
	private String openOfficeHome;
	/**
	 * 被开启的openoffice软件服务的端口号
	 */
	private int openOfficePort;
	/**
	 * 转pdf之前存放word文件的目录
	 */
	private String wordFileUrl;
	/**
	 * 转pdf之后存放pdf文件的目录
	 */
	private String pdfFileUrl;
	/**
	 * wordtopdf功能的开关
	 */
	private boolean isOpen;
	/**
	 * 清理痕迹后,给予jacob释放word资源的时间
	 */
	private int afterDeleteHJCleanResTime = 3000;

	
	
	
	

	public boolean isHandOpen() {
		return handOpen;
	}

	public void setHandOpen(boolean handOpen) {
		this.handOpen = handOpen;
	}

	public int getAfterDeleteHJCleanResTime() {
		return afterDeleteHJCleanResTime;
	}

	public void setAfterDeleteHJCleanResTime(int afterDeleteHJCleanResTime) {
		this.afterDeleteHJCleanResTime = afterDeleteHJCleanResTime;
	}

	public String getOpenOfficeHome() {
		return openOfficeHome;
	}

	public void setOpenOfficeHome(String openOfficeHome) {
		this.openOfficeHome = openOfficeHome;
	}

	public int getOpenOfficePort() {
		return openOfficePort;
	}

	public void setOpenOfficePort(int openOfficePort) {
		this.openOfficePort = openOfficePort;
	}

	public String getWordFileUrl() {
		return wordFileUrl;
	}

	public void setWordFileUrl(String wordFileUrl) {
		this.wordFileUrl = wordFileUrl;
	}

	public String getPdfFileUrl() {
		return pdfFileUrl;
	}

	public void setPdfFileUrl(String pdfFileUrl) {
		this.pdfFileUrl = pdfFileUrl;
	}

	private boolean getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(boolean isOpen) {
		this.isOpen = isOpen;
	}
	
	
	
}

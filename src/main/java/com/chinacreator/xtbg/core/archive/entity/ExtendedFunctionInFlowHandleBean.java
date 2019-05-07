package com.chinacreator.xtbg.core.archive.entity;
/**
 * 支持在流程中扩展的功能处理Bean
 * 作用:
 * 1:将专用的JS脚本 或 HTML 脚本注入 Tag 对象中(如 :WordArchiveWebTextTag标签)
 * 2:方便统一管理流程页面中的隶属统一功能的 脚本
 * @author tuo.zou
 * 
 */
public abstract class ExtendedFunctionInFlowHandleBean {
	/**
	 * 为处理扩展的功能生成的JS脚本(JS脚本文件)
	 * @return
	 */
	public abstract String createJsCode();
	/**
	 * 为处理扩展的功能生成的HTML脚本
	 * @return
	 */
	public abstract String createHTMLCode(String ...strs);
	
	public abstract String getURLString();
	/**
	 * 在form版flow页面写入java脚本
	 */
	public abstract String getJavaString();
}

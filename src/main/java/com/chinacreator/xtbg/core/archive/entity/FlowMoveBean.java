package com.chinacreator.xtbg.core.archive.entity;

import javax.servlet.http.HttpServletRequest;


import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 收文转发文时,迁移数据处理Bean
 * 
 * @author tuo.zou
 *
 */
public class FlowMoveBean extends ExtendedFunctionInFlowHandleBean{
	/**
	 * 参数名:判断是否是开启新流程
	 */
	public static final String ARG_isStartAdd = "isStartAdd";
	/**
	 * 参数名:标题
	 */
	public static final String ARG_flowTitle = "flowTitle";
	/**
	 * 参数名:附件
	 */
	public static final String ARG_oldAttachId = "oldAttachId";
	
	/**
	 * 参数名:正文
	 */
	public static final String ARG_textIdZW = "textIdZW";
	
	private HttpServletRequest request;
	
	public FlowMoveBean(HttpServletRequest request){
		this.request = request;
	}
	public FlowMoveBean(){
	}
	/**
	 * 收文转发文相关的参数名 集合 
	 * 在js 和 html 中需要
	 */
	private static final String[] args = new String[]{
		"isStartAdd",//是否发起流程
		"flowTitle",//老流程标题
		"textIdYW",//老流程的 原文
		"textIdZW",//老流程的 正文
		"textIdMQ",//老流程的 面签
		"textIdZBD",//老流程的 转办单
		"docNo",//老流程的 文号
		"oldInsId",//老流程的 ID
		"oldAttachId",
		"fmb_config"
	};//老流程的 附件
	
	/**
	 * 支持收文转发文:在 WordArchiveWebTextTag 中生成 js对象 
	 * 支持wordiweboffice.js
	 * 放在wordiweboffice.js之前,才能让newFlowFnBody(fn) 和 initFlowInFlow(fn) 生效
	 * fun newFlowFnBody：发起新流程
	 * fun initFlowInFlow：初始化新流程页面
	 * 
	 * 以后可扩展为java 生成动态js文件,动态js函数
	 * @return
	 */
	public String createJsCode(){
		StringBuffer js = new StringBuffer("<script type='text/javascript'>");
		js.append("var _fmb = {");
		for (int i = 0; i < args.length; i++) {
			if(i!=0){
				js.append(",'"+args[i]+"':'"+args[i]+"'");
			}else{
				js.append("'"+args[i]+"':'"+args[i]+"'");
			}
		}
		js.append("};");
		if(this.isFlowInFlow()){
			js.append("var afterActionSuccessFn = function (){try{getParentWindow('newwindows').afterActionSuccessFn();}catch(e){alert('closeWindowAfterFlowInFlow error');}}");
		}
		js.append("</script>");
		return js.toString();
	}
	
	/**
	 * 支持收文转发文: 在 WordArchiveWebTextTag 中生成 HTML 
	 * 支持wordform.jsp的
	 * fun newFlowFnBody 发起新流程
	 * fun initFlowInFlow 初始化新流程页面
	 * @return
	 */
	public String createHTMLCode(String ... strArray){
		StringBuffer html = new StringBuffer();
		for (int i = 0; i < args.length; i++) {
			String arg = args[i];
			// set value of htmlObj
			String value = StringUtil.deNull(request.getParameter(arg));
			if(arg.equals("fmb_config")){
				String configs = OASystemCache.getContextProperty("wordiwebofficeJS_doFlowInFlow_config");
				value = (StringUtil.nullOrBlank(configs))?"1,1,1":configs;
			}
			// create htmlObj
			html.append("<input name='"+arg+"' id='"+arg+"' type='hidden' value='"+ value +"'/>");
		}
		
		return html.toString();
	}
	
	/**
	 * 支持newflowmain.jsp
	 * 如果是收文转发文而弹出该窗口就在url后面加入个性化参数
	 * @return
	 */
	public String getURLString(){
		boolean isNormalFlow = !this.isFlowInFlow();
		if(!isNormalFlow){
			StringBuffer url = new StringBuffer();
			for (int i = 0; i < args.length; i++) {
				String arg = args[i];
				url.append("&")
				.append(arg).append("=").append(StringUtil.deNull(request.getParameter(arg)));
			}
			return url.toString();
		}
		return "";
	}
	/**
	 * 判断是否是流程中启动流程
	 * @return
	 */
	public boolean isFlowInFlow(){
		String isStartAdd = StringUtil.deNull(request.getParameter(ARG_isStartAdd));
		if("Y".equals(isStartAdd)){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 特殊情况:支持表单版流程初始化page所需的 
	 * 
	 * word版 的代码 写在 sendtoarchivedo.jsp中
	 * @return
	 */
	public String getJavaString(){
		StringBuffer javaCode = new StringBuffer();
		javaCode.append("FlowMoveBean fmb = new FlowMoveBean(request);\r\n");
		javaCode.append("//正文通过JS搞定\r\n");
		javaCode.append("if(fmb.isFlowInFlow()){\r\n");
		javaCode.append("String fmb_config = \""+OASystemCache.getContextProperty("wordiwebofficeJS_doFlowInFlow_config")+"\";\r\n");
		javaCode.append("fmb_config = (StringUtil.nullOrBlank(fmb_config))?\"1,1,1\":fmb_config;\r\n");
		javaCode.append("String[] fmb_config_arr = fmb_config.split(\",\");\r\n");
		javaCode.append("if(fmb_config_arr[1].equals(\"1\")){\r\n");
		javaCode.append(" drag_in_title = request.getParameter(\"flowTitle\");\r\n");
		javaCode.append("}\r\n");
		javaCode.append("if(fmb_config_arr[2].equals(\"1\")){\r\n");
		javaCode.append(" drag_in_attach = StringUtil.getUUID();\r\n");
		javaCode.append(" WordArchiveService service = new WordArchiveServiceImpl();\r\n");
		javaCode.append(" String mFilePath = request.getSession().getServletContext().getRealPath(\"\")+FiletransferServiceImpl.upload_To_SeverPath;\r\n");
		javaCode.append(" Map<String,String> argMap = new HashMap<String,String>();\r\n");
		javaCode.append(" argMap.put(\"flowTitle\", request.getParameter(\"flowTitle\"));\r\n");
		javaCode.append(" argMap.put(\"textIdYW\", null);\r\n");
		javaCode.append(" argMap.put(\"textIdMQ\", null);\r\n");
		javaCode.append(" argMap.put(\"textIdZBD\", null);\r\n");
		javaCode.append(" argMap.put(\"attachId\", drag_in_attach);\r\n");
		javaCode.append(" argMap.put(\"oldAttachId\", request.getParameter(\"oldAttachId\"));\r\n");
		javaCode.append(" argMap.put(\"mFilePath\", mFilePath);\r\n");
		javaCode.append(" argMap.put(\"userId\", accesscontroler.getUserID());\r\n");
		javaCode.append(" Map<String,String> messMap = service.copyAttachForNewFlow(argMap); \r\n");
		javaCode.append("}\r\n");
		javaCode.append("}\r\n");
		return javaCode.toString();
	}
}

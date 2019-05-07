package com.chinacreator.xtbg.core.archive.entity;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;

/**
 * 公文登记(来文登记)
 * 描述:在流程发起时,通过配置将要走流程的公文数据 自动加载到 页面
 * 目前只支持 存放在 公文登记表[OA_GWRECEIVE]的数据
 * 
 * @author tuo.zou
 *
 */
public class OfficialDocumentRegisterHandleBean extends ExtendedFunctionInFlowHandleBean{
	
	private static final Log LOG = LogFactory.getLog(OfficialDocumentRegisterHandleBean.class);
	/**
	 * 需要登记的公文的ID
	 */
	public static final String OFF_DOC_REG_ID = "offDocRegId";
	/**
	 * OA_WORD_TEXTINPUT.TEMPLATE_ID(word中输入文本数据表.模板ID)
	 */
	private String templateId;
	private String offDocRegId;
	private HttpServletRequest request;
	/**
	 * 是否输出JS
	 */
	private boolean isWriteCode;
	
	public OfficialDocumentRegisterHandleBean(HttpServletRequest request,boolean isWriteCode){
		this.request = request;
		this.isWriteCode = isWriteCode;
		this.offDocRegId = request.getParameter(OFF_DOC_REG_ID);
		this.templateId = request.getParameter("template_id");//有模板就word版，无模板就是form版
		if(offDocRegId==null){
			isWriteCode = false;
		}else{
			LOG.info("公文登记:启动公文登记");
		}
	}
	public OfficialDocumentRegisterHandleBean(){}

	@Override
	public String createJsCode() {
		if(!isWriteCode){
			return "";
		}
		//获得位置与值的映射
		try {
			AccessControl ac = AccessControl.getAccessControl();
			ac.checkAccess(request.getSession());
			String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
			String userId = ac.getUserID();
			WordArchiveService service = new WordArchiveServiceImpl();
			
			StringBuffer js = new StringBuffer();
			if(templateId!=null){//有模板就是word版本,没模板靠FormServiceImpl.java在页面插入java脚本
				Object[] o = service.getOfficialDocumentRegisterMess(offDocRegId, templateId, mFilePath, userId);
				Map<String,String> map = (Map<String,String>)o[0];
				js = new StringBuffer("<script type='text/javascript'>");
				js.append("var _offDocRegId="+JSONObject.toJSONString(map)+";");
				js.append("jQuery(function(){" +
							"for(var i in _offDocRegId){" +
							"selectTextInput(i,_offDocRegId[i]);" +
							"}");
				
				if(o[1]!=null){
					Map<String,String> mapFJ = (Map<String,String>)o[1];
					String key = mapFJ.keySet().iterator().next();
					js.append("jQuery('#"+key+"').val('"+mapFJ.get(key)+"');");
				}
				js.append("});</script>");
			}
			
			if(this.isGWDJ()){
				js.append("<script type='text/javascript'>");
				js.append("var afterActionSuccessFn = function (){try{getParentWindow('newwindows').afterActionSuccessFn();}catch(e){alert('closeWindowAfterFlowInFlow error');}}");
				js.append("</script>");
			}
			return js.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	@Override
	public String createHTMLCode(String... strs) {
		if(!isWriteCode){
			return "";
		}
		StringBuffer html = new StringBuffer();
		html.append("<input name='"+OFF_DOC_REG_ID+"' id='"+OFF_DOC_REG_ID+"' type='hidden' value='"+ offDocRegId +"' />");
		return html.toString();
	}
	/**
	 * 支持newflowmain.jsp
	 * 如果是收文登记而弹出该窗口就在url后面加入个性化参数
	  * <b>Summary: </b>
	  *     复写方法 getURLString
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.entity.ExtendedFunctionInFlowHandleBean#getURLString()
	 */
	@Override
	public String getURLString() {
		boolean isGWDJ = this.isGWDJ();
		if(isGWDJ){
			String gwdj = this.request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);
			StringBuffer url = new StringBuffer();
			url.append("&")
			.append(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID).append("=").append(gwdj);
			return url.toString();
		}
		return "";
	}
	/**
	 * 
	*<b>Summary: </b>
	* isGWDJ(如果是公文登记就返回true)
	* @return
	 */
	public boolean isGWDJ() {
		String gwdj = this.request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);
		if(gwdj!=null&&gwdj.length()>0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 为表单版流程page 添加java脚本
	 * accesscontroler,drag_in_title,drag_in_attach变量见 FormserviceImpl.addJavaCodeForPage()
	 * 类的引用见archiveform.vm
	 */
	@Override
	public String getJavaString() {
		StringBuffer javaCode = new StringBuffer();
		javaCode.append("OfficialDocumentRegisterHandleBean ofr = new OfficialDocumentRegisterHandleBean(request,true);							\r\n");	
		javaCode.append("if(ofr.isGWDJ()){                                                                                               \r\n");
		javaCode.append("	String gwdj = request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);                             \r\n");
		javaCode.append("	String mFilePath = request.getSession().getServletContext().getRealPath(\"\")+FiletransferServiceImpl.upload_To_SeverPath;\r\n");
		javaCode.append("	String userId = accesscontroler.getUserID();                                                                            \r\n");
		javaCode.append("	WordArchiveService service = new WordArchiveServiceImpl();                                                              \r\n");
		javaCode.append("	Object mess[] = service.getOfficialDocumentRegisterMess(gwdj, null, mFilePath, userId);                                 \r\n");
		javaCode.append("	if(mess!=null&&mess.length>0){                                                                                                      \r\n");
		javaCode.append("		Map<String,String> map = (Map<String,String>)mess[0];                                                                 \r\n");
		javaCode.append("		drag_in_title = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_TITLE));                                            \r\n");
		javaCode.append("		drag_in_attach = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_ATTACH));                                          \r\n");
		javaCode.append("	}                                                                                                                       \r\n");
		javaCode.append("}                                                                                                                        \r\n");
		return javaCode.toString();
	}
	
	
}

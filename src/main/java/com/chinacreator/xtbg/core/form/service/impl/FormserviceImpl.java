package com.chinacreator.xtbg.core.form.service.impl;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.io.StringWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.entity.FlowMoveBean;
import com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.form.dao.FormDao;
import com.chinacreator.xtbg.core.form.entity.OaFormConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaFormTagConfigBean;
import com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean;
import com.chinacreator.xtbg.core.form.entity.OaMdTableBean;
import com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean;
import com.chinacreator.xtbg.core.form.service.Formservice;
import com.frameworkset.util.VelocityUtil;

/**
 * 
 *<p>Title:FormserviceImpl.java</p>
 *<p>Description:表单定义serviceimpl</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-22
 */
public class FormserviceImpl implements Formservice {
	private static final Logger log = Logger.getLogger(FormserviceImpl.class);
	public final static String form_To_SeverPath = File.separator + "ccapp"+File.separator+"oa"+File.separator+"archive"+File.separator;//TODO 配置文件设置服务器路径//CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath");
	public final static String DRAG_IN_TITLE = "drag_in_title"; 
	public final static String DRAG_IN_ATTACH = "drag_in_attach"; 
	public final static String DRAG_IN_WEBTEXT = "drag_in_webtext"; 
	public final static String DRAG_IN_WEBTEXT_DB = "<%=drag_in_webtext%>"; 
	public final static String DRAG_IN_TITLE_PG = "{drag_in_title}"; 
	public final static String DRAG_IN_ATTACH_PG = "{drag_in_attach}";
	public final static String DRAG_IN_TITLE_DB = "<%=drag_in_title%>"; 
	public final static String DRAG_IN_ATTACH_DB = "<%=drag_in_attach%>"; 
	public final static String DRAG_IN_NUMBER_PG = "{drag_in_number}"; 
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTableList
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#getTableList()
	 */
	@Override
	public List<OaMdTableBean> getTableList() {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		 List<OaMdTableBean> oaMdTableBeanList = new ArrayList<OaMdTableBean>();
		try {
			oaMdTableBeanList = dao.getTableList();
		} catch (Exception e) {
			log.error("查询表列表出现异常", e);
		}
		return oaMdTableBeanList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getCloumn
	  * @param table_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#getCloumn(java.lang.String)
	 */
	@Override
	public List<OaMdColumnsBean> getCloumn(String table_id,String type) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		List<OaMdColumnsBean> oaMdColumnsBeanList = new ArrayList<OaMdColumnsBean>();
		if(StringUtil.isBlank(type)){
			try {
				oaMdColumnsBeanList = dao.getCloumn(table_id);
			} catch (Exception e) {
				log.error("查询表列表出现异常", e);
			}
			return oaMdColumnsBeanList;
		}else{
			try {
				oaMdColumnsBeanList = dao.getCloumnDataFromSystemTable(table_id);
			} catch (Exception e) {
				log.error("查询表列表出现异常", e);
			}
			return oaMdColumnsBeanList;
		}
		
		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveTagConfig
	  * @param request
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#saveTagConfig(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public boolean saveTagConfig(String paramJson,HttpServletRequest request) {
		boolean flag = false;
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormTagConfigBean oaFormTagConfigBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				 oaFormTagConfigBean = JSONObject.parseObject(paramJson, OaFormTagConfigBean.class);
			}
			String tagHtml = request.getParameter("tag_html");
			if("input".equals(oaFormTagConfigBean.getTag_type_id())
					||"afix".equals(oaFormTagConfigBean.getTag_type_id())){
					if(!StringUtil.isBlank(oaFormTagConfigBean.getDefault_value())){
						tagHtml = repalceDefaultValue(tagHtml,oaFormTagConfigBean.getDefault_value(),request);
					}
					if(!StringUtil.isBlank(oaFormTagConfigBean.getDrag_in_value())){
						tagHtml = repalceDefaultValue(tagHtml,oaFormTagConfigBean.getDrag_in_value(),request);
					}
				}
			if(!StringUtil.isBlank(tagHtml)){
				oaFormTagConfigBean.setTag_html(tagHtml);
			}
			if(oaFormTagConfigBean != null){
					flag = dao.saveTagConfig(oaFormTagConfigBean,null);
			}	
		} catch (Exception e) {
			log.error("保存表单配置信息出现异常", e);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateTagConfig
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#updateTagConfig(java.lang.String)
	 */
	@Override
	public boolean updateTagConfig(String paramJson,HttpServletRequest request) {
		boolean flag = false;
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormTagConfigBean oaFormTagConfigBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				 oaFormTagConfigBean = JSONObject.parseObject(paramJson, OaFormTagConfigBean.class);
			}
			String tagHtml = request.getParameter("tag_html");
			if("input".equals(oaFormTagConfigBean.getTag_type_id())
				||"afix".equals(oaFormTagConfigBean.getTag_type_id())){
				if(!StringUtil.isBlank(oaFormTagConfigBean.getDefault_value())){
					tagHtml = repalceDefaultValue(tagHtml,oaFormTagConfigBean.getDefault_value(),request);
				}
				if(!StringUtil.isBlank(oaFormTagConfigBean.getDrag_in_value())){
					tagHtml = repalceDefaultValue(tagHtml,oaFormTagConfigBean.getDrag_in_value(),request);
				}
			}
			
			if(!StringUtil.isBlank(tagHtml)){
				oaFormTagConfigBean.setTag_html(tagHtml);
			}
			if(oaFormTagConfigBean != null){
					flag = dao.updateTagConfig(oaFormTagConfigBean,null);
			}	
		} catch (Exception e) {
			log.error("更新表单配置信息出现异常", e);
		}
		return flag;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* repalceDefaultValue(替换默认值)
	* @param tagHtml
	* @param default_value
	* @return
	 */
	private String repalceDefaultValue(String tagHtml, String default_value,HttpServletRequest request) {
		if("{user_id}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_id}","<%=user_id%>");
		}else if("{user_name}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_name}","<%=user_name%>");
		}else if("{org_id}".equals(default_value)){
			tagHtml = tagHtml.replace("{org_id}","<%=org_id%>");
		}else if("{org_name}".equals(default_value)){
			tagHtml = tagHtml.replace("{org_name}","<%=org_name%>");
		}else if("{unit_id}".equals(default_value)){
			tagHtml = tagHtml.replace("{unit_id}","<%=unit_id%>");
		}else if("{unit_name}".equals(default_value)){
			tagHtml = tagHtml.replace("{unit_name}","<%=unit_name%>");
		}else if("{time}".equals(default_value)){
			tagHtml = tagHtml.replace("{time}","<%=time%>");
		}else if("{date}".equals(default_value)){
			tagHtml = tagHtml.replace("{date}","<%=date%>");
		}else if("{user_name + time}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_name + time}","<%=user_name + \"  \"+time%>");
		}else if("{user_name + date}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_name + date}","<%=user_name+ \"  \"+date%>");
		}else if(DRAG_IN_TITLE_PG.equals(default_value)){
			tagHtml = tagHtml.replace(DRAG_IN_TITLE_PG,DRAG_IN_TITLE_DB);
		}else if(DRAG_IN_ATTACH_PG.equals(default_value)){
			tagHtml = tagHtml.replace(DRAG_IN_ATTACH_PG,DRAG_IN_ATTACH_DB);
		}else if("{user_worktel}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_worktel}","<%=user_worktel%>");
		}else if("{user_mobiletel1}".equals(default_value)){
			tagHtml = tagHtml.replace("{user_mobiletel1}","<%=user_mobiletel1%>");
		}else{
			tagHtml = new PageInitHandlerBean().getHTMLString(tagHtml, request);
		}
		tagHtml = tagHtml.trim();
		return tagHtml;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delTagConfig
	  * @param tag_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#delTagConfig(java.lang.String)
	 */
	@Override
	public boolean delTagConfig(String tag_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		boolean flag = false;
		try {
			flag = dao.delTagConfig(tag_id, null);
		} catch (Exception e) {
			log.error("删除元素配置信息出现异常", e);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryTagConfigInfo
	  * @param tag_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#queryTagConfigInfo(java.lang.String)
	 */
	@Override
	public OaFormTagConfigBean queryTagConfigInfo(String tag_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormTagConfigBean oaFormTagConfigBean = new OaFormTagConfigBean();
		try {
			oaFormTagConfigBean = dao.queryTagConfigInfo(tag_id,null);
		} catch (Exception e) {
			log.error("查询表列表出现异常", e);
		}
		return oaFormTagConfigBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 formAdd
	  * @param request
	  * @param response
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#formAdd(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public Map<String, Object> formAdd(HttpServletRequest request,HttpServletResponse response) {
			FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
			String form_id = request.getParameter("form_id");
			String htmlStr = StringUtil.deNull(request.getParameter("paramJson"));
			String confightmls = request.getParameter("confightmls");
			String is_text = request.getParameter("is_text_select");
			String txt_table_id = "";
			String txt_column_id = "";
			StringBuffer hideString = new StringBuffer();//隐藏域
			Map<String, Object> map = new  HashMap<String, Object>();
			Connection conn = null;
					
			try{
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				conn = DbManager.getInstance().getTransactionConnection();
				log.info(confightmls);
				//定义保存到数据库
				dao.saveFormHtml(confightmls.trim(),form_id,conn);
				//更新是否正文
				OaFormConfigBean bean = new OaFormConfigBean();
				bean.setForm_id(form_id);
				bean.setIs_text(is_text);
				bean.setFrom_ext_parm(request.getParameter("from_ext_parm"));
				dao.updateIsText(bean, conn);
				
				OaFormConfigBean oaFormConfigBean = dao.getFormConfig(form_id,conn);
				//替换生成OA标签
				List<OaFormTagConfigBean> oaFormTagConfigBeanList = dao.getTagConfig(form_id,conn);
				for(int i=0; i<oaFormTagConfigBeanList.size();i++){
					htmlStr = htmlStr.replace("oa_"+oaFormTagConfigBeanList.get(i).getTag_id(), oaFormTagConfigBeanList.get(i).getTag_html());
					if("hide".equals(oaFormTagConfigBeanList.get(i).getTag_type_id())){//如果是隐藏标签 生成隐藏域
						StringBuffer hideStr =new StringBuffer();
						hideStr.append("<oa:input type='hidden' column='").append(oaFormTagConfigBeanList.get(i).getColumn_id())
								  .append("' table='").append(oaFormTagConfigBeanList.get(i).getTable_id())
								  .append("' value='").append(oaFormTagConfigBeanList.get(i).getDefault_value()).append("' />");
						String hideString1 = hideStr.toString();
						if(!StringUtil.isBlank(hideString1.toString())){
							 hideString1 = repalceDefaultValue(hideStr.toString(),oaFormTagConfigBeanList.get(i).getDefault_value(),request).toString();
						}
						hideString.append(hideString1);
					}
				}
				//获取正文配置
				if("Y".equals(is_text)){
					for(int i=0; i<oaFormTagConfigBeanList.size();i++){
						if("txt".equals(oaFormTagConfigBeanList.get(i).getTag_type_id())){
							txt_table_id = oaFormTagConfigBeanList.get(i).getTable_id();
							txt_column_id = oaFormTagConfigBeanList.get(i).getColumn_id();
							break;
						}
					}
				}
				//System.out.println(htmlStr);
				// 获取模板引擎
				VelocityEngine ve = new VelocityEngine();
				// 模板文件所在的路径
				String path = "D:/workspace";
				// 设置参数
				ve.setProperty(Velocity.FILE_RESOURCE_LOADER_PATH, path);
				// 处理中文问题
				ve.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
				ve.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
				ve.setProperty(Velocity.ENCODING_DEFAULT, "UTF-8");
				// 初始化模板
				ve.init();
				// 获取模板(hello.html)
				// Velocity模板的名称
				Template template = VelocityUtil.getTemplate("form/archiveform.vm");
	
				// 获取上下文
				VelocityContext root = new VelocityContext();
	
				// 把数据填入上下文
				root.put("form_name", oaFormConfigBean.getForm_name()); // 表单名称
				root.put("form_jsp_name", oaFormConfigBean.getForm_jsp_name()); // 表单JSP名称
				root.put("form_background", oaFormConfigBean.getForm_background()); // 表单底色
				root.put("form_width", oaFormConfigBean.getForm_width().trim()+"px"); // 表单宽度
				root.put("tag_width", oaFormConfigBean.getTag_width()); // 元素宽度
				root.put("tag_height", oaFormConfigBean.getTag_height()); // 元素高度
				root.put("tag_margins", oaFormConfigBean.getTag_margins()); // 元素间隔PX
				root.put("tag_margins2", (int)(Float.parseFloat(oaFormConfigBean.getTag_margins())*2)+"px"); // 元素间隔PX.
				root.put("is_text", "Y".equals(is_text)); // 是否有正文
				root.put("txt_table_id", txt_table_id); // 正文TABLE_ID
				root.put("txt_column_id", txt_column_id); //正文COLUMN_ID
				root.put("txt_table_column_id", txt_table_id+"__"+txt_column_id); //正文COLUMN_ID
				root.put("hideString",hideString.toString());//加入隐藏域
				root.put("htmlstr",htmlStr);
				addImportClassCode(root);
				addJavaCodeForPage(root,request);
				addJavaScriptCodeForPage(root,oaFormConfigBean);
				// 输出路径
				//取得服务器路径  文件保存的路径
				String appPath = form_To_SeverPath+oaFormConfigBean.getForm_jsp_name()+".jsp";
				String  outpath = request.getSession().getServletContext().getRealPath("")+appPath;
				
				 StringWriter writer = new StringWriter();         
				 template.merge(root,writer);      
		         FileOutputStream fos = new FileOutputStream(new File(outpath));
		         PrintStream ps = new PrintStream(fos, true, "UTF-8");//这里我们就可以设置编码了
		         ps.print(writer.toString());
		         ps.flush();
		         ps.close();
		         fos.close();   
		         map.put("flag", true);
				 map.put("filePath", outpath);
				//保存到oa_flow_form表单配置表
				dao.saveOrUpdateFlowForm(appPath.replace("\\", "/"),oaFormConfigBean.getForm_name(),conn);
				
				DbManager.closeTransactionConnection(conn, true);
			}catch (Exception e){	
				// 关闭连接并回滚事务
				DbManager.closeTransactionConnection(conn, false);
				map.put("flag", false);
				map.put("erroInfo", e.getMessage());
				log.error("生成文件出现异常", e);
			}
			return map;
		}
	
	
	private void addImportClassCode(VelocityContext root) {
		StringBuffer code = new StringBuffer();
		code.append("<%@page import=\"com.chinacreator.security.AccessControl\"%>											  \r\n"); 
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.cache.UserCache\"%>                                   \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean\"%>                        \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.util.*\"%>                                            \r\n");
		code.append("<%@page import=\"java.util.Map\"%>                                                                       \r\n");
		code.append("<%@page import=\"java.util.HashMap\"%>                                                                   \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl\"%>  \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.archive.service.WordArchiveService\"%>                       \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl\"%>              \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.archive.entity.FlowMoveBean\"%>                              \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean\"%>        \r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl\"%>        \r\n");
		root.put("importClassCode",code);
	}
	/**
	 * 为jsp页面生成 构建java代码
	 * @param root
	 */
	private void addJavaCodeForPage(VelocityContext root,HttpServletRequest request) {
		StringBuffer javaCode = new StringBuffer();
		javaCode.append("AccessControl accesscontroler = AccessControl.getInstance();\r\n");                           
		javaCode.append("accesscontroler.checkAccess(request, response);\r\n");   
		javaCode.append("String windowsId = request.getParameter(\"windowsId\");\r\n"); 
		/**
		javaCode.append("String user_id = accesscontroler.getUserID();//用户id\r\n");   
		javaCode.append("String user_name = accesscontroler.getUserName();//用户名\r\n");   
		javaCode.append("String time = DateUtil.getCurrentDateTime();//当前时间\r\n");   
		javaCode.append("String date = DateUtil.getCurrentDate();//当日期\r\n");   
		javaCode.append("UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息\r\n");   
		javaCode.append("String org_id = userBean.getOrg_id();//所属部门id\r\n");   
		javaCode.append("String org_name = userBean.getOrg_name();//所属部门名\r\n");   
		javaCode.append("String unit_id = userBean.getUnit_id();    //所属单位id\r\n");   
		javaCode.append("String unit_name =  userBean.getUnit_name();//所属单位名\r\n");
		javaCode.append("String user_worktel = userBean.getUser_worktel(); //工作电话\r\n");
		javaCode.append("String user_mobiletel1 = userBean.getUser_mobiletel1(); //手机号码\r\n");
		**/
		javaCode.append("String drag_in_title = \"\";\r\n");
		javaCode.append("String drag_in_attach = \"\";\r\n");
		javaCode.append("String drag_in_webtext = \"\";\r\n");
		
		javaCode.append(new FlowMoveBean().getJavaString());
		javaCode.append(new OfficialDocumentRegisterHandleBean().getJavaString());
		
		
		javaCode.append(new PageInitHandlerBean().getJavaString(request));
		root.put("webtext_defautValue",DRAG_IN_WEBTEXT_DB);
		root.put("javaCode", javaCode.toString());
	}

	
	private void addJavaScriptCodeForPage(VelocityContext root,Object... o) {
		StringBuffer javaScriptCode = new StringBuffer();
		javaScriptCode.append("jQuery(function(){ //DOM Ready\r\n");
		javaScriptCode.append("	initGridster();\r\n");
		//TODO ZHELI JIADAIMA
		javaScriptCode.append("});\r\n");
		
		
		javaScriptCode.append("//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。\r\n");
		javaScriptCode.append("function resetSubmit(){\r\n");
		javaScriptCode.append("	jQuery(\"#form1\").resetSubmit(false);\r\n");
		javaScriptCode.append("}\r\n");
		javaScriptCode.append("\r\n");
		
		
		OaFormConfigBean bean = (OaFormConfigBean)o[0];
		javaScriptCode.append("function initGridster(){\r\n");
		javaScriptCode.append("	jQuery(\".gridster ul\").gridster({\r\n");
		javaScriptCode.append("			widget_margins: ["+bean.getTag_margins()+", "+bean.getTag_margins()+"],//元素间隔\r\n");
		javaScriptCode.append("			widget_base_dimensions: ["+bean.getTag_width()+","+bean.getTag_height()+"],//初始化宽度 \r\n");
		javaScriptCode.append("			avoid_overlapped_widgets: true,  //不可以重叠\r\n");
		javaScriptCode.append("			max_size_y: 35,				//最多可以添加行数\r\n");
		javaScriptCode.append("			max_size_x: 35,				//最多可以添加列数\r\n");
		javaScriptCode.append("			max_cols: 35\r\n");
		javaScriptCode.append("			//collision:{on_overlap_stop: function(collider_data){ }}\r\n");
		javaScriptCode.append("	  });\r\n");
		javaScriptCode.append("   jQuery(\".gridster ul li\").each(function(){//将LI设置为不可拖拽\r\n");
		javaScriptCode.append("	   jQuery(\".gridster ul\").gridster().data('gridster').disable(jQuery(this));\r\n");
		javaScriptCode.append("   });\r\n");
		javaScriptCode.append("   }\r\n");
		
		javaScriptCode.append("function initPageObj(){\r\n");
		javaScriptCode.append("	jQuery(\"#\"+jQuery(\"#field_drag_in_title\").val()).focus();\r\n");
		javaScriptCode.append("   }\r\n");
		root.put("javaScriptCode", javaScriptCode.toString());
		
		javaScriptCode = new StringBuffer();
		javaScriptCode.append("jQuery(function(){ //DOM Ready\r\n");
		javaScriptCode.append("	initPageObj();\r\n");
		//TODO ZHELI JIADAIMA
		javaScriptCode.append("});\r\n");
		root.put("javaScriptCode2", javaScriptCode.toString());
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveFormConfig
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#saveFormConfig(java.lang.String)
	 */
	@Override
	public boolean saveFormConfig(String paramJson) {
		boolean flag = false;
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormConfigBean oaFormConfigBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				oaFormConfigBean = StringUtil.convertStringToBean(paramJson, OaFormConfigBean.class);
			}
			
			if(oaFormConfigBean != null){
					flag = dao.saveFormConfig(oaFormConfigBean,null);
			}	
		} catch (Exception e) {
			log.error("保存表单配置信息出现异常", e);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateFormConfig
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#updateFormConfig(java.lang.String)
	 */
	@Override
	public boolean updateFormConfig(String paramJson) {
		boolean flag = false;
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormConfigBean oaFormConfigBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				oaFormConfigBean = StringUtil.convertStringToBean(paramJson, OaFormConfigBean.class);
			}
			
			if(oaFormConfigBean != null){
					flag = dao.updateFormConfig(oaFormConfigBean,null);
			}	
		} catch (Exception e) {
			log.error("更新表单配置信息出现异常", e);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delFormConfig
	  * @param form_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#delFormConfig(java.lang.String)
	 */
	@Override
	public boolean delFormConfig(String form_ids) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		// 数据库连接
		Connection conn = null;
		boolean flag = true;
		try {
				conn = DbManager.getInstance().getTransactionConnection();
				// 删除TAG信息
				flag = flag&dao.delTagByformList(form_ids, conn);
				//删除FORM 信息
				flag = flag&dao.delFormConfig(form_ids, conn);
				
			// 关闭连接并提交事务
			DbManager.closeTransactionConnection(conn, true);
			return flag;

		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.closeTransactionConnection(conn, false);
			log.error(e.getMessage(), e);
			return flag;
		}
	
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFormHtml
	  * @param form_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#getFormHtml(java.lang.String)
	 */
	@Override
	public String getFormHtml(String form_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		String configHtml = "";
		try {
			 configHtml = dao.getFormHtml(form_id,null);
		} catch (Exception e) {
			log.error("查询该表单配置HTML出现异常", e);
		}
		return configHtml;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryFormConfigInfo
	  * @param form_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#queryFormConfigInfo(java.lang.String)
	 */
	@Override
	public OaFormConfigBean queryFormConfigInfo(String form_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		OaFormConfigBean aFormConfigBean = new OaFormConfigBean();
		try {
			aFormConfigBean = dao.getFormConfig(form_id,null);
		} catch (Exception e) {
			log.error("查询表单配置信息出现异常", e);
		}
		return aFormConfigBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getIsText
	  * @param form_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#getIsText(java.lang.String)
	 */
	@Override
	public String getIsText(String form_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		String is_text = "";
		try {
			is_text = dao.getIsText(form_id,null);
		} catch (Exception e) {
			log.error("查询该表单配置HTML出现异常", e);
		}
		return is_text;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveOrUpdateHide
	  * @param paramJson
	  * @param request
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#saveOrUpdateHide(java.lang.String, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public boolean saveOrUpdateHideTag(String paramJson, HttpServletRequest request) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		String form_id = request.getParameter("form_id");
		List<OaFormTagConfigBean> oaFormTagConfigBeanList = new ArrayList<OaFormTagConfigBean>();
		boolean flag = true;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			oaFormTagConfigBeanList = (List<OaFormTagConfigBean>) JSONObject.parseArray(paramJson, OaFormTagConfigBean.class);
			flag = flag&dao.delTagByType(form_id, "hide", conn);//删除
			flag = flag&dao.saveOrUpdateHideTag(oaFormTagConfigBeanList,conn);//保存
			// 关闭连接并提交事务
			DbManager.closeTransactionConnection(conn, true);
		} catch (Exception e) {
			// 关闭连接并回滚事务
			DbManager.closeTransactionConnection(conn, false);
			log.error("保存隐藏域出现异常", e);
			return false;
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getHideTagConfig
	  * @param form_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.form.service.Formservice#getHideTagConfig(java.lang.String)
	 */
	@Override
	public List<OaFormTagConfigBean> getHideTagConfig(String form_id) {
		FormDao dao = (FormDao) LoadSpringContext.getApplicationContext().getBean("FormDaoImpl");
		List<OaFormTagConfigBean> hideTagList = null;
		try {
			hideTagList = new ArrayList<OaFormTagConfigBean>();
			hideTagList = dao.getTagConfigByType(form_id, "hide", null);
		} catch (Exception e) {
			log.error("获取隐藏域出现异常", e);
			return null;
		}
		return hideTagList;
	}
}
